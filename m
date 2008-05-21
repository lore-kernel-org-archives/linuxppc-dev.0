Return-Path: <luisgpm@linux.vnet.ibm.com>
Received: from igw3.br.ibm.com (igw3.br.ibm.com [32.104.18.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "igw3.br.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 06BA7DDF25
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 07:54:28 +1000 (EST)
Received: from mailhub3.br.ibm.com (unknown [9.18.232.110])
	by igw3.br.ibm.com (Postfix) with ESMTP id 31826390228
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 18:39:17 -0300 (BRST)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.18.232.47])
	by mailhub3.br.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4LLsPeh311404
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 18:54:25 -0300
Received: from d24av02.br.ibm.com (loopback [127.0.0.1])
	by d24av02.br.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4LLsLE5016637
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 18:54:21 -0300
Subject: Re: [RFC] 4xx hardware watchpoint support
From: Luis Machado <luisgpm@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4AD81AD4-796D-4FFE-B209-0E6363F5B798@kernel.crashing.org>
References: <1211391577.6232.15.camel@gargoyle>
	<4AD81AD4-796D-4FFE-B209-0E6363F5B798@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 21 May 2008 18:54:25 -0300
Message-Id: <1211406866.6232.34.camel@gargoyle>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
Reply-To: luisgpm@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks for the inlining tip. It should be now. :-)

So, basically we are looking at a cleaner and much better interface to
set such hardware features? That's something that would greatly improve
the communication from, say, GDB to the kernel regarding these
facilities.

Regards,
Luis

On Wed, 2008-05-21 at 16:16 -0500, Kumar Gala wrote:
> Two real quick notes.
> 
> Take a look at:
> 
> http://ozlabs.org/pipermail/linuxppc-dev/2008-May/055745.html
> 
> and can you try and post the patch inline next time.  Hard to provide  
> review comments on it :)
> 
> - kIndex: linux-2.6.25.1/arch/powerpc/kernel/process.c

===================================================================
--- linux-2.6.25.1.orig/arch/powerpc/kernel/process.c	2008-05-21 07:25:45.000000000 -0700
+++ linux-2.6.25.1/arch/powerpc/kernel/process.c	2008-05-21 07:26:55.000000000 -0700
@@ -219,6 +219,28 @@
 }
 #endif /* CONFIG_SPE */
 
+#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+
+/* Add support for HW Debug breakpoint.  Use DAC register.  */
+int set_dac(unsigned long dac)
+{
+	mtspr(SPRN_DAC1, dac);
+
+	return 0;
+}
+unsigned int get_dac()
+{
+	return mfspr(SPRN_DAC1);
+}
+int set_dbcr0(unsigned long dbcr)
+{
+	mtspr(SPRN_DBCR0, dbcr);
+
+	return 0;
+}
+
+#endif
+
 #ifndef CONFIG_SMP
 /*
  * If we are doing lazy switching of CPU state (FP, altivec or SPE),
@@ -330,6 +352,13 @@
 	if (unlikely(__get_cpu_var(current_dabr) != new->thread.dabr))
 		set_dabr(new->thread.dabr);
 
+
+#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+	/* If new thread DAC (HW breakpoint) is the same then leave it.  */
+	if (new->thread.dac)
+		set_dac(new->thread.dac);
+#endif
+
 	new_thread = &new->thread;
 	old_thread = &current->thread;
 
@@ -515,6 +544,16 @@
 
 	discard_lazy_cpu_state();
 
+#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+	if (current->thread.dac) {
+		current->thread.dac = 0;
+		/* Clear debug control.  */
+		current->thread.dbcr0 &= ~(DBSR_DAC1R | DBSR_DAC1W);
+
+		set_dac(0);
+	}
+#endif
+
 	if (current->thread.dabr) {
 		current->thread.dabr = 0;
 		set_dabr(0);
Index: linux-2.6.25.1/arch/powerpc/kernel/ptrace.c
===================================================================
--- linux-2.6.25.1.orig/arch/powerpc/kernel/ptrace.c	2008-05-21 07:25:45.000000000 -0700
+++ linux-2.6.25.1/arch/powerpc/kernel/ptrace.c	2008-05-21 08:23:34.000000000 -0700
@@ -629,9 +629,15 @@
 {
 	struct pt_regs *regs = task->thread.regs;
 
+#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+	/* If DAC then do not single step, skip.  */
+	if (task->thread.dac)
+		return;
+#endif
+
 	if (regs != NULL) {
 #if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
-		task->thread.dbcr0 = 0;
+		task->thread.dbcr0 &= ~(DBCR0_IC | DBCR0_IDM);
 		regs->msr &= ~MSR_DE;
 #else
 		regs->msr &= ~MSR_SE;
@@ -640,22 +646,83 @@
 	clear_tsk_thread_flag(task, TIF_SINGLESTEP);
 }
 
-static int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
+static int ptrace_get_debugreg(struct task_struct *task, unsigned long data)
+{
+	int ret;
+
+	#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+		ret = put_user(task->thread.dac,
+				(unsigned long __user *)data);
+	#else
+		ret = put_user(task->thread.dabr,
+				(unsigned long __user *)data);
+	#endif
+
+	return ret;
+}
+
+int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
 			       unsigned long data)
 {
-	/* We only support one DABR and no IABRS at the moment */
+	/* For ppc64 we support one DABR and no IABR's at the moment (ppc64).
+	   For embedded processors we support one DAC and no IAC's
+	   at the moment.  */
 	if (addr > 0)
 		return -EINVAL;
 
-	/* The bottom 3 bits are flags */
 	if ((data & ~0x7UL) >= TASK_SIZE)
 		return -EIO;
 
-	/* Ensure translation is on */
+#ifdef CONFIG_PPC64
+
+	/* For processors using DABR (i.e. 970), the bottom 3 bits are flags.
+	   It was assumed, on previous implementations, that 3 bits were
+	   passed together with the data address, fitting the design of the
+	   DABR register, as follows:
+
+	   bit 0: Read flag
+	   bit 1: Write flag
+	   bit 2: Breakpoint translation
+
+	   Thus, we use them here as so.  */
+
+	/* Ensure breakpoint translation bit is set.  */
 	if (data && !(data & DABR_TRANSLATION))
 		return -EIO;
 
+	/* Move contents to the DABR register.  */
 	task->thread.dabr = data;
+
+#endif
+#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+
+	/* Read or Write bits must be set.  */
+	if (!(data & 0x3UL))
+		return -EINVAL;
+
+	/* As described above, we assume 3 bits are passed with the data
+	   address, so mask them so we can set the DAC register with the
+	   correct address.  */
+	task->thread.dac = data & ~0x7UL;
+
+	if (task->thread.dac == 0) {
+		task->thread.dbcr0 &= ~(DBSR_DAC1R | DBSR_DAC1W | DBCR0_IDM);
+		task->thread.regs->msr &= ~MSR_DE;
+		return 0;
+	}
+
+	/* Set the Internal Debugging flag (IDM bit 1) for the DBCR0
+	   register.  */
+	task->thread.dbcr0 = DBCR0_IDM;
+
+	/* Check for write and read flags and set DBCR0 accordingly.  */
+	if (data & 1)
+		task->thread.dbcr0 |= DBSR_DAC1R;
+	if (data & 2)
+		task->thread.dbcr0 |= DBSR_DAC1W;
+
+	task->thread.regs->msr |= MSR_DE;
+#endif
 	return 0;
 }
 
@@ -763,11 +830,10 @@
 
 	case PTRACE_GET_DEBUGREG: {
 		ret = -EINVAL;
-		/* We only support one DABR and no IABRS at the moment */
+		/* We only support one DAC or DABR at the moment.  */
 		if (addr > 0)
 			break;
-		ret = put_user(child->thread.dabr,
-			       (unsigned long __user *)data);
+		ret = ptrace_get_debugreg(child, data);
 		break;
 	}
 
Index: linux-2.6.25.1/arch/powerpc/kernel/signal.c
===================================================================
--- linux-2.6.25.1.orig/arch/powerpc/kernel/signal.c	2008-05-21 07:25:45.000000000 -0700
+++ linux-2.6.25.1/arch/powerpc/kernel/signal.c	2008-05-21 07:26:55.000000000 -0700
@@ -148,6 +148,17 @@
 		set_dabr(current->thread.dabr);
 
 	if (is32) {
+#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+		/*
+		* Reenable the DAC before delivering the signal to
+		* user space. The DAC will have been cleared if it
+		* triggered inside the kernel.
+		*/
+		if (current->thread.dac) {
+			set_dac(current->thread.dac);
+			set_dbcr0(current->thread.dbcr0);
+		}
+#endif
         	if (ka.sa.sa_flags & SA_SIGINFO)
 			ret = handle_rt_signal32(signr, &ka, &info, oldset,
 					regs);
Index: linux-2.6.25.1/arch/powerpc/kernel/traps.c
===================================================================
--- linux-2.6.25.1.orig/arch/powerpc/kernel/traps.c	2008-05-21 07:25:45.000000000 -0700
+++ linux-2.6.25.1/arch/powerpc/kernel/traps.c	2008-05-21 09:08:49.000000000 -0700
@@ -54,6 +54,9 @@
 #endif
 #include <asm/kexec.h>
 
+extern int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
+						      unsigned long data);
+
 #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)
 int (*__debugger)(struct pt_regs *regs);
 int (*__debugger_ipi)(struct pt_regs *regs);
@@ -61,6 +64,7 @@
 int (*__debugger_sstep)(struct pt_regs *regs);
 int (*__debugger_iabr_match)(struct pt_regs *regs);
 int (*__debugger_dabr_match)(struct pt_regs *regs);
+int (*__debugger_dac_match)(struct pt_regs *regs);
 int (*__debugger_fault_handler)(struct pt_regs *regs);
 
 EXPORT_SYMBOL(__debugger);
@@ -69,6 +73,7 @@
 EXPORT_SYMBOL(__debugger_sstep);
 EXPORT_SYMBOL(__debugger_iabr_match);
 EXPORT_SYMBOL(__debugger_dabr_match);
+EXPORT_SYMBOL(__debugger_dac_match);
 EXPORT_SYMBOL(__debugger_fault_handler);
 #endif
 
@@ -253,6 +258,27 @@
 }
 #endif
 
+#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+
+static void do_dac(struct pt_regs *regs, unsigned long address,
+						unsigned long error_code)
+{
+	siginfo_t info;
+
+	/* Clear the DAC and struct entries.  One shot trigger.  */
+	mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) & ~(DBSR_DAC1R | DBSR_DAC1W
+							| DBCR0_IDM));
+	set_dac(0);
+	ptrace_set_debugreg(current, 0, 0);
+
+	/* Deliver signal to userspace.  */
+	info.si_signo = SIGTRAP;
+	info.si_errno = 0;
+	info.si_code = TRAP_HWBKPT;
+	info.si_addr = (void __user *)address;
+	force_sig_info(SIGTRAP, &info, current);
+}
+#endif
 /*
  * I/O accesses can cause machine checks on powermacs.
  * Check if the NIP corresponds to the address of a sync
@@ -1045,6 +1071,20 @@
 				return;
 		}
 		_exception(SIGTRAP, regs, TRAP_TRACE, 0);
+	} else if (debug_status & (DBSR_DAC1R | DBSR_DAC1W)) {
+		regs->msr &= ~MSR_DE;
+		if (user_mode(regs)) {
+			current->thread.dbcr0 &= ~(DBSR_DAC1R | DBSR_DAC1W |
+								DBCR0_IDM);
+		} else {
+			/* Disable DAC interupts.  */
+			mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) & ~(DBSR_DAC1R |
+							DBSR_DAC1W | DBCR0_IDM));
+			/* Clear the DAC event.  */
+			mtspr(SPRN_DBSR, (DBSR_DAC1R | DBSR_DAC1W));
+		}
+		/* Setup and send the trap to the handler.  */
+		do_dac(regs, get_dac(), debug_status);
 	}
 }
 #endif /* CONFIG_4xx || CONFIG_BOOKE */
Index: linux-2.6.25.1/include/asm-powerpc/processor.h
===================================================================
--- linux-2.6.25.1.orig/include/asm-powerpc/processor.h	2008-05-21 07:25:45.000000000 -0700
+++ linux-2.6.25.1/include/asm-powerpc/processor.h	2008-05-21 07:26:55.000000000 -0700
@@ -149,6 +149,7 @@
 #if defined(CONFIG_4xx) || defined (CONFIG_BOOKE)
 	unsigned long	dbcr0;		/* debug control register values */
 	unsigned long	dbcr1;
+	unsigned long   dac;		/* Data Address Compare register */
 #endif
 	double		fpr[32];	/* Complete floating point set */
 	struct {			/* fpr ... fpscr must be contiguous */
Index: linux-2.6.25.1/include/asm-powerpc/system.h
===================================================================
--- linux-2.6.25.1.orig/include/asm-powerpc/system.h	2008-05-21 07:25:45.000000000 -0700
+++ linux-2.6.25.1/include/asm-powerpc/system.h	2008-05-21 08:26:10.000000000 -0700
@@ -73,6 +73,7 @@
 extern int (*__debugger_sstep)(struct pt_regs *regs);
 extern int (*__debugger_iabr_match)(struct pt_regs *regs);
 extern int (*__debugger_dabr_match)(struct pt_regs *regs);
+extern int (*__debugger_dac_match)(struct pt_regs *regs);
 extern int (*__debugger_fault_handler)(struct pt_regs *regs);
 
 #define DEBUGGER_BOILERPLATE(__NAME) \
@@ -89,6 +90,7 @@
 DEBUGGER_BOILERPLATE(debugger_sstep)
 DEBUGGER_BOILERPLATE(debugger_iabr_match)
 DEBUGGER_BOILERPLATE(debugger_dabr_match)
+DEBUGGER_BOILERPLATE(debugger_dac_match)
 DEBUGGER_BOILERPLATE(debugger_fault_handler)
 
 #else
@@ -98,10 +100,17 @@
 static inline int debugger_sstep(struct pt_regs *regs) { return 0; }
 static inline int debugger_iabr_match(struct pt_regs *regs) { return 0; }
 static inline int debugger_dabr_match(struct pt_regs *regs) { return 0; }
+static inline int debugger_dac_match(struct pt_regs *regs) { return 0; }
 static inline int debugger_fault_handler(struct pt_regs *regs) { return 0; }
 #endif
 
 extern int set_dabr(unsigned long dabr);
+
+/* These are 4XX-specific functions for debugging register manipulations.  */
+extern int set_dac(unsigned long dac);
+extern unsigned int get_dac(void);
+extern int set_dbcr0(unsigned long dbcr);
+
 extern void print_backtrace(unsigned long *);
 extern void show_regs(struct pt_regs * regs);
 extern void flush_instruction_cache(void);
Index: linux-2.6.25.1/arch/powerpc/kernel/entry_32.S
===================================================================
--- linux-2.6.25.1.orig/arch/powerpc/kernel/entry_32.S	2008-05-21 07:25:45.000000000 -0700
+++ linux-2.6.25.1/arch/powerpc/kernel/entry_32.S	2008-05-21 07:26:55.000000000 -0700
@@ -112,7 +112,7 @@
 	/* Check to see if the dbcr0 register is set up to debug.  Use the
 	   single-step bit to do this. */
 	lwz	r12,THREAD_DBCR0(r12)
-	andis.	r12,r12,DBCR0_IC@h
+	andis.	r12,r12,(DBCR0_IC | DBSR_DAC1R | DBSR_DAC1W)@h
 	beq+	3f
 	/* From user and task is ptraced - load up global dbcr0 */
 	li	r12,-1			/* clear all pending debug events */
@@ -241,7 +241,7 @@
 	/* If the process has its own DBCR0 value, load it up.  The single
 	   step bit tells us that dbcr0 should be loaded. */
 	lwz	r0,THREAD+THREAD_DBCR0(r2)
-	andis.	r10,r0,DBCR0_IC@h
+	andis.	r10,r0,(DBCR0_IC | DBSR_DAC1R | DBSR_DAC1W)@h
 	bnel-	load_dbcr0
 #endif
 #ifdef CONFIG_44x
@@ -669,7 +669,7 @@
 	/* Check whether this process has its own DBCR0 value.  The single
 	   step bit tells us that dbcr0 should be loaded. */
 	lwz	r0,THREAD+THREAD_DBCR0(r2)
-	andis.	r10,r0,DBCR0_IC@h
+	andis.	r10,r0,(DBCR0_IC | DBSR_DAC1R | DBSR_DAC1W)@h
 	bnel-	load_dbcr0
 #endif
 
Index: linux-2.6.25.1/include/asm-ppc/system.h
===================================================================
--- linux-2.6.25.1.orig/include/asm-ppc/system.h	2008-05-01 14:45:25.000000000 -0700
+++ linux-2.6.25.1/include/asm-ppc/system.h	2008-05-21 08:26:28.000000000 -0700
@@ -56,6 +56,12 @@
 extern void hard_reset_now(void);
 extern void poweroff_now(void);
 extern int set_dabr(unsigned long dabr);
+
+/* These are 4XX-specific functions for debugging register manipulations.  */
+extern int set_dac(unsigned long dac);
+extern unsigned int get_dac(void);
+extern int set_dbcr0(unsigned long dbcr);
+
 #ifdef CONFIG_6xx
 extern long _get_L2CR(void);
 extern long _get_L3CR(void);
