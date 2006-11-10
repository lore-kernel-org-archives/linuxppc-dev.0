Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.vr.in-berlin.de",
	Issuer "IN-Berlin Server CA (G2)" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5422B67F4F
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 10:27:03 +1100 (EST)
Date: Sat, 11 Nov 2006 00:26:24 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH update 3/3] ieee1394: ohci1394: call PMac code in shutdown
	only for proper machines
To: linux1394-devel@lists.sourceforge.net
In-Reply-To: <tkrat.210c1fb372b68f41@s5r6.in-berlin.de>
Message-ID: <tkrat.9fa7eb5af4b571c3@s5r6.in-berlin.de>
References: <454DBFE7.3090800@s5r6.in-berlin.de>
	<1162724083.28571.235.camel@localhost.localdomain>
	<454DC985.2020203@s5r6.in-berlin.de> <20061106165752.GA25595@aepfle.de>
	<1162851570.28571.361.camel@localhost.localdomain>
	<20061107070839.GA31460@aepfle.de>
	<1162883865.28571.439.camel@localhost.localdomain>
	<tkrat.bedb19657ae90fd7@s5r6.in-berlin.de>
	<tkrat.fa66c98c1012e645@s5r6.in-berlin.de>
	<1163200208.4982.193.camel@localhost.localdomain>
	<tkrat.8573138b9ed5f558@s5r6.in-berlin.de>
	<tkrat.210c1fb372b68f41@s5r6.in-berlin.de>
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

There has been an if(...) missing, for ages.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 drivers/ieee1394/ohci1394.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux/drivers/ieee1394/ohci1394.c
===================================================================
--- linux.orig/drivers/ieee1394/ohci1394.c	2006-11-11 00:13:45.000000000 +0100
+++ linux/drivers/ieee1394/ohci1394.c	2006-11-11 00:16:37.000000000 +0100
@@ -3517,7 +3517,7 @@ static void ohci1394_pci_remove(struct p
 #ifdef CONFIG_PPC_PMAC
 	/* On UniNorth, power down the cable and turn off the chip clock
 	 * to save power on laptops */
-	{
+	if (machine_is(powermac)) {
 		struct device_node* ofn = pci_device_to_OF_node(ohci->dev);
 
 		if (ofn) {
