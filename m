Return-Path: <linuxppc-dev+bounces-26157-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF37C61DC4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Aug 2026 22:48:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hWGrQ0mQrz2xKh;
	Fri, 28 Aug 2026 08:48:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::136"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787870886;
	cv=none; b=FEWl63B8H6fJYGk41MdRtzPQkPABgjTVB9hM7AcVBbr5s40CvA90YlBhak8kAX4r0/1SpzPPdYrgLoRwv2FRV2dbqn0tZPWwGVnaHr3cAVvr2AONl5khfsphjdesU5WmzMx4BEAJr6tWhtI6Uqi3OdHlXfql/lEJvrBp2qlnolyerOT+fe2j2HuDa6QG9RVPynH7afpz9exlvKssszSwNZLW3MXgJooVTS+zaL4LWoEnZF0RIYhQ2Dkzo2Qe6IHF1TCbU9Ht0/cceJeR/UXmhpEJVncvpf3z1aZSjVdPpafqqlE+CE6Gomwrf2hckDb7DgninzkWQ6AI6zcjz/2Xwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787870886; c=relaxed/relaxed;
	bh=EXQuytFudEdgp91C+uFz8aeu/WW15G7DgPzpxtGKF4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RfyUSjhwzXRUkLZuZ1bbV6dRFl9mPxpd/d4QsZTGegF6FCA2TQsE2GBWhCZkuKAXUIeyiE6OUT4NP5Q8EGQbEIFPHulviJP2+Zs2i/tPtFf98Em9kuEqkbmrtRFnlLPDUr3VX1iTL0fXwhXUdmwAOJ5p8ewU2S5+7pusZta3J4ZM+cLsuEXgK6Cq9166q9D9NCCBDgPrrUzMjD7acZ9A++LCg+L9VkzWII/zJo+A39C3+tWnClmGPsp+anl0GDfCC9+Zh1Dyn6V2tEbL8TdETXmVm2dquj3dqAm4joaYMxHCy7+7meGKpDvY1e5LitQiF8TG8yrmi/ATE+bJ2g2hUA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zytor.com; dkim=pass (2048-bit key; unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026072801 header.b=GymOd4Rk; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::136; helo=mail.zytor.com; envelope-from=hpa@zytor.com; receiver=lists.ozlabs.org) smtp.mailfrom=zytor.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026072801 header.b=GymOd4Rk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=zytor.com (client-ip=2607:7c80:54:3::136; helo=mail.zytor.com; envelope-from=hpa@zytor.com; receiver=lists.ozlabs.org)
Received: from mail.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3::136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hWGrN3Fmfz2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2026 08:48:04 +1000 (AEST)
Received: from [IPV6:2601:646:8081:8d71:8c93:dacb:e5fa:49aa] ([IPv6:2601:646:8081:8d71:8c93:dacb:e5fa:49aa])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 67RMl4Qn1836438
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 27 Aug 2026 15:47:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 67RMl4Qn1836438
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026072801; t=1787870834;
	bh=EXQuytFudEdgp91C+uFz8aeu/WW15G7DgPzpxtGKF4M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GymOd4RkxGi8njVCQCfisvKP39Bb44ZVOGqd2ZqhsM67DzFyYn8S/jMXCU8Rma33W
	 PEelxL7L8kBY+qk5qAEjpsMwfkxEwjrDmJEsL+fSa6zkpR+h5d+MOwPtTLVMwwm0lZ
	 bCPemLIjQYuVaQEQRjl132J4YP0xzX54ej4JFh90v2xhqZFikkHSFSnGkczichDoFv
	 sZK/qGKEclFkhvxq+v2kMkmJ4o1BjYqiHVTd5aGLm7HyH0fkUCbFxhX7p3xCNzPfY0
	 gzR1rveeuo2MbtEx3KqfD+thNsEFw5il2Dad3o6axDhdFmbVxxjrh2OwAc/diiyN8G
	 nWKtXnX6xx8pw==
Message-ID: <995a61ef-ce8c-4c8b-bea8-77f375076a39@zytor.com>
Date: Thu, 27 Aug 2026 15:46:58 -0700
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
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 03/18] entry: Provide
 [syscall_]enter_from_user_mode_randomize_stack()
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Kees Cook <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>, Andy Lutomirski <luto@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller
 <deller@gmx.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>,
        Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>,
        Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
        linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20260707181957.433213175@kernel.org>
 <20260707190253.816918647@kernel.org>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20260707190253.816918647@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-07-07 12:06, Thomas Gleixner wrote:
> Randomizing the syscall stack can only happen after state is established
> via enter_from_user_mode() or syscall_enter_from_user_mode(). The earlier
> it happens the better.
> 
> Provide two new macros to consolidate that:
> 
>   - enter_from_user_mode_randomize_stack()
> 	enter_from_user_mode();
> 	add_random_kstack_offset_irqsoff();
> 
>   - syscall_enter_from_user_mode_randomize_stack()
> 	enter_from_user_mode_randomize_stack();
> 	syscall_enter_from_user_mode_work();
>     
> to reduce boiler plate code.
> 
> Those are macros and not inline functions as the latter would limit the
> stack randomization scope to the inline function itself.
> 
Not directly related to this patchset, but still:

Can anyone *please* find out what the actual security requirements are for the
syscall randomization offset?

The original checkin, 39218ff4c625 ("stack: Optionally randomize kernel stack
offset each syscall") indicates that it is fundamental that the stack offset
is applied *after* pt_regs pushing, but that isn't documented anywhere in the
kernel sources as far as I can tell.

However, I have also come to understand that there are further, undocumented
constraints; at least at one point I was told that "the offset should not be
stored in memory while running in the kernel", which seems more than a bit odd.

This matters, because it creates a data dependency on exit. The original
checkin does call out that RDTSC timing is inappropriate if the user could
control it, but using a hardware CSPRNG like RDRAND (or its equivalent for
other architectures) would be feasible if it isn't in the critical path. If an
RDRAND - store sequence can be executed on entry, *after* the stack
adjustment, then the high latency of RDRAND can hopefully be very effectively
hidden by an OO CPU.

Incidentally, in case you are wondering "why doesn't each core get a dedicated
CSPRNG and hardware randomness generator, to avoid high latency", the answer
is pretty simple: a hardware random number source, regardless of the specifics
of the design, almost by definition violates the hardware design rules of any
digital design; after all, the design rules are designed to *eliminate* noise
(making the circuit behave as closely as physically possible to a realization
of the abstract digital circuit), whereas the very goal of a HWRNG source is
to *extract and amplify* quantum thermal noise. This means that considerable
chip area is consumed by a "keep-out zone", a designated "no man's land"
keeping the digital logic away from the noise source. This keep-out zone is
typically much, much larger than the noise source itself.

	-hpa


