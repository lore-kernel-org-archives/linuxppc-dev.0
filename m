Return-Path: <linuxppc-dev+bounces-23867-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514EDC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 23:41:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwZNy0WyDz3c9y;
	Thu, 09 Jul 2026 09:41:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=80.86.107.70
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783546823;
	cv=none; b=K8zvP86VN1I19aN/0Nyus2uoNeiTEjYuqcNoWb0H33nt4mxSwQQA1ThVC5rSTGQvsHNrSS0+pk+leEZDIak/vToskYhoqgO43pSzO59KdAU0u6kMRsSnfLCU1ml28y4Ud2PMIYdl8v1aeD2T/HE//8Go+8HFpPZZ4KUrFu5PW72gFD7SkIYpx6dC+1pQalXAWvA7UVPU4518Vue1AXcs/4qBWoIPa8w2lRYzBG55heR4+dLC1ml5y9V23rOIxzQEgssWPPIzOnFaSD+jZkosctwwutR6o4y02T/3sLvaYuXXPRdl3xVfvNzypvzz8N6ipjiYFPLNRtQNCsO0Cj1fnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783546823; c=relaxed/relaxed;
	bh=vh8LzxdSEB6LZ5YWToq98HafI55oS8+SMbKFy7UAtCc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PlmtNeikKR89tB7qucCxzs0ItWEgOf9Mju+QzHhjFrvGlIamCg5A5NnUFkU9XhXVltJZvOF6gjPHoAmCvEGi5ypchI2BnPr421AMaXNFbm6X8yQzDA4hdofB1dGEQBrYaNJo+tjA6qTtA4bFr2d+zUZbfjUkyUZM0yE10tVadVXeU4IUqxIofkM7ggV51HQ8PIN0bAjYclfAKUD6Wk8zIeZqNwr2efvbCHux/jVS9ltJqxwrghVKKvgSWV60U18cIUbNIoD98OD4khixHeU/9O99Wo+ligWINLSsz77fbWCqNkRYevbOGG+/tGuPJbrSS0e+UuqMO/rclabFMY9c5Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=rendec.net; dkim=pass (2048-bit key; unprotected) header.d=rendec.net header.i=@rendec.net header.a=rsa-sha256 header.s=default header.b=Vxaj5QTr; dkim-atps=neutral; spf=pass (client-ip=80.86.107.70; helo=mail.mindbit.ro; envelope-from=radu@rendec.net; receiver=lists.ozlabs.org) smtp.mailfrom=rendec.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=rendec.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=rendec.net header.i=@rendec.net header.a=rsa-sha256 header.s=default header.b=Vxaj5QTr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=rendec.net (client-ip=80.86.107.70; helo=mail.mindbit.ro; envelope-from=radu@rendec.net; receiver=lists.ozlabs.org)
Received: from mail.mindbit.ro (xs1.mindbit.ro [80.86.107.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwWjL42Xnz2yd7
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 07:40:22 +1000 (AEST)
Received: from bat.kanata.rendec.net (unknown [24.114.111.125])
	by mail.mindbit.ro (Postfix) with ESMTPSA id 362D5C2A88;
	Thu,  9 Jul 2026 00:39:55 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.mindbit.ro 362D5C2A88
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rendec.net;
	s=default; t=1783546818;
	bh=vh8LzxdSEB6LZ5YWToq98HafI55oS8+SMbKFy7UAtCc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Vxaj5QTrZmnMb8kgo0DAnYKLpgF1VNrrEnZhf9ONVOiUDzl0XehMr6So/mzP7wSyL
	 f/bqBaPzsa1UU5XOryNPd/7wb5rGQ7IwzXh6waI3HHJA4HLb35t2X+7MMwejCU49/V
	 wyf2N0EPqZ3qOvz85kyJv8Z4VVG4eamp/AsyfiC+iferCPdwrWRhhI2Gihi8EYWMG6
	 w9oTc7WxIT/1nxUO9bTb5BDnYHc4NJdQoeD9M4hXia3YTHnUvNPgR3MY/vwUlZnDJN
	 KsGLwDIHTElRb68oeRo724l+p50zYouaHMInNxEVvF4Rx2YclHGHsHkUSx9MW9gMJA
	 BLbx/jCYTxmsw==
Message-ID: <0f3a6ccaadc1d330215416d9cec13263d71b685e.camel@rendec.net>
Subject: Re: [patch 10/18] entry: Use syscall number instead of rereading it
From: Radu Rendec <radu@rendec.net>
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Michael Ellerman
 <mpe@ellerman.id.au>,  Shrikanth Hegde <sshegde@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, Huacai Chen	
 <chenhuacai@kernel.org>, loongarch@lists.linux.dev, Paul Walmsley
 <pjw@kernel.org>,  Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org, Sven Schnelle <svens@linux.ibm.com>, 
	linux-s390@vger.kernel.org, x86@kernel.org, Mark Rutland
 <mark.rutland@arm.com>,  Jinjie Ruan <ruanjinjie@huawei.com>, Andy
 Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas	 <catalin.marinas@arm.com>, Guo
 Ren <guoren@kernel.org>, Geert Uytterhoeven	 <geert@linux-m68k.org>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>,  Helge Deller	 <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger
 <richard@nod.at>, Chris Zankel <chris@zankel.net>,
 linux-arm-kernel@lists.infradead.org, 	linux-alpha@vger.kernel.org,
 linux-csky@vger.kernel.org, 	linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, 	linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org, 	linux-um@lists.infradead.org, Arnd Bergmann
 <arnd@arndb.de>, Vineet Gupta	 <vgupta@kernel.org>, Will Deacon
 <will@kernel.org>, Brian Cain <bcain@kernel.org>,  Michal Simek
 <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, "David S. Miller"
 <davem@davemloft.net>,  Andreas Larsson <andreas@gaisler.com>,
 linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-arch@vger.kernel.org, Michal =?ISO-8859-1?Q?Such=E1nek?=	
 <msuchanek@suse.de>, Jonathan Corbet <corbet@lwn.net>, 
	linux-doc@vger.kernel.org
Date: Wed, 08 Jul 2026 17:39:50 -0400
In-Reply-To: <20260707190254.181086755@kernel.org>
References: <20260707181957.433213175@kernel.org>
	 <20260707190254.181086755@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
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

On Tue, 2026-07-07 at 21:06 +0200, Thomas Gleixner wrote:
> rseq_syscall_enter_work() is invoked before the syscall number can be
> modified. So there is no point in rereading it from pt_regs.
>=20
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
> =C2=A0include/linux/entry-common.h |=C2=A0=C2=A0=C2=A0 9 +++++----
> =C2=A01 file changed, 5 insertions(+), 4 deletions(-)
>=20
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -70,9 +70,10 @@ static inline void syscall_enter_audit(s
> =C2=A0	}
> =C2=A0}
> =C2=A0
> -static __always_inline long syscall_trace_enter(struct pt_regs *regs, un=
signed long work)
> +static __always_inline long syscall_trace_enter(struct pt_regs *regs, un=
signed long work,
> +						long syscall)
> =C2=A0{
> -	long syscall, ret =3D 0;
> +	long ret =3D 0;
> =C2=A0
> =C2=A0	/*
> =C2=A0	 * Handle Syscall User Dispatch.=C2=A0 This must comes first, sinc=
e
> @@ -90,7 +91,7 @@ static __always_inline long syscall_trac
> =C2=A0	 * through hrtimer_interrupt().
> =C2=A0	 */
> =C2=A0	if (work & SYSCALL_WORK_SYSCALL_RSEQ_SLICE)
> -		rseq_syscall_enter_work(syscall_get_nr(current, regs));
> +		rseq_syscall_enter_work(syscall);
> =C2=A0
> =C2=A0	/* Handle ptrace */
> =C2=A0	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)=
) {
> @@ -145,7 +146,7 @@ static __always_inline long syscall_ente
> =C2=A0	unsigned long work =3D READ_ONCE(current_thread_info()->syscall_wo=
rk);
> =C2=A0
> =C2=A0	if (work & SYSCALL_WORK_ENTER)
> -		syscall =3D syscall_trace_enter(regs, work);
> +		syscall =3D syscall_trace_enter(regs, work, syscall);
> =C2=A0
> =C2=A0	return syscall;
> =C2=A0}

Reviewed-by: Radu Rendec <radu@rendec.net>

