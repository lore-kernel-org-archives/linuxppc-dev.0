Return-Path: <linuxppc-dev+bounces-26200-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A65A0C61DD9
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Aug 2026 14:54:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hXwBy549Wz2xr2;
	Mon, 31 Aug 2026 00:54:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788101690;
	cv=none; b=DTKdEalyluO+mBthrnxGJY+hCDcmU9fHLy11AisDDsFd6Z7fF3TW45CByH8+ZsdF1fxoPcSvaiDBKRJrgLUTmuETti00Ox+H4y/+v7sUhjQpCYXMJ9Pave/K9spexFXUvXZRCW5WjDu7tcs+gU2EBSzSyAEwt5X2UcyH8sLlwSUzBJdfdKu5YEMmGjWR+CnRVoZVNdcqO9ZVdnDSvdN+DJRBrehcL8GgQb7zqFBcqqSx/e6Ey3wzzqmIgAg6URUdneVh0WjU08WYYkiluqLNgzCt5aNQOBV7L3lKtB7JUQ5AIOVKMsUW1gY9CNCY2p1QT+moC5IBlOS+u6r3Ng412g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788101690; c=relaxed/relaxed;
	bh=nztRj9sUX1IJjCQusGPxjK1E0oMLJnKvNUAHcjpeCgc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=boq6F5J43ZVp+IF4Qs4F2VFQFPzWTwzoJ9ezs09fj/7AiceWs/kObI/Z7ApF9yM0TkON+/HKReeGymHgpp98x1BxxaKnzLBluAAYXgcyRrkv2txQXwwhqq0+MgS7YLgwzrERkE2FPPhZPpuSzAstGVcFJ2IHbMaB8udng/qDewctVaCm1+NC2RgpA28kumtaAukfotdF+B+/JbItUVb8Z9PmfVhCLl0GqFiBiGlrY3e5k9HNSC5MhcEKEgLXn9vfREXWbuAA+pVO+YzfFKYLaOf6GJNGBLpm3cmyqpgQGNSMBzMKasIUDCwyd/pq0Be8ZvAmDLIW7Oq0Xn2k78wVTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ryvaEzMA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ryvaEzMA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hXwBx0Zh9z2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 00:54:47 +1000 (AEST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-38fdeaed181so3958199a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Aug 2026 07:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788101685; x=1788706485; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nztRj9sUX1IJjCQusGPxjK1E0oMLJnKvNUAHcjpeCgc=;
        b=ryvaEzMA5vsrjOSjPyGHEgNnFUSeA7SqXrsXv8uBx3R/Ylt5lQFlr75nVekyYfZtfg
         xNxnCRG02kTpgXnDtfjdpTRyNHoyngDoBKYPr1/pWLanFytpXvqDjNXFC7J9jedHNKtr
         11pC9N2AIX3b4iMIKDKLlPmFfjsyCii9xC5c0LWwWV5LkU1p/n4IzEWtac/JRKntR1Cb
         C4yRS6anFQraspOvQWMIuuy+nGn7mqHm015anlsGD4g7EhgyVY3uJwbSSHZ37ufuGCRC
         AhceedYh+VVGUaPKvJeNyy/yay9fT9Muove2tQ4I2sDfn9HJjIEn5n2BrigAZZVAQ/i0
         GATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788101685; x=1788706485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nztRj9sUX1IJjCQusGPxjK1E0oMLJnKvNUAHcjpeCgc=;
        b=nv0LMZ6H6jYFvfacJYphFiO6lu+XgCjLhXoEuc9MFJ/SsgLIWMOkbnQVdldNZNEUqf
         11oJ4UHcTY1ncdn4IcniivxReRqTkqSml5RV6X4Gdruh676UIHY6MY9qQfduE0UgNGl5
         568wj0jIlSEamipAr2fHnvFvDGAY9Ed7FFIblZYpOciZGF04zlplP7pDwumShNs+mCHR
         jP4VVnpOY03sNZY6OzfqDztOICIhN8LXkLuqfP7Ei6i/myw6IQmafTmulWajRdvNUc72
         3VsTw+avcyGSb34IqNP++vu8hk/WyqEtRs++C4kwhD2jnn6iHFGRhSXQN1yIdijFWIQ6
         sqxw==
X-Gm-Message-State: AFuF++kfTsx6L4/bJ+hrkIuDnWCrLMjYCqooIr/bYUBySJQBBmlxh0W5
	c1IZ14rb50H9o6E0iOSey+t8qYlDzTPAQsaEk+E5cec0vIKPKFcxB8SQRN7IuU9Z
X-Gm-Gg: AYBFou0GvEvR3dS5cARiKadCo/TmNo1pvINgHuQGC0UXDwV2q0I4VceuwD94AuX7vZs
	Mv7qtnCTCNgcUeQlifqmfc0biwqG1I1dIDpQMDWoR0etAcYRKaUt5PekFnAzZ4AHo0tPUiC3tK4
	AMpT8pBUk3fTr0KCzWpN94MPt/qEJtTIqwLLHMXybuDB414+HiB9JnXCVod4h0hA7jSrnyB/BcI
	lE98Ycggm4SO6BWQnGFlDt8zxdF0QFyUu+VIl0X2GuZUgrJR/A6OADscS5LK7vfmw+pz/OCoZdZ
	T7Mpmrm8e7lRNJP7eLK8hRDuAmTwLc/+1eCyexbWocsP5+au60HFExgblBr+W40jakSIcT5R2Ux
	ehlEFc2AsvAuZovv1LGUK/KX33uS8Ag/CLSaNNZd+tOcAooiFb4JRrcoFUQOTivyP42Etd63rSG
	6qxVpGYbksgnQtGYkKiJfg6oaIzu0ckUK3+yAWhagCrdRAzj81wzm+nNjrjb9b3lMSrGrwY4cOY
	iWlCU4wW0f5pzfq348YrmRmhXcz3zWHfzbaiPvAIUJhhhOHgW8=
X-Received: by 2002:a17:90a:dfc6:b0:38e:57a3:f218 with SMTP id 98e67ed59e1d1-396d0ef6470mr35605774a91.13.1788101685025;
        Sun, 30 Aug 2026 07:54:45 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0d38207sm21599847c88.5.2026.08.30.07.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 07:54:43 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH] powerpc: Do not restore KUAP in arch_exit_to_user_mode_prepare()
Date: Sun, 30 Aug 2026 20:24:30 +0530
Message-Id: <52fee44fd23acf8e1c024ace668728e626a783a8.1788101609.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
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

KUAP means kernel cannot touch user memory unless it explicitly is
enabled. In the kernel it should stay AMR_KUAP_BLOCKED. While returning
to userspace just before RFI, kernel should restore the user AMR value
back.

Looks like GENERIC_ENTRY might be treating arch_exit_to_user_mode_prepare()
as the last architecture step before returning to userspace.
commit bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
therefore called kuap_user_restore() from that hook. But on PowerPC that
is too early. After irqentry_exit() / syscall_exit_to_user_mode() we
still run platform specific exit routines.

e.g. code snippets showing both exception handling and system call
handling as the callers of function arch_exit_to_user_mode_prepare()
which does kuap_user_restore(). The below path shows that calling
kuap_user_restore() is too early when called from
arch_exit_to_user_mode_prepare().

Exception handling in exceptions-64s.S
=======================================

bl	CFUNC(do_page_fault)
	  ..DEFINE_INTERRUPT_HANDLER_ASYNC(do_page_fault)
	      arch_interrupt_async_enter_prepare(regs);
	      state = irqentry_enter(regs);
	      instrumentation_begin();
	      irq_enter_rcu();
	      handler(regs);
	      nap_adjust_return(regs);
	      irq_exit_rcu();
	      instrumentation_end();
	      arch_interrupt_async_exit_prepare(regs);
	      irqentry_exit(regs, state); 		   <<< too early
	        irqentry_exit_to_user_mode()
		  __exit_to_user_mode_prepare(regs, EXIT_TO_USER_MODE_WORK_IRQ);
		    arch_exit_to_user_mode_prepare(regs, ti_work);  <<< too early
b	interrupt_return_srr
		.. bl	CFUNC(interrupt_exit_user_prepare) <<< already calls kuap_user_restore

prep_irq_for_enabled_exit() retry can run kernel code with IRQs on. So
only when that routine is fully finished is when the user KUAP should be
fully restored which interrupt_exit_user_prepare() already takes care of
before returning.

Similarly for system call handling in interrupt_64.S
======================================================

	bl	CFUNC(system_call_exception)

.Lsyscall_exit:
	addi	r4,r1,STACK_INT_FRAME_REGS
	li	r5,0 /* !scv */
	bl	CFUNC(syscall_exit_prepare)
		  .. kuap_assert_locked();
		     syscall_exit_to_user_mode(regs); <<< too early
		       syscall_exit_to_user_mode_prepare(regs);  <<< too early
 		     kuap_user_restore(regs);         <<< already calls

syscall_exit_prepare(), which can enable IRQs, replay a pending
interrupt, and only then rfi. Those functions already restore KUAP
immediately before rfi.

Note that if we restore the user AMR too early like in the current code
as shown from the code snippets above, then we get the following warning
when CONFIG_PPC_KUAP_DEBUG is enabled:
  WARNING: arch/powerpc/include/asm/book3s/64/kup.h:293 at interrupt_exit_user_prepare+0x1a0/0x1c0
  Hardware name: IBM pSeries (emulated by qemu) POWER10 (architected)
  TRAP: 0700
  LR: c00000000000d8d4 CTR: c0000000021fe500
  MSR: <SF,EE,ME,IR,DR,RI,LE>  CR: 44000804  XER: 20040000
  interrupt_exit_user_prepare+0x1a0/0x1c0
  interrupt_return_srr_user+0x8/0x12c

Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
Fixes: 02565a782c1ee ("powerpc: Introduce syscall exit arch functions")
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/include/asm/entry-common.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
index c5adb5006361..94083516df57 100644
--- a/arch/powerpc/include/asm/entry-common.h
+++ b/arch/powerpc/include/asm/entry-common.h
@@ -515,8 +515,14 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	local_paca->tm_scratch = regs->msr;
 #endif
-	/* Restore user access locks last */
-	kuap_user_restore(regs);
+	/*
+	 * Do not restore KUAP here. Generic entry might treat this as the last
+	 * arch step before userspace but PowerPC still has kernel work after
+	 * irqentry_exit()/syscall_exit_to_user_mode() i.e. in
+	 * interrupt_exit_user_prepare() / syscall_exit_prepare() may enable
+	 * IRQs and retry. Those functions restore KUAP immediately before rfi,
+	 * which is where it should belong.
+	 */
 }

 #define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
--
2.39.5


