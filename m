From: Frank Smith <smith@amirix.com>
To: "Mark S. Mathews" <mark@absoval.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Can't mmap the top 1MB of /dev/mem?
In-Reply-To: <Pine.LNX.3.96.1000622130831.10550A-100000@tristar.cc.absoval.com>
Message-Id: <00Jun22.151432adt.7305@dragon.appliedmicro.ns.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Date: Thu, 22 Jun 2000 15:14:31 -0300
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 22 Jun 2000, Mark S. Mathews wrote:

>
> Hi Dan (and all),
>
> I've been playing w/ mmap for flash and nvram access on the rpxlite(MV
> derived kernel). One thing I've noticed is that it won't let me mmap the
> top 1MB of the address space.  I'm guessing that the region isn't
> represented in the MMU stuff or this is a deliberate block in the /dev/mem
> driver.
>
> I've done a little digging on my own and haven't found the cause.  Can
> anyone point me to the right file/function(s)?

include/asm/processor.h: -------------------------------------------------

...
#define TASK_SIZE    (0x80000000UL)
...

mm/mmap.c: ---------------------------------------------------------------

...
unsigned long do_mmap(struct file * file, unsigned long addr, unsigned
long len,
        unsigned long prot, unsigned long flags, unsigned long off)
{
...
        if (len > TASK_SIZE || addr > TASK_SIZE-len)
                return -EINVAL;
...


-------------------------------------------------------------------------

Wouldn't this account for it?  I'm not sure where your top 1M of
address space is on your board, but the DY4 board I'm working on
has flash up around 0xfe000000. And we ran into the same problem trying
to map our flash.

We solved the problem in a roundabout way by doing what we need to do
from inside the kernel, calling remap_page_range() directly like
mmap_mem() [drivers/char/mmap.c] does.


Frank.

-----
Frank Smith, MCompSci
Principal Software Designer      frank.smith@amirix.com
AMIRIX Systems Inc.              http://www.amirix.com/
Embedded Debian Project          http://www.emdebian.org/
77 Chain Lake Drive              902-450-1700 x289 (Phone)
Halifax, N.S. B3S 1E1            902-450-1704 (FAX)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
