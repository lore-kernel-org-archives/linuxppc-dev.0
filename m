Date: Tue, 23 Jan 2001 03:34:33 +0000
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Dan Malek <dan@mvista.com>, Takashi Oe <toe@unlserve.unl.edu>
Cc: Roman Zippel <zippel@fh-brandenburg.de>,
        Jeff Hartmann <jhartmann@valinux.com>, michdaen@iiic.ethz.ch,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Gareth Hughes <gareth@valinux.com>, linuxppc-dev@lists.linuxppc.org,
        Paul Mackerras <paulus@linuxcare.com>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010123033438.B3DB9DBA41@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


[DRI-devel removed]

Dan Malek wrote:
> Takashi Oe wrote:
>
>> Is it really true that virt_to_phys on vmalloc'd memory is broken 6xx?
>
> Yep.  The virt_to_phys (except for APUS), only does address - KERNELBASE.
> I posted a message about this a few days ago during my "mmu cleanup"
> while merging new code.  I have discovered that architectures are
> implementing private versions of functions/macros for things like
> this that are all slightly different.  There is no sense to this,
> as there should be generic Linux functions for many more memory
> management functions (and cache management, and dma management,...).

and, from this also 7xx...

>> .....  I
>> wonder why planb works at all....
>
> Probably because no one stumbles across the memory it is trashing?
> Currently, bad_thing_will_happen = vmalloc + virt_to_bus + dma.
> It could be with the right memory size, modulo addressing, memory
> controller configuration, timing of the vmalloc, it just may
> accidently work.  If this is the case, I would be out buying
> lottery tickets........

OK. so, supposing this might be the source of an occasional segv we're
getting with dmasound - (this thread was starting to worry me).

what is the _current_ "right thing" to do?
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
