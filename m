Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id E43A2DDDFD
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 07:52:29 +1000 (EST)
Message-Id: <20070712210909.451536561@arndb.de>
References: <20070712210156.973038514@arndb.de>
Date: Thu, 12 Jul 2007 23:02:00 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: paulus@samba.org
Subject: [PATCH 4/5] move 86xx into multiplatform
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

MPC86xx based machines don't need their own kernel,
but can run one that is shared with the other 6xx
compatible machines, so we should allow that
in Kconfig.

Cc: Kumar Gala <galak@kernel.crashing.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---

Kumar, I don't remember if you still had objections
to merging 86xx annd 83xx into multiplatform after
our last discussion.
Please Ack or Nack the two patches.

Index: linux-2.6/arch/powerpc/platforms/86xx/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/86xx/Kconfig
+++ linux-2.6/arch/powerpc/platforms/86xx/Kconfig
@@ -1,18 +1,20 @@
-choice
-	prompt "86xx Board Type"
-	depends on PPC_86xx
-	default MPC8641_HPCN
+config PPC_86xx
+	bool "Freescale 86xx based boards"
+	depends on 6xx
+	select FSL_SOC
+	select ALTIVEC
+	help
+	  The Freescale E600 SoCs have 74xx cores.
 
 config MPC8641_HPCN
 	bool "Freescale MPC8641 HPCN"
+	depends on PPC_86xx
 	select PPC_I8259
 	select DEFAULT_UIMAGE
 	select CPU_7450
 	help
 	  This option enables support for the MPC8641 HPCN board.
 
-endchoice
-
 config MPC8641
 	bool
 	select PPC_INDIRECT_PCI
Index: linux-2.6/arch/powerpc/platforms/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/Kconfig
+++ linux-2.6/arch/powerpc/platforms/Kconfig
@@ -23,13 +23,6 @@ config PPC_83xx
 	select 83xx
 	select WANT_DEVICE_TREE
 
-config PPC_86xx
-	bool "Freescale 86xx"
-	depends on 6xx
-	select FSL_SOC
-	select ALTIVEC
-	help
-	  The Freescale E600 SoCs have 74xx cores.
 endchoice
 
 config CLASSIC32

--
