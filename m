Date: Mon, 25 Feb 2002 12:27:52 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200202252027.g1PKRqt01988@xdr.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux 2.4.17 bug, mmap of /dev/mem
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In the meantime I managed to make some minimal changes to 2.4.14 to
get it partially up on our box. The modified files are
Makefile
  Setting arch: to ppc, and setting up CROSS_COMPILE

arch/ppc/8260_io/uart.c
arch/ppc/8260_io/fcc_enet.c
  Slight changes to reflect our port assignments

fs/proc/proc_misc.c
include/asm-ppc/est8260.h
  These work together to pass some information from ppcboot to linux,
  so I can configure networking and whatnot.

Basically I'm making no major changes to the linux kernel, and the problem
is still there. I am trying to get 2.4.8 working but it looks like things
have moved around quite a bit, so I'm not sure how successful I'll be...

So: 2.4.2_hhl20 doesn't have the problem
2.4.8 = still trying to get it up on our box
2.4.14 has the problem
2.4.17 has the problem

Here is the current program to demonstrate the problem:

#include <stdio.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#define ADDR 0xf0010000
#define SIZE 0x00002000

main()
{
void *where;
int fd;
int t;
volatile unsigned long *base;
int i;

	fd=open("/dev/mem",O_RDWR);
	if(fd<0) {printf("Failed to open\n");return;}

	for(i=0;i<500;++i)
	{
		int status;
		if(fork()) {wait(&status);continue;}

		where=mmap(0,SIZE,PROT_READ|PROT_WRITE,MAP_SHARED,fd,ADDR);
		if(where==(void *)0xffffffff)
		{
			close(fd);
			printf("mmap failed\n");
			return -1;
		}

		base=(void *)where;

		t=base[0];
		base[0]=t;
		printf("%4d,%x\n",i,t);
		munmap(where,SIZE);
		exit(0);
	}
	close(fd);
	printf("done---mt\n");
}
---cut---
The above program fails at about iteration 228 on linux 2.4.17. On 2.4.14
it fails at an unpredictable iteration, from maybe 180 to 350. The number
of other seemingly harmless shell comands executed, like "ls", before running
the above program has an effect, meaning the above program will fail sooner
the more times a program has been executed by the shell.

In the case of 2.4.17, if I power up the box, wait until login prompt, login
as root, then run the above program, it very reliably fails at iteration
228. If I do 5 'ls' commands before, then it fails at iteration 223. Strange,
huh?

BTW the mmap is mapping the IMM area at 0xf0xxxxxx, but since the program
does a read then write back of the same value nothing should be affected.
The register I'm setting is the SIUMCR on the 8260.

Thanks--
Dave

>You are asking in the right place, but some of us that should be looking
>at it are swamped on other projects at the moment.  I've been using
>mmap() without trouble to do similar things, and when I get a moment
>I'll peruse your messages in the archives.
>
>Thanks.
>
>        -- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
