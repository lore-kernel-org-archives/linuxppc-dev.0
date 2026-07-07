Return-Path: <linuxppc-dev+bounces-23735-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E97CC43602
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 19:06:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvrL915WCz2yVv;
	Wed, 08 Jul 2026 05:06:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783451185;
	cv=none; b=TS32lj/vjBk8BmefPz6iXGgmYACNgVy+/K6Dyhr0iOH7dOtK0iX2RxDJ5jTnMZaoDMyBZmxOxqHQtIgGbPaE9ZP4nl1hbWYvmHUaHM+kq6KVCK0GduID+3XvZ4BrolVsOD/VTzhJPuGzJZMTM1pjX2G1EE+7TsLyVkoT5cQC4l3s4rfdaaSzQJ8hgtwP4VfSkAJgryVKanCjW3iNGharPzm/ndnzvu1qrrnf8unXn56ZQGZM/D7C9cboogTA/8nQue4IZIE/URzXQKWZqH08ar60FSxbb6xyc/NcQlXuPuTJJstMmcbjTu8cHXLakcITnxZhk90RdxFl4r0+iE7L7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783451185; c=relaxed/relaxed;
	bh=FSz9R//tXkAkFf727Rcog7SX40mWm3WZD+GcFTZrqNo=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=MZAh4SEKRH8OEjUDGdtPc107hAbI9XMqHK30AYaLhtZcDO/Qxg9xVo3iQKADFaghCC2aJdXCYH8zI32WFldcd0D0/uQ3rX0+cBl6suP+3WCgw3tBSt+rNY8bn6ubpjziDKRXFNSpEOjDcRA3pdg/AKFChGoyj3ZNOZr1MbCDK32wLLxqpXUBgyWIezJjkGKNnVvAglaTVsLj0RhN/dTIx6Z6IvqF4ZutqJ2QesMtB/dB4gjkJYM7ZEKfHnopwsIny2sZRAnUAk2IqSgavHiwbx/EkDha5bZFdyBWqd2Pesixtom/CGGjcSM+oopv6lOClmSdMiZVr+OXweRb3Bc77A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jmy5NgtN; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jmy5NgtN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvrL81xQ5z2xyh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 05:06:24 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5EBE9601ED;
	Tue,  7 Jul 2026 19:06:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5D11F00A3D;
	Tue,  7 Jul 2026 19:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783451182;
	bh=FSz9R//tXkAkFf727Rcog7SX40mWm3WZD+GcFTZrqNo=;
	h=Date:From:To:Cc:Subject:References;
	b=jmy5NgtN1SD2HqwkVPG0TWkFN54TmdXj7T1HSJ0YKKwFEFYGJZgl0bxw21Z5Zw6gF
	 oLz0li+t91OzAxgXcJufOtcILCljJifd/dtqOAvAWgylV3Gsd2EQ0rLxbGfO01LU0j
	 fGSFcIN5CQo8Eb+XAIcZbFr1t/Rccy9Jg9VrEGxft5Y0XFjAFPmIVc5t+s4ruAoLPe
	 NXUZ3wSbTXF7v2pk2mNXgxKVbV69AzbsU6gyihCw7XUl2EEorcZSB4GwvDUCm+Y5ri
	 rE9qNujpevqvyyh40zbml6ST8aYSMsFvamJntu3IcdBj7uE8fU0k0BtndQzpUpA3fJ
	 QZRGwGblw5h8g==
Date: Tue, 07 Jul 2026 21:06:19 +0200
Message-ID: <20260707190253.974626922@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Kees Cook <kees@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev,
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
Subject: [patch 06/18] riscv/syscall: Use
 syscall_enter_from_user_mode_randomize_stack()
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

syscall_enter_from_user_mode_randomize_stack() replaces
syscall_enter_from_user_mode() and the subsequent invocation of
add_random_kstack_offset().

The advantage is that it applies the stack randomization right after
enter_from_user_mode() and thereby avoids the overhead of get/put_cpu_var()
as that code is invoked with interrupts disabled.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Paul Walmsley <pjw@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-riscv@lists.infradead.org
---
 arch/riscv/kernel/traps.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -7,7 +7,6 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/irqflags.h>
-#include <linux/randomize_kstack.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/signal.h>
@@ -333,9 +332,7 @@ void do_trap_ecall_u(struct pt_regs *reg
 
 		riscv_v_vstate_discard(regs);
 
-		syscall = syscall_enter_from_user_mode(regs, syscall);
-
-		add_random_kstack_offset();
+		syscall = syscall_enter_from_user_mode_randomize_stack(regs, syscall);
 
 		if (syscall >= 0 && syscall < NR_syscalls) {
 			syscall = array_index_nospec(syscall, NR_syscalls);


