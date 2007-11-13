Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D6D47DDECB
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 04:11:03 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	lADHAwe6005616
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 10:10:59 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id lADHAwki002745
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 11:10:58 -0600 (CST)
Subject: [PATCH v2] cell: Convert #include of asm/of_{platform, device}.h
	into linux/of_{platform, device}.h.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1194973858.12888.12.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Tue, 13 Nov 2007 11:10:58 -0600
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>From b26c62af41b28f87ae2cdf525477670a5ac623fd Mon Sep 17 00:00:00 2001
From: Jon Loeliger <jdl@freescale.com>
Date: Mon, 12 Nov 2007 14:23:16 -0600
Subject: [PATCH] cell: Convert #include of asm/of_{platform, device}.h into linux/of_{platform, device}.h.

Signed-off-by: Jon Loeliger <jdl@freescale.com>
Acked-by: Stephen Rothwell <sfr@canb.auug.org.au> Built a ppc64_defconfig
---

This version picks up the celleb/ files too.
Stephen, notice that you tacitly ACK'ed this pickup too... :-)


 arch/powerpc/platforms/cell/cbe_cpufreq.c     |    3 ++-
 arch/powerpc/platforms/cell/cbe_cpufreq_pmi.c |    3 ++-
 arch/powerpc/platforms/cell/cbe_regs.c        |    4 ++--
 arch/powerpc/platforms/cell/iommu.c           |    2 +-
 arch/powerpc/platforms/cell/setup.c           |    2 +-
 arch/powerpc/platforms/celleb/iommu.c         |    3 +--
 arch/powerpc/platforms/celleb/setup.c         |    2 +-
 7 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/cell/cbe_cpufreq.c b/arch/powerpc/platforms/cell/cbe_cpufreq.c
index 13d5a87..ec7c8f4 100644
--- a/arch/powerpc/platforms/cell/cbe_cpufreq.c
+++ b/arch/powerpc/platforms/cell/cbe_cpufreq.c
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
diff --git a/arch/powerpc/platforms/cell/cbe_cpufreq_pmi.c b/arch/powerpc/platforms/cell/cbe_cpufreq_pmi.c
index 6a2c1b0..69288f6 100644
--- a/arch/powerpc/platforms/cell/cbe_cpufreq_pmi.c
+++ b/arch/powerpc/platforms/cell/cbe_cpufreq_pmi.c
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
diff --git a/arch/powerpc/platforms/cell/cbe_regs.c b/arch/powerpc/platforms/cell/cbe_regs.c
index 16a9b07..a839c6c 100644
--- a/arch/powerpc/platforms/cell/cbe_regs.c
+++ b/arch/powerpc/platforms/cell/cbe_regs.c
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
diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index faabc3f..179ba2e 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
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
 #include <asm/cell-regs.h>
 
diff --git a/arch/powerpc/platforms/cell/setup.c b/arch/powerpc/platforms/cell/setup.c
index 98e7ef8..4f6347c 100644
--- a/arch/powerpc/platforms/cell/setup.c
+++ b/arch/powerpc/platforms/cell/setup.c
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
diff --git a/arch/powerpc/platforms/celleb/iommu.c b/arch/powerpc/platforms/celleb/iommu.c
index 755d869..f00396a 100644
--- a/arch/powerpc/platforms/celleb/iommu.c
+++ b/arch/powerpc/platforms/celleb/iommu.c
@@ -22,8 +22,7 @@
 #include <linux/init.h>
 #include <linux/dma-mapping.h>
 #include <linux/pci.h>
-
-#include <asm/of_platform.h>
+#include <linux/of_platform.h>
 
 #include "beat_wrapper.h"
 
diff --git a/arch/powerpc/platforms/celleb/setup.c b/arch/powerpc/platforms/celleb/setup.c
index 1769d75..116c30b 100644
--- a/arch/powerpc/platforms/celleb/setup.c
+++ b/arch/powerpc/platforms/celleb/setup.c
@@ -40,6 +40,7 @@
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
 #include <linux/console.h>
+#include <linux/of_platform.h>
 
 #include <asm/mmu.h>
 #include <asm/processor.h>
@@ -51,7 +52,6 @@
 #include <asm/irq.h>
 #include <asm/spu_priv1.h>
 #include <asm/firmware.h>
-#include <asm/of_platform.h>
 
 #include "interrupt.h"
 #include "beat_wrapper.h"
-- 
1.5.3
