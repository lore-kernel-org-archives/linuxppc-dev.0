To: Dan Malek <dan@embeddededge.com>
Cc: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: question on howto use invalidate_dcache_range
References: <FCEAKDJJAPHPLJFINDAJCELACOAA.Stephan.Linke@epygi.de>
	<3E70B17E.9090507@embeddededge.com>
	<004501c2e989$a10a66c0$020120b0@jockeXP>
	<3E70C88B.70004@embeddededge.com> <52k7f3t9ic.fsf@topspin.com>
	<3E70D076.7030507@embeddededge.com>
From: Roland Dreier <roland@topspin.com>
Date: 13 Mar 2003 11:09:00 -0800
In-Reply-To: <3E70D076.7030507@embeddededge.com>
Message-ID: <52fzprt777.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


    Dan> That's a problem in any system design.  Consider what would
    Dan> happen if you had an architecture that was hardware cache
    Dan> coherent.  Software that writes to buffers at any time that
    Dan> is also a DMA target will result in unpredictable behavior.
    Dan> The system design for what you described requires a higher
    Dan> level of shared memory software synchronization as it is
    Dan> exactly the unpredictability that has to be prevented in any
    Dan> SMP design.

I think you misunderstood.  The dirty cache line could be produced by
a write to memory executed long before the DMA is initiated.  In a
hardware cache coherent architecture, the bus controller would just
snoop the CPU's cache and invalidate the dirty cache line.

In any case the current Linux kernel seems to do things the way I
believe is necessary: pci_map_single(...PCI_DMA_FROMDEVICE)
invalidates the cache (and is done _before_ the DMA is initiated),
while pci_unmap_single() is a NOOP.

 - Roland


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
