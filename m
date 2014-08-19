Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C39EC1A03CE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 08:55:24 +1000 (EST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH 2/4] powerpc: Ensure global functions include their prototype
Date: Wed, 20 Aug 2014 08:55:19 +1000
Message-Id: <1408488921-19187-2-git-send-email-anton@samba.org>
In-Reply-To: <1408488921-19187-1-git-send-email-anton@samba.org>
References: <1408488921-19187-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix a number of places where global functions were not including
their prototype. This ensures the prototype and the function match.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/smp.c                       | 1 +
 arch/powerpc/mm/slice.c                         | 2 ++
 arch/powerpc/oprofile/backtrace.c               | 1 +
 arch/powerpc/platforms/powernv/subcore.c        | 1 +
 arch/powerpc/platforms/pseries/dlpar.c          | 1 +
 arch/powerpc/platforms/pseries/hotplug-memory.c | 1 +
 arch/powerpc/platforms/pseries/pci.c            | 1 +
 7 files changed, 8 insertions(+)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index a0738af..4866d5d 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -52,6 +52,7 @@
 #endif
 #include <asm/vdso.h>
 #include <asm/debug.h>
+#include <asm/kexec.h>
 
 #ifdef DEBUG
 #include <asm/udbg.h>
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index b0c75cc..86f6a75 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -30,9 +30,11 @@
 #include <linux/err.h>
 #include <linux/spinlock.h>
 #include <linux/export.h>
+#include <linux/hugetlb.h>
 #include <asm/mman.h>
 #include <asm/mmu.h>
 #include <asm/spu.h>
+#include <asm/hugetlb.h>
 
 /* some sanity checks */
 #if (PGTABLE_RANGE >> 43) > SLICE_MASK_SIZE
diff --git a/arch/powerpc/oprofile/backtrace.c b/arch/powerpc/oprofile/backtrace.c
index f75301f..6adf55f 100644
--- a/arch/powerpc/oprofile/backtrace.c
+++ b/arch/powerpc/oprofile/backtrace.c
@@ -12,6 +12,7 @@
 #include <asm/processor.h>
 #include <asm/uaccess.h>
 #include <asm/compat.h>
+#include <asm/oprofile_impl.h>
 
 #define STACK_SP(STACK)		*(STACK)
 
diff --git a/arch/powerpc/platforms/powernv/subcore.c b/arch/powerpc/platforms/powernv/subcore.c
index 894ecb3..c87f96b 100644
--- a/arch/powerpc/platforms/powernv/subcore.c
+++ b/arch/powerpc/platforms/powernv/subcore.c
@@ -24,6 +24,7 @@
 #include <asm/smp.h>
 
 #include "subcore.h"
+#include "powernv.h"
 
 
 /*
diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index d37ba4f..86f3136 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include "offline_states.h"
+#include "pseries.h"
 
 #include <asm/prom.h>
 #include <asm/machdep.h>
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 24abc5c..6169497 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -20,6 +20,7 @@
 #include <asm/machdep.h>
 #include <asm/prom.h>
 #include <asm/sparsemem.h>
+#include "pseries.h"
 
 unsigned long pseries_memory_block_size(void)
 {
diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
index c413ec1..67e4859 100644
--- a/arch/powerpc/platforms/pseries/pci.c
+++ b/arch/powerpc/platforms/pseries/pci.c
@@ -29,6 +29,7 @@
 #include <asm/pci-bridge.h>
 #include <asm/prom.h>
 #include <asm/ppc-pci.h>
+#include "pseries.h"
 
 #if 0
 void pcibios_name_device(struct pci_dev *dev)
-- 
1.9.1
