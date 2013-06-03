Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7A9DD2C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jun 2013 21:18:43 +1000 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org
Subject: [PATCH v1 1/1] mpc512x: silence a USB Kconfig dependency warning
Date: Mon,  3 Jun 2013 13:18:06 +0200
Message-Id: <1370258286-27905-1-git-send-email-gsi@denx.de>
Cc: Gerhard Sittig <gsi@denx.de>, Anatolij Gustschin <agust@denx.de>,
 Alan Stern <stern@rowland.harvard.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

the PPC_MPC512x config automatically selected USB_EHCI_BIG_ENDIAN_*
switches, which made Kconfig warn about "unmet direct dependencies":

  scripts/kconfig/conf --silentoldconfig Kconfig
  warning: (PPC_MPC512x && 440EPX) selects USB_EHCI_BIG_ENDIAN_DESC which has unmet direct dependencies (USB_SUPPORT && USB && USB_EHCI_HCD)
  warning: (PPC_MPC512x && PPC_PS3 && PPC_CELLEB && 440EPX) selects USB_EHCI_BIG_ENDIAN_MMIO which has unmet direct dependencies (USB_SUPPORT && USB && USB_EHCI_HCD)
  warning: (PPC_MPC512x && 440EPX) selects USB_EHCI_BIG_ENDIAN_DESC which has unmet direct dependencies (USB_SUPPORT && USB && USB_EHCI_HCD)
  warning: (PPC_MPC512x && PPC_PS3 && PPC_CELLEB && 440EPX) selects USB_EHCI_BIG_ENDIAN_MMIO which has unmet direct dependencies (USB_SUPPORT && USB && USB_EHCI_HCD)

make the selected entries additionally depend on USB_EHCI_HCD which
silences the warning

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 arch/powerpc/platforms/512x/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/512x/Kconfig b/arch/powerpc/platforms/512x/Kconfig
index aaf1edb..049fb7b 100644
--- a/arch/powerpc/platforms/512x/Kconfig
+++ b/arch/powerpc/platforms/512x/Kconfig
@@ -17,8 +17,8 @@ config PPC_MPC512x
 	select PPC_PCI_CHOICE
 	select FSL_PCI if PCI
 	select ARCH_WANT_OPTIONAL_GPIOLIB
-	select USB_EHCI_BIG_ENDIAN_MMIO
-	select USB_EHCI_BIG_ENDIAN_DESC
+	select USB_EHCI_BIG_ENDIAN_MMIO if USB_EHCI_HCD
+	select USB_EHCI_BIG_ENDIAN_DESC if USB_EHCI_HCD
 
 config MPC5121_ADS
 	bool "Freescale MPC5121E ADS"
-- 
1.7.10.4
