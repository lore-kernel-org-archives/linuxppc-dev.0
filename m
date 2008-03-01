Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.vr.in-berlin.de",
	Issuer "IN-Berlin Server CA (G2)" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 687D8DDED3
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Mar 2008 22:36:22 +1100 (EST)
Date: Sat, 1 Mar 2008 12:36:06 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 3/4] ieee1394: ohci1394: switch on bus power after resume on
	PPC PMac
To: linux1394-devel@lists.sourceforge.net
In-Reply-To: <tkrat.ff90a1c61d90de61@s5r6.in-berlin.de>
Message-ID: <tkrat.cc6eff0684655cd0@s5r6.in-berlin.de>
References: <tkrat.ac97915a5b51e35b@s5r6.in-berlin.de>
	<tkrat.7e8e04e66a38dcd6@s5r6.in-berlin.de>
	<1204340392.15052.455.camel@pasglop>
	<47C90E81.7050603@s5r6.in-berlin.de>
	<tkrat.bc4ca3408428a60b@s5r6.in-berlin.de>
	<tkrat.ffa17a046c55daa9@s5r6.in-berlin.de>
	<tkrat.ff90a1c61d90de61@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The platform feature calls in the suspend method switched off cable
power, but the calls in the resume method did not switch it back on.

Add the necessary feature call to .resume.  Also add the corresponding
call to .suspend to make .suspend's behavior explicitly the same on all
PMacs.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 drivers/ieee1394/ohci1394.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

Index: linux/drivers/ieee1394/ohci1394.c
===================================================================
--- linux.orig/drivers/ieee1394/ohci1394.c
+++ linux/drivers/ieee1394/ohci1394.c
@@ -3340,8 +3340,10 @@ static int ohci1394_pci_suspend(struct p
 	if (machine_is(powermac)) {
 		struct device_node *ofn = pci_device_to_OF_node(pdev);
 
-		if (ofn)
+		if (ofn) {
 			pmac_call_feature(PMAC_FTR_1394_ENABLE, ofn, 0, 0);
+			pmac_call_feature(PMAC_FTR_1394_CABLE_POWER, ofn, 0, 0);
+		}
 	}
 #endif /* CONFIG_PPC_PMAC */
 
@@ -3365,8 +3367,10 @@ static int ohci1394_pci_resume(struct pc
 	if (machine_is(powermac)) {
 		struct device_node *ofn = pci_device_to_OF_node(pdev);
 
-		if (ofn)
+		if (ofn) {
+			pmac_call_feature(PMAC_FTR_1394_CABLE_POWER, ofn, 0, 1);
 			pmac_call_feature(PMAC_FTR_1394_ENABLE, ofn, 0, 1);
+		}
 	}
 #endif /* CONFIG_PPC_PMAC */
 

-- 
Stefan Richter
-=====-==--- --== ----=
http://arcgraph.de/sr/
