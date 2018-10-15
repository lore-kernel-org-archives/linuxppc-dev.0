Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD19C04AA5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 10:10:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5153820652
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 10:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5153820652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YZ2W23tqzF3Mq
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 21:10:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 42YZ0G3xNQzF3DQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 21:08:46 +1100 (AEDT)
Received: from vpl1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 1E1E3AE807FE;
 Mon, 15 Oct 2018 06:08:42 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v2] KVM: PPC: Optimize clearing TCEs for sparse tables
Date: Mon, 15 Oct 2018 21:08:41 +1100
Message-Id: <20181015100841.33267-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.11.0
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, kvm-ppc@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The powernv platform maintains 2 TCE tables for VFIO - a hardware TCE
table and a table with userspace addresses. These tables are radix trees,
we allocate indirect levels when they are written to. Since
the memory allocation is problematic in real mode, we have 2 accessors
to the entries:
- for virtual mode: it allocates the memory and it is always expected
to return non-NULL;
- fr real mode: it does not allocate and can return NULL.

Also, DMA windows can span to up to 55 bits of the address space and since
we never have this much RAM, such windows are sparse. However currently
the SPAPR TCE IOMMU driver walks through all TCEs to unpin DMA memory.

Since we maintain a userspace addresses table for VFIO which is a mirror
of the hardware table, we can use it to know which parts of the DMA
window have not been mapped and skip these so does this patch.

The bare metal systems do not have this problem as they use a bypass mode
of a PHB which maps RAM directly.

This helps a lot with sparse DMA windows, reducing the shutdown time from
about 3 minutes per 1 billion TCEs to a few seconds for 32GB sparse guest.
Just skipping the last level seems to be good enough.

As non-allocating accessor is used now in virtual mode as well, rename it
from IOMMU_TABLE_USERSPACE_ENTRY_RM (real mode) to _RO (read only).

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v2:
* instead of adding the level size to @entry, now we align the entry
to the beginning of next chunk of the level, ie
"entry += tbl->it_level_size - 1" became "entry |= tbl->it_level_size - 1"
---
 arch/powerpc/include/asm/iommu.h    |  2 +-
 arch/powerpc/kvm/book3s_64_vio.c    |  5 ++---
 arch/powerpc/kvm/book3s_64_vio_hv.c |  6 +++---
 drivers/vfio/vfio_iommu_spapr_tce.c | 23 +++++++++++++++++++++--
 4 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 3d4b88c..35db0cb 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -126,7 +126,7 @@ struct iommu_table {
 	int it_nid;
 };
 
-#define IOMMU_TABLE_USERSPACE_ENTRY_RM(tbl, entry) \
+#define IOMMU_TABLE_USERSPACE_ENTRY_RO(tbl, entry) \
 		((tbl)->it_ops->useraddrptr((tbl), (entry), false))
 #define IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry) \
 		((tbl)->it_ops->useraddrptr((tbl), (entry), true))
diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index c0c64d1..62a8d03 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -410,11 +410,10 @@ static long kvmppc_tce_iommu_mapped_dec(struct kvm *kvm,
 {
 	struct mm_iommu_table_group_mem_t *mem = NULL;
 	const unsigned long pgsize = 1ULL << tbl->it_page_shift;
-	__be64 *pua = IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
+	__be64 *pua = IOMMU_TABLE_USERSPACE_ENTRY_RO(tbl, entry);
 
 	if (!pua)
-		/* it_userspace allocation might be delayed */
-		return H_TOO_HARD;
+		return H_SUCCESS;
 
 	mem = mm_iommu_lookup(kvm->mm, be64_to_cpu(*pua), pgsize);
 	if (!mem)
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index ec99363..2206bc7 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -214,7 +214,7 @@ static long iommu_tce_xchg_rm(struct mm_struct *mm, struct iommu_table *tbl,
 
 	if (!ret && ((*direction == DMA_FROM_DEVICE) ||
 				(*direction == DMA_BIDIRECTIONAL))) {
-		__be64 *pua = IOMMU_TABLE_USERSPACE_ENTRY_RM(tbl, entry);
+		__be64 *pua = IOMMU_TABLE_USERSPACE_ENTRY_RO(tbl, entry);
 		/*
 		 * kvmppc_rm_tce_iommu_do_map() updates the UA cache after
 		 * calling this so we still get here a valid UA.
@@ -240,7 +240,7 @@ static long kvmppc_rm_tce_iommu_mapped_dec(struct kvm *kvm,
 {
 	struct mm_iommu_table_group_mem_t *mem = NULL;
 	const unsigned long pgsize = 1ULL << tbl->it_page_shift;
-	__be64 *pua = IOMMU_TABLE_USERSPACE_ENTRY_RM(tbl, entry);
+	__be64 *pua = IOMMU_TABLE_USERSPACE_ENTRY_RO(tbl, entry);
 
 	if (!pua)
 		/* it_userspace allocation might be delayed */
@@ -304,7 +304,7 @@ static long kvmppc_rm_tce_iommu_do_map(struct kvm *kvm, struct iommu_table *tbl,
 {
 	long ret;
 	unsigned long hpa = 0;
-	__be64 *pua = IOMMU_TABLE_USERSPACE_ENTRY_RM(tbl, entry);
+	__be64 *pua = IOMMU_TABLE_USERSPACE_ENTRY_RO(tbl, entry);
 	struct mm_iommu_table_group_mem_t *mem;
 
 	if (!pua)
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 96721b1..b30926e 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -444,7 +444,7 @@ static void tce_iommu_unuse_page_v2(struct tce_container *container,
 	struct mm_iommu_table_group_mem_t *mem = NULL;
 	int ret;
 	unsigned long hpa = 0;
-	__be64 *pua = IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
+	__be64 *pua = IOMMU_TABLE_USERSPACE_ENTRY_RO(tbl, entry);
 
 	if (!pua)
 		return;
@@ -467,8 +467,27 @@ static int tce_iommu_clear(struct tce_container *container,
 	unsigned long oldhpa;
 	long ret;
 	enum dma_data_direction direction;
+	unsigned long lastentry = entry + pages;
+
+	for ( ; entry < lastentry; ++entry) {
+		if (tbl->it_indirect_levels && tbl->it_userspace) {
+			/*
+			 * For multilevel tables, we can take a shortcut here
+			 * and skip some TCEs as we know that the userspace
+			 * addresses cache is a mirror of the real TCE table
+			 * and if it is missing some indirect levels, then
+			 * the hardware table does not have them allocated
+			 * either and therefore does not require updating.
+			 */
+			__be64 *pua = IOMMU_TABLE_USERSPACE_ENTRY_RO(tbl,
+					entry);
+			if (!pua) {
+				/* align to level_size which is power of two */
+				entry |= tbl->it_level_size - 1;
+				continue;
+			}
+		}
 
-	for ( ; pages; --pages, ++entry) {
 		cond_resched();
 
 		direction = DMA_NONE;
-- 
2.11.0

