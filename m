Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <ee0594c9d1803c11227837bfbe80335927cc63e2.1209537097.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] Merge Axon MSI trigger debugging
Date: Wed, 30 Apr 2008 16:31:43 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I've forward-ported this patch three times now, so we should just put
it in the tree and save the trouble. It's all inside #ifdef DEBUG so
causes no harm unless it's enabled.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/axon_msi.c |   58 ++++++++++++++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index c39f5c2..8b055bc 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -14,6 +14,7 @@
 #include <linux/pci.h>
 #include <linux/msi.h>
 #include <linux/of_platform.h>
+#include <linux/debugfs.h>
 
 #include <asm/dcr.h>
 #include <asm/machdep.h>
@@ -69,8 +70,19 @@ struct axon_msic {
 	dma_addr_t fifo_phys;
 	dcr_host_t dcr_host;
 	u32 read_offset;
+#ifdef DEBUG
+	u32 __iomem *trigger;
+#endif
 };
 
+#ifdef DEBUG
+void axon_msi_debug_setup(struct device_node *dn, struct axon_msic *msic);
+#else
+static inline void axon_msi_debug_setup(struct device_node *dn,
+					struct axon_msic *msic) { }
+#endif
+
+
 static void msic_dcr_write(struct axon_msic *msic, unsigned int dcr_n, u32 val)
 {
 	pr_debug("axon_msi: dcr_write(0x%x, 0x%x)\n", val, dcr_n);
@@ -381,6 +393,8 @@ static int axon_msi_probe(struct of_device *device,
 	ppc_md.teardown_msi_irqs = axon_msi_teardown_msi_irqs;
 	ppc_md.msi_check_device = axon_msi_check_device;
 
+	axon_msi_debug_setup(dn, msic);
+
 	printk(KERN_DEBUG "axon_msi: setup MSIC on %s\n", dn->full_name);
 
 	return 0;
@@ -418,3 +432,47 @@ static int __init axon_msi_init(void)
 	return of_register_platform_driver(&axon_msi_driver);
 }
 subsys_initcall(axon_msi_init);
+
+
+#ifdef DEBUG
+static int msic_set(void *data, u64 val)
+{
+	struct axon_msic *msic = data;
+	out_le32(msic->trigger, val);
+	return 0;
+}
+
+static int msic_get(void *data, u64 *val)
+{
+	*val = 0;
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(fops_msic, msic_get, msic_set, "%llu\n");
+
+void axon_msi_debug_setup(struct device_node *dn, struct axon_msic *msic)
+{
+	char name[8];
+	u64 addr;
+
+	addr = of_translate_address(dn, of_get_property(dn, "reg", NULL));
+	if (addr == OF_BAD_ADDR) {
+		pr_debug("axon_msi: couldn't translate reg property\n");
+		return;
+	}
+
+	msic->trigger = ioremap(addr, 0x4);
+	if (!msic->trigger) {
+		pr_debug("axon_msi: ioremap failed\n");
+		return;
+	}
+
+	snprintf(name, sizeof(name), "msic_%d", of_node_to_nid(dn));
+
+	if (!debugfs_create_file(name, 0600, powerpc_debugfs_root,
+				 msic, &fops_msic)) {
+		pr_debug("axon_msi: debugfs_create_file failed!\n");
+		return;
+	}
+}
+#endif /* DEBUG */
-- 
1.5.5
