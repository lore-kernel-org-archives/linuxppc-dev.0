Return-Path: <prasad@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AA081B7B69
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Sep 2009 04:40:11 +1000 (EST)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 42A44DDD01
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Sep 2009 04:40:11 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp03.au.ibm.com (8.14.3/8.13.1) with ESMTP id n83IbktV016818
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Sep 2009 04:37:46 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n83IcS7r1089710
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Sep 2009 04:38:28 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n83Ie8Vs024657
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Sep 2009 04:40:08 +1000
Date: Fri, 4 Sep 2009 00:10:02 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>, linuxppc-dev@ozlabs.org
Subject: [Patch 1/6] PPC64-HWBKPT: Prepare the PowerPC platform for HW
	Breakpoint infrastructure
Message-ID: <20090903184002.GB4590@in.ibm.com>
References: <20090903183306.875398457@xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>, paulus@samba.org,
	Alan Stern <stern@rowland.harvard.edu>,
	"K.Prasad" <prasad@linux.vnet.ibm.com>, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Prepare the PowerPC code for HW Breakpoint infrastructure patches by including
relevant constant definitions and function declarations.

Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/hw_breakpoint.h |   61 +++++++++++++++++++++++++++++++
 arch/powerpc/include/asm/processor.h     |    1 
 arch/powerpc/include/asm/reg.h           |    3 +
 arch/powerpc/include/asm/thread_info.h   |    2 +
 4 files changed, 67 insertions(+)

Index: linux-2.6-tip.ppc64_hbkpt/arch/powerpc/include/asm/hw_breakpoint.h
===================================================================
--- /dev/null
+++ linux-2.6-tip.ppc64_hbkpt/arch/powerpc/include/asm/hw_breakpoint.h
@@ -0,0 +1,61 @@
+#ifndef	_PPC64_HW_BREAKPOINT_H
+#define	_PPC64_HW_BREAKPOINT_H
+
+#ifdef	__KERNEL__
+#define	__ARCH_HW_BREAKPOINT_H
+#ifdef CONFIG_PPC64
+
+struct arch_hw_breakpoint {
+	int		type;
+	char		*name; /* Contains name of the symbol to set bkpt */
+	unsigned long	address;
+	unsigned long	symbolsize;
+};
+
+#include <linux/kdebug.h>
+#include <asm/reg.h>
+#include <asm-generic/hw_breakpoint.h>
+
+#define HW_BREAKPOINT_READ DABR_DATA_READ
+#define HW_BREAKPOINT_WRITE DABR_DATA_WRITE
+#define HW_BREAKPOINT_RW (DABR_DATA_READ | DABR_DATA_WRITE)
+
+#define HW_BREAKPOINT_ALIGN 0x7
+/* Maximum permissible length of any HW Breakpoint */
+#define HW_BREAKPOINT_LEN 0x8
+
+extern struct hw_breakpoint *hbp_kernel[HBP_NUM];
+DECLARE_PER_CPU(struct hw_breakpoint*, this_hbp_kernel[HBP_NUM]);
+extern unsigned int hbp_user_refcount[HBP_NUM];
+
+extern void arch_install_thread_hw_breakpoint(struct task_struct *tsk);
+extern void arch_uninstall_thread_hw_breakpoint(void);
+extern int arch_validate_hwbkpt_settings(struct hw_breakpoint *bp,
+						struct task_struct *tsk);
+extern void arch_update_user_hw_breakpoint(int pos, struct task_struct *tsk);
+extern void arch_flush_thread_hw_breakpoint(struct task_struct *tsk);
+extern void arch_update_kernel_hw_breakpoint(void *);
+extern void arch_disable_hw_breakpoint(void);
+extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
+				     unsigned long val, void *data);
+
+extern void flush_thread_hw_breakpoint(struct task_struct *tsk);
+extern int copy_thread_hw_breakpoint(struct task_struct *tsk,
+		struct task_struct *child, unsigned long clone_flags);
+extern void load_debug_registers(void);
+extern void ptrace_triggered(struct hw_breakpoint *bp, struct pt_regs *regs);
+
+static inline void hw_breakpoint_disable(void)
+{
+	set_dabr(0);
+}
+
+#else
+static inline void hw_breakpoint_disable(void)
+{
+	/* Function is defined only on PPC64 for now */
+}
+#endif	/* CONFIG_PPC64 */
+#endif	/* __KERNEL__ */
+#endif	/* _PPC64_HW_BREAKPOINT_H */
+
Index: linux-2.6-tip.ppc64_hbkpt/arch/powerpc/include/asm/processor.h
===================================================================
--- linux-2.6-tip.ppc64_hbkpt.orig/arch/powerpc/include/asm/processor.h
+++ linux-2.6-tip.ppc64_hbkpt/arch/powerpc/include/asm/processor.h
@@ -177,6 +177,7 @@ struct thread_struct {
 #ifdef CONFIG_PPC64
 	unsigned long	start_tb;	/* Start purr when proc switched in */
 	unsigned long	accum_tb;	/* Total accumilated purr for process */
+	struct hw_breakpoint *hbp[HBP_NUM];
 #endif
 	unsigned long	dabr;		/* Data address breakpoint register */
 #ifdef CONFIG_ALTIVEC
Index: linux-2.6-tip.ppc64_hbkpt/arch/powerpc/include/asm/reg.h
===================================================================
--- linux-2.6-tip.ppc64_hbkpt.orig/arch/powerpc/include/asm/reg.h
+++ linux-2.6-tip.ppc64_hbkpt/arch/powerpc/include/asm/reg.h
@@ -26,6 +26,8 @@
 #include <asm/reg_8xx.h>
 #endif /* CONFIG_8xx */
 
+#define INSTRUCTION_LEN	4		/* Length of any instruction */
+
 #define MSR_SF_LG	63              /* Enable 64 bit mode */
 #define MSR_ISF_LG	61              /* Interrupt 64b mode valid on 630 */
 #define MSR_HV_LG 	60              /* Hypervisor state */
@@ -184,6 +186,7 @@
 #define   CTRL_TE	0x00c00000	/* thread enable */
 #define   CTRL_RUNLATCH	0x1
 #define SPRN_DABR	0x3F5	/* Data Address Breakpoint Register */
+#define   HBP_NUM	1	/* Number of physical HW breakpoint registers */
 #define   DABR_TRANSLATION	(1UL << 2)
 #define   DABR_DATA_WRITE	(1UL << 1)
 #define   DABR_DATA_READ	(1UL << 0)
Index: linux-2.6-tip.ppc64_hbkpt/arch/powerpc/include/asm/thread_info.h
===================================================================
--- linux-2.6-tip.ppc64_hbkpt.orig/arch/powerpc/include/asm/thread_info.h
+++ linux-2.6-tip.ppc64_hbkpt/arch/powerpc/include/asm/thread_info.h
@@ -112,6 +112,7 @@ static inline struct thread_info *curren
 #define TIF_FREEZE		14	/* Freezing for suspend */
 #define TIF_RUNLATCH		15	/* Is the runlatch enabled? */
 #define TIF_ABI_PENDING		16	/* 32/64 bit switch needed */
+#define TIF_DEBUG		17	/* uses debug registers */
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
@@ -130,6 +131,7 @@ static inline struct thread_info *curren
 #define _TIF_FREEZE		(1<<TIF_FREEZE)
 #define _TIF_RUNLATCH		(1<<TIF_RUNLATCH)
 #define _TIF_ABI_PENDING	(1<<TIF_ABI_PENDING)
+#define _TIF_DEBUG		(1<<TIF_DEBUG)
 #define _TIF_SYSCALL_T_OR_A	(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SECCOMP)
 
 #define _TIF_USER_WORK_MASK	(_TIF_SIGPENDING | _TIF_NEED_RESCHED | \
