Return-Path: <aik@ozlabs.ru>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 531091A088D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 01:56:58 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Sat, 28 Mar 2015 00:56:57 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id AC9DC2BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 01:56:52 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2REuiMB28180646
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 01:56:52 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2REuJUl030925
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 01:56:19 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v7 19/31] powerpc/powernv/ioda2: Introduce
 pnv_pci_ioda2_create_table/pnc_pci_free_table
Date: Sat, 28 Mar 2015 01:55:03 +1100
Message-Id: <1427468115-2224-20-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1427468115-2224-1-git-send-email-aik@ozlabs.ru>
References: <1427468115-2224-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a part of moving TCE table allocation into an iommu_ops
callback to support multiple IOMMU groups per one VFIO container.

This enforce window size to be a power of two.

This is a pretty mechanical patch.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 85 +++++++++++++++++++++++--------
 1 file changed, 63 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index a1e0df9..908863a 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -24,7 +24,9 @@
 #include <linux/msi.h>
 #include <linux/memblock.h>
 #include <linux/iommu.h>
+#include <linux/mmzone.h>
 
+#include <asm/mmzone.h>
 #include <asm/sections.h>
 #include <asm/io.h>
 #include <asm/prom.h>
@@ -1337,6 +1339,58 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 		__free_pages(tce_mem, get_order(TCE32_TABLE_SIZE * segs));
 }
 
+static long pnv_pci_ioda2_create_table(struct pnv_ioda_pe *pe,
+		__u32 page_shift, __u64 window_size,
+		struct iommu_table *tbl)
+{
+	int nid = pe->phb->hose->node;
+	struct page *tce_mem = NULL;
+	void *addr;
+	unsigned long tce_table_size;
+	int64_t rc;
+	unsigned order;
+
+	if ((window_size > memory_hotplug_max()) || !is_power_of_2(window_size))
+		return -EINVAL;
+
+	tce_table_size = (window_size >> page_shift) * 8;
+	tce_table_size = max(0x1000UL, tce_table_size);
+
+	/* Allocate TCE table */
+	order = get_order(tce_table_size);
+
+	tce_mem = alloc_pages_node(nid, GFP_KERNEL, order);
+	if (!tce_mem) {
+		pr_err("Failed to allocate a TCE memory, order=%d\n", order);
+		rc = -ENOMEM;
+		goto fail;
+	}
+	addr = page_address(tce_mem);
+	memset(addr, 0, tce_table_size);
+
+	/* Setup linux iommu table */
+	pnv_pci_setup_iommu_table(tbl, addr, tce_table_size, 0,
+			page_shift);
+
+	tbl->it_ops = &pnv_ioda2_iommu_ops;
+
+	return 0;
+fail:
+	if (tce_mem)
+		__free_pages(tce_mem, get_order(tce_table_size));
+
+	return rc;
+}
+
+static void pnv_pci_free_table(struct iommu_table *tbl)
+{
+	if (!tbl->it_size)
+		return;
+
+	free_pages(tbl->it_base, get_order(tbl->it_size << 3));
+	memset(tbl, 0, sizeof(struct iommu_table));
+}
+
 static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable)
 {
 	uint16_t window_id = (pe->pe_number << 1 ) + 1;
@@ -1409,11 +1463,9 @@ static struct iommu_table_group_ops pnv_pci_ioda2_ops = {
 static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 				       struct pnv_ioda_pe *pe)
 {
-	struct page *tce_mem = NULL;
-	void *addr;
 	const __be64 *swinvp;
-	struct iommu_table *tbl;
-	unsigned int tce_table_size, end;
+	unsigned int end;
+	struct iommu_table *tbl = &pe->table_group.tables[0];
 	int64_t rc;
 
 	/* We shouldn't already have a 32-bit DMA associated */
@@ -1422,30 +1474,20 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 
 	/* The PE will reserve all possible 32-bits space */
 	pe->tce32_seg = 0;
+
 	end = (1 << ilog2(phb->ioda.m32_pci_base));
-	tce_table_size = (end / 0x1000) * 8;
 	pe_info(pe, "Setting up 32-bit TCE table at 0..%08x\n",
 		end);
 
-	/* Allocate TCE table */
-	tce_mem = alloc_pages_node(phb->hose->node, GFP_KERNEL,
-				   get_order(tce_table_size));
-	if (!tce_mem) {
-		pe_err(pe, "Failed to allocate a 32-bit TCE memory\n");
-		goto fail;
+	rc = pnv_pci_ioda2_create_table(pe, IOMMU_PAGE_SHIFT_4K,
+			phb->ioda.m32_pci_base, tbl);
+	if (rc) {
+		pe_err(pe, "Failed to create 32-bit TCE table, err %ld", rc);
+		return;
 	}
-	addr = page_address(tce_mem);
-	memset(addr, 0, tce_table_size);
 
 	/* Setup iommu */
 	pe->table_group.tables[0].it_group = &pe->table_group;
-
-	/* Setup linux iommu table */
-	tbl = &pe->table_group.tables[0];
-	pnv_pci_setup_iommu_table(tbl, addr, tce_table_size, 0,
-			IOMMU_PAGE_SHIFT_4K);
-
-	tbl->it_ops = &pnv_ioda2_iommu_ops;
 	iommu_init_table(tbl, phb->hose->node);
 #ifdef CONFIG_IOMMU_API
 	pe->table_group.ops = &pnv_pci_ioda2_ops;
@@ -1494,8 +1536,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 fail:
 	if (pe->tce32_seg >= 0)
 		pe->tce32_seg = -1;
-	if (tce_mem)
-		__free_pages(tce_mem, get_order(tce_table_size));
+	pnv_pci_free_table(tbl);
 }
 
 static void pnv_ioda_setup_dma(struct pnv_phb *phb)
-- 
2.0.0
