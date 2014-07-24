Return-Path: <aik@ozlabs.ru>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DD6501A08A5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 18:48:25 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Thu, 24 Jul 2014 18:48:20 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id EF610357802D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 18:48:23 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6O8m73s4456852
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 18:48:07 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6O8mNgN005030
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 18:48:23 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 16/18] powerpc/powernv: Implement Dynamic DMA windows (DDW)
 for IODA
Date: Thu, 24 Jul 2014 18:48:09 +1000
Message-Id: <1406191691-31441-17-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1406191691-31441-1-git-send-email-aik@ozlabs.ru>
References: <1406191691-31441-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

SPAPR defines an interface to create additional DMA windows dynamically.
"Dynamically" means that the window is not allocated at the guest start
and the guest can request it later. In practice, existing linux guests
check for the capability and if it is there, they create+map one big DMA
window as big as the entire guest RAM.

SPAPR defines 4 RTAS calls for this feature which userspace implements.
This adds 4 callbacks into the spapr_tce_iommu_ops struct:
1. query - ibm,query-pe-dma-window - returns number/size of windows
which can be created (one, any page size);
2. create - ibm,create-pe-dma-window - creates a window;
3. remove - ibm,remove-pe-dma-window - removes a window; only additional
window created by create() can be removed, the default 32bit window cannot
be removed as guests do not expect new windows to start from zero;
4. reset -  ibm,reset-pe-dma-window - reset the DMA windows configuration
to the default state; now it only removes the additional window if it
was created.

The next patch will add corresponding ioctls to VFIO SPAPR TCE driver to
pass RTAS call from the userspace to the IODA code.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/tce.h            |  21 ++++
 arch/powerpc/platforms/powernv/pci-ioda.c | 157 +++++++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/pci.h      |   2 +
 3 files changed, 179 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/tce.h b/arch/powerpc/include/asm/tce.h
index 5ee4987..583463b 100644
--- a/arch/powerpc/include/asm/tce.h
+++ b/arch/powerpc/include/asm/tce.h
@@ -60,6 +60,27 @@ struct spapr_tce_iommu_ops {
 			phys_addr_t addr);
 	void (*take_ownership)(struct spapr_tce_iommu_group *data,
 			bool enable);
+
+	/* Dynamic DMA window */
+	/* Page size flags for ibm,query-pe-dma-window */
+#define DDW_PGSIZE_4K       0x01
+#define DDW_PGSIZE_64K      0x02
+#define DDW_PGSIZE_16M      0x04
+#define DDW_PGSIZE_32M      0x08
+#define DDW_PGSIZE_64M      0x10
+#define DDW_PGSIZE_128M     0x20
+#define DDW_PGSIZE_256M     0x40
+#define DDW_PGSIZE_16G      0x80
+	long (*query)(struct spapr_tce_iommu_group *data,
+			__u32 *windows_available,
+			__u32 *page_size_mask);
+	long (*create)(struct spapr_tce_iommu_group *data,
+			__u32 page_shift,
+			__u32 window_shift,
+			struct iommu_table **ptbl);
+	long (*remove)(struct spapr_tce_iommu_group *data,
+			struct iommu_table *tbl);
+	long (*reset)(struct spapr_tce_iommu_group *data);
 };
 
 struct spapr_tce_iommu_group {
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index f828c57..2f2bdab 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -754,6 +754,24 @@ static void pnv_pci_ioda2_setup_bypass_pe(struct pnv_phb *phb,
 	pnv_pci_ioda2_set_bypass(pe, true);
 }
 
+static struct iommu_table *pnv_ioda2_iommu_get_table(
+		struct spapr_tce_iommu_group *data,
+		phys_addr_t addr)
+{
+	struct pnv_ioda_pe *pe = data->iommu_owner;
+
+	if (addr == TCE_DEFAULT_WINDOW)
+		return &pe->tce32.table;
+
+	if (pnv_pci_ioda_check_addr(&pe->tce64.table, addr))
+		return &pe->tce64.table;
+
+	if (pnv_pci_ioda_check_addr(&pe->tce32.table, addr))
+		return &pe->tce32.table;
+
+	return NULL;
+}
+
 static void pnv_ioda2_take_ownership(struct spapr_tce_iommu_group *data,
 				     bool enable)
 {
@@ -762,9 +780,146 @@ static void pnv_ioda2_take_ownership(struct spapr_tce_iommu_group *data,
 	pnv_pci_ioda2_set_bypass(pe, !enable);
 }
 
+static long pnv_pci_ioda2_ddw_query(struct spapr_tce_iommu_group *data,
+		__u32 *windows_available, __u32 *page_size_mask)
+{
+	struct pnv_ioda_pe *pe = data->iommu_owner;
+
+	if (pe->tce64_active) {
+		*page_size_mask = 0;
+		*windows_available = 0;
+	} else {
+		*page_size_mask =
+			DDW_PGSIZE_4K |
+			DDW_PGSIZE_64K |
+			DDW_PGSIZE_16M;
+		*windows_available = 1;
+	}
+
+	return 0;
+}
+
+static long pnv_pci_ioda2_ddw_create(struct spapr_tce_iommu_group *data,
+		__u32 page_shift, __u32 window_shift,
+		struct iommu_table **ptbl)
+{
+	struct pnv_ioda_pe *pe = data->iommu_owner;
+	struct pnv_phb *phb = pe->phb;
+	struct page *tce_mem = NULL;
+	void *addr;
+	long ret;
+	unsigned long tce_table_size =
+			(1ULL << (window_shift - page_shift)) * 8;
+	unsigned order;
+	struct iommu_table *tbl64 = &pe->tce64.table;
+
+	if ((page_shift != 12) && (page_shift != 16) && (page_shift != 24))
+		return -EINVAL;
+
+	if (window_shift > (memory_hotplug_max() >> page_shift))
+		return -EINVAL;
+
+	if (pe->tce64_active)
+		return -EBUSY;
+
+	tce_table_size = max(0x1000UL, tce_table_size);
+	order = get_order(tce_table_size);
+
+	pe_info(pe, "Setting up DDW at %llx..%llx ws=0x%x ps=0x%x table_size=0x%lx order=0x%x\n",
+			pe->tce_bypass_base,
+			pe->tce_bypass_base + (1ULL << window_shift) - 1,
+			window_shift, page_shift, tce_table_size, order);
+
+	tce_mem = alloc_pages_node(phb->hose->node, GFP_KERNEL, order);
+	if (!tce_mem) {
+		pe_err(pe, " Failed to allocate a DDW\n");
+		return -EFAULT;
+	}
+	addr = page_address(tce_mem);
+	memset(addr, 0, tce_table_size);
+
+	/* Configure HW */
+	ret = opal_pci_map_pe_dma_window(phb->opal_id,
+			pe->pe_number,
+			(pe->pe_number << 1) + 1, /* Window number */
+			1,
+			__pa(addr),
+			tce_table_size,
+			1 << page_shift);
+	if (ret) {
+		pe_err(pe, " Failed to configure 32-bit TCE table, err %ld\n",
+				ret);
+		return -EFAULT;
+	}
+
+	/* Setup linux iommu table */
+	pnv_pci_setup_iommu_table(tbl64, addr, tce_table_size,
+			pe->tce_bypass_base, page_shift);
+	pe->tce64.pe = pe;
+
+	/* Copy "invalidate" register address */
+	tbl64->it_index = pe->tce32.table.it_index;
+	tbl64->it_type = TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE |
+			TCE_PCI_SWINV_PAIR;
+	tbl64->it_map = (void *) 0xDEADBEEF; /* poison */
+
+	*ptbl = &pe->tce64.table;
+
+	pe->tce64_active = true;
+
+	return 0;
+}
+
+static long pnv_pci_ioda2_ddw_remove(struct spapr_tce_iommu_group *data,
+		struct iommu_table *tbl)
+{
+	struct pnv_ioda_pe *pe = data->iommu_owner;
+	struct pnv_phb *phb = pe->phb;
+	long ret;
+
+	/* Only additional 64bit window removal is supported */
+	if ((tbl != &pe->tce64.table) || !pe->tce64_active)
+		return -EFAULT;
+
+	pe_info(pe, "Removing huge 64bit DMA window\n");
+
+	iommu_clear_tces_and_put_pages(tbl, tbl->it_offset, tbl->it_size);
+
+	pe->tce64_active = false;
+
+	ret = opal_pci_map_pe_dma_window(phb->opal_id,
+			pe->pe_number,
+			(pe->pe_number << 1) + 1,
+			0/* levels */, 0/* table address */,
+			0/* table size */, 0/* page size */);
+	if (ret)
+		pe_warn(pe, "Unmapping failed, ret = %ld\n", ret);
+
+	free_pages(tbl->it_base, get_order(tbl->it_size << 3));
+	memset(&pe->tce64, 0, sizeof(pe->tce64));
+
+	return ret;
+}
+
+static long pnv_pci_ioda2_ddw_reset(struct spapr_tce_iommu_group *data)
+{
+	struct pnv_ioda_pe *pe = data->iommu_owner;
+
+	pe_info(pe, "Reset DMA windows\n");
+
+	if (!pe->tce64_active)
+		return 0;
+
+	return pnv_pci_ioda2_ddw_remove(data, &pe->tce64.table);
+}
+
 static struct spapr_tce_iommu_ops pnv_pci_ioda2_ops = {
-	.get_table = pnv_ioda1_iommu_get_table,
+	.get_table = pnv_ioda2_iommu_get_table,
 	.take_ownership = pnv_ioda2_take_ownership,
+	.query = pnv_pci_ioda2_ddw_query,
+	.create = pnv_pci_ioda2_ddw_create,
+	.remove = pnv_pci_ioda2_ddw_remove,
+	.reset = pnv_pci_ioda2_ddw_reset
 };
 
 static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 32847a5..7e88d8a 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -64,6 +64,8 @@ struct pnv_ioda_pe {
 	int			tce32_segcount;
 	struct pnv_iommu_table	tce32;
 	phys_addr_t		tce_inval_reg_phys;
+	bool			tce64_active;
+	struct pnv_iommu_table	tce64;
 
 	/* 64-bit TCE bypass region */
 	bool			tce_bypass_enabled;
-- 
2.0.0
