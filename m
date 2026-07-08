Return-Path: <linuxppc-dev+bounces-23845-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F34DC44501
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 23:14:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwYp03PlLz2yd7;
	Thu, 09 Jul 2026 09:14:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783552472;
	cv=none; b=hL19Rjk0FzD8cVJ9R6jrGlvTxBlGqGMasjOcNflf2jv2i4wfjJTLygkymDnG/phhKcNVsDJFVFDnu0fnm8kVrX7hbCRiBxeCJIbGyS+VLe/X1lk+wShDICQqTvQTAVBEsJR1//oTgoN2uVKl+/NNi1StaKm4rMo9GmkRR0OJo9sQwtwKkxQ0gQCZSWFLTw8tJYRW+s67doFCLoHLe4SXsRfPwyrucvA1LlGrBDB2HPjvU2BM9dWb8Y8OU+QtvN0USERwXP6CFBW55RazP0a4Wi6vmHwOD6S3rr1T/4lhlPrk6Y4erEbbjqd4JkKqgb/0iXqfEuVTRZY/Pdo6Ro5CdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783552472; c=relaxed/relaxed;
	bh=znSNM+MGjR1fppYrLy7qoTqjpqFxQICpffN75ccsbrI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PfAMG/WJMZWM9Q+e9yuX72OqoVikxnVAEbcndY8gVrkTtyMlFVtWL7lRR4wF56YTtrvX2YVuu2l45hig/T9l/XUFyvA9nYjDZSNLg0vD+lYCjxO5UiWJ3z2U7Gy9h+Gdmv7vnyExMr7HOPVgsIGssbmqdxDeh/1opYHVNH+qkmrlf+Sc50Ok6hB2aSeWlP+Xa6MvAM1y5/3TM8XJjoX0M4JpjUkPFdSxQyuIoJ+1j8BDa28D0n2PboVDxay03holsTZ33QXuD4YJI/7xi7Qt/mSEWOd8xD/AiPwHu0hxtiTiqVAN3ghMAlnwPslGte45o8tGlnZlo0Yh1V0QGONBGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U7j9DuQ2; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U7j9DuQ2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwYnz0Y3Gz2yYs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 09:14:30 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D4A506001A;
	Wed,  8 Jul 2026 23:14:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5FD11F000E9;
	Wed,  8 Jul 2026 23:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783552467;
	bh=znSNM+MGjR1fppYrLy7qoTqjpqFxQICpffN75ccsbrI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=U7j9DuQ2nc8ydd23uGNZv2p9cQUiXygCkAVxSq71mj+NkX2cdLrmoGsFASFGg4Ml0
	 bDwc3/JpNMt1iiuBfO2+u2t8OwVWEKPRBEqFojt4WTEHrS5dyU+Rrl+iHhRZJ43XFU
	 Tp4PiEAswwCoD7KapE0e4aTY0MQO/lRQruojDYgw6tkvWRm9BrYDb1Uy0bxO7Zv6Ig
	 NQWzkZJfqj2mxHN2D5QfuxwgKNzrkIccqqWhDuluZJB6zK0q7BbhRN+Pi08TxExqdC
	 M1JIWRaFxQmoW8FElnvw5Vst8d3UaIMnUJuT2C8niIgtq2a4qubF9EJ5FQZPKi1rPF
	 fpIGbT8HGVkAQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
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
 linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org, Arnd Bergmann
 <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Will Deacon
 <will@kernel.org>, Brian Cain <bcain@kernel.org>, Michal Simek
 <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
 linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org
Subject: Re: [patch 13/18] entry: Make trace_syscall_enter() return type bool
In-Reply-To: <87se5tqkyp.ffs@fw13>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.338083894@kernel.org> <ak5ySpil83TNWxeq@kunlun.suse.cz>
 <87se5tqkyp.ffs@fw13>
Date: Thu, 09 Jul 2026 01:14:24 +0200
Message-ID: <87ik6pqdkf.ffs@fw13>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08 2026 at 22:34, Thomas Gleixner wrote:
> On Wed, Jul 08 2026 at 17:52, Michal Such=C3=A1nek wrote:
> Q: Is it perfect?
> A: No
>
> Q: Can it be made perfect?
> A: No, because you can't change history and established practice.
>
> Just for illustration. Changing the logic in trace_syscall_enter() to:
>
> --- a/kernel/entry/syscall-common.c
> +++ b/kernel/entry/syscall-common.c
> @@ -9,13 +9,15 @@
>=20=20
>  bool trace_syscall_enter(struct pt_regs *regs, long *syscall)
>  {
> +	long orig_syscall =3D *syscall;
> +
>  	trace_sys_enter(regs, *syscall);
>  	/*
>  	 * Probes or BPF hooks in the tracepoint may have changed the
>  	 * system call number. Reread it.
>  	 */
>  	*syscall =3D syscall_get_nr(current, regs);
> -	return *syscall !=3D -1L;
> +	return *syscall =3D=3D orig_syscall || *syscall !=3D -1L;
>  }
>=20=20
>  void trace_syscall_exit(struct pt_regs *regs, long ret)
>
> does not make #2 magically go away. It's still the same problem whether
> you like it or not.

And just to be entirely clear, the syscall() interface has to be correct
in the first place, but then it's all about performance.

So the sequence of:

   pt_regs =3D PUSH_REGS();
   syscall =3D pt_regs->syscall_reg;
   pt_regs->result =3D -ENOSYS;

   arch_syscall(pt_regs, syscall) {
      if (likely(syscall_enter_from_user_mode(pt_regs, &syscall) {
         if (syscall < SYSCALL_max)
            pt_regs->result =3D invoke_syscall(pt_regs, syscall);
      }
      ,,,,
   }
   pt_regs->($RETURN_VALUE) =3D pt_regs->result;
   POP_REGS();
   return;

is the correct and obviuosly most efficient way idependent of the -1L
return value overload in the original implementation, which this series
gets rid of for clarity.

If an architecture decide[sd] to do otherwise and makes up it's own rules
which only cover parts of the problem then it _is_ an architecture
problem and not something which has to be solved by claiming that every
architecture has to implement the same nonsense as you falsely claimed
in your RFC^WPOC^Whack thread:

  "However, the API should be specified in a way that does not require
   everyone implementing such flag."

There is _ZERO_ requirement for any architecture to implement that
flag. Just because S390 decided it's a brilliant idea to do so does not
make it a requirement for everyone.

No. Every other architecture got it right because they looked at the
historical patterns despite having correct documentation at hand.

Feel free to prove me wrong with actual facts.

Thanks,

        tglx

