Return-Path: <fweisbec@gmail.com>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 94119B6F9E
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 May 2011 07:52:42 +1000 (EST)
Received: by wwi18 with SMTP id 18so2849121wwi.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 May 2011 14:52:38 -0700 (PDT)
From: Frederic Weisbecker <fweisbec@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/6] x86: Allow the user not to build hw_breakpoints
Date: Tue, 24 May 2011 23:52:24 +0200
Message-Id: <1306273947-8410-4-git-send-email-fweisbec@gmail.com>
In-Reply-To: <1306273947-8410-1-git-send-email-fweisbec@gmail.com>
References: <1306273947-8410-1-git-send-email-fweisbec@gmail.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Frederic Weisbecker <fweisbec@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

So that hw_breakpoints and perf can be not built on
specific embedded systems.

Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Jason Wessel <jason.wessel@windriver.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/Kconfig                |    3 +--
 arch/x86/include/asm/debugreg.h |   33 +++++++++++++++++++++++++++++++--
 arch/x86/kernel/Makefile        |    3 ++-
 arch/x86/kernel/process.c       |    1 +
 arch/x86/kernel/ptrace.c        |   17 +++++++++++++++++
 5 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 8b49bff..fb28dd9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -41,7 +41,7 @@ config X86
 	select HAVE_FTRACE_NMI_ENTER if DYNAMIC_FTRACE
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_KVM
-	select HAVE_ARCH_KGDB
+	select HAVE_ARCH_KGDB if HW_BREAKPOINT
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_GENERIC_DMA_COHERENT if X86_32
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
@@ -54,7 +54,6 @@ config X86
 	select HAVE_KERNEL_XZ
 	select HAVE_KERNEL_LZO
 	select HAVE_HW_BREAKPOINT
-	select HW_BREAKPOINT
 	select HAVE_MIXED_BREAKPOINTS_REGS
 	select PERF_EVENTS
 	select HAVE_PERF_EVENTS_NMI
diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debugreg.h
index 078ad0c..c40d6d4 100644
--- a/arch/x86/include/asm/debugreg.h
+++ b/arch/x86/include/asm/debugreg.h
@@ -78,8 +78,6 @@
  */
 #ifdef __KERNEL__
 
-DECLARE_PER_CPU(unsigned long, cpu_dr7);
-
 static inline void hw_breakpoint_disable(void)
 {
 	/* Zero the control register for HW Breakpoint */
@@ -92,6 +90,10 @@ static inline void hw_breakpoint_disable(void)
 	set_debugreg(0UL, 3);
 }
 
+#ifdef CONFIG_HW_BREAKPOINT
+
+DECLARE_PER_CPU(unsigned long, cpu_dr7);
+
 static inline int hw_breakpoint_active(void)
 {
 	return __this_cpu_read(cpu_dr7) & DR_GLOBAL_ENABLE_MASK;
@@ -100,6 +102,33 @@ static inline int hw_breakpoint_active(void)
 extern void aout_dump_debugregs(struct user *dump);
 
 extern void hw_breakpoint_restore(void);
+#else
+static inline int hw_breakpoint_active(void)
+{
+	return 0;
+}
+
+static inline void hw_breakpoint_restore(void)
+{
+	set_debugreg(0UL, 0);
+	set_debugreg(0UL, 1);
+	set_debugreg(0UL, 2);
+	set_debugreg(0UL, 3);
+	set_debugreg(current->thread.debugreg6, 6);
+	set_debugreg(0UL, 7);
+}
+
+static inline void aout_dump_debugregs(struct user *dump)
+{
+	int i;
+
+	for (i = 0; i < 6; i++)
+		dump->u_debugreg[i] = 0;
+
+	dump->u_debugreg[6] = current->thread.debugreg6;
+	dump->u_debugreg[7] = 0;
+}
+#endif /* CONFIG_HW_BREAKPOINT */
 
 #endif	/* __KERNEL__ */
 
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 7338ef2..270e439 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -42,7 +42,7 @@ obj-$(CONFIG_X86_64)	+= sys_x86_64.o x8664_ksyms_64.o
 obj-$(CONFIG_X86_64)	+= syscall_64.o vsyscall_64.o
 obj-y			+= bootflag.o e820.o
 obj-y			+= pci-dma.o quirks.o topology.o kdebugfs.o
-obj-y			+= alternative.o i8253.o pci-nommu.o hw_breakpoint.o
+obj-y			+= alternative.o i8253.o pci-nommu.o
 obj-y			+= tsc.o io_delay.o rtc.o
 obj-y			+= pci-iommu_table.o
 obj-y			+= resource.o
@@ -51,6 +51,7 @@ obj-y				+= trampoline.o trampoline_$(BITS).o
 obj-y				+= process.o
 obj-y				+= i387.o xsave.o
 obj-y				+= ptrace.o
+obj-$(CONFIG_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_X86_32)		+= tls.o
 obj-$(CONFIG_IA32_EMULATION)	+= tls.o
 obj-y				+= step.o
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index d46cbe4..d1adbd1 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -22,6 +22,7 @@
 #include <asm/uaccess.h>
 #include <asm/i387.h>
 #include <asm/debugreg.h>
+#include <asm/kdebug.h>
 
 struct kmem_cache *task_xstate_cachep;
 EXPORT_SYMBOL_GPL(task_xstate_cachep);
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index f65e5b5..091f110c 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -528,6 +528,7 @@ static int genregs_set(struct task_struct *target,
 	return ret;
 }
 
+#ifdef CONFIG_HW_BREAKPOINT
 static void ptrace_triggered(struct perf_event *bp, int nmi,
 			     struct perf_sample_data *data,
 			     struct pt_regs *regs)
@@ -777,6 +778,22 @@ ret_path:
 	return rc;
 }
 
+#else /* !CONFIG_HW_BREAKPOINT */
+
+static inline unsigned long
+ptrace_get_debugreg(struct task_struct *tsk, int n)
+{
+	return -ENOSYS;
+}
+
+static inline
+int ptrace_set_debugreg(struct task_struct *tsk, int n, unsigned long val)
+{
+	return -ENOSYS;
+}
+
+#endif /* CONFIG_HW_BREAKPOINT */
+
 /*
  * These access the current or another (stopped) task's io permission
  * bitmap for debugging or core dump.
-- 
1.7.3.2
