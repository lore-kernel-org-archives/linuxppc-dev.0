Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 0C96EDDF87
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2007 15:52:21 +1000 (EST)
Date: Fri, 27 Apr 2007 00:52:43 -0500
To: paulus@samba.org
Subject: [PATCH] powerpc: clean up cpufreq Kconfig dependencies
Message-ID: <20070427055243.GC7755@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Shuffle Kconfig order, making the platform drivers menu depend on the global
option instead of each driver being dependent on it.

Also fix dependency of PPC_PMAC on the G5 one.

Signed-off-by: Olof Johansson <olof@lixom.net>


Index: powerpc/arch/powerpc/platforms/Kconfig
===================================================================
--- powerpc.orig/arch/powerpc/platforms/Kconfig
+++ powerpc/arch/powerpc/platforms/Kconfig
@@ -148,14 +148,14 @@ config GENERIC_IOMAP
 	bool
 	default n
 
-menu "CPU Frequency support"
-	depends on PPC64 || CLASSIC32
-
 source "drivers/cpufreq/Kconfig"
 
+menu "CPU Frequency drivers"
+	depends on CPU_FREQ
+
 config CPU_FREQ_PMAC
 	bool "Support for Apple PowerBooks"
-	depends on CPU_FREQ && ADB_PMU && PPC32
+	depends on ADB_PMU && PPC32
 	select CPU_FREQ_TABLE
 	help
 	  This adds support for frequency switching on Apple PowerBooks,
@@ -164,7 +164,7 @@ config CPU_FREQ_PMAC
 
 config CPU_FREQ_PMAC64
 	bool "Support for some Apple G5s"
-	depends on CPU_FREQ && PPC64
+	depends on PPC_PMAC && PPC64
 	select CPU_FREQ_TABLE
 	help
 	  This adds support for frequency switching on Apple iMac G5,
@@ -172,7 +172,7 @@ config CPU_FREQ_PMAC64
 
 config PPC_PASEMI_CPUFREQ
 	bool "Support for PA Semi PWRficient"
-	depends on CPU_FREQ && PPC_PASEMI
+	depends on PPC_PASEMI
 	default y
 	select CPU_FREQ_TABLE
 	help
