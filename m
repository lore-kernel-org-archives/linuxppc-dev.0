Return-Path: <linuxppc-dev+bounces-23744-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B4FC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 19:07:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvrLt646Zz3cCr;
	Wed, 08 Jul 2026 05:07:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783451222;
	cv=none; b=iteXkn5gTbeX1M37A4RQCy6x/fGkeCczZyhxY63ATjJoX+yGsASfkQX8PtgnEzMiI+2CZGoabItBB76m0+Wlc7HQwLhCPLFVHYJBnUewv8cvaWgfT4Ot76VVbnsssVNtG5nMSCpTtFlFRkVGEcpKFVVeN6I/3YD0iRH5zWld6KMePq73vWgSRUeGb2Fe/jvMPdOJMYUzt7JlJICNaku9+CqMREzFvz0oSq1hbe69tliGQ4wWCXzKwNfVcPlJtiJxH9JKETTzn+agTDMebpVWFM0IungpQQivy48xDSMOkC9/G5nOb5XOB7VlYGWENSlEkp/8SrsaEoHW5ZHSH5nLiw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783451222; c=relaxed/relaxed;
	bh=TiJrYE33DXumkQwt2/+W2OjkQTFHtAcxd2PwMoVTvyY=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=FiER+eEBePtifGrohPrGYHPwamSn89d8RMuk3e9E3F8mTL34+BxiIwbN6hTaH5TBO0lbSZCpB4SEepsfaUFbgVnSwuV5B8j1BJo5qOZkYfOgRhl+1GUpzTmQaNgVtYIO3+6mco6U1fSC8X1ctpBHv1du6iTIjrbYWTOlrbKCDzRZ4RoYmyjUx1Mezm2L7T9sUqbyDSSBzfWjB6MUdYyHbatH51p1uUtWWqCh/w1IozkcRh6f3ILmGOo+YS7vRMo+i8uDpBXdgldcYMPx/wq/BleI7SYW1YoIyqwuE5jtLHqpS2+eEgnfrraW/G7NbQHQnnLWXKuEhj+A7/fvLJyueg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mLelz5RM; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mLelz5RM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvrLt03kwz3bs5
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 05:07:01 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 22341601ED;
	Tue,  7 Jul 2026 19:07:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0645A1F000E9;
	Tue,  7 Jul 2026 19:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783451219;
	bh=TiJrYE33DXumkQwt2/+W2OjkQTFHtAcxd2PwMoVTvyY=;
	h=Date:From:To:Cc:Subject:References;
	b=mLelz5RMvm7eytF+jRJ4D5fjNpUVxBoHH7hg2nYnZT/UFPrsYUFlgsa1ekVxmkuNT
	 gqUlNLdwWLgnYzjvuNk4q4mfdBDP4L9l+PTvTfQrCbLe3tZ/yCqRzAo7NlwS8PHVVI
	 49mJ8Q2tJOFblQl3o/L9kClWZZm2mywKm7GJNLZxIBpy3Ihnr2srvP1DZLhHyNUo1f
	 Hc4RmwqJyFgE/dUEvlOSzi5K2ghRbH1MWuPc5m+aohcMKTewB0AZ3WteDH3gsBS7Ig
	 eb6bs+QZFAyC8WgWIMWvxdkpIA0RxkwSS687u/2TmUsTZblqnvzwjAyicI3Zcq5CI+
	 B67Z6TZ23hK0Q==
Date: Tue, 07 Jul 2026 21:06:57 +0200
Message-ID: <20260707190254.438361565@kernel.org>
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
Subject: [patch 15/18] x86/entry: Make syscall functions static
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

They are only used in the respective source files. No point in exposing
them.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
---
 arch/x86/entry/syscall_32.c    |    2 +-
 arch/x86/entry/syscall_64.c    |   10 ++++++----
 arch/x86/include/asm/syscall.h |    8 --------
 3 files changed, 7 insertions(+), 13 deletions(-)

--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -41,7 +41,7 @@ const sys_call_ptr_t sys_call_table[] =
 #endif
 
 #define __SYSCALL(nr, sym) case nr: return __ia32_##sym(regs);
-long ia32_sys_call(const struct pt_regs *regs, unsigned int nr)
+static noinline long ia32_sys_call(const struct pt_regs *regs, unsigned int nr)
 {
 	switch (nr) {
 	#include <asm/syscalls_32.h>
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -32,7 +32,7 @@ const sys_call_ptr_t sys_call_table[] =
 #undef  __SYSCALL
 
 #define __SYSCALL(nr, sym) case nr: return __x64_##sym(regs);
-long x64_sys_call(const struct pt_regs *regs, unsigned int nr)
+static noinline long x64_sys_call(const struct pt_regs *regs, unsigned int nr)
 {
 	switch (nr) {
 	#include <asm/syscalls_64.h>
@@ -40,15 +40,17 @@ long x64_sys_call(const struct pt_regs *
 	}
 }
 
-#ifdef CONFIG_X86_X32_ABI
-long x32_sys_call(const struct pt_regs *regs, unsigned int nr)
+static noinline long x32_sys_call(const struct pt_regs *regs, unsigned int nr)
 {
+#ifdef CONFIG_X86_X32_ABI
 	switch (nr) {
 	#include <asm/syscalls_x32.h>
 	default: return __x64_sys_ni_syscall(regs);
 	}
-}
+#else
+	return -ENOSYS;
 #endif
+}
 
 static __always_inline bool do_syscall_x64(struct pt_regs *regs, int nr)
 {
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -21,14 +21,6 @@ typedef long (*sys_call_ptr_t)(const str
 extern const sys_call_ptr_t sys_call_table[];
 
 /*
- * These may not exist, but still put the prototypes in so we
- * can use IS_ENABLED().
- */
-extern long ia32_sys_call(const struct pt_regs *, unsigned int nr);
-extern long x32_sys_call(const struct pt_regs *, unsigned int nr);
-extern long x64_sys_call(const struct pt_regs *, unsigned int nr);
-
-/*
  * Only the low 32 bits of orig_ax are meaningful, so we return int.
  * This importantly ignores the high bits on 64-bit, so comparisons
  * sign-extend the low 32 bits.


