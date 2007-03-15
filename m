Return-Path: <domen.puncer@telargo.com>
Received: from out002.atlarge.net (out002.atlarge.net [129.41.63.60])
	by ozlabs.org (Postfix) with ESMTP id D2213DDE34
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Mar 2007 21:42:31 +1100 (EST)
Date: Thu, 15 Mar 2007 11:42:28 +0100
From: Domen Puncer <domen.puncer@telargo.com>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH 3/5] mpc52xx suspend: USB
Message-ID: <20070315104228.GD22215@moe.telargo.com>
References: <20070315103959.GA22215@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070315103959.GA22215@moe.telargo.com>
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
+#ifdef CONFIG_PPC_MPC52xx
+	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
+
+	descr_a = in_be32(&ohci->regs->roothub.a);
+	out_be32(&ohci->regs->roothub.a, (descr_a & ~0x200) | 0x100);
+#endif
+	return 0;
+}
+static int ohci_hcd_ppc_soc_drv_resume(struct of_device *op)
+{
+	struct usb_hcd *hcd = dev_get_drvdata(&op->dev);
+#ifdef CONFIG_PPC_MPC52xx
+	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
+
+	out_be32(&ohci->regs->roothub.a, descr_a);
+#endif
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
