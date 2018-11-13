Return-Path: <SRS0=INWp=NY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF618C43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 09:01:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5488F22360
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 09:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5488F22360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42vM7d1SD5zF3Tl
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 20:01:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 42vLQS2CQJzF3FW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2018 19:29:35 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id C9583AE8035E;
 Tue, 13 Nov 2018 03:29:31 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v3 19/22] powerpc/powernv/npu: Add release_ownership
 hook
Date: Tue, 13 Nov 2018 19:28:20 +1100
Message-Id: <20181113082823.2440-20-aik@ozlabs.ru>
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

In order to make ATS work and translate addresses for arbitrary
LPID and PID, we need to program an NPU with LPID and allow PID wildcard
matching with a specific MSR mask.

This implements a helper to assign a GPU to LPAR and program the NPU
with a wildcard for PID and a helper to do clean-up. The helper takes
MSR (only DR/HV/PR/SF bits are allowed) to program them into NPU2 for
ATS checkout requests support.

This exports pnv_npu2_unmap_lpar_dev() as following patches will use it
from the VFIO driver.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/npu-dma.c | 47 ++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 2231f4c..48adaa5 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -289,6 +289,7 @@ static void pnv_npu_take_ownership(struct iommu_table_group *table_group)
 			table_group);
 	struct pnv_phb *phb = npe->phb;
 	int64_t rc;
+	struct pci_dev *gpdev = NULL;
 
 	/*
 	 * Note: NPU has just a single TVE in the hardware which means that
@@ -310,12 +311,28 @@ static void pnv_npu_take_ownership(struct iommu_table_group *table_group)
 		return;
 	}
 	pnv_pci_ioda2_tce_invalidate_entire(npe->phb, false);
+
+	get_gpu_pci_dev_and_pe(npe, &gpdev);
+	if (gpdev)
+		pnv_npu2_unmap_lpar_dev(gpdev);
+}
+
+static void pnv_npu_release_ownership(struct iommu_table_group *table_group)
+{
+	struct pnv_ioda_pe *npe = container_of(table_group, struct pnv_ioda_pe,
+			table_group);
+	struct pci_dev *gpdev = NULL;
+
+	get_gpu_pci_dev_and_pe(npe, &gpdev);
+	if (gpdev)
+		pnv_npu2_map_lpar_dev(gpdev, 0, MSR_DR | MSR_PR | MSR_HV);
 }
 
 static struct iommu_table_group_ops pnv_pci_npu_ops = {
 	.set_window = pnv_npu_set_window,
 	.unset_window = pnv_npu_unset_window,
 	.take_ownership = pnv_npu_take_ownership,
+	.release_ownership = pnv_npu_release_ownership,
 };
 #endif /* !CONFIG_IOMMU_API */
 
@@ -1239,3 +1256,33 @@ void pnv_npu2_map_lpar(struct pnv_ioda_pe *gpe, unsigned long msr)
 					ret);
 	}
 }
+
+int pnv_npu2_unmap_lpar_dev(struct pci_dev *gpdev)
+{
+	int ret;
+	struct pci_dev *npdev = pnv_pci_get_npu_dev(gpdev, 0);
+	struct pci_controller *hose = pci_bus_to_host(npdev->bus);
+	struct pnv_phb *nphb = hose->private_data;
+
+	dev_dbg(&gpdev->dev, "destroy context opalid=%llu\n",
+			nphb->opal_id);
+	ret = opal_npu_destroy_context(nphb->opal_id, 0/*__unused*/,
+			PCI_DEVID(gpdev->bus->number, gpdev->devfn));
+	if (ret < 0) {
+		dev_err(&gpdev->dev, "Failed to destroy context: %d\n", ret);
+		return ret;
+	}
+
+	/* Set LPID to 0 anyway, just to be safe */
+	dev_dbg(&gpdev->dev, "Map LPAR opalid=%llu lparid=0\n", nphb->opal_id);
+	ret = opal_npu_map_lpar(nphb->opal_id,
+			PCI_DEVID(gpdev->bus->number, gpdev->devfn), 0 /*LPID*/,
+			0 /* LPCR bits */);
+	if (ret)
+		dev_err(&gpdev->dev, "Error %d mapping device to LPAR\n", ret);
+
+	opal_purge_cache();
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pnv_npu2_unmap_lpar_dev);
-- 
2.17.1

