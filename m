Return-Path: <linuxppc-dev+bounces-23124-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24534C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 18:30:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gpvvq6dCsz2yH4;
	Tue, 30 Jun 2026 04:29:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1332"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782757799;
	cv=none; b=fJKtzxeGgbtT7kBqyDOiEflUniMDoKeCLN4TtkmjlT+mq8zzuphokxeooERCG11+g6/QH5WSt2EigZeenwm+GiklsHICiCJ3C02YR18QBeg3qFQ7oP188/2CAfhspi9qP8GIhxgvIviD/JS8qO9CZurxiSYe61yYXkGWBlf47btq3hNWLYgwnnW+LIxA7hUkTUKrqrAn40RNWh9WvBCDuAqWclANnXwZQ7/9pM5qGsZmdlosP4nhyKPyK6kIBhCtusSu86K3hU75omGsYyK9tr+qDfnb2R7epi1D9rNAHenaiaBw2Fmk2whV1PC18k8cgaoIYJ04IZhwCqcwRfJgfw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782757799; c=relaxed/relaxed;
	bh=vOXx8KjnXCH8WGWSSSkVZN9ds8kGcTXaH0+3DMwQEBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LsT0/nRONJcZufPp2FPR0xGW0LgnYOBzqLdvdfMSURF3TqYKc/fKDVcenGUR5F4yihooX33yXcTZQenIXh7PdRKLbIGruq5ww/ycEruKBK1CsFDesx9+2WvEURi4tifGoqd3GSb7lz17eaTIioWUJWIc1tCMFJdt0QCpxKwt1vDwgHsCbA0+wFPRdFgKPKbnl0Fc+ciq9HaTIquyTjCublIQfS/F3nlMpS6hVUaokrU/Nd22v8zv+Tf/k123ziMiyw8GfiSZiKYPQ47vqwsa4XrMSTqhvz7C2av+IUTw/mC7+nJY4pbwPFa2/+WppA3J4tf+neO2SXs31xMq4oGaBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AvpLPk/W; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AvpLPk/W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1332.google.com (mail-dy1-x1332.google.com [IPv6:2607:f8b0:4864:20::1332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpvvp2S4Kz2xd2
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 04:29:57 +1000 (AEST)
Received: by mail-dy1-x1332.google.com with SMTP id 5a478bee46e88-30c965eab27so6982946eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 11:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782757795; x=1783362595; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vOXx8KjnXCH8WGWSSSkVZN9ds8kGcTXaH0+3DMwQEBg=;
        b=AvpLPk/WmHD5SD8AzDtrr9Y5gjTrjGCW668tKXh3fBkkVAdDYyJn1Kz+Q96PuoxKgq
         w+UIvJ51lvr7VBdX4FhiVhF+ZN6wnaIYZpki5+MJmkaONyeivNZXeOSSlbtWKTv5TGnk
         SQJYqr0GDaCY5xDu8XsE+/P6vlVRCgV4vFw4Kj+j/4LCz9URs8Lpep0EVKY9/xSq4laN
         1vl/r2V5dJ9vWSU8rlZwIVTt3CgVJFy3PBbCwOXytd8uLe/XCl1J/LV+4X9R0FrM96MH
         IlpN3Z52FE0TVw3L+JWdLCeA7xNxru8aF8L6OKXjwJPKjMi4K4+y9ivd+sReyzd5marp
         nUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782757795; x=1783362595;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOXx8KjnXCH8WGWSSSkVZN9ds8kGcTXaH0+3DMwQEBg=;
        b=dHp9kxENvjgUORchPg4rg5ezA/Vpc8WWHiSMDY8AcPgF74uOfgz1mMmBmdhQRSYohN
         i/gMCMBBfOz4nLLrNDj4jHAIprfMiVb7wC9AitixwsZFRq7sxVhVpPS6M2SfbNG5m4WB
         tp0kQCA3p6B8+bbe7LqK/kVl03q99W2rwBuoHxwP9J26odePDhGngMsu9n88gcHBgzMW
         9RMxpC1Q77kJLViYpYCk5CN/w76gP6MrKUk0+kpW4ntPL+8Be6ZROx2KPoDs07cjR4FV
         LQcL2nlm/CEdUJ1+jqNLflLpbuwiOr0Vg4HR+UQLY5Zl4uuSyZ+tIK5jus9IyMxDMM0W
         wLjA==
X-Forwarded-Encrypted: i=1; AHgh+RoUzAvXPAzgPdYD18zyGLQDdEr6liKDWp73pNGsgVqE3yNxCTqGL67MMTklRfhkH5V3MQpqCCQgW+dybhg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyKwekST7taCSZPZ9kIa0mcMHJnvCVtNbAIzNTQKwnJCK6/yhon
	Y7FrsOggq/a6x+8r+UVeLuVgB0d2BM6Bw6FRCsPQhBbJMY8DuBFvSH9m
X-Gm-Gg: AfdE7cneVPyqeeyxCwXXuixJ5kSXc/rqQYvzVdmHzFN5n85owP7qaKB9hmsZHw0OH9x
	xUATdkvqED8o7wEJ7QBXI5TM2CZQYD8SYZfGbZxZUbu/SD+yezl7fHPY64lJpzMf/I4fu5fst4g
	Nz+qNK0NQK9c4RTW7NOfTGk4pLxwQchJtxUKC5IAL6RQmFjzt9jB59gKfPa8WJulmp4T6iDA/MU
	leUQ9XBXoStD1RdimiS960lSCdX5Mq82zJsj7Z0OwtQw4pQcTelSk7vICYubQriiwlN3vmTjTX9
	rKID4htQfHxpGroC2QhMbRUOYFiP69lEn5Y/jRLKOS+68HNh+53yBDmIeaGMkB3bDtr6gjaS3pc
	5nko3EqQs+Qejc8lhvofRi3UwRBsR71Qwd14JfidcL52L59SgNaH9i8hVMtA7hZO9wlsMhKqW+Z
	3JUN7hSS2e7X0UowDyaBG3XcSuB1eMTvCqBMudElMuKSKnR0ezMLN5SAtJfFe8Z8Q6Ag==
X-Received: by 2002:a05:7301:100e:b0:304:e2a5:689a with SMTP id 5a478bee46e88-30ee136b835mr405041eec.21.1782757795251;
        Mon, 29 Jun 2026 11:29:55 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee31711acsm75391eec.18.2026.06.29.11.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 11:29:54 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	mkchauras@linux.ibm.com,
	sshegde@linux.ibm.com,
	ryan.roberts@arm.com,
	ruanjinjie@huawei.com,
	mkchauras@gmail.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>
Subject: [PATCH V2] powerpc/syscall: Fix seccomp errno handling with GENERIC_ENTRY
Date: Mon, 29 Jun 2026 23:59:46 +0530
Message-ID: <20260629182946.419552-1-mkchauras@gmail.com>
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
NR_syscalls. Since -1 is greater than NR_syscalls,
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

Also Move the syscall_enter_from_user_mode() call and the seccomp/ptrace
skip check to after the NR_syscalls bounds check.

When syscall -1 was passed, the r0 == -1L check would trigger before
the NR_syscalls check, causing syscall_get_error() to return 0 instead
of -ENOSYS. This resulted in a silent success (ret=0, errno=0) instead
of the expected ENOSYS error.

By moving syscall_enter_from_user_mode() after the bounds check, an
initial syscall number of -1 is correctly rejected with -ENOSYS first.
The seccomp/ptrace skip path still works correctly for valid syscall
numbers that get overridden to -1 by seccomp or ptrace.

This aligns PowerPC's behavior with other architectures using GENERIC_ENTRY
and restores correct seccomp errno handling.

Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
Reported-by: Michal Suchánek <msuchanek@suse.de>
Closes: https://lore.kernel.org/all/ajpp-_XnbF3UTM_E@kunlun.suse.cz/
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---

v1 -> v2:
 - Fix issues in the previous fix (Michal)
v1: https://lore.kernel.org/all/20260624171520.772408-1-mkchauras@gmail.com

 arch/powerpc/kernel/syscall.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
index a9da2af6efa8..36d73933a311 100644
--- a/arch/powerpc/kernel/syscall.c
+++ b/arch/powerpc/kernel/syscall.c
@@ -20,7 +20,6 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
 	syscall_fn f;
 
 	add_random_kstack_offset();
-	r0 = syscall_enter_from_user_mode(regs, r0);
 
 	if (unlikely(r0 >= NR_syscalls)) {
 		if (unlikely(trap_is_unsupported_scv(regs))) {
@@ -31,6 +30,12 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
 		return -ENOSYS;
 	}
 
+	r0 = syscall_enter_from_user_mode(regs, r0);
+
+	/* Seccomp or ptrace may have set return value, skip syscall */
+	if (unlikely(r0 == -1L))
+		return syscall_get_error(current, regs);
+
 	/* May be faster to do array_index_nospec? */
 	barrier_nospec();
 
-- 
2.54.0


