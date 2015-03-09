Return-Path: <aik@ozlabs.ru>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6ECBB1A0467
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:08:53 +1100 (AEDT)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 10 Mar 2015 00:08:52 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id CD4483578054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:08:48 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t29E8eiH18284558
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:08:48 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t29E8Fw0013820
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:08:15 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 20/29] powerpc/powernv/ioda2: Introduce
 pnv_pci_ioda2_create_table/pnc_pci_free_table
Date: Tue, 10 Mar 2015 01:07:16 +1100
Message-Id: <1425910045-26167-21-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1425910045-26167-1-git-send-email-aik@ozlabs.ru>
References: <1425910045-26167-1-git-send-email-aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>
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
 arch/powerpc/platforms/powernv/pci-ioda.c | 90 +++++++++++++++++++++++--------
 1 file changed, 67 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index d05abaf..fae8cf6 100644
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
@@ -1331,6 +1333,62 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
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
+	if ((page_shift != 12) && (page_shift != 16) && (page_shift != 24))
+		return -EINVAL;
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
+	iommu_init_table(tbl, nid);
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
@@ -1401,11 +1459,9 @@ static struct iommu_table_group_ops pnv_pci_ioda2_ops = {
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
@@ -1414,31 +1470,20 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 
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
-	iommu_init_table(tbl, phb->hose->node);
 	pe->table_group.ops = &pnv_pci_ioda2_ops;
 
 	/*
@@ -1484,8 +1529,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
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
