Return-Path: <domen.puncer@telargo.com>
Received: from out002.atlarge.net (out002.atlarge.net [129.41.63.60])
	by ozlabs.org (Postfix) with ESMTP id 9F32BDDF1A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Mar 2007 18:44:46 +1100 (EST)
Date: Thu, 22 Mar 2007 08:44:43 +0100
From: Domen Puncer <domen.puncer@telargo.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 3/5 v2] mpc52xx suspend: USB
Message-ID: <20070322074443.GB4620@moe.telargo.com>
References: <20070315103959.GA22215@moe.telargo.com>
	<20070315104228.GD22215@moe.telargo.com>
	<528646bc0703150624i2bac5ce4n7beebc88d8acbafe@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <528646bc0703150624i2bac5ce4n7beebc88d8acbafe@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Trivial suspend and resume OF OHCI.
On MPC52xx turn off and on power to ports.


Signed-off-by: Domen Puncer <domen.puncer@telargo.com>

---
 drivers/usb/host/ohci-ppc-of.c |   30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

Index: grant.git/drivers/usb/host/ohci-ppc-of.c
===================================================================
--- grant.git.orig/drivers/usb/host/ohci-ppc-of.c
+++ grant.git/drivers/usb/host/ohci-ppc-of.c
@@ -214,6 +214,32 @@ MODULE_DEVICE_TABLE(of, ohci_hcd_ppc_of_
 #endif
 
 
+#ifdef CONFIG_PM
+static u32 descr_a;
+static int ohci_hcd_ppc_soc_drv_suspend(struct of_device *op,
+		pm_message_t state)
+{
+	struct usb_hcd *hcd = dev_get_drvdata(&op->dev);
+	if (machine_is_compatible("generic-mpc5200")) {
+		struct ohci_hcd *ohci = hcd_to_ohci(hcd);
+
+		descr_a = in_be32(&ohci->regs->roothub.a);
+		out_be32(&ohci->regs->roothub.a, (descr_a & ~0x200) | 0x100);
+	}
+	return 0;
+}
+static int ohci_hcd_ppc_soc_drv_resume(struct of_device *op)
+{
+	struct usb_hcd *hcd = dev_get_drvdata(&op->dev);
+	if (machine_is_compatible("generic-mpc5200")) {
+		struct ohci_hcd *ohci = hcd_to_ohci(hcd);
+
+		out_be32(&ohci->regs->roothub.a, descr_a);
+	}
+	return 0;
+}
+#endif
+
 static struct of_platform_driver ohci_hcd_ppc_of_driver = {
 	.name		= "ppc-of-ohci",
 	.match_table	= ohci_hcd_ppc_of_match,
@@ -221,8 +247,8 @@ static struct of_platform_driver ohci_hc
 	.remove		= ohci_hcd_ppc_of_remove,
 	.shutdown 	= ohci_hcd_ppc_of_shutdown,
 #ifdef CONFIG_PM
-	/*.suspend	= ohci_hcd_ppc_soc_drv_suspend,*/
-	/*.resume	= ohci_hcd_ppc_soc_drv_resume,*/
+	.suspend	= ohci_hcd_ppc_soc_drv_suspend,
+	.resume		= ohci_hcd_ppc_soc_drv_resume,
 #endif
 	.driver		= {
 		.name	= "ppc-of-ohci",
