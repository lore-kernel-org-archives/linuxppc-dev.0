Return-Path: <linuxppc-dev+bounces-23742-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1307BC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 19:07:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvrLk2wK9z3bsM;
	Wed, 08 Jul 2026 05:06:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783451214;
	cv=none; b=QDPu6EYjSroWYQaYnjCQ4uUzncXA5i9Z6aQkCsWCZ/D9jDg3+w9XP+MEaPoM0/XXOybg/DUfWyIFtwbhU8PosZahYcyMutTdVBvzBs/03QfFj0/5G97jXV6ni9I6yNldvc3Vf6gq9s2vafKUilst6LKKD4VWKHJFeJrJxI13RIjSokziHaQ0FUGmA1LNDF8WqdJO0913qAsIIrS0z5FhUTwZsbSaGeL+gmqVVJ7iXrSO7e6smAwpMno9KIsadBmQxqpUbyGLSq9J06zVRiHx/U4fRBuXbps452zCBBuXglT5OgPKlwwrTTWE5wU87fYUBK0sTiNqCWBRofG6Udz1EA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783451214; c=relaxed/relaxed;
	bh=2hP2B4F9qeeUXuU3XysbmgOwdSnbN4nPIvEqn4Tc+Vc=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=NMtTQ8FycKtQYkOSpVmgafFSIKf2P2hRn/iN2obzJRISUezgmklxw6uTAaP3gO3K5bY4P8KhfVTCujqyHawoWvl7UySLsvLUS38YsPf/NU4EBJOZ+ZfCog88jjap5nfe/S7tI6RDUzEbebdxPoim+KOEL0PY0ISFZ4BDixh8WvZ7h/sAIT92IhdDoESNsvqkge0jv3EQWxC7QcCQ/aoYNlrOsgwTjoR1CTE/OateVFySQkW9G7Ukfsd4feVOcHY2zFuN8I/pJvpFTkg3MIZOGOXLZdaJ+xpswpzDN/TcjMMeG44N4wOdNq9OqXJgsqXjxbAQvigika82H/3SluFJyw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GX8UQNU5; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GX8UQNU5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvrLj4FjSz3bs5
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 05:06:53 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B33606138B;
	Tue,  7 Jul 2026 19:06:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997691F00A3F;
	Tue,  7 Jul 2026 19:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783451211;
	bh=2hP2B4F9qeeUXuU3XysbmgOwdSnbN4nPIvEqn4Tc+Vc=;
	h=Date:From:To:Cc:Subject:References;
	b=GX8UQNU5eotoxcPBLwgb2dREYSYCaobbI7j41EIjeAQbZxYCGuF9DAt9CuKdWhml5
	 sKLqvJU7OLLMsewiAA5UrA2UnmhlrFwfEUGzISBe2Jat9AL4izazWtNtXgKtBBNbzS
	 Pk/Ylkh8qbCDazP5INDbcRzOErFrWroa9+BlpD5E0YXaC/H3Z3JkwneB2JtFInyqn1
	 9UUW7cznoP9Sj9JShH/9STHt6/MiC/5xbpW1rEBQWCbAjEVvJGIuJwCWYWkkgnIyrX
	 3Z+Nm44fpA3fg/FSFwJd+2UjfCZ/sMDtcZhjx7lFIz/M/97exj3ilz3ZoFUpMhhgHk
	 1wiFALaxAM02A==
Date: Tue, 07 Jul 2026 21:06:48 +0200
Message-ID: <20260707190254.338083894@kernel.org>
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
Subject: [patch 13/18] entry: Make trace_syscall_enter() return type bool
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

In preparation of converting the return value of
syscall_enter_from_user_mode[_work]() bool, rework trace_syscall_enter() to

 - update the syscall number via a pointer argument

 - Return True if the syscall number is != -1, False otherwise

That aligns with ptrace_report_syscall_permit_enter() and
seccomp_permit_syscall().

The only difference is that this also returns False, when the syscall
number was already -1 to begin with, but there is not much which can be
done about that. As the architecture has to preset the return value to
-ENOSYS anyway, that results in the correct return value for such an
invalid syscall.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
---
 include/linux/entry-common.h  |    8 +++++---
 kernel/entry/syscall-common.c |    7 ++++---
 2 files changed, 9 insertions(+), 6 deletions(-)

--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -58,7 +58,7 @@ static __always_inline bool arch_ptrace_
 #endif
 
 bool syscall_user_dispatch(struct pt_regs *regs);
-long trace_syscall_enter(struct pt_regs *regs, long syscall);
+bool trace_syscall_enter(struct pt_regs *regs, long *syscall);
 void trace_syscall_exit(struct pt_regs *regs, long ret);
 
 static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
@@ -108,8 +108,10 @@ static __always_inline long syscall_trac
 	/* Either of the above might have changed the syscall number */
 	syscall = syscall_get_nr(current, regs);
 
-	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT))
-		syscall = trace_syscall_enter(regs, syscall);
+	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT)) {
+		if (!trace_syscall_enter(regs, &syscall))
+			return -1L;
+	}
 
 	syscall_enter_audit(regs, syscall);
 
--- a/kernel/entry/syscall-common.c
+++ b/kernel/entry/syscall-common.c
@@ -7,14 +7,15 @@
 
 /* Out of line to prevent tracepoint code duplication */
 
-long trace_syscall_enter(struct pt_regs *regs, long syscall)
+bool trace_syscall_enter(struct pt_regs *regs, long *syscall)
 {
-	trace_sys_enter(regs, syscall);
+	trace_sys_enter(regs, *syscall);
 	/*
 	 * Probes or BPF hooks in the tracepoint may have changed the
 	 * system call number. Reread it.
 	 */
-	return syscall_get_nr(current, regs);
+	*syscall = syscall_get_nr(current, regs);
+	return *syscall != -1L;
 }
 
 void trace_syscall_exit(struct pt_regs *regs, long ret)


