Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <408E8346.9070202@gcctech.com>
Date: Tue, 27 Apr 2004 11:59:02 -0400
From: "Christopher R. Johnson" <cjohnson@gcctech.com>
Reply-To: cjohnson@gcctech.com
MIME-Version: 1.0
To: Sergey Urvanov <abs@dts.ru>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ioperm
References: <466383553.20040427132502@dts.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've seen that also - if I remember correctly, it was an issue with the
toolchain.  I don't use eldk however, I roll my own.  Check your include
paths and the linker.  Also, in my environment its #include <sys/io.h>
for ioperm stuff.

Sergey Urvanov wrote:

>Hi
>Anybody seen this error?
>I'm getting it while trying to compile  for a ppc405EP based board,
>using the ELDK 2.1 toolchain (ppc_4xx).
>
>I have a problem with next test code:
>
>#include <stdlib.h>
>#include <stdio.h>
>#include <unistd.h>
>#include <errno.h>
>#include <asm/io.h>
>
>#define BASEPORT 0x378
>
>
>int main (int   argc,
>          char  *argv[])
>{
>        int kz=0;
>        if (ioperm(BASEPORT, 3, 1))
>         {
>                perror ("ioperm");
>                exit (1);
>         }
>        outb(0, BASEPORT);
>        printf ("status 1 %d\n", kz);
>        usleep (100000);
>        kz=inb(BASEPORT+1);
>        printf ("status 2 %d\n", kz);
>        if (ioperm(BASEPORT, 3, 0))
>         {
>                perror ("ioperm");
>                exit (1);
>         }
>        printf ("Stop \n");
>        return 0;
>}
>
>
>I try to make:
>
>/opt/eldk/usr/ppc-linux/bin/gcc -c -O2 test.c
>/opt/eldk/usr/ppc-linux/bin/gcc -o test test.o
>
>And in the answer:
>
>test.o: In function `main':
>test.o(.text+0x2c): undefined reference to `ioperm'
>test.o(.text+0x2c): relocation truncated to fit: R_PPC_REL24 ioperm
>test.o(.text+0x54): undefined reference to `outb'
>test.o(.text+0x54): relocation truncated to fit: R_PPC_REL24 outb
>test.o(.text+0x78): undefined reference to `inb'
>test.o(.text+0x78): relocation truncated to fit: R_PPC_REL24 inb
>test.o(.text+0x98): undefined reference to `ioperm'
>test.o(.text+0x98): relocation truncated to fit: R_PPC_REL24 ioperm
>collect2: ld returned 1 exit status
>
>Any help would be appreciated.
>
>Thanx and regards
>Sergey Urvanov
>
>
>

--
Christopher R. Johnson
Principal Software Engineer
GCC Printers
(781)276-8763


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
