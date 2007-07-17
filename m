Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1F97BDDE1F
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 10:58:38 +1000 (EST)
To: Greg KH <greg@kroah.com>
From: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: [PATCH] USB_DR host support for FSL MPC831x
Date: Tue, 17 Jul 2007 04:58:32 +0400
Message-ID: <20070717005832.23019.99739.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Modifies fsl_ehci code so that to get USB host working on
mpc831x platform. Verified with MPC8313RDB reference board.

Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>

---

 arch/powerpc/boot/dts/mpc8313erdb.dts |    1 +
 drivers/usb/host/ehci-fsl.c           |    4 +++-
 drivers/usb/host/ehci-hcd.c           |    2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
index 1b351dc..c330e79 100644
--- a/arch/powerpc/boot/dts/mpc8313erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
@@ -90,6 +90,7 @@
 			interrupt-parent = < &ipic >;
 			interrupts = <26 8>;
 			phy_type = "utmi_wide";
+			control_init  = <00000280>; // UTMI ext 48 MHz clk
 		};
 
 		mdio@24520 {
diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index c7a7c59..3e3187b 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -185,12 +185,14 @@ static void mpc83xx_usb_setup(struct usb_hcd *hcd)
 	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
 	struct fsl_usb2_platform_data *pdata;
 	void __iomem *non_ehci = hcd->regs;
+	u32 temp;
 
 	pdata =
 	    (struct fsl_usb2_platform_data *)hcd->self.controller->
 	    platform_data;
 	/* Enable PHY interface in the control reg. */
-	out_be32(non_ehci + FSL_SOC_USB_CTRL, 0x00000004);
+	temp = in_be32(non_ehci + FSL_SOC_USB_CTRL);
+	out_be32(non_ehci + FSL_SOC_USB_CTRL, temp | 0x00000004);
 	out_be32(non_ehci + FSL_SOC_USB_SNOOP1, 0x0000001b);
 
 #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 099aff6..994a127 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -925,7 +925,7 @@ MODULE_LICENSE ("GPL");
 #define	PCI_DRIVER		ehci_pci_driver
 #endif
 
-#ifdef CONFIG_MPC834x
+#if defined(CONFIG_MPC834x) || defined(CONFIG_PPC_MPC831x)
 #include "ehci-fsl.c"
 #define	PLATFORM_DRIVER		ehci_fsl_driver
 #endif
