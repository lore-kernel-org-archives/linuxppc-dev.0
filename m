Date: Mon, 2 Oct 2000 10:51:17 -0400 (EDT)
From: "TWG - pat, mark & steve" <twg@world.std.com>
To: Jari <jari.nguyen@smartstors.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Memory map?
In-Reply-To: <39D59806.9AE0F189@serialsystem.com.sg>
Message-ID: <Pine.SGI.3.95.1001002104232.17412D-100000@world.std.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jari,
I take it you're trying to do this from an application (i.e. not within
the kernel).  Here is a (hack) piece of code which performs a similar
task.  I use it to access a dual-port RAM connecting me to another
processor.  First, it needs access to the (860T)'s internal memory map, to
set up the chip selects so that CS5 decodes at 0x50000000.  Then it gets a
pointer I can use to access the memory.  You probably only need to do the
last mmap (and the fopen of /dev/mem!), since (presumably) there are
already chip selects decoding your ROM.  (additional comments after the
code)

#include <stdio.h>
#include <asm/io.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#include <unistd.h>
#include <sys/mman.h>
#include <errno.h>

char *MapDpRam(void)
{
  int *paddr1;
  char *paddr2;
  int fd;
  // figure out the page size (since we can only mmap in pagesize
increments)
  size_t size = getpagesize();
  // get an FD to /dev/mem
  fd = open("/dev/mem",O_RDWR);
  // these 3 lines change the internal chip-selects in the 860T
  paddr1 = mmap(0,size,PROT_READ|PROT_WRITE,MAP_SHARED,fd,0xfa200000);
  *(paddr1+0x4b) = 0xffff8d84;
  *(paddr1+0x4a) = 0x50007401;
  // done messing with chip-selects, unmap them
  munmap(paddr1,size);
  // this one does the real work, gives me a pointer which, when accessed,
points to the memory at physical address 50000000
  paddr2 = mmap(0,size,PROT_READ|PROT_WRITE,MAP_SHARED,fd,0x50000000);
  return(paddr2);
}

Notes: It's a bit sloppy, I assume that getpagesize() returns at least 1K
(which is all I need).  If you need more space, you will have to set
"size" to some multiple of pagesize that's big enough.  It also assumes it
knows where the MCR points to (0xfa200000) rather than reading it directly
(I'm too lazy to figure out how to do that! :)
Hope it helps...

Mark Phillips


On Sat, 30 Sep 2000, Jari wrote:

>
> Hello,
>
> After booting kernel, I want to access the physical address in rom ,
> for example:
> my rom begins at 0xFE00 0000, and I want to read 1 byte at this address.
>
> currently, the MMU has been turned on, the RAM begin at 0x0C00 0000,
> and I don't know what the address of the ROM is.
>
> what do I have to do?
> is there anybody know how to take the address of the ROM?
>
> Help me, pls.
> Thank you,
> Jari
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
