Return-Path: <SRS0=n2Bs=OC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC115C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 06:08:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 255FA20672
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 06:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 255FA20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 431QqM6MW9zDqWy
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 17:08:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 431QV43h6mzDqSx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2018 16:53:48 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id A612FAE80053;
 Fri, 23 Nov 2018 00:53:13 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v4 01/19] powerpc/ioda/npu: Call skiboot's hot reset
 hook when disabling NPU2
Date: Fri, 23 Nov 2018 16:52:46 +1100
Message-Id: <20181123055304.25116-2-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181123055304.25116-1-aik@ozlabs.ru>
References: <20181123055304.25116-1-aik@ozlabs.ru>
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
 Oliver O'Halloran <oohall@gmail.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 =?UTF-8?q?Leonardo=20Augusto=20Guimar=C3=A3es=20Garcia?= <lagarcia@br.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The skiboot firmware has a hot reset handler which fences the NVIDIA V100
GPU RAM on Witherspoons and makes accesses no-op instead of throwing HMIs:
https://github.com/open-power/skiboot/commit/fca2b2b839a67

Now we are going to pass V100 via VFIO which most certainly involves
KVM guests which are often terminated without getting a chance to offline
GPU RAM so we end up with a running machine with misconfigured memory.
Accessing this memory produces hardware management interrupts (HMI)
which bring the host down.

To suppress HMIs, this wires up this hot reset hook to vfio_pci_disable()
via pci_disable_device() which switches NPU2 to a safe mode and prevents
HMIs.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Acked-by: Alistair Popple <alistair@popple.id.au>
---
Changes:
v2:
* updated the commit log
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 9ee7a30..29c6837 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3676,6 +3676,15 @@ static void pnv_pci_release_device(struct pci_dev *pdev)
 		pnv_ioda_release_pe(pe);
 }
 
+static void pnv_npu_disable_device(struct pci_dev *pdev)
+{
+	struct eeh_dev *edev = pci_dev_to_eeh_dev(pdev);
+	struct eeh_pe *eehpe = edev ? edev->pe : NULL;
+
+	if (eehpe && eeh_ops && eeh_ops->reset)
+		eeh_ops->reset(eehpe, EEH_RESET_HOT);
+}
+
 static void pnv_pci_ioda_shutdown(struct pci_controller *hose)
 {
 	struct pnv_phb *phb = hose->private_data;
@@ -3720,6 +3729,7 @@ static const struct pci_controller_ops pnv_npu_ioda_controller_ops = {
 	.reset_secondary_bus	= pnv_pci_reset_secondary_bus,
 	.dma_set_mask		= pnv_npu_dma_set_mask,
 	.shutdown		= pnv_pci_ioda_shutdown,
+	.disable_device		= pnv_npu_disable_device,
 };
 
 static const struct pci_controller_ops pnv_npu_ocapi_ioda_controller_ops = {
-- 
2.17.1

