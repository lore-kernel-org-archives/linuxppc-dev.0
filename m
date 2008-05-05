Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 8E970DDEFC
	for <linuxppc-dev@ozlabs.org>; Mon,  5 May 2008 17:57:17 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id C8887C8C21E
	for <linuxppc-dev@ozlabs.org>; Mon,  5 May 2008 00:57:15 -0700 (PDT)
Date: Mon, 05 May 2008 00:57:15 -0700 (PDT)
Message-Id: <20080505.005715.215572318.davem@davemloft.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH]: PPC_OF protect USB driver...
From: David Miller <davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This uses APIs that are not generic, or at least not part of
what Sparc provides yet.

So just PPC_OF this for now just like the EHCI_OF driver.

This fixes allmodconfig build errors on sparc.

Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 33b467a..1ef6df3 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -129,7 +129,7 @@ config USB_ISP1760_PCI
 
 config USB_ISP1760_OF
 	bool "Support for the OF platform bus"
-	depends on USB_ISP1760_HCD && OF
+	depends on USB_ISP1760_HCD && PPC_OF
 	---help---
 	  Enables support for the device present on the PowerPC
 	  OpenFirmware platform bus.
