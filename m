Return-Path: <linuxppc-dev+bounces-24074-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E81DC44501
	for <linuxppc-dev@archiver.kernel.org>; Sun, 12 Jul 2026 21:25:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gyzBJ0XM0z2y7W;
	Mon, 13 Jul 2026 07:25:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783891528;
	cv=none; b=f80z97T2KKxGGEzjlqqa9BdZJ09H33B5p9B9H4wv+2QiEAWJX8ObNQXJmZc5QPgTlfjoEHdaHHKKMSthEEYRVVgJUL3USm1pNwDjQeg6f6VX+kSAZouHnHG4lB5Tdwnjj1zKakvCdwwtvv57k6qSyws+cxokJYXxoQqeiKbEUbOYLBnkeLI0cEU+EK7P8UXVLsfsvgIkLTELg3Tvqx74K1APXDFMNtWG7cCBWQl5Np385P+BAOv5kCcXtrz+Krv2JpiwjMLDgyoftQzTCQCKbb19w/4OAzo4T2euFiwHKgeaiEdQaeyTTk9GI1zAIbivhrgGJERt0S1dC2bdVSLYJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783891528; c=relaxed/relaxed;
	bh=2JItWlUO0RtFZwJ9AedXkVw8o5YILdxQ5hx8qr2Nb5s=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=WDFW0xgNWQBpsBresOv2EMu+0ZrPOwpcS7ihUAM6q0DQWCbvz5EIyVmv8MDWtoq9But9KBufQEYWDrP9JkxwOLwCgAa2MYjlYvib5a3zy5C7gvogurKS556PmXsyrBEa733nXN2GVc51LiRO3JledFqZXAnkhEjk1RZOfHGqmHJ/DlF914Rs3DeQCP1Q4B3CW4EPCaOI1lVXSD1QAJW8k3Tg3ZrbPLExN9eCTx7wv5fckdoR9JUu8eaIYF9G3Tx5hf8M2Nh1O3+jKFSYKMhc0hFc5mcIit7F45aHzy1zOW5gARGJ2z6ci/1DnLOSmHxe0KRb7hZgxSasF0UR/kTTQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mzeCuuT0; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mzeCuuT0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gyzBH5n6kz2xyj
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 07:25:27 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E837F600FC;
	Sun, 12 Jul 2026 21:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF891F000E9;
	Sun, 12 Jul 2026 21:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783891525;
	bh=2JItWlUO0RtFZwJ9AedXkVw8o5YILdxQ5hx8qr2Nb5s=;
	h=Date:From:To:Cc:Subject:References;
	b=mzeCuuT0JQcjq0ffdG1mMOXvwVg7uBygi4ikhxj2XYUNlmMfzmfn3U2nH5Q/s2tYT
	 hE6So6oMIRH9zZo8P+kLDM1SHxS9ep4XeX4OI3bWj66SvgdPaw44aKEwaw1MYINh0H
	 4zCSmz9lTSmItEjpfX/V5TRcJOf34STaoyRjMoXNl0u96NUZtWitt5VWhcdZN+gCWy
	 1VFaBHkKtdt0C3blUBtUpl6PbzJYJ53qjO+yF+0U6mYoA2Nbt0/kmPWWjLEgxJP/cY
	 oOTjW6RijF7rhFsJnEwV9x1TsJubt24VulGi6dqcPQSyG1yrH+hb9EUlxjDaCvPx9L
	 hy+Ix8nbOcXZQ==
Date: Sun, 12 Jul 2026 23:25:22 +0200
Message-ID: <20260712141346.639115923@kernel.org>
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
Subject: [patch 2/4] entry: Rework trace_syscall_enter()
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

Reread the syscall number from pt_regs and stop returning the eventually
modified syscall number.

That moves the reread to the end of the syscall_trace_enter() and prepares
for moving it to the call site.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
---
 include/linux/entry-common.h  |   10 ++++------
 kernel/entry/syscall-common.c |    9 ++-------
 2 files changed, 6 insertions(+), 13 deletions(-)

--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -58,7 +58,7 @@ static __always_inline bool arch_ptrace_
 }
 #endif
 
-long trace_syscall_enter(struct pt_regs *regs, long syscall);
+void trace_syscall_enter(struct pt_regs *regs);
 void trace_syscall_exit(struct pt_regs *regs, long ret);
 void syscall_enter_audit(struct pt_regs *regs);
 
@@ -96,16 +96,14 @@ static __always_inline long syscall_trac
 			return -1L;
 	}
 
-	/* Either of the above might have changed the syscall number */
-	syscall = syscall_get_nr(current, regs);
-
 	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT))
-		syscall = trace_syscall_enter(regs, syscall);
+		trace_syscall_enter(regs);
 
 	if (unlikely(audit_context()))
 		syscall_enter_audit(regs);
 
-	return syscall;
+	/* Either of the above might have changed the syscall number */
+	return syscall_get_nr(current, regs);
 }
 
 /**
--- a/kernel/entry/syscall-common.c
+++ b/kernel/entry/syscall-common.c
@@ -8,14 +8,9 @@
 
 /* Out of line to prevent tracepoint code duplication */
 
-long trace_syscall_enter(struct pt_regs *regs, long syscall)
+void trace_syscall_enter(struct pt_regs *regs)
 {
-	trace_sys_enter(regs, syscall);
-	/*
-	 * Probes or BPF hooks in the tracepoint may have changed the
-	 * system call number. Reread it.
-	 */
-	return syscall_get_nr(current, regs);
+	trace_sys_enter(regs, syscall_get_nr(current, regs));
 }
 
 void trace_syscall_exit(struct pt_regs *regs, long ret)


