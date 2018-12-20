Return-Path: <SRS0=vnEJ=O5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DE4C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 08:36:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D180F21720
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 08:36:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D180F21720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43L4pn0P2qzDr0P
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 19:36:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 43L4YR1DKFzDqv4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2018 19:24:27 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id DAA7EAE802FB;
 Thu, 20 Dec 2018 03:24:22 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v7 08/20] powerpc/pseries: Remove IOMMU API support for
 non-LPAR systems
Date: Thu, 20 Dec 2018 19:23:38 +1100
Message-Id: <20181220082350.58113-9-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181220082350.58113-1-aik@ozlabs.ru>
References: <20181220082350.58113-1-aik@ozlabs.ru>
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
Cc: Christoph Hellwig <hch@infradead.org>,
 Jose Ricardo Ziviani <joserz@linux.ibm.com>, kvm@vger.kernel.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Alistair Popple <alistair@popple.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sam Bobroff <sbobroff@linux.ibm.com>,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>,
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
 arch/powerpc/platforms/pseries/iommu.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index cbcc8ce..2783cb7 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -645,7 +645,6 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
 	iommu_table_setparms(pci->phb, dn, tbl);
 	tbl->it_ops = &iommu_table_pseries_ops;
 	iommu_init_table(tbl, pci->phb->node);
-	iommu_register_group(pci->table_group, pci_domain_nr(bus), 0);
 
 	/* Divide the rest (1.75GB) among the children */
 	pci->phb->dma_window_size = 0x80000000ul;
@@ -756,10 +755,7 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev *dev)
 		iommu_table_setparms(phb, dn, tbl);
 		tbl->it_ops = &iommu_table_pseries_ops;
 		iommu_init_table(tbl, phb->node);
-		iommu_register_group(PCI_DN(dn)->table_group,
-				pci_domain_nr(phb->bus), 0);
 		set_iommu_table_base(&dev->dev, tbl);
-		iommu_add_device(&dev->dev);
 		return;
 	}
 
@@ -770,11 +766,10 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev *dev)
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

