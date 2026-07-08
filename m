Return-Path: <linuxppc-dev+bounces-23844-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF4BC44506
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 22:08:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwXKY2hwGz2xPb;
	Thu, 09 Jul 2026 08:08:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783548497;
	cv=none; b=TWSoRCS7j6vMafVOafEshnAXI03R5gqv0pV3mBZT3GwY60rGPL9Z2SlvyeT9xS0Nv+vEEsjXNFUMBsr7gID7am1IwZE2xhQ6m/gye9ULsVkwqqhX+DK93u32hrp8q0OwxTGtaU2ThzcykN+CxYFXHUDs1XoTh2nLps0qeomVGQ1JokvDamlb6LXi9MKXkRRhItrLyr0Ffu+Upac1fIlc74EXnVyyBFP6MmL5d8TtFzeaBUOnLm/ijAsdFCtQovj7AN3aw1AfZVc+B9gy/aQvPOOqXGy8p9EfiNJEFwosWfwL9XUqEDZ1977qxk6xEu/uZ7BAgPwaQWahKibqH33HqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783548497; c=relaxed/relaxed;
	bh=6Cz8BOTHw08E9NcS2yyN9pfUWQWxwh/AbZG3/5oSlNo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=apv/h2sTIfn7upCqoMrXyGhpfEmROSCQ0iFLpvmqp/LmpuHCC9blHqK9QLNuogwtk4x8jSBrHPmKOHzPFaKCNfWtuVn18NQwKPp1KB0ppbS4tnvj2JHwjuUFMUnQ9fBY5ibrOFm7tnFKbDylUyoXA+vZZ1hJWm3hQhcVw/7/e2srExlvw2XeVMinKaMlVa+xp9S88AvHaHjEQ3ZADnEymlE6ESR4VIV5/HobSXDnHZipuyES3wTKoiyeZIWgkckz5HPwhmfLxrIPp7uRrGuSvjf9vrrPgkCpfEcw79OAkUAowilArX6MS87F7G7/tvfPTiHjxu8hF6oHO6806UDNrw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FHRxCIVT; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FHRxCIVT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwXKX3y1kz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 08:08:16 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 137E040751;
	Wed,  8 Jul 2026 22:08:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A72C1F000E9;
	Wed,  8 Jul 2026 22:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783548494;
	bh=6Cz8BOTHw08E9NcS2yyN9pfUWQWxwh/AbZG3/5oSlNo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=FHRxCIVTukQAG3miFmDwBEU6I209sFjCARp6kEzFqtKLvTVeoIbUSsC2eSN9qIdnR
	 VQXn9bZShPRC0JvYyhaNRqG/HqxM+0wwkl21YMKvZbZEbwDcCKokdsns9i9ZzyHYbj
	 JPwH4nZrvGyAqtNPEHE5kgl0uyruw7Hao0EDZtv1yI13czTm2pC4iPHCUKvnl9ttoA
	 FQw80n5mm74fyWAHSi+eqhPD70ioINDjajTGwworQYlA/8+7sT+AhOFmASXWzYgLLf
	 IhREvhCoeEVhqiVsSYxwG/avxpiZWCQ9oe9o7pb6I/zkL58DG4nCbi8UNCb/vvui/f
	 nhrMJDrJBHLcg==
From: Thomas Gleixner <tglx@kernel.org>
To: Radu Rendec <radu@rendec.net>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, Huacai Chen
 <chenhuacai@kernel.org>, loongarch@lists.linux.dev, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org, Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org, x86@kernel.org, Mark Rutland
 <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, Andy
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
 linux-arch@vger.kernel.org, Michal =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 09/18] entry: Remove syscall_enter_from_user_mode()
In-Reply-To: <28fb0a8fd840bbf5223c60fea156584cb0f0f208.camel@rendec.net>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.132654198@kernel.org>
 <28fb0a8fd840bbf5223c60fea156584cb0f0f208.camel@rendec.net>
Date: Thu, 09 Jul 2026 00:08:11 +0200
Message-ID: <87mrw1qgms.ffs@fw13>
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

On Wed, Jul 08 2026 at 17:21, Radu Rendec wrote:

> On Tue, 2026-07-07 at 21:06 +0200, Thomas Gleixner wrote:
>> All architecture use either:
>>=20
>> =C2=A0=C2=A0=C2=A0 nr =3D enter_from_user_mode_randomize_stack(regs, nr);
>
> You probably mean syscall_enter_from_user_mode_randomize_stack.

Duh. I obviously got that wrong in a hurry. Thanks for pointing it out!
>> =C2=A0static __always_inline bool report_single_step(unsigned long work)
>> =C2=A0{
>> --- a/include/linux/irq-entry-common.h
>> +++ b/include/linux/irq-entry-common.h
>> @@ -49,9 +49,9 @@
>> =C2=A0 * Defaults to an empty implementation. Can be replaced by archite=
cture
>> =C2=A0 * specific code.
>> =C2=A0 *
>> - * Invoked from syscall_enter_from_user_mode() in the non-instrumentable
>> - * section. Use __always_inline so the compiler cannot push it out of l=
ine
>> - * and make it instrumentable.
>> + * Invoked from enter_from_user_mode_syscall_and_randomize_stack() in t=
he
>                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> Probably syscall_enter_from_user_mode_randomize_stack()? But the
> reality is it's only ever invoked from enter_from_user_mode(), which is
> below in the same file (include/linux/irq-entry-common.h).

Yes. Indeed.



