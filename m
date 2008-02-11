Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 68774DDEF5
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 09:48:03 +1100 (EST)
Date: Mon, 11 Feb 2008 15:50:23 -0700
From: Dave Jiang <djiang@mvista.com>
To: paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Marvell 64x60 EDAC platform devices setup
Message-ID: <20080211225023.GA15541@blade.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
Software ECC scrubbing is provided. These replace the mv64x60 error
handlers in the ppc branch. They are being moved to EDAC subsystem in
order to centralize error reporting.

The error reporting can be triggered via interrupts from the mv64x60 bridge
chip or via polling mechanism provided by the EDAC core code.

Signed-off-by: Dave Jiang <djiang@mvista.com>
Acked-by: Dale Farnsworth <dale@farnsworth.org>

---
commit 0acbcb74052fbd5823bfb262619db52dedc85a86
tree 905f2c324a4d55bbcde78d60f2537a5027a831fa
parent da914292a37172fa14ec8080d2a71bf014672b58
author Dave Jiang <djiang@blade.(none)> Mon, 11 Feb 2008 15:43:22 -0700
committer Dave Jiang <djiang@blade.(none)> Mon, 11 Feb 2008 15:43:22 -0700

 arch/powerpc/sysdev/mv64x60_dev.c |   94 +++++++++++++++++++++++++++++++++++++
 1 files changed, 94 insertions(+), 0 deletions(-)

The mv64x60 EDAC driver is in mainline now

diff --git a/arch/powerpc/sysdev/mv64x60_dev.c b/arch/powerpc/sysdev/mv64x60_dev.c
index efda002..c9edd66 100644
--- a/arch/powerpc/sysdev/mv64x60_dev.c
+++ b/arch/powerpc/sysdev/mv64x60_dev.c
@@ -17,6 +17,7 @@
 #include <linux/platform_device.h>
 
 #include <asm/prom.h>
+#include <asm/io.h>
 
 /*
  * These functions provide the necessary setup for the mv64x60 drivers.
@@ -439,6 +440,69 @@ error:
 	return err;
 }
 
+static int __init mv64x60_edac_pdev_init(struct device_node *np,
+                                         int id,
+                                         int num_addr,
+                                         char *pdev_name)
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
+#define MV64X60_PCIx_ERR_MASK_VAL      0x00a50c24
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
+#endif /* CONFIG_PCI */
+
 static int __init mv64x60_device_setup(void)
 {
 	struct device_node *np = NULL;
@@ -460,6 +524,36 @@ static int __init mv64x60_device_setup(void)
 		if ((err = mv64x60_i2c_device_setup(np, id++)))
 			goto error;
 
+	id = 0;
+	for_each_compatible_node(np, NULL, "marvell,mv64x60-mem-ctrl")
+		if ((err = mv64x60_edac_pdev_init(np, id++, 1,
+							"mv64x60_mc_err")))
+			goto error;
+
+	id = 0;
+	for_each_compatible_node(np, NULL, "marvell,mv64x60-cpu-error")
+		if ((err = mv64x60_edac_pdev_init(np, id++, 2,
+							"mv64x60_cpu_err")))
+			goto error;
+
+	id = 0;
+	for_each_compatible_node(np, NULL, "marvell,mv64x60-sram-ctrl")
+		if ((err = mv64x60_edac_pdev_init(np, id++, 1,
+							"mv64x60_sram_err")))
+			goto error;
+
+#ifdef CONFIG_PCI
+	id = 0;
+	for_each_compatible_node(np, NULL, "marvell,mv64x60-pci-error") {
+		if ((err = mv64x60_pci_fixup(np)))
+			goto error;
+
+		if ((err = mv64x60_edac_pdev_init(np, id++, 1,
+							"mv64x60_pci_err")))
+			goto error;
+	}
+#endif
+
 	/* support up to one watchdog timer */
 	np = of_find_compatible_node(np, NULL, "marvell,mv64x60-wdt");
 	if (np) {
