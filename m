Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BC8311A0633
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 14:59:38 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Remove some unused functions
Date: Wed, 28 Jan 2015 14:59:35 +1100
Message-Id: <1422417575-25045-1-git-send-email-mpe@ellerman.id.au>
Cc: rickard_strandqvist@spectrumdigital.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove slice_set_psize() which is not used.

It was added in 3a8247cc2c85 "powerpc: Only demote individual slices
rather than whole process" but was never used.

Remove vsx_assist_exception() which is not used.

It was added in ce48b2100785 "powerpc: Add VSX context save/restore,
ptrace and signal support" but was never used.

Remove generic_mach_cpu_die() which is not used.

Its last caller was removed in 375f561a4131 "powerpc/powernv: Always go
into nap mode when CPU is offline".

Remove mpc7448_hpc2_power_off() and mpc7448_hpc2_halt() which are
unused.

These were introduced in c5d56332fd6c "[POWERPC] Add general support for
mpc7448hpc2 (Taiga) platform" but were never used.

This was partially found by using a static code analysis program called
cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
[mpe: Update changelog with details on when/why they are unused]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/smp.h                    |  1 -
 arch/powerpc/kernel/smp.c                         | 14 -----------
 arch/powerpc/kernel/traps.c                       | 15 ------------
 arch/powerpc/mm/slice.c                           | 29 -----------------------
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c | 11 ---------
 5 files changed, 70 deletions(-)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 5a6614a7f0b2..d607df5081a7 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -64,7 +64,6 @@ DECLARE_PER_CPU(unsigned int, cpu_pvr);
 extern void migrate_irqs(void);
 int generic_cpu_disable(void);
 void generic_cpu_die(unsigned int cpu);
-void generic_mach_cpu_die(void);
 void generic_set_cpu_dead(unsigned int cpu);
 void generic_set_cpu_up(unsigned int cpu);
 int generic_check_cpu_restart(unsigned int cpu);
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 8ec017cb4446..1cc4bdce19f3 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -434,20 +434,6 @@ void generic_cpu_die(unsigned int cpu)
 	printk(KERN_ERR "CPU%d didn't die...\n", cpu);
 }
 
-void generic_mach_cpu_die(void)
-{
-	unsigned int cpu;
-
-	local_irq_disable();
-	idle_task_exit();
-	cpu = smp_processor_id();
-	printk(KERN_DEBUG "CPU%d offline\n", cpu);
-	__this_cpu_write(cpu_state, CPU_DEAD);
-	smp_wmb();
-	while (__this_cpu_read(cpu_state) != CPU_UP_PREPARE)
-		cpu_relax();
-}
-
 void generic_set_cpu_dead(unsigned int cpu)
 {
 	per_cpu(cpu_state, cpu) = CPU_DEAD;
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index e6595b72269b..19e4744b6eba 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1707,21 +1707,6 @@ void altivec_assist_exception(struct pt_regs *regs)
 }
 #endif /* CONFIG_ALTIVEC */
 
-#ifdef CONFIG_VSX
-void vsx_assist_exception(struct pt_regs *regs)
-{
-	if (!user_mode(regs)) {
-		printk(KERN_EMERG "VSX assist exception in kernel mode"
-		       " at %lx\n", regs->nip);
-		die("Kernel VSX assist exception", regs, SIGILL);
-	}
-
-	flush_vsx_to_thread(current);
-	printk(KERN_INFO "VSX assist not supported at %lx\n", regs->nip);
-	_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
-}
-#endif /* CONFIG_VSX */
-
 #ifdef CONFIG_FSL_BOOKE
 void CacheLockingException(struct pt_regs *regs, unsigned long address,
 			   unsigned long error_code)
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index ded0ea1afde4..0f432a702870 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -645,35 +645,6 @@ void slice_set_user_psize(struct mm_struct *mm, unsigned int psize)
 	spin_unlock_irqrestore(&slice_convert_lock, flags);
 }
 
-void slice_set_psize(struct mm_struct *mm, unsigned long address,
-		     unsigned int psize)
-{
-	unsigned char *hpsizes;
-	unsigned long i, flags;
-	u64 *lpsizes;
-
-	spin_lock_irqsave(&slice_convert_lock, flags);
-	if (address < SLICE_LOW_TOP) {
-		i = GET_LOW_SLICE_INDEX(address);
-		lpsizes = &mm->context.low_slices_psize;
-		*lpsizes = (*lpsizes & ~(0xful << (i * 4))) |
-			((unsigned long) psize << (i * 4));
-	} else {
-		int index, mask_index;
-		i = GET_HIGH_SLICE_INDEX(address);
-		hpsizes = mm->context.high_slices_psize;
-		mask_index = i & 0x1;
-		index = i >> 1;
-		hpsizes[index] = (hpsizes[index] &
-				  ~(0xf << (mask_index * 4))) |
-			(((unsigned long)psize) << (mask_index * 4));
-	}
-
-	spin_unlock_irqrestore(&slice_convert_lock, flags);
-
-	copro_flush_all_slbs(mm);
-}
-
 void slice_set_range_psize(struct mm_struct *mm, unsigned long start,
 			   unsigned long len, unsigned int psize)
 {
diff --git a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
index beeaf4a173e1..df4ad95f183e 100644
--- a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
+++ b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
@@ -156,17 +156,6 @@ void mpc7448_hpc2_restart(char *cmd)
 	for (;;) ;		/* Spin until reset happens */
 }
 
-void mpc7448_hpc2_power_off(void)
-{
-	local_irq_disable();
-	for (;;) ;		/* No way to shut power off with software */
-}
-
-void mpc7448_hpc2_halt(void)
-{
-	mpc7448_hpc2_power_off();
-}
-
 /*
  * Called very early, device-tree isn't unflattened
  */
-- 
2.1.0
