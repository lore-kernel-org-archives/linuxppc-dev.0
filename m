Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 05 Dec 2007 11:53:07 +1100
Subject: [RFC/PATCH 6/6] powerpc: pci32: 4xx embedded platforms want to
	reassign all PCI resources
In-Reply-To: <1196815980.72143.899704305870.qpush@grosgo>
Message-Id: <20071205005416.B362CDE1B5@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This makes 4xx embedded platforms re-assign all PCI resources as we
pretty much never care about what the various firmwares have done on
these, it's generally not compatible with the way the kernel will map
the bridges.

We still need to also enable bus renumbering on some of them, but I
will do that from a separate patch after I've fixed 4xx PCIe to handle
all bus numbers.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/platforms/40x/ep405.c   |    2 ++
 arch/powerpc/platforms/40x/kilauea.c |    3 +++
 arch/powerpc/platforms/40x/walnut.c  |    3 +++
 arch/powerpc/platforms/44x/bamboo.c  |    4 ++++
 arch/powerpc/platforms/44x/ebony.c   |    3 +++
 arch/powerpc/platforms/44x/katmai.c  |    3 +++
 arch/powerpc/platforms/44x/sequoia.c |    5 ++++-
 arch/powerpc/platforms/44x/taishan.c |    2 ++
 8 files changed, 24 insertions(+), 1 deletion(-)

Index: linux-work/arch/powerpc/platforms/44x/bamboo.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/44x/bamboo.c	2007-12-05 11:22:15.000000000 +1100
+++ linux-work/arch/powerpc/platforms/44x/bamboo.c	2007-12-05 11:23:35.000000000 +1100
@@ -21,6 +21,8 @@
 #include <asm/udbg.h>
 #include <asm/time.h>
 #include <asm/uic.h>
+#include <asm/pci-bridge.h>
+
 #include "44x.h"
 
 static struct of_device_id bamboo_of_bus[] = {
@@ -48,6 +50,8 @@ static int __init bamboo_probe(void)
 	if (!of_flat_dt_is_compatible(root, "amcc,bamboo"))
 		return 0;
 
+	ppc_pci_flags = PPC_PCI_REASSIGN_ALL_RSRC;
+
 	return 1;
 }
 
Index: linux-work/arch/powerpc/platforms/40x/ep405.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/40x/ep405.c	2007-12-05 11:22:15.000000000 +1100
+++ linux-work/arch/powerpc/platforms/40x/ep405.c	2007-12-05 11:23:35.000000000 +1100
@@ -102,6 +102,8 @@ static void __init ep405_setup_arch(void
 {
 	/* Find & init the BCSR CPLD */
 	ep405_init_bcsr();
+
+	ppc_pci_flags = PPC_PCI_REASSIGN_ALL_RSRC;
 }
 
 static int __init ep405_probe(void)
Index: linux-work/arch/powerpc/platforms/40x/kilauea.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/40x/kilauea.c	2007-12-05 11:22:15.000000000 +1100
+++ linux-work/arch/powerpc/platforms/40x/kilauea.c	2007-12-05 11:24:41.000000000 +1100
@@ -19,6 +19,7 @@
 #include <asm/udbg.h>
 #include <asm/time.h>
 #include <asm/uic.h>
+#include <asm/pci-bridge.h>
 
 static struct of_device_id kilauea_of_bus[] = {
 	{ .compatible = "ibm,plb4", },
@@ -45,6 +46,8 @@ static int __init kilauea_probe(void)
 	if (!of_flat_dt_is_compatible(root, "amcc,kilauea"))
 		return 0;
 
+	ppc_pci_flags = PPC_PCI_REASSIGN_ALL_RSRC;
+
 	return 1;
 }
 
Index: linux-work/arch/powerpc/platforms/40x/walnut.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/40x/walnut.c	2007-12-05 11:22:15.000000000 +1100
+++ linux-work/arch/powerpc/platforms/40x/walnut.c	2007-12-05 11:24:47.000000000 +1100
@@ -24,6 +24,7 @@
 #include <asm/udbg.h>
 #include <asm/time.h>
 #include <asm/uic.h>
+#include <asm/pci-bridge.h>
 
 static struct of_device_id walnut_of_bus[] = {
 	{ .compatible = "ibm,plb3", },
@@ -51,6 +52,8 @@ static int __init walnut_probe(void)
 	if (!of_flat_dt_is_compatible(root, "ibm,walnut"))
 		return 0;
 
+	ppc_pci_flags = PPC_PCI_REASSIGN_ALL_RSRC;
+
 	return 1;
 }
 
Index: linux-work/arch/powerpc/platforms/44x/ebony.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/44x/ebony.c	2007-12-05 11:22:15.000000000 +1100
+++ linux-work/arch/powerpc/platforms/44x/ebony.c	2007-12-05 11:24:13.000000000 +1100
@@ -24,6 +24,7 @@
 #include <asm/udbg.h>
 #include <asm/time.h>
 #include <asm/uic.h>
+#include <asm/pci-bridge.h>
 
 #include "44x.h"
 
@@ -55,6 +56,8 @@ static int __init ebony_probe(void)
 	if (!of_flat_dt_is_compatible(root, "ibm,ebony"))
 		return 0;
 
+	ppc_pci_flags = PPC_PCI_REASSIGN_ALL_RSRC;
+
 	return 1;
 }
 
Index: linux-work/arch/powerpc/platforms/44x/katmai.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/44x/katmai.c	2007-12-05 11:22:15.000000000 +1100
+++ linux-work/arch/powerpc/platforms/44x/katmai.c	2007-12-05 11:24:00.000000000 +1100
@@ -21,6 +21,7 @@
 #include <asm/udbg.h>
 #include <asm/time.h>
 #include <asm/uic.h>
+#include <asm/pci-bridge.h>
 
 #include "44x.h"
 
@@ -49,6 +50,8 @@ static int __init katmai_probe(void)
 	if (!of_flat_dt_is_compatible(root, "amcc,katmai"))
 		return 0;
 
+	ppc_pci_flags = PPC_PCI_REASSIGN_ALL_RSRC;
+
 	return 1;
 }
 
Index: linux-work/arch/powerpc/platforms/44x/sequoia.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/44x/sequoia.c	2007-12-05 11:22:15.000000000 +1100
+++ linux-work/arch/powerpc/platforms/44x/sequoia.c	2007-12-05 11:24:53.000000000 +1100
@@ -21,7 +21,8 @@
 #include <asm/udbg.h>
 #include <asm/time.h>
 #include <asm/uic.h>
-#include "44x.h"
+#include <asm/pci-bridge.h>
+
 
 static struct of_device_id sequoia_of_bus[] = {
 	{ .compatible = "ibm,plb4", },
@@ -48,6 +49,8 @@ static int __init sequoia_probe(void)
 	if (!of_flat_dt_is_compatible(root, "amcc,sequoia"))
 		return 0;
 
+	ppc_pci_flags = PPC_PCI_REASSIGN_ALL_RSRC;
+
 	return 1;
 }
 
Index: linux-work/arch/powerpc/platforms/44x/taishan.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/44x/taishan.c	2007-12-05 11:22:15.000000000 +1100
+++ linux-work/arch/powerpc/platforms/44x/taishan.c	2007-12-05 11:23:35.000000000 +1100
@@ -60,6 +60,8 @@ static int __init taishan_probe(void)
 	if (!of_flat_dt_is_compatible(root, "ibm,taishan"))
 		return 0;
 
+	ppc_pci_flags = PPC_PCI_REASSIGN_ALL_RSRC;
+
 	return 1;
 }
 
