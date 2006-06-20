Return-Path: <anton@ozlabs.org>
Date: Tue, 20 Jun 2006 18:00:30 +1000
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Dont look for class-code in pci children
Message-ID: <20060620080029.GA30974@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Looking for class-code in PCI children breaks with direct slots. Lets
just count all children.

Signed-off-by: Anton Blanchard <anton@samba.org>
Acked-by: Olof Johansson <olof@lixom.net>
---

Index: build/arch/powerpc/platforms/pseries/iommu.c
===================================================================
--- build.orig/arch/powerpc/platforms/pseries/iommu.c	2006-06-10 19:52:32.000000000 +1000
+++ build/arch/powerpc/platforms/pseries/iommu.c	2006-06-10 21:58:20.000000000 +1000
@@ -331,13 +331,9 @@ static void iommu_bus_setup_pSeries(stru
 	if (isa_dn_orig)
 		of_node_put(isa_dn_orig);
 
-	/* Count number of direct PCI children of the PHB.
-	 * All PCI device nodes have class-code property, so it's
-	 * an easy way to find them.
-	 */
+	/* Count number of direct PCI children of the PHB. */
 	for (children = 0, tmp = dn->child; tmp; tmp = tmp->sibling)
-		if (get_property(tmp, "class-code", NULL))
-			children++;
+		children++;
 
 	DBG("Children: %d\n", children);
 
