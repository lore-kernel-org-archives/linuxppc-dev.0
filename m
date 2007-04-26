Return-Path: <mgreer@mvista.com>
Date: Wed, 25 Apr 2007 17:00:44 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 9/13] powerpc: Add arch/powerpc mv64x60 I2C platform data setup
Message-ID: <20070426000043.GK4046@mag.az.mvista.com>
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

 mv64x60.c |   75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

Index: linux-2.6-powerpc-df/arch/powerpc/sysdev/mv64x60.c
===================================================================
--- linux-2.6-powerpc-df.orig/arch/powerpc/sysdev/mv64x60.c
+++ linux-2.6-powerpc-df/arch/powerpc/sysdev/mv64x60.c
@@ -646,3 +646,78 @@ ret_node_put:
 }
 
 arch_initcall(mv64x60_eth_platform_device_init);
+
+/*
+ * Create mv64x60_i2c platform device
+ */
+static int __init mv64x60_i2c_platform_device_init(void)
+{
+	struct device_node *np = NULL;
+	int i;
+	struct platform_device *pdev;
+	int err;
+
+	for (i = 0;
+	     (np = of_find_compatible_node(np, "i2c", "mv64x60-i2c"));
+	     i++) {
+		struct resource r[2];
+		struct mv64xxx_i2c_pdata pdata;
+		const unsigned int *prop;
+
+		err = of_address_to_resource(np, 0, &r[0]);
+		if (err)
+			goto ret_node_put;
+
+		memset(&r[1], 0, sizeof(r[1]));
+		of_irq_to_resource(np, 0, &r[1]);
+
+		pdev = platform_device_register_simple(MV64XXX_I2C_CTLR_NAME,
+						       0, r, 2);
+		if (IS_ERR(pdev)) {
+			err = PTR_ERR(pdev);
+			goto ret_node_put;
+		}
+
+		memset(&pdata, 0, sizeof(pdata));
+
+		prop = of_get_property(np, "freq_m", NULL);
+		if (!prop) {
+			err = -ENODEV;
+			goto ret_unreg;
+		}
+		pdata.freq_m = *prop;
+
+		prop = of_get_property(np, "freq_n", NULL);
+		if (!prop) {
+			err = -ENODEV;
+			goto ret_unreg;
+		}
+		pdata.freq_n = *prop;
+
+		prop = of_get_property(np, "timeout", NULL);
+		if (prop)
+			pdata.timeout = *prop;
+		else
+			pdata.timeout = 1000;	/* 1 second */
+
+		prop = of_get_property(np, "retries", NULL);
+		if (prop)
+			pdata.retries = *prop;
+		else
+			pdata.retries = 1;
+
+		err = platform_device_add_data(pdev, &pdata, sizeof(pdata));
+		if (err)
+			goto ret_unreg;
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
+arch_initcall(mv64x60_i2c_platform_device_init);
