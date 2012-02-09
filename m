Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id ED6FDB6EE7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Feb 2012 16:34:21 +1100 (EST)
Message-ID: <1328765653.2903.59.camel@pasglop>
Subject: [PATCH] powerpc: Fix WARN_ON in decrementer_check_overflow
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 09 Feb 2012 16:34:13 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Hugh Dickins <hughd@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We use __get_cpu_var() which triggers a false positive warning
in smp_processor_id() thinking interrupts are enabled (at this
point, they are soft-enabled but hard-disabled).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

I was initially planning to fix that with a more in-depth rework
of how we do lazy irq disabling on powerpc, but that patch is
becoming too complex for this release so I'll apply this as a
stop-gap and leave the full rework for -next
 
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 701d4ac..01e2877 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -118,10 +118,14 @@ static inline notrace void set_soft_enabled(unsigned long enable)
 static inline notrace void decrementer_check_overflow(void)
 {
 	u64 now = get_tb_or_rtc();
-	u64 *next_tb = &__get_cpu_var(decrementers_next_tb);
+	u64 *next_tb;
+
+	preempt_disable();
+	next_tb = &__get_cpu_var(decrementers_next_tb);
 
 	if (now >= *next_tb)
 		set_dec(1);
+	preempt_enable();
 }
 
 notrace void arch_local_irq_restore(unsigned long en)
