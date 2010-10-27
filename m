Return-Path: <nacc@us.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e39.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5305DB70AF
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Oct 2010 14:35:59 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e39.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o9R3Oj8P022241
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Oct 2010 21:24:45 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o9R3ZhSU148514
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Oct 2010 21:35:43 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o9R3ZhjO032347
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Oct 2010 21:35:43 -0600
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: nacc@us.ibm.com
Subject: [RFC PATCH 3/7 v2] ppc: do not search for dma-window property on
	dlpar remove
Date: Tue, 26 Oct 2010 20:35:13 -0700
Message-Id: <1288150518-4026-4-git-send-email-nacc@us.ibm.com>
In-Reply-To: <1288150518-4026-1-git-send-email-nacc@us.ibm.com>
References: <1288150518-4026-1-git-send-email-nacc@us.ibm.com>
Cc: sonnyrao@us.ibm.com, miltonm@bga.com, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The iommu_table pointer in the pci auxiliary struct of device_node has
not been used by the iommu ops since the dma refactor of
12d04eef927bf61328af2c7cbe756c96f98ac3bf, however this code still uses
it to find tables for dlpar. By only setting the PCI_DN iommu_table
pointer on nodes with dma window properties, we will be able to quickly
find the node for later checks, and can remove the table without looking
for the the dma window property on dlpar remove.

Signed-off-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
---
 arch/powerpc/platforms/pseries/iommu.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 9184db3..8ab32da 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -455,9 +455,6 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
 		ppci->iommu_table = iommu_init_table(tbl, ppci->phb->node);
 		pr_debug("  created table: %p\n", ppci->iommu_table);
 	}
-
-	if (pdn != dn)
-		PCI_DN(dn)->iommu_table = ppci->iommu_table;
 }
 
 
@@ -571,8 +568,7 @@ static int iommu_reconfig_notifier(struct notifier_block *nb, unsigned long acti
 
 	switch (action) {
 	case PSERIES_RECONFIG_REMOVE:
-		if (pci && pci->iommu_table &&
-		    of_get_property(np, "ibm,dma-window", NULL))
+		if (pci && pci->iommu_table)
 			iommu_free_table(pci->iommu_table, np->full_name);
 		break;
 	default:
-- 
1.7.1
