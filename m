Return-Path: <SRS0=2g3y=OW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6828C65BAE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 06:59:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A05A2080F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 06:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A05A2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Fl0d0RLdzDqWs
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 17:59:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 43Fk5v5kH3zDqcd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2018 17:18:59 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 8A395AE80549;
 Thu, 13 Dec 2018 01:18:25 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v5 12/20] powerpc/powernv/npu: Move single TVE handling
 to NPU PE
Date: Thu, 13 Dec 2018 17:17:26 +1100
Message-Id: <20181213061734.16651-13-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181213061734.16651-1-aik@ozlabs.ru>
References: <20181213061734.16651-1-aik@ozlabs.ru>
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
Cc: Jose Ricardo Ziviani <joserz@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Alistair Popple <alistair@popple.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm-ppc@vger.kernel.org,
 Sam Bobroff <sbobroff@linux.ibm.com>,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 =?UTF-8?q?Leonardo=20Augusto=20Guimar=C3=A3es=20Garcia?= <lagarcia@br.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Normal PCI PEs have 2 TVEs, one per a DMA window; however NPU PE has only
one which points to one of two tables of the corresponding PCI PE.

So whenever a new DMA window is programmed to PEs, the NPU PE needs to
release old table in order to use the new one.

Commit d41ce7b1bcc3e ("powerpc/powernv/npu: Do not try invalidating 32bit
table when 64bit table is enabled") did just that but in pci-ioda.c
while it actually belongs to npu-dma.c.

This moves the single TVE handling to npu-dma.c. This does not implement
restoring though as it is highly unlikely that we can set the table to
PCI PE and cannot to NPU PE and if that fails, we could only set 32bit
table to NPU PE and this configuration is not really supported or wanted.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/npu-dma.c  |  8 +++++++
 arch/powerpc/platforms/powernv/pci-ioda.c | 27 +++--------------------
 2 files changed, 11 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index ef1457f..26063fb 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -130,6 +130,11 @@ long pnv_npu_set_window(struct pnv_ioda_pe *npe, int num,
 		tbl->it_level_size : tbl->it_size;
 	const __u64 start_addr = tbl->it_offset << tbl->it_page_shift;
 	const __u64 win_size = tbl->it_size << tbl->it_page_shift;
+	int num2 = (num == 0) ? 1 : 0;
+
+	/* NPU has just one TVE so if there is another table, remove it first */
+	if (npe->table_group.tables[num2])
+		pnv_npu_unset_window(npe, num2);
 
 	pe_info(npe, "Setting up window %llx..%llx pg=%lx\n",
 			start_addr, start_addr + win_size - 1,
@@ -160,6 +165,9 @@ long pnv_npu_unset_window(struct pnv_ioda_pe *npe, int num)
 	struct pnv_phb *phb = npe->phb;
 	int64_t rc;
 
+	if (!npe->table_group.tables[num])
+		return 0;
+
 	pe_info(npe, "Removing DMA window\n");
 
 	rc = opal_pci_map_pe_dma_window(phb->opal_id, npe->pe_number,
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index d6b140f..3f998bd 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2669,23 +2669,14 @@ static struct pnv_ioda_pe *gpe_table_group_to_npe(
 static long pnv_pci_ioda2_npu_set_window(struct iommu_table_group *table_group,
 		int num, struct iommu_table *tbl)
 {
-	struct pnv_ioda_pe *npe = gpe_table_group_to_npe(table_group);
-	int num2 = (num == 0) ? 1 : 0;
 	long ret = pnv_pci_ioda2_set_window(table_group, num, tbl);
 
 	if (ret)
 		return ret;
 
-	if (table_group->tables[num2])
-		pnv_npu_unset_window(npe, num2);
-
-	ret = pnv_npu_set_window(npe, num, tbl);
-	if (ret) {
+	ret = pnv_npu_set_window(gpe_table_group_to_npe(table_group), num, tbl);
+	if (ret)
 		pnv_pci_ioda2_unset_window(table_group, num);
-		if (table_group->tables[num2])
-			pnv_npu_set_window(npe, num2,
-					table_group->tables[num2]);
-	}
 
 	return ret;
 }
@@ -2694,24 +2685,12 @@ static long pnv_pci_ioda2_npu_unset_window(
 		struct iommu_table_group *table_group,
 		int num)
 {
-	struct pnv_ioda_pe *npe = gpe_table_group_to_npe(table_group);
-	int num2 = (num == 0) ? 1 : 0;
 	long ret = pnv_pci_ioda2_unset_window(table_group, num);
 
 	if (ret)
 		return ret;
 
-	if (!npe->table_group.tables[num])
-		return 0;
-
-	ret = pnv_npu_unset_window(npe, num);
-	if (ret)
-		return ret;
-
-	if (table_group->tables[num2])
-		ret = pnv_npu_set_window(npe, num2, table_group->tables[num2]);
-
-	return ret;
+	return pnv_npu_unset_window(gpe_table_group_to_npe(table_group), num);
 }
 
 static void pnv_ioda2_npu_take_ownership(struct iommu_table_group *table_group)
-- 
2.17.1

