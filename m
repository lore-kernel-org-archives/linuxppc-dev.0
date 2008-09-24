Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 79FBBDDDF3
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 11:24:25 +1000 (EST)
Date: Tue, 23 Sep 2008 20:24:02 -0500 (CDT)
Message-Id: <200809240124.m8O1O2QK076012@sullivan.realtime.net>
To: Sebastian Siewior <bigeasy@linutronix.de>
Sender: Milton Miller <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
Subject: [RFC] powerpc/boot: add kernel,end node to the cuboot target
In-Reply-To: <20080923195404.GA10935@www.tglx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed Sep 24 at about 05:54:04 EST 2008, Sebastian Siewior wrote:
> this could be used by the kexec userland code.

NACK.

First of all, you fail to justify why it is needed.

Second of all, its in the wrong place, if it were needed.  The code
in arch/powerpc/boot does not get executed on all platforms, it is
just an assistance and conversion wrapper for those platforms that
need it.

Third, it will break the 64 bit code worse than it is.  (The kernel
does not delete the property before attemtping to add a new one. The
patch got lost in the maintainer then patchwork shuffeles and will
be resent.)

On the first point:  The only reason the kernel exports it for the
64 bit code is because of limitations of the kernel kexec code
unique to the 64 bit powerpc port.  Specifically, the kernel does
not support the next image destination address being on top of
itself.   This this limitation is unique to 64-bit powerpc kexec
code and shold NOT be propagated to 32-bit powerpc support.  The
reason for it is due the combination of the hypervisor architecture
that only gives us access to a small portion of memory in real mode
(MB out of GB of main memory), a single zone memory management
policy for linux alocation of main memory (which is good from a
memory management perspective but combined with the former means
we can not reasonably permit the generic code to just keep allocating
memory until the chosen pages are in the real mode accesble region),
and the many specific hypervisor interfaces to fill in the page
table required to do a virtural mode access.  The three factors
combine to say the only sane answer is to do the copy under the
kernels virtural mode fault handlers, and therefore the new image
must be loaded using memory other than that occupied by the current
kernel text, its static data and bss (and other mmu related tables).
The reason this limiation is to not too severe is the kernel currently
does not care where it is loaded as it will copy itself to the
beginning of memory.  Note that this does not apply to kdump -- the
panic kernel is loaded into memory reserverd for the purpose by the
first kernel, and that memory never overlaps the kernel, page table,
iommu tables, or other simiar data).  Also, this easing only applies
to the linux kernel, and other targets may need a second copy loop
within the real mode region.

So far I have seen no argument clone this limitation to this for
32 bit mode.   The existing 32 bit code does like x86 and most other
architecures: it includes a small loop (well less than a page), to
turn off the mmu, copy the pages into place, and jump to the indicated
address.  This code is completely relocatable and its runtime
location is chosen after all source and destination pages are
allocated for the new image.  On Book-E this will need to establish
a 1-1 linear mapping probaby as suggested in the ePAPR, but there
is no need for the size of the current kernel.


If you have any questions about kdump or what needs to happen,
please feel free to contact me either by email or on irc (sometimes
I use mdm other times the email login as my nick, and when connected
I tend to leave it well past the hours I am at the computer).

milton


PS:  I read the previous kdump for ppc32 patches, but did not get
a chance to reply in detail.  Apologies if they are unrelated to
your work.  My main comments were:

(1) the first patch, similar to this one but moving the code in
the kernel from 64 bit to common code, was not needed.

(2) I can not support making the default kexec hooks be attempt
kexec and see what happens until there is at least minimal support
for both smp processors (weither it be the 64-bit kernel approach
of parallel entry points, possibly modified for the 32 bit entry
aparently having at least one platform using 0xc0 vs 0x60 as the
start point for exactly one slave, and possibly extended to having
a postive acknowledgement to say the slave made it), or the ePAPR
spinloop (which works until we notice that the code in the boot
directory does not look at the device tree reserves, the kernel
does not export it its original reserves for the next kexec, nor
are they tagged for kexec to filter upon), or some other approach.
I think the book-e (44x and fsl) maintainers should simlarly nack
such a patch until sutiable code to establish an initial enviornment
for their processors were also included.
