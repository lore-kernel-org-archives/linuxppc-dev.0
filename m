Date: Tue, 27 Apr 2004 13:25:02 +0400
From: Sergey Urvanov <abs@dts.ru>
Reply-To: Sergey Urvanov <abs@dts.ru>
Message-ID: <466383553.20040427132502@dts.ru>
To: linuxppc-embedded@lists.linuxppc.org
Subject: ioperm
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi
Anybody seen this error?
I'm getting it while trying to compile  for a ppc405EP based board,
using the ELDK 2.1 toolchain (ppc_4xx).

I have a problem with next test code:

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <errno.h>
#include <asm/io.h>

#define BASEPORT 0x378


int main (int   argc,
          char  *argv[])
{
        int kz=0;
        if (ioperm(BASEPORT, 3, 1))
         {
                perror ("ioperm");
                exit (1);
         }
        outb(0, BASEPORT);
        printf ("status 1 %d\n", kz);
        usleep (100000);
        kz=inb(BASEPORT+1);
        printf ("status 2 %d\n", kz);
        if (ioperm(BASEPORT, 3, 0))
         {
                perror ("ioperm");
                exit (1);
         }
        printf ("Stop \n");
        return 0;
}


I try to make:

/opt/eldk/usr/ppc-linux/bin/gcc -c -O2 test.c
/opt/eldk/usr/ppc-linux/bin/gcc -o test test.o

And in the answer:

test.o: In function `main':
test.o(.text+0x2c): undefined reference to `ioperm'
test.o(.text+0x2c): relocation truncated to fit: R_PPC_REL24 ioperm
test.o(.text+0x54): undefined reference to `outb'
test.o(.text+0x54): relocation truncated to fit: R_PPC_REL24 outb
test.o(.text+0x78): undefined reference to `inb'
test.o(.text+0x78): relocation truncated to fit: R_PPC_REL24 inb
test.o(.text+0x98): undefined reference to `ioperm'
test.o(.text+0x98): relocation truncated to fit: R_PPC_REL24 ioperm
collect2: ld returned 1 exit status

Any help would be appreciated.

Thanx and regards
Sergey Urvanov


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
