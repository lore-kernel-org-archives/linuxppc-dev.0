Return-Path: <michael@ozlabs.org>
To: linux-pci@atrey.karlin.mff.cuni.cz
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 25 Jan 2007 19:34:12 +1100
Subject: [RFC/PATCH 9/16] RTAS MSI implementation
In-Reply-To: <1169714047.65693.647693675533.qpush@cradle>
Message-Id: <20070125083414.35F4FDE37E@ozlabs.org>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Kyle McMartin <kyle@parisc-linux.org>,
	linuxppc-dev@ozlabs.org, Brice Goglin <brice@myri.com>,
	shaohua.li@intel.com, "David S. Miller" <davem@davemloft.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Powerpc MSI support via RTAS.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 drivers/pci/msi/Makefile  |    1 
 drivers/pci/msi/rtas.c    |  268 ++++++++++++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/msi.h |    6 +
 3 files changed, 275 insertions(+)

Index: msi/drivers/pci/msi/Makefile
===================================================================
--- msi.orig/drivers/pci/msi/Makefile
+++ msi/drivers/pci/msi/Makefile
@@ -3,6 +3,7 @@
 #
 
 obj-y			+= core.o raw.o
+obj-$(CONFIG_PPC_RTAS)	+= rtas.o
 
 ifeq ($(CONFIG_PCI_MSI_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
Index: msi/drivers/pci/msi/rtas.c
===================================================================
--- /dev/null
+++ msi/drivers/pci/msi/rtas.c
@@ -0,0 +1,268 @@
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
+#include <linux/irq.h>
+#include <linux/msi-ops.h>
+#include <asm/msi.h>
+#include <asm/rtas.h>
+#include <asm/hw_irq.h>
+#include <asm/ppc-pci.h>
+
+static int query_token, change_token;
+
+#define RTAS_QUERY_FN		0
+#define RTAS_CHANGE_FN		1
+#define RTAS_RESET_FN		2
+#define RTAS_CHANGE_MSI_FN	3
+#define RTAS_CHANGE_MSIX_FN	4
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
+static int rtas_change_msi(struct pci_dn *pdn, u32 func, u32 num_irqs)
+{
+	u32 addr, seq_num, rtas_ret[3];
+	unsigned long buid;
+	int rc;
+
+	addr = rtas_config_addr(pdn->busno, pdn->devfn, 0);
+	buid = pdn->phb->buid;
+
+	seq_num = 1;
+	do {
+		if (func == RTAS_CHANGE_MSI_FN || func == RTAS_CHANGE_MSIX_FN)
+			rc = rtas_call(change_token, 6, 4, rtas_ret, addr,
+					BUID_HI(buid), BUID_LO(buid),
+					func, num_irqs, seq_num);
+		else
+			rc = rtas_call(change_token, 6, 3, rtas_ret, addr,
+					BUID_HI(buid), BUID_LO(buid),
+					func, num_irqs, seq_num);
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
+static void rtas_disable_msi(struct pci_dev *pdev)
+{
+	struct pci_dn *pdn;
+
+	pdn = get_pdn(pdev);
+	if (!pdn)
+		return;
+
+	if (rtas_change_msi(pdn, RTAS_CHANGE_FN, 0) != 0) {
+		msi_debug("Setting MSIs to 0 failed!\n");
+		BUG();
+	}
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
+static void msi_rtas_free(struct pci_dev *pdev, int num,
+			struct msix_entry *entries, int type)
+{
+	int i;
+
+	for (i = 0; i < num; i++) {
+		irq_dispose_mapping(entries[i].vector);
+	}
+
+	rtas_disable_msi(pdev);
+}
+
+static int check_req_msi(struct pci_dev *pdev)
+{
+	struct device_node *dn;
+	struct pci_dn *pdn;
+	const u32 *req_msi;
+
+	pdn = get_pdn(pdev);
+	if (!pdn)
+		return -1;
+
+	dn = pdn->node;
+
+	req_msi = get_property(dn, "ibm,req#msi", NULL);
+	if (!req_msi) {
+		msi_debug("No ibm,req#msi for %s\n", pci_name(pdev));
+		return -1;
+	}
+
+	if (*req_msi == 0) {
+		msi_debug("ibm,req#msi requests 0 MSIs for %s\n",
+			  pci_name(pdev));
+		return -1;
+	}
+
+	return 0;
+}
+
+static int msi_rtas_check(struct pci_dev *pdev, int num,
+			struct msix_entry *entries, int type)
+{
+	int i, rc;
+
+	rc = check_req_msi(pdev);
+	if (rc)
+		return rc;
+
+	/*
+	 * Firmware gives us no control over which entries are allocated
+	 * for MSI-X, it seems to assume we want 0 - n. For now just insist
+	 * that the entries array entry members are 0 - n.
+	 */
+	for (i = 0; i < num; i++) {
+		if (entries[i].entry != i) {
+			msi_debug("entries[%d].entry (%d) != %d\n", i,
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
+	int hwirq, virq, i, rc;
+
+	pdn = get_pdn(pdev);
+	if (!pdn)
+		return -1;
+
+	/*
+	 * Try the new more explicit firmware interface, if that fails fall
+	 * back to the old interface. The old interface is known to never
+	 * return MSI-Xs.
+	 */
+	if (type == PCI_CAP_ID_MSI) {
+		rc = rtas_change_msi(pdn, RTAS_CHANGE_MSI_FN, num);
+
+		if (rc != num) {
+			msi_debug("trying the old firmware interface.\n");
+			rc = rtas_change_msi(pdn, RTAS_CHANGE_FN, num);
+		}
+	} else
+		rc = rtas_change_msi(pdn, RTAS_CHANGE_MSIX_FN, num);
+
+	if (rc != num) {
+		msi_debug("rtas_change_msi() failed for %s\n", pci_name(pdev));
+
+		/*
+		 * In case of an error it's not clear whether the device is
+		 * left with MSI enabled or not, so we explicitly disable.
+		 */
+		goto out_free;
+	}
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
+static struct msi_ops rtas_msi_ops = {
+	.check = msi_rtas_check,
+	.alloc = msi_rtas_alloc,
+	.free  = msi_rtas_free
+};
+
+static struct msi_ops *rtas_get_msi_ops(struct pci_dev *pdev)
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
@@ -20,4 +20,10 @@ static inline struct msi_ops *arch_get_m
 	return NULL;
 }
 
+#ifdef CONFIG_PCI_MSI
+extern int msi_rtas_init(void);
+#else
+static inline int msi_rtas_init(void) { return -1; };
+#endif
+
 #endif /* __ASM_POWERPC_MSI_H */
