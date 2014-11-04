Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 67F621A0232
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Nov 2014 08:46:44 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH] powerpc: Add ppc64 hard lockup detector support
Date: Wed,  5 Nov 2014 08:46:42 +1100
Message-Id: <1415137602-17402-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The hard lockup detector uses a PMU event as a periodic NMI to
detect if we are stuck (where stuck means no timer interrupts have
occurred).

Ben's rework of the ppc64 soft disable code has made ppc64 PMU
exceptions a partial NMI. They can get disabled if an external
interrupt comes in, but otherwise PMU interrupts will fire in
interrupt disabled regions.

We disable the hard lockup detector by default for a few reasons:

- It breaks userspace event based branches on POWER8.
- It is likely to produce false positives on KVM guests.
- Since PMCs can only count to 2^31, counting cycles means we might
  take multiple PMU exceptions per second per hardware thread even
  if our hard lockup timeout is 10 seconds.

It can be enabled via a boot option, or via procfs.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/Kconfig                   |  2 +-
 arch/powerpc/Kconfig           |  1 +
 arch/powerpc/include/asm/nmi.h |  4 ++++
 arch/powerpc/kernel/setup_64.c | 20 ++++++++++++++++++++
 4 files changed, 26 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/include/asm/nmi.h

diff --git a/arch/Kconfig b/arch/Kconfig
index 05d7a8a..a8551b0 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -32,7 +32,7 @@ config HAVE_OPROFILE
 
 config OPROFILE_NMI_TIMER
 	def_bool y
-	depends on PERF_EVENTS && HAVE_PERF_EVENTS_NMI
+	depends on (PERF_EVENTS && HAVE_PERF_EVENTS_NMI) && !PPC
 
 config KPROBES
 	bool "Kprobes"
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 88eace4..03791c4 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -148,6 +148,7 @@ config PPC
 	select HAVE_ARCH_AUDITSYSCALL
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select DCACHE_WORD_ACCESS if PPC64 && CPU_LITTLE_ENDIAN
+	select HAVE_PERF_EVENTS_NMI if PPC64
 
 config GENERIC_CSUM
 	def_bool CPU_LITTLE_ENDIAN
diff --git a/arch/powerpc/include/asm/nmi.h b/arch/powerpc/include/asm/nmi.h
new file mode 100644
index 0000000..ff1ccb3
--- /dev/null
+++ b/arch/powerpc/include/asm/nmi.h
@@ -0,0 +1,4 @@
+#ifndef _ASM_NMI_H
+#define _ASM_NMI_H
+
+#endif /* _ASM_NMI_H */
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 1b56320..c368397 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -37,6 +37,7 @@
 #include <linux/memblock.h>
 #include <linux/hugetlb.h>
 #include <linux/memory.h>
+#include <linux/nmi.h>
 
 #include <asm/io.h>
 #include <asm/kdump.h>
@@ -781,3 +782,22 @@ unsigned long memory_block_size_bytes(void)
 struct ppc_pci_io ppc_pci_io;
 EXPORT_SYMBOL(ppc_pci_io);
 #endif
+
+#ifdef CONFIG_HARDLOCKUP_DETECTOR
+u64 hw_nmi_get_sample_period(int watchdog_thresh)
+{
+	return ppc_proc_freq * watchdog_thresh;
+}
+
+/*
+ * The hardlockup detector breaks PMU event based branches and is likely
+ * to get false positives in KVM guests, so disable it by default.
+ */
+static int __init disable_hardlockup_detector(void)
+{
+	watchdog_enable_hardlockup_detector(false);
+
+	return 0;
+}
+early_initcall(disable_hardlockup_detector);
+#endif
-- 
1.9.1
