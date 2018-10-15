Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D7EC7112B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 09:40:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A33D8205C9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 09:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A33D8205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YYMB08d7zF3Df
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 20:40:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 42YYCK5n3TzF3Dj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 20:33:17 +1100 (AEDT)
Received: from vpl1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id D8F6DAE807F3;
 Mon, 15 Oct 2018 05:33:14 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel 5/5] powerpc/powernv/npu: Add helper to map GPU to LPAR
Date: Mon, 15 Oct 2018 20:33:01 +1100
Message-Id: <20181015093301.1007-6-aik@ozlabs.ru>
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

In order to make ATS work and translate addresses for arbitrary
LPID and PID, we need to program an NPU with these.

This implements a helper to assign a GPU to LPAR and program the NPU
with a wildcard for PID. The helper also takes MSR (only DR/HV/PR/SF bits
are allowed) to program them into NPU2 for ATS checkout requests.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/pci.h           |  2 ++
 arch/powerpc/platforms/powernv/npu-dma.c | 38 ++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index f196df6..c3c9728 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -131,5 +131,7 @@ extern struct pci_dev *pnv_pci_get_gpu_dev(struct pci_dev *npdev);
 extern struct pci_dev *pnv_pci_get_npu_dev(struct pci_dev *gpdev, int index);
 extern void pnv_npu2_devices_init(void);
 extern int pnv_npu2_init(struct pci_controller *hose);
+extern int pnv_npu2_map_lpar_dev(struct pci_controller *hose,
+		struct pci_dev *gpdev, unsigned int lparid, unsigned long msr);
 
 #endif /* __ASM_POWERPC_PCI_H */
diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 677f30a..1dde753 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -1047,3 +1047,41 @@ void pnv_npu2_map_lpar_phb(struct pnv_phb *nphb, unsigned long msr)
 		dev_err(&gpdev->dev, "Failed to init context: %d\n", ret);
 	}
 }
+
+int pnv_npu2_map_lpar_dev(struct pci_controller *hose, struct pci_dev *gpdev,
+		unsigned int lparid, unsigned long msr)
+{
+	int ret;
+	struct pnv_phb *nphb = hose->private_data;
+
+	dev_dbg(&gpdev->dev, "Map LPAR opalid=%llu lparid=%u\n",
+			nphb->opal_id, lparid);
+	/*
+	 * Currently we only support radix and non-zero LPCR only makes sense
+	 * for hash tables so skiboot expects the LPCR parameter to be a zero.
+	 */
+	ret = opal_npu_map_lpar(nphb->opal_id,
+			PCI_DEVID(gpdev->bus->number, gpdev->devfn), lparid,
+			0 /* LPCR bits */);
+	if (ret) {
+		dev_err(&gpdev->dev, "Error %d mapping device to LPAR\n", ret);
+		return ret;
+	}
+
+	dev_dbg(&gpdev->dev, "destroy context opalid=%llu msr=%lx\n",
+			nphb->opal_id, msr);
+	ret = opal_npu_destroy_context(nphb->opal_id, 0/*__unused*/,
+			PCI_DEVID(gpdev->bus->number, gpdev->devfn));
+	if (ret)
+		dev_err(&gpdev->dev, "Failed to destroy context: %d\n", ret);
+
+	dev_dbg(&gpdev->dev, "init context opalid=%llu msr=%lx\n",
+			nphb->opal_id, msr);
+	ret = opal_npu_init_context(nphb->opal_id, 0/*__unused*/, msr,
+			PCI_DEVID(gpdev->bus->number, gpdev->devfn));
+	if (ret)
+		dev_err(&gpdev->dev, "Failed to init context: %d\n", ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pnv_npu2_map_lpar_dev);
-- 
2.11.0

