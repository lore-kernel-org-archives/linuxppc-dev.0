Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3A872DDF5B
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 00:27:13 +1000 (EST)
Date: Mon, 8 Oct 2007 18:25:54 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] OHCI: add PowerPC 440EP/440EPx support
Message-ID: <20071008142554.GA15175@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

PowerPC 440EP 440EPx OHCI controller needs frame number value shift.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 drivers/usb/host/ohci.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -pruN linux-2.6.orig/drivers/usb/host/ohci.h linux-2.6/drivers/usb/host/ohci.h
--- linux-2.6.orig/drivers/usb/host/ohci.h	2007-10-08 16:30:28.000000000 +0400
+++ linux-2.6/drivers/usb/host/ohci.h	2007-10-08 17:55:43.000000000 +0400
@@ -612,7 +612,7 @@ static inline u32 hc32_to_cpup (const st
  * to arch/powerpc
  */
 
-#ifdef CONFIG_STB03xxx
+#if defined(CONFIG_STB03xxx) || defined(CONFIG_440EP) || defined(CONFIG_440EPX)
 #define OHCI_BE_FRAME_NO_SHIFT	16
 #else
 #define OHCI_BE_FRAME_NO_SHIFT	0
