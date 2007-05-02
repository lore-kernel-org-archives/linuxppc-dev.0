Return-Path: <dale@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Wed, 2 May 2007 14:46:09 -0700
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [PATCH 10/13] powerpc: Add arch/powerpc mv64x60 PCI setup
Message-ID: <20070502214609.GE27253@xyzzy.farnsworth.org>
References: <20070425234630.GA4046@mag.az.mvista.com>
	<20070426000107.GL4046@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070426000107.GL4046@mag.az.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Dale Farnsworth <dale@farnsworth.org>

---
I took Arnd Bergmann's advice and put the mv64x60 PCI setup code
in its own file.

 arch/powerpc/platforms/embedded6xx/Kconfig |    1 
 arch/powerpc/sysdev/Makefile               |    4 
 arch/powerpc/sysdev/mv64x60.h              |    2 
 arch/powerpc/sysdev/mv64x60_pci.c          |  190 +++++++++++++++++++
 4 files changed, 197 insertions(+)

Index: linux-2.6-powerpc-df/arch/powerpc/sysdev/Makefile
===================================================================
--- linux-2.6-powerpc-df.orig/arch/powerpc/sysdev/Makefile
+++ linux-2.6-powerpc-df/arch/powerpc/sysdev/Makefile
@@ -16,6 +16,10 @@ obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pc
 obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
 obj-$(CONFIG_MV64X60)		+= mv64x60_pic.o mv64x60_dev.o
 
+ifeq ($(CONFIG_PCI),y)
+obj-$(CONFIG_MV64X60)		+= mv64x60_pci.o
+endif
+
 # contains only the suspend handler for time
 obj-$(CONFIG_PM)		+= timer.o
 
Index: linux-2.6-powerpc-df/arch/powerpc/sysdev/mv64x60.h
===================================================================
--- linux-2.6-powerpc-df.orig/arch/powerpc/sysdev/mv64x60.h
+++ linux-2.6-powerpc-df/arch/powerpc/sysdev/mv64x60.h
@@ -16,4 +16,6 @@ extern int __init mv64x60_device_probe(s
 extern void __init mv64x60_init_irq(void);
 extern unsigned int mv64x60_get_irq(void);
 
+extern void __init mv64x60_pci_init(void);
+
 #endif /* __MV64X60_H__ */
Index: linux-2.6-powerpc-df/arch/powerpc/sysdev/mv64x60_pci.c
===================================================================
--- /dev/null
+++ linux-2.6-powerpc-df/arch/powerpc/sysdev/mv64x60_pci.c
@@ -0,0 +1,190 @@
+/*
+ * PCI bus setup for Marvell mv64360/mv64460 host bridges (Discovery)
+ *
+ * Author: Dale Farnsworth <dale@farnsworth.org>
+ *
+ * 2007 (c) MontaVista, Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+
+#include <asm/prom.h>
+#include <asm/pci-bridge.h>
+
+static int mv64x60_pci_exclude_bridge = 1;
+static struct pci_controller *mv64x60_primary_hose;
+static int mv64x60_pci2_busno;
+
+#ifdef CONFIG_SYSFS
+/* 32-bit hex or dec stringified number + '\n' */
+#define MV64X60_VAL_LEN_MAX		11
+#define MV64X60_PCICFG_CPCI_HOTSWAP	0x68
+
+DECLARE_MUTEX(mv64x60_hs_lock);
+
+static ssize_t mv64x60_hs_reg_read(struct kobject *kobj, char *buf, loff_t off,
+				   size_t count)
+{
+	u32 v;
+	int save_exclude;
+
+	if (off > 0)
+		return 0;
+	if (count < MV64X60_VAL_LEN_MAX)
+		return -EINVAL;
+
+	if (down_interruptible(&mv64x60_hs_lock))
+		return -ERESTARTSYS;
+	save_exclude = mv64x60_pci_exclude_bridge;
+	mv64x60_pci_exclude_bridge = 0;
+	early_read_config_dword(mv64x60_primary_hose, 0, PCI_DEVFN(0, 0),
+				MV64X60_PCICFG_CPCI_HOTSWAP, &v);
+	mv64x60_pci_exclude_bridge = save_exclude;
+	up(&mv64x60_hs_lock);
+
+	return sprintf(buf, "0x%08x\n", v);
+}
+
+static ssize_t mv64x60_hs_reg_write(struct kobject *kobj, char *buf,
+				    loff_t off, size_t count)
+{
+	u32 v;
+	int save_exclude;
+
+	if (off > 0)
+		return 0;
+	if (count <= 0)
+		return -EINVAL;
+
+	if (sscanf(buf, "%i", &v) == 1) {
+		if (down_interruptible(&mv64x60_hs_lock))
+			return -ERESTARTSYS;
+		save_exclude = mv64x60_pci_exclude_bridge;
+		mv64x60_pci_exclude_bridge = 0;
+		early_write_config_dword(mv64x60_primary_hose, 0,
+					 PCI_DEVFN(0, 0),
+					 MV64X60_PCICFG_CPCI_HOTSWAP, v);
+		mv64x60_pci_exclude_bridge = save_exclude;
+		up(&mv64x60_hs_lock);
+	}
+	else
+		count = -EINVAL;
+
+	return count;
+}
+
+static struct bin_attribute mv64x60_hs_reg_attr = { /* Hotswap register */
+	.attr = {
+		.name = "hs_reg",
+		.mode = S_IRUGO | S_IWUSR,
+		.owner = THIS_MODULE,
+	},
+	.size  = MV64X60_VAL_LEN_MAX,
+	.read  = mv64x60_hs_reg_read,
+	.write = mv64x60_hs_reg_write,
+};
+
+static int __init mv64x60_sysfs_init(void)
+{
+	struct device_node *np;
+	struct platform_device *pdev;
+	const unsigned int *prop;
+
+	np = of_find_compatible_node(NULL, NULL, "mv64x60");
+	if (!np)
+		return 0;
+
+	pdev = platform_device_register_simple("mv64x60", 0, NULL, 0);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	prop = of_get_property(np, "hs_reg_valid", NULL);
+	of_node_put(np);
+	if (!prop)
+		return 0;
+
+	return sysfs_create_bin_file(&pdev->dev.kobj, &mv64x60_hs_reg_attr);
+}
+
+subsys_initcall(mv64x60_sysfs_init);
+
+#endif /* CONFIG_SYSFS */
+
+static int mv64x60_exclude_device(u_char bus, u_char devfn)
+{
+	if ((bus == 0 || bus == mv64x60_pci2_busno) &&
+	    PCI_SLOT(devfn) == 0 && mv64x60_pci_exclude_bridge)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int __init mv64x60_add_bridge(struct device_node *dev)
+{
+	int len;
+	struct pci_controller *hose;
+	struct resource rsrc;
+	const int *bus_range;
+	int primary;
+
+	memset(&rsrc, 0, sizeof(rsrc));
+
+	/* Fetch host bridge registers address */
+	if (of_address_to_resource(dev, 0, &rsrc)) {
+		printk(KERN_ERR "No PCI reg property in device tree\n");
+		return -ENODEV;
+	}
+
+	/* Get bus range if any */
+	bus_range = of_get_property(dev, "bus-range", &len);
+	if (bus_range == NULL || len < 2 * sizeof(int))
+		printk(KERN_WARNING "Can't get bus-range for %s, assume"
+		       " bus 0\n", dev->full_name);
+
+	hose = pcibios_alloc_controller();
+	if (!hose)
+		return -ENOMEM;
+
+	hose->arch_data = dev;
+	hose->set_cfg_type = 1;
+
+	hose->first_busno = bus_range ? bus_range[0] : 0;
+	hose->last_busno = bus_range ? bus_range[1] : 0xff;
+	primary = hose->first_busno == 0;
+
+	setup_indirect_pci(hose, rsrc.start, rsrc.start + 4);
+
+	if (primary)
+		mv64x60_primary_hose = hose;
+	else {
+		hose->bus_offset = hose->first_busno;
+		mv64x60_pci2_busno = hose->first_busno;
+	}
+
+	printk(KERN_INFO "Found MV64x60 PCI host bridge at 0x%016llx. "
+	       "Firmware bus number: %d->%d\n",
+	       (unsigned long long)rsrc.start, hose->first_busno,
+	       hose->last_busno);
+
+	/* Interpret the "ranges" property */
+	/* This also maps the I/O region and sets isa_io/mem_base */
+	pci_process_bridge_OF_ranges(hose, dev, primary);
+
+	return 0;
+}
+
+void __init mv64x60_pci_init(void)
+{
+	struct device_node *np = NULL;
+
+	ppc_md.pci_exclude_device = mv64x60_exclude_device;
+
+	while ((np = of_find_compatible_node(np, "pci", "mv64x60-pci")))
+		mv64x60_add_bridge(np);
+}
Index: linux-2.6-powerpc-df/arch/powerpc/platforms/embedded6xx/Kconfig
===================================================================
--- linux-2.6-powerpc-df.orig/arch/powerpc/platforms/embedded6xx/Kconfig
+++ linux-2.6-powerpc-df/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -40,6 +40,7 @@ config MPC10X_BRIDGE
 
 config MV64X60
 	bool
+	select PPC_INDIRECT_PCI
 
 config MPC10X_OPENPIC
 	bool
