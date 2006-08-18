Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Fri, 18 Aug 2006 18:13:30 +1000
Subject: [RFC/PATCH 3/4] Powerpc MSI support via RTAS
Message-Id: <20060818081331.37E2F67B56@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Powerpc MSI support via RTAS. Based on Jake's code, reworked to:
 * only ever set 1 MSI.
 * implement disable, we can't do without it.
 * bork if firmware enables MSI-X on us, that's not ok.
 * more error handling.

NOT tested. Mainline apparently isn't booting atm on the machines that
have the required firmware :/

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>
Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/platforms/pseries/setup.c |    1 
 drivers/pci/Makefile                   |    1 
 drivers/pci/msi-rtas.c                 |  199 +++++++++++++++++++++++++++++++++
 include/asm-powerpc/pci-bridge.h       |    3 
 include/asm-powerpc/rtas.h             |    6 
 5 files changed, 210 insertions(+)

Index: git/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- git.orig/arch/powerpc/platforms/pseries/setup.c
+++ git/arch/powerpc/platforms/pseries/setup.c
@@ -273,6 +273,7 @@ static void __init pseries_discover_pic(
 			return;
 		} else if (strstr(typep, "ppc-xicp")) {
 			ppc_md.init_IRQ       = xics_init_IRQ;
+			rtas_msi_init();
 #ifdef CONFIG_KEXEC
 			ppc_md.kexec_cpu_down = pseries_kexec_cpu_down_xics;
 #endif
Index: git/drivers/pci/Makefile
===================================================================
--- git.orig/drivers/pci/Makefile
+++ git/drivers/pci/Makefile
@@ -31,6 +31,7 @@ msiobj-$(CONFIG_X86) := msi.o msi-apic.o
 msiobj-$(CONFIG_IA64) := msi.o msi-apic.o
 msiobj-$(CONFIG_IA64_GENERIC) := msi-altix.o
 msiobj-$(CONFIG_IA64_SGI_SN2) := msi-altix.o
+msiobj-$(CONFIG_PPC_PSERIES) := msi-rtas.o
 
 obj-$(CONFIG_PCI_MSI) += $(msiobj-y)
 
Index: git/drivers/pci/msi-rtas.c
===================================================================
--- /dev/null
+++ git/drivers/pci/msi-rtas.c
@@ -0,0 +1,199 @@
+/*
+ * Copyright (C) 2006 Jake Moilanen <moilanen@austin.ibm.com>, IBM Corp.
+ * Copyright (C) 2006 Michael Ellerman, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2 of the
+ * License.
+ *
+ */
+
+#define DEBUG 1
+
+#include <linux/pci.h>
+#include <linux/irq.h>
+#include <asm/rtas.h>
+#include <asm/hw_irq.h>
+#include <asm/ppc-pci.h>
+
+static int query_token, change_token;
+
+#define RTAS_QUERY_MSI_FN	0
+#define RTAS_CHANGE_MSI_FN	1
+#define RTAS_RESET_MSI_FN	2
+
+static int rtas_change_msi(struct pci_dn *pdn, u32 function, u32 num_irqs)
+{
+	u32 addr, seq_num, rtas_ret[2];
+	unsigned long buid;
+	int rc;
+
+	addr = rtas_config_addr(pdn->busno, pdn->devfn, 0);
+	buid = pdn->phb->buid;
+
+	seq_num = 1;
+	do {
+		rc = rtas_call(change_token, 6, 3, rtas_ret, addr,
+				BUID_HI(buid), BUID_LO(buid),
+				function, num_irqs, seq_num);
+
+		seq_num = rtas_ret[1];
+	} while (rtas_busy_delay(rc));
+
+	if (rc) {
+		printk(KERN_WARNING "Error[%d]: getting the number of"
+			" MSI interrupts for %s\n", rc, pci_name(pdn->pcidev));
+		return rc;
+	}
+
+	return rtas_ret[0];
+}
+
+static int rtas_query_irq_number(struct pci_dn *pdn, int offset)
+{
+	u32 addr, rtas_ret[2];
+	unsigned long buid;
+	int rc;
+
+	addr = rtas_config_addr(pdn->busno, pdn->devfn, 0);
+	buid = pdn->phb->buid;
+
+	do {
+		rc = rtas_call(query_token, 4, 3, rtas_ret, addr,
+			       BUID_HI(buid), BUID_LO(buid), offset);
+	} while (rtas_busy_delay(rc));
+
+	if (rc) {
+		printk(KERN_WARNING "Error[%d]: Querying irq source number "
+				"for %s\n", rc, pci_name(pdn->pcidev));
+		return rc;
+	}
+
+	return rtas_ret[0];
+}
+
+static int msi_enabled(struct pci_dev *pdev)
+{
+	int pos;
+	u16 reg;
+
+	pos = pci_find_capability(pdev, PCI_CAP_ID_MSI);
+	if (!pos)
+		return 0;
+
+	pci_read_config_word(pdev, pos + PCI_MSI_FLAGS, &reg);
+	if (reg & PCI_MSI_FLAGS_ENABLE)
+		return 1;
+
+	return 0;
+}
+
+static void rtas_disable_msi(struct pci_dev* pdev)
+{
+	struct device_node *dn;
+	struct pci_dn *pdn;
+
+	dn = pci_device_to_OF_node(pdev);
+	if (!dn) {
+		pr_debug("rtas_disable_msi: No OF device node for %s\n",
+				pci_name(pdev));
+		return;
+	}
+
+	pdn = PCI_DN(dn);
+	if (!pdn) {
+		pr_debug("rtas_disable_msi: No PCI DN for %s\n",
+				pci_name(pdev));
+		return;
+	}
+
+	/* XXX can we do anything sane if this fails? */
+	rtas_change_msi(pdn, RTAS_CHANGE_MSI_FN, 0);
+
+	pdev->irq = pdn->saved_irq;
+}
+
+static int rtas_enable_msi(struct pci_dev *pdev)
+{
+	struct device_node *dn;
+	struct pci_dn *pdn;
+	int rc, virq;
+
+	dn = pci_device_to_OF_node(pdev);
+	if (!dn) {
+		pr_debug("rtas_enable_msi: No OF device node for %s\n",
+				pci_name(pdev));
+		goto out_err;
+	}
+
+	if (!of_find_property(dn, "ibm,req#msi", NULL)) {
+		pr_debug("rtas_enable_msi: No ibm,req#msi for %s\n",
+				pci_name(pdev));
+		goto out_err;
+	}
+
+	pdn = PCI_DN(dn);
+	if (!pdn) {
+		pr_debug("rtas_change_msi: No PCI DN for %s\n", pci_name(pdev));
+		goto out_err;
+	}
+
+	pdn->saved_irq = pdev->irq;
+
+	/*
+	 * Try and configure 1 MSI for the device. This should get us
+	 * either 1 MSI, or an error. In the case of an error it's not
+	 * clear whether the device is left with MSI enabled or disabled,
+	 * so I think we should explicitly disable.
+	 */
+	rc = rtas_change_msi(pdn, RTAS_CHANGE_MSI_FN, 1);
+	if (rc != 1)
+		goto out_disable;
+
+	/*
+	 * The spec gives firmware the option to enable either MSI or MSI-X,
+	 * this doesn't wash with the Linux API. For the time beinging, we
+	 * kludge around that by checking ourselves if MSI has been enabled.
+	 */
+	if (!msi_enabled(pdev)) {
+		pr_debug("rtas_enable_msi: MSI not enabled by firmware!\n");
+		goto out_disable;
+	}
+
+	rc = rtas_query_irq_number(pdn, 0);
+	if (rc < 0)
+		goto out_disable;
+
+	virq = irq_create_mapping(NULL, rc);
+	if (virq == NO_IRQ) {
+		pr_debug("rtas_enable_msi: Failed mapping hwirq %d\n", rc);
+		goto out_disable;
+	}
+
+	pdev->irq = virq;
+	return 0;
+
+ out_disable:
+	rtas_disable_msi(pdev);
+ out_err:
+	return -1;
+}
+
+void rtas_msi_init(void)
+{
+	query_token  = rtas_token("ibm,query-interrupt-source-number");
+	change_token = rtas_token("ibm,change-msi");
+
+	if ((query_token == RTAS_UNKNOWN_SERVICE) ||
+			(change_token == RTAS_UNKNOWN_SERVICE)) {
+		pr_debug("rtas_msi_init: Couldn't find RTAS tokens, no "
+				"MSI support available.\n");
+		return;
+	}
+
+	pr_debug("rtas_msi_init: Registering MSI callbacks.\n");
+
+	ppc_md.enable_msi = rtas_enable_msi;
+	ppc_md.disable_msi = rtas_disable_msi;
+}
Index: git/include/asm-powerpc/pci-bridge.h
===================================================================
--- git.orig/include/asm-powerpc/pci-bridge.h
+++ git/include/asm-powerpc/pci-bridge.h
@@ -81,6 +81,9 @@ struct pci_dn {
 	struct	pci_dev *pcidev;	/* back-pointer to the pci device */
 	struct	device_node *node;	/* back-pointer to the device_node */
 	u32	config_space[16];	/* saved PCI config space */
+#ifdef CONFIG_PCI_MSI
+	int	saved_irq;		/* saved LSI for MSI */
+#endif
 };
 
 /* Get the pointer to a device_node's pci_dn */
Index: git/include/asm-powerpc/rtas.h
===================================================================
--- git.orig/include/asm-powerpc/rtas.h
+++ git/include/asm-powerpc/rtas.h
@@ -246,5 +246,11 @@ static inline u32 rtas_config_addr(int b
 			(devfn << 8) | (reg & 0xff);
 }
 
+#ifdef CONFIG_PCI_MSI
+extern void rtas_msi_init(void);
+#else
+static inline void rtas_msi_init(void) { }
+#endif
+
 #endif /* __KERNEL__ */
 #endif /* _POWERPC_RTAS_H */
