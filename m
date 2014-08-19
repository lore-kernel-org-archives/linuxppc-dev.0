Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3F32D1A03D1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 08:00:10 +1000 (EST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH 3/6] powerpc: Move more symbol exports next to function
 definitions
Date: Wed, 20 Aug 2014 08:00:02 +1000
Message-Id: <1408485605-10490-3-git-send-email-anton@samba.org>
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

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/ppc_ksyms.c    | 14 --------------
 arch/powerpc/kernel/process.c      |  2 ++
 arch/powerpc/kernel/setup-common.c |  3 +++
 arch/powerpc/kernel/time.c         |  1 +
 arch/powerpc/mm/hash_utils_64.c    |  1 +
 5 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index 521291d..4a42a1f 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -5,7 +5,6 @@
 #include <linux/elfcore.h>
 #include <linux/string.h>
 #include <linux/interrupt.h>
-#include <linux/screen_info.h>
 #include <linux/vt_kern.h>
 #include <linux/nvram.h>
 #include <linux/irq.h>
@@ -96,8 +95,6 @@ EXPORT_SYMBOL(isa_mem_base);
 EXPORT_SYMBOL(pci_dram_offset);
 #endif /* CONFIG_PCI */
 
-EXPORT_SYMBOL(start_thread);
-
 #ifdef CONFIG_PPC_FPU
 EXPORT_SYMBOL(giveup_fpu);
 EXPORT_SYMBOL(load_fp_state);
@@ -109,7 +106,6 @@ EXPORT_SYMBOL(load_vr_state);
 EXPORT_SYMBOL(store_vr_state);
 #endif /* CONFIG_ALTIVEC */
 #ifdef CONFIG_VSX
-EXPORT_SYMBOL(giveup_vsx);
 EXPORT_SYMBOL_GPL(__giveup_vsx);
 #endif /* CONFIG_VSX */
 #ifdef CONFIG_SPE
@@ -128,8 +124,6 @@ EXPORT_SYMBOL(smp_hw_index);
 #endif
 #endif
 
-EXPORT_SYMBOL(to_tm);
-
 #ifdef CONFIG_PPC32
 long long __ashrdi3(long long, int);
 long long __ashldi3(long long, int);
@@ -150,10 +144,6 @@ EXPORT_SYMBOL(memmove);
 EXPORT_SYMBOL(memcmp);
 EXPORT_SYMBOL(memchr);
 
-#if defined(CONFIG_FB_VGA16_MODULE)
-EXPORT_SYMBOL(screen_info);
-#endif
-
 #ifdef CONFIG_PPC32
 EXPORT_SYMBOL(timer_interrupt);
 EXPORT_SYMBOL(tb_ticks_per_jiffy);
@@ -189,10 +179,6 @@ EXPORT_SYMBOL(__arch_hweight32);
 EXPORT_SYMBOL(__arch_hweight64);
 #endif
 
-#ifdef CONFIG_PPC_BOOK3S_64
-EXPORT_SYMBOL_GPL(mmu_psize_defs);
-#endif
-
 #ifdef CONFIG_EPAPR_PARAVIRT
 EXPORT_SYMBOL(epapr_hypercall_start);
 #endif
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index bf44ae9..aa1df89 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -228,6 +228,7 @@ void giveup_vsx(struct task_struct *tsk)
 	giveup_altivec_maybe_transactional(tsk);
 	__giveup_vsx(tsk);
 }
+EXPORT_SYMBOL(giveup_vsx);
 
 void flush_vsx_to_thread(struct task_struct *tsk)
 {
@@ -1316,6 +1317,7 @@ void start_thread(struct pt_regs *regs, unsigned long start, unsigned long sp)
 	current->thread.tm_tfiar = 0;
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
 }
+EXPORT_SYMBOL(start_thread);
 
 #define PR_FP_ALL_EXCEPT (PR_FP_EXC_DIV | PR_FP_EXC_OVF | PR_FP_EXC_UND \
 		| PR_FP_EXC_RES | PR_FP_EXC_INV)
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 1b0e260..c933acd 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -94,6 +94,9 @@ struct screen_info screen_info = {
 	.orig_video_isVGA = 1,
 	.orig_video_points = 16
 };
+#if defined(CONFIG_FB_VGA16_MODULE)
+EXPORT_SYMBOL(screen_info);
+#endif
 
 /* Variables required to store legacy IO irq routing */
 int of_i8042_kbd_irq;
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 368ab37..055558b 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -1024,6 +1024,7 @@ void to_tm(int tim, struct rtc_time * tm)
 	 */
 	GregorianDay(tm);
 }
+EXPORT_SYMBOL(to_tm);
 
 /*
  * Divide a 128-bit dividend by a 32-bit divisor, leaving a 128 bit
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index daee7f4..bc6cc2a 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -92,6 +92,7 @@ extern unsigned long dart_tablebase;
 
 static unsigned long _SDR1;
 struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
+EXPORT_SYMBOL_GPL(mmu_psize_defs);
 
 struct hash_pte *htab_address;
 unsigned long htab_size_bytes;
-- 
1.9.1
