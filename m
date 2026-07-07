Return-Path: <linuxppc-dev+bounces-23734-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C44C44501
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 19:06:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvrL45TGJz2yMm;
	Wed, 08 Jul 2026 05:06:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783451180;
	cv=none; b=VvmpF0BUs9l906zxrxhTe0wWVsey/f1BqzIB9TodcbIeDx1Uje2QM7iEZGDURe+6YyqJxVQM5OuRa907io2EDB1iSB0foemKGmuBE+FJHBUCE/lVWOF3OZpQ8HtJ+2aJGAoCT5H/rz6vkp8kVsw46u/MCw9Tofqj30iAVRO8pEhGEGrw5vPcdqbIn5dAGjg2IyLisPW+e/psEniXNYTHf8uGk8vKQsq3seiX6woHYafpyI85drRDnrSJ81pJIc1e65/j8T0J0XJkeY8Ff/GnSLQiDWO2uT1KR5TJ/ATiv24BvmQiw/73TwANyHPYh5K6K/rOVw/mHwzFZnPdbpMOWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783451180; c=relaxed/relaxed;
	bh=bqcx1niI7ioy3DW+/gZQ2MbLYJEE35hyG+fCdizbDSo=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=heCrAafc3+vmJXoxiw2t8YiyN0ySIC5cHXdc2ww7unGLTyCTzwpD8dsgSfeFX+7qfd0141pBG4c5K26e/RpqxcOQnIjvdHDEkgnGcr8AourSwxFyvR7EKkuyMcuYQdovXs1bDK4/iTBVDfqDy6asdCW3zEdO5K5VwDNuzhgUhyU8sYhKoPAUtDPjxd3h/50+z6NrHUYJJmL1tOqNxumtx7bZNS+9hRq0rT9ZA4gBVG9gzbhB1Kx+VAggdm3tM85bPex4fUM1Efmwn4x5rvSAB6EpvwvS3hZ+beT/rBf9YX/Jc20ul8lTVoOD5Rigoy/xYe7u01seP7PDAkfpoPs2Xg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aJaRZSNF; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aJaRZSNF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvrL40PlCz2xyh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 05:06:20 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2C56B601EC;
	Tue,  7 Jul 2026 19:06:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E0D1F00A3A;
	Tue,  7 Jul 2026 19:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783451177;
	bh=bqcx1niI7ioy3DW+/gZQ2MbLYJEE35hyG+fCdizbDSo=;
	h=Date:From:To:Cc:Subject:References;
	b=aJaRZSNFmGdCFvruVG7x5xRrvggSIGN0GND+eCq7/up7llJN2RLb5yTt7nKiF5bMl
	 dDjbHacdEwTpP5I1/lusznloh2jALXKsApluk4rrQ6UjQSVw3qYVOOw6/ktRrDvDFv
	 6mM4CdAeBuHePM8toFrWSjVi5vf12es33TiR0Erbaqy0+HMgOhtPrzfLuSaVmJcBBf
	 Qwx11aY+YPFSRPD5t62E+zU8M90fmxRE9JPIpsU8ZmTyzhptaz9i1jNQWCYVnDIzEX
	 +BqGBqk3JLQ87YaLjGkYNumyEdOthBs5KZUcJ25lEB3+VQ9NuYSR6XQbeSkS9Uk7wj
	 gTZuo3rzjPU7w==
Date: Tue, 07 Jul 2026 21:06:15 +0200
Message-ID: <20260707190253.918861529@kernel.org>
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
Subject: [patch 05/18] powerpc/syscall: Use
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
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/syscall.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/arch/powerpc/kernel/syscall.c
+++ b/arch/powerpc/kernel/syscall.c
@@ -2,7 +2,6 @@
 
 #include <linux/compat.h>
 #include <linux/context_tracking.h>
-#include <linux/randomize_kstack.h>
 #include <linux/entry-common.h>
 
 #include <asm/interrupt.h>
@@ -19,8 +18,7 @@ notrace long system_call_exception(struc
 	long ret;
 	syscall_fn f;
 
-	r0 = syscall_enter_from_user_mode(regs, r0);
-	add_random_kstack_offset();
+	r0 = syscall_enter_from_user_mode_randomize_stack(regs, r0);
 
 	if (unlikely(r0 >= NR_syscalls)) {
 		if (unlikely(trap_is_unsupported_scv(regs))) {


