Return-Path: <SRS0=iwfG=PW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB3EC43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 00:57:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB6FB2063F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 00:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB6FB2063F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43dFSM5FVJzDqSD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 11:57:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 43dFQd2wqDzDqN5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2019 11:56:09 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id D2DEFAE80046;
 Sun, 13 Jan 2019 19:56:05 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel 1/2] powerpc/powernv/npu: Move compound PEs to powernv
Date: Mon, 14 Jan 2019 11:56:00 +1100
Message-Id: <20190114005601.1220-2-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190114005601.1220-1-aik@ozlabs.ru>
References: <20190114005601.1220-1-aik@ozlabs.ru>
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
 Alistair Popple <alistair@popple.id.au>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

We are going to move NPU code shared among pseries and powernv into sysdev.

This prepares the move by moving compound PEs from the npu struct
(which is going to move to sysdev) to powernv's phb struct as
pseries does not need this. This makes npucomp a pointer instead of
embedding it to the pnv_ohb struct so we can still have the definition of
it in npu-dma.c (the only place which uses it) and save some bytes when
there is no NPU.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci.h     |  4 ++++
 arch/powerpc/platforms/powernv/npu-dma.c | 10 +++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 8e36da3..8eb1cad 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -62,6 +62,7 @@ struct pnv_ioda_pe {
 
 	/* "Base" iommu table, ie, 4K TCEs, 32-bit DMA */
 	struct iommu_table_group table_group;
+	/* Compound PE for P8/NPU */
 	struct npu_comp		*npucomp;
 
 	/* 64-bit TCE bypass region */
@@ -173,6 +174,9 @@ struct pnv_phb {
 	u8			*diag_data;
 
 	int p2p_target_count;
+
+	/* Compound PE for P9/NPU2 */
+	struct npu_comp *npucomp;
 };
 
 extern struct pci_ops pnv_pci_ops;
diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 2ca7982..c7cd259 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -370,8 +370,6 @@ struct npu {
 
 	/* Do we need to explicitly flush the nest mmu? */
 	bool nmmu_flush;
-
-	struct npu_comp npucomp;
 };
 
 #ifdef CONFIG_IOMMU_API
@@ -535,6 +533,7 @@ struct iommu_table_group *pnv_try_setup_npu_table_group(struct pnv_ioda_pe *pe)
 	struct npu_comp *npucomp;
 	struct pci_dev *gpdev = NULL;
 	struct pci_controller *hose;
+	struct pnv_phb *phb;
 	struct pci_dev *npdev = NULL;
 
 	list_for_each_entry(gpdev, &pe->pbus->devices, bus_list) {
@@ -548,9 +547,14 @@ struct iommu_table_group *pnv_try_setup_npu_table_group(struct pnv_ioda_pe *pe)
 		return NULL;
 
 	hose = pci_bus_to_host(npdev->bus);
+	phb = hose->private_data;
 
 	if (hose->npu) {
-		table_group = &hose->npu->npucomp.table_group;
+		if (!phb->npucomp) {
+			phb->npucomp = kzalloc(sizeof(struct npu_comp),
+					GFP_KERNEL);
+		}
+		table_group = &phb->npucomp->table_group;
 
 		if (!table_group->group) {
 			table_group->ops = &pnv_npu_peers_ops;
-- 
2.17.1

