Return-Path: <SRS0=dpXp=SO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6E3C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 06:48:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99E212186A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 06:48:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E212186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44gT4z50LVzDq9n
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 16:48:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 44gT0J2TMTzDqTD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2019 16:44:48 +1000 (AEST)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 803E1AE800EC;
 Fri, 12 Apr 2019 02:44:15 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel RFC 2/2] powerpc/powernv/ioda2: Create bigger default
 window with 64k IOMMU pages
Date: Fri, 12 Apr 2019 16:44:08 +1000
Message-Id: <20190412064408.85399-3-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190412064408.85399-1-aik@ozlabs.ru>
References: <20190412064408.85399-1-aik@ozlabs.ru>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>, Oliver O'Halloran <oohall@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

At the moment we create a small window only for 32bit devices, the window
maps 0..2GB of the PCI space only. For other devices we either use
a sketchy bypass or hardware bypass but the former can only work if
the amount of RAM is no bigger than the device's DMA mask and the latter
requires devices to support at least 59bit DMA.

This extends the default DMA window to the maximum size possible to allow
more flexibility. The default window size has a limitation as
the allocation bitmap in iommu_table is a contiguous array with a bit per
an IOMMU page. Also, this increases the default IOMMU page size to
the system page size to allow higher supported DMA masks.

As the extended window now overlaps the 32bit MMIO region, this adds
reservation capability to iommu_init_table().

After this change the default window size is 0x80000000000==1<<43 so
devices limited to DMA mask smaller than the amount of system RAM can
still use more than just 2GB of memory for DMA.

With the on-demand allocation of indirect TCE table levels enabled and
2 levels, the first TCE level size is just
1<<ceil((log2(0x7ffffffffff+1)-16)/2)=16384 TCEs or 2 system pages.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/iommu.h          |  8 +++-
 arch/powerpc/kernel/iommu.c               | 58 +++++++++++++++--------
 arch/powerpc/platforms/powernv/pci-ioda.c | 14 ++++--
 3 files changed, 56 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 0ac52392ed99..5ea782e04803 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -124,6 +124,8 @@ struct iommu_table {
 	struct iommu_table_ops *it_ops;
 	struct kref    it_kref;
 	int it_nid;
+	unsigned long it_reserved_start; /* Start of not-DMA-able (MMIO) area */
+	unsigned long it_reserved_end;
 };
 
 #define IOMMU_TABLE_USERSPACE_ENTRY_RO(tbl, entry) \
@@ -162,8 +164,10 @@ extern int iommu_tce_table_put(struct iommu_table *tbl);
 /* Initializes an iommu_table based in values set in the passed-in
  * structure
  */
-extern struct iommu_table *iommu_init_table(struct iommu_table * tbl,
-					    int nid);
+extern struct iommu_table *iommu_init_table_res(struct iommu_table *tbl,
+		int nid, unsigned long res_start, unsigned long res_end);
+#define iommu_init_table(tbl, nid) iommu_init_table_res((tbl), (nid), 0, 0)
+
 #define IOMMU_TABLE_GROUP_MAX_TABLES	2
 
 struct iommu_table_group;
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 33bbd59cff79..209306ce7f4b 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -646,11 +646,43 @@ static void iommu_table_clear(struct iommu_table *tbl)
 #endif
 }
 
+static void iommu_table_reserve_pages(struct iommu_table *tbl)
+{
+	int i;
+
+	/*
+	 * Reserve page 0 so it will not be used for any mappings.
+	 * This avoids buggy drivers that consider page 0 to be invalid
+	 * to crash the machine or even lose data.
+	 */
+	if (tbl->it_offset == 0)
+		set_bit(0, tbl->it_map);
+
+	for (i = tbl->it_reserved_start; i < tbl->it_reserved_end; ++i)
+		set_bit(i, tbl->it_map);
+}
+
+static void iommu_table_release_pages(struct iommu_table *tbl)
+{
+	int i;
+
+	/*
+	 * In case we have reserved the first bit, we should not emit
+	 * the warning below.
+	 */
+	if (tbl->it_offset == 0)
+		clear_bit(0, tbl->it_map);
+
+	for (i = tbl->it_reserved_start; i < tbl->it_reserved_end; ++i)
+		clear_bit(i, tbl->it_map);
+}
+
 /*
  * Build a iommu_table structure.  This contains a bit map which
  * is used to manage allocation of the tce space.
  */
-struct iommu_table *iommu_init_table(struct iommu_table *tbl, int nid)
+struct iommu_table *iommu_init_table_res(struct iommu_table *tbl, int nid,
+		unsigned long res_start, unsigned long res_end)
 {
 	unsigned long sz;
 	static int welcomed = 0;
@@ -669,13 +701,9 @@ struct iommu_table *iommu_init_table(struct iommu_table *tbl, int nid)
 	tbl->it_map = page_address(page);
 	memset(tbl->it_map, 0, sz);
 
-	/*
-	 * Reserve page 0 so it will not be used for any mappings.
-	 * This avoids buggy drivers that consider page 0 to be invalid
-	 * to crash the machine or even lose data.
-	 */
-	if (tbl->it_offset == 0)
-		set_bit(0, tbl->it_map);
+	tbl->it_reserved_start = res_start;
+	tbl->it_reserved_end = res_end;
+	iommu_table_reserve_pages(tbl);
 
 	/* We only split the IOMMU table if we have 1GB or more of space */
 	if ((tbl->it_size << tbl->it_page_shift) >= (1UL * 1024 * 1024 * 1024))
@@ -727,12 +755,7 @@ static void iommu_table_free(struct kref *kref)
 		return;
 	}
 
-	/*
-	 * In case we have reserved the first bit, we should not emit
-	 * the warning below.
-	 */
-	if (tbl->it_offset == 0)
-		clear_bit(0, tbl->it_map);
+	iommu_table_release_pages(tbl);
 
 	/* verify that table contains no entries */
 	if (!bitmap_empty(tbl->it_map, tbl->it_size))
@@ -1037,8 +1060,7 @@ int iommu_take_ownership(struct iommu_table *tbl)
 	for (i = 0; i < tbl->nr_pools; i++)
 		spin_lock(&tbl->pools[i].lock);
 
-	if (tbl->it_offset == 0)
-		clear_bit(0, tbl->it_map);
+	iommu_table_reserve_pages(tbl);
 
 	if (!bitmap_empty(tbl->it_map, tbl->it_size)) {
 		pr_err("iommu_tce: it_map is not empty");
@@ -1068,9 +1090,7 @@ void iommu_release_ownership(struct iommu_table *tbl)
 
 	memset(tbl->it_map, 0, sz);
 
-	/* Restore bit#0 set by iommu_init_table() */
-	if (tbl->it_offset == 0)
-		set_bit(0, tbl->it_map);
+	iommu_table_release_pages(tbl);
 
 	for (i = 0; i < tbl->nr_pools; i++)
 		spin_unlock(&tbl->pools[i].lock);
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index dcfb5469678e..3eb755cf13d7 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2434,10 +2434,13 @@ static long pnv_pci_ioda2_setup_default_config(struct pnv_ioda_pe *pe)
 	 * DMA window can be larger than available memory, which will
 	 * cause errors later.
 	 */
-	const u64 window_size = min((u64)pe->table_group.tce32_size, max_memory);
+	const u64 maxblock = 1UL << (PAGE_SHIFT + MAX_ORDER - 1);
+	/* iommu_table::it_map uses 1 bit per IOMMU page, hence 8 */
+	const u64 window_size = min((maxblock * 8) << PAGE_SHIFT, max_memory);
+	unsigned long res_start = 0, res_end = 0;
 
 	rc = pnv_pci_ioda2_create_table(&pe->table_group, 0,
-			IOMMU_PAGE_SHIFT_4K,
+			PAGE_SHIFT,
 			window_size,
 			POWERNV_IOMMU_DEFAULT_LEVELS, false, &tbl);
 	if (rc) {
@@ -2446,7 +2449,12 @@ static long pnv_pci_ioda2_setup_default_config(struct pnv_ioda_pe *pe)
 		return rc;
 	}
 
-	iommu_init_table(tbl, pe->phb->hose->node);
+	/* We use top part of 32bit space for MMIO so exclude it from DMA */
+	if (window_size > pe->phb->ioda.m32_pci_base) {
+		res_start = pe->phb->ioda.m32_pci_base >> tbl->it_page_shift;
+		res_end = min(window_size, SZ_4G) >> tbl->it_page_shift;
+	}
+	iommu_init_table_res(tbl, pe->phb->hose->node, res_start, res_end);
 
 	rc = pnv_pci_ioda2_set_window(&pe->table_group, 0, tbl);
 	if (rc) {
-- 
2.17.1

