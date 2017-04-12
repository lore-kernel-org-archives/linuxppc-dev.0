Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2xGR6CzGzDqFS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 18:02:07 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3C7rwcB055015
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 04:02:05 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29scje8eym-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 04:02:05 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 12 Apr 2017 18:02:02 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3C81qTK45744362
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 18:02:00 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3C81NKu002796
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 18:01:24 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v7 04/11] powerpc: reverse the soft_enable logic
Date: Wed, 12 Apr 2017 13:30:33 +0530
In-Reply-To: <1491984040-28801-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1491984040-28801-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1491984040-28801-5-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"paca->soft_enabled" is used as a flag to mask some of interrupts.
Currently supported flags values and their details:

soft_enabled    MSR[EE]

0               0       Disabled (PMI and HMI not masked)
1               1       Enabled

"paca->soft_enabled" is initialized to 1 to make the interripts as
enabled. arch_local_irq_disable() will toggle the value when interrupts
needs to disbled. At this point, the interrupts are not actually disabled,
instead, interrupt vector has code to check for the flag and mask it when it occurs.
By "mask it", it update interrupt paca->irq_happened and return.
arch_local_irq_restore() is called to re-enable interrupts, which checks and
replays interrupts if any occured.

Now, as mentioned, current logic doesnot mask "performance monitoring interrupts"
and PMIs are implemented as NMI. But this patchset depends on local_irq_*
for a successful local_* update. Meaning, mask all possible interrupts during
local_* update and replay them after the update.

So the idea here is to reserve the "paca->soft_enabled" logic. New values and
details:

soft_enabled    MSR[EE]

1               0       Disabled  (PMI and HMI not masked)
0               1       Enabled

Reason for the this change is to create foundation for a third mask value "0x2"
for "soft_enabled" to add support to mask PMIs. When ->soft_enabled is
set to a value "3", PMI interrupts are mask and when set to a value
of "1", PMI are not mask. With this patch also extends soft_enabled
interrupt disable mask.

Patch also fixes the ptrace call to force the user to see the softe value
to be alway 1. Reason being, even though userspace has no business knowing about
softe, it is part of pt_regs. Like-wise in signal context

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/exception-64s.h |  4 ++--
 arch/powerpc/include/asm/hw_irq.h        |  6 +++---
 arch/powerpc/kernel/entry_64.S           |  5 ++---
 arch/powerpc/kernel/ptrace.c             | 10 ++++++++++
 arch/powerpc/kernel/signal_32.c          |  8 ++++++++
 arch/powerpc/kernel/signal_64.c          |  3 +++
 6 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index af1b90ff78ff..5d0904433a3a 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -455,9 +455,9 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 #define __SOFTEN_TEST(h, vec)						\
 	lbz	r10,PACASOFTIRQEN(r13);					\
-	cmpwi	r10,IRQ_DISABLE_MASK_LINUX;				\
+	andi.	r10,r10,IRQ_DISABLE_MASK_LINUX;				\
 	li	r10,SOFTEN_VALUE_##vec;					\
-	beq	masked_##h##interrupt
+	bne	masked_##h##interrupt
 
 #define _SOFTEN_TEST(h, vec)	__SOFTEN_TEST(h, vec)
 
diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index c292ef4b4bc5..f7c761902dc9 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -30,8 +30,8 @@
 /*
  * flags for paca->soft_enabled
  */
-#define IRQ_DISABLE_MASK_NONE	1
-#define IRQ_DISABLE_MASK_LINUX	0
+#define IRQ_DISABLE_MASK_NONE	0
+#define IRQ_DISABLE_MASK_LINUX	1
 
 #endif /* CONFIG_PPC64 */
 
@@ -134,7 +134,7 @@ static inline bool arch_irqs_disabled(void)
 	_was_enabled = local_paca->soft_enabled;	\
 	local_paca->soft_enabled = IRQ_DISABLE_MASK_LINUX;\
 	local_paca->irq_happened |= PACA_IRQ_HARD_DIS;	\
-	if (_was_enabled == IRQ_DISABLE_MASK_NONE)	\
+	if (!(_was_enabled & IRQ_DISABLE_MASK_LINUX))	\
 		trace_hardirqs_off();			\
 } while(0)
 
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 8e347ffca14e..7ef3064ddde1 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -132,8 +132,7 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 	 */
 #if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_BUG)
 	lbz	r10,PACASOFTIRQEN(r13)
-	xori	r10,r10,IRQ_DISABLE_MASK_NONE
-1:	tdnei	r10,0
+1:	tdnei	r10,IRQ_DISABLE_MASK_NONE
 	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,BUGFLAG_WARNING
 #endif
 
@@ -1010,7 +1009,7 @@ _GLOBAL(enter_rtas)
 	 * check it with the asm equivalent of WARN_ON
 	 */
 	lbz	r0,PACASOFTIRQEN(r13)
-1:	tdnei	r0,IRQ_DISABLE_MASK_LINUX
+1:	tdeqi	r0,IRQ_DISABLE_MASK_NONE
 	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,BUGFLAG_WARNING
 #endif
 	
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 925a4ef90559..75c10d4aaf30 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -276,6 +276,16 @@ int ptrace_get_reg(struct task_struct *task, int regno, unsigned long *data)
 	if (regno == PT_DSCR)
 		return get_user_dscr(task, data);
 
+	/*
+	 * softe copies paca->soft_enabled variable state. Since soft_enabled is
+	 * no more used as a flag, lets force usr to alway see the softe value as 1
+	 * which means interrupts are not soft disabled.
+	 */
+	if (regno == PT_SOFTE) {
+		*data = 1;
+		return  0;
+	}
+
 	if (regno < (sizeof(struct pt_regs) / sizeof(unsigned long))) {
 		*data = ((unsigned long *)task->thread.regs)[regno];
 		return 0;
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 97bb1385e771..bc1216f9be3c 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -138,12 +138,20 @@ static inline int save_general_regs(struct pt_regs *regs,
 {
 	elf_greg_t64 *gregs = (elf_greg_t64 *)regs;
 	int i;
+	/* Force usr to alway see softe as 1 (interrupts enabled) */
+	elf_greg_t64 softe = 0x1;
 
 	WARN_ON(!FULL_REGS(regs));
 
 	for (i = 0; i <= PT_RESULT; i ++) {
 		if (i == 14 && !FULL_REGS(regs))
 			i = 32;
+		if ( i == PT_SOFTE) {
+			if(__put_user((unsigned int)softe, &frame->mc_gregs[i]))
+				return -EFAULT;
+			else
+				continue;
+		}
 		if (__put_user((unsigned int)gregs[i], &frame->mc_gregs[i]))
 			return -EFAULT;
 	}
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index c83c115858c1..797029edbcb4 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -110,6 +110,8 @@ static long setup_sigcontext(struct sigcontext __user *sc,
 	struct pt_regs *regs = tsk->thread.regs;
 	unsigned long msr = regs->msr;
 	long err = 0;
+	/* Force usr to alway see softe as 1 (interrupts enabled) */
+	unsigned long softe = 0x1;
 
 	BUG_ON(tsk != current);
 
@@ -169,6 +171,7 @@ static long setup_sigcontext(struct sigcontext __user *sc,
 	WARN_ON(!FULL_REGS(regs));
 	err |= __copy_to_user(&sc->gp_regs, regs, GP_REGS_SIZE);
 	err |= __put_user(msr, &sc->gp_regs[PT_MSR]);
+	err |= __put_user(softe, &sc->gp_regs[PT_SOFTE]);
 	err |= __put_user(signr, &sc->signal);
 	err |= __put_user(handler, &sc->handler);
 	if (set != NULL)
-- 
2.7.4
