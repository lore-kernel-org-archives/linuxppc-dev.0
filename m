Message-ID: <3A6CEF13.1F868277@mvista.com>
Date: Mon, 22 Jan 2001 21:40:19 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Takashi Oe <toe@unlserve.unl.edu>
CC: Roman Zippel <zippel@fh-brandenburg.de>,
        Jeff Hartmann <jhartmann@valinux.com>, michdaen@iiic.ethz.ch,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Gareth Hughes <gareth@valinux.com>, linuxppc-dev@lists.linuxppc.org,
        dri-devel@lists.sourceforge.net, Paul Mackerras <paulus@linuxcare.com>
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
References: <B6924864.5CF1%toe@unlserve.unl.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Takashi Oe wrote:

> Is it really true that virt_to_phys on vmalloc'd memory is broken 6xx?

Yep.  The virt_to_phys (except for APUS), only does address - KERNELBASE.
I posted a message about this a few days ago during my "mmu cleanup"
while merging new code.  I have discovered that architectures are
implementing private versions of functions/macros for things like
this that are all slightly different.  There is no sense to this,
as there should be generic Linux functions for many more memory
management functions (and cache management, and dma management,...).

> .....  I
> wonder why planb works at all....

Probably because no one stumbles across the memory it is trashing?
Currently, bad_thing_will_happen = vmalloc + virt_to_bus + dma.
It could be with the right memory size, modulo addressing, memory
controller configuration, timing of the vmalloc, it just may
accidently work.  If this is the case, I would be out buying
lottery tickets........


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
