From: kd@flaga.is
Subject: pthreads, glibc2.1.2 problems
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF8A4A80C6.CC06AB0A-ON00256839.0055E479@flaga.is>
Date: Tue, 30 Nov 1999 16:07:51 +0000
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Could someone verify for me that pthread_create() does not block
indefinitly on their embedded system setup (or even pmac would be great
too).
My setup is glibc 2.1.2 with fpu and cache patch applied , kernel 2.2.5 and
gcc 2.95.2.
The following short program, compiled with gcc -static pthreads.c -o
pthreads -pthreads
blocks at pthread_create() for no apparent reason (when run on ppc823). The
same program compiled on i386
(same glibc, kernel 2.2.1 and same gcc and same compile flags) runs fine.

Thank you

K.D.

####program begins#####

#include <stdio.h>
#include <pthread.h>
#include <errno.h>

#define assert(X) if(!(X)){printf("assertion failed in %s at line %d\n",
__FILE__, __LINE__);}

void* funcA(void* arg)
{
     int i;
     int* times = (int*)arg;

     for(i = 0; i < *times; i++)
     {
          sleep(1);
          printf("threadA : %d\n", i);
     }
}

int main(int argc, char** argv)
{
     int res;
     int argA;
     int statusA;
     pthread_t threadA;

     argA=10;
     printf("Create thread A\n");
     res = pthread_create(&threadA, NULL, funcA, (void*)&argA);
     assert(res==0);

     printf("Joining thread A\n");
     pthread_join(threadA, NULL);
}
####program ends######


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
