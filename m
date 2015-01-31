Return-Path: <haokexin@gmail.com>
Received: from mail-yk0-x22a.google.com (mail-yk0-x22a.google.com
 [IPv6:2607:f8b0:4002:c07::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6A6001A1179
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Feb 2015 00:49:02 +1100 (AEDT)
Received: by mail-yk0-f170.google.com with SMTP id q9so19124011ykb.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Jan 2015 05:49:00 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org
Subject: [PATCH 14/15] usb: kconfig: replace PPC_OF with PPC
Date: Sat, 31 Jan 2015 21:47:44 +0800
Message-Id: <1422712065-9403-15-git-send-email-haokexin@gmail.com>
In-Reply-To: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kevin Hao <haokexin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PPC_OF is a ppc specific option which is used to mean that the
firmware device tree access functions are available. Since all the
ppc platforms have a device tree, it is aways set to 'y' for ppc.
So it makes no sense to keep a such option in the current kernel.
Replace it with PPC

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/usb/host/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 3de291b6ac04..5ad60e46dc2b 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -219,7 +219,7 @@ config USB_EHCI_TEGRA
 
 config USB_EHCI_HCD_PPC_OF
 	bool "EHCI support for PPC USB controller on OF platform bus"
-	depends on PPC_OF
+	depends on PPC
 	default y
 	---help---
 	  Enables support for the USB controller present on the PowerPC
@@ -480,7 +480,7 @@ config USB_OHCI_ATH79
 
 config USB_OHCI_HCD_PPC_OF_BE
 	bool "OHCI support for OF platform bus (big endian)"
-	depends on PPC_OF
+	depends on PPC
 	select USB_OHCI_BIG_ENDIAN_DESC
 	select USB_OHCI_BIG_ENDIAN_MMIO
 	---help---
@@ -489,7 +489,7 @@ config USB_OHCI_HCD_PPC_OF_BE
 
 config USB_OHCI_HCD_PPC_OF_LE
 	bool "OHCI support for OF platform bus (little endian)"
-	depends on PPC_OF
+	depends on PPC
 	select USB_OHCI_LITTLE_ENDIAN
 	---help---
 	  Enables support for little-endian USB controllers present on the
@@ -497,7 +497,7 @@ config USB_OHCI_HCD_PPC_OF_LE
 
 config USB_OHCI_HCD_PPC_OF
 	bool
-	depends on PPC_OF
+	depends on PPC
 	default USB_OHCI_HCD_PPC_OF_BE || USB_OHCI_HCD_PPC_OF_LE
 
 config USB_OHCI_HCD_PCI
-- 
1.9.3
