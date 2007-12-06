Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 3D6A5DE1D6
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 02:07:54 +1100 (EST)
Received: from ash.ozlabs.ibm.com (ta-1-1.tip.net.au [203.11.71.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id 0F565368002
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 02:07:54 +1100 (EST)
Date: Fri, 7 Dec 2007 01:46:40 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 03/19] [POWERPC] iSeries: move find_Device_Node to avoid a
	forward declaration
Message-Id: <20071207014640.0e7a70e2.sfr@canb.auug.org.au>
In-Reply-To: <20071206180045.0eb1db98.sfr@canb.auug.org.au>
References: <20071206180045.0eb1db98.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Also remove another unnecessary forward declaration.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/iseries/pci.c |   39 ++++++++++++++--------------------
 1 files changed, 16 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/platforms/iseries/pci.c b/arch/powerpc/platforms/iseries/pci.c
index a74d1e1..e4e6ae0 100644
--- a/arch/powerpc/platforms/iseries/pci.c
+++ b/arch/powerpc/platforms/iseries/pci.c
@@ -45,16 +45,9 @@
 #include "pci.h"
 #include "call_pci.h"
 
-/*
- * Forward declares of prototypes.
- */
-static struct device_node *find_Device_Node(int bus, int devfn);
-
 static int Pci_Retry_Max = 3;	/* Only retry 3 times  */
 static int Pci_Error_Flag = 1;	/* Set Retry Error on. */
 
-static struct pci_ops iSeries_pci_ops;
-
 /*
  * Table defines
  * Each Entry size is 4 MB * 1024 Entries = 4GB I/O address space.
@@ -155,6 +148,22 @@ static void pci_Log_Error(char *Error_Text, int Bus, int SubBus,
 }
 
 /*
+ * Look down the chain to find the matching Device Device
+ */
+static struct device_node *find_Device_Node(int bus, int devfn)
+{
+	struct device_node *node;
+
+	for (node = NULL; (node = of_find_all_nodes(node)); ) {
+		struct pci_dn *pdn = PCI_DN(node);
+
+		if (pdn && (bus == pdn->busno) && (devfn == pdn->devfn))
+			return node;
+	}
+	return NULL;
+}
+
+/*
  * iSeries_pci_final_fixup(void)
  */
 void __init iSeries_pci_final_fixup(void)
@@ -214,22 +223,6 @@ void __init iSeries_pci_final_fixup(void)
 	mf_display_src(0xC9000200);
 }
 
-/*
- * Look down the chain to find the matching Device Device
- */
-static struct device_node *find_Device_Node(int bus, int devfn)
-{
-	struct device_node *node;
-
-	for (node = NULL; (node = of_find_all_nodes(node)); ) {
-		struct pci_dn *pdn = PCI_DN(node);
-
-		if (pdn && (bus == pdn->busno) && (devfn == pdn->devfn))
-			return node;
-	}
-	return NULL;
-}
-
 #if 0
 /*
  * Returns the device node for the passed pci_dev
-- 
1.5.3.7


-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
