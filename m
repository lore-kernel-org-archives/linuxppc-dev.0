Return-Path: <SRS0=INWp=NY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6B2C43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 08:35:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A93E22507
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 08:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A93E22507
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42vLXt5x3pzF3Fk
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 19:35:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 42vLPY1ksQzF37r
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2018 19:28:48 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id A03FCAE800ED;
 Tue, 13 Nov 2018 03:28:44 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v3 05/22] powerpc/powernv/npu: Add helper to access
 struct npu for NPU device
Date: Tue, 13 Nov 2018 19:28:06 +1100
Message-Id: <20181113082823.2440-6-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113082823.2440-1-aik@ozlabs.ru>
References: <20181113082823.2440-1-aik@ozlabs.ru>
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
 Alex Williamson <alex.williamson@redhat.com>, kvm-ppc@vger.kernel.org,
 Sam Bobroff <sbobroff@linux.ibm.com>,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 =?UTF-8?q?Leonardo=20Augusto=20Guimar=C3=A3es=20Garcia?= <lagarcia@br.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This step is to help removing the npu struct from pnv_phb so it
can be used by pseries as well.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/platforms/powernv/npu-dma.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 91d488f..9f48831 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -327,6 +327,18 @@ struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe)
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
 
@@ -478,7 +490,6 @@ static void acquire_atsd_reg(struct npu_context *npu_context,
 	int i, j;
 	struct npu *npu;
 	struct pci_dev *npdev;
-	struct pnv_phb *nphb;
 
 	for (i = 0; i <= max_npu2_index; i++) {
 		mmio_atsd_reg[i].reg = -1;
@@ -493,8 +504,7 @@ static void acquire_atsd_reg(struct npu_context *npu_context,
 			if (!npdev)
 				continue;
 
-			nphb = pci_bus_to_host(npdev->bus)->private_data;
-			npu = &nphb->npu;
+			npu = npdev_to_npu(npdev);
 			mmio_atsd_reg[i].npu = npu;
 			mmio_atsd_reg[i].reg = get_mmio_atsd_reg(npu);
 			while (mmio_atsd_reg[i].reg < 0) {
@@ -690,7 +700,7 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
 	}
 
 	nphb = pci_bus_to_host(npdev->bus)->private_data;
-	npu = &nphb->npu;
+	npu = npdev_to_npu(npdev);
 
 	/*
 	 * Setup the NPU context table for a particular GPU. These need to be
@@ -764,7 +774,7 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
 	 */
 	WRITE_ONCE(npu_context->npdev[npu->index][nvlink_index], npdev);
 
-	if (!nphb->npu.nmmu_flush) {
+	if (!npu->nmmu_flush) {
 		/*
 		 * If we're not explicitly flushing ourselves we need to mark
 		 * the thread for global flushes
@@ -810,7 +820,7 @@ void pnv_npu2_destroy_context(struct npu_context *npu_context,
 		return;
 
 	nphb = pci_bus_to_host(npdev->bus)->private_data;
-	npu = &nphb->npu;
+	npu = npdev_to_npu(npdev);
 	nvlink_dn = of_parse_phandle(npdev->dev.of_node, "ibm,nvlink", 0);
 	if (WARN_ON(of_property_read_u32(nvlink_dn, "ibm,npu-link-index",
 							&nvlink_index)))
-- 
2.17.1

