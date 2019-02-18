Return-Path: <SRS0=Hg4A=QZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099C1C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 06:00:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1D0C218B0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 06:00:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D0C218B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 442tW82RtkzDqKg
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 17:00:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 442tTR54bmzDqKK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2019 16:58:35 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id A9171AE80023;
 Mon, 18 Feb 2019 00:58:02 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel] powerpc/powernv/sriov: Register IOMMU groups for VFs
Date: Mon, 18 Feb 2019 16:58:01 +1100
Message-Id: <20190218055801.35165-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
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

The compound IOMMU group rework moved iommu_register_group() together in
pnv_pci_ioda_setup_iommu_api() (which is a part of ppc_md.pcibios_fixup).
As the result, pnv_ioda_setup_bus_iommu_group() does not create groups
any more, it only adds devices to groups.

This works fine for boot time devices. However IOMMU groups for SRIOV's
VFs were added by pnv_ioda_setup_bus_iommu_group() so this got broken:
pnv_tce_iommu_bus_notifier() expects a group to be registered for VF
and it is not.

This adds missing group registration and adds a NULL pointer check into
the bus notifier so we won't stop in xmon if there is no group, although
it is not expected to happen now.

Fixes: 0bd971676e68 "powerpc/powernv/npu: Add compound IOMMU groups"
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

Fixes https://bugzilla.linux.ibm.com/show_bug.cgi?id=175550
"Kernel Oops while creating SRIOV VF's."


---
 arch/powerpc/platforms/powernv/pci-ioda.c | 2 ++
 arch/powerpc/platforms/powernv/pci.c      | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 7db3119..145373f 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1593,6 +1593,8 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
 
 		pnv_pci_ioda2_setup_dma_pe(phb, pe);
 #ifdef CONFIG_IOMMU_API
+		iommu_register_group(&pe->table_group,
+				pe->phb->hose->global_number, pe->pe_number);
 		pnv_ioda_setup_bus_iommu_group(pe, &pe->table_group, NULL);
 #endif
 	}
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 45fb70b..ef9448a 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -1147,6 +1147,8 @@ static int pnv_tce_iommu_bus_notifier(struct notifier_block *nb,
 			return 0;
 
 		pe = &phb->ioda.pe_array[pdn->pe_number];
+		if (!pe->table_group.group)
+			return 0;
 		iommu_add_device(&pe->table_group, dev);
 		return 0;
 	case BUS_NOTIFY_DEL_DEVICE:
-- 
2.17.1

