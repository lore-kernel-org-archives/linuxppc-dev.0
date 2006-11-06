Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id CF35C67C6C
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Nov 2006 21:19:13 +1100 (EST)
Date: Mon, 6 Nov 2006 11:19:08 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch 04/16] powerpc: remove dead code in iommu.h
Message-ID: <20061106101907.GI6318@localhost.localdomain>
References: <20061102125555.252338000@localhost.localdomain>
	<20061102125625.428089000@localhost.localdomain>
	<1162506113.10630.35.camel@localhost.localdomain>
	<20061103084730.GB22478@localhost.localdomain>
	<1162709223.28571.213.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1162709223.28571.213.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Subject: powerpc: remove dead code in iommu.h
From: Sascha Hauer <s.hauer@pengutronix.de>

iommu_setup_pSeries() and iommu_setup_dart() are declared extern but are
not implemented, so remove them. Remove ifdef around extern function
declaration.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Index: include/asm-powerpc/iommu.h
===================================================================
--- a/include/asm-powerpc/iommu.h.orig
+++ b/include/asm-powerpc/iommu.h
@@ -70,17 +70,9 @@ struct iommu_table {
 struct scatterlist;
 struct device_node;
 
-#ifdef CONFIG_PPC_MULTIPLATFORM
-
-/* Walks all buses and creates iommu tables */
-extern void iommu_setup_pSeries(void);
-extern void iommu_setup_dart(void);
-
 /* Frees table for an individual device node */
 extern void iommu_free_table(struct device_node *dn);
 
-#endif /* CONFIG_PPC_MULTIPLATFORM */
-
 /* Initializes an iommu_table based in values set in the passed-in
  * structure
  */

-- 
 Dipl.-Ing. Sascha Hauer | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry
    Handelsregister: Amtsgericht Hildesheim, HRA 2686
      Hannoversche Str. 2, 31134 Hildesheim, Germany
    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
