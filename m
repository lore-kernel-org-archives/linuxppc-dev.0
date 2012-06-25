Return-Path: <anton@samba.org>
Date: Mon, 25 Jun 2012 14:26:17 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, michael@ellerman.id.au,
 miltonm@bga.com, nacc@us.ibm.com, brking@linux.vnet.ibm.com,
 rcj@linux.vnet.ibm.com
Subject: [PATCH 4/4] powerpc: IOMMU fault injection
Message-ID: <20120625142617.337e9bab@kryten>
In-Reply-To: <20120625142353.0a92791a@kryten>
References: <20120625142353.0a92791a@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Add the ability to inject IOMMU faults. We enable this per device
via a fail_iommu sysfs property, similar to fault injection on other
subsystems.

An example:

# lspci
...
0003:01:00.1 Ethernet controller: Emulex Corporation OneConnect 10Gb NIC (be3) (rev 02)

To inject one error to this device:

echo 1 > /sys/bus/pci/devices/0003:01:00.1/fail_iommu
echo 1 > /sys/kernel/debug/fail_iommu/probability
echo 1 > /sys/kernel/debug/fail_iommu/times

As feared, the first failure injected on the be3 results in an
unrecoverable error, taking down both functions of the card
permanently:

be2net 0003:01:00.1: Unrecoverable error in the card

Signed-off-by: Anton Blanchard <anton@samba.org>  
---

Index: linux-build/arch/powerpc/kernel/iommu.c
===================================================================
--- linux-build.orig/arch/powerpc/kernel/iommu.c	2012-06-08 09:01:02.785709100 +1000
+++ linux-build/arch/powerpc/kernel/iommu.c	2012-06-08 09:01:07.489784856 +1000
@@ -33,7 +33,9 @@
 #include <linux/bitmap.h>
 #include <linux/iommu-helper.h>
 #include <linux/crash_dump.h>
+#include <linux/fault-inject.h>
 #include <asm/io.h>
+#include <asm/vio.h>
 #include <asm/prom.h>
 #include <asm/iommu.h>
 #include <asm/pci-bridge.h>
@@ -58,6 +60,94 @@ static int __init setup_iommu(char *str)
 
 __setup("iommu=", setup_iommu);
 
+#ifdef CONFIG_FAIL_IOMMU
+
+static DECLARE_FAULT_ATTR(fail_iommu);
+
+static int __init setup_fail_iommu(char *str)
+{
+	return setup_fault_attr(&fail_iommu, str);
+}
+__setup("fail_iommu=", setup_fail_iommu);
+
+static bool should_fail_iommu(struct device *dev)
+{
+	return dev->archdata.fail_iommu && should_fail(&fail_iommu, 1);
+}
+
+static int __init fail_iommu_debugfs(void)
+{
+	struct dentry *dir = fault_create_debugfs_attr("fail_iommu",
+						       NULL, &fail_iommu);
+
+	return IS_ERR(dir) ? PTR_ERR(dir) : 0;
+}
+late_initcall(fail_iommu_debugfs);
+
+static ssize_t fail_iommu_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", dev->archdata.fail_iommu);
+}
+
+static ssize_t fail_iommu_store(struct device *dev,
+				struct device_attribute *attr, const char *buf,
+				size_t count)
+{
+	int i;
+
+	if (count > 0 && sscanf(buf, "%d", &i) > 0)
+		dev->archdata.fail_iommu = (i == 0) ? 0 : 1;
+
+	return count;
+}
+
+static DEVICE_ATTR(fail_iommu, S_IRUGO|S_IWUSR, fail_iommu_show,
+		   fail_iommu_store);
+
+static int fail_iommu_bus_notify(struct notifier_block *nb,
+				 unsigned long action, void *data)
+{
+	struct device *dev = data;
+
+	if (action == BUS_NOTIFY_ADD_DEVICE) {
+		if (device_create_file(dev, &dev_attr_fail_iommu))
+			pr_warn("Unable to create IOMMU fault injection sysfs "
+				"entries\n");
+	} else if (action == BUS_NOTIFY_DEL_DEVICE) {
+		device_remove_file(dev, &dev_attr_fail_iommu);
+	}
+
+	return 0;
+}
+
+static struct notifier_block fail_iommu_bus_notifier = {
+	.notifier_call = fail_iommu_bus_notify
+};
+
+static int __init fail_iommu_setup(void)
+{
+#ifdef CONFIG_PCI
+	bus_register_notifier(&pci_bus_type, &fail_iommu_bus_notifier);
+#endif
+#ifdef CONFIG_IBMVIO
+	bus_register_notifier(&vio_bus_type, &fail_iommu_bus_notifier);
+#endif
+
+	return 0;
+}
+/*
+ * Must execute after PCI and VIO subsystem have initialised but before
+ * devices are probed.
+ */
+arch_initcall(fail_iommu_setup);
+#else
+static inline bool should_fail_iommu(struct device *dev)
+{
+	return false;
+}
+#endif
+
 static unsigned long iommu_range_alloc(struct device *dev,
 				       struct iommu_table *tbl,
                                        unsigned long npages,
@@ -83,6 +173,9 @@ static unsigned long iommu_range_alloc(s
 		return DMA_ERROR_CODE;
 	}
 
+	if (should_fail_iommu(dev))
+		return DMA_ERROR_CODE;
+
 	if (handle && *handle)
 		start = *handle;
 	else
Index: linux-build/arch/powerpc/include/asm/device.h
===================================================================
--- linux-build.orig/arch/powerpc/include/asm/device.h	2012-06-08 09:01:02.765708778 +1000
+++ linux-build/arch/powerpc/include/asm/device.h	2012-06-08 09:01:07.489784856 +1000
@@ -34,6 +34,9 @@ struct dev_archdata {
 #ifdef CONFIG_EEH
 	struct eeh_dev		*edev;
 #endif
+#ifdef CONFIG_FAIL_IOMMU
+	int fail_iommu;
+#endif
 };
 
 struct pdev_archdata {
Index: linux-build/arch/powerpc/Kconfig.debug
===================================================================
--- linux-build.orig/arch/powerpc/Kconfig.debug	2012-06-08 09:01:02.753708585 +1000
+++ linux-build/arch/powerpc/Kconfig.debug	2012-06-08 09:01:07.489784856 +1000
@@ -331,4 +331,13 @@ config STRICT_DEVMEM
 
 	  If you are unsure, say Y.
 
+config FAIL_IOMMU
+	bool "Fault-injection capability for IOMMU"
+	depends on FAULT_INJECTION
+	help
+	  Provide fault-injection capability for IOMMU. Each device can
+	  be selectively enabled via the fail_iommu property.
+
+	  If you are unsure, say N.
+
 endmenu
