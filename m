Return-Path: <linuxppc-dev+bounces-24150-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F32B3C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 22:20:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzcMs6Rnsz2xWY;
	Tue, 14 Jul 2026 08:20:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783981257;
	cv=none; b=JB/RsDa7t9cO+pRalzdpgAbaRsgHfDw+DgRP9IkBW4UZUuXvqyyg6fC4rb5xUY4/k31lUfhVLWDCGAi+gQhX8rAqAzeShntnR786HUezlnrmjmbKKlVIbDdeO/jj8TbXz4xXhS3DzgB0LlFHKkeWGTmCXiQp6BL6alRzIPgtjz54tvcFFHxOXyhImb0AK6NsAY5ZfFi6h510tzrEA0GTb5D8BXadFd/tcZS1M+x6jtCJzkX3OilGVrzf6OFRpls/ZQsOF2J6d9ErLVjKgYI5QzHR3GeJUdxSjMeFTyVEyVGQZdOrnwwOOStp+cVAzZyfKViXIslP1jAqqv6YD4E1ug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783981257; c=relaxed/relaxed;
	bh=w3UBKxF49r1FocG/e6uCyLxV81MIS/cKXMKj7GFa2dY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WdDBYta8sh+Z6VC87Qy/Bfj9jmDikIJJTDI6rSY3TY0DrBPbY4dlxIluhAR5aqlWFWcEt8VlhnzNAtj3VdyGClktrN2VVhe5hCHwNHnZKnKNyrFHFOnO0y55rZPLipjl77BYlAgEkg/RBpeIXXU+1Jn04uEqvq+e9mkTwl+gBdm8Uf4DEV9H/v28GQu0AY6nStmHIskcMd97bX6Z1LkAJx58wJej+F3287oKG81IediTgf7Tf9KU+1WYMimca/kLtotq9SMGRFJgFfEL5jnbHFV5obctbfoHF1+fGpSjnOV5YKCg2AcB6gXL5FzniZqVjx2u++WRdziObTlA+NtcjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MpMCkP0Q; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MpMCkP0Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzcMr45y5z2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 08:20:56 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8B6D060103;
	Mon, 13 Jul 2026 22:20:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AFF31F000E9;
	Mon, 13 Jul 2026 22:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783981253;
	bh=w3UBKxF49r1FocG/e6uCyLxV81MIS/cKXMKj7GFa2dY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=MpMCkP0Q6zqib0sjSPapvsNNpIi4SuIbRx2KpQXXh5WymOk/U9BYtzwUFKFSDJeFr
	 cs5Si8k2Jro4QstLfelU9720P5WxeuRbAnaxnadJdzaNvoaow0D7p7lmUZbQ5oMrrN
	 3o5UyHWDonKsgHBAuyv9ZXOcFD4wg3E4vkt4dz4QCFld69S4V95QQDPnbS7bjngziq
	 2jPG3bUh3nPhORy/xTSX0II1pDeNiDEJxCtsVmFL58A3GaH2iLUQD/2RQGNNGo+4RY
	 8iH8Ua+ASe9SPzJRnmuCPKTYmEYeFYtAmbx6vPkwBxZlSMFDBbTa0wDk4N8IQubbaz
	 LFd4xigUG0cCA==
From: Thomas Gleixner <tglx@kernel.org>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, Sven Schnelle
 <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>,
 Magnus Lindholm <linmag7@gmail.com>, "Mukesh Kumar Chaurasiya (IBM)"
 <mkchauras@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Radu Rendec
 <radu@rendec.net>
Subject: Re: [patch 4/4] entry, treewide: Make
 syscall_enter_from_user_mode[_work]() indicate syscall execution
In-Reply-To: <alSlg72c8xmjaj48@kunlun.suse.cz>
References: <20260712134433.549076055@kernel.org>
 <20260712141346.772209074@kernel.org> <alSlg72c8xmjaj48@kunlun.suse.cz>
Date: Tue, 14 Jul 2026 00:20:49 +0200
Message-ID: <871pd6r0ou.ffs@fw13>
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

On Mon, Jul 13 2026 at 10:44, Michal Such=C3=A1nek wrote:
> On Sun, Jul 12, 2026 at 11:25:32PM +0200, Thomas Gleixner wrote:
>> The return values of syscall_enter_from_user_mode[_work]() are
>> non-intuitive. Both functions return the syscall number which should be
>> invoked by the architecture specific syscall entry code. The returned
>> number can be:
>>=20
>>   - the unmodified syscall number which was handed in by the caller
>>=20
>>   - a modified syscall number (ptrace, seccomp, trace/probe/bpf)
>>=20
>> That has an additional twist. If the return value is -1L then the caller=
 is
>> not allowed to modify the return value as that indicates that the modify=
ing
>> entity requests to abort the syscall and set the return value already. T=
hat
>> can obviously not be differentiated from a syscall which handed in -1 as
>> syscall number.
>>=20
>> The most trivial way to deal with that is:
>>=20
>>     set_return_value(regs, -ENOSYS);
>>     nr =3D syscall_enter_from_user_mode(regs, nr);
>>     if (valid(nr))
>>     	handle_syscall(regs, nr);
>>=20
>> That's what LOONGARCH, RISCV, and X86 do. But PowerPC and S390 do not
>> preset the return value, so when user space hands in -1 and there is
>> nothing setting the return value in the entry work code, then the syscall
>> is skipped but the return value is whatever random data has been in the
>> return value register.
>
> The reason why PowerPC and S390 do not preset the return value is that
> the return value uses the same register as the syscall number. There are
> apparently other architectures on which the return value overlaps with
> the arguments which also do not preset the return value for that reason.
> If they would use the generic entry the same problem would arise.

That's an implementation choice of PPC/S390 as I explained before, which
could trivially be solved by having an explicit pt_regs->return_val
member,

>> Change the return values of syscall_enter_from_user_mode[_work]() to
>> boolean and return false, when either ptrace or seccomp request to skip =
the
>
> There is a difference between seccomp and ptrace.
>
> When seccomp indicates to skip the syscall it has also set the syscall
> return value.
>
> However, when the syscall number is -1 and the return value is not
> preset that does not indicate anything.

I agree it's an invalid syscall, but the current generic entry code made
the rightful assumption that returning -1L as the syscall number either
results in -ENOSYS or in the value which was set by one of the entry
mechanisms as that code originated from the x86 implementation.

It's not the fault of that code that PPC and S390 converted their stuff
over without paying attention to that detail.

> The return value can still hold garbage. ptrace does not have the
> ability to indicate that a syscall is to be skipped, at least on the
> entry trace. It needs to be skipped based on the syscall number being
> invalid.

That's what I explained you before and you told me I'm all wrong.

But that's moot as this latest version does not care anymore. The
architectures whixh preset the return value are correct under all
circumstances and PPC/S390 can keep their own world view.

Thanks,

        tglx

