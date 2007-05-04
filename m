Return-Path: <dale@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Fri, 4 May 2007 14:08:26 -0700
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [PATCH 9/13] powerpc: Create Marvell mv64x60 I2C platform_data
Message-ID: <20070504210826.GC3166@xyzzy.farnsworth.org>
References: <20070425234630.GA4046@mag.az.mvista.com>
	<20070426000043.GK4046@mag.az.mvista.com>
	<20070502214416.GD27253@xyzzy.farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070502214416.GD27253@xyzzy.farnsworth.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Paul Mackerras <paulus@samba.org>,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch creates platform_device entries for the Marvell mv64x60
I2C ports, based on information contained in device tree.

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
---
Latest rev.  I think I've addressed all of Stephen's and Arnd's issues.

 arch/powerpc/sysdev/mv64x60_dev.c |   74 +++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 2 deletions(-)

Index: linux-2.6-powerpc-df/arch/powerpc/sysdev/mv64x60_dev.c
===================================================================
--- linux-2.6-powerpc-df.orig/arch/powerpc/sysdev/mv64x60_dev.c
+++ linux-2.6-powerpc-df/arch/powerpc/sysdev/mv64x60_dev.c
@@ -323,14 +323,79 @@ error:
 	return err;
 }
 
+/*
+ * Create mv64x60_i2c platform devices
+ */
+static int __init mv64x60_i2c_device_setup(struct device_node *np, int id)
+{
+	struct resource r[2];
+	struct platform_device *pdev;
+	struct mv64xxx_i2c_pdata pdata;
+	const unsigned int *prop;
+	int err;
+
+	memset(&r, 0, sizeof(r));
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
+	pdev = platform_device_alloc(MV64XXX_I2C_CTLR_NAME, id);
+	if (!pdev)
+		return -ENOMEM;
+
+	err = platform_device_add_resources(pdev, r, 2);
+	if (err)
+		goto error;
+
+	err = platform_device_add_data(pdev, &pdata, sizeof(pdata));
+	if (err)
+		goto error;
+
+	err = platform_device_add(pdev);
+	if (err)
+		goto error;
+
+	return 0;
+
+error:
+	platform_device_put(pdev);
+	return err;
+}
+
 static int __init mv64x60_device_setup(void)
 {
 	struct device_node *np = NULL;
 	int id;
 	int err;
 
-	for (id = 0;
-	     (np = of_find_compatible_node(np, "serial", "mpsc")); id++)
+	for (id = 0; (np = of_find_compatible_node(np, "serial", "mpsc")); id++)
 		if ((err = mv64x60_mpsc_device_setup(np, id)))
 			goto error;
 
@@ -339,6 +404,11 @@ static int __init mv64x60_device_setup(v
 		if ((err = mv64x60_eth_device_setup(np, id)))
 			goto error;
 
+	for (id = 0;
+	     (np = of_find_compatible_node(np, "i2c", "mv64x60-i2c")); id++)
+		if ((err = mv64x60_i2c_device_setup(np, id)))
+			goto error;
+
 	return 0;
 
 error:
