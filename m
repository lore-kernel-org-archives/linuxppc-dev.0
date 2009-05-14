Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [59.145.155.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp08.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 521D8DDFEE
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 23:43:44 +1000 (EST)
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28smtp08.in.ibm.com (8.13.1/8.13.1) with ESMTP id n4ED1CT8000512
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 18:31:12 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4EDhcY1790622
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 19:13:38 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.13.1/8.13.3) with ESMTP id n4EDhbaW030130
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 23:43:38 +1000
Date: Thu, 14 May 2009 19:13:35 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC Patch 1/6] Prepare the PowerPC platform for HW Breakpoint
	infrastructure
Message-ID: <20090514134335.GB14229@in.ibm.com>
References: <20090514133312.360702378@prasadkr_t60p.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	Alan Stern <stern@rowland.harvard.edu>, paulus@samba.org,
	"K.Prasad" <prasad@linux.vnet.ibm.com>, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Prepare the PowerPC code for HW Breakpoint infrastructure patches by including
relevant constant definitions and function declarations.

Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/hw_breakpoint.h |   49 +++++
 arch/powerpc/include/asm/processor.h     |    1 
 arch/powerpc/include/asm/reg.h           |    4 

Index: linux-2.6-tip.hbkpt/arch/powerpc/include/asm/hw_breakpoint.h
===================================================================
--- /dev/null
+++ linux-2.6-tip.hbkpt/arch/powerpc/include/asm/hw_breakpoint.h
@@ -0,0 +1,49 @@
+#ifndef	_PPC64_HW_BREAKPOINT_H
+#define	_PPC64_HW_BREAKPOINT_H
+
+#ifdef	__KERNEL__
+#define	__ARCH_HW_BREAKPOINT_H
+
+struct arch_hw_breakpoint {
+	char		*name; /* Contains name of the symbol to set bkpt */
+	unsigned long	address;
+	u8		type;
+};
+
+#include <linux/kdebug.h>
+#include <asm/reg.h>
+#include <asm-generic/hw_breakpoint.h>
+
+#define HW_BREAKPOINT_READ DABR_DATA_READ
+#define HW_BREAKPOINT_WRITE DABR_DATA_WRITE
+#define HW_BREAKPOINT_RW DABR_DATA_RW
+
+#define HW_BREAKPOINT_ALIGN 0x7
+#define HW_BREAKPOINT_LEN INSTRUCTION_LEN
+
+extern struct hw_breakpoint *hbp_kernel[HBP_NUM];
+extern unsigned int hbp_user_refcount[HBP_NUM];
+
+extern void arch_install_thread_hw_breakpoint(struct task_struct *tsk);
+extern void arch_uninstall_thread_hw_breakpoint(void);
+extern int arch_validate_hwbkpt_settings(struct hw_breakpoint *bp,
+						struct task_struct *tsk);
+extern void arch_update_user_hw_breakpoint(int pos, struct task_struct *tsk);
+extern void arch_flush_thread_hw_breakpoint(struct task_struct *tsk);
+extern void arch_update_kernel_hw_breakpoint(void *);
+extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
+				     unsigned long val, void *data);
+
+extern void flush_thread_hw_breakpoint(struct task_struct *tsk);
+extern int copy_thread_hw_breakpoint(struct task_struct *tsk,
+		struct task_struct *child, unsigned long clone_flags);
+extern void switch_to_thread_hw_breakpoint(struct task_struct *tsk);
+
+static inline void hw_breakpoint_disable(void)
+{
+	set_dabr(0);
+}
+
+#endif	/* __KERNEL__ */
+#endif	/* _PPC64_HW_BREAKPOINT_H */
+
Index: linux-2.6-tip.hbkpt/arch/powerpc/include/asm/processor.h
===================================================================
--- linux-2.6-tip.hbkpt.orig/arch/powerpc/include/asm/processor.h
+++ linux-2.6-tip.hbkpt/arch/powerpc/include/asm/processor.h
@@ -177,6 +177,7 @@ struct thread_struct {
 #ifdef CONFIG_PPC64
 	unsigned long	start_tb;	/* Start purr when proc switched in */
 	unsigned long	accum_tb;	/* Total accumilated purr for process */
+	struct hw_breakpoint *hbp[HBP_NUM];
 #endif
 	unsigned long	dabr;		/* Data address breakpoint register */
 #ifdef CONFIG_ALTIVEC
Index: linux-2.6-tip.hbkpt/arch/powerpc/include/asm/reg.h
===================================================================
--- linux-2.6-tip.hbkpt.orig/arch/powerpc/include/asm/reg.h
+++ linux-2.6-tip.hbkpt/arch/powerpc/include/asm/reg.h
@@ -26,6 +26,8 @@
 #include <asm/reg_8xx.h>
 #endif /* CONFIG_8xx */
 
+#define INSTRUCTION_LEN	4		/* Length of any instruction */
+
 #define MSR_SF_LG	63              /* Enable 64 bit mode */
 #define MSR_ISF_LG	61              /* Interrupt 64b mode valid on 630 */
 #define MSR_HV_LG 	60              /* Hypervisor state */
@@ -184,9 +186,11 @@
 #define   CTRL_TE	0x00c00000	/* thread enable */
 #define   CTRL_RUNLATCH	0x1
 #define SPRN_DABR	0x3F5	/* Data Address Breakpoint Register */
+#define   HBP_NUM	1	/* Number of physical HW breakpoint registers */
 #define   DABR_TRANSLATION	(1UL << 2)
 #define   DABR_DATA_WRITE	(1UL << 1)
 #define   DABR_DATA_READ	(1UL << 0)
+#define   DABR_DATA_RW		(3UL << 0)
 #define SPRN_DABR2	0x13D	/* e300 */
 #define SPRN_DABRX	0x3F7	/* Data Address Breakpoint Register Extension */
 #define   DABRX_USER	(1UL << 0)
