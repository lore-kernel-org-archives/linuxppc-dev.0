Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id C53EC67C02
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Nov 2006 00:30:29 +1100 (EST)
Message-Id: <20061102125625.428089000@localhost.localdomain>
References: <20061102125555.252338000@localhost.localdomain>
Date: Thu, 02 Nov 2006 13:55:59 +0100
From: s.hauer@pengutronix.de
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 04/16] powerpc: remove dead code in iommu.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

iommu_setup_pSeries() and iommu_setup_dart() are declared extern but are
not implemented, so remove them. iommu_free_table() is pSeries specific,
so #ifdef it with CONFIG_PPC_PSERIES and not CONFIG_PPC_MULTIPLATFORM

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Index: linux-2.6/include/asm-powerpc/iommu.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/iommu.h
+++ linux-2.6/include/asm-powerpc/iommu.h
@@ -70,16 +70,12 @@ struct iommu_table {
 struct scatterlist;
 struct device_node;
 
-#ifdef CONFIG_PPC_MULTIPLATFORM
-
-/* Walks all buses and creates iommu tables */
-extern void iommu_setup_pSeries(void);
-extern void iommu_setup_dart(void);
+#ifdef CONFIG_PPC_PSERIES
 
 /* Frees table for an individual device node */
 extern void iommu_free_table(struct device_node *dn);
 
-#endif /* CONFIG_PPC_MULTIPLATFORM */
+#endif /* CONFIG_PPC_PSERIES */
 
 /* Initializes an iommu_table based in values set in the passed-in
  * structure

--
 Dipl.-Ing. Sascha Hauer | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry
    Handelsregister: Amtsgericht Hildesheim, HRA 2686
      Hannoversche Str. 2, 31134 Hildesheim, Germany
    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
