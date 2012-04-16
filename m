Return-Path: <tkil@scrye.com>
Received: from mail.scrye.com (unknown
 [IPv6:2001:470:b8bc:cafe:5054:ff:fedc:793f])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.scrye.com", Issuer "mail.scrye.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8DF3DB6FF9
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Apr 2012 14:56:33 +1000 (EST)
To: linux-usb@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: PPC / USB: kernel hangs in warm boot on 8513 in fsl-ehci
From: Anthony Foiani <tkil@scrye.com>
Date: Sun, 15 Apr 2012 22:45:50 -0600
Message-ID: <gsjg4i8sh.fsf@dworkin.scrye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Reply-To: Anthony Foiani <tkil@scrye.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Greetings.

I'm working on an embedded board using the MPC8315E processor.  After
many (10-20+) warm boots, the kernel boot sequence will eventually
hang here:

  ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
  /immr@e0000000/usb@23000: Invalid 'dr_mode' property, fallback to host mode
  fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host Controller
  fsl-ehci fsl-ehci.0: new USB bus registered, assigned bus number 1

On a normal boot, it continues with the irq/iomem message:

  ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
  /immr@e0000000/usb@23000: Invalid 'dr_mode' property, fallback to host mode
  fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host Controller
  fsl-ehci fsl-ehci.0: new USB bus registered, assigned bus number 1
  fsl-ehci fsl-ehci.0: irq 38, io mem 0xe0023000
  fsl-ehci fsl-ehci.0: USB 2.0 started, EHCI 1.00

I found a recent conversation about a similar hang on the 5020,
including one patch that had made it into -stable, along with a few
other patches that didn't but maybe should; please see my exchange
with Greg KH here:

  https://lkml.org/lkml/2012/4/13/10

I did apply the most obvious set of patches to my kernel, but I'm
still seeing hangs.  I'm using 3.0.6 with vendor patches and a few
other odds and ends applied.  The only relevant change to fsl-ehci is
the one inspired by the patches mentioned in the above message:

------------------------------------------------------------------------
diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index f380bf9..ac4ca27 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -217,6 +217,9 @@ static void ehci_fsl_setup_phy(struct ehci_hcd *ehci,
 {
 	u32 portsc;
 
+	struct usb_hcd *hcd = ehci_to_hcd(ehci);
+	void __iomem *non_ehci = hcd->regs;
+
 	portsc = ehci_readl(ehci, &ehci->regs->port_status[port_offset]);
 	portsc &= ~(PORT_PTS_MSK | PORT_PTS_PTW);
 
@@ -231,6 +234,9 @@ static void ehci_fsl_setup_phy(struct ehci_hcd *ehci,
 		portsc |= PORT_PTS_PTW;
 		/* fall through */
 	case FSL_USB2_PHY_UTMI:
+		/* enable UTMI PHY */
+		setbits32(non_ehci + FSL_SOC_USB_CTRL, CTRL_UTMI_PHY_EN);
+		msleep(10);
 		portsc |= PORT_PTS_UTMI;
 		break;
 	case FSL_USB2_PHY_NONE:
@@ -252,21 +258,18 @@ static void ehci_fsl_usb_setup(struct ehci_hcd *ehci)
 	if (pdata->have_sysif_regs) {
 		temp = in_be32(non_ehci + FSL_SOC_USB_CTRL);
 		out_be32(non_ehci + FSL_SOC_USB_CTRL, temp | 0x00000004);
-		out_be32(non_ehci + FSL_SOC_USB_SNOOP1, 0x0000001b);
-	}
 
-#if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
-	/*
-	 * Turn on cache snooping hardware, since some PowerPC platforms
-	 * wholly rely on hardware to deal with cache coherent
-	 */
+		/*
+		* Turn on cache snooping hardware, since some PowerPC platforms
+		* wholly rely on hardware to deal with cache coherent
+		*/
 
-	/* Setup Snooping for all the 4GB space */
-	/* SNOOP1 starts from 0x0, size 2G */
-	out_be32(non_ehci + FSL_SOC_USB_SNOOP1, 0x0 | SNOOP_SIZE_2GB);
-	/* SNOOP2 starts from 0x80000000, size 2G */
-	out_be32(non_ehci + FSL_SOC_USB_SNOOP2, 0x80000000 | SNOOP_SIZE_2GB);
-#endif
+		/* Setup Snooping for all the 4GB space */
+		/* SNOOP1 starts from 0x0, size 2G */
+		out_be32(non_ehci + FSL_SOC_USB_SNOOP1, 0x0 | SNOOP_SIZE_2GB);
+		/* SNOOP2 starts from 0x80000000, size 2G */
+		out_be32(non_ehci + FSL_SOC_USB_SNOOP2, 0x80000000 | SNOOP_SIZE_2GB);
+	}
 
 	if ((pdata->operating_mode == FSL_USB2_DR_HOST) ||
 			(pdata->operating_mode == FSL_USB2_DR_OTG))
diff --git a/drivers/usb/host/ehci-fsl.h b/drivers/usb/host/ehci-fsl.h
index 4918062..16665a4 100644
--- a/drivers/usb/host/ehci-fsl.h
+++ b/drivers/usb/host/ehci-fsl.h
@@ -45,5 +45,6 @@
 #define FSL_SOC_USB_PRICTRL	0x40c	/* NOTE: big-endian */
 #define FSL_SOC_USB_SICTRL	0x410	/* NOTE: big-endian */
 #define FSL_SOC_USB_CTRL	0x500	/* NOTE: big-endian */
+#define CTRL_UTMI_PHY_EN	(1 << 9)
 #define SNOOP_SIZE_2GB		0x1e
 #endif				/* _EHCI_FSL_H */
------------------------------------------------------------------------

But I'm still seeing the hang.  (And I realize, now that I'm not head
down on the project, that the snooping fixes are probably irrelevant
for a single-core system like mine.)

Does anyone have suggestions on where I can go from here?

I could try the latest kernels, but due to our vendor not upstreaming
their patches, there could be some pain in that transition.

Thanks in advance for any suggestions.

Best regards,
Anthony Foiani
