Return-Path: <B33228@freescale.com>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6C72BB708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 10 Jan 2011 21:05:31 +1100 (EST)
Received: from mail37-tx2 (localhost.localdomain [127.0.0.1])	by
	mail37-tx2-R.bigfish.com (Postfix) with ESMTP id 4297D5780F3	for
	<linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jan 2011 10:05:20 +0000 (UTC)
Received: from TX2EHSMHS018.bigfish.com (unknown [10.9.14.248])	by
	mail37-tx2.bigfish.com (Postfix) with ESMTP id 28BB3DD8057	for
	<linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jan 2011 10:05:20 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id p0AA5IBM016999	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 10 Jan 2011 03:05:18 -0700 (MST)
From: Xulei <B33228@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] USB: Fix USB Kconfig dependency problem on 85xx/QoirQ
	platforms
Date: Mon, 10 Jan 2011 18:06:57 +0800
Message-ID: <1294654017-32568-1-git-send-email-B33228@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Xulei <B33228@freescale.com>, Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For FSL PPC SoCs USB_ARCH_HAS_EHCI currently on depends on PPC_83xx.
However that excludes support for USB on 85xx & QorIQ devices.  Use
FSL_SOC insted which will get us 83xx, 85xx, QorIQ, and 5xxx which all
have the same USB IP on them.

Signed-off-by: Xulei <B33228@freescale.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
---
 drivers/usb/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 6a58cb1..d513d3a 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -57,7 +57,7 @@ config USB_ARCH_HAS_OHCI
 # some non-PCI hcds implement EHCI
 config USB_ARCH_HAS_EHCI
 	boolean
-	default y if PPC_83xx
+	default y if FSL_SOC
 	default y if SOC_AU1200
 	default y if ARCH_IXP4XX
 	default y if ARCH_W90X900
-- 
1.7.0.4
