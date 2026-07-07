Return-Path: <linuxppc-dev+bounces-23737-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B18CC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 19:07:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvrLK25MBz3brN;
	Wed, 08 Jul 2026 05:06:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783451193;
	cv=none; b=CxgHDfVP3Xl2Wz522NzCje/wwIx5f+Bh0l1f4YPnAYfYllcE1jN3XmBiSKdx1sMzDDasS+QYg3YpFDKj4y2BHPnfXVuoOvAeICxZWTi3heOGQW0d48ZcP5Rf7R6XQCcU1diG1uANwa+oqa9FeVIwjbAAR1PnceayupGVIH5jl1POfOURQea2u73zsKXslhyxoAZhoW/oAEoOMdDE7qqNhHA7vusu5HXWqgbo2YBmFPdduzhZwPnyNKK1sCuy6gPPm8cqOGirncHrNeZMjvwMG3X845YRRBwefYIyW6D4ULc8R5MFMUg9cAMypE6w4ENSzRWNmEGXt0CY6nUJ6HY3nw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783451193; c=relaxed/relaxed;
	bh=9cJlPyoSYNFp/gOreqxa1IqYId3zkUs6emQr6ytoL3s=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=C5yntjbIUxv2npU4coqbCEhy8Qzq4UTKh1r9Ps4XBuqH4BdBFVSglxnoV5Z66J6uKo54nHwVKEJ03TQvvp6fv8yBRHtou5lIOYKQvwlEpa0qlZsD/+GmJmOCZJ3358XtEmw6HgTJ+dK9tinyjCFJIYrDY+5bF1SfiKVTcAJNISbG2kyFm5XyQZ4YX+jlp3DRqzMYDvJ8ADQP4OImuRHBkFdp7sxopcoHFHeQofKyRxD2n6lI5zE9KfDN1a8xZnG0Iz/g1RwtC3qd/AAP1fpNPkGEm9rahArJ+FU9vwDj6PBbj+WOBniuzCz/In3k8s/TDmp6+3WWXI+5/D67sA09ag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nQZnMsUe; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nQZnMsUe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvrLJ4Jbwz2yfS
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 05:06:32 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B667561384;
	Tue,  7 Jul 2026 19:06:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9882A1F00A3D;
	Tue,  7 Jul 2026 19:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783451190;
	bh=9cJlPyoSYNFp/gOreqxa1IqYId3zkUs6emQr6ytoL3s=;
	h=Date:From:To:Cc:Subject:References;
	b=nQZnMsUeWM0MBmYh2tftX2ldO6f4f4+KQMN8PIETF59TUOLWGfrzzUj86Bfd1xFh6
	 10CcaK+cuIh4vWxH/paWeIPEbvqCR1T98llJwakIpvPv3wZbJgr7EneYcvAjY3VyZc
	 A4mjZpEslZwnTQ9Y3RdELc2sHV368KIKF0A5adgHMQpKbhnF3wx5Vk/7BVZea8ug+A
	 sLcT2ttVqhK19d2pPXbALVn/ZjJDUgCPlmQmEO3tTnqhNKn17sPyy6QjidI+vgfixZ
	 R+fRDdpiEFDapfuQEgmUBP+RUuSIVZHbmwmncIS0zVZsCPzwXAEyG1obgAdo30Y+r0
	 YPfe7YvFhevHQ==
Date: Tue, 07 Jul 2026 21:06:27 +0200
Message-ID: <20260707190254.079478122@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org,
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
Subject: [patch 08/18] x86/syscall: Use
 [syscall_]enter_from_user_mode_randomize_stack()
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

These functions integrate the stack randomization.

syscall_enter_from_user_mode_randomize_stack() has the advantage that the
randomization happens early right after enter_from_user_mode().

In both cases also the overhead of get/put_cpu_var() in
add_random_kstack_offset() is avoided.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: x86@kernel.org
---
 arch/x86/entry/syscall_32.c         |   19 +++++--------------
 arch/x86/entry/syscall_64.c         |    3 +--
 arch/x86/include/asm/entry-common.h |    1 -
 3 files changed, 6 insertions(+), 17 deletions(-)

--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -142,10 +142,9 @@ static __always_inline bool int80_is_ext
 	 * int80_is_external() below which calls into the APIC driver.
 	 * Identical for soft and external interrupts.
 	 */
-	enter_from_user_mode(regs);
+	enter_from_user_mode_randomize_stack(regs);
 
 	instrumentation_begin();
-	add_random_kstack_offset();
 
 	/* Validate that this is a soft interrupt to the extent possible */
 	if (unlikely(int80_is_external()))
@@ -210,11 +209,9 @@ DEFINE_FREDENTRY_RAW(int80_emulation)
 {
 	int nr;
 
-	enter_from_user_mode(regs);
+	enter_from_user_mode_randomize_stack(regs);
 
 	instrumentation_begin();
-	add_random_kstack_offset();
-
 	/*
 	 * FRED pushed 0 into regs::orig_ax and regs::ax contains the
 	 * syscall number.
@@ -252,10 +249,10 @@ DEFINE_FREDENTRY_RAW(int80_emulation)
 	 * orig_ax, the int return value truncates it. This matches
 	 * the semantics of syscall_get_nr().
 	 */
-	nr = syscall_enter_from_user_mode(regs, nr);
+	nr = syscall_enter_from_user_mode_randomize_stack(regs, nr);
+
 	instrumentation_begin();
 
-	add_random_kstack_offset();
 	do_syscall_32_irqs_on(regs, nr);
 
 	instrumentation_end();
@@ -268,15 +265,9 @@ static noinstr bool __do_fast_syscall_32
 	int nr = syscall_32_enter(regs);
 	int res;
 
-	/*
-	 * This cannot use syscall_enter_from_user_mode() as it has to
-	 * fetch EBP before invoking any of the syscall entry work
-	 * functions.
-	 */
-	enter_from_user_mode(regs);
+	enter_from_user_mode_randomize_stack(regs);
 
 	instrumentation_begin();
-	add_random_kstack_offset();
 	local_irq_enable();
 	/* Fetch EBP from where the vDSO stashed it. */
 	if (IS_ENABLED(CONFIG_X86_64)) {
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -86,10 +86,9 @@ static __always_inline bool do_syscall_x
 /* Returns true to return using SYSRET, or false to use IRET */
 __visible noinstr bool do_syscall_64(struct pt_regs *regs, int nr)
 {
-	nr = syscall_enter_from_user_mode(regs, nr);
+	nr = syscall_enter_from_user_mode_randomize_stack(regs, nr);
 
 	instrumentation_begin();
-	add_random_kstack_offset();
 
 	if (!do_syscall_x64(regs, nr) && !do_syscall_x32(regs, nr) && nr != -1) {
 		/* Invalid system call, but still a system call. */
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -2,7 +2,6 @@
 #ifndef _ASM_X86_ENTRY_COMMON_H
 #define _ASM_X86_ENTRY_COMMON_H
 
-#include <linux/randomize_kstack.h>
 #include <linux/user-return-notifier.h>
 
 #include <asm/nospec-branch.h>


