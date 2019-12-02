Return-Path: <SRS0=Td3a=ZY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F55FC432C0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Dec 2019 02:13:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25D96206E4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Dec 2019 02:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D96206E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47R7vM19hpzDqQt
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Dec 2019 13:13:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.ru (client-ip=107.174.27.60; helo=ozlabs.ru;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (unknown [107.174.27.60])
 by lists.ozlabs.org (Postfix) with ESMTP id 47R7pq0Yg0zDqJB
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Dec 2019 13:09:38 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 9504AAE8010F;
 Sun,  1 Dec 2019 20:58:56 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel RFC 1/4] powerpc/powernv/ioda: Rework for huge DMA
 window at 4GB
Date: Mon,  2 Dec 2019 12:59:50 +1100
Message-Id: <20191202015953.127902-2-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191202015953.127902-1-aik@ozlabs.ru>
References: <20191202015953.127902-1-aik@ozlabs.ru>
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
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>,
 Alex Williamson <alex.williamson@redhat.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This moves code to make the next patches look simpler. In particular:

1. Separate locals declaration as we will be allocating a smaller DMA
window if a TVE1_4GB option (allows a huge DMA windows at 4GB) is enabled;

2. Pass the bypass offset directly to pnv_pci_ioda2_create_table()
as it is the only information needed from @pe;

3. Use PAGE_SHIFT for it_map allocation estimate and @tceshift for
the IOMMU page size; this makes the distinction clear and allows
easy switching between different IOMMU page size.

These changes should not cause behavioral change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

I really need 1), 2) makes the code less dependent on the PE struct member
value (==easier to follow), 3) is to enable 2MB quickly for the default
DMA window for debugging/performance testing.
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 38 ++++++++++++-----------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 9e55bd9d7ecd..328fb27a966f 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2349,15 +2349,10 @@ static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable)
 		pe->tce_bypass_enabled = enable;
 }
 
-static long pnv_pci_ioda2_create_table(struct iommu_table_group *table_group,
-		int num, __u32 page_shift, __u64 window_size, __u32 levels,
+static long pnv_pci_ioda2_create_table(int nid, int num, __u64 bus_offset,
+		__u32 page_shift, __u64 window_size, __u32 levels,
 		bool alloc_userspace_copy, struct iommu_table **ptbl)
 {
-	struct pnv_ioda_pe *pe = container_of(table_group, struct pnv_ioda_pe,
-			table_group);
-	int nid = pe->phb->hose->node;
-	__u64 bus_offset = num ?
-		pe->table_group.tce64_start : table_group->tce32_start;
 	long ret;
 	struct iommu_table *tbl;
 
@@ -2384,21 +2379,23 @@ static long pnv_pci_ioda2_setup_default_config(struct pnv_ioda_pe *pe)
 {
 	struct iommu_table *tbl = NULL;
 	long rc;
-	unsigned long res_start, res_end;
+	u64 max_memory, maxblock, window_size;
+	const unsigned int tceshift = PAGE_SHIFT;
+	unsigned long res_start, res_end, tces_order, tcelevel_order, levels;
 
 	/*
 	 * crashkernel= specifies the kdump kernel's maximum memory at
 	 * some offset and there is no guaranteed the result is a power
 	 * of 2, which will cause errors later.
 	 */
-	const u64 max_memory = __rounddown_pow_of_two(memory_hotplug_max());
+	max_memory = __rounddown_pow_of_two(memory_hotplug_max());
 
 	/*
 	 * In memory constrained environments, e.g. kdump kernel, the
 	 * DMA window can be larger than available memory, which will
 	 * cause errors later.
 	 */
-	const u64 maxblock = 1UL << (PAGE_SHIFT + MAX_ORDER - 1);
+	maxblock = 1UL << (PAGE_SHIFT + MAX_ORDER - 1);
 
 	/*
 	 * We create the default window as big as we can. The constraint is
@@ -2408,11 +2405,11 @@ static long pnv_pci_ioda2_setup_default_config(struct pnv_ioda_pe *pe)
 	 * to support crippled devices (i.e. not fully 64bit DMAble) only.
 	 */
 	/* iommu_table::it_map uses 1 bit per IOMMU page, hence 8 */
-	const u64 window_size = min((maxblock * 8) << PAGE_SHIFT, max_memory);
+	window_size = min((maxblock * 8) << tceshift, max_memory);
 	/* Each TCE level cannot exceed maxblock so go multilevel if needed */
-	unsigned long tces_order = ilog2(window_size >> PAGE_SHIFT);
-	unsigned long tcelevel_order = ilog2(maxblock >> 3);
-	unsigned int levels = tces_order / tcelevel_order;
+	tces_order = ilog2(window_size >> tceshift);
+	tcelevel_order = ilog2(maxblock >> 3);
+	levels = tces_order / tcelevel_order;
 
 	if (tces_order % tcelevel_order)
 		levels += 1;
@@ -2422,8 +2419,8 @@ static long pnv_pci_ioda2_setup_default_config(struct pnv_ioda_pe *pe)
 	 */
 	levels = max_t(unsigned int, levels, POWERNV_IOMMU_DEFAULT_LEVELS);
 
-	rc = pnv_pci_ioda2_create_table(&pe->table_group, 0, PAGE_SHIFT,
-			window_size, levels, false, &tbl);
+	rc = pnv_pci_ioda2_create_table(pe->phb->hose->node,
+			0, 0, tceshift, window_size, levels, false, &tbl);
 	if (rc) {
 		pe_err(pe, "Failed to create 32-bit TCE table, err %ld",
 				rc);
@@ -2525,8 +2522,13 @@ static long pnv_pci_ioda2_create_table_userspace(
 		int num, __u32 page_shift, __u64 window_size, __u32 levels,
 		struct iommu_table **ptbl)
 {
-	long ret = pnv_pci_ioda2_create_table(table_group,
-			num, page_shift, window_size, levels, true, ptbl);
+	struct pnv_ioda_pe *pe = container_of(table_group, struct pnv_ioda_pe,
+			table_group);
+	__u64 bus_offset = num ?
+		pe->table_group.tce64_start : table_group->tce32_start;
+	long ret = pnv_pci_ioda2_create_table(pe->phb->hose->node,
+			num, bus_offset, page_shift, window_size, levels, true,
+			ptbl);
 
 	if (!ret)
 		(*ptbl)->it_allocated_size = pnv_pci_ioda2_get_table_size(
-- 
2.17.1

