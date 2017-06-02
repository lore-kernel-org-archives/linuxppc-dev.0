Return-Path: <npiggin@gmail.com>
Received: from mail-it0-x244.google.com (mail-it0-x244.google.com
 [IPv6:2607:f8b0:4001:c0b::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wfGMc4KSBzDqLl
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 17:40:12 +1000 (AEST)
Received: by mail-it0-x244.google.com with SMTP id l145so8911264ita.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Jun 2017 00:40:12 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Anton Blanchard <anton@samba.org>
Subject: [PATCH 04/14] powerpc/64s: process interrupts from system reset wakeup
Date: Fri,  2 Jun 2017 17:39:36 +1000
Message-Id: <20170602073946.8983-5-npiggin@gmail.com>
In-Reply-To: <20170602073946.8983-1-npiggin@gmail.com>
References: <20170602073946.8983-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When the CPU wakes from low power state, it begins at the system reset
interrupt with the exception that caused the wakeup encoded in SRR1.

Today, powernv idle wakeup ignores the wakeup reason (except a special
case for HMI), and the regular interrupt corresponding to the
exception will fire after the idle wakeup exits.

Change this to replay the interrupt from the idle wakeup before
interrupts are hard-enabled.

Test on POWER8 of context_switch selftests benchmark with polling idle
disabled (e.g., always nap, giving cross-CPU IPIs) gives the following
results:

                                original         wakeup direct
Different threads, same core:   315k/s           264k/s
Different cores:                235k/s           242k/s

There is a slowdown for doorbell IPI (same core) case because system
reset wakeup does not clear the message and the doorbell interrupt
fires again needlessly.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/hw_irq.h     |  1 +
 arch/powerpc/kernel/exceptions-64s.S  | 27 +++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/idle.c |  6 ++++++
 3 files changed, 34 insertions(+)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index eba60416536e..0ef9a33c139f 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -32,6 +32,7 @@
 #ifndef __ASSEMBLY__
 
 extern void __replay_interrupt(unsigned int vector);
+extern void __replay_wakeup_interrupt(unsigned long srr1);
 
 extern void timer_interrupt(struct pt_regs *);
 extern void performance_monitor_exception(struct pt_regs *regs);
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 2f700a15bfa3..69fe20b2b0cd 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1646,3 +1646,30 @@ FTR_SECTION_ELSE
 	beq	doorbell_super_common
 ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
 	blr
+
+/*
+ * Similar to __replay_interrupt but called from cpu idle wakeup
+ * with SRR1 wake value in r3.
+ */
+_GLOBAL(__replay_wakeup_interrupt)
+	extrdi	r3,r3,42,4	/* Get SRR1 wake reason in low bits */
+	mfmsr	r12
+	mflr	r11
+	mfcr	r9
+	/* Don't set EE in MSR, we have hard disable set */
+	cmpwi	r3,0x6
+	beq	decrementer_common
+	cmpwi	r3,0x8
+	beq	hardware_interrupt_common
+BEGIN_FTR_SECTION
+	cmpwi	r3,0x3
+	beq	h_doorbell_common
+	cmpwi	r3,0x9
+	beq	h_virt_irq_common
+	cmpwi	r3,0xa
+	beq	hmi_exception_common
+FTR_SECTION_ELSE
+	cmpwi	r3,0x5
+	beq	doorbell_super_common
+ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
+	blr
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 5886657fd1b6..2ed79ab35d8d 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -289,6 +289,8 @@ unsigned long power7_idle_type(unsigned long type)
 
 	trace_hardirqs_off();
 
+	__replay_wakeup_interrupt(srr1);
+
 	return srr1;
 }
 
@@ -342,6 +344,8 @@ unsigned long power9_idle_type(unsigned long stop_psscr_val,
 
 	trace_hardirqs_off();
 
+	__replay_wakeup_interrupt(srr1);
+
 	return srr1;
 }
 
@@ -671,6 +675,8 @@ static int __init pnv_init_idle_states(void)
 
 	if (supported_cpuidle_states & OPAL_PM_NAP_ENABLED)
 		ppc_md.power_save = power7_idle;
+	else if (supported_cpuidle_states & OPAL_PM_STOP_INST_FAST)
+		ppc_md.power_save = power9_idle;
 
 out:
 	return 0;
-- 
2.11.0
