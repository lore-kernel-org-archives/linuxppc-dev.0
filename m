Return-Path: <SRS0=G0Pv=6Q=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7B6C3A5A9
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 May 2020 14:37:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64B5820661
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 May 2020 14:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="DZHh+Ifs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B5820661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49DsCR2mxkzDqc1
	for <linuxppc-dev@archiver.kernel.org>; Sun,  3 May 2020 00:37:23 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49Ds6W3vBFzDrPt
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 May 2020 00:33:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=DZHh+Ifs; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 49Ds6V2pzzz9sSk; Sun,  3 May 2020 00:33:06 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 49Ds6T5R6Kz9sSs; Sun,  3 May 2020 00:33:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1588429985;
 bh=D15b49rD4JjZQMSzFbgIR5o64j044GWJvwJszGrv3XU=;
 h=From:To:Cc:Subject:Date:From;
 b=DZHh+Ifs6k2Yx7LXWYiMXTW6usTE6PJNy4QFTAU16FkuBahiHIAGht1x1FZHeNZl3
 SAbT9S7g0Bsk4K+BHRmxWpRHzpMe5kf0lizyJE/kCqDgB3oQGYbx1mDus8JQK3iIpG
 GaHwnbeYS/ILod2IN5vlolwRq91A6q5XONS5ZtoWNHUOiJ0gYhP1FeWetLGTyButp8
 LTOA2XfrqPN1n4uiLCfqoXtndRHTP9vNJHoOhxxdmiszfBXTTdM4S3aBy7WsvRuXPf
 x5vbPPrgyUUI8PG8S6X0Lv+p+uuvEfEB6XyoTTI5mnFSFyYXNf7+jbWA4l4B2E73Tg
 d4wNTHxeRZ0Tg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/64s: Fix unrecoverable SLB crashes due to preemption
 check
Date: Sun,  3 May 2020 00:33:16 +1000
Message-Id: <20200502143316.929341-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: hughd@google.com, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hugh reported that his trusty G5 crashed after a few hours under load
with an "Unrecoverable exception 380".

The crash is in interrupt_return() where we check lazy_irq_pending(),
which calls get_paca() and with CONFIG_DEBUG_PREEMPT=y that goes to
check_preemption_disabled() via debug_smp_processor_id().

As Nick explained on the list:

  Problem is MSR[RI] is cleared here, ready to do the last few things
  for interrupt return where we're not allowed to take any other
  interrupts.

  SLB interrupts can happen just about anywhere aside from kernel
  text, global variables, and stack. When that hits, it appears to be
  unrecoverable due to RI=0.

The problematic access is in preempt_count() which is:

	return READ_ONCE(current_thread_info()->preempt_count);

Because of THREAD_INFO_IN_TASK, current_thread_info() just points to
current, so the access is to somewhere in kernel memory, but not on
the stack or in .data, which means it can cause an SLB miss. If we
take an SLB miss with RI=0 it is fatal.

The easiest solution is to add a version of lazy_irq_pending() that
doesn't do the preemption check and call it from the interrupt return
path.

Fixes: 68b34588e202 ("powerpc/64/sycall: Implement syscall entry/exit logic in C")
Reported-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/hw_irq.h | 20 +++++++++++++++++++-
 arch/powerpc/kernel/syscall_64.c  |  6 +++---
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index e0e71777961f..3a0db7b0b46e 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -250,9 +250,27 @@ static inline bool arch_irqs_disabled(void)
 	}								\
 } while(0)
 
+static inline bool __lazy_irq_pending(u8 irq_happened)
+{
+	return !!(irq_happened & ~PACA_IRQ_HARD_DIS);
+}
+
+/*
+ * Check if a lazy IRQ is pending. Should be called with IRQs hard disabled.
+ */
 static inline bool lazy_irq_pending(void)
 {
-	return !!(get_paca()->irq_happened & ~PACA_IRQ_HARD_DIS);
+	return __lazy_irq_pending(get_paca()->irq_happened);
+}
+
+/*
+ * Check if a lazy IRQ is pending, with no debugging checks.
+ * Should be called with IRQs hard disabled.
+ * For use in RI disabled code or other constrained situations.
+ */
+static inline bool lazy_irq_pending_nocheck(void)
+{
+	return __lazy_irq_pending(local_paca->irq_happened);
 }
 
 /*
diff --git a/arch/powerpc/kernel/syscall_64.c b/arch/powerpc/kernel/syscall_64.c
index c74295a7765b..1fe94dd9de32 100644
--- a/arch/powerpc/kernel/syscall_64.c
+++ b/arch/powerpc/kernel/syscall_64.c
@@ -189,7 +189,7 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
 
 	/* This pattern matches prep_irq_for_idle */
 	__hard_EE_RI_disable();
-	if (unlikely(lazy_irq_pending())) {
+	if (unlikely(lazy_irq_pending_nocheck())) {
 		__hard_RI_enable();
 		trace_hardirqs_off();
 		local_paca->irq_happened |= PACA_IRQ_HARD_DIS;
@@ -264,7 +264,7 @@ notrace unsigned long interrupt_exit_user_prepare(struct pt_regs *regs, unsigned
 
 	trace_hardirqs_on();
 	__hard_EE_RI_disable();
-	if (unlikely(lazy_irq_pending())) {
+	if (unlikely(lazy_irq_pending_nocheck())) {
 		__hard_RI_enable();
 		trace_hardirqs_off();
 		local_paca->irq_happened |= PACA_IRQ_HARD_DIS;
@@ -334,7 +334,7 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs, unsign
 
 		trace_hardirqs_on();
 		__hard_EE_RI_disable();
-		if (unlikely(lazy_irq_pending())) {
+		if (unlikely(lazy_irq_pending_nocheck())) {
 			__hard_RI_enable();
 			irq_soft_mask_set(IRQS_ALL_DISABLED);
 			trace_hardirqs_off();
-- 
2.25.1

