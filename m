Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EA0C7112B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 09:38:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3800C205C9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 09:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3800C205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YYK62J6YzF3HF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 20:38:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 42YYC84ggyzDr1F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 20:33:08 +1100 (AEDT)
Received: from vpl1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 79DD3AE807EB;
 Mon, 15 Oct 2018 05:33:05 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel 1/5] powerpc/powernv/npu: Add helper to access struct
 npu for NPU device
Date: Mon, 15 Oct 2018 20:32:57 +1100
Message-Id: <20181015093301.1007-2-aik@ozlabs.ru>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181015093301.1007-1-aik@ozlabs.ru>
References: <20181015093301.1007-1-aik@ozlabs.ru>
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
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm-ppc@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This step is to help removing the npu struct from pnv_phb so it
can be used by pseries as well.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/npu-dma.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 3a5c4ed..13e5153 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -389,6 +389,18 @@ struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe)
 	return gpe;
 }
 
+/*
+ * NPU2 ATS
+ */
+static struct npu *npdev_to_npu(struct pci_dev *npdev)
+{
+	struct pnv_phb *nphb;
+
+	nphb = pci_bus_to_host(npdev->bus)->private_data;
+
+	return &nphb->npu;
+}
+
 /* Maximum number of nvlinks per npu */
 #define NV_MAX_LINKS 6
 
@@ -546,7 +558,6 @@ static void acquire_atsd_reg(struct npu_context *npu_context,
 	int i, j;
 	struct npu *npu;
 	struct pci_dev *npdev;
-	struct pnv_phb *nphb;
 
 	for (i = 0; i <= max_npu2_index; i++) {
 		mmio_atsd_reg[i].reg = -1;
@@ -561,8 +572,7 @@ static void acquire_atsd_reg(struct npu_context *npu_context,
 			if (!npdev)
 				continue;
 
-			nphb = pci_bus_to_host(npdev->bus)->private_data;
-			npu = &nphb->npu;
+			npu = npdev_to_npu(npdev);
 			mmio_atsd_reg[i].npu = npu;
 			mmio_atsd_reg[i].reg = get_mmio_atsd_reg(npu);
 			while (mmio_atsd_reg[i].reg < 0) {
@@ -749,7 +759,7 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
 	}
 
 	nphb = pci_bus_to_host(npdev->bus)->private_data;
-	npu = &nphb->npu;
+	npu = npdev_to_npu(npdev);
 
 	/*
 	 * Setup the NPU context table for a particular GPU. These need to be
@@ -869,7 +879,7 @@ void pnv_npu2_destroy_context(struct npu_context *npu_context,
 		return;
 
 	nphb = pci_bus_to_host(npdev->bus)->private_data;
-	npu = &nphb->npu;
+	npu = npdev_to_npu(npdev);
 	nvlink_dn = of_parse_phandle(npdev->dev.of_node, "ibm,nvlink", 0);
 	if (WARN_ON(of_property_read_u32(nvlink_dn, "ibm,npu-link-index",
 							&nvlink_index)))
-- 
2.11.0

