Return-Path: <pravin.shedge4linux@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yzQCB57PSzDrfk
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Dec 2017 22:32:54 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id g7so7350014pgs.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Dec 2017 03:32:54 -0800 (PST)
From: Pravin Shedge <pravin.shedge4linux@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, mahesh@linux.vnet.ibm.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mingo@kernel.org, fweisbec@gmail.com, john.stultz@linaro.org,
 ivan@de.ibm.com, tglx@linutronix.de, mhiramat@kernel.org,
 naveen.n.rao@linux.vnet.ibm.com, shailendras@nvidia.com,
 keescook@chromium.org, anju@linux.vnet.ibm.com, mcgrof@kernel.org,
 bsingharora@gmail.com, linux-kernel@vger.kernel.org
Cc: pravin.shedge4linux@gmail.com
Subject: [PATCH 38/45] arch/powerpc: remove duplicate includes
Date: Sat, 16 Dec 2017 17:02:37 +0530
Message-Id: <1513423957-6118-1-git-send-email-pravin.shedge4linux@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These duplicate includes have been found with scripts/checkincludes.pl but
they have been removed manually to avoid removing false positives.

Signed-off-by: Pravin Shedge <pravin.shedge4linux@gmail.com>
---
 arch/powerpc/kernel/time.c               | 2 --
 arch/powerpc/lib/code-patching.c         | 1 -
 arch/powerpc/mm/numa.c                   | 1 -
 arch/powerpc/platforms/powernv/npu-dma.c | 1 -
 arch/powerpc/platforms/powernv/opal.c    | 1 -
 5 files changed, 6 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index fe6f3a2..64d0b80 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -57,7 +57,6 @@
 #include <linux/irq_work.h>
 #include <linux/clk-provider.h>
 #include <linux/suspend.h>
-#include <linux/rtc.h>
 #include <linux/sched/cputime.h>
 #include <linux/processor.h>
 #include <asm/trace.h>
@@ -78,7 +77,6 @@
 
 /* powerpc clocksource/clockevent code */
 
-#include <linux/clockchips.h>
 #include <linux/timekeeper_internal.h>
 
 static u64 rtc_read(struct clocksource *);
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index d469224..5f7e5ed 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -15,7 +15,6 @@
 #include <linux/cpuhotplug.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
-#include <linux/kprobes.h>
 
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index adb6364f..fa4b3af 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -33,7 +33,6 @@
 #include <asm/sparsemem.h>
 #include <asm/prom.h>
 #include <asm/smp.h>
-#include <asm/cputhreads.h>
 #include <asm/topology.h>
 #include <asm/firmware.h>
 #include <asm/paca.h>
diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index f6cbc1a..e35b4fc 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -26,7 +26,6 @@
 #include <asm/iommu.h>
 #include <asm/pnv-pci.h>
 #include <asm/msi_bitmap.h>
-#include <asm/opal.h>
 
 #include "powernv.h"
 #include "pci.h"
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 041ddbd..e00c1c6 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -26,7 +26,6 @@
 #include <linux/memblock.h>
 #include <linux/kthread.h>
 #include <linux/freezer.h>
-#include <linux/printk.h>
 #include <linux/kmsg_dump.h>
 #include <linux/console.h>
 #include <linux/sched/debug.h>
-- 
2.7.4
