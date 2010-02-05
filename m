Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id E9B06B8CD0
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Feb 2010 00:44:31 +1100 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 07/11] powerpc/fsl_soc.c: prepare for addition of mpc5121
	USB code
Date: Fri,  5 Feb 2010 14:42:53 +0100
Message-Id: <1265377377-29327-8-git-send-email-agust@denx.de>
In-Reply-To: <1265377377-29327-1-git-send-email-agust@denx.de>
References: <1265377377-29327-1-git-send-email-agust@denx.de>
Cc: Anatolij Gustschin <agust@denx.de>, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Factor out common code for registering a FSL EHCI platform
device into new fsl_usb2_register_device() function. This
is done to avoid code duplication while adding code for
instantiating of MPC5121 dual role USB platform devices.
Then, the subsequent patch can use
for_each_compatible_node(np, NULL, "fsl,mpc5121-usb2-dr") {
	...
	fsl_usb2_register_device();
}

Signed-off-by: Anatolij Gustschin <agust@denx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
Note to avoid confusion: this patch is new in this series
and is needed because for mpc5121 "fsl,mpc5121-usb2-dr" is
used as the compatible property as requested. "fsl-usb2-dr"
won't be used for mpc5121 any more.

 arch/powerpc/sysdev/fsl_soc.c |  219 ++++++++++++++++++-----------------------
 1 files changed, 98 insertions(+), 121 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index b91f7ac..7bd6436 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -209,6 +209,37 @@ static int __init of_add_fixed_phys(void)
 arch_initcall(of_add_fixed_phys);
 #endif /* CONFIG_FIXED_PHY */
 
+struct fsl_usb2_dev_data {
+	char *dr_mode;		/* controller mode */
+	char *drivers[2];	/* drivers to instantiate for this mode */
+	enum fsl_usb2_operating_modes op_mode;	/* operating mode */
+};
+
+struct fsl_usb2_dev_data dr_data[] __initdata = {
+	{ "host",	{ "fsl-ehci",	NULL,		}, FSL_USB2_DR_HOST,  },
+	{ "otg",	{ "fsl-ehci",	"fsl-usb2-udc",	}, FSL_USB2_DR_OTG,   },
+	{ "periferal",	{ "fsl-usb2-udc", NULL,		}, FSL_USB2_DR_DEVICE,},
+};
+
+struct fsl_usb2_dev_data mph_data[] __initdata = {
+	{ NULL,		{ "fsl-ehci",	NULL,		}, FSL_USB2_MPH_HOST, },
+};
+
+struct fsl_usb2_dev_data * __init get_dr_data(struct device_node *np)
+{
+	const unsigned char *prop;
+	int i;
+
+	prop = of_get_property(np, "dr_mode", NULL);
+	if (prop) {
+		for (i = 0; i < ARRAY_SIZE(dr_data); i++) {
+			if (!strcmp(prop, dr_data[i].dr_mode))
+				return &dr_data[i];
+		}
+	}
+	return &dr_data[0]; /* mode not specified, use host */
+}
+
 static enum fsl_usb2_phy_modes determine_usb_phy(const char *phy_type)
 {
 	if (!phy_type)
@@ -225,151 +256,97 @@ static enum fsl_usb2_phy_modes determine_usb_phy(const char *phy_type)
 	return FSL_USB2_PHY_NONE;
 }
 
-static int __init fsl_usb_of_init(void)
+int __init fsl_usb2_register_device(struct device_node *np,
+			struct fsl_usb2_dev_data *dev_data,
+			struct fsl_usb2_platform_data *pdata,
+			unsigned int idx)
 {
-	struct device_node *np;
-	unsigned int i = 0;
-	struct platform_device *usb_dev_mph = NULL, *usb_dev_dr_host = NULL,
-		*usb_dev_dr_client = NULL;
+	struct platform_device *usb_dev;
+	const unsigned char *prop;
+	struct resource r[2];
+	int registered = 0;
 	int ret;
+	int i;
+
+	if (!(dev_data && pdata))
+		return -EINVAL;
+
+	memset(&r, 0, sizeof(r));
+	ret = of_address_to_resource(np, 0, &r[0]);
+	if (ret)
+		return -ENODEV;
+
+	ret = of_irq_to_resource(np, 0, &r[1]);
+	if (ret == NO_IRQ)
+		return -ENODEV;
+
+	pdata->operating_mode = dev_data->op_mode;
+
+	prop = of_get_property(np, "phy_type", NULL);
+	pdata->phy_mode = determine_usb_phy(prop);
+	ret = 0;
+	for (i = 0; i < ARRAY_SIZE(dev_data->drivers); i++) {
+		if (!dev_data->drivers[i])
+			break;
+		usb_dev = platform_device_register_simple(
+					dev_data->drivers[i], idx, r, 2);
+		if (IS_ERR(usb_dev)) {
+			ret = PTR_ERR(usb_dev);
+			goto out;
+		}
 
-	for_each_compatible_node(np, NULL, "fsl-usb2-mph") {
-		struct resource r[2];
-		struct fsl_usb2_platform_data usb_data;
-		const unsigned char *prop = NULL;
-
-		memset(&r, 0, sizeof(r));
-		memset(&usb_data, 0, sizeof(usb_data));
-
-		ret = of_address_to_resource(np, 0, &r[0]);
+		usb_dev->dev.coherent_dma_mask = 0xffffffffUL;
+		usb_dev->dev.dma_mask = &usb_dev->dev.coherent_dma_mask;
+		ret = platform_device_add_data(usb_dev, pdata,
+				sizeof(struct fsl_usb2_platform_data));
 		if (ret)
-			goto err;
-
-		of_irq_to_resource(np, 0, &r[1]);
-
-		usb_dev_mph =
-		    platform_device_register_simple("fsl-ehci", i, r, 2);
-		if (IS_ERR(usb_dev_mph)) {
-			ret = PTR_ERR(usb_dev_mph);
-			goto err;
-		}
+			platform_device_unregister(usb_dev);
+		else
+			registered++;
+	}
+out:
+	if (!registered)
+		irq_dispose_mapping(r[1].end);
 
-		usb_dev_mph->dev.coherent_dma_mask = 0xffffffffUL;
-		usb_dev_mph->dev.dma_mask = &usb_dev_mph->dev.coherent_dma_mask;
+	return ret;
+}
 
-		usb_data.operating_mode = FSL_USB2_MPH_HOST;
+static int __init fsl_usb_of_init(void)
+{
+	struct device_node *np;
+	const unsigned char *prop;
+	struct fsl_usb2_platform_data pdata;
+	unsigned int idx = 0;
+	int ret;
 
+	for_each_compatible_node(np, NULL, "fsl-usb2-mph") {
+		memset(&pdata, 0, sizeof(pdata));
 		prop = of_get_property(np, "port0", NULL);
 		if (prop)
-			usb_data.port_enables |= FSL_USB2_PORT0_ENABLED;
+			pdata.port_enables |= FSL_USB2_PORT0_ENABLED;
 
 		prop = of_get_property(np, "port1", NULL);
 		if (prop)
-			usb_data.port_enables |= FSL_USB2_PORT1_ENABLED;
+			pdata.port_enables |= FSL_USB2_PORT1_ENABLED;
 
-		prop = of_get_property(np, "phy_type", NULL);
-		usb_data.phy_mode = determine_usb_phy(prop);
-
-		ret =
-		    platform_device_add_data(usb_dev_mph, &usb_data,
-					     sizeof(struct
-						    fsl_usb2_platform_data));
+		ret = fsl_usb2_register_device(np, mph_data, &pdata, idx++);
 		if (ret)
-			goto unreg_mph;
-		i++;
+			return ret;
 	}
 
 	for_each_compatible_node(np, NULL, "fsl-usb2-dr") {
-		struct resource r[2];
-		struct fsl_usb2_platform_data usb_data;
-		const unsigned char *prop = NULL;
-
 		if (!of_device_is_available(np))
 			continue;
 
-		memset(&r, 0, sizeof(r));
-		memset(&usb_data, 0, sizeof(usb_data));
-
-		ret = of_address_to_resource(np, 0, &r[0]);
+		memset(&pdata, 0, sizeof(pdata));
+		ret = fsl_usb2_register_device(np, get_dr_data(np),
+						&pdata, idx++);
 		if (ret)
-			goto unreg_mph;
-
-		of_irq_to_resource(np, 0, &r[1]);
-
-		prop = of_get_property(np, "dr_mode", NULL);
-
-		if (!prop || !strcmp(prop, "host")) {
-			usb_data.operating_mode = FSL_USB2_DR_HOST;
-			usb_dev_dr_host = platform_device_register_simple(
-					"fsl-ehci", i, r, 2);
-			if (IS_ERR(usb_dev_dr_host)) {
-				ret = PTR_ERR(usb_dev_dr_host);
-				goto err;
-			}
-		} else if (prop && !strcmp(prop, "peripheral")) {
-			usb_data.operating_mode = FSL_USB2_DR_DEVICE;
-			usb_dev_dr_client = platform_device_register_simple(
-					"fsl-usb2-udc", i, r, 2);
-			if (IS_ERR(usb_dev_dr_client)) {
-				ret = PTR_ERR(usb_dev_dr_client);
-				goto err;
-			}
-		} else if (prop && !strcmp(prop, "otg")) {
-			usb_data.operating_mode = FSL_USB2_DR_OTG;
-			usb_dev_dr_host = platform_device_register_simple(
-					"fsl-ehci", i, r, 2);
-			if (IS_ERR(usb_dev_dr_host)) {
-				ret = PTR_ERR(usb_dev_dr_host);
-				goto err;
-			}
-			usb_dev_dr_client = platform_device_register_simple(
-					"fsl-usb2-udc", i, r, 2);
-			if (IS_ERR(usb_dev_dr_client)) {
-				ret = PTR_ERR(usb_dev_dr_client);
-				goto err;
-			}
-		} else {
-			ret = -EINVAL;
-			goto err;
-		}
-
-		prop = of_get_property(np, "phy_type", NULL);
-		usb_data.phy_mode = determine_usb_phy(prop);
-
-		if (usb_dev_dr_host) {
-			usb_dev_dr_host->dev.coherent_dma_mask = 0xffffffffUL;
-			usb_dev_dr_host->dev.dma_mask = &usb_dev_dr_host->
-				dev.coherent_dma_mask;
-			if ((ret = platform_device_add_data(usb_dev_dr_host,
-						&usb_data, sizeof(struct
-						fsl_usb2_platform_data))))
-				goto unreg_dr;
-		}
-		if (usb_dev_dr_client) {
-			usb_dev_dr_client->dev.coherent_dma_mask = 0xffffffffUL;
-			usb_dev_dr_client->dev.dma_mask = &usb_dev_dr_client->
-				dev.coherent_dma_mask;
-			if ((ret = platform_device_add_data(usb_dev_dr_client,
-						&usb_data, sizeof(struct
-						fsl_usb2_platform_data))))
-				goto unreg_dr;
-		}
-		i++;
+			return ret;
 	}
-	return 0;
 
-unreg_dr:
-	if (usb_dev_dr_host)
-		platform_device_unregister(usb_dev_dr_host);
-	if (usb_dev_dr_client)
-		platform_device_unregister(usb_dev_dr_client);
-unreg_mph:
-	if (usb_dev_mph)
-		platform_device_unregister(usb_dev_mph);
-err:
-	return ret;
+	return 0;
 }
-
 arch_initcall(fsl_usb_of_init);
 
 #if defined(CONFIG_FSL_SOC_BOOKE) || defined(CONFIG_PPC_86xx)
-- 
1.6.3.3
