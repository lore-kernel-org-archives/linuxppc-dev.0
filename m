Return-Path: <linuxppc-dev+bounces-23792-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFDD4C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 09:15:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwC9h1JTxz2xll;
	Wed, 08 Jul 2026 19:15:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783502120;
	cv=none; b=BipqpAkQd57k2OZfpLxT3SLPlD9lDhyfcpa+qzkix9A0qPmvjOF7z0Rbe3717AmztZC482MEqAZOoRlRsMa+JqzIcYGB08q0cgrVPTxJuQUaCRS0aL1j9IAuDAsG2IxPYbCkH5hV7ZEoyRpWzPAJT4Clr3S7Wgb5k5R6pArx+fvY6kKm2DjjIFUwpaB+F7arzQ0obk4qYLpO+LB8GSc8sj86Qp2oaMmOxqpZvKLbpfk8Ptlj58H1MSxEMqwIDVp5j0fYogGTFCQfKW2LJKNVK6905hHA1FV75KgC3BHl4QOdojfLDA7OKAdOJ1OZSBmtLmOKCcQxpyBnubuq61a0rw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783502120; c=relaxed/relaxed;
	bh=QXKIkU3dsIb83LaNl9YeImi7A85K1dyuGPQma33N644=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lCb92lWjvYf9yvQvsjoc3t4T0v/gcpnKD1eYE+kLQLgvC9CpjE3zK8CVefmSkBSaW9OlthjT3fuuvz2yFvw57ZrK7pl241rkw7KTjHmXr3KlDIwk6/+2hkrhWpqSHFXc2P+eWffItsJKRDQ1cGLJUNdeaETgskMdAn9q+q22d0oSR3azC6FTiUy7sbReWEqURz4vILnRPJ4xsfcpugbtpaEOzCrAFiJIf71a0LUO5NUhoYa6MD8mA5bpXLFmhVlpK002Y0ZflalcudzFP7d2yRseSp4Y3MiwvzC3NyColm2b+03RzWWDyeYwZowsvnSf3+1aGJxdGjLw0GMjRA2gbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DFMxLuEi; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DFMxLuEi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwC9f0mDJz2xWY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 19:15:17 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DC95A40128;
	Wed,  8 Jul 2026 09:15:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D697D1F00A3A;
	Wed,  8 Jul 2026 09:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783502113;
	bh=QXKIkU3dsIb83LaNl9YeImi7A85K1dyuGPQma33N644=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=DFMxLuEi7KbiLxKOKr7+5tYyHQCk3JpHfb6tuRzE2WRkuMx1mPUf9jIugzEHb8/5x
	 LO8Xyowg5mKltHMmbDOr+gi5tZvNMk+K5CLlhuwiVeBNQv3EKRcMCXRbA9wKg3qjXN
	 yktK4sMH/4XosacPFHJ3cmJotsn19Buu9FUV++AMzk2yr3c1ztSf7A6xr+F2FPufYH
	 7C4ovIQAnZoRC6G/Qa1C+7b0RWd5ohzlBHkaLFo1vS55Av8D6fJzCv3nFP2MI70JYw
	 B1ItdudtjTbPFz/5q4TbBg2sVxB0g3L5dtrLprFMkBcrpN5g+UQIf8TbjYMP31tAm2
	 nw7+qD9T59MIw==
From: Thomas Gleixner <tglx@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Mark Rutland
 <mark.rutland@arm.com>, Kees Cook <kees@kernel.org>, Andy Lutomirski
 <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Russell King <linux@armlinux.org.uk>,
 Catalin
 Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, Helge Deller <deller@gmx.de>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Richard Weinberger <richard@nod.at>, Chris
 Zankel <chris@zankel.net>, linux-arm-kernel@lists.infradead.org,
 linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org, Michael Ellerman <mpe@ellerman.id.au>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org, Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, Brian
 Cain <bcain@kernel.org>, Michal Simek <monstr@monstr.eu>, Dinh Nguyen
 <dinguyen@kernel.org>, "David S. Miller" <davem@davemloft.net>, Andreas
 Larsson <andreas@gaisler.com>, linux-snps-arc@lists.infradead.org,
 linux-hexagon@vger.kernel.org, linux-openrisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, Michal
 =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org
Subject: Re: [patch 11/18] seccomp, treewide: Rename and convert
 __secure_computing() to return boolean
In-Reply-To: <2e6ed364-ce8f-4b4b-8675-acd07f140f4f@huawei.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.230735780@kernel.org>
 <2e6ed364-ce8f-4b4b-8675-acd07f140f4f@huawei.com>
Date: Wed, 08 Jul 2026 11:15:10 +0200
Message-ID: <871pddsuzl.ffs@fw13>
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
Content-Type: text/plain

On Wed, Jul 08 2026 at 09:43, Jinjie Ruan wrote:
> On 7/8/2026 3:06 AM, Thomas Gleixner wrote:
> As Ada pointed out, the description of secure_computing in arch/Kconfig
> need to be updated, a possible suggestion:
>
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -636,8 +636,8 @@ config HAVE_ARCH_SECCOMP_FILTER
>           - syscall_rollback()
>           - syscall_set_return_value()
>           - SIGSYS siginfo_t support
> -         - secure_computing is called from a ptrace_event()-safe context
> -         - secure_computing return value is checked and a return value
> of -1
> +         - seccomp_permits_syscall is called from a ptrace_event()-safe
> context
> +         - seccomp_permits_syscall return value is checked and if false

Makes sense.
>>  		if (__seccomp_filter(this_syscall, true))
>> -			return -1;
>> +			return false;
>
> The return value of __seccomp_filter is checked in the wrong way, check
> -1 should be replaced with check false, maybe:
>
> -               if (__seccomp_filter(this_syscall, true))
> -                       return -1;
> +               if (!__seccomp_filter(this_syscall, true))
> +                       return false;

Ooops.

