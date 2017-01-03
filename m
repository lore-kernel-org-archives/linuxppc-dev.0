Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tt5Gj3LWwzDqDx
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jan 2017 18:31:25 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id g1so32724052pgn.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Jan 2017 23:31:25 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Balbir Singh <bsingharora@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC v2 3/3] Enable soft nmi handler
Date: Tue,  3 Jan 2017 18:30:58 +1100
Message-Id: <20170103073058.30066-4-bsingharora@gmail.com>
In-Reply-To: <20170103073058.30066-1-bsingharora@gmail.com>
References: <20170103073058.30066-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

a. On decrementer interrupt, instead of setting
   dec to maximum and returning, we do the following
  i. Call a function handle_nmi_dec, which in
     turn calls handle_soft_nmi
  ii. handle_soft_nmi sets the decrementer value
      to 1 second and checks if more than 30
      seconds have passed since starting it. If
      so it calls BUG_ON(1), we can do an NMI
      panic as well.

This patch relies on the previous patch to keep
interrupts enabled and held at the previous
priority (not EOI'd) when we disable interrupts.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Nicholas Piggin <npiggin@gmail.com>

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S |  8 ++++----
 arch/powerpc/kernel/time.c           | 25 +++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index cf64bc4..7c6bbe8a 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1310,10 +1310,9 @@ masked_##_H##interrupt:					\
 	stb	r11,PACAIRQHAPPENED(r13);		\
 	cmpwi	r10,PACA_IRQ_DEC;			\
 	bne	1f;					\
-	lis	r10,0x7fff;				\
-	ori	r10,r10,0xffff;				\
-	mtspr	SPRN_DEC,r10;				\
-	b	2f;					\
+	GET_SCRATCH0(r10);				\
+	std	r13,PACA_EXGEN+EX_R13(r13);		\
+	EXCEPTION_PROLOG_PSERIES_1(handle_nmi_dec, _H);	\
 1:	cmpwi	r10,PACA_IRQ_DBELL;			\
 	beq	2f;					\
 	cmpwi	r10,PACA_IRQ_HMI;			\
@@ -1337,6 +1336,7 @@ USE_FIXED_SECTION(virt_trampolines)
 	MASKED_INTERRUPT(H)
 
 EXC_COMMON(handle_irq_mask, 0x500, handle_masked_irq)
+EXC_COMMON(handle_nmi_dec, 0x900, handle_soft_nmi)
 
 #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
 TRAMP_REAL_BEGIN(kvmppc_skip_interrupt)
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 52f8f81..4dcf73a 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -118,6 +118,7 @@ struct clock_event_device decrementer_clockevent = {
 EXPORT_SYMBOL(decrementer_clockevent);
 
 DEFINE_PER_CPU(u64, decrementers_next_tb);
+DEFINE_PER_CPU(u64, nmi_started_tb);
 static DEFINE_PER_CPU(struct clock_event_device, decrementers);
 
 #define XSEC_PER_SEC (1024*1024)
@@ -520,6 +521,7 @@ static void __timer_interrupt(void)
 	u64 now;
 
 	trace_timer_interrupt_entry(regs);
+	__this_cpu_write(nmi_started_tb, 0);
 
 	if (test_irq_work_pending()) {
 		clear_irq_work_pending();
@@ -565,6 +567,7 @@ void timer_interrupt(struct pt_regs * regs)
 	 * some CPUs will continue to take decrementer exceptions.
 	 */
 	set_dec(decrementer_max);
+	__this_cpu_write(nmi_started_tb, 0);
 
 	/* Some implementations of hotplug will get timer interrupts while
 	 * offline, just ignore these and we also need to set
@@ -599,6 +602,28 @@ EXPORT_SYMBOL(timer_interrupt);
 
 
 /*
+ * If we have watchdog enabled, we do expect to hit this
+ * at-least once per sample_frequence.
+ * We set the decrement to 30 seconds and if we hit it
+ * again.. it's a BUG, it can be made a NMI panic as well.
+ */
+void handle_soft_nmi(struct pt_regs *regs)
+{
+	unsigned long long now = get_tb_or_rtc();
+	unsigned long long nmi_started_time = __this_cpu_read(nmi_started_tb);
+
+	if (!nmi_started_time) {
+		set_dec(ppc_tb_freq);
+		__this_cpu_write(nmi_started_tb, now);
+	} else {
+		if ((now - nmi_started_time) >= (30 * ppc_tb_freq)) {
+			BUG_ON(1);
+		} else
+			set_dec(ppc_tb_freq);
+	}
+}
+
+/*
  * Hypervisor decrementer interrupts shouldn't occur but are sometimes
  * left pending on exit from a KVM guest.  We don't need to do anything
  * to clear them, as they are edge-triggered.
-- 
2.9.3
