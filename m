Return-Path: <SRS0=INWp=NY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8941C43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 08:46:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43E6320854
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 08:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E6320854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42vLp31XpnzF3Gq
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 19:46:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 42vLQ01mYnzF3Kf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2018 19:29:12 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 5ACC0AE80219;
 Tue, 13 Nov 2018 03:29:08 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v3 12/22] powerpc/pseries: Remove IOMMU API support for
 non-LPAR systems
Date: Tue, 13 Nov 2018 19:28:13 +1100
Message-Id: <20181113082823.2440-13-aik@ozlabs.ru>
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

The pci_dma_bus_setup_pSeries and pci_dma_dev_setup_pSeries hooks are
registered for the pseries platform which does not have FW_FEATURE_LPAR;
these would be pre-powernv platforms which we never supported PCI pass
through for anyway so remove it.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---

Propably should remove all pseries-but-not-lpar code.
---
 arch/powerpc/platforms/pseries/iommu.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index f818737..b045f28 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -648,7 +648,6 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
 	iommu_table_setparms(pci->phb, dn, tbl);
 	tbl->it_ops = &iommu_table_pseries_ops;
 	iommu_init_table(tbl, pci->phb->node);
-	iommu_register_group(pci->table_group, pci_domain_nr(bus), 0);
 
 	/* Divide the rest (1.75GB) among the children */
 	pci->phb->dma_window_size = 0x80000000ul;
@@ -759,10 +758,7 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev *dev)
 		iommu_table_setparms(phb, dn, tbl);
 		tbl->it_ops = &iommu_table_pseries_ops;
 		iommu_init_table(tbl, phb->node);
-		iommu_register_group(PCI_DN(dn)->table_group,
-				pci_domain_nr(phb->bus), 0);
 		set_iommu_table_base(&dev->dev, tbl);
-		iommu_add_device(&dev->dev);
 		return;
 	}
 
@@ -773,11 +769,10 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev *dev)
 	while (dn && PCI_DN(dn) && PCI_DN(dn)->table_group == NULL)
 		dn = dn->parent;
 
-	if (dn && PCI_DN(dn)) {
+	if (dn && PCI_DN(dn))
 		set_iommu_table_base(&dev->dev,
 				PCI_DN(dn)->table_group->tables[0]);
-		iommu_add_device(&dev->dev);
-	} else
+	else
 		printk(KERN_WARNING "iommu: Device %s has no iommu table\n",
 		       pci_name(dev));
 }
-- 
2.17.1

