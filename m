Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CFF072C00CC
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Nov 2013 19:32:58 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Mon, 4 Nov 2013 03:32:55 -0500
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id C84E0C9003E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Nov 2013 03:32:52 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rA48Wrjf53149734
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Nov 2013 08:32:53 GMT
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 rA48WrJ0015811
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Nov 2013 06:32:53 -0200
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc/powernv: Reserve the correct PE number
Date: Mon,  4 Nov 2013 16:32:47 +0800
Message-Id: <1383553967-16644-2-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1383553967-16644-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1383553967-16644-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We're assigning PE numbers after the completion of PCI probe. During
the PCI probe, we had PE#0 as the super container to encompass all
PCI devices. However, that's inappropriate since PELTM has ascending
order of priority on search on P7IOC. So we need PE#127 takes the
role that PE#0 has previously. For PHB3, we still have PE#0 as the
reserved PE.

The patch supposes that the underly firmware has built the RID to
PE# mapping after resetting IODA tables: all PELTM entries except
last one has invalid mapping on P7IOC, but all RTEs have binding
to PE#0. The reserved PE# is being exported by firmware by device
tree.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |   22 +++++++++-------------
 arch/powerpc/platforms/powernv/pci.c      |   10 +++++++---
 arch/powerpc/platforms/powernv/pci.h      |    1 +
 3 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 198566e..084cdfa 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1209,12 +1209,13 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
 		pr_err("  Failed to map registers !\n");
 
 	/* Initialize more IODA stuff */
+	phb->ioda.total_pe = 1;
 	prop32 = of_get_property(np, "ibm,opal-num-pes", NULL);
-	if (!prop32)
-		phb->ioda.total_pe = 1;
-	else
+	if (prop32)
 		phb->ioda.total_pe = be32_to_cpup(prop32);
-
+	prop32 = of_get_property(np, "ibm,opal-reserved-pe", NULL);
+	if (prop32)
+		phb->ioda.reserved_pe = be32_to_cpup(prop32);
 	phb->ioda.m32_size = resource_size(&hose->mem_resources[0]);
 	/* FW Has already off top 64k of M32 space (MSI space) */
 	phb->ioda.m32_size += 0x10000;
@@ -1243,7 +1244,7 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	if (phb->type == PNV_PHB_IODA1)
 		phb->ioda.io_segmap = aux + iomap_off;
 	phb->ioda.pe_array = aux + pemap_off;
-	set_bit(0, phb->ioda.pe_alloc);
+	set_bit(phb->ioda.reserved_pe, phb->ioda.pe_alloc);
 
 	INIT_LIST_HEAD(&phb->ioda.pe_dma_list);
 	INIT_LIST_HEAD(&phb->ioda.pe_list);
@@ -1268,8 +1269,10 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
 					 segment_size);
 #endif
 
-	pr_info("  %d PE's M32: 0x%x [segment=0x%x] IO: 0x%x [segment=0x%x]\n",
+	pr_info("  %d (%d) PE's M32: 0x%x [segment=0x%x]"
+		" IO: 0x%x [segment=0x%x]\n",
 		phb->ioda.total_pe,
+		phb->ioda.reserved_pe,
 		phb->ioda.m32_size, phb->ioda.m32_segsize,
 		phb->ioda.io_size, phb->ioda.io_segsize);
 
@@ -1306,13 +1309,6 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	rc = opal_pci_reset(phb_id, OPAL_PCI_IODA_TABLE_RESET, OPAL_ASSERT_RESET);
 	if (rc)
 		pr_warning("  OPAL Error %ld performing IODA table reset !\n", rc);
-
-	/*
-	 * On IODA1 map everything to PE#0, on IODA2 we assume the IODA reset
-	 * has cleared the RTT which has the same effect
-	 */
-	if (ioda_type == PNV_PHB_IODA1)
-		opal_pci_set_pe(phb_id, 0, 0, 7, 1, 1 , OPAL_MAP_PE);
 }
 
 void __init pnv_pci_init_ioda2_phb(struct device_node *np)
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 921ae67..4eb33a9 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -242,11 +242,15 @@ static void pnv_pci_config_check_eeh(struct pnv_phb *phb,
 	/*
 	 * Get the PE#. During the PCI probe stage, we might not
 	 * setup that yet. So all ER errors should be mapped to
-	 * PE#0
+	 * reserved PE.
 	 */
 	pe_no = PCI_DN(dn)->pe_number;
-	if (pe_no == IODA_INVALID_PE)
-		pe_no = 0;
+	if (pe_no == IODA_INVALID_PE) {
+		if (phb->type == PNV_PHB_P5IOC2)
+			pe_no = 0;
+		else
+			pe_no = phb->ioda.reserved_pe;
+	}
 
 	/* Read freeze status */
 	rc = opal_pci_eeh_freeze_status(phb->opal_id, pe_no, &fstate, &pcierr,
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 64d3b12..911c24e 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -125,6 +125,7 @@ struct pnv_phb {
 		struct {
 			/* Global bridge info */
 			unsigned int		total_pe;
+			unsigned int		reserved_pe;
 			unsigned int		m32_size;
 			unsigned int		m32_segsize;
 			unsigned int		m32_pci_base;
-- 
1.7.9.5
