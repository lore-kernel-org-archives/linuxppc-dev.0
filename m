Message-ID: <017401c291fe$67190990$e600a8c0@udtech.net>
From: "Shen Rong" <rshen@udtech.com.cn>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: linuxppc_2_4_devel stability problem?
Date: Fri, 22 Nov 2002 16:08:55 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
   I have ported the latest linuxppc_2_4_devel from bk://ppc.bkbits.net
to my mpc755(with mpc8250 as slave). I test a simple program, which
does malloc&free variable length memory forever. I always get SIGSEGV
shortly(less than 10 minutes) after I run the program. I have the problem with
linuxppc-2.4.16 before, and I think it may be solved in the latest version, but
it doesn't.

  My mpc755 works under 400Mhz, with 64M SDRAM. Though the totoal
memory I malloced is large than 64M sometime, since I don't use it but
only remember the address the malloc returns, and free it with the address later.
It will always failed when to free some a remembered address.

  I think linux won't alloc the real page until a reference to the memory occurs,
with which a page fault will leads to a real page mapped. So where is the SIGSEGV
from.  I am also not sure whether the libc is compatible with this version of linux or
not. Anyway, I'd rather believe it's  the kernel problem.

  Does anybody have some ideas on it? Or, maybe you are interested in my test
program, why not try! Here it is.

BTW, I have wrote another program, it will crash the 2.4.16, and if you are interested
too, I can mail to you for free:).

Thanks
Shenrong



#include <stdio.h>
#include <stdlib.h>
#include <signal.h>


#define M_TIME 10240

int i, j, k = 0;
int size;
char *p[M_TIME];

char block[10240];

int ii, jj = 0;
struct sigaction sSEGVAction;

void SEGVHandler (int iSignal)
{
     jj = 0;
     printf("\nsig err: dump: \n\n");
     printf("i=%d, j=%d, k=%d, p[i]=0x%08x\n", i, j, k, p[i]);

#if 0
     for(ii=0; ii<M_TIME; ii++) {
       if(jj == 0)
          printf("%04d ", ii);

       printf(" %08x", p[ii]);
       jj++;
       if(jj == 10) {
          printf("\n");
          jj = 0;
       }
     }
#endif

    exit(-1);
}


int main(int argc, char **argv)
{
    sSEGVAction.sa_handler = SEGVHandler;
    sSEGVAction.sa_flags   = SA_RESTART;
    sigemptyset ( &sSEGVAction.sa_mask );
    sigaction ( SIGSEGV, &sSEGVAction, NULL );

    while(1) {
    k++;
    printf("%d round start\n\n", k);

    for(j=1; j<10; j++) {
        size = 0;

        for(i=0; i<M_TIME; i++) {
           p[i] = malloc(i * j);
           if(!p[i]) {
               printf("malloc failed at %d\n", i);
               return -1;
           }
           size += i * j;
#if 0
           if(i * j > 0)
    {
               int len = i * j;
               char *ptr = p[i];
        int n;

               memset(ptr, 0xaa, len);

               for(n=0; n<len; n++) {
                  if(ptr[n] != 0xaa) {
                      printf("memory write check error: i=%d, j=%d, k=%d, p[i]=0x%08x, n=%d, err=%d\n", i, j, k, p[i], n, ptr[n]);
                      exit(-1);
                  }
               }
           }
#endif
        }

        printf("loop %d: malloc %d bytes totally succeed...", j, size);

        for(i=0; i<M_TIME; i++)
           free(p[i]);

        printf("freed\n");
    }
    }
    return 0;
}

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
