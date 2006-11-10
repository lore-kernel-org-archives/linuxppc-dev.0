Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.vr.in-berlin.de",
	Issuer "IN-Berlin Server CA (G2)" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3766167EF5
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 10:23:01 +1100 (EST)
Date: Sat, 11 Nov 2006 00:22:35 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH update 1/3] ieee1394: ohci1394: add PPC_PMAC platform code to
	driver probe
To: linux1394-devel@lists.sourceforge.net
In-Reply-To: <1163200208.4982.193.camel@localhost.localdomain>
Message-ID: <tkrat.8573138b9ed5f558@s5r6.in-berlin.de>
References: <454DBFE7.3090800@s5r6.in-berlin.de>
	<1162724083.28571.235.camel@localhost.localdomain>
	<454DC985.2020203@s5r6.in-berlin.de> <20061106165752.GA25595@aepfle.de>
	<1162851570.28571.361.camel@localhost.localdomain>
	<20061107070839.GA31460@aepfle.de>
	<1162883865.28571.439.camel@localhost.localdomain>
	<tkrat.bedb19657ae90fd7@s5r6.in-berlin.de>
	<tkrat.fa66c98c1012e645@s5r6.in-berlin.de>
	<1163200208.4982.193.camel@localhost.localdomain>
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

Fixes http://bugzilla.kernel.org/show_bug.cgi?id=7431
iBook G3 threw a machine check exception and put the display backlight
to full brightness after ohci1394 was unloaded and reloaded.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Patch update:  There were braces missing.  Thanks to Jens Maurer.

 drivers/ieee1394/ohci1394.c |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

Index: linux/drivers/ieee1394/ohci1394.c
===================================================================
--- linux.orig/drivers/ieee1394/ohci1394.c	2006-11-08 18:19:56.000000000 +0100
+++ linux/drivers/ieee1394/ohci1394.c	2006-11-11 00:12:31.000000000 +0100
@@ -3215,6 +3215,19 @@ static int __devinit ohci1394_pci_probe(
 	struct ti_ohci *ohci;	/* shortcut to currently handled device */
 	resource_size_t ohci_base;
 
+#ifdef CONFIG_PPC_PMAC
+	/* Necessary on some machines if ohci1394 was loaded/ unloaded before */
+	if (machine_is(powermac)) {
+		struct device_node *of_node = pci_device_to_OF_node(dev);
+
+		if (of_node) {
+			pmac_call_feature(PMAC_FTR_1394_CABLE_POWER, of_node,
+					  0, 1);
+			pmac_call_feature(PMAC_FTR_1394_ENABLE, of_node, 0, 1);
+		}
+	}
+#endif /* CONFIG_PPC_PMAC */
+
         if (pci_enable_device(dev))
 		FAIL(-ENXIO, "Failed to enable OHCI hardware");
         pci_set_master(dev);
@@ -3503,10 +3516,8 @@ static void ohci1394_pci_remove(struct p
 #endif
 
 #ifdef CONFIG_PPC_PMAC
-	/* On UniNorth, power down the cable and turn off the chip
-	 * clock when the module is removed to save power on
-	 * laptops. Turning it back ON is done by the arch code when
-	 * pci_enable_device() is called */
+	/* On UniNorth, power down the cable and turn off the chip clock
+	 * to save power on laptops */
 	{
 		struct device_node* of_node;
 
