Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id CF03DDE048
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 05:46:55 +1000 (EST)
Message-Id: <20070423193913.530310528@arndb.de>
References: <20070423193538.576702568@arndb.de>
Date: Mon, 23 Apr 2007 21:35:48 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 10/10] update cell_defconfig
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sync with the Kconfig changes, and enable some options for celleb

Cc: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Signed-off-by: Jens Osterkamp <jens@de.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Index: linux-2.6/arch/powerpc/configs/cell_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/cell_defconfig
+++ linux-2.6/arch/powerpc/configs/cell_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.21-rc3
-# Fri Mar  9 23:34:53 2007
+# Linux kernel version: 2.6.21-rc6
+# Mon Apr 23 20:46:48 2007
 #
 CONFIG_PPC64=y
 CONFIG_64BIT=y
@@ -139,11 +139,31 @@ CONFIG_PPC_MULTIPLATFORM=y
 # CONFIG_PPC_PMAC is not set
 # CONFIG_PPC_MAPLE is not set
 # CONFIG_PPC_PASEMI is not set
+CONFIG_PPC_CELLEB=y
+CONFIG_PPC_PS3=y
+
+#
+# PS3 Platform Options
+#
+# CONFIG_PS3_ADVANCED is not set
+CONFIG_PS3_HTAB_SIZE=20
+# CONFIG_PS3_DYNAMIC_DMA is not set
+CONFIG_PS3_USE_LPAR_ADDR=y
+CONFIG_PS3_VUART=y
+CONFIG_PS3_PS3AV=y
+CONFIG_PS3_SYS_MANAGER=y
 CONFIG_PPC_CELL=y
 CONFIG_PPC_CELL_NATIVE=y
 CONFIG_PPC_IBM_CELL_BLADE=y
-CONFIG_PPC_PS3=y
-CONFIG_PPC_CELLEB=y
+
+#
+# Cell Broadband Engine options
+#
+CONFIG_SPU_FS=m
+CONFIG_SPU_BASE=y
+CONFIG_CBE_RAS=y
+CONFIG_CBE_THERM=m
+CONFIG_CBE_CPUFREQ=m
 CONFIG_PPC_NATIVE=y
 CONFIG_UDBG_RTAS_CONSOLE=y
 CONFIG_PPC_UDBG_BEAT=y
@@ -175,26 +195,6 @@ CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
 CONFIG_MPIC=y
 
 #
-# Cell Broadband Engine options
-#
-CONFIG_SPU_FS=m
-CONFIG_SPU_BASE=y
-CONFIG_CBE_RAS=y
-CONFIG_CBE_THERM=m
-CONFIG_CBE_CPUFREQ=m
-
-#
-# PS3 Platform Options
-#
-# CONFIG_PS3_ADVANCED is not set
-CONFIG_PS3_HTAB_SIZE=20
-# CONFIG_PS3_DYNAMIC_DMA is not set
-CONFIG_PS3_USE_LPAR_ADDR=y
-CONFIG_PS3_VUART=y
-CONFIG_PS3_PS3AV=y
-CONFIG_PS3_SYS_MANAGER=y
-
-#
 # Kernel options
 #
 # CONFIG_HZ_100 is not set
@@ -534,7 +534,6 @@ CONFIG_BLK_DEV_GENERIC=y
 # CONFIG_BLK_DEV_OPTI621 is not set
 CONFIG_BLK_DEV_IDEDMA_PCI=y
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
-CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_IDEDMA_ONLYDISK is not set
 CONFIG_BLK_DEV_AEC62XX=y
 # CONFIG_BLK_DEV_ALI15X3 is not set
@@ -561,11 +560,10 @@ CONFIG_BLK_DEV_SIIMAGE=y
 # CONFIG_BLK_DEV_TRM290 is not set
 # CONFIG_BLK_DEV_VIA82CXXX is not set
 # CONFIG_BLK_DEV_TC86C001 is not set
-CONFIG_BLK_DEV_IDE_CELLEB=y
+CONFIG_BLK_DEV_CELLEB=y
 # CONFIG_IDE_ARM is not set
 CONFIG_BLK_DEV_IDEDMA=y
 # CONFIG_IDEDMA_IVB is not set
-CONFIG_IDEDMA_AUTO=y
 # CONFIG_BLK_DEV_HD is not set
 
 #
@@ -937,7 +935,7 @@ CONFIG_UNIX98_PTYS=y
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_HVC_DRIVER=y
 CONFIG_HVC_RTAS=y
-# CONFIG_HVC_BEAT is not set
+CONFIG_HVC_BEAT=y
 
 #
 # IPMI
@@ -1482,6 +1480,8 @@ CONFIG_NLS_ISO8859_15=m
 # Distributed Lock Manager
 #
 # CONFIG_DLM is not set
+# CONFIG_UCC_SLOW is not set
+# CONFIG_UCC_FAST is not set
 
 #
 # Library routines
@@ -1540,6 +1540,7 @@ CONFIG_DEBUG_BUGVERBOSE=y
 # CONFIG_FAULT_INJECTION is not set
 # CONFIG_DEBUG_STACKOVERFLOW is not set
 # CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_DEBUG_PAGEALLOC is not set
 CONFIG_DEBUGGER=y
 CONFIG_XMON=y
 CONFIG_XMON_DEFAULT=y

--
