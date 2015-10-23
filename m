Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9A2A81A0BE3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2015 07:59:34 +1100 (AEDT)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 23 Oct 2015 16:59:32 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id F33246E8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2015 16:47:40 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9NKxTUX63832276
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2015 20:59:29 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9NKxQrE032715
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2015 16:59:29 -0400
Date: Fri, 23 Oct 2015 13:59:25 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Matthew Wilcox <willy@linux.intel.com>,
 Keith Busch <keith.busch@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Christoph Hellwig <hch@infradead.org>,
 "David S. Miller" <davem@davemloft.net>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Subject: [PATCH 4/7 v2] pseries/iommu: implement DDW-aware dma_get_page_shift
Message-ID: <20151023205925.GF10197@linux.vnet.ibm.com>
References: <20151023205420.GA10197@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151023205420.GA10197@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When DDW (Dynamic DMA Windows) are present for a device, we have stored
the TCE (Translation Control Entry) size in a special device tree
property. Check if we have enabled DDW for the device and return the TCE
size from that property if present. If the property isn't present,
fallback to looking the value up in struct iommu_table. If we don't find
a iommu_table, fallback to the kernel's page size.

Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 36 ++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 0946b98..1bf6471 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -1292,6 +1292,40 @@ static u64 dma_get_required_mask_pSeriesLP(struct device *dev)
 	return dma_iommu_ops.get_required_mask(dev);
 }
 
+static unsigned long dma_get_page_shift_pSeriesLP(struct device *dev)
+{
+	struct iommu_table *tbl;
+
+	if (!disable_ddw && dev_is_pci(dev)) {
+		struct pci_dev *pdev = to_pci_dev(dev);
+		struct device_node *dn;
+
+		dn = pci_device_to_OF_node(pdev);
+
+		/* search upwards for ibm,dma-window */
+		for (; dn && PCI_DN(dn) && !PCI_DN(dn)->table_group;
+				dn = dn->parent)
+			if (of_get_property(dn, "ibm,dma-window", NULL))
+				break;
+		/*
+		 * if there is a DDW configuration, the TCE shift is stored in
+		 * the property
+		 */
+		if (dn && PCI_DN(dn)) {
+			const struct dynamic_dma_window_prop *direct64 =
+				of_get_property(dn, DIRECT64_PROPNAME, NULL);
+			if (direct64)
+				return be32_to_cpu(direct64->tce_shift);
+		}
+	}
+
+	tbl = get_iommu_table_base(dev);
+	if (tbl)
+		return tbl->it_page_shift;
+
+	return PAGE_SHIFT;
+}
+
 #else  /* CONFIG_PCI */
 #define pci_dma_bus_setup_pSeries	NULL
 #define pci_dma_dev_setup_pSeries	NULL
@@ -1299,6 +1333,7 @@ static u64 dma_get_required_mask_pSeriesLP(struct device *dev)
 #define pci_dma_dev_setup_pSeriesLP	NULL
 #define dma_set_mask_pSeriesLP		NULL
 #define dma_get_required_mask_pSeriesLP	NULL
+#define dma_get_page_shift_pSeriesLP	NULL
 #endif /* !CONFIG_PCI */
 
 static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
@@ -1395,6 +1430,7 @@ void iommu_init_early_pSeries(void)
 		pseries_pci_controller_ops.dma_dev_setup = pci_dma_dev_setup_pSeriesLP;
 		ppc_md.dma_set_mask = dma_set_mask_pSeriesLP;
 		ppc_md.dma_get_required_mask = dma_get_required_mask_pSeriesLP;
+		ppc_md.dma_get_page_shift = dma_get_page_shift_pSeriesLP;
 	} else {
 		pseries_pci_controller_ops.dma_bus_setup = pci_dma_bus_setup_pSeries;
 		pseries_pci_controller_ops.dma_dev_setup = pci_dma_dev_setup_pSeries;
-- 
1.9.1
