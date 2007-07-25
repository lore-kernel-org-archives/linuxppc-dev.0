Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 5C4D0DDEDC
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 06:03:18 +1000 (EST)
Date: Wed, 25 Jul 2007 13:06:19 -0700
From: Dave Jiang <djiang@mvista.com>
To: paulus@samba.org
Subject: [PATCH 1/2] powerpc: Marvell 64x60 EDAC platform devices setup
Message-ID: <20070725200619.GA28059@blade.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, bluesmoke-devel@lists.sourceforge.net,
	norsk5@yahoo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Creating platform devices (memory controller, sram error registers, cpu
error registers, PCI error registers) for Error Detection and Correction
(EDAC) driver.

The platform devices allow the mv64x60 EDAC driver to detect errors from
the memory controller (ECC erorrs), SRAM controller, CPU data path error
registers, and PCI error registers. The errors are reported to syslog.
Software ECC scrubbing is provided. These replace the mv64x60 error handlers
in the ppc branch. They are being moved to EDAC subsystem in order to
centralize error reporting.

The error reporting can be triggered via interrupts from the mv64x60 bridge
chip or via polling mechanism provided by the EDAC core code.

Signed-off-by: Dave Jiang <djiang@mvista.com>
Acked-by: Dale Farnsworth <dale@farnsworth.org>

---

 arch/powerpc/sysdev/mv64x60_dev.c |  115 +++++++++++++++++++++++++++++++++----
 1 files changed, 103 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/sysdev/mv64x60_dev.c b/arch/powerpc/sysdev/mv64x60_dev.c
index b618fa6..bc8cd5a 100644
--- a/arch/powerpc/sysdev/mv64x60_dev.c
+++ b/arch/powerpc/sysdev/mv64x60_dev.c
@@ -17,6 +17,7 @@
 #include <linux/platform_device.h>
 
 #include <asm/prom.h>
+#include <asm/io.h>
 
 /*
  * These functions provide the necessary setup for the mv64x60 drivers.
@@ -390,30 +391,120 @@ error:
 	return err;
 }
 
+static int __init mv64x60_edac_pdev_init(struct device_node *np,
+					  int id,
+					  int num_addr,
+					  char *pdev_name)
+{
+	struct resource *r;
+	struct platform_device *pdev;
+	int i, ret;
+
+	r = kzalloc(num_addr * sizeof(*r) + sizeof(*r), GFP_KERNEL);
+	if (!r)
+		return -ENOMEM;
+
+	for (i = 0; i < num_addr; i++) {
+		ret = of_address_to_resource(np, i, &r[i]);
+		if (ret) {
+			kfree(r);
+			return ret;
+		}
+	}
+
+	of_irq_to_resource(np, 0, &r[i]);
+
+	pdev = platform_device_register_simple(pdev_name, id, r, num_addr + 1);
+
+	kfree(r);
+
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	return 0;
+}
+
+#ifdef CONFIG_PCI
+/*
+ * Bit 0 of MV64x60_PCIx_ERR_MASK does not exist on the 64360 and because of
+ * errata FEr-#11 and FEr-##16 for the 64460, it should be 0 on that chip as
+ * well.  IOW, don't set bit 0.
+ */
+#define MV64X60_PCIx_ERR_MASK_VAL	0x00a50c24
+
+/* Erratum FEr PCI-#16: clear bit 0 of PCI SERRn Mask reg. */
+static int __init mv64x60_pci_fixup(struct device_node *np)
+{
+	struct resource res;
+	void __iomem *pci_serr;
+	int ret;
+
+	ret = of_address_to_resource(np, 1, &res);
+	if (ret)
+		return ret;
+
+	pci_serr = ioremap(res.start, res.end - res.start + 1);
+	if (!pci_serr)
+		return -ENOMEM;
+
+	out_le32(pci_serr, in_le32(pci_serr) & ~0x1);
+	iounmap(pci_serr);
+
+	return 0;
+}
+#endif	/* CONFIG_PCI */
+
 static int __init mv64x60_device_setup(void)
 {
 	struct device_node *np = NULL;
 	int id;
 	int err;
 
-	for (id = 0;
-	     (np = of_find_compatible_node(np, "serial", "marvell,mpsc")); id++)
-		if ((err = mv64x60_mpsc_device_setup(np, id)))
+	id = 0;
+	for_each_compatible_node(np, "serial", "marvell,mpsc")
+		if ((err = mv64x60_mpsc_device_setup(np, id++)))
+			goto error;
+
+	id = 0;
+	for_each_compatible_node(np, "network", "marvell,mv64x60-eth")
+		if ((err = mv64x60_eth_device_setup(np, id++)))
 			goto error;
 
-	for (id = 0;
-	     (np = of_find_compatible_node(np, "network",
-					   "marvell,mv64x60-eth"));
-	     id++)
-		if ((err = mv64x60_eth_device_setup(np, id)))
+	id = 0;
+	for_each_compatible_node(np, "i2c", "marvell,mv64x60-i2c")
+		if ((err = mv64x60_i2c_device_setup(np, id++)))
 			goto error;
 
-	for (id = 0;
-	     (np = of_find_compatible_node(np, "i2c", "marvell,mv64x60-i2c"));
-	     id++)
-		if ((err = mv64x60_i2c_device_setup(np, id)))
+	id = 0;
+	for_each_compatible_node(np, NULL, "marvell,mv64x60-mem-ctrl")
+		if ((err = mv64x60_edac_pdev_init(np, id++, 1,
+						  "mv64x60_mc_err")))
 			goto error;
 
+	id = 0;
+	for_each_compatible_node(np, NULL, "marvell,mv64x60-cpu-error")
+		if ((err = mv64x60_edac_pdev_init(np, id++, 2,
+						  "mv64x60_cpu_err")))
+			goto error;
+
+	id = 0;
+	for_each_compatible_node(np, NULL, "marvell,mv64x60-sram-ctrl")
+		if ((err = mv64x60_edac_pdev_init(np, id++, 1,
+						  "mv64x60_sram_err")))
+			goto error;
+
+#ifdef CONFIG_PCI
+	id = 0;
+	for_each_compatible_node(np, NULL, "marvell,mv64x60-pci-error") {
+		if ((err = mv64x60_pci_fixup(np)))
+			goto error;
+
+		if ((err = mv64x60_edac_pdev_init(np, id++, 1,
+						  "mv64x60_pci_err")))
+			goto error;
+	}
+#endif
+
 	return 0;
 
 error:
