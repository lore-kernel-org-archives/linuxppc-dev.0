Return-Path: <linuxppc-dev+bounces-28822-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5649ACA5FE3
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Oct 2026 09:45:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxgkB66yCz2y1W;
	Sat, 03 Oct 2026 19:45:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:36::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791020722;
	cv=none; b=iaDz7nZYdFUbdix7OHnyr1GaN9SVwIgGNFGdnfZsPvagIk6sFBWSeXQk6aLVVgsIyPzx/AxqOHCl6lOv61f11s7LLhp9jnFNMjLZjpJGGUXdECFYy+Y6Bd5Z9HjnLqKp6EIQ8LYzmtZSNfNlvkxiKwLD75oiuwlx9NHlvw3ITM5da+GBP5htzSunbLMZJ+bkdMC87/puTxaNRdWTsWsZ1Z+Q1RXQYLlGm2tL2cJZ1tHDqdHsakAAgcDIO2v5iIXI/x7m16xiDZiJC8+hjfAzDZFnHZat16QFCTqc83hQej3iDJStv5rKC2tRoJiX8tmgCI5k+PypVf8oa3NaB+NaDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791020722; c=relaxed/relaxed;
	bh=k6wW0Un3ym1Iv5CZgyMVb1WOGO/BQAZRmqh+pgtAtyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R4dH6Miyw61/NcT59NbNZLp2J0mt6Q90kOFo6GnbNU1jj6y4IB3ZhO7Hi382i3J7cNKfx+1g5lnWoP0xTK841qHxFOGkx2oZj+c8t5TlwCYKJYQnjTWd/JnHhWCqXTc6L9SiicIqaiahJpidZ7mNPnSH+OOnYdeKBSz1+8cFiuoZMSaiUn5TweF3PBTYQCds8W4zlHENI0JNbd1Otk+hg4LJ3eCQN0Jy9NIJMZeamLfS/+485ugIhI+AeNSrDC+yDrp05HLcmrKpVMXsD3Bx8vNFtjUHCVs5NNw/MoGaFlIidhVncqZUBV4r/eSQ0zKQ/sOHrrF1WydqC8pjtz8rtQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MsZjfsnz; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:36::f; helo=mail-dy2-x0f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MsZjfsnz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:36::f; helo=mail-dy2-x0f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-x0f.google.com (mail-dy2-x0f.google.com [IPv6:2607:f8b0:4864:36::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxgk96WhRz2xr2
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 19:45:21 +1000 (AEST)
Received: by mail-dy2-x0f.google.com with SMTP id 5a478bee46e88-3511e727e66so1216eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 02:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791020720; x=1791625520; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=k6wW0Un3ym1Iv5CZgyMVb1WOGO/BQAZRmqh+pgtAtyU=;
        b=MsZjfsnzpkBUqAgdG/lkYlVsdJ8utl6aOBr3htXYmDklZUrhjMedncQ+es/FaFEF9w
         cBjNkOh0xvRO/R8tE8ZO45ix7v9MeVZkzEbzNBGxGUinl66fVH+acKLuK+B5d5SitOew
         2cRv53/ZFSGyELgSipqk+IqEkYI0yaIndZUzjRSeRc9k4xEwbdSbZOrjJfaYN/vIx1ME
         Rz4HyOnVEjBRLauSbzlw3NaOtq25dkq6zr1h5xQE6x9TIAmvMiWGrFdDCJ2vckFfLQMQ
         1YRtPH8oJcWQVqkWlU4fG8oRbaRUbkH2GOIeLKksPEswMJYxM/AhhM6od2d8G8l/wdea
         ys1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791020720; x=1791625520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k6wW0Un3ym1Iv5CZgyMVb1WOGO/BQAZRmqh+pgtAtyU=;
        b=XQ62oAQ/9yoyc2r8JlGVHl+6e6WXnHDURhZTuHXXQfnLH5+qpkEo18h6ntOrwDU7KO
         g0vduGilNG4RSlXw0mveErSFMwi3fxS0vfWA5XjGFY2OqBtwcaQHe7HMvhBLlJdC4r5N
         CbiYmc+aWpCQVI6niLr4akUTZ8ubiQZ2UGxuWLev4RWMl91sf1TH5yH/D1DT5SRe858u
         CtYIZh2e3CSbs5ZxjSpO5h5WsTKDv+g3SkrG5jehnoJFykrTek1chin7ysWjPbOlj2Na
         EcuxIs9JZAE18Lcs0Za6Op1EhAt3lI8hzelZH/06+BdTvCfJzuYwaC3ofbyWsjy5A/ua
         lUVQ==
X-Forwarded-Encrypted: i=1; AKwUvByuCYMe+tMd+SNiQmtJoiYzBFAztXkruNRtRb08Y5x83TBphgTQbPDNN3iUf6qrpFSB1vI40W6EpSkd6Ws=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJRzJkltXH+UE7rwu/IfeXMPoGa0LRg97nRPLnsz4wRKl3dqfa8
	xO58dnhl8PblyyQ9YUBqtFKrOKriGcTVGG55lv+3u7bJSLRkqpij01Ui
X-Gm-Gg: AYBFou1sjViF+kFm+0kPb2MI+mvBqrUB3xwr2A/NspkXUKgdoTLkfYMRFI4QYE9Ovej
	+ayIIJXeNHWXQJEFN93+4TkEMOinh7uAoQFCtVBGQuwVB+ALhOxHLGu7sDVm3lI3rvxh+wMwlpG
	LfKhZ7hlWtXUBRjyhM43W3690eORCVEypIA4OxUKC8jJWHyS2wNATXXDKymXgJhNdtlnbNe+V8o
	E+kozbkaaSatxruJDycuqmt/CzyGuyYSQa7cr4rDhfAf2+WawuO5gsxQKRMuMaAx2yxpnD/6cF1
	Y1g3NlU/CQBg233emceXPGpqdHfS71s7lh0EiA1MQPzDRkdX9rU5AsKxNqfW3EpU3QgZ+j3q3ed
	aGVoGrD09gYkf2xuwaLgc83ju9FL2fxpKu/qdAn+7cS3rhq//Iv1+nWP7XCuFm3vUTyHzlY0TYV
	qE0pu3vZfQGhS8WoYXpaDTe5TzSWpqMZYGHzMP6Hr103n9wxa29Xoy/tJrKNvMeOnGQ7W3kW8+8
	2shl+ywVKFYqx8BDam7ZItCAogaWvTYHaHDTcXByjyrIvkRiQ==
X-Received: by 2002:a05:7301:782:b0:351:1e72:735d with SMTP id 5a478bee46e88-3511e7277b6mr17179eec.19.1791020719529;
        Sat, 03 Oct 2026 02:45:19 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.165.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34ef98d925csm14055363eec.0.2026.10.03.02.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 02:45:19 -0700 (PDT)
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
Subject: [PATCH V2] powerpc: fix NMI exit ordering: restore soft masks after irqentry_nmi_exit()
Date: Sat,  3 Oct 2026 15:15:09 +0530
Message-ID: <20261003094509.3408190-1-mkchauras@gmail.com>
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

Root cause:
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

Fix:
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

Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
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


