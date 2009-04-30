Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 08551DDFA9
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 05:26:25 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] powerpc/pci: Move pseries code into pseries platform
	specific area
Date: Thu, 30 Apr 2009 14:26:21 -0500
Message-Id: <1241119581-23733-1-git-send-email-galak@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There doesn't appear to be any specific reason that we need to setup the
pseries specific notifier in generic arch pci code.  Move it into pseries
land.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/include/asm/pci-bridge.h  |    1 +
 arch/powerpc/kernel/pci_dn.c           |   28 +---------------------------
 arch/powerpc/platforms/pseries/setup.c |   25 +++++++++++++++++++++++++
 3 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 84007af..90fcfc4 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -221,6 +221,7 @@ struct pci_dn {
 #define PCI_DN(dn)	((struct pci_dn *) (dn)->data)
 
 extern struct device_node *fetch_dev_dn(struct pci_dev *dev);
+extern void * update_dn_pci_info(struct device_node *dn, void *data);
 
 /* Get a device_node from a pci_dev.  This code must be fast except
  * in the case where the sysdata is incorrect and needs to be fixed
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index 1c67de5..d5e36e5 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -27,7 +27,6 @@
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
-#include <asm/pSeries_reconfig.h>
 #include <asm/ppc-pci.h>
 #include <asm/firmware.h>
 
@@ -35,7 +34,7 @@
  * Traverse_func that inits the PCI fields of the device node.
  * NOTE: this *must* be done before read/write config to the device.
  */
-static void * __devinit update_dn_pci_info(struct device_node *dn, void *data)
+void * __devinit update_dn_pci_info(struct device_node *dn, void *data)
 {
 	struct pci_controller *phb = data;
 	const int *type =
@@ -184,29 +183,6 @@ struct device_node *fetch_dev_dn(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(fetch_dev_dn);
 
-static int pci_dn_reconfig_notifier(struct notifier_block *nb, unsigned long action, void *node)
-{
-	struct device_node *np = node;
-	struct pci_dn *pci = NULL;
-	int err = NOTIFY_OK;
-
-	switch (action) {
-	case PSERIES_RECONFIG_ADD:
-		pci = np->parent->data;
-		if (pci)
-			update_dn_pci_info(np, pci->phb);
-		break;
-	default:
-		err = NOTIFY_DONE;
-		break;
-	}
-	return err;
-}
-
-static struct notifier_block pci_dn_reconfig_nb = {
-	.notifier_call = pci_dn_reconfig_notifier,
-};
-
 /** 
  * pci_devs_phb_init - Initialize phbs and pci devs under them.
  * 
@@ -223,6 +199,4 @@ void __init pci_devs_phb_init(void)
 	/* This must be done first so the device nodes have valid pci info! */
 	list_for_each_entry_safe(phb, tmp, &hose_list, list_node)
 		pci_devs_phb_init_dynamic(phb);
-
-	pSeries_reconfig_notifier_register(&pci_dn_reconfig_nb);
 }
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index ec34170..8d75ea2 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -63,6 +63,7 @@
 #include <asm/smp.h>
 #include <asm/firmware.h>
 #include <asm/eeh.h>
+#include <asm/pSeries_reconfig.h>
 
 #include "plpar_wrappers.h"
 #include "pseries.h"
@@ -254,6 +255,29 @@ static void __init pseries_discover_pic(void)
 	       " interrupt-controller\n");
 }
 
+static int pci_dn_reconfig_notifier(struct notifier_block *nb, unsigned long action, void *node)
+{
+	struct device_node *np = node;
+	struct pci_dn *pci = NULL;
+	int err = NOTIFY_OK;
+
+	switch (action) {
+	case PSERIES_RECONFIG_ADD:
+		pci = np->parent->data;
+		if (pci)
+			update_dn_pci_info(np, pci->phb);
+		break;
+	default:
+		err = NOTIFY_DONE;
+		break;
+	}
+	return err;
+}
+
+static struct notifier_block pci_dn_reconfig_nb = {
+	.notifier_call = pci_dn_reconfig_notifier,
+};
+
 static void __init pSeries_setup_arch(void)
 {
 	/* Discover PIC type and setup ppc_md accordingly */
@@ -271,6 +295,7 @@ static void __init pSeries_setup_arch(void)
 	/* Find and initialize PCI host bridges */
 	init_pci_config_tokens();
 	find_and_init_phbs();
+	pSeries_reconfig_notifier_register(&pci_dn_reconfig_nb);
 	eeh_init();
 
 	pSeries_nvram_init();
-- 
1.6.0.6
