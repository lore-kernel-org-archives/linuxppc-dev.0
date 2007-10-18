Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7804BDDEBA
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 22:56:36 +1000 (EST)
Date: Thu, 18 Oct 2007 16:55:13 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] PowerPC: Split early debug output and early boot console for
	44x
Message-ID: <20071018125513.GA24673@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently there's no way to enable early boot console on PowerPC 44x
not specifying uart's physical address in kernel config, which is used
for very early debug messages. This patch splits very early debug output
(which needs uart physical address in kernel config) and early boot console
(which searches for uarts in the device tree using find_legacy_serial_ports).
We enable early boot console for all 44x processors, while (dangerous)
early debug is user-selectable.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 arch/powerpc/Kconfig.debug             |    1 -
 arch/powerpc/platforms/Kconfig.cputype |    1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff -pruN linux-2.6.orig/arch/powerpc/Kconfig.debug linux-2.6/arch/powerpc/Kconfig.debug
--- linux-2.6.orig/arch/powerpc/Kconfig.debug	2007-10-18 15:59:09.000000000 +0400
+++ linux-2.6/arch/powerpc/Kconfig.debug	2007-10-18 16:08:33.000000000 +0400
@@ -216,7 +216,6 @@ config PPC_EARLY_DEBUG_BEAT
 config PPC_EARLY_DEBUG_44x
 	bool "Early serial debugging for IBM/AMCC 44x CPUs"
 	depends on 44x
-	select PPC_UDBG_16550
 	help
 	  Select this to enable early debugging for IBM 44x chips via the
 	  inbuilt serial port.
diff -pruN linux-2.6.orig/arch/powerpc/platforms/Kconfig.cputype linux-2.6/arch/powerpc/platforms/Kconfig.cputype
--- linux-2.6.orig/arch/powerpc/platforms/Kconfig.cputype	2007-10-18 15:59:10.000000000 +0400
+++ linux-2.6/arch/powerpc/platforms/Kconfig.cputype	2007-10-18 16:08:33.000000000 +0400
@@ -48,6 +48,7 @@ config 44x
 	bool "AMCC 44x"
 	select PPC_DCR_NATIVE
 	select WANT_DEVICE_TREE
+	select PPC_UDBG_16550
 
 config E200
 	bool "Freescale e200"
