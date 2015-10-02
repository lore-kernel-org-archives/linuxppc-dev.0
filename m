Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2037B1A055C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Oct 2015 06:22:20 +1000 (AEST)
Received: from localhost
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 2 Oct 2015 14:22:19 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id D20E41FF0049
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 14:10:08 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t92KIlZZ9830828
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Oct 2015 13:18:47 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t92KLtAx019500
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Oct 2015 14:21:56 -0600
Date: Fri, 2 Oct 2015 13:21:51 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Matthew Wilcox <willy@linux.intel.com>
Cc: Keith Busch <keith.busch@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Christoph Hellwig <hch@infradead.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/5 v2] pseries/iommu: implement DDW-aware dma_get_page_shift
Message-ID: <20151002202151.GJ8040@linux.vnet.ibm.com>
References: <20151002171606.GA41011@linux.vnet.ibm.com>
 <20151002200953.GB40695@linux.vnet.ibm.com>
 <20151002201142.GC40695@linux.vnet.ibm.com>
 <20151002201647.GH8040@linux.vnet.ibm.com>
 <20151002201914.GI8040@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151002201914.GI8040@linux.vnet.ibm.com>
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
