Date: Thu, 22 Jun 2000 14:47:14 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
To: Dan Malek <dan@netx4.com>
cc: "Mark S. Mathews" <mark@absoval.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Can't mmap the top 1MB of /dev/mem?
In-Reply-To: <39525027.A7343F66@embeddededge.com>
Message-ID: <Pine.LNX.4.21.0006221435370.3102-100000@sunapee.transcept.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello, Dan!

> That should work, I do this quite regularly.  What actually fails,
> the mmap() or your access to the mapped region?

mmap fails with EINVAL.

> There is what I do:
>
> 	mem_addr = (u_char *)mmap(NULL, FLASH_MEM_SIZE,
> 			(PROT_READ | PROT_WRITE), MAP_SHARED,
> 			mem_fd, FLASH_MEM_ADDR);

I know that program. FLASH_MEM_SIZE is a small number used only in the
first mmap() to determine the size of the flash. If you make it so big
that (int)(FLASH_MEM_ADDR+FLASH_MEM_SIZE)==0 then mmap() fails.

The test program below works on LinuxPPC (2.2.14 with tweaks for G3) but
fails on RPX/Lite (MontaVista kernel):

mmap at 0xffc00000, size 0x400000 failed: Invalid argument

Regards,
Pavel Roskin

=================================
#include <sys/types.h>
#include <sys/mman.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#define FLASH_MEM_ADDR	((uint)0xffc00000)
#define FLASH_MEM_SIZE	((uint)0x00400000)
int
main(void)
{
	int	mem_fd, i;
	uint	mfg, dev;
	void* mem_addr = NULL;

	if ((mem_fd = open("/dev/mem", O_RDWR)) < 0) {
		perror("cannot open /dev/mem");
		exit(1);
	}

	mem_addr = (u_int *)mmap(NULL, FLASH_MEM_SIZE,
				(PROT_READ | PROT_WRITE), MAP_SHARED,
				mem_fd, FLASH_MEM_ADDR);

	if ((int)mem_addr < 0) {
		fprintf(stderr, "mmap at 0x%x, size 0x%x failed: %s\n",
			FLASH_MEM_ADDR, FLASH_MEM_SIZE, strerror(errno));
		exit(1);
	}
}
=================================


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
