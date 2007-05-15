Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 45E1FDDF2F
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 02:47:52 +1000 (EST)
Date: Tue, 15 May 2007 09:51:44 -0700
From: Dave Jiang <djiang@mvista.com>
To: paulus@samba.org
Subject: [PATCH] powerpc: EDAC platform devices setup for Marvell/mv64x60
Message-ID: <20070515165144.GA3179@blade.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, dfarnsworth@mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Creating platform devices (memory controller, sram error registers, cpu error
registers, pci error registers) for EDAC driver on the Marvell/mv64x60 chip.

Signed-off-by: Dave Jiang <djiang@mvista.com>

---

 arch/powerpc/sysdev/mv64x60_dev.c |  183 +++++++++++++++++++++++++++++++++++++
 1 files changed, 183 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/mv64x60_dev.c b/arch/powerpc/sysdev/mv64x60_dev.c
index 4b0a9c8..ce37ab8 100644
--- a/arch/powerpc/sysdev/mv64x60_dev.c
+++ b/arch/powerpc/sysdev/mv64x60_dev.c
@@ -16,6 +16,7 @@
 #include <linux/platform_device.h>
 
 #include <asm/prom.h>
+#include <asm/io.h>
 
 /*
  * These functions provide the necessary setup for the mv64x60 drivers.
@@ -389,6 +390,154 @@ error:
 	return err;
 }
 
+/*
+ * Platform device setup for EDAC memory controller
+ */
+static int __init mv64x60_mem_ctrl_init(struct device_node *np, int id)
+{
+	struct resource r[2];
+	struct platform_device *pdev;
+	int ret;
+
+	memset(r, 0, sizeof(r));
+
+	ret = of_address_to_resource(np, 0, &r[0]);
+	if (ret)
+		goto err;
+
+	of_irq_to_resource(np, 0, &r[1]);
+
+	pdev = platform_device_register_simple("mv64x60_mc_err", id, r, 2);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	return 0;
+
+err:
+	return ret;
+}
+
+/*
+ * Platform device setup for EDAC CPU errors
+ */
+static int __init mv64x60_cpu_error_init(struct device_node *np, int id)
+{
+	struct resource r[3];
+	struct platform_device *pdev;
+	int ret;
+
+	memset(r, 0, sizeof(r));
+
+	ret = of_address_to_resource(np, 0, &r[0]);
+	if (ret)
+		goto err;
+
+	ret = of_address_to_resource(np, 1, &r[1]);
+	if (ret)
+		goto err;
+
+	of_irq_to_resource(np, 0, &r[2]);
+
+	pdev = platform_device_register_simple("mv64x60_cpu_err", id, r, 3);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	return 0;
+
+err:
+	return ret;
+}
+
+/*
+ * Platform device setup for EDAC SRAM errors
+ */
+static int __init mv64x60_sram_ctrl_init(struct device_node *np, int id)
+{
+	struct resource r[2];
+	struct platform_device *pdev;
+	int ret;
+
+	memset(r, 0, sizeof(r));
+
+	ret = of_address_to_resource(np, 0, &r[0]);
+	if (ret)
+		goto err;
+
+	of_irq_to_resource(np, 0, &r[1]);
+
+	pdev = platform_device_register_simple("mv64x60_sram_err", id, r, 2);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	return 0;
+
+err:
+	return ret;
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
+
+/*
+ * Platform device setup for EDAC PCI errors
+ */
+static int __init mv64x60_pci_error_init(struct device_node *np, int id)
+{
+	struct resource r[2];
+	struct platform_device *pdev;
+	int ret;
+
+	memset(r, 0, sizeof(r));
+
+	ret = mv64x60_pci_fixup(np);
+	if (ret)
+		goto err;
+
+	ret = of_address_to_resource(np, 0, &r[0]);
+	if (ret)
+		goto err;
+
+	of_irq_to_resource(np, 0, &r[1]);
+
+	pdev = platform_device_register_simple("mv64x60_pci_err", id, r, 2);
+	if (IS_ERR(pdev)) {
+		ret = PTR_ERR(pdev);
+		goto err;
+	}
+
+	return 0;
+
+err:
+	return ret;
+}
+#endif	/* CONFIG_PCI */
+
 static int __init mv64x60_device_setup(void)
 {
 	struct device_node *np = NULL;
@@ -413,6 +562,40 @@ static int __init mv64x60_device_setup(void)
 		if ((err = mv64x60_i2c_device_setup(np, id)))
 			goto error;
 
+	for (id = 0;
+	     (np = of_find_compatible_node(np, 
+					   NULL, 
+					   "marvell,mv64x60-mem-ctrl"));
+	     id++)
+		if ((err = mv64x60_mem_ctrl_init(np, id)))
+			goto error;
+
+	for (id = 0;
+	     (np = of_find_compatible_node(np, 
+					   NULL, 
+					   "marvell,mv64x60-cpu-error"));
+	     id++)
+		if ((err = mv64x60_cpu_error_init(np, id)))
+			goto error;
+
+	for (id = 0;
+	     (np = of_find_compatible_node(np, 
+					   NULL, 
+					   "marvell,mv64x60-sram-ctrl"));
+	     id++)
+		if ((err = mv64x60_sram_ctrl_init(np, id)))
+			goto error;
+
+#ifdef CONFIG_PCI
+	for (id = 0;
+	     (np = of_find_compatible_node(np, 
+					   NULL, 
+					   "marvell,mv64x60-pci-error"));
+	     id++)
+		if ((err = mv64x60_pci_error_init(np, id)))
+			goto error;
+#endif
+
 	return 0;
 
 error:
