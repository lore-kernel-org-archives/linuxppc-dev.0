Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3B8C92C03D3
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Mar 2013 01:18:04 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 1 Mar 2013 09:18:01 -0500
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id D8A98C90029
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2013 09:17:58 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r21EHvnb66322498
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Mar 2013 09:17:58 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r21EHvrR009789
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Mar 2013 09:17:57 -0500
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 18/22] powerpc/eeh: PowerNV EEH backends
Date: Fri,  1 Mar 2013 22:17:16 +0800
Message-Id: <1362147440-14096-19-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1362147440-14096-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1362147440-14096-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch adds EEH backends for PowerNV platform. It's notable that
part of those EEH backends call to the I/O chip dependent backends.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/Makefile      |    2 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c |  373 ++++++++++++++++++++++++++
 2 files changed, 374 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/eeh-powernv.c

diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index 09bd0cb..7fe5951 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -3,4 +3,4 @@ obj-y			+= opal-rtc.o opal-nvram.o
 
 obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_PCI)	+= pci.o pci-p5ioc2.o pci-ioda.o
-obj-$(CONFIG_EEH)	+= eeh-ioda.o
+obj-$(CONFIG_EEH)	+= eeh-ioda.o eeh-powernv.o
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
new file mode 100644
index 0000000..7544a48
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -0,0 +1,373 @@
+/*
+ * The file intends to implement the platform dependent EEH operations on
+ * powernv platform. Actually, the powernv was created in order to fully
+ * hypervisor support.
+ *
+ * Copyright Benjamin Herrenschmidt & Gavin Shan, IBM Corporation 2013.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <linux/atomic.h>
+#include <linux/delay.h>
+#include <linux/export.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/msi.h>
+#include <linux/of.h>
+#include <linux/pci.h>
+#include <linux/proc_fs.h>
+#include <linux/rbtree.h>
+#include <linux/sched.h>
+#include <linux/seq_file.h>
+#include <linux/spinlock.h>
+
+#include <asm/eeh.h>
+#include <asm/eeh_event.h>
+#include <asm/io.h>
+#include <asm/iommu.h>
+#include <asm/machdep.h>
+#include <asm/opal.h>
+#include <asm/ppc-pci.h>
+
+#include "powernv.h"
+#include "pci.h"
+
+/**
+ * powernv_eeh_init - EEH platform dependent initialization
+ *
+ * EEH platform dependent initialization on powernv
+ */
+static int powernv_eeh_init(void)
+{
+	/* Set EEH probe mode */
+	eeh_probe_mode_set(EEH_PROBE_MODE_DEV);
+
+	return 0;
+}
+
+/**
+ * powernv_eeh_post_init - EEH platform dependent post initialization
+ *
+ * EEH platform dependent post initialization on powernv. When
+ * the function is called, the EEH PEs and devices should have
+ * been built. If the I/O cache staff has been built, EEH is
+ * ready to supply service.
+ */
+static int powernv_eeh_post_init(void)
+{
+	struct pci_controller *hose;
+	struct pnv_phb *phb;
+	int ret = 0;
+
+	list_for_each_entry(hose, &hose_list, list_node) {
+		phb = hose->private_data;
+
+		if (phb->eeh_ops && phb->eeh_ops->post_init) {
+			ret = phb->eeh_ops->post_init(hose);
+			if (ret)
+				break;
+		}
+	}
+
+	return ret;
+}
+
+/**
+ * powernv_eeh_dev_probe - Do probe on PCI device
+ * @dev: PCI device
+ * @flag: unused
+ *
+ * When EEH module is installed during system boot, all PCI devices
+ * are checked one by one to see if it supports EEH. The function
+ * is introduced for the purpose. By default, EEH has been enabled
+ * on all PCI devices. That's to say, we only need do necessary
+ * initialization on the corresponding eeh device and create PE
+ * accordingly.
+ *
+ * It's notable that's unsafe to retrieve the EEH device through
+ * the corresponding PCI device. During the PCI device hotplug, which
+ * was possiblly triggered by EEH core, the binding between EEH device
+ * and the PCI device isn't built yet.
+ */
+static void *powernv_eeh_dev_probe(struct pci_dev *dev, void *flag)
+{
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+	struct pnv_phb *phb = hose->private_data;
+	struct device_node *dn = pci_device_to_OF_node(dev);
+	struct eeh_dev *edev = of_node_to_eeh_dev(dn);
+
+	/*
+	 * When probing the root bridge, which doesn't have any
+	 * subordinate PCI devices. We don't have OF node for
+	 * the root bridge. So it's not reasonable to continue
+	 * the probing.
+	 */
+	if (!dn || !edev)
+		return NULL;
+
+	/* Skip for PCI-ISA bridge */
+	if ((dev->class >> 8) == PCI_CLASS_BRIDGE_ISA)
+		return NULL;
+
+	/* Initialize eeh device */
+	edev->class_code	= dev->class;
+	edev->mode		= 0;
+	edev->config_addr	= ((dev->bus->number << 8) | dev->devfn);
+	edev->pe_config_addr	= phb->bdfn_to_pe(phb, dev->bus, dev->devfn & 0xff);
+
+	/* Create PE */
+	eeh_add_to_parent_pe(edev);
+
+	/* Enable EEH explicitly */
+	eeh_subsystem_enabled = 1;
+
+	/* Save memory bars */
+	eeh_save_bars(edev);
+
+	return NULL;
+}
+
+/**
+ * powernv_eeh_set_option - Initialize EEH or MMIO/DMA reenable
+ * @pe: EEH PE
+ * @option: operation to be issued
+ *
+ * The function is used to control the EEH functionality globally.
+ * Currently, following options are support according to PAPR:
+ * Enable EEH, Disable EEH, Enable MMIO and Enable DMA
+ */
+static int powernv_eeh_set_option(struct eeh_pe *pe, int option)
+{
+	struct pci_controller *hose = pe->phb;
+	struct pnv_phb *phb = hose->private_data;
+	int ret = -EEXIST;
+
+	/*
+	 * What we need do is pass it down for hardware
+	 * implementation to handle it.
+	 */
+	if (phb->eeh_ops && phb->eeh_ops->set_option)
+		ret = phb->eeh_ops->set_option(pe, option);
+
+	return ret;
+}
+
+/**
+ * powernv_eeh_get_pe_addr - Retrieve PE address
+ * @pe: EEH PE
+ *
+ * Retrieve the PE address according to the given tranditional
+ * PCI BDF (Bus/Device/Function) address.
+ */
+static int powernv_eeh_get_pe_addr(struct eeh_pe *pe)
+{
+	return pe->addr;
+}
+
+/**
+ * powernv_eeh_get_state - Retrieve PE state
+ * @pe: EEH PE
+ * @state: return value
+ *
+ * Retrieve the state of the specified PE. For IODA-compitable
+ * platform, it should be retrieved from IODA table. Therefore,
+ * we prefer passing down to hardware implementation to handle
+ * it.
+ */
+static int powernv_eeh_get_state(struct eeh_pe *pe, int *state)
+{
+	struct pci_controller *hose = pe->phb;
+	struct pnv_phb *phb = hose->private_data;
+	int ret = EEH_STATE_NOT_SUPPORT;
+
+	if (phb->eeh_ops && phb->eeh_ops->get_state)
+		ret = phb->eeh_ops->get_state(pe, state);
+
+	return ret;
+}
+
+/**
+ * powernv_eeh_reset - Reset the specified PE
+ * @pe: EEH PE
+ * @option: reset option
+ *
+ * Reset the specified PE
+ */
+static int powernv_eeh_reset(struct eeh_pe *pe, int option)
+{
+	struct pci_controller *hose = pe->phb;
+	struct pnv_phb *phb = hose->private_data;
+	int ret = -EEXIST;
+
+	if (phb->eeh_ops && phb->eeh_ops->reset)
+		ret = phb->eeh_ops->reset(pe, option);
+
+	return ret;
+}
+
+/**
+ * powernv_eeh_wait_state - Wait for PE state
+ * @pe: EEH PE
+ * @max_wait: maximal period in microsecond
+ *
+ * Wait for the state of associated PE. It might take some time
+ * to retrieve the PE's state.
+ */
+static int powernv_eeh_wait_state(struct eeh_pe *pe, int max_wait)
+{
+	int ret;
+	int mwait;
+
+	while (1) {
+		ret = powernv_eeh_get_state(pe, &mwait);
+
+		/*
+		 * If the PE's state is temporarily unavailable,
+		 * we have to wait for the specified time. Otherwise,
+		 * the PE's state will be returned immediately.
+		 */
+		if (ret != EEH_STATE_UNAVAILABLE)
+			return ret;
+
+		max_wait -= mwait;
+		msleep(mwait);
+	}
+
+	return EEH_STATE_NOT_SUPPORT;
+}
+
+/**
+ * powernv_eeh_get_log - Retrieve error log
+ * @pe: EEH PE
+ * @severity: temporary or permanent error log
+ * @drv_log: driver log to be combined with retrieved error log
+ * @len: length of driver log
+ *
+ * Retrieve the temporary or permanent error from the PE.
+ */
+static int powernv_eeh_get_log(struct eeh_pe *pe, int severity,
+			char *drv_log, unsigned long len)
+{
+	struct pci_controller *hose = pe->phb;
+	struct pnv_phb *phb = hose->private_data;
+	int ret = -EEXIST;
+
+	if (phb->eeh_ops && phb->eeh_ops->get_log)
+		ret = phb->eeh_ops->get_log(pe, severity, drv_log, len);
+
+	return ret;
+}
+
+/**
+ * powernv_eeh_configure_bridge - Configure PCI bridges in the indicated PE
+ * @pe: EEH PE
+ *
+ * The function will be called to reconfigure the bridges included
+ * in the specified PE so that the mulfunctional PE would be recovered
+ * again.
+ */
+static int powernv_eeh_configure_bridge(struct eeh_pe *pe)
+{
+	struct pci_controller *hose = pe->phb;
+	struct pnv_phb *phb = hose->private_data;
+	int ret = 0;
+
+	if (phb->eeh_ops && phb->eeh_ops->configure_bridge)
+		ret = phb->eeh_ops->configure_bridge(pe);
+
+	return ret;
+}
+
+/**
+ * powernv_eeh_read_config - Read PCI config space
+ * @dn: device node
+ * @where: PCI address
+ * @size: size to read
+ * @val: return value
+ *
+ * Read config space from the speicifed device
+ */
+static int powernv_eeh_read_config(struct device_node *dn, int where,
+				   int size, u32 *val)
+{
+	struct eeh_dev *edev = of_node_to_eeh_dev(dn);
+	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
+	struct pci_controller *hose = edev->phb;
+
+	return hose->ops->read(dev->bus, dev->devfn, where, size, val);
+}
+
+/**
+ * powernv_eeh_write_config - Write PCI config space
+ * @dn: device node
+ * @where: PCI address
+ * @size: size to write
+ * @val: value to be written
+ *
+ * Write config space to the specified device
+ */
+static int powernv_eeh_write_config(struct device_node *dn, int where,
+				    int size, u32 val)
+{
+	struct eeh_dev *edev = of_node_to_eeh_dev(dn);
+	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
+	struct pci_controller *hose = edev->phb;
+
+	hose = pci_bus_to_host(dev->bus);
+
+	return hose->ops->write(dev->bus, dev->devfn, where, size, val);
+}
+
+static struct eeh_ops powernv_eeh_ops = {
+	.name                   = "powernv",
+	.init                   = powernv_eeh_init,
+	.post_init              = powernv_eeh_post_init,
+	.of_probe               = NULL,
+	.dev_probe              = powernv_eeh_dev_probe,
+	.set_option             = powernv_eeh_set_option,
+	.get_pe_addr            = powernv_eeh_get_pe_addr,
+	.get_state              = powernv_eeh_get_state,
+	.reset                  = powernv_eeh_reset,
+	.wait_state             = powernv_eeh_wait_state,
+	.get_log                = powernv_eeh_get_log,
+	.configure_bridge       = powernv_eeh_configure_bridge,
+	.read_config            = powernv_eeh_read_config,
+	.write_config           = powernv_eeh_write_config
+};
+
+/**
+ * eeh_powernv_init - Register platform dependent EEH operations
+ *
+ * EEH initialization on powernv platform. This function should be
+ * called before any EEH related functions.
+ */
+static int __init eeh_powernv_init(void)
+{
+	int ret = -EINVAL;
+
+	if (!machine_is(powernv))
+		return ret;
+
+	ret = eeh_ops_register(&powernv_eeh_ops);
+	if (!ret)
+		pr_info("EEH: PowerNV platform initialized\n");
+	else
+		pr_info("EEH: Failed to initialize PowerNV platform (%d)\n", ret);
+
+	return ret;
+}
+
+early_initcall(eeh_powernv_init);
-- 
1.7.5.4
