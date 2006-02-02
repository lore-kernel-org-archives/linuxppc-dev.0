Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CBBBC68A31
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Feb 2006 05:38:56 +1100 (EST)
Date: Thu, 2 Feb 2006 12:31:00 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: Add platform support for MPC834x USB controllers
Message-ID: <Pine.LNX.4.44.0602021230260.13198-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Setup the platform devices needed by the Freescale EHCI USB
host controllers based on a flat device tree

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 7ddda6a6630d95f800fbf848b00bd1d685c9bba4
tree 1d20b1c54ce3f28c1c103560bad4abf31ccdc00f
parent 9a8e139654ff5807b5b8fc3f73e9d118f22a3947
author Kumar Gala <galak@kernel.crashing.org> Thu, 02 Feb 2006 12:37:33 -0600
committer Kumar Gala <galak@kernel.crashing.org> Thu, 02 Feb 2006 12:37:33 -0600

 arch/powerpc/sysdev/fsl_soc.c |  140 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 140 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index e0887d5..ceb5846 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -351,3 +351,143 @@ nodev:
 
 arch_initcall(mpc83xx_wdt_init);
 #endif
+
+static enum fsl_usb2_phy_modes determine_usb_phy(char * phy_type)
+{
+	if (!phy_type)
+		return FSL_USB2_PHY_NONE;
+	if (!strcasecmp(phy_type, "ulpi"))
+		return FSL_USB2_PHY_ULPI;
+	if (!strcasecmp(phy_type, "utmi"))
+		return FSL_USB2_PHY_UTMI;
+	if (!strcasecmp(phy_type, "utmi_wide"))
+		return FSL_USB2_PHY_UTMI_WIDE;
+	if (!strcasecmp(phy_type, "serial"))
+		return FSL_USB2_PHY_SERIAL;
+
+	return FSL_USB2_PHY_NONE;
+}
+
+static int __init fsl_usb_of_init(void)
+{
+	struct device_node *np;
+	unsigned int i;
+	struct platform_device *usb_dev;
+	int ret;
+
+	for (np = NULL, i = 0;
+	     (np = of_find_compatible_node(np, "usb", "fsl-usb2-mph")) != NULL;
+	     i++) {
+		struct resource r[2];
+		struct fsl_usb2_platform_data usb_data;
+		unsigned char *prop = NULL;
+
+		memset(&r, 0, sizeof(r));
+		memset(&usb_data, 0, sizeof(usb_data));
+
+		ret = of_address_to_resource(np, 0, &r[0]);
+		if (ret)
+			goto err;
+
+		r[1].start = np->intrs[0].line;
+		r[1].end = np->intrs[0].line;
+		r[1].flags = IORESOURCE_IRQ;
+
+		usb_dev =
+		    platform_device_register_simple("fsl-usb2-mph", i, r, 2);
+		if (IS_ERR(usb_dev)) {
+			ret = PTR_ERR(usb_dev);
+			goto err;
+		}
+
+		usb_dev->dev.coherent_dma_mask = 0xffffffffUL;
+		usb_dev->dev.dma_mask = &usb_dev->dev.coherent_dma_mask;
+
+		usb_data.operating_mode = FSL_USB2_MPH_HOST;
+
+		prop = get_property(np, "port0", NULL);
+		if (prop)
+			usb_data.port_enables |= FSL_USB2_PORT0_ENABLED;
+
+		prop = get_property(np, "port1", NULL);
+		if (prop)
+			usb_data.port_enables |= FSL_USB2_PORT1_ENABLED;
+
+		prop = get_property(np, "phy_type", NULL);
+		usb_data.phy_mode = determine_usb_phy(prop);
+
+		ret =
+		    platform_device_add_data(usb_dev, &usb_data,
+					     sizeof(struct
+						    fsl_usb2_platform_data));
+		if (ret)
+			goto unreg;
+	}
+
+	return 0;
+
+unreg:
+	platform_device_unregister(usb_dev);
+err:
+	return ret;
+}
+
+arch_initcall(fsl_usb_of_init);
+
+static int __init fsl_usb_dr_of_init(void)
+{
+	struct device_node *np;
+	unsigned int i;
+	struct platform_device *usb_dev;
+	int ret;
+
+	for (np = NULL, i = 0;
+	     (np = of_find_compatible_node(np, "usb", "fsl-usb2-dr")) != NULL;
+	     i++) {
+		struct resource r[2];
+		struct fsl_usb2_platform_data usb_data;
+		unsigned char *prop = NULL;
+
+		memset(&r, 0, sizeof(r));
+		memset(&usb_data, 0, sizeof(usb_data));
+
+		ret = of_address_to_resource(np, 0, &r[0]);
+		if (ret)
+			goto err;
+
+		r[1].start = np->intrs[0].line;
+		r[1].end = np->intrs[0].line;
+		r[1].flags = IORESOURCE_IRQ;
+
+		usb_dev =
+		    platform_device_register_simple("fsl-usb2-dr", i, r, 2);
+		if (IS_ERR(usb_dev)) {
+			ret = PTR_ERR(usb_dev);
+			goto err;
+		}
+
+		usb_dev->dev.coherent_dma_mask = 0xffffffffUL;
+		usb_dev->dev.dma_mask = &usb_dev->dev.coherent_dma_mask;
+
+		usb_data.operating_mode = FSL_USB2_DR_HOST;
+
+		prop = get_property(np, "phy_type", NULL);
+		usb_data.phy_mode = determine_usb_phy(prop);
+
+		ret =
+		    platform_device_add_data(usb_dev, &usb_data,
+					     sizeof(struct
+						    fsl_usb2_platform_data));
+		if (ret)
+			goto unreg;
+	}
+
+	return 0;
+
+unreg:
+	platform_device_unregister(usb_dev);
+err:
+	return ret;
+}
+
+arch_initcall(fsl_usb_dr_of_init);
