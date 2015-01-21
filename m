Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 70D181A0D1A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 14:46:26 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 rric@kernel.org
Subject: [PATCH 2/2] powerpc: Add ppc64 hard lockup detector support
Date: Wed, 21 Jan 2015 14:46:23 +1100
Message-Id: <1421811983-22788-2-git-send-email-anton@samba.org>
In-Reply-To: <1421811983-22788-1-git-send-email-anton@samba.org>
References: <1421811983-22788-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, oprofile-list@lists.sf.net
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
 arch/powerpc/Kconfig           |  1 +
 arch/powerpc/include/asm/nmi.h |  4 ++++
 arch/powerpc/kernel/setup_64.c | 20 ++++++++++++++++++++
 3 files changed, 25 insertions(+)
 create mode 100644 arch/powerpc/include/asm/nmi.h

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a2a168e..f6f4734 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -152,6 +152,7 @@ config PPC
 	select DCACHE_WORD_ACCESS if PPC64 && CPU_LITTLE_ENDIAN
 	select NO_BOOTMEM
 	select HAVE_GENERIC_RCU_GUP
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
index 300be7d..ae39ec6 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -37,6 +37,7 @@
 #include <linux/memblock.h>
 #include <linux/hugetlb.h>
 #include <linux/memory.h>
+#include <linux/nmi.h>
 
 #include <asm/io.h>
 #include <asm/kdump.h>
@@ -779,3 +780,22 @@ unsigned long memory_block_size_bytes(void)
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
2.1.0
