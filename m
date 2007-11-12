Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9E981DDEA0
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 07:27:38 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	lACKRAkw025364
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Nov 2007 13:27:29 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id lACKQp5a008287
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Nov 2007 14:26:51 -0600 (CST)
Subject: [PATCH] cell: Convert #include of asm/of_{platform, device}.h into
	linux/of_{platform, device}.h.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1194899211.3396.15.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Mon, 12 Nov 2007 14:26:51 -0600
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Jon Loeliger <jdl@freescale.com>

Signed-off-by: Jon Loeliger <jdl@freescale.com>
---
 arch/powerpc/platforms/cell/cbe_cpufreq.c     |    3 ++-
 arch/powerpc/platforms/cell/cbe_cpufreq_pmi.c |    3 ++-
 arch/powerpc/platforms/cell/cbe_regs.c        |    4 ++--
 arch/powerpc/platforms/cell/iommu.c           |    2 +-
 arch/powerpc/platforms/cell/setup.c           |    2 +-
 5 files changed, 8 insertions(+), 6 deletions(-)

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
-- 
1.5.3
