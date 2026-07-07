Return-Path: <linuxppc-dev+bounces-23743-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA272C44502
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 19:07:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvrLp4FM6z3bsQ;
	Wed, 08 Jul 2026 05:06:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783451218;
	cv=none; b=m31zMmEshR3go2rxMhZws7EicH+qm6OLPj6o8Sf1yUKya/V+M+PKPnRL4wm5LqeEFCJSYsrfoNqsKzpt6jNKCCn+uet8NO86PE4yWQ1hrkpYI+oqfJ+wiY71mcKaIsFjNBk2bxHIsfnMz8izrTnUqcGAuM0GMgYIfgvHvRPjK2AS1BclVVgyjDmkS2aMAqv4X6tO0sjhWYSF6Xk931APHVgnvo+oiWhwBeE9SNhmXC2lX5kW7LFxrVR5oi7hl+FcTwG52RJN+FSB8x2Maoj8NZKPOWnXbUYp00sLMwzPVJLlwOaEQ+OnBMOJ4s6t4ikUYqeOz57IfiACRtsFDSxf0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783451218; c=relaxed/relaxed;
	bh=M6M79H685AEiWZ8EuGvrBs5I7Y5P9Ee9ippfe5S1H4o=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=HiBI3s0rhvZUUdrk1kN3qLXjxTN8WYfH8E/r/LIuy+ht0s3JC2bcrgMyjgPVsJEppHjcsSUKRqkbLkpXQpckP0ws2ehWHqIZ4vPXoZtjpzV2KdSRqVr2ICxwRGbVJM7jWhILN3kCjejFutr4mklkhIjc1yFTXemmt3f4aJr+mOpFjSsyA1Bqn8gsfiu+/GXWe0W0p0UzegviGYLgYZEKemCRbwIBc52un5uWXbqc9nXNoCRV4sXOD7oIUepHjJ2QRGzYDHTxY7pQyACCq1wq1wgOfugxGas1+b6VOa4X0a5EiVEygWAccl4Z2s8pfWytfySSWXS+B+FghKm5vWPyjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z9pGvu6H; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z9pGvu6H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvrLn5RyGz3bs5
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 05:06:57 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BB45E40166;
	Tue,  7 Jul 2026 19:06:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4E71F00A3D;
	Tue,  7 Jul 2026 19:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783451215;
	bh=M6M79H685AEiWZ8EuGvrBs5I7Y5P9Ee9ippfe5S1H4o=;
	h=Date:From:To:Cc:Subject:References;
	b=Z9pGvu6HNUZ1HEZ1iYllaavjjFKOFgTqadPIozXIv9JGgx2jiaihgSbjZ3dmUzUJU
	 hfjd2RhwbRCe4/RE6GxyfPq09ROnl/NCd1HaUQk2oMKLyHrrLWVUfmEQIWNgG4H0yV
	 BATAOIL2AA4szex3DJbzo2snz+LuHQ5mvQ28B8yiZeSewg4gWEoZdYSbZCcErqheQA
	 uNsdYnJB/6z23NzIIqnXgmHg+EkSOB5aumXG9do1DJbSPpj9mBvOvIqZlR1k7iJd+n
	 ifnsuEaoUlbMIslTJD3wtnmpXeWlKWS3cwSDNZNKQCEZLL2h2iYwy4NYNlzBrzTYMO
	 XibetjyLr85WQ==
Date: Tue, 07 Jul 2026 21:06:53 +0200
Message-ID: <20260707190254.392010241@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Kees Cook <kees@kernel.org>,
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
 Andy Lutomirski <luto@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Guo Ren <guoren@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Helge Deller <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Weinberger <richard@nod.at>,
 Chris Zankel <chris@zankel.net>,
 linux-arm-kernel@lists.infradead.org,
 linux-alpha@vger.kernel.org,
 linux-csky@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org,
 Arnd Bergmann <arnd@arndb.de>,
 Vineet Gupta <vgupta@kernel.org>,
 Will Deacon <will@kernel.org>,
 Brian Cain <bcain@kernel.org>,
 Michal Simek <monstr@monstr.eu>,
 Dinh Nguyen <dinguyen@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>,
 linux-snps-arc@lists.infradead.org,
 linux-hexagon@vger.kernel.org,
 linux-openrisc@vger.kernel.org,
 sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org,
 =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
 Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org
Subject: [patch 14/18] entry: Make return type of syscall_trace_enter() bool
References: <20260707181957.433213175@kernel.org>
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

This prepares for changing the return types of
syscall_enter_from_user_mode[_work]() to bool, which in turn separates the
decision of invoking the syscall from the syscall number, which might have
been changed in the call by ptrace, seccomp, tracing.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
---
 include/linux/entry-common.h |   28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -71,8 +71,8 @@ static inline void syscall_enter_audit(s
 	}
 }
 
-static __always_inline long syscall_trace_enter(struct pt_regs *regs, unsigned long work,
-						long syscall)
+static __always_inline bool syscall_trace_enter(struct pt_regs *regs, unsigned long work,
+						long *syscall)
 {
 	/*
 	 * Handle Syscall User Dispatch.  This must comes first, since
@@ -81,7 +81,7 @@ static __always_inline long syscall_trac
 	 */
 	if (work & SYSCALL_WORK_SYSCALL_USER_DISPATCH) {
 		if (syscall_user_dispatch(regs))
-			return -1L;
+			return false;
 	}
 
 	/*
@@ -90,32 +90,32 @@ static __always_inline long syscall_trac
 	 * through hrtimer_interrupt().
 	 */
 	if (work & SYSCALL_WORK_SYSCALL_RSEQ_SLICE)
-		rseq_syscall_enter_work(syscall);
+		rseq_syscall_enter_work(*syscall);
 
 	/* Handle ptrace */
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
 
 	/* Either of the above might have changed the syscall number */
-	syscall = syscall_get_nr(current, regs);
+	*syscall = syscall_get_nr(current, regs);
 
 	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT)) {
-		if (!trace_syscall_enter(regs, &syscall))
-			return -1L;
+		if (!trace_syscall_enter(regs, syscall))
+			return false;
 	}
 
-	syscall_enter_audit(regs, syscall);
+	syscall_enter_audit(regs, *syscall);
 
-	return syscall;
+	return true;
 }
 
 /**
@@ -145,8 +145,10 @@ static __always_inline long syscall_ente
 {
 	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
 
-	if (work & SYSCALL_WORK_ENTER)
-		syscall = syscall_trace_enter(regs, work, syscall);
+	if (work & SYSCALL_WORK_ENTER) {
+		if (!syscall_trace_enter(regs, work, &syscall))
+			return -1L;
+	}
 
 	return syscall;
 }


