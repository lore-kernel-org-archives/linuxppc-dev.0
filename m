Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 959BEDDF4A
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 05:15:14 +1100 (EST)
Message-Id: <20071218175105.674886000@arndb.de>
References: <20071218174852.112644000@arndb.de>
Date: Tue, 18 Dec 2007 18:49:03 +0100
From: arnd@arndb.de
To: paulus@samba.org
Subject: [POWERPC 11/18] cell: Convert #include of asm/of_{platform,
	device}.h into linux/of_{platform, device}.h.
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Jon Loeliger <jdl@freescale.com>
Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/cell/cbe_cpufreq.c     |    3 ++-
 arch/powerpc/platforms/cell/cbe_cpufreq_pmi.c |    3 ++-
 arch/powerpc/platforms/cell/cbe_regs.c        |    4 ++--
 arch/powerpc/platforms/cell/iommu.c           |    2 +-
 arch/powerpc/platforms/cell/setup.c           |    2 +-
 arch/powerpc/platforms/celleb/iommu.c         |    3 +--
 arch/powerpc/platforms/celleb/setup.c         |    2 +-
 7 files changed, 10 insertions(+), 9 deletions(-)

Index: linux-2.6-new/arch/powerpc/platforms/cell/cbe_cpufreq.c
===================================================================
--- linux-2.6-new.orig/arch/powerpc/platforms/cell/cbe_cpufreq.c
+++ linux-2.6-new/arch/powerpc/platforms/cell/cbe_cpufreq.c
@@ -21,8 +21,9 @@
  */
 
 #include <linux/cpufreq.h>
+#include <linux/of_platform.h>
+
 #include <asm/machdep.h>
-#include <asm/of_platform.h>
 #include <asm/prom.h>
 #include <asm/cell-regs.h>
 #include "cbe_cpufreq.h"
Index: linux-2.6-new/arch/powerpc/platforms/cell/cbe_cpufreq_pmi.c
===================================================================
--- linux-2.6-new.orig/arch/powerpc/platforms/cell/cbe_cpufreq_pmi.c
+++ linux-2.6-new/arch/powerpc/platforms/cell/cbe_cpufreq_pmi.c
@@ -23,7 +23,8 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/timer.h>
-#include <asm/of_platform.h>
+#include <linux/of_platform.h>
+
 #include <asm/processor.h>
 #include <asm/prom.h>
 #include <asm/pmi.h>
Index: linux-2.6-new/arch/powerpc/platforms/cell/cbe_regs.c
===================================================================
--- linux-2.6-new.orig/arch/powerpc/platforms/cell/cbe_regs.c
+++ linux-2.6-new/arch/powerpc/platforms/cell/cbe_regs.c
@@ -9,13 +9,13 @@
 #include <linux/percpu.h>
 #include <linux/types.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
 
 #include <asm/io.h>
 #include <asm/pgtable.h>
 #include <asm/prom.h>
 #include <asm/ptrace.h>
-#include <asm/of_device.h>
-#include <asm/of_platform.h>
 #include <asm/cell-regs.h>
 
 /*
Index: linux-2.6-new/arch/powerpc/platforms/cell/iommu.c
===================================================================
--- linux-2.6-new.orig/arch/powerpc/platforms/cell/iommu.c
+++ linux-2.6-new/arch/powerpc/platforms/cell/iommu.c
@@ -26,13 +26,13 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/notifier.h>
+#include <linux/of_platform.h>
 
 #include <asm/prom.h>
 #include <asm/iommu.h>
 #include <asm/machdep.h>
 #include <asm/pci-bridge.h>
 #include <asm/udbg.h>
-#include <asm/of_platform.h>
 #include <asm/lmb.h>
 #include <asm/firmware.h>
 #include <asm/cell-regs.h>
Index: linux-2.6-new/arch/powerpc/platforms/cell/setup.c
===================================================================
--- linux-2.6-new.orig/arch/powerpc/platforms/cell/setup.c
+++ linux-2.6-new/arch/powerpc/platforms/cell/setup.c
@@ -30,6 +30,7 @@
 #include <linux/console.h>
 #include <linux/mutex.h>
 #include <linux/memory_hotplug.h>
+#include <linux/of_platform.h>
 
 #include <asm/mmu.h>
 #include <asm/processor.h>
@@ -51,7 +52,6 @@
 #include <asm/spu_priv1.h>
 #include <asm/udbg.h>
 #include <asm/mpic.h>
-#include <asm/of_platform.h>
 #include <asm/cell-regs.h>
 
 #include "interrupt.h"
Index: linux-2.6-new/arch/powerpc/platforms/celleb/iommu.c
===================================================================
--- linux-2.6-new.orig/arch/powerpc/platforms/celleb/iommu.c
+++ linux-2.6-new/arch/powerpc/platforms/celleb/iommu.c
@@ -22,8 +22,8 @@
 #include <linux/init.h>
 #include <linux/dma-mapping.h>
 #include <linux/pci.h>
+#include <linux/of_platform.h>
 
-#include <asm/of_platform.h>
 #include <asm/firmware.h>
 
 #include "beat_wrapper.h"
Index: linux-2.6-new/arch/powerpc/platforms/celleb/setup.c
===================================================================
--- linux-2.6-new.orig/arch/powerpc/platforms/celleb/setup.c
+++ linux-2.6-new/arch/powerpc/platforms/celleb/setup.c
@@ -40,6 +40,7 @@
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
 #include <linux/console.h>
+#include <linux/of_platform.h>
 
 #include <asm/mmu.h>
 #include <asm/processor.h>
@@ -52,7 +53,6 @@
 #include <asm/time.h>
 #include <asm/spu_priv1.h>
 #include <asm/firmware.h>
-#include <asm/of_platform.h>
 #include <asm/rtas.h>
 #include <asm/cell-regs.h>
 

-- 
