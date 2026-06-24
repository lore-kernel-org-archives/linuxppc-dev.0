Return-Path: <linuxppc-dev+bounces-22963-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7112ECDB479
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jun 2026 17:15:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glpVK3swyz2yVd;
	Thu, 25 Jun 2026 03:15:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::535"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782321337;
	cv=none; b=PaKl/m1/P5NQGki0RWAhtICRnfz9BAilj+QDgSDPJul7jhaNFmhW4lBY8BTUZigT2z4xF0UKKGdG281dRAXvKh65bwGitUqahsBKb/uNhTvlsaY+7VqFIEM7DqZeESd9piAzvrA+y1x2o6pvXSxBghe8waUwU/oMHG+gXu68XAu8IVHeNogJcW4WzWVHBVxzxzgysXskHQ/XetRhht0fseUWirs6x7DxLzstCqVFU0Y6jJVj98ph55Lfp+ed1pm/CSCq53Fhq1hvkmSN7jgnSp6qzKjdxgB/36rk4fUbtmMzhai9CIyFaCi8OROcgKMKDhMU1cQa8AmsU/j//oHC7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782321337; c=relaxed/relaxed;
	bh=U/G1JgxwMKv+niNn6F5i+1VXQFhS2/7uV7yXwnMuPUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OZAk+96jjUU8rKGybYrVtdJuTAcla+EhhR0AViA2syy+7dzjzX0jDN121qyVYMyNMMLkasKNXXubXWix3vHjoT5jXP8beuOLQvGPBdtZHFn0yTA/O/0u99YP/ssGSfC078oeVf7MeOJBBhEY3JlwxXuTMeXK1C3K1PmEm/4KEBuIzYu0A1TXUhs/L2x48xhUlhpkXgdKVO5eC7j/ZOy5qDKpSChhRCtD/HY5JgHDennvHiKR7mRQYrJMpMTvFCeko0E7j7GbyPnnefuGOk/ACxB3X5JBBU9B6epWSzqmGXLCYpQPoa3V7Mbwl+K6+3ze5zAiumey0hrW48VbRxaKWA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GWbCY7/+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GWbCY7/+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4glpVH4Dtwz2xnK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2026 03:15:34 +1000 (AEST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-c8894560c89so423343a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2026 10:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782321331; x=1782926131; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U/G1JgxwMKv+niNn6F5i+1VXQFhS2/7uV7yXwnMuPUA=;
        b=GWbCY7/+9mH8sMvTv7RAFnqdDulMAuUY/q0a2MKsWn4Lgn3lvyqJkSRwmwqhmYNd5M
         rxsWdmR3/f2x/16wAVRiaStq+S7+xUHioDQUlx1Hry2/2HvIKXbxhuKIDdJ21iRUjgot
         FwAAMaHX3ZfOg8nW2I5F1fQ1WAyJ/7wkhA+JZk715mFSW7RXigm1Q+lhgnCrIeQmzgBt
         lM3o2w0P/aRSB8gLv5DSuYkOOCzfzJpLrX3TfvTmatqORtR0xM2pFk5OYy2vaMUPcGuh
         AwkP0gwx2BDvW1eb5OUC77oaeKw3QXbxSCOlE5bHC4moxI4bDIR74FtTrOB4za64KDGO
         4LDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782321331; x=1782926131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/G1JgxwMKv+niNn6F5i+1VXQFhS2/7uV7yXwnMuPUA=;
        b=rI+B2ylp6Dmal0Xu/rKn+/kM+PA0+OuU0Kh5cMDEdplsJPPtjLYwJbD0yCb8w6oUz7
         C7pYm4HoeqnXWzA0zEUwMQWRUQ0hYEsp9lbHbtls22g2W2Bm/4myu5uBoojzRIqFm/42
         aA3aimwVvfKR3SiFfNmK3NNU34JtIAvDlwj5jaB/7ylTBZNSddmO0CJcWwEuRJbzZcyK
         Q6kwBgk3sMMS6WRUd0hc4Uw5N2qTW/B9GWqVruYDtqC2+N940aPBJ3P06NP8BrlPsN2x
         UDQHNR5dM7+766EJXf0bJi5Zu/KILFKePDcfKNAO5ebUtXKGMiiuKAOxrtuU040KDU3D
         1icw==
X-Forwarded-Encrypted: i=1; AFNElJ+gus+obxFLoWZbord48l6Xv7Jm+zGqwGkCqPNp7sRQb/Qxc3zdZ8NRJGi9FyKjqfcM0npL+gmkwnH3A9M=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyFT5rtjPOYUOB2CR/h72sSyYXN9vZvYcZUZ0v/P6QS5kFmry85
	sEwSArybY1RdkllJA6YZKPjguZcpRgonGRp8kbIDTZVdB1cqlKDrIcsy
X-Gm-Gg: AfdE7cmXCq0GnOmDs+7gzfTfGa+UjgPtw1lwj1JHgcsacDgZJT4vnxyIWMiY/R/YtiE
	+BcJCevcebT8rCTCdQCZW/ExYVKzP3v7cqwmsHUTb+8crIYkKzq75YG9sCZdK1RpjahuKspjzjD
	NCfbt0XCqotMjL2RuTpwgYD08WfSl8+BRo8LgKisH/jx1Gl4Eleg2/JWPFmDyDkMh1plaWDk1dA
	VJ6GLAOInibxQwdjZVIIJe2fmg7HzmOdX3DV7dvOjGTOBOwKl/9EHQ4J7QcmXiPnrPh5FPIyykZ
	jt0np6pP2L+e1H0X10HnepxOX+tTSVnlrspDXK5Yd9gqODGAkGSKn9fSKa8qm2j5nuJ8hdOd9sO
	hdhwj2L98/bacZ1yCP7r7MePhqutVVEy4iGfTHijMEITziM+v8p9Ci17yO8uxYVimHtDOeQwaaz
	H4+05MY1xiNa4NAZVwtbv6lPju6x7FRF5h/0XS3RyrJEShjbnJOfpRJqc4fXSbkf/VgQ==
X-Received: by 2002:a05:6a20:ce4b:b0:398:840d:39aa with SMTP id adf61e73a8af0-3bd2d23dad1mr5089082637.29.1782321331219;
        Wed, 24 Jun 2026 10:15:31 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c92bcc90af5sm186497a12.28.2026.06.24.10.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 10:15:30 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	sshegde@linux.ibm.com,
	mkchauras@linux.ibm.com,
	kees@kernel.org,
	mark.rutland@arm.com,
	mkchauras@gmail.com,
	ryan.roberts@arm.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>
Subject: [PATCH] powerpc/syscall: Fix seccomp errno handling with GENERIC_ENTRY
Date: Wed, 24 Jun 2026 22:45:20 +0530
Message-ID: <20260624171520.772408-1-mkchauras@gmail.com>
X-Mailer: git-send-email 2.54.0
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After enabling GENERIC_ENTRY on PowerPC, seccomp filters using
SCMP_ACT_ERRNO without an explicit errnoRet value return ENOSYS
(Function not implemented) instead of the expected EPERM (Operation
not permitted).

The issue occurs in system_call_exception() when syscall_enter_from_user_mode()
returns -1 to indicate the syscall should be skipped (e.g., blocked by seccomp).
The current code treats this -1 as a syscall number and compares it against
NR_syscalls. Since -1 (when cast to unsigned long) is greater than NR_syscalls,
the code incorrectly returns -ENOSYS, overwriting the errno that seccomp
already set via syscall_set_return_value().

The generic entry code in syscall_trace_enter() calls __secure_computing(),
which sets the appropriate errno in regs->gpr[3] and returns -1 to signal
that the syscall should be skipped. However, the PowerPC syscall handler
was not checking for this -1 return value before validating the syscall
number.

Fix this by explicitly checking if syscall_enter_from_user_mode() returns
-1 and returning the value already set in regs->gpr[3] (the errno from
seccomp) before performing the syscall number validation.

This aligns PowerPC's behavior with other architectures using GENERIC_ENTRY
and restores correct seccomp errno handling.

Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
Reported-by: Michal Suchánek <msuchanek@suse.de>
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 arch/powerpc/kernel/syscall.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
index a9da2af6efa8..5b58c8d396c8 100644
--- a/arch/powerpc/kernel/syscall.c
+++ b/arch/powerpc/kernel/syscall.c
@@ -22,6 +22,10 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
 	add_random_kstack_offset();
 	r0 = syscall_enter_from_user_mode(regs, r0);
 
+	/* Seccomp or ptrace may have set return value, skip syscall */
+	if (unlikely(r0 == -1L))
+		return regs->gpr[3];
+
 	if (unlikely(r0 >= NR_syscalls)) {
 		if (unlikely(trap_is_unsupported_scv(regs))) {
 			/* Unsupported scv vector */
-- 
2.54.0


