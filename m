Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org,
 benh@kernel.crashing.org
Subject: Re: [Cbe-oss-dev] [patch 9/9] powerpc/cell:
	=?iso-8859-1?q?Add=09DMA=5FATTR=5FSTRONG=5FORDERING_dma_attribute_and_use?=
	=?iso-8859-1?q?_in_IOMMU?= code
Date: Thu, 17 Jul 2008 16:53:28 +0200
References: <20080715195139.316677337@arndb.de>
	<200807160954.03633.arnd@arndb.de>
	<1216275643.7740.302.camel@pasglop>
In-Reply-To: <1216275643.7740.302.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807171653.29946.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Roland Dreier <rdreier@cisco.com>,
	Peter Altevogt <peter.altevogt@de.ibm.com>,
	Hans Boettiger <h.boettiger@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 17 July 2008, Benjamin Herrenschmidt wrote:
> On Wed, 2008-07-16 at 09:54 +0200, Arnd Bergmann wrote:
> > On Wednesday 16 July 2008, Roland Dreier wrote:
> > >  > Strong ordering is only active when both the bridge and the IOMMU
> > >  > enable it, but for correctly written drivers, this only results in a
> > >  > slowdown.
> > >
> > > So when would someone use this dma attribute?  As a hack to fix drivers
> > > where the real fix is too complicated?
> >
> > This is used in the Axon PCIe endpoint drivers, e.g. in the Roadrunner
> > machine. The reason was to improve roundtrip latency by doing only
> > mmio stores, not loads, on each side of the PCIe connection, which
> > turn into posted DMA operations on the other end. With relaxed ordering,
> > the posted writes may be observed out of order. Strong ordering makes
> > sure they arrive in-order without having to do a non-posted mmio read
> > or eieio operation on the receiver side.
>
> I don't think it's legal for writes from a given initiator to arrive to
> memory out of order.
> 
> Some drivers, notably network drivers, for example, rely on the "OWN"
> bit being written last in memory when writing back ring buffer status.
> 
> If the bit arrives before the actual data, then data corruption will
> occur.

Ok, this makes sense. I've followed the bit down in the specification,
and now it seems like we can't just set relaxed ordering in the IOMMU
but should use the value that comes from the PCIe device.

The flow of the order bit in this machine is as follows:

1. The device can select relaxed (weak) or non-relaxed (strong) ordering
for a DMA transfer. PCI-X is always strong, DMAx can be configured globally,
and PCIe is device specific.
2. The PCIe root complex can override the order bit and force it to strong
ordering (which we don't).
3. The PLB5-to-C3PO bridge can override the bit and force it to weak or
strong or leave it alone (we force it to weak).
4. The IOMMU can force the bit to weak on a per-page base (we don't without
the patch, but do with the patch).

Peter and Hans were involved in the discussion that led to the decision
to change step 3 from per-transfer default to always weak ordering.
I think they verified that this is safe for all the peripherals that we
have on the QS21 and QS22 blades (tg3, ehci, mthca, mptsas), but that
doesn't mean that it is safe in general, so I guess you are right that
we should not make it the default in the kernel for Cell systems.
Hans, can you confirm this?

	Arnd <><
