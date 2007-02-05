Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 7DAC9DDE33
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Feb 2007 20:08:55 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l1598rkw027664
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Feb 2007 02:08:53 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l1598msd027068
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Feb 2007 03:08:49 -0600 (CST)
Message-ID: <45C6F46C.9000000@freescale.com>
Date: Mon, 05 Feb 2007 17:10:04 +0800
From: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
To: Paul <paulus@samba.org>
Subject: [PATCH 2/3] add soc setup code for USB DR OTG mode
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/sysdev/fsl_soc.c |   76 ++++++++++++++++++++++++++++++----------
 1 files changed, 57 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index ad31e56..d9541aa 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -440,7 +440,8 @@ static int __init fsl_usb_of_init(void)
 {
 	struct device_node *np;
 	unsigned int i;
-	struct platform_device *usb_dev_mph = NULL, *usb_dev_dr = NULL;
+	struct platform_device *usb_dev_mph = NULL, *usb_dev_dr_host = NULL,
+		*usb_dev_dr_client = NULL;
 	int ret;
 
 	for (np = NULL, i = 0;
@@ -506,33 +507,70 @@ static int __init fsl_usb_of_init(void)
 
 		of_irq_to_resource(np, 0, &r[1]);
 
-		usb_dev_dr =
-		    platform_device_register_simple("fsl-ehci", i, r, 2);
-		if (IS_ERR(usb_dev_dr)) {
-			ret = PTR_ERR(usb_dev_dr);
-			goto err;
-		}
-
-		usb_dev_dr->dev.coherent_dma_mask = 0xffffffffUL;
-		usb_dev_dr->dev.dma_mask = &usb_dev_dr->dev.coherent_dma_mask;
+		prop = get_property(np, "dr_mode", NULL);
 
-		usb_data.operating_mode = FSL_USB2_DR_HOST;
+		if (prop && !strcmp(prop, "host")) {
+			usb_data.operating_mode = FSL_USB2_DR_HOST;
+			usb_dev_dr_host = platform_device_register_simple(
+					"fsl-ehci", i, r, 2);
+			if (IS_ERR(usb_dev_dr_host)) {
+				ret = PTR_ERR(usb_dev_dr_host);
+				goto err;
+			}
+			
+		} else if (prop && !strcmp(prop, "peripheral")) {
+			usb_data.operating_mode = FSL_USB2_DR_DEVICE;
+			usb_dev_dr_client = platform_device_register_simple(
+					"fsl-usb2-udc", i, r, 2);
+			if (IS_ERR(usb_dev_dr_client)) {
+				ret = PTR_ERR(usb_dev_dr_client);
+				goto err;
+			}
+		} else if (!prop || (prop && !strcmp(prop, "otg"))) {
+			usb_data.operating_mode = FSL_USB2_DR_OTG;
+			usb_dev_dr_host = platform_device_register_simple(
+					"fsl-ehci", i, r, 2);
+			if (IS_ERR(usb_dev_dr_host)) {
+				ret = PTR_ERR(usb_dev_dr_host);
+				goto err;
+			}
+			usb_dev_dr_client = platform_device_register_simple(
+					"fsl-usb2-udc", i, r, 2);
+			if (IS_ERR(usb_dev_dr_client)) {
+				ret = PTR_ERR(usb_dev_dr_client);
+				goto err;
+			}
+		}
 
 		prop = get_property(np, "phy_type", NULL);
 		usb_data.phy_mode = determine_usb_phy(prop);
 
-		ret =
-		    platform_device_add_data(usb_dev_dr, &usb_data,
-					     sizeof(struct
-						    fsl_usb2_platform_data));
-		if (ret)
-			goto unreg_dr;
+		if (usb_dev_dr_host) {
+			usb_dev_dr_host->dev.coherent_dma_mask = 0xffffffffUL;
+			usb_dev_dr_host->dev.dma_mask = &usb_dev_dr_host->
+				dev.coherent_dma_mask;
+			if ((ret = platform_device_add_data(usb_dev_dr_host,
+						&usb_data, sizeof(struct
+						fsl_usb2_platform_data))))
+				goto unreg_dr;
+		}
+		if (usb_dev_dr_client) {
+			usb_dev_dr_client->dev.coherent_dma_mask = 0xffffffffUL;
+			usb_dev_dr_client->dev.dma_mask = &usb_dev_dr_client->
+				dev.coherent_dma_mask;
+			if ((ret = platform_device_add_data(usb_dev_dr_client,
+						&usb_data, sizeof(struct
+						fsl_usb2_platform_data))))
+				goto unreg_dr;
+		}
 	}
 	return 0;
 
 unreg_dr:
-	if (usb_dev_dr)
-		platform_device_unregister(usb_dev_dr);
+	if (usb_dev_dr_host)
+		platform_device_unregister(usb_dev_dr_host);
+	if (usb_dev_dr_client)
+		platform_device_unregister(usb_dev_dr_client);
 unreg_mph:
 	if (usb_dev_mph)
 		platform_device_unregister(usb_dev_mph);
