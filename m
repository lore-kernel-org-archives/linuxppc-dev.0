Return-Path: <jengelh@linux01.gwdg.de>
Received: from mailer.gwdg.de (mailer.gwdg.de [134.76.10.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0CF6FDDF04
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Apr 2007 22:39:26 +1000 (EST)
Date: Mon, 30 Apr 2007 13:37:55 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 15/36] Use menuconfig objects II - Macintosh
In-Reply-To: <Pine.LNX.4.61.0704301225060.29151@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.61.0704301336200.29151@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0704301225060.29151@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Make a "menuconfig" out of the Kconfig objects "menu, ..., endmenu",
so that the user can disable all the options in that menu at once
instead of having to disable each option separately.

Signed-off-by: Jan Engelhardt <jengelh@gmx.de>

---
 drivers/macintosh/Kconfig |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- linux-2.6.21-mm_20070428.orig/drivers/macintosh/Kconfig
+++ linux-2.6.21-mm_20070428/drivers/macintosh/Kconfig
@@ -1,6 +1,10 @@
 
-menu "Macintosh device drivers"
+menuconfig MACINTOSH_DRIVERS
+	bool "Macintosh device drivers"
 	depends on PPC || MAC || X86
+	default y
+
+if MACINTOSH_DRIVERS
 
 config ADB
 	bool "Apple Desktop Bus (ADB) support"
@@ -234,4 +238,4 @@ config PMAC_RACKMETER
 	  This driver procides some support to control the front panel
           blue LEDs "vu-meter" of the XServer macs.
 
-endmenu
+endif # MACINTOSH_DRIVERS
