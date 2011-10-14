Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2E09BB70B2
 for <linuxppc-dev@ozlabs.org>; Sat, 15 Oct 2011 07:35:17 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: gregkh@suse.de
Subject: [PATCH] USB: Fix USB Kconfig dependency problem on 85xx/QoirQ
 platforms
Date: Fri, 14 Oct 2011 15:35:10 -0500
Message-Id: <1318624510-24058-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Xu lei <B33228@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Xu lei <B33228@freescale.com>

For FSL PPC SoCs USB_ARCH_HAS_EHCI currently on depends on PPC_83xx.
However that excludes support for USB on 85xx & QorIQ devices.  Use
FSL_SOC insted which will get us 83xx, 85xx, QorIQ, and 5xxx which all
have the same USB IP on them.

Signed-off-by: Xulei <B33228@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 drivers/usb/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 48f1781..1580d7c 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -54,7 +54,7 @@ config USB_ARCH_HAS_OHCI
 # some non-PCI hcds implement EHCI
 config USB_ARCH_HAS_EHCI
 	boolean
-	default y if PPC_83xx
+	default y if FSL_SOC
 	default y if PPC_MPC512x
 	default y if SOC_AU1200
 	default y if ARCH_IXP4XX
-- 
1.7.3.4
