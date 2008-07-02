Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 914CCDDFC8
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jul 2008 17:14:40 +1000 (EST)
Date: Wed, 2 Jul 2008 02:14:33 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: dbrownell@users.sourceforge.net, Greg KH <greg@kroah.com>
Subject: [PATCH] USB: EHCI: Reconciling USB register differences on MPC85xx
	vs MPC83xx
Message-ID: <Pine.LNX.4.64.0807020213250.25180@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Srikanth Srinivasan <srikanth.srinivasan@freescale.com>

A couple of USB register initializations had to be changed on MPC85xx
platforms.  This is due to the internal SoC buses being different on
MPC83xx SoCs vs MPC85xx SoCs.

We currently handle this via an ifdef since 83xx and 85xx are mutually
exclusive kernel builds.

Signed-off-by: Srikanth Srinivasan <srikanth.srinivasan@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

This is for 2.6.27 and is need for proper USB functionality of the
MPC8536DS platform that will go in via the powerpc tree in 2.6.27.

- k

 drivers/usb/host/ehci-fsl.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index 7370d61..237a779 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -230,8 +230,13 @@ static void mpc83xx_usb_setup(struct usb_hcd *hcd)

 	/* put controller in host mode. */
 	ehci_writel(ehci, 0x00000003, non_ehci + FSL_SOC_USB_USBMODE);
+#ifdef CONFIG_PPC_85xx
+	out_be32(non_ehci + FSL_SOC_USB_PRICTRL, 0x00000008);
+	out_be32(non_ehci + FSL_SOC_USB_AGECNTTHRSH, 0x00000080);
+#else
 	out_be32(non_ehci + FSL_SOC_USB_PRICTRL, 0x0000000c);
 	out_be32(non_ehci + FSL_SOC_USB_AGECNTTHRSH, 0x00000040);
+#endif
 	out_be32(non_ehci + FSL_SOC_USB_SICTRL, 0x00000001);
 }

-- 
1.5.5.1
