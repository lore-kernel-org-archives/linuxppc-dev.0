Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A7C606A327
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Nov 2026 17:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FkpyzqH8
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jHjHX3Dsnz2xnn;
	Mon, 02 Nov 2026 04:58:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793555896;
	cv=none; b=d7PKK6gNx9upKn1XSab2gZwpQcgRUuc4si5Ttlw5L9y/Xkc2tEYBJr7te/fJedUrUYz6g0Ju04HbLRPeGJ2OJVz3vUq4aVIDM548/0HHWps1MSXnkXrwQ4SG6aYKJKki3cW12Dmpo+DDPmee5FOyEgL9hTHHVE6vRndzs1kmT8el6so+XXtqTPmGuf3YBr//Z08+2M/BAo89IU9JTm0qdvZc2rx2FRtD/r+E81dyT6WKF4lHRK/pEwSTHRcBqXwkiqDnmDVL1cK8tHZJ3wxKGhIqZYfagPlsU7MyzRBBgUMHhE2Q9m/XS38GatER2g8aVFkvijxuwfnEEk0eRC1Elg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793555896; c=relaxed/relaxed;
	bh=+7HwRXGWtYS3xmU+Z46/w0lVl31Dl0sZcMyXjmUDfIs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UXXMHpGUTyZ4GXcGW9s9RKXMlCV409ePiz6+41UdVs6WM1RHwNUhifbpS0GJ2l1DkdgmYq43yHCz0KfxxYo75sA6i2hsDOQzlafVP2oa0CDEpHtIJv5nAKA5wR68oKbvTRoPw7nA67c6hygfOeKY5LkK2sFUvw7wDJal1G2vBCtnSEWvKPwj0bEB/M644jIX/uq1AKReqdsVWYnwpc9H++LGKOk/t2IL/lPyTuwTRuP5xfWzG1VQobJkLF4fJ3kA4J3l3ng49uCQvrm1yVNj7rJN4Py9pwQSHz+/wT3QDoIoNyzYD4dAqfUCT3fNYlBYFMzaaAuV5de7u2pyFUyyvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FkpyzqH8; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FkpyzqH8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jHjHV6rFHz2xWt
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 04:58:14 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0EC39402BE;
	Sun,  1 Nov 2026 17:58:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388A21F00A17;
	Sun,  1 Nov 2026 17:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793555891;
	bh=+7HwRXGWtYS3xmU+Z46/w0lVl31Dl0sZcMyXjmUDfIs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=FkpyzqH892Y24Bf4MzJaxg0GENU+W3h1HrKoje37+gLiStKVwoHULfobDtcxPd97k
	 O7yDPvc5mWSjJBu8vqqdIiJljIIY/6Z6d8PFXXCg74LTEn4DannL5V6rcy3NiVl7Cu
	 DnutKq7d2bLfY2EkKJcg1fiS7Qvebb0UQQu9SHDSugPX5Tba1NEXcVGdUEzB6sw+y5
	 V2z/p2t+EDUDEUhm+YjJeNELsgmzPgXTja1HpGoACFV2HxgapWeRjmaKUW4P/rTSol
	 vGE0a3SiPbMJFefI/JNfVFZ/R4iCFJ+Rd4uFfOaqAIzWd7mtslcqNYqP4841tBmpOx
	 x3REifKbTPuGQ==
From: Thomas Gleixner <tglx@kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Shrikanth
 Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Kees Cook
 <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, Sven Schnelle
 <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, Andy
 Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Guo
 Ren <guoren@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Helge Deller <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger
 <richard@nod.at>, Chris Zankel <chris@zankel.net>,
 linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-m68k@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org, Arnd Bergmann
 <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Will Deacon
 <will@kernel.org>, Brian Cain <bcain@kernel.org>, Michal Simek
 <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
 linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, Michal =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH V2] x86/entry: Fix ptrace regression
In-Reply-To: <87mrrvxaty.ffs@fw13>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.493733289@kernel.org>
 <20261022142425.3Wx-RrU5@linutronix.de> <87fqxx1r80.ffs@fw13>
 <87cxt11ktr.ffs@fw13> <1149A39E-BEBA-46EA-94F4-4DFFC4733EF5@zytor.com>
 <871p9g1s3w.ffs@fw13> <87y0boze95.ffs@fw13>
 <C6D7BF04-4CF7-48D1-93B5-E80D52C2617D@zytor.com> <87se1wyvs8.ffs@fw13>
 <87mrrvxaty.ffs@fw13>
Date: Sun, 01 Nov 2026 18:58:08 +0100
Message-ID: <87ecd4xwlr.ffs@fw13>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The recent rework of the syscall entry code missed the historical detail of
the abuse of syscall number -1L to abort a syscall and keep modifications
by tracers to the return value, while a rewrite of the syscall number to an
invalid value undoes eventual tracer modification to the return value and
overwrite it with -ENOSYS.

Restore the original behaviour.

Fixes: 1b1f3b3e1b39 ("x86/entry: Get rid of the sys_ni_syscall() indirection")
Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/all/20261022142425.3Wx-RrU5@linutronix.de
---
V2: Add the missing -1 check in the 32bit path - sashiko
---
 arch/x86/entry/syscall_32.c |    4 ++++
 arch/x86/entry/syscall_64.c |   26 ++++++++++++++++++++++----
 2 files changed, 26 insertions(+), 4 deletions(-)

--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -77,6 +77,10 @@ static __always_inline void do_syscall_3
 	if (likely(nr < IA32_NR_syscalls)) {
 		nr = array_index_nospec(nr, IA32_NR_syscalls);
 		regs->ax = ia32_sys_call(regs, (unsigned int)nr);
+	} else {
+		/* See comment in do_syscall_64() */
+		if (nr != -1UL) {
+			regs->ax = -ENOSYS;
 	}
 }
 
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -64,15 +64,20 @@ static __always_inline bool do_syscall_x
 	return false;
 }
 
-static __always_inline void do_syscall_x32(struct pt_regs *regs, unsigned long nr)
+static __always_inline bool do_syscall_x32(struct pt_regs *regs, unsigned long nr)
 {
+	if (!IS_ENABLED(CONFIG_X86_X32_ABI))
+		return false;
+
 	/* Adjust the starting offset of the table */
 	nr -= __X32_SYSCALL_BIT;
 
-	if (IS_ENABLED(CONFIG_X86_X32_ABI) && likely(nr < X32_NR_syscalls)) {
+	if (likely(nr < X32_NR_syscalls)) {
 		nr = array_index_nospec(nr, X32_NR_syscalls);
 		regs->ax = x32_sys_call(regs, (unsigned int)nr);
+		return true;
 	}
+	return false;
 }
 
 /* Returns true to return using SYSRET, or false to use IRET */
@@ -81,8 +86,21 @@ static __always_inline void do_syscall_x
 	if (likely(syscall_enter_from_user_mode_randomize_stack(regs, &nr))) {
 		instrumentation_begin();
 
-		if (!do_syscall_x64(regs, nr))
-			do_syscall_x32(regs, nr);
+		if (unlikely(!do_syscall_x64(regs, nr))) {
+			/*
+			 * The special treatment of syscall number -1 is a
+			 * historical bogosity as the original code used -1 to
+			 * indicate syscall abort, which is not distinguishable
+			 * from a syscall which is invoked with syscall number
+			 * -1. The historic behavior is to keep the return value
+			 * in regs->ax unmodified in that case, which means it's
+			 * either the preset value -ENOSYS or a value which was
+			 * written by a tracer. If the syscall number is invalid
+			 * but not -1 then overwrite any tracer modification.
+			 */
+			if (!do_syscall_x32(regs, nr) && nr != -1L)
+				regs->ax = -ENOSYS;
+		}
 
 		instrumentation_end();
 	}

