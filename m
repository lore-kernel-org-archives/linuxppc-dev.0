Return-Path: <dale@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Wed, 2 May 2007 14:41:04 -0700
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [PATCH 7/13] powerpc: Add arch/powerpc mv64x60 MPSC platform data
	setup
Message-ID: <20070502214104.GB27253@xyzzy.farnsworth.org>
References: <20070425234630.GA4046@mag.az.mvista.com>
	<20070425235939.GI4046@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070425235939.GI4046@mag.az.mvista.com>
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

I added a comment describing using platform_device rather than
of_platform_device.  I also rearranged some of the property
setting code.

 arch/powerpc/platforms/embedded6xx/Kconfig |    3 
 arch/powerpc/sysdev/Makefile               |    2 
 arch/powerpc/sysdev/mv64x60_dev.c          |  201 +++++++++++++++++++
 3 files changed, 205 insertions(+), 1 deletion(-)

Index: linux-2.6-powerpc-df/arch/powerpc/sysdev/mv64x60_dev.c
===================================================================
--- /dev/null
+++ linux-2.6-powerpc-df/arch/powerpc/sysdev/mv64x60_dev.c
@@ -0,0 +1,201 @@
+/*
+ * Platform device setup for Marvell mv64360/mv64460 host bridges (Discovery)
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
+#include <linux/mv643xx.h>
+#include <linux/platform_device.h>
+
+#include <asm/prom.h>
+
+/*
+ * These functions provide the necessary setup for the mv64x60 drivers.
+ * These drivers are unusual in that they work on both the MIPS and PowerPC
+ * architectures.  Because of that, the drivers do not support the normal
+ * PowerPC of_platform_bus_type.  They support platform_bus_type instead.
+ */
+
+/*
+ * Create MPSC platform device
+ */
+static int __init mv64x60_mpsc_register_shared_pdev(struct device_node *np)
+{
+	struct platform_device *pdev;
+	struct resource r[2];
+	struct mpsc_shared_pdata pdata;
+	const phandle *ph;
+	struct device_node *mpscrouting, *mpscintr;
+	int err;
+
+	ph = of_get_property(np, "mpscrouting", NULL);
+	mpscrouting = of_find_node_by_phandle(*ph);
+	if (!mpscrouting)
+		return -ENODEV;
+
+	err = of_address_to_resource(mpscrouting, 0, &r[0]);
+	of_node_put(mpscrouting);
+	if (err)
+		return err;
+
+	ph = of_get_property(np, "mpscintr", NULL);
+	mpscintr = of_find_node_by_phandle(*ph);
+	if (!mpscintr)
+		return -ENODEV;
+
+	err = of_address_to_resource(mpscintr, 0, &r[1]);
+	of_node_put(mpscintr);
+	if (err)
+		return err;
+
+	pdev = platform_device_register_simple(MPSC_SHARED_NAME, 0, r, 2);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	memset(&pdata, 0, sizeof(pdata));
+
+	err = platform_device_add_data(pdev, &pdata, sizeof(pdata));
+	if (err)
+		platform_device_unregister(pdev);
+
+	return 0;
+}
+
+static int __init mv64x60_mpsc_device_setup(struct device_node *np)
+{
+	struct resource r[5];
+	struct mpsc_pdata pdata;
+	struct platform_device *pdev;
+	const unsigned int *prop;
+	const phandle *ph;
+	struct device_node *sdma, *brg;
+	int err;
+	int port_number;
+	static int called_count;
+
+	memset(&r, 0, sizeof(r));
+
+	err = of_address_to_resource(np, 0, &r[0]);
+	if (err)
+		return err;
+
+	of_irq_to_resource(np, 0, &r[4]);
+
+	ph = of_get_property(np, "sdma", NULL);
+	sdma = of_find_node_by_phandle(*ph);
+	if (!sdma)
+		return -ENODEV;
+
+	of_irq_to_resource(sdma, 0, &r[3]);
+	err = of_address_to_resource(sdma, 0, &r[1]);
+	of_node_put(sdma);
+	if (err)
+		return err;
+
+	ph = of_get_property(np, "brg", NULL);
+	brg = of_find_node_by_phandle(*ph);
+	if (!brg)
+		return -ENODEV;
+
+	err = of_address_to_resource(brg, 0, &r[2]);
+	of_node_put(brg);
+	if (err)
+		return err;
+
+	memset(&pdata, 0, sizeof(pdata));
+
+	pdata.cache_mgmt = 1; /* All current revs need this set */
+
+	prop = of_get_property(np, "block-index", NULL);
+	if (!prop)
+		return -ENODEV;
+	port_number = *(int *)prop;
+
+	prop = of_get_property(np, "max_idle", NULL);
+	if (prop)
+		pdata.max_idle = *prop;
+
+	prop = of_get_property(brg, "current-speed", NULL);
+	if (prop)
+		pdata.default_baud = *prop;
+
+	/* Default is 8 bits, no parity, no flow control */
+	pdata.default_bits = 8;
+	pdata.default_parity = 'n';
+	pdata.default_flow = 'n';
+
+	prop = of_get_property(np, "chr_1", NULL);
+	if (prop)
+		pdata.chr_1_val = *prop;
+
+	prop = of_get_property(np, "chr_2", NULL);
+	if (prop)
+		pdata.chr_2_val = *prop;
+
+	prop = of_get_property(np, "chr_10", NULL);
+	if (prop)
+		pdata.chr_10_val = *prop;
+
+	prop = of_get_property(np, "mpcr", NULL);
+	if (prop)
+		pdata.mpcr_val = *prop;
+
+	prop = of_get_property(brg, "bcr", NULL);
+	if (prop)
+		pdata.bcr_val = *prop;
+
+	pdata.brg_can_tune = 1; /* All current revs need this set */
+
+	prop = of_get_property(brg, "clock-src", NULL);
+	if (prop)
+		pdata.brg_clk_src = *prop;
+
+	prop = of_get_property(brg, "clock-frequency", NULL);
+	if (prop)
+		pdata.brg_clk_freq = *prop;
+
+	pdev = platform_device_register_simple(MPSC_CTLR_NAME,
+					       port_number, r, 5);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	err = platform_device_add_data(pdev, &pdata, sizeof(pdata));
+	if (err)
+		goto unreg;
+
+	/* only register the shared platform device the first time through */
+	if (called_count++ == 0)
+		if ((err = mv64x60_mpsc_register_shared_pdev(np)))
+			goto unreg;
+
+	return 0;
+
+unreg:
+	platform_device_unregister(pdev);
+	return err;
+}
+
+static int __init mv64x60_device_setup(void)
+{
+	struct device_node *np = NULL;
+	int err;
+
+	while ((np = of_find_compatible_node(np, "serial", "mpsc")))
+		if ((err = mv64x60_mpsc_device_setup(np)))
+			goto err_ret;
+
+	return 0;
+
+err_ret:
+	of_node_put(np);
+	return err;
+}
+arch_initcall(mv64x60_device_setup);
Index: linux-2.6-powerpc-df/arch/powerpc/sysdev/Makefile
===================================================================
--- linux-2.6-powerpc-df.orig/arch/powerpc/sysdev/Makefile
+++ linux-2.6-powerpc-df/arch/powerpc/sysdev/Makefile
@@ -14,7 +14,7 @@ obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
 obj-$(CONFIG_FSL_PCIE)		+= fsl_pcie.o
 obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
 obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
-obj-$(CONFIG_MV64X60)		+= mv64x60_pic.o
+obj-$(CONFIG_MV64X60)		+= mv64x60_pic.o mv64x60_dev.o
 
 # contains only the suspend handler for time
 obj-$(CONFIG_PM)		+= timer.o
Index: linux-2.6-powerpc-df/arch/powerpc/platforms/embedded6xx/Kconfig
===================================================================
--- linux-2.6-powerpc-df.orig/arch/powerpc/platforms/embedded6xx/Kconfig
+++ linux-2.6-powerpc-df/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -38,6 +38,9 @@ config MPC10X_BRIDGE
 	select PPC_INDIRECT_PCI
 	default y
 
+config MV64X60
+	bool
+
 config MPC10X_OPENPIC
 	bool
 	depends on LINKSTATION
