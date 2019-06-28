Return-Path: <SRS0=ywKm=U3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A867C4321A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Jun 2019 06:54:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E2602070D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Jun 2019 06:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E2602070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45ZnZ3608szDqp7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Jun 2019 16:54:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 45ZnXM0yZgzDqk7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2019 16:53:06 +1000 (AEST)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 41744AE800AC;
 Fri, 28 Jun 2019 02:53:02 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel] powerpc/powernv: Fix stale iommu table base after VFIO
Date: Fri, 28 Jun 2019 16:53:00 +1000
Message-Id: <20190628065300.41674-1-aik@ozlabs.ru>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>, Sam Bobroff <sbobroff@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The powernv platform uses @dma_iommu_ops for non-bypass DMA. These ops
need an iommu_table pointer which is stored in
dev->archdata.iommu_table_base. It is initialized during
pcibios_setup_device() which handles boot time devices. However when
a device is taken from the system in order to pass it through, the default
IOMMU table is destroyed but the pointer in a device is not updated;
also when a device is returned back to the system, a new table pointer
is not stored in dev->archdata.iommu_table_base either. So when a just
returned device tries using IOMMU, it crashes on accessing stale
iommu_table or its members.

This calls set_iommu_table_base() when the default window is created.
Note it used to be there before but was wrongly removed (see "fixes").
It did not appear before as these days most devices simply use bypass.

This adds set_iommu_table_base(NULL) when a device is taken from
the system to make it clear that IOMMU DMA cannot be used past that point.

Fixes: c4e9d3c1e65a ("powerpc/powernv/pseries: Rework device adding to IOMMU groups")
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

This needs to be applied before
https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=110810
(discovered while testing this on POWER8)
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 10cc42b9e541..0f72c7484824 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2456,6 +2456,14 @@ static long pnv_pci_ioda2_setup_default_config(struct pnv_ioda_pe *pe)
 	if (!pnv_iommu_bypass_disabled)
 		pnv_pci_ioda2_set_bypass(pe, true);
 
+	/*
+	 * Set table base for the case of IOMMU DMA use. Usually this is done
+	 * from dma_dev_setup() which is not called when a device is returned
+	 * from VFIO so do it here.
+	 */
+	if (pe->pdev)
+		set_iommu_table_base(&pe->pdev->dev, tbl);
+
 	return 0;
 }
 
@@ -2543,6 +2551,8 @@ static void pnv_ioda2_take_ownership(struct iommu_table_group *table_group)
 	pnv_pci_ioda2_unset_window(&pe->table_group, 0);
 	if (pe->pbus)
 		pnv_ioda_setup_bus_dma(pe, pe->pbus);
+	else if (pe->pdev)
+		set_iommu_table_base(&pe->pdev->dev, NULL);
 	iommu_tce_table_put(tbl);
 }
 
-- 
2.17.1

