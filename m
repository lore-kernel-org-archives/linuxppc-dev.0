Return-Path: <mgreer@mvista.com>
Date: Wed, 25 Apr 2007 16:59:39 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 7/13] powerpc: Add arch/powerpc mv64x60 MPSC platform data
	setup
Message-ID: <20070425235939.GI4046@mag.az.mvista.com>
References: <20070425234630.GA4046@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070425234630.GA4046@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Dale Farnsworth <dale@farnsworth.org>

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
---

 mv64x60.c |  170 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 170 insertions(+)

Index: linux-2.6-powerpc-df/arch/powerpc/sysdev/mv64x60.c
===================================================================
--- linux-2.6-powerpc-df.orig/arch/powerpc/sysdev/mv64x60.c
+++ linux-2.6-powerpc-df/arch/powerpc/sysdev/mv64x60.c
@@ -15,6 +15,9 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
+#include <linux/string.h>
+#include <linux/mv643xx.h>
+#include <linux/platform_device.h>
 
 #include <asm/byteorder.h>
 #include <asm/io.h>
@@ -341,3 +344,170 @@ int __init mv64x60_verify_cache_coherenc
 }
 
 late_initcall(mv64x60_verify_cache_coherency);
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
+static int __init mv64x60_mpsc_platform_device_init(void)
+{
+	struct device_node *np = NULL;
+	unsigned int i;
+	struct platform_device *pdev;
+	int err;
+
+	for (i = 0; (np = of_find_compatible_node(np, "serial", "mpsc")); i++) {
+		struct resource r[5];
+		struct mpsc_pdata pdata;
+		const unsigned int *prop;
+		const phandle *ph;
+		struct device_node *sdma, *brg;
+
+		memset(&r, 0, sizeof(r));
+
+		if (i == 0) {
+			err = mv64x60_mpsc_register_shared_pdev(np);
+			if (err)
+				goto ret_node_put;
+		}
+
+		err = of_address_to_resource(np, 0, &r[0]);
+		if (err)
+			goto ret_node_put;
+
+		of_irq_to_resource(np, 0, &r[4]);
+
+		ph = of_get_property(np, "sdma", NULL);
+		sdma = of_find_node_by_phandle(*ph);
+		if (!sdma) {
+			err = -ENODEV;
+			goto ret_node_put;
+		}
+		of_irq_to_resource(sdma, 0, &r[3]);
+		err = of_address_to_resource(sdma, 0, &r[1]);
+		of_node_put(sdma);
+		if (err)
+			goto ret_node_put;
+
+		ph = of_get_property(np, "brg", NULL);
+		brg = of_find_node_by_phandle(*ph);
+		if (!brg) {
+			err = -ENODEV;
+			goto ret_node_put;
+		}
+
+		err = of_address_to_resource(brg, 0, &r[2]);
+		of_node_put(brg);
+		if (err)
+			goto ret_node_put;
+
+		pdev = platform_device_register_simple(MPSC_CTLR_NAME, i, r, 5);
+		if (IS_ERR(pdev)) {
+			err = PTR_ERR(pdev);
+			goto ret_node_put;
+		}
+
+		memset(&pdata, 0, sizeof(pdata));
+
+		pdata.cache_mgmt = 1; /* All current revs need this set */
+
+		prop = of_get_property(np, "max_idle", NULL);
+		if (prop)
+			pdata.max_idle = *prop;
+
+		prop = of_get_property(brg, "current-speed", NULL);
+		if (prop)
+			pdata.default_baud = *prop;
+
+		/* Default is 8 bits, no parity, no flow control */
+		pdata.default_bits = 8;
+		pdata.default_parity = 'n';
+		pdata.default_flow = 'n';
+
+		prop = of_get_property(np, "chr_1", NULL);
+		if (prop)
+			pdata.chr_1_val = *prop;
+
+		prop = of_get_property(np, "chr_2", NULL);
+		if (prop)
+			pdata.chr_2_val = *prop;
+
+		prop = of_get_property(np, "chr_10", NULL);
+		if (prop)
+			pdata.chr_10_val = *prop;
+
+		prop = of_get_property(np, "mpcr", NULL);
+		if (prop)
+			pdata.mpcr_val = *prop;
+
+		prop = of_get_property(brg, "bcr", NULL);
+		if (prop)
+			pdata.bcr_val = *prop;
+
+		pdata.brg_can_tune = 1; /* All current revs need this set */
+
+		prop = of_get_property(brg, "clock-src", NULL);
+		if (prop)
+			pdata.brg_clk_src = *prop;
+
+		prop = of_get_property(brg, "clock-frequency", NULL);
+		if (prop)
+			pdata.brg_clk_freq = *prop;
+
+		err = platform_device_add_data(pdev, &pdata, sizeof(pdata));
+		if (err)
+			goto ret_unreg;
+		of_node_put(np);
+	}
+
+	return 0;
+
+ret_unreg:
+	platform_device_unregister(pdev);
+ret_node_put:
+	of_node_put(np);
+	return err;
+}
+
+arch_initcall(mv64x60_mpsc_platform_device_init);
