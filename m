Message-ID: <392562CE.A71A4F49@embeddededge.com>
Date: Fri, 19 May 2000 11:50:38 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Ralph Blach <rcblach@raleigh.ibm.com>
CC: Daris A Nevil <dnevil@snmc.com>,
        Graham Stoney <greyham@research.canon.com.au>,
        Daniel Wu <Daniel.Wu@alcatel.com.au>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: Porting LinuxPPC
References: <20000519051051.236093C972@elph.research.canon.com.au> <39253A48.24B90117@snmc.com> <39253D0B.F9AF86EE@raleigh.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ralph Blach wrote:

> I disagree.  I beleive that the Kernel load simply must be above
> 0x80000000.

OK, time for another memory map lesson........

Virtual addresses from 0 to 0x7fffffff are for user context.  Above
this are the kernel virtual addresses.  The PowerPC processors have
more than 32-bits of addressing, but I won't go into that since it
is not important for this discussion.

During the early kernel initialization, the kernel virtual memory
allocator is not operational.  Prior to this KVM initialization, we
choose to map virtual to physical addresses 1:1.  That is, the kernel
virtual address exactly matches the physical address on the bus.  These
mappings are typically done in arch/ppc/kernel/head.S, or
arch/ppc/mm/init.c.  Only absolutely necessary mappings should be
done at this time, for example board control registers or a serial
uart.  Normal device driver initialization should map resources
later when necessary.

Although platform dependent, and certainly the case for embedded 8xx,
traditionally memory is mapped at physical address zero, and I/O
devices above phsical address 0x80000000.  The lowest and highest
(above 0xf0000000) I/O addresses are traditionally used for devices
or registers we need to map during kernel initialization and prior
to KVM operation.  For this reason, and since it followed prior PowerPC
platform examples, I chose to map the embedded 8xx kernel to the
0xc0000000 virtual address.  This way, we can enable the MMU to map the
kernel for proper operation, and still map a few windows before the
KVM is operational.

On some systems, you could possibly run the kernel at the 0x80000000
or any other virtual address.  It just depends upon mapping that must
be done prior to KVM operational.  You can never map devices or
kernel spaces that overlap with the user virtual space.  This is why
default IMMR mapping used by most BDM tools won't work.  They put
the IMMR at something like 0x10000000 or 0x02000000 for example.  You
simply can't map these addresses early in the kernel, and continue
proper system operation.

The embedded 8xx/82xx kernel is mature enough that all you should need
to do is map the IMMR someplace at or above 0xf0000000 and it should
boot far enough to get serial console messages and KGDB connected on
any platform.  There are lots of other subtle memory management design
features that you simply don't need to worry about.  If you are changing
functions related to MMU initialization, you are likely breaking things
that are known to work and are heading down a path of disaster and
frustration.  Your changes should be to make the flexibility of the
processor fit Linux, not force arbitrary and non-workable memory
mappings into Linux.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
