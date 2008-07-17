Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [patch 9/9] powerpc/cell:
	Add	DMA_ATTR_STRONG_ORDERING dma attribute and use in IOMMU code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200807171653.29946.arnd@arndb.de>
References: <20080715195139.316677337@arndb.de>
	<200807160954.03633.arnd@arndb.de> <1216275643.7740.302.camel@pasglop>
	<200807171653.29946.arnd@arndb.de>
Content-Type: text/plain
Date: Fri, 18 Jul 2008 06:10:57 +1000
Message-Id: <1216325457.7740.357.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Roland Dreier <rdreier@cisco.com>,
	Peter Altevogt <peter.altevogt@de.ibm.com>,
	cbe-oss-dev@ozlabs.org, Hans Boettiger <h.boettiger@de.ibm.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Ok, this makes sense. I've followed the bit down in the specification,
> and now it seems like we can't just set relaxed ordering in the IOMMU
> but should use the value that comes from the PCIe device.
> 
> The flow of the order bit in this machine is as follows:
> 
> 1. The device can select relaxed (weak) or non-relaxed (strong) ordering
> for a DMA transfer. PCI-X is always strong, DMAx can be configured globally,
> and PCIe is device specific.
> 2. The PCIe root complex can override the order bit and force it to strong
> ordering (which we don't).
> 3. The PLB5-to-C3PO bridge can override the bit and force it to weak or
> strong or leave it alone (we force it to weak).
> 4. The IOMMU can force the bit to weak on a per-page base (we don't without
> the patch, but do with the patch).
> 
> Peter and Hans were involved in the discussion that led to the decision
> to change step 3 from per-transfer default to always weak ordering.
> I think they verified that this is safe for all the peripherals that we
> have on the QS21 and QS22 blades (tg3, ehci, mthca, mptsas), but that
> doesn't mean that it is safe in general, so I guess you are right that
> we should not make it the default in the kernel for Cell systems.
> Hans, can you confirm this?

In the meantime, send a patch that defaults to strong with explicit
weak, we can easily fixup after that.

Ben.
