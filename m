Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wk8zx1hNKzDqNZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 01:51:41 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id f27so5592880pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Jun 2017 08:51:41 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH 04/14] powerpc/64s: idle process interrupts from system reset
 wakeup
Date: Fri,  9 Jun 2017 01:51:03 +1000
Message-Id: <20170608155113.21300-5-npiggin@gmail.com>
In-Reply-To: <20170608155113.21300-1-npiggin@gmail.com>
References: <20170608155113.21300-1-npiggin@gmail.com>
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
 arch/powerpc/kernel/exceptions-64s.S  | 28 ++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/idle.c | 12 ++++++++----
 3 files changed, 37 insertions(+), 4 deletions(-)

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
index 2f700a15bfa3..3d75641c2566 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1646,3 +1646,31 @@ FTR_SECTION_ELSE
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
+	ori	r12,r12,MSR_EE
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
+	mtmsrd	r12,1
+	blr
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 78b4755b7947..7c83a95f929e 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -272,8 +272,10 @@ static unsigned long __power7_idle_type(unsigned long type)
 
 void power7_idle_type(unsigned long type)
 {
-	__power7_idle_type(type);
-	__hard_irq_enable();
+	unsigned long srr1;
+
+	srr1 = __power7_idle_type(type);
+	__replay_wakeup_interrupt(srr1);
 }
 
 void power7_idle(void)
@@ -310,8 +312,10 @@ static unsigned long __power9_idle_type(unsigned long stop_psscr_val,
 void power9_idle_type(unsigned long stop_psscr_val,
 				      unsigned long stop_psscr_mask)
 {
-	__power9_idle_type(stop_psscr_val, stop_psscr_mask);
-	__hard_irq_enable();
+	unsigned long srr1;
+
+	srr1 = __power9_idle_type(stop_psscr_val, stop_psscr_mask);
+	__replay_wakeup_interrupt(srr1);
 }
 
 /*
-- 
2.11.0
