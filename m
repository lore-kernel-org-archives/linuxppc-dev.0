Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 07 Nov 2006 18:21:23 +1100
Subject: [RFC/PATCH 5/7] RTAS MSI implementation
In-Reply-To: <1162884080.585336.70559261997.qpush@cradle>
Message-Id: <20061107072126.2EE7167CC6@ozlabs.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Greg Kroah-Hartman <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Powerpc MSI support via RTAS. Based on Jake's code.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/msi-rtas.c |  265 +++++++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/msi.h      |    6 
 2 files changed, 271 insertions(+)

Index: msi/arch/powerpc/kernel/msi-rtas.c
===================================================================
--- /dev/null
+++ msi/arch/powerpc/kernel/msi-rtas.c
@@ -0,0 +1,265 @@
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
+#undef DEBUG
+
+#include <linux/irq.h>
+#include <asm/msi.h>
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
+
+static struct pci_dn *get_pdn(struct pci_dev *pdev)
+{
+	struct device_node *dn;
+	struct pci_dn *pdn;
+
+	dn = pci_device_to_OF_node(pdev);
+	if (!dn) {
+		msi_debug("No OF device node for %s\n", pci_name(pdev));
+		return NULL;
+	}
+
+	pdn = PCI_DN(dn);
+	if (!pdn) {
+		msi_debug("No PCI DN for %s\n", pci_name(pdev));
+		return NULL;
+	}
+
+	return pdn;
+}
+
+/* RTAS Helpers */
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
+		msi_debug("error (%d) for %s\n", rc, pci_name(pdn->pcidev));
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
+		msi_debug("error (%d) querying source number for %s\n",
+				rc, pci_name(pdn->pcidev));
+		return rc;
+	}
+
+	return rtas_ret[0];
+}
+
+/*
+ * The spec gives firmware the option to enable either MSI or MSI-X,
+ * this doesn't wash with the Linux API. For the time beinging, we
+ * kludge around that by checking ourselves the right type is enabled.
+ */
+static int check_msi_type(struct pci_dev *pdev, int type)
+{
+	int pos, msi_enabled, msix_enabled;
+	u16 reg;
+
+	pos = pci_find_capability(pdev, PCI_CAP_ID_MSI);
+	if (!pos) {
+		msi_debug("cap (%d) not found for %s\n", type, pci_name(pdev));
+		return -1;
+	}
+
+	pci_read_config_word(pdev, pos + PCI_MSI_FLAGS, &reg);
+
+	msi_enabled = msix_enabled = 0;
+
+	if (reg & PCI_MSI_FLAGS_ENABLE)
+		msi_enabled = 1;
+
+	if (reg & PCI_MSIX_FLAGS_ENABLE)
+		msix_enabled = 1;
+
+	if (type == PCI_CAP_ID_MSI && (msix_enabled || !msi_enabled)) {
+		msi_debug("Expected MSI but got %s.\n",
+				msix_enabled ? "MSI-X" : "none");
+		return -1;
+	}
+
+	if (type == PCI_CAP_ID_MSIX && (msi_enabled || !msix_enabled)) {
+		msi_debug("Expected MSI-X but got %s.\n",
+				msi_enabled ? "MSI" : "none");
+		return -1;
+	}
+
+	return 0;
+}
+
+static void msi_rtas_free(struct pci_dev *pdev, int num,
+			struct msix_entry *entries, int type)
+{
+	struct pci_dn *pdn;
+	int i;
+
+	pdn = get_pdn(pdev);
+	if (!pdn)
+		return;
+
+	for (i = 0; i < num; i++) {
+		irq_dispose_mapping(entries[i].vector);
+	}
+
+	if (rtas_change_msi(pdn, RTAS_CHANGE_MSI_FN, 0) != 0) {
+		msi_debug("Setting MSIs to 0 failed!\n");
+		BUG();
+	}
+}
+
+static int msi_rtas_check(struct pci_dev *pdev, int num,
+			struct msix_entry *entries, int type)
+{
+	struct device_node *dn;
+	int i;
+
+	/* We must have a pci_dn for the RTAS code. */
+	if (!get_pdn(pdev))
+		return -1;
+
+	dn = pci_device_to_OF_node(pdev);
+	if (!of_find_property(dn, "ibm,req#msi", NULL)) {
+		msi_debug("No ibm,req#msi for %s\n", pci_name(pdev));
+		return -1;
+	}
+
+	/*
+	 * Firmware gives us no control over which entries are allocated
+	 * for MSI-X, it seems to assume we want 0 - n. For now just insist
+	 * that the entries array entry members are 0 - n.
+	 */
+	for (i = 0; i < num; i++) {
+		if (entries[i].entry != i) {
+			msi_debug("entries[%d].entry (%d) != %d\n", i
+					entries[i].entry, i);
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+static int msi_rtas_alloc(struct pci_dev *pdev, int num,
+			struct msix_entry *entries, int type)
+{
+	struct pci_dn *pdn;
+	int hwirq, virq, i;
+
+	pdn = get_pdn(pdev);
+	if (!pdn)
+		return -1;
+
+	/*
+	 * In the case of an error it's not clear whether the device is left
+	 * with MSI enabled or not, I think we should explicitly disable.
+	 */
+	if (rtas_change_msi(pdn, RTAS_CHANGE_MSI_FN, num) != num) {
+		msi_debug("rtas_change_msi() failed for %s\n", pci_name(pdev));
+		goto out_free;
+	}
+
+	if (check_msi_type(pdev, type))
+		goto out_free;
+
+	for (i = 0; i < num; i++) {
+		hwirq = rtas_query_irq_number(pdn, i);
+		if (hwirq < 0) {
+			msi_debug("error (%d) getting hwirq for %s\n",
+					hwirq, pci_name(pdev));
+			goto out_free;
+		}
+
+		virq = irq_create_mapping(NULL, hwirq);
+
+		if (virq == NO_IRQ) {
+			msi_debug("Failed mapping hwirq %d\n", hwirq);
+			goto out_free;
+		}
+
+		entries[i].vector = virq;
+	}
+
+	return 0;
+
+ out_free:
+	msi_rtas_free(pdev, num, entries, type);
+	return -1;
+}
+
+static struct ppc_msi_ops rtas_msi_ops = {
+	.check = msi_rtas_check,
+	.alloc = msi_rtas_alloc,
+	.free  = msi_rtas_free
+};
+
+static struct ppc_msi_ops *rtas_get_msi_ops(struct pci_dev *pdev)
+{
+	return &rtas_msi_ops;
+}
+
+int msi_rtas_init(void)
+{
+	query_token  = rtas_token("ibm,query-interrupt-source-number");
+	change_token = rtas_token("ibm,change-msi");
+
+	if ((query_token == RTAS_UNKNOWN_SERVICE) ||
+			(change_token == RTAS_UNKNOWN_SERVICE)) {
+		msi_debug("Couldn't find RTAS tokens, no MSI support.\n");
+		return -1;
+	}
+
+	msi_debug("Registering RTAS MSI ops.\n");
+
+	ppc_md.get_msi_ops = rtas_get_msi_ops;
+
+	return 0;
+}
Index: msi/include/asm-powerpc/msi.h
===================================================================
--- msi.orig/include/asm-powerpc/msi.h
+++ msi/include/asm-powerpc/msi.h
@@ -168,6 +168,12 @@ extern void msi_raw_disable(struct pci_d
 #define msi_debug(fmt, args...)	\
 	pr_debug("MSI:%s:%d: " fmt, __FUNCTION__, __LINE__, ## args)
 
+#ifdef CONFIG_PCI_MSI
+extern int msi_rtas_init(void);
+#else
+static inline int msi_rtas_init(void) { return -1; };
+#endif
+
 #endif /* __ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_MSI_H */
