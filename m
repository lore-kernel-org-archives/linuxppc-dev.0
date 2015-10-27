Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B78361A0475
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 09:22:36 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Tue, 27 Oct 2015 16:22:34 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 2B98C3E40044
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 16:22:32 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9RMJB0q4063622
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 15:19:11 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9RMMUHZ029869
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 16:22:31 -0600
Date: Tue, 27 Oct 2015 15:22:29 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Matthew Wilcox <willy@linux.intel.com>,
 Keith Busch <keith.busch@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Christoph Hellwig <hch@infradead.org>,
 "David S. Miller" <davem@davemloft.net>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 4/7 v2] pseries/iommu: implement DDW-aware
 dma_get_page_shift
Message-ID: <20151027222229.GE7716@linux.vnet.ibm.com>
References: <20151023205420.GA10197@linux.vnet.ibm.com>
 <20151023205925.GF10197@linux.vnet.ibm.com>
 <562F11FA.9090805@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <562F11FA.9090805@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 27.10.2015 [16:56:10 +1100], Alexey Kardashevskiy wrote:
> On 10/24/2015 07:59 AM, Nishanth Aravamudan wrote:
> >When DDW (Dynamic DMA Windows) are present for a device, we have stored
> >the TCE (Translation Control Entry) size in a special device tree
> >property. Check if we have enabled DDW for the device and return the TCE
> >size from that property if present. If the property isn't present,
> >fallback to looking the value up in struct iommu_table. If we don't find
> >a iommu_table, fallback to the kernel's page size.
> >
> >Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> >---
> >  arch/powerpc/platforms/pseries/iommu.c | 36 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >
> >diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> >index 0946b98..1bf6471 100644
> >--- a/arch/powerpc/platforms/pseries/iommu.c
> >+++ b/arch/powerpc/platforms/pseries/iommu.c
> >@@ -1292,6 +1292,40 @@ static u64 dma_get_required_mask_pSeriesLP(struct device *dev)
> >  	return dma_iommu_ops.get_required_mask(dev);
> >  }
> >
> >+static unsigned long dma_get_page_shift_pSeriesLP(struct device *dev)
> >+{
> >+	struct iommu_table *tbl;
> >+
> >+	if (!disable_ddw && dev_is_pci(dev)) {
> >+		struct pci_dev *pdev = to_pci_dev(dev);
> >+		struct device_node *dn;
> >+
> >+		dn = pci_device_to_OF_node(pdev);
> >+
> >+		/* search upwards for ibm,dma-window */
> >+		for (; dn && PCI_DN(dn) && !PCI_DN(dn)->table_group;
> >+				dn = dn->parent)
> >+			if (of_get_property(dn, "ibm,dma-window", NULL))
> >+				break;
> >+		/*
> >+		 * if there is a DDW configuration, the TCE shift is stored in
> >+		 * the property
> >+		 */
> >+		if (dn && PCI_DN(dn)) {
> >+			const struct dynamic_dma_window_prop *direct64 =
> >+				of_get_property(dn, DIRECT64_PROPNAME, NULL);
> 
> 
> This DIRECT64_PROPNAME property is only present under pHyp, QEMU/KVM
> does not set it as 64bit windows are dynamic there so something like
> find_existing_ddw() needs to be used here.

DIRECT64_PROPNAME is a Linux thing, not a pHyp or QEMU/KVM thing -- it's
created by the Linux DDW logic and left in the device-tree when we
successfully configure DDW.

You're right, though, that logically find_existing_ddw() would be better
to use here. I'll spin up a new version.

-Nish
