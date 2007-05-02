Return-Path: <dale@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Wed, 2 May 2007 14:44:17 -0700
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [PATCH 9/13] powerpc: Add arch/powerpc mv64x60 I2C platform data setup
Message-ID: <20070502214416.GD27253@xyzzy.farnsworth.org>
References: <20070425234630.GA4046@mag.az.mvista.com>
	<20070426000043.GK4046@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070426000043.GK4046@mag.az.mvista.com>
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
 arch/powerpc/sysdev/mv64x60_dev.c |   63 ++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

Index: linux-2.6-powerpc-df/arch/powerpc/sysdev/mv64x60_dev.c
===================================================================
--- linux-2.6-powerpc-df.orig/arch/powerpc/sysdev/mv64x60_dev.c
+++ linux-2.6-powerpc-df/arch/powerpc/sysdev/mv64x60_dev.c
@@ -299,6 +299,65 @@ unreg:
 	return err;
 }
 
+/*
+ * Create mv64x60_i2c platform devices
+ */
+static int __init mv64x60_i2c_device_setup(struct device_node *np)
+{
+	struct resource r[2];
+	struct platform_device *pdev;
+	struct mv64xxx_i2c_pdata pdata;
+	const unsigned int *prop;
+	int err;
+	static int called_count;
+	int instance = called_count++;
+
+	memset(&r[1], 0, sizeof(r[1]));
+
+	err = of_address_to_resource(np, 0, &r[0]);
+	if (err)
+		return err;
+
+	of_irq_to_resource(np, 0, &r[1]);
+
+	memset(&pdata, 0, sizeof(pdata));
+
+	prop = of_get_property(np, "freq_m", NULL);
+	if (!prop)
+		return -ENODEV;
+	pdata.freq_m = *prop;
+
+	prop = of_get_property(np, "freq_n", NULL);
+	if (!prop)
+		return -ENODEV;
+	pdata.freq_n = *prop;
+
+	prop = of_get_property(np, "timeout", NULL);
+	if (prop)
+		pdata.timeout = *prop;
+	else
+		pdata.timeout = 1000;	/* 1 second */
+
+	prop = of_get_property(np, "retries", NULL);
+	if (prop)
+		pdata.retries = *prop;
+	else
+		pdata.retries = 1;
+
+	pdev = platform_device_register_simple(MV64XXX_I2C_CTLR_NAME,
+					       instance, r, 2);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	err = platform_device_add_data(pdev, &pdata, sizeof(pdata));
+	if (err) {
+		platform_device_unregister(pdev);
+		return err;
+	}
+
+	return 0;
+}
+
 static int __init mv64x60_device_setup(void)
 {
 	struct device_node *np = NULL;
@@ -312,6 +371,10 @@ static int __init mv64x60_device_setup(v
 		if ((err = mv64x60_eth_device_setup(np)))
 			goto err_ret;
 
+	while ((np = of_find_compatible_node(np, "i2c", "mv64x60-i2c")))
+		if ((err = mv64x60_i2c_device_setup(np)))
+			goto err_ret;
+
 	return 0;
 
 err_ret:
