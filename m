Return-Path: <srs0=nllt=ai=kernel.crashing.org=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xnrMp2PfNzDrY5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Sep 2017 16:36:54 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xnrMp1dhNz8tD9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Sep 2017 16:36:54 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xnrMn1jdtz9s82
 for <linuxppc-dev@ozlabs.org>; Thu,  7 Sep 2017 16:36:52 +1000 (AEST)
Message-ID: <1504766144.12628.15.camel@kernel.crashing.org>
Subject: [PATCH 2/2] powerpc/powernv: Rework EEH initialization on powernv
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Cc: Russell Currey <ruscur@au1.ibm.com>
Date: Thu, 07 Sep 2017 16:35:44 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove the post_init callback which is only used
by powernv, we can just call it explicitly from
the powernv code.

This partially kills the ability to "disable" eeh at
runtime via debugfs as this was calling that same
callback again, but this is both unused and broken
in several ways. If we want to revive it, we need
to create a dedicated enable/disable callback on the
backend that does the right thing.

Let the bulk of eeh initialize normally at
core_initcall() like it does on pseries by removing
the hack in eeh_init() that delays it.

Instead we make sure our eeh->probe cleanly bails
out of the PEs haven't been created yet and we force
a re-probe where we used to call eeh_init() again.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/eeh.h               |  8 ++---
 arch/powerpc/kernel/eeh.c                    | 46 +++++++++------------------
 arch/powerpc/platforms/powernv/eeh-powernv.c | 47 +++++++++++++++-------------
 arch/powerpc/platforms/powernv/pci-ioda.c    |  3 +-
 arch/powerpc/platforms/powernv/pci.h         |  1 +
 5 files changed, 43 insertions(+), 62 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 8e37b71674f4..f44271b3beaf 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -202,7 +202,6 @@ enum {
 struct eeh_ops {
 	char *name;
 	int (*init)(void);
-	int (*post_init)(void);
 	void* (*probe)(struct pci_dn *pdn, void *data);
 	int (*set_option)(struct eeh_pe *pe, int option);
 	int (*get_pe_addr)(struct eeh_pe *pe);
@@ -276,7 +275,7 @@ struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe);
 
 struct eeh_dev *eeh_dev_init(struct pci_dn *pdn);
 void eeh_dev_phb_init_dynamic(struct pci_controller *phb);
-int eeh_init(void);
+void eeh_probe_devices(void);
 int __init eeh_ops_register(struct eeh_ops *ops);
 int __exit eeh_ops_unregister(const char *name);
 int eeh_check_failure(const volatile void __iomem *token);
@@ -322,10 +321,7 @@ static inline bool eeh_enabled(void)
         return false;
 }
 
-static inline int eeh_init(void)
-{
-	return 0;
-}
+static inline void eeh_probe_devices(void) { }
 
 static inline void *eeh_dev_init(struct pci_dn *pdn, void *data)
 {
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index f27eecd5ec7f..5e8617a53a86 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -971,6 +971,18 @@ static struct notifier_block eeh_reboot_nb = {
 	.notifier_call = eeh_reboot_notifier,
 };
 
+void eeh_probe_devices(void)
+{
+	struct pci_controller *hose, *tmp;
+	struct pci_dn *pdn;
+
+	/* Enable EEH for all adapters */
+	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
+		pdn = hose->pci_data;
+		traverse_pci_dn(pdn, eeh_ops->probe, NULL);
+	}
+}
+
 /**
  * eeh_init - EEH initialization
  *
@@ -986,22 +998,11 @@ static struct notifier_block eeh_reboot_nb = {
  * Even if force-off is set, the EEH hardware is still enabled, so that
  * newer systems can boot.
  */
-int eeh_init(void)
+static int eeh_init(void)
 {
 	struct pci_controller *hose, *tmp;
-	struct pci_dn *pdn;
-	static int cnt = 0;
 	int ret = 0;
 
-	/*
-	 * We have to delay the initialization on PowerNV after
-	 * the PCI hierarchy tree has been built because the PEs
-	 * are figured out based on PCI devices instead of device
-	 * tree nodes
-	 */
-	if (machine_is(powernv) && cnt++ <= 0)
-		return ret;
-
 	/* Register reboot notifier */
 	ret = register_reboot_notifier(&eeh_reboot_nb);
 	if (ret) {
@@ -1027,22 +1028,7 @@ int eeh_init(void)
 	if (ret)
 		return ret;
 
-	/* Enable EEH for all adapters */
-	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
-		pdn = hose->pci_data;
-		traverse_pci_dn(pdn, eeh_ops->probe, NULL);
-	}
-
-	/*
-	 * Call platform post-initialization. Actually, It's good chance
-	 * to inform platform that EEH is ready to supply service if the
-	 * I/O cache stuff has been built up.
-	 */
-	if (eeh_ops->post_init) {
-		ret = eeh_ops->post_init();
-		if (ret)
-			return ret;
-	}
+	eeh_probe_devices();
 
 	if (eeh_enabled())
 		pr_info("EEH: PCI Enhanced I/O Error Handling Enabled\n");
@@ -1757,10 +1743,6 @@ static int eeh_enable_dbgfs_set(void *data, u64 val)
 	else
 		eeh_add_flag(EEH_FORCE_DISABLED);
 
-	/* Notify the backend */
-	if (eeh_ops->post_init)
-		eeh_ops->post_init();
-
 	return 0;
 }
 
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 3f48f6df1cf3..6bde8f0f78e3 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -41,7 +41,6 @@
 #include "powernv.h"
 #include "pci.h"
 
-static bool pnv_eeh_nb_init = false;
 static int eeh_event_irq = -EINVAL;
 
 static int pnv_eeh_init(void)
@@ -204,31 +203,31 @@ PNV_EEH_DBGFS_ENTRY(inbB, 0xE10);
  * been built. If the I/O cache staff has been built, EEH is
  * ready to supply service.
  */
-static int pnv_eeh_post_init(void)
+int pnv_eeh_post_init(void)
 {
 	struct pci_controller *hose;
 	struct pnv_phb *phb;
 	int ret = 0;
 
-	/* Register OPAL event notifier */
-	if (!pnv_eeh_nb_init) {
-		eeh_event_irq = opal_event_request(ilog2(OPAL_EVENT_PCI_ERROR));
-		if (eeh_event_irq < 0) {
-			pr_err("%s: Can't register OPAL event interrupt (%d)\n",
-			       __func__, eeh_event_irq);
-			return eeh_event_irq;
-		}
+	/* Probe devices & build address cache */
+	eeh_probe_devices();
+	eeh_addr_cache_build();
 
-		ret = request_irq(eeh_event_irq, pnv_eeh_event,
-				IRQ_TYPE_LEVEL_HIGH, "opal-eeh", NULL);
-		if (ret < 0) {
-			irq_dispose_mapping(eeh_event_irq);
-			pr_err("%s: Can't request OPAL event interrupt (%d)\n",
-			       __func__, eeh_event_irq);
-			return ret;
-		}
+	/* Register OPAL event notifier */
+	eeh_event_irq = opal_event_request(ilog2(OPAL_EVENT_PCI_ERROR));
+	if (eeh_event_irq < 0) {
+		pr_err("%s: Can't register OPAL event interrupt (%d)\n",
+		       __func__, eeh_event_irq);
+		return eeh_event_irq;
+	}
 
-		pnv_eeh_nb_init = true;
+	ret = request_irq(eeh_event_irq, pnv_eeh_event,
+			  IRQ_TYPE_LEVEL_HIGH, "opal-eeh", NULL);
+	if (ret < 0) {
+		irq_dispose_mapping(eeh_event_irq);
+		pr_err("%s: Can't request OPAL event interrupt (%d)\n",
+		       __func__, eeh_event_irq);
+		return ret;
 	}
 
 	if (!eeh_enabled())
@@ -357,7 +356,7 @@ static void *pnv_eeh_probe(struct pci_dn *pdn, void *data)
 	struct pci_controller *hose = pdn->phb;
 	struct pnv_phb *phb = hose->private_data;
 	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
-	uint32_t pcie_flags;
+	uint32_t pcie_flags, config_addr;
 	int ret;
 
 	/*
@@ -373,6 +372,11 @@ static void *pnv_eeh_probe(struct pci_dn *pdn, void *data)
 	if ((pdn->class_code >> 8) == PCI_CLASS_BRIDGE_ISA)
 		return NULL;
 
+	/* Skip if we haven't probed yet */
+	config_addr = (pdn->busno << 8) | (pdn->devfn);
+	if (phb->ioda.pe_rmap[config_addr] == IODA_INVALID_PE)
+		return NULL;
+
 	/* Initialize eeh device */
 	edev->class_code = pdn->class_code;
 	edev->mode	&= 0xFFFFFF00;
@@ -393,7 +397,7 @@ static void *pnv_eeh_probe(struct pci_dn *pdn, void *data)
 		}
 	}
 
-	edev->config_addr    = (pdn->busno << 8) | (pdn->devfn);
+	edev->config_addr    = config_addr;
 	edev->pe_config_addr = phb->ioda.pe_rmap[edev->config_addr];
 
 	/* Create PE */
@@ -1742,7 +1746,6 @@ static int pnv_eeh_restore_config(struct pci_dn *pdn)
 static struct eeh_ops pnv_eeh_ops = {
 	.name                   = "powernv",
 	.init                   = pnv_eeh_init,
-	.post_init              = pnv_eeh_post_init,
 	.probe			= pnv_eeh_probe,
 	.set_option             = pnv_eeh_set_option,
 	.get_pe_addr            = pnv_eeh_get_pe_addr,
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index b900eb1d5e17..24e52fa0c8b7 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3294,8 +3294,7 @@ static void pnv_pci_ioda_fixup(void)
 	pnv_pci_ioda_create_dbgfs();
 
 #ifdef CONFIG_EEH
-	eeh_init();
-	eeh_addr_cache_build();
+	pnv_eeh_post_init();
 #endif
 }
 
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index f16bc403ec03..31f5f99be39a 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -229,6 +229,7 @@ extern void pnv_teardown_msi_irqs(struct pci_dev *pdev);
 extern struct pnv_ioda_pe *pnv_ioda_get_pe(struct pci_dev *dev);
 extern void pnv_set_msi_irq_chip(struct pnv_phb *phb, unsigned int virq);
 extern bool pnv_pci_enable_device_hook(struct pci_dev *dev);
+extern int pnv_eeh_post_init(void);
 
 extern void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
 			    const char *fmt, ...);
