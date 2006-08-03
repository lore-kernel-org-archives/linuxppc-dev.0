Return-Path: <dale@farnsworth.org>
Date: 3 Aug 2006 13:53:00 -0000
Message-ID: <20060803135300.24837.qmail@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
To: jean-baptiste.maneyrol@teamlog.com, Linuxppc-embedded@ozlabs.org
Subject: Re: IBM OCP GPIO driver for linux 2.6
In-Reply-To: <1154603751.17247.10.camel@jb-portable>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In article <1154603751.17247.10.camel@jb-portable> you write:
> I'm porting a custom PPC 405GP card based on a Walnut from Montavista
> Linux 3.0 (kernel 2.4.18) to linux 2.6, and I was wondering if there is
> a port of the IBM OCP GPIO driver (a char driver providing
> device /dev/gpio, major 10 minor 185). The driver was written by Armin
> Kuster, and it doesn't exist in the stock kernel 2.6.17.7.
> 
> Let me known if a port exists, or if there is a new way of accessing the
> PPC 405GP GPIO under linux 2.6.

The recommended way of accessing GPIO registers is to mmap them
and manipulate them directly in user space.

Below, I've included a quick hack that blinks a LED on a Walnut-like
board.

-Dale

#include <stdint.h>
#include <stdio.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/stat.h>
#include <fcntl.h>

#define GPIO_PAGE_ADDR	0xef600000

#define OUTPUT_REG	0x0700
#define TRISTATE_REG	0x0704
#define OPENDRAIN_REG	0x0718
#define INPUT_REG	0x071c

#define MEDIA_LED_BIT	0x20000000

#define reg_addr(p, o)	((uint32_t *)((void *)p + o))

int main(int argc, char *argv[])
{
	int i;
	uint32_t *p;
	char *filename = "/dev/mem";
	void *addr	= 0;
	size_t length	= 4096;
	int prot	= PROT_READ | PROT_WRITE;
	int flags	= MAP_SHARED;
	int fd		= open(filename, O_RDWR);
	off_t offset	= (off_t)GPIO_PAGE_ADDR;

	if (fd < 0) {
		perror("open");
		return 1;
	}

	p = mmap(addr, length, prot, flags, fd, offset);
	if (p == MAP_FAILED) {
		perror("mmap");
		return 4;
	}

	/* drive led output */
	*reg_addr(p, TRISTATE_REG) |= MEDIA_LED_BIT;

	/* blink media led 10 times */
	for (i = 0; i < 10; i++) {
		/* turn media led on */
		*reg_addr(p, OUTPUT_REG) &= ~MEDIA_LED_BIT;
		sleep(1);
		/* turn media led off */
		*reg_addr(p, OUTPUT_REG) |= MEDIA_LED_BIT;
		sleep(1);
	}

	return 0;
}
