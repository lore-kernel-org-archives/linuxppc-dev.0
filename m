Return-Path: <viro@www.linux.org.uk>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1F081680A6
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Aug 2005 16:49:24 +1000 (EST)
To: torvalds@osdl.org
Message-Id: <E1E60jQ-0000Ye-PE@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Fri, 19 Aug 2005 07:52:00 +0100
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] (23/46) Kconfig fix (ppc 4xx and early serial)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

a bunch of ppc 4xx variants unconditionally calls early_serial_setup() and
therefore needs SERIAL_8250

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git10-mv64360-irq/arch/ppc/platforms/4xx/Kconfig RC13-rc6-git10-4xx-early-serial/arch/ppc/platforms/4xx/Kconfig
--- RC13-rc6-git10-mv64360-irq/arch/ppc/platforms/4xx/Kconfig	2005-08-10 10:37:46.000000000 -0400
+++ RC13-rc6-git10-4xx-early-serial/arch/ppc/platforms/4xx/Kconfig	2005-08-18 14:23:26.000000000 -0400
@@ -3,6 +3,11 @@
 	depends on 40x || 44x
 	default y
 
+config WANT_EARLY_SERIAL
+	bool
+	select SERIAL_8250
+	default n
+
 menu "IBM 4xx options"
 	depends on 4xx
 
@@ -18,6 +23,7 @@
 
 config BUBINGA
 	bool "Bubinga"
+	select WANT_EARLY_SERIAL
 	help
 	  This option enables support for the IBM 405EP evaluation board.
 
@@ -70,21 +76,25 @@
 
 config BAMBOO
 	bool "Bamboo"
+	select WANT_EARLY_SERIAL
 	help
 	  This option enables support for the IBM PPC440EP evaluation board.
 
 config EBONY
 	bool "Ebony"
+	select WANT_EARLY_SERIAL
 	help
 	  This option enables support for the IBM PPC440GP evaluation board.
 
 config LUAN
 	bool "Luan"
+	select WANT_EARLY_SERIAL
 	help
 	  This option enables support for the IBM PPC440SP evaluation board.
 
 config OCOTEA
 	bool "Ocotea"
+	select WANT_EARLY_SERIAL
 	help
 	  This option enables support for the IBM PPC440GX evaluation board.
 
