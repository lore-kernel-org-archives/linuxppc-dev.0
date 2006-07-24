Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2CCDC67B5F
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Jul 2006 17:22:33 +1000 (EST)
Date: Mon, 24 Jul 2006 09:22:27 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] hide onboard graphics drivers on G5
Message-ID: <20060724072227.GA32456@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hide the video drivers for onboard graphics found in early PCI PowerMacs
in Apple G5 config files.

drivers/built-in.o: In function `.platinumfb_probe':
platinumfb.c:(.text+0x377a0): undefined reference to `.nvram_read_byte'
platinumfb.c:(.text+0x37830): undefined reference to `.nvram_read_byte'
drivers/built-in.o: In function `.control_init':
controlfb.c:(.init.text+0x1938): undefined reference to `.nvram_read_byte'
controlfb.c:(.init.text+0x1968): undefined reference to `.nvram_read_byte'
drivers/built-in.o: In function `.valkyriefb_init':
(.init.text+0x2300): undefined reference to `.nvram_read_byte'
drivers/built-in.o:(.init.text+0x239c): more undefined references to `.nvram_read_byte' follow


Signed-off-by: Olaf Hering <olh@suse.de>
---
 drivers/video/Kconfig |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6.18-rc2/drivers/video/Kconfig
===================================================================
--- linux-2.6.18-rc2.orig/drivers/video/Kconfig
+++ linux-2.6.18-rc2/drivers/video/Kconfig
@@ -420,7 +420,7 @@ config FB_OF
 
 config FB_CONTROL
 	bool "Apple \"control\" display support"
-	depends on (FB = y) && PPC_PMAC
+	depends on (FB = y) && PPC_PMAC && PPC32
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -431,7 +431,7 @@ config FB_CONTROL
 
 config FB_PLATINUM
 	bool "Apple \"platinum\" display support"
-	depends on (FB = y) && PPC_PMAC
+	depends on (FB = y) && PPC_PMAC && PPC32
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -442,7 +442,7 @@ config FB_PLATINUM
 
 config FB_VALKYRIE
 	bool "Apple \"valkyrie\" display support"
-	depends on (FB = y) && (MAC || PPC_PMAC)
+	depends on (FB = y) && (MAC || (PPC_PMAC && PPC32))
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -453,7 +453,7 @@ config FB_VALKYRIE
 
 config FB_CT65550
 	bool "Chips 65550 display support"
-	depends on (FB = y) && PPC
+	depends on (FB = y) && PPC32
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
