Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F1B311A0650
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 08:00:14 +1000 (EST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH 6/6] powerpc: Separate ppc32 symbol exports into ppc_ksyms_32.c
Date: Wed, 20 Aug 2014 08:00:05 +1000
Message-Id: <1408485605-10490-6-git-send-email-anton@samba.org>
In-Reply-To: <1408485605-10490-1-git-send-email-anton@samba.org>
References: <1408485605-10490-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Simplify things considerably by moving all the ppc32 specific
symbol exports into its own file.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/Makefile       |   3 +
 arch/powerpc/kernel/ppc_ksyms.c    | 123 +++++--------------------------------
 arch/powerpc/kernel/ppc_ksyms_32.c |  61 ++++++++++++++++++
 3 files changed, 79 insertions(+), 108 deletions(-)
 create mode 100644 arch/powerpc/kernel/ppc_ksyms_32.c

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 670c312..502cf69 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -93,6 +93,9 @@ obj-$(CONFIG_PPC32)		+= entry_32.o setup_32.o
 obj-$(CONFIG_PPC64)		+= dma-iommu.o iommu.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
 obj-$(CONFIG_MODULES)		+= ppc_ksyms.o
+ifeq ($(CONFIG_PPC32),y)
+obj-$(CONFIG_MODULES)		+= ppc_ksyms_32.o
+endif
 obj-$(CONFIG_BOOTX_TEXT)	+= btext.o
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index aba41f3..c4dfff6 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -1,135 +1,42 @@
-#include <linux/export.h>
-#include <linux/threads.h>
-#include <linux/smp.h>
-#include <linux/sched.h>
-#include <linux/elfcore.h>
-#include <linux/string.h>
-#include <linux/interrupt.h>
-#include <linux/vt_kern.h>
-#include <linux/nvram.h>
-#include <linux/irq.h>
-#include <linux/pci.h>
-#include <linux/delay.h>
-#include <linux/bitops.h>
+#include <linux/ftrace.h>
+#include <linux/mm.h>
 
-#include <asm/page.h>
 #include <asm/processor.h>
-#include <asm/cacheflush.h>
-#include <asm/uaccess.h>
-#include <asm/io.h>
-#include <linux/atomic.h>
-#include <asm/checksum.h>
-#include <asm/pgtable.h>
-#include <asm/tlbflush.h>
-#include <linux/adb.h>
-#include <linux/cuda.h>
-#include <linux/pmu.h>
-#include <asm/prom.h>
-#include <asm/pci-bridge.h>
-#include <asm/irq.h>
-#include <asm/pmac_feature.h>
-#include <asm/dma.h>
-#include <asm/machdep.h>
-#include <asm/hw_irq.h>
-#include <asm/nvram.h>
-#include <asm/mmu_context.h>
-#include <asm/backlight.h>
-#include <asm/time.h>
-#include <asm/cputable.h>
-#include <asm/btext.h>
-#include <asm/div64.h>
-#include <asm/signal.h>
-#include <asm/dcr.h>
-#include <asm/ftrace.h>
 #include <asm/switch_to.h>
+#include <asm/cacheflush.h>
 #include <asm/epapr_hcalls.h>
 
-#ifdef CONFIG_PPC32
-EXPORT_SYMBOL(clear_pages);
-EXPORT_SYMBOL(ISA_DMA_THRESHOLD);
-EXPORT_SYMBOL(DMA_MODE_READ);
-EXPORT_SYMBOL(DMA_MODE_WRITE);
-#endif
+EXPORT_SYMBOL(flush_dcache_range);
+EXPORT_SYMBOL(flush_icache_range);
+
+EXPORT_SYMBOL(empty_zero_page);
+
+long long __bswapdi2(long long);
+EXPORT_SYMBOL(__bswapdi2);
 
 #ifdef CONFIG_FUNCTION_TRACER
 EXPORT_SYMBOL(_mcount);
 #endif
 
-#if defined(CONFIG_PCI) && defined(CONFIG_PPC32)
-EXPORT_SYMBOL(isa_io_base);
-EXPORT_SYMBOL(isa_mem_base);
-EXPORT_SYMBOL(pci_dram_offset);
-#endif /* CONFIG_PCI */
-
 #ifdef CONFIG_PPC_FPU
 EXPORT_SYMBOL(giveup_fpu);
 EXPORT_SYMBOL(load_fp_state);
 EXPORT_SYMBOL(store_fp_state);
 #endif
+
 #ifdef CONFIG_ALTIVEC
 EXPORT_SYMBOL(giveup_altivec);
 EXPORT_SYMBOL(load_vr_state);
 EXPORT_SYMBOL(store_vr_state);
-#endif /* CONFIG_ALTIVEC */
-#ifdef CONFIG_VSX
-EXPORT_SYMBOL_GPL(__giveup_vsx);
-#endif /* CONFIG_VSX */
-#ifdef CONFIG_SPE
-EXPORT_SYMBOL(giveup_spe);
-#endif /* CONFIG_SPE */
-
-#ifndef CONFIG_PPC64
-EXPORT_SYMBOL(flush_instruction_cache);
-#endif
-EXPORT_SYMBOL(flush_dcache_range);
-EXPORT_SYMBOL(flush_icache_range);
-
-#ifdef CONFIG_SMP
-#ifdef CONFIG_PPC32
-EXPORT_SYMBOL(smp_hw_index);
-#endif
-#endif
-
-#ifdef CONFIG_PPC32
-long long __ashrdi3(long long, int);
-long long __ashldi3(long long, int);
-long long __lshrdi3(long long, int);
-EXPORT_SYMBOL(__ashrdi3);
-EXPORT_SYMBOL(__ashldi3);
-EXPORT_SYMBOL(__lshrdi3);
-int __ucmpdi2(unsigned long long, unsigned long long);
-EXPORT_SYMBOL(__ucmpdi2);
-int __cmpdi2(long long, long long);
-EXPORT_SYMBOL(__cmpdi2);
-#endif
-long long __bswapdi2(long long);
-EXPORT_SYMBOL(__bswapdi2);
-
-#ifdef CONFIG_PPC32
-EXPORT_SYMBOL(timer_interrupt);
-EXPORT_SYMBOL(tb_ticks_per_jiffy);
 #endif
 
-#ifdef CONFIG_PPC32
-EXPORT_SYMBOL(switch_mmu_context);
+#ifdef CONFIG_VSX
+EXPORT_SYMBOL_GPL(__giveup_vsx);
 #endif
 
-#ifdef CONFIG_PPC_STD_MMU_32
-extern long mol_trampoline;
-EXPORT_SYMBOL(mol_trampoline); /* For MOL */
-EXPORT_SYMBOL(flush_hash_pages); /* For MOL */
-#ifdef CONFIG_SMP
-extern int mmu_hash_lock;
-EXPORT_SYMBOL(mmu_hash_lock); /* For MOL */
-#endif /* CONFIG_SMP */
-extern long *intercept_table;
-EXPORT_SYMBOL(intercept_table);
-#endif /* CONFIG_PPC_STD_MMU_32 */
-#ifdef CONFIG_PPC_DCR_NATIVE
-EXPORT_SYMBOL(__mtdcr);
-EXPORT_SYMBOL(__mfdcr);
+#ifdef CONFIG_SPE
+EXPORT_SYMBOL(giveup_spe);
 #endif
-EXPORT_SYMBOL(empty_zero_page);
 
 #ifdef CONFIG_EPAPR_PARAVIRT
 EXPORT_SYMBOL(epapr_hypercall_start);
diff --git a/arch/powerpc/kernel/ppc_ksyms_32.c b/arch/powerpc/kernel/ppc_ksyms_32.c
new file mode 100644
index 0000000..30ddd8a
--- /dev/null
+++ b/arch/powerpc/kernel/ppc_ksyms_32.c
@@ -0,0 +1,61 @@
+#include <linux/export.h>
+#include <linux/smp.h>
+
+#include <asm/page.h>
+#include <asm/dma.h>
+#include <asm/io.h>
+#include <asm/hw_irq.h>
+#include <asm/time.h>
+#include <asm/mmu_context.h>
+#include <asm/pgtable.h>
+#include <asm/dcr.h>
+
+EXPORT_SYMBOL(clear_pages);
+EXPORT_SYMBOL(ISA_DMA_THRESHOLD);
+EXPORT_SYMBOL(DMA_MODE_READ);
+EXPORT_SYMBOL(DMA_MODE_WRITE);
+
+#if defined(CONFIG_PCI)
+EXPORT_SYMBOL(isa_io_base);
+EXPORT_SYMBOL(isa_mem_base);
+EXPORT_SYMBOL(pci_dram_offset);
+#endif
+
+#ifdef CONFIG_SMP
+EXPORT_SYMBOL(smp_hw_index);
+#endif
+
+long long __ashrdi3(long long, int);
+long long __ashldi3(long long, int);
+long long __lshrdi3(long long, int);
+int __ucmpdi2(unsigned long long, unsigned long long);
+int __cmpdi2(long long, long long);
+EXPORT_SYMBOL(__ashrdi3);
+EXPORT_SYMBOL(__ashldi3);
+EXPORT_SYMBOL(__lshrdi3);
+EXPORT_SYMBOL(__ucmpdi2);
+EXPORT_SYMBOL(__cmpdi2);
+
+EXPORT_SYMBOL(timer_interrupt);
+EXPORT_SYMBOL(tb_ticks_per_jiffy);
+
+EXPORT_SYMBOL(switch_mmu_context);
+
+#ifdef CONFIG_PPC_STD_MMU_32
+extern long mol_trampoline;
+EXPORT_SYMBOL(mol_trampoline); /* For MOL */
+EXPORT_SYMBOL(flush_hash_pages); /* For MOL */
+#ifdef CONFIG_SMP
+extern int mmu_hash_lock;
+EXPORT_SYMBOL(mmu_hash_lock); /* For MOL */
+#endif /* CONFIG_SMP */
+extern long *intercept_table;
+EXPORT_SYMBOL(intercept_table);
+#endif /* CONFIG_PPC_STD_MMU_32 */
+
+#ifdef CONFIG_PPC_DCR_NATIVE
+EXPORT_SYMBOL(__mtdcr);
+EXPORT_SYMBOL(__mfdcr);
+#endif
+
+EXPORT_SYMBOL(flush_instruction_cache);
-- 
1.9.1
