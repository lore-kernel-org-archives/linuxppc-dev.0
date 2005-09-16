Return-Path: <galak@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 519A3682F8
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Sep 2005 02:37:40 +1000 (EST)
Date: Fri, 16 Sep 2005 11:37:33 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.61.0509161136530.20199@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc32: Removed non-inlined versions of local_irq* functions
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We always use the inlined versions of local_irq_enable, local_irq_disable,
local_save_flags_ptr, and local_irq_restore on ppc32 so the non-inlined
versions where just taking up space.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit d32a678da44acac59f2767d7437466ab0db90de1
tree 8abc5e2e4846159c467f38ef63c1cda0fc70fdcc
parent 065d9cac98a5406ecd5a1368f8fd38f55739dee9
author Kumar K. Gala <kumar.gala@freescale.com> Fri, 16 Sep 2005 11:30:25 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Fri, 16 Sep 2005 11:30:25 -0500

 arch/ppc/kernel/misc.S      |  128 -------------------------------------------
 arch/ppc/kernel/ppc_ksyms.c |   10 ---
 include/asm-ppc/hw_irq.h    |   16 -----
 3 files changed, 0 insertions(+), 154 deletions(-)

diff --git a/arch/ppc/kernel/misc.S b/arch/ppc/kernel/misc.S
--- a/arch/ppc/kernel/misc.S
+++ b/arch/ppc/kernel/misc.S
@@ -273,134 +273,6 @@ _GLOBAL(low_choose_7447a_dfs)
 
 #endif /* CONFIG_CPU_FREQ_PMAC && CONFIG_6xx */
 
-/* void local_save_flags_ptr(unsigned long *flags) */
-_GLOBAL(local_save_flags_ptr)
-	mfmsr	r4
-	stw	r4,0(r3)
-	blr
-	/*
-	 * Need these nops here for taking over save/restore to
-	 * handle lost intrs
-	 * -- Cort
-	 */
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-_GLOBAL(local_save_flags_ptr_end)
-
-/* void local_irq_restore(unsigned long flags) */
-_GLOBAL(local_irq_restore)
-/*
- * Just set/clear the MSR_EE bit through restore/flags but do not
- * change anything else.  This is needed by the RT system and makes
- * sense anyway.
- *    -- Cort
- */
-	mfmsr 	r4
-	/* Copy all except the MSR_EE bit from r4 (current MSR value)
-	   to r3.  This is the sort of thing the rlwimi instruction is
-	   designed for.  -- paulus. */
-	rlwimi	r3,r4,0,17,15
-	 /* Check if things are setup the way we want _already_. */
-	cmpw	0,r3,r4
-	beqlr
-1:	SYNC
-	mtmsr	r3
-	SYNC
-	blr
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-_GLOBAL(local_irq_restore_end)
-
-_GLOBAL(local_irq_disable)
-	mfmsr	r0		/* Get current interrupt state */
-	rlwinm	r3,r0,16+1,32-1,31	/* Extract old value of 'EE' */
-	rlwinm	r0,r0,0,17,15	/* clear MSR_EE in r0 */
-	SYNC			/* Some chip revs have problems here... */
-	mtmsr	r0		/* Update machine state */
-	blr			/* Done */
-	/*
-	 * Need these nops here for taking over save/restore to
-	 * handle lost intrs
-	 * -- Cort
-	 */
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-_GLOBAL(local_irq_disable_end)
-
-_GLOBAL(local_irq_enable)
-	mfmsr	r3		/* Get current state */
-	ori	r3,r3,MSR_EE	/* Turn on 'EE' bit */
-	SYNC			/* Some chip revs have problems here... */
-	mtmsr	r3		/* Update machine state */
-	blr
-	/*
-	 * Need these nops here for taking over save/restore to
-	 * handle lost intrs
-	 * -- Cort
-	 */
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-_GLOBAL(local_irq_enable_end)
-
 /*
  * complement mask on the msr then "or" some values on.
  *     _nmask_and_or_msr(nmask, value_to_or)
diff --git a/arch/ppc/kernel/ppc_ksyms.c b/arch/ppc/kernel/ppc_ksyms.c
--- a/arch/ppc/kernel/ppc_ksyms.c
+++ b/arch/ppc/kernel/ppc_ksyms.c
@@ -272,16 +272,6 @@ EXPORT_SYMBOL(screen_info);
 #endif
 
 EXPORT_SYMBOL(__delay);
-#ifndef INLINE_IRQS
-EXPORT_SYMBOL(local_irq_enable);
-EXPORT_SYMBOL(local_irq_enable_end);
-EXPORT_SYMBOL(local_irq_disable);
-EXPORT_SYMBOL(local_irq_disable_end);
-EXPORT_SYMBOL(local_save_flags_ptr);
-EXPORT_SYMBOL(local_save_flags_ptr_end);
-EXPORT_SYMBOL(local_irq_restore);
-EXPORT_SYMBOL(local_irq_restore_end);
-#endif
 EXPORT_SYMBOL(timer_interrupt);
 EXPORT_SYMBOL(irq_desc);
 EXPORT_SYMBOL(tb_ticks_per_jiffy);
diff --git a/include/asm-ppc/hw_irq.h b/include/asm-ppc/hw_irq.h
--- a/include/asm-ppc/hw_irq.h
+++ b/include/asm-ppc/hw_irq.h
@@ -10,12 +10,8 @@
 
 extern void timer_interrupt(struct pt_regs *);
 
-#define INLINE_IRQS
-
 #define irqs_disabled()	((mfmsr() & MSR_EE) == 0)
 
-#ifdef INLINE_IRQS
-
 static inline void local_irq_disable(void)
 {
 	unsigned long msr;
@@ -45,18 +41,6 @@ static inline void local_irq_save_ptr(un
 #define local_irq_save(flags)		local_irq_save_ptr(&flags)
 #define local_irq_restore(flags)	mtmsr(flags)
 
-#else
-
-extern void local_irq_enable(void);
-extern void local_irq_disable(void);
-extern void local_irq_restore(unsigned long);
-extern void local_save_flags_ptr(unsigned long *);
-
-#define local_save_flags(flags) local_save_flags_ptr(&flags)
-#define local_irq_save(flags) ({local_save_flags(flags);local_irq_disable();})
-
-#endif
-
 extern void do_lost_interrupts(unsigned long);
 
 #define mask_irq(irq) ({if (irq_desc[irq].handler && irq_desc[irq].handler->disable) irq_desc[irq].handler->disable(irq);})
