Return-Path: <linuxppc-dev+bounces-28448-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571CBCA5FA1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 07:16:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hv8bz5CLXz2yft;
	Tue, 29 Sep 2026 17:16:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:38::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790666175;
	cv=none; b=Vbk7fbh5yBeB/4ZShBfNm/J77ScOY2uOE9w9RRhIuxVPTme3fzu36ZyPxGuuocyhga0S/VFKdkzDvT7/HZfJ/peElUqAkZWJxD2kGaSoqhIk3tddsd37+DHc7cSX9ksQ/kWAwuRImqLUEXSw6zKRWIO/hRzG2SyC7TCCway6CNAUUxBMyHykGoid7xwdYvgkjKlsHljTfKFU54ZNIqX5b+aZU9k4OnKqHyJrBHgaiGJDipVWzivPJsRZsd2xfhMgghTCi/4TQq21J750/vc5yMjkLOVdg8hxUjMCzIcn0rEocqCgttlVLCBpGO//KsTdhJPgA1t3Kx7i0nYnHGzFaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790666175; c=relaxed/relaxed;
	bh=tV37dXjm0XTJJYPlLCuDvkniyGjzFz1oUiZO7WcjuN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dvznu5L6qvIL4oG/X3SkkuQObnL/00I4XOnHT1lVCRZRWw5q3ecxLf+phFI8AVV+yD5lCcobOEa6Oxo0ZndGMvWDg182uUnrshvUM5Yu8Ciuu1DQIUC1Nf3Ck+Ykvwby4MFKjjzeMvcfVrrzVIiq1c5VKv6l6EC0s3FhKCZfSmjRMd71bliSUo5NlEkIOYcvAcMkotK4Z+s22tzsvD+z4CqKU3+BbeBVvzyvhKmF7GGbroknyiQaivuxDYFWmjjsGOe/Kf34WheqPKKg+RfZgr9/CECPdjMr6uKKm1Dr2wRNvmARFMcNTMUdgmk/W9cK9NkfNia9rkqscrlmm2Eg1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UR+uuPnt; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:38::f; helo=mail-dl2-x0f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UR+uuPnt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:38::f; helo=mail-dl2-x0f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl2-x0f.google.com (mail-dl2-x0f.google.com [IPv6:2607:f8b0:4864:38::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hv8bx5rPyz2yDD
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 17:16:13 +1000 (AEST)
Received: by mail-dl2-x0f.google.com with SMTP id a92af1059eb24-142dd046b87so2769959c88.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 00:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790666170; x=1791270970; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tV37dXjm0XTJJYPlLCuDvkniyGjzFz1oUiZO7WcjuN4=;
        b=UR+uuPnt+3mCX9d5DkIu05/zyBMtbUfBxaGP6C95LAUiOmk6ChAngGvxuPEjUpKd81
         pj9xTPg3Z5HQ8+5ibGD1gL6ItpjFFOk+DYPbZ8ueAFZjcruc5nwe98xPsvHqqPO56DGv
         cNCAWEDRLVsUeIFcIs0HanRAyaLaid5S0hGnSHXlHY99ymIhlipOYN1fXozUCKw7/8B+
         GyKPHqxJNjrhSNcEvU5uiyPzBIQjil8dfSIlEuuKJM7R9jVXf8weTt+U9amo0kY4HMAJ
         P2RIUVBr5klvXl6o6QGVHZ2Rc0VYUIbWroZ75wvrxyX2qH+5m5kDiWqzUhRUw/ki8Mb+
         wjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790666170; x=1791270970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tV37dXjm0XTJJYPlLCuDvkniyGjzFz1oUiZO7WcjuN4=;
        b=s3Iq4/Aqu/zKlIDllHMM45ZbKYoFnQW1s6LickPIcnb7jP1EosqFyPx9soFiBD29GI
         aL5QktmoDWjVUEw/6yTdvrQHAR2+moqWahcNSbeCVs5kdMST0WMvH021U0rEQj6k7ifb
         VkVBicu3e6/9xFRYCpGYE64F0otrMK3VpvrU4WNyfU6PSB7riVG8i9n4vY2OBk5cwLpD
         t0k7Baxr7hzPzmErTUWtmV7wnGDcRQXgAOZjli7lECQw7GvQXy5hmNmzaPeGJEI0lXF7
         El1DVgfVJUeKLoshe/ajtwQvB7geWoJy2aJ4S7j8EtHJXEj0xrVSMtzZojYszJu/cJ/6
         LlRA==
X-Forwarded-Encrypted: i=1; AKwUvBxp3Gfl4aVLBE5mGfFSm0KDu5ME2BKcvnyoekGgPCHW+68XkVyYjW5KBY0KZX31iYzIER+XzEP/KIAMMq8=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nNQ50dwwZiRII/SXXFF6CQ9Fqrq6uaqUrySjbXDjcashAF7KGU
	UVClNDtRI7Gs7kW9Dj/ojQiV+LqteVoBWVgAxOIF4HR23TN7r7mAKv2o
X-Gm-Gg: AYBFou162dVDQafOxAC2Yv+TTKDAdRSZyd4cXx7hV0CjUjUwVtfMWFZJaz6EtDoY+v9
	m8CVcQqf3r8MJ/cjTcOrNRoBM6awwjeUVOrJIegSB1xRte0hs7G993d60wVuBsrHQRH5Y//POvi
	RVxiGqpSZb/rOu1IbiF8iLKcD7hM6FIqY7kdy5278Xud4Nc+QnFAIQVGPEHWD9C9LdM8q0ymgLX
	UK6xGYK8FAuX99mNC1EyOxTCUfJLH0IMhRZUkHDPK6DMZ6jJA2AEnVxDpymou9lCZ2BANg563/F
	KmYLgxZs0KQjgFXIgA37tKJXY5ee2awPb9eJ//EL7qq0kjMvcDciusS/pOhkvtdlY82N2gC3KD3
	JSpG8UokvDHyaah6sbY09yqpu7+/mxVCpSRMiFGA+VO40+iPTQzLHdVx74tAJd5r4Fxm5NqTz5F
	Ro7C9QpbgLRkdqhOfShYP9cuJqFfvt7ybfFNqn9lIwkZf0CICvWeSiiHo1PCtVyk1QBwN9oJpwA
	AaQ0uwFUmNVI3KC804NCfWUnJkwIxL5UkfNnWf2ejTnMkNMrr4tRvgHhCJo
X-Received: by 2002:a05:701b:2511:b0:14a:c6cf:1449 with SMTP id a92af1059eb24-14ac6cf14e6mr3420039c88.32.1790666169513;
        Tue, 29 Sep 2026 00:16:09 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.165.23])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-147913a776fsm27867713c88.17.2026.09.29.00.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 00:16:09 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	mkchauras@linux.ibm.com,
	mkchauras@gmail.com,
	ruanjinjie@huawei.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH] powerpc: fix NMI exit ordering: restore soft masks after irqentry_nmi_exit()
Date: Tue, 29 Sep 2026 12:46:00 +0530
Message-ID: <20260929071600.2963954-1-mkchauras@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running with CONFIG_PPC_IRQ_SOFT_MASK_DEBUG=y and LOCKDEP=y, an
Oops is triggered during NMI exit:

  [  202.258332] Oops: Exception in kernel mode, sig: 4 [#1]
  NIP [000000000003e178] 0x3e178
  LR  [c00000000003e174] arch_local_irq_restore+0x2a4/0x328
  TRAP: 0700  MSR: 0000000000081000 <ME>

The faulting instruction at NIP is a 'trap' (0fe00000) inside the
rfi_flush_fallback trampoline at a userspace-looking low address, reached
after a bad rfid caused by an incorrect SRR0 value.

Root cause
----------
DEFINE_INTERRUPT_HANDLER_NMI used to call arch_interrupt_nmi_exit_prepare()
*before* irqentry_nmi_exit(), giving this sequence:

  arch_interrupt_nmi_enter_prepare()   // saves irq_soft_mask, irq_happened
  irqentry_nmi_enter()                 // __nmi_enter() -> nmi_count++, in_nmi()=true
  ____func(regs)                       // NMI handler body
  arch_interrupt_nmi_exit_prepare()    // RESTORES irq_soft_mask=0 (IRQS_ENABLED)
                                       // RESTORES irq_happened with pending bits
  irqentry_nmi_exit()                  // instrumentation block runs here...
    trace_hardirqs_on_prepare()        //   ...with in_nmi()==true still
    lockdep_hardirqs_on_prepare()      //   ...and irq_soft_mask already restored to 0
      -> arch_local_irq_restore(0)     // mask=0 -> enable path entered
           WARN_ON_ONCE(in_nmi())      // FIRES: __nmi_exit() hasn't run yet
    __nmi_exit()                       // nmi_count-- (too late)

arch_interrupt_nmi_exit_prepare() restores irq_soft_mask to whatever
the interrupted thread had (IRQS_ENABLED / 0) and restores irq_happened
with any pending deferred-interrupt bits that were present when the NMI
fired.  This is correct and necessary before rfid back to the interrupted
context, but it must not happen until irqentry_nmi_exit() has fully
completed.

With irq_soft_mask=0 and pending bits in irq_happened, the
trace_hardirqs_on_prepare() call inside irqentry_nmi_exit()'s
instrumentation block reaches lockdep_hardirqs_on_prepare() which
calls __trace_hardirqs_on_caller(), which eventually calls
arch_local_irq_restore(0) (the IRQS_ENABLED / enable path).

arch_local_irq_restore() with mask=0 hits the CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
guards at irq_64.c:217:

  WARN_ON_ONCE(in_nmi());   // TRUE: __nmi_exit() not yet called

The WARN_ON_ONCE fires a 'trap' instruction (tw 31,0,0 / 0fe00000) in
kernel mode with MSR_PR=0, MSR_IR=0 (real-mode).  The program check
handler (TRAP 0700) takes the sig:4 (SIGILL) path via do_program_check()
and calls die(), producing the Oops.

The RESTART_TABLE mechanism in arch_local_irq_restore then causes the
bad rfid that lands at the userspace-looking address visible in the NIP.

The bug is invisible with LOCKDEP=n because trace_hardirqs_on_prepare()
is a no-op when CONFIG_TRACE_IRQFLAGS is not set (TRACE_IRQFLAGS is
selected by PROVE_LOCKING which selects LOCKDEP).

Fix
---
Move arch_interrupt_nmi_exit_prepare() to after the irqentry_nmi_exit()
block, so that:

  irqentry_nmi_exit()                 // __nmi_exit() -> nmi_count--, in_nmi()=false
  arch_interrupt_nmi_exit_prepare()   // now safe to restore soft mask state

The instrumentation inside irqentry_nmi_exit() now executes while
in_nmi() is still true (nmi_count not yet decremented), but
irq_soft_mask is still IRQS_ALL_DISABLED (NMI-entry value), so
arch_local_irq_restore() is never called with mask=0 from that path.
After __nmi_exit() returns, arch_interrupt_nmi_exit_prepare() restores
the pre-NMI soft mask and irq_happened, which is the correct state for
the rfid back to the interrupted context.

Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Closes: https://lore.kernel.org/all/d4cccba9-ce5c-424b-864c-2248fb0d99e6@linux.ibm.com/
Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 arch/powerpc/include/asm/interrupt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
index 1b45a49e9bed..56f855c6f07e 100644
--- a/arch/powerpc/include/asm/interrupt.h
+++ b/arch/powerpc/include/asm/interrupt.h
@@ -301,7 +301,6 @@ interrupt_handler long func(struct pt_regs *regs)			\
 		state = irqentry_nmi_enter(regs);			\
 	}								\
 	ret = ____##func (regs);					\
-	arch_interrupt_nmi_exit_prepare(regs, &nmi_state);		\
 	if (mfmsr() & MSR_DR) {						\
 		/* nmi_exit if relocations are on */			\
 		irqentry_nmi_exit(regs, state);				\
@@ -317,6 +316,7 @@ interrupt_handler long func(struct pt_regs *regs)			\
 	} else {							\
 		irqentry_nmi_exit(regs, state);				\
 	}								\
+	arch_interrupt_nmi_exit_prepare(regs, &nmi_state);		\
 									\
 	return ret;							\
 }									\
-- 
2.55.0


