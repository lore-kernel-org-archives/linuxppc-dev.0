Return-Path: <viro@www.linux.org.uk>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 99B47680AD
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Aug 2005 07:44:29 +1000 (EST)
To: torvalds@osdl.org
Message-Id: <E1E7gbR-0007C8-R6@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:46:41 +0100
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] (23/43) Kconfig fix (CONFIG_PM on 44x)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

CONFIG_PM is broken on 44x; removed duplicate entry for CONFIG_PM, made
the inclusion of generic one conditional on BROKEN || !44x.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-4xx-early-serial/arch/ppc/Kconfig RC13-rc6-git13-44x-PM/arch/ppc/Kconfig
--- RC13-rc6-git13-4xx-early-serial/arch/ppc/Kconfig	2005-08-21 13:17:04.000000000 -0400
+++ RC13-rc6-git13-44x-PM/arch/ppc/Kconfig	2005-08-21 13:17:06.000000000 -0400
@@ -1126,7 +1126,9 @@
 
 source "drivers/zorro/Kconfig"
 
+if !44x || BROKEN
 source kernel/power/Kconfig
+endif
 
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
diff -urN RC13-rc6-git13-4xx-early-serial/arch/ppc/platforms/4xx/Kconfig RC13-rc6-git13-44x-PM/arch/ppc/platforms/4xx/Kconfig
--- RC13-rc6-git13-4xx-early-serial/arch/ppc/platforms/4xx/Kconfig	2005-08-21 13:17:05.000000000 -0400
+++ RC13-rc6-git13-44x-PM/arch/ppc/platforms/4xx/Kconfig	2005-08-21 13:17:06.000000000 -0400
@@ -240,10 +240,6 @@
 	depends on 4xx
 	default y
 
-config PM
-	bool "Power Management support (EXPERIMENTAL)"
-	depends on 4xx && EXPERIMENTAL
-
 choice
 	prompt "TTYS0 device and default console"
 	depends on 40x
