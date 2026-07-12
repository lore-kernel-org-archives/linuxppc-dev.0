Return-Path: <linuxppc-dev+bounces-24075-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55DC7C43458
	for <linuxppc-dev@archiver.kernel.org>; Sun, 12 Jul 2026 21:25:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gyzBP0nSwz2yPR;
	Mon, 13 Jul 2026 07:25:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783891533;
	cv=none; b=Lx5HbVincovXV1FumDeuz8fO8lHBMKdBLayye1QQGpwVr/g0WC65jOF+eVyUM5clTik9ZZbboo/Y93nrt167xPB3Xs7Q4ixjUQntYbw5jaorcH0Cw2P/w8sslxsHs/I3lHcRTwmYLHKwXiKY1UR2ECo97ksiNNS/G7rJt5QWaWV98bmbR8nzW3vVWNfLsBE10MpIJVr/veIPmEjoBRat3263yj5JrIYmWfwFm1A4HmZWUD6CcTfvIWEWwj02pq9nFIK/5b+bcHOdXb7LwUfbM/azG5ZyNX2p3owR8uN+apCRkMx8M4h0w4Ygpa714ptRjc3Wp0qv16H4zttNsX9L0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783891533; c=relaxed/relaxed;
	bh=3dgiu8TI4TCoeEn0bEpVdfOeeBtaQ/CqpKNHZxWnkT0=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ZBKS1Ra8gmZq77GfV5AYWMr5MBfaXeDSbpBfK8zQYhcF8U5FzXLhVYFvQg7ryIN7+QTiOya8dd13aWcGjPIWw99V6RDzVGvz13E5gkKJAThLhtMB021CwidZ3A8ryUFhlw+B3lM98PovuyA8fBjjo+DASh9+rV/jsyAx8xEjSf1X5HhI3T2bS9hSYBijbc00vvllzoxPGQANnCR4SfhE+HjGt5BSPExz+4HXl2I4l7Cl/etNM9FYKRjzJGBfmfJfFfFcozLNHLS8R+KIiyUkuTHo4WpOD3ChNGUaffCtkHSniy4C+E+elDY8UcZE+92nk30NMhFI3G421CI3/JqWfg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RLFHFdpF; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RLFHFdpF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gyzBN68mlz2xyj
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 07:25:32 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D47F560103;
	Sun, 12 Jul 2026 21:25:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE9691F000E9;
	Sun, 12 Jul 2026 21:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783891530;
	bh=3dgiu8TI4TCoeEn0bEpVdfOeeBtaQ/CqpKNHZxWnkT0=;
	h=Date:From:To:Cc:Subject:References;
	b=RLFHFdpFXUTSZm/YBrtnuBzx0Yh8fHlGCVPyr2M8hm65643btsbKADLAv6wpykm33
	 Eg0cUgOEJOfikXRmAG51l2v8MPBdeAm4aMIOyJ/i6di5f7CALzJWxWHCoNxcD6S0ah
	 FX4lwJrcKFzpB2M5EgU1/ICA5lBHJxPds5h1Jxb+KnbSYzz3UD+j9I76Mfca2WnMrL
	 l+97Kjp5ak82rCbAcIT3mOGGkVYr59ROgtUEPIgjxvkwzQUd/3aKLG8Jh+dmHXGXKQ
	 EXN1m1qE2cZM4dUpd34jLSEE6VEv5KNYMkU6dEdFEGOJLIsBjxZdcBSNxnjfoamDuS
	 GhGN8JsoJebPw==
Date: Sun, 12 Jul 2026 23:25:27 +0200
Message-ID: <20260712141346.699072205@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev,
 Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org,
 Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 x86@kernel.org,
 Mark Rutland <mark.rutland@arm.com>,
 Jinjie Ruan <ruanjinjie@huawei.com>,
 Magnus Lindholm <linmag7@gmail.com>,
 "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Radu Rendec <radu@rendec.net>
Subject: [patch 3/4] entry: Make return type of syscall_trace_enter() bool
References: <20260712134433.549076055@kernel.org>
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

From: Thomas Gleixner <tglx@kernel.org>

This prepares for changing the return types of
syscall_enter_from_user_mode[_work]() to bool, which in turn separates the
decision of invoking the syscall from the syscall number, which might have
been changed in the call by ptrace, seccomp, tracing.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
---
 include/linux/entry-common.h |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -72,7 +72,7 @@ static __always_inline long syscall_trac
 	 */
 	if (work & SYSCALL_WORK_SYSCALL_USER_DISPATCH) {
 		if (syscall_user_dispatch(regs))
-			return -1L;
+			return false;
 	}
 
 	/*
@@ -87,13 +87,13 @@ static __always_inline long syscall_trac
 	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
 		if (!arch_ptrace_report_syscall_permit_entry(regs) ||
 		    (work & SYSCALL_WORK_SYSCALL_EMU))
-			return -1L;
+			return false;
 	}
 
 	/* Do seccomp after ptrace, to catch any tracer changes. */
 	if (work & SYSCALL_WORK_SECCOMP) {
 		if (!__seccomp_permit_syscall())
-			return -1L;
+			return false;
 	}
 
 	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT))
@@ -102,8 +102,7 @@ static __always_inline long syscall_trac
 	if (unlikely(audit_context()))
 		syscall_enter_audit(regs);
 
-	/* Either of the above might have changed the syscall number */
-	return syscall_get_nr(current, regs);
+	return true;
 }
 
 /**
@@ -133,8 +132,13 @@ static __always_inline long syscall_ente
 {
 	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
 
-	if (work & SYSCALL_WORK_ENTER)
-		syscall = syscall_trace_enter(regs, work, syscall);
+	if (work & SYSCALL_WORK_ENTER) {
+		if (!syscall_trace_enter(regs, work, syscall))
+			return -1L;
+
+		/* Reread the syscall number as it might have been modified */
+		syscall = syscall_get_nr(current, regs);
+	}
 
 	return syscall;
 }


