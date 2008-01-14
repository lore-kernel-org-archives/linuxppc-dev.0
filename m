Return-Path: <mgreer@mvista.com>
Date: Mon, 14 Jan 2008 15:51:50 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/4] powerpc: mv64x60 - Use early_* PCI accessors for hotswap
	reg
Message-ID: <20080114225150.GB21940@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Mark A. Greer <mgreer@mvista.com>

The mv64x60 Hotswap register is on the first hose of the mv64x60
hostbridge.  To access it, manually find the hose structure and
use the early_* PCI accessor routines because the hostbridge is
normally hidden.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---
 arch/powerpc/sysdev/mv64x60.h     |   22 ++++++++++++++++++++++
 arch/powerpc/sysdev/mv64x60_pci.c |   25 +++++++++++++++----------
 2 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/sysdev/mv64x60.h b/arch/powerpc/sysdev/mv64x60.h
index 4f618fa..27e22f4 100644
--- a/arch/powerpc/sysdev/mv64x60.h
+++ b/arch/powerpc/sysdev/mv64x60.h
@@ -3,10 +3,32 @@
 
 #include <linux/init.h>
 
+#include <asm/prom.h>
+#include <asm/pci-bridge.h>
+
 extern void __init mv64x60_init_irq(void);
 extern unsigned int mv64x60_get_irq(void);
 
 extern void __init mv64x60_pci_init(void);
 extern void __init mv64x60_init_early(void);
 
+static inline struct pci_controller *mv64x60_find_hose(u32 idx)
+{
+	struct device_node *phb;
+	struct pci_controller *hose;
+	const u32 *prop;
+	int len;
+
+	for_each_compatible_node(phb, "pci", "marvell,mv64360-pci") {
+		prop = of_get_property(phb, "cell-index", &len);
+		if (prop && (len == sizeof(prop)) && (*prop == idx)) {
+			hose = pci_find_hose_for_OF_device(phb);
+			of_node_put(phb);
+			return hose;
+		}
+	}
+
+	return NULL;
+}
+
 #endif /* __MV64X60_H__ */
diff --git a/arch/powerpc/sysdev/mv64x60_pci.c b/arch/powerpc/sysdev/mv64x60_pci.c
index 1456015..2115177 100644
--- a/arch/powerpc/sysdev/mv64x60_pci.c
+++ b/arch/powerpc/sysdev/mv64x60_pci.c
@@ -17,6 +17,8 @@
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
 
+#include <sysdev/mv64x60.h>
+
 #define PCI_HEADER_TYPE_INVALID		0x7f	/* Invalid PCI header type */
 
 #ifdef CONFIG_SYSFS
@@ -24,11 +26,12 @@
 #define MV64X60_VAL_LEN_MAX		11
 #define MV64X60_PCICFG_CPCI_HOTSWAP	0x68
 
+/* cPCI Hotswap register only supported on PCI 0 interface */
 static ssize_t mv64x60_hs_reg_read(struct kobject *kobj,
 				   struct bin_attribute *attr, char *buf,
 				   loff_t off, size_t count)
 {
-	struct pci_dev *phb;
+	struct pci_controller *hose;
 	u32 v;
 
 	if (off > 0)
@@ -36,11 +39,12 @@ static ssize_t mv64x60_hs_reg_read(struct kobject *kobj,
 	if (count < MV64X60_VAL_LEN_MAX)
 		return -EINVAL;
 
-	phb = pci_get_bus_and_slot(0, PCI_DEVFN(0, 0));
-	if (!phb)
+	hose = mv64x60_find_hose(0);
+	if (!hose)
 		return -ENODEV;
-	pci_read_config_dword(phb, MV64X60_PCICFG_CPCI_HOTSWAP, &v);
-	pci_dev_put(phb);
+
+	early_read_config_dword(hose, 0, PCI_DEVFN(0, 0),
+			MV64X60_PCICFG_CPCI_HOTSWAP, &v);
 
 	return sprintf(buf, "0x%08x\n", v);
 }
@@ -49,7 +53,7 @@ static ssize_t mv64x60_hs_reg_write(struct kobject *kobj,
 				    struct bin_attribute *attr, char *buf,
 				    loff_t off, size_t count)
 {
-	struct pci_dev *phb;
+	struct pci_controller *hose;
 	u32 v;
 
 	if (off > 0)
@@ -60,11 +64,12 @@ static ssize_t mv64x60_hs_reg_write(struct kobject *kobj,
 	if (sscanf(buf, "%i", &v) != 1)
 		return -EINVAL;
 
-	phb = pci_get_bus_and_slot(0, PCI_DEVFN(0, 0));
-	if (!phb)
+	hose = mv64x60_find_hose(0);
+	if (!hose)
 		return -ENODEV;
-	pci_write_config_dword(phb, MV64X60_PCICFG_CPCI_HOTSWAP, v);
-	pci_dev_put(phb);
+
+	early_write_config_dword(hose, 0, PCI_DEVFN(0, 0),
+			MV64X60_PCICFG_CPCI_HOTSWAP, v);
 
 	return count;
 }
