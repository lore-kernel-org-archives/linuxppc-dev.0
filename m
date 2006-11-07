Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 07 Nov 2006 18:22:30 +1100
Subject: [PATCH 0/31] My current serie of patches for 2.6.20 for review
In-Reply-To: <benh@kernel.crashing.org>
Message-Id: <1162884150.435786.961370643810.qpush@grosgo>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[ I'm re-posting it today as there have been a number of significant
  changes. I expect that unless I get a lot of feedback, however,
  your mailboxes will be safe from such another flood for the next
  few days as I'll be working on a couple of other things I have
  pending and I'm fairly happy with the patches in their current
  shape
]

This is the whole of my current patch set that I intend to merge
as soon as 2.6.20 merge window opens. I'm posting them here for
review, some of them already had a few iterations on the list by
their own, some didn't show up publically at all yet.

Note that the first 4 ones require specific comments:

- powerpc-ibmveth-remove-liobn.diff should already be queued with
  Jeff Garzik

- platform-notify-remove-change.diff
- device-notifier.diff should both be already queued with Greg KH

- iomap-arch-accessors.diff was written by Linus but is not merged
  yet. He asked me to resend it when needed, so I'll include it with
  the other patches when the merge window opens.

This patch set started its life as the support for the new "Axon"
southbridge for cell (which includes such things as MMIO mapped DCR
and 4xx-type devices). However, as things evolved, I ended up doing
a lot more than just the basic support. Among other highlights of
this patch serie are:

 - Generic DCR support for both 4xx-type DCRs and MMIO mapped DCR and
MPIC & EMAC changes to work with that

 - Souped up of_platform_driver to make it easier to register entire
trees of devices at once, along with PCI host bridge detection support
for 64 bits architectures. Note that some name changes might break
compile of some platforms. I hope to have fixed everything before I
merge but don't forget to tell me if I missed something.

 - Completely reworked 64 bits DMA operations

 - Possibility to "hook" on PCI MMIO and PCI operations from the platform
code for use by iSeries, Cell and possibly others who have to deal with
weird hypervisor or PCI host bridge erratas. Currently supported only on
64 bits but would be easy to make it work on 32 bits if ever needed.

 - Merged 32 and 64 bits io.h. ARCH=powerpc now uses asm-powerpc/io.h
for both. ARCH=ppc still uses the old one in asm-ppc as I really don't
feel like dealing with some of the cruft in there.

 - As a consequence of the 2 above, new accessors are available that match
what is done by other architectures: {read,write}{w,l,q}_be for big endian
PCI MMIO accesses, {read,write}s{b,w,l} for MMIO "repeat" operations, and
a significant cleanup of the EEH stuff.

 - Cell IOMMU support (mostly written by Jeremy Kerr)
