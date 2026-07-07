Return-Path: <linuxppc-dev+bounces-23730-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F69C44503
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 19:06:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvrKp0GkFz3brx;
	Wed, 08 Jul 2026 05:06:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783451166;
	cv=none; b=GmU10XDV14lIA8RDXNz6eCMjK+NFyp91S5qAU2LXZG4JAhQ4r9JIGbdcvk5wahhlOKyytb5ayL/aFj1eAvcmd38jJ/EJympOyBslAmJWTDryPFlwAyHK33f9y1io7fAAFM6AcBLKvvJb2Sqwz0rM7PAggHxDVfpKlKEuw9pZ/tyXdcG27UcNu0BlR0YM5BSqy5AN10NRz4Jt4joIg0qr5ualsSiSMrtGxfinxHi5yEq6RDVWYHIAYfH+xxS/AQjCtTRAnCzKr/p21vM9wLI3ombU95Wod0m+kc2t5/E6NkFXwnVK+/VpL1TjoTJxlBicryLrLjlhVWdT3Wwe3PVgCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783451166; c=relaxed/relaxed;
	bh=hxSnO03KgHWOZGMce0tACqpsA4dr5cG/I6UVdKHVTVw=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=V3fNce5YjeEMoCEnSiKTPZeOYSMCwsIQX2aT6BrhgKi3oRtyyFKLEzgvRdmwFv2C8NJgYYCUpSXBdUcPY01i2E6NoZEb9y5Kq6MFKuou9hUgsYQQyAF6uYklgtoohAgTxqj+ckHy05hHOUJX5w0ZNpsx955kPa5M4IzhQP9w1P/7cEAs+LCc4HGATTpSeza2l3mmiRRiYUj1dD22C6pv+uKhawmo1npllHYAEw/LCqXdqQrzQyy8i0BaDKSMwYgva+2erPJctWSIeir69jCprfCnhCRDiy7APRIl0RZqs19Skvsf8i8MSOP7dNQSE+Ny9fk5XbF9dfQyATFrwoWmQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XjLMGEZI; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XjLMGEZI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvrKn32RVz2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 05:06:05 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7D4B3601ED;
	Tue,  7 Jul 2026 19:06:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8731F000E9;
	Tue,  7 Jul 2026 19:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783451161;
	bh=hxSnO03KgHWOZGMce0tACqpsA4dr5cG/I6UVdKHVTVw=;
	h=Date:From:To:Cc:Subject:References;
	b=XjLMGEZIqo7ptFMh+dt6XLydZgtGilujB6Pr3G5Xs8jTgXHjTmjHbXax45A1Irn7Q
	 ZoKgOQ+erxKpVuTEY1CN+p5oa4NISG5yLBcptFbbuZ5Smi9OI4/1GT5wKmBvG/kUCm
	 Kb++/j50MCS4Bd4ZIaLeUp05IkQ8BBoXhS1+C2Dfdb2Px/6YBrEpRHirZkoMvFkjrB
	 Esy2/NvwC38v686eB+S6XqRLlxxoxacZU7i1j9g0fzbALa1yDrWEDepcbm0R60qZn9
	 YK/VjvOicJpHE846L2yVE16swnlEjzi7zlbAJYmhCaJqshy4C6LdDpsWMl5NR0b1d9
	 qdpIAZc9XtCbQ==
Date: Tue, 07 Jul 2026 21:05:58 +0200
Message-ID: <20260707190253.718191130@kernel.org>
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
Subject: [patch 01/18] powerpc: Move stack randomization after
 syscall_enter_from_user_mode()
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

add_random_kstack_offset() is invoked before syscall_enter_from_user_mode()
establishes state. That's wrong because add_random_kstack_offset() calls
into instrumentable code.

Move it after syscall_enter_from_user_mode() to ensure that state is
correctly established.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/syscall.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/kernel/syscall.c
+++ b/arch/powerpc/kernel/syscall.c
@@ -19,8 +19,8 @@ notrace long system_call_exception(struc
 	long ret;
 	syscall_fn f;
 
-	add_random_kstack_offset();
 	r0 = syscall_enter_from_user_mode(regs, r0);
+	add_random_kstack_offset();
 
 	if (unlikely(r0 >= NR_syscalls)) {
 		if (unlikely(trap_is_unsupported_scv(regs))) {


