Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.vr.in-berlin.de",
	Issuer "IN-Berlin Server CA (G2)" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 354BB67EE5
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 09:45:12 +1100 (EST)
Date: Fri, 10 Nov 2006 23:44:32 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2/2] ieee1394: ohci1394: reformat PPC_PMAC platform code
To: linux1394-devel@lists.sourceforge.net
In-Reply-To: <tkrat.ab4351ec984c9a0c@s5r6.in-berlin.de>
Message-ID: <tkrat.9f00c7946b5b61c0@s5r6.in-berlin.de>
References: <454DBFE7.3090800@s5r6.in-berlin.de>
	<1162724083.28571.235.camel@localhost.localdomain>
	<454DC985.2020203@s5r6.in-berlin.de>
	<454DCCE8.4020402@s5r6.in-berlin.de>
	<1162731544.28571.237.camel@localhost.localdomain>
	<tkrat.ab4351ec984c9a0c@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Cc: linuxppc-dev@ozlabs.org, Gioele Barabucci <dev@gioelebarabucci.com>,
	Olaf Hering <olaf@aepfle.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Adjust whitespace and line lengths

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 drivers/ieee1394/ohci1394.c |   34 ++++++++++++++--------------------
 1 files changed, 14 insertions(+), 20 deletions(-)

Index: linux/drivers/ieee1394/ohci1394.c
===================================================================
--- linux.orig/drivers/ieee1394/ohci1394.c	2006-11-10 23:25:04.000000000 +0100
+++ linux/drivers/ieee1394/ohci1394.c	2006-11-10 23:26:12.000000000 +0100
@@ -3218,12 +3218,11 @@ static int __devinit ohci1394_pci_probe(
 #ifdef CONFIG_PPC_PMAC
 	/* Necessary on some machines if ohci1394 was loaded/ unloaded before */
 	if (machine_is(powermac)) {
-		struct device_node *of_node = pci_device_to_OF_node(dev);
+		struct device_node *ofn = pci_device_to_OF_node(dev);
 
-		if (of_node)
-			pmac_call_feature(PMAC_FTR_1394_CABLE_POWER, of_node,
-					  0, 1);
-			pmac_call_feature(PMAC_FTR_1394_ENABLE, of_node, 0, 1);
+		if (ofn)
+			pmac_call_feature(PMAC_FTR_1394_CABLE_POWER, ofn, 0, 1);
+			pmac_call_feature(PMAC_FTR_1394_ENABLE, ofn, 0, 1);
 	}
 #endif /* CONFIG_PPC_PMAC */
 
@@ -3518,12 +3517,11 @@ static void ohci1394_pci_remove(struct p
 	/* On UniNorth, power down the cable and turn off the chip clock
 	 * to save power on laptops */
 	{
-		struct device_node* of_node;
+		struct device_node* ofn = pci_device_to_OF_node(ohci->dev);
 
-		of_node = pci_device_to_OF_node(ohci->dev);
-		if (of_node) {
-			pmac_call_feature(PMAC_FTR_1394_ENABLE, of_node, 0, 0);
-			pmac_call_feature(PMAC_FTR_1394_CABLE_POWER, of_node, 0, 0);
+		if (ofn) {
+			pmac_call_feature(PMAC_FTR_1394_ENABLE, ofn, 0, 0);
+			pmac_call_feature(PMAC_FTR_1394_CABLE_POWER, ofn, 0, 0);
 		}
 	}
 #endif /* CONFIG_PPC_PMAC */
@@ -3583,12 +3581,10 @@ static int ohci1394_pci_suspend(struct p
 /* PowerMac suspend code comes last */
 #ifdef CONFIG_PPC_PMAC
 	if (machine_is(powermac)) {
-		struct device_node *of_node;
+		struct device_node *ofn = pci_device_to_OF_node(pdev);
 
-		/* Disable 1394 */
-		of_node = pci_device_to_OF_node (pdev);
-		if (of_node)
-			pmac_call_feature(PMAC_FTR_1394_ENABLE, of_node, 0, 0);
+		if (ofn)
+			pmac_call_feature(PMAC_FTR_1394_ENABLE, ofn, 0, 0);
 	}
 #endif /* CONFIG_PPC_PMAC */
 
@@ -3610,12 +3606,10 @@ static int ohci1394_pci_resume(struct pc
 /* PowerMac resume code comes first */
 #ifdef CONFIG_PPC_PMAC
 	if (machine_is(powermac)) {
-		struct device_node *of_node;
+		struct device_node *ofn = pci_device_to_OF_node(pdev);
 
-		/* Re-enable 1394 */
-		of_node = pci_device_to_OF_node (pdev);
-		if (of_node)
-			pmac_call_feature (PMAC_FTR_1394_ENABLE, of_node, 0, 1);
+		if (ofn)
+			pmac_call_feature(PMAC_FTR_1394_ENABLE, ofn, 0, 1);
 	}
 #endif /* CONFIG_PPC_PMAC */
 
