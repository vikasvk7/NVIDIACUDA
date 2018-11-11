#include <stdio.h>
//Compiler version gcc 6.3.0


__global__ void sum(int *a, int *b, int *c) 
{ 
	*c = *a + *b; 
    } 
int main(void) 
{ 
	int a, b, c; // host copies of a, b, c 
    int *d_a, *d_b, *d_c; // device copies of a, b, c
    int size = sizeof(int); 
    // Allocate space for device copies of a, b, c 
    cudaMalloc((void **)&d_a, size); 
    cudaMalloc((void **)&d_b, size);
    cudaMalloc((void **)&d_c, size); 
    //Input values
    a = 10; b = 20; 
   
 
// Copy inputs to device
cudaMemcpy(d_a, &a, size, cudaMemcpyHostToDevice); 
cudaMemcpy(d_b, &b, size, cudaMemcpyHostToDevice); 
//Launching add() kernel on GPU
sum<<<1,1>>>(d_a, d_b, d_c); 
// Copy result back to host
cudaMemcpy(&c, d_c, size, cudaMemcpyDeviceToHost); // Cleanup 
cudaFree(d_a); 
cudaFree(d_b);
cudaFree(d_c);
printf("%d",c); 
return 0; 
        
}

