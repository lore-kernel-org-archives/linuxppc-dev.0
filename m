Return-Path: <mgreer@mvista.com>
Date: Tue, 27 Mar 2007 18:11:50 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [RFC 5/8] powerpc: Add arch/powerpc mv64x60 MPSC platform data setup
Message-ID: <20070328011150.GG302@mag.az.mvista.com>
References: <20070328010444.GB302@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070328010444.GB302@mag.az.mvista.com>
Cc: Dale Farnsworth <dfarnsworth@mvista.com>
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

 mv64x60.c |  171 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 171 insertions(+)
---

Index: linux-2.6-powerpc-df/arch/powerpc/sysdev/mv64x60.c
===================================================================
--- linux-2.6-powerpc-df.orig/arch/powerpc/sysdev/mv64x60.c
+++ linux-2.6-powerpc-df/arch/powerpc/sysdev/mv64x60.c
@@ -16,6 +16,9 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
+#include <linux/string.h>
+#include <linux/mv643xx.h>
+#include <linux/platform_device.h>
 
 #include <asm/byteorder.h>
 #include <asm/io.h>
@@ -316,3 +319,171 @@ int __init mv64x60_verify_cache_coherenc
 }
 
 late_initcall(mv64x60_verify_cache_coherency);
+
+#if defined(CONFIG_SERIAL_MPSC) || defined(CONFIG_SERIAL_MPSC_MODULE)
+static int __init mv64x60_mpsc_register_shared_pdev(struct device_node *np)
+{
+	struct platform_device *pdev;
+	struct resource r[2];
+	struct mpsc_shared_pdata pdata;
+	const phandle *ph;
+	struct device_node *mpscrouting, *mpscintr;
+	int err;
+
+	ph = get_property(np, "mpscrouting", NULL);
+	mpscrouting = of_find_node_by_phandle(*ph);
+	if (!mpscrouting)
+		return -ENODEV;
+
+	err = of_address_to_resource(mpscrouting, 0, &r[0]);
+	of_node_put(mpscrouting);
+	if (err)
+		return err;
+
+	ph = get_property(np, "mpscintr", NULL);
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
+		ph = get_property(np, "sdma", NULL);
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
+		ph = get_property(np, "brg", NULL);
+		brg = of_find_node_by_phandle(*ph);
+		if (!brg) {
+			err = -ENODEV;
+			goto ret_node_put;
+		}
+
+		err = of_address_to_resource(brg, 0, &r[2]);
+		of_node_put(brg);
+		if (err) {
+			goto ret_node_put;
+		}
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
+		prop = get_property(np, "max_idle", NULL);
+		if (prop)
+			pdata.max_idle = *prop;
+
+		prop = get_property(brg, "current-speed", NULL);
+		if (prop)
+			pdata.default_baud = *prop;
+
+		/* Default is 8 bits, no parity, no flow control */
+		pdata.default_bits = 8;
+		pdata.default_parity = 'n';
+		pdata.default_flow = 'n';
+
+		prop = get_property(np, "chr_1", NULL);
+		if (prop)
+			pdata.chr_1_val = *prop;
+
+		prop = get_property(np, "chr_2", NULL);
+		if (prop)
+			pdata.chr_2_val = *prop;
+
+		prop = get_property(np, "chr_10", NULL);
+		if (prop)
+			pdata.chr_10_val = *prop;
+
+		prop = get_property(np, "mpcr", NULL);
+		if (prop)
+			pdata.mpcr_val = *prop;
+
+		prop = get_property(brg, "bcr", NULL);
+		if (prop)
+			pdata.bcr_val = *prop;
+
+		pdata.brg_can_tune = 1; /* All current revs need this set */
+
+		prop = get_property(brg, "clock-src", NULL);
+		if (prop)
+			pdata.brg_clk_src = *prop;
+
+		prop = get_property(brg, "clock-frequency", NULL);
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
+
+#endif /* defined(CONFIG_SERIAL_MPSC) || defined(CONFIG_SERIAL_MPSC_MODULE) */
