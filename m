Return-Path: <linuxppc-dev+bounces-23859-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E90E0C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 23:36:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwZHF4mXSz3brP;
	Thu, 09 Jul 2026 09:36:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=80.86.107.70
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783531781;
	cv=none; b=iMFiuP2ED7dpD46Mu8zJoMZuF75UfyZh6IWSzVNxGzlFPO0J3AAggNVuGLXgVlB7+lCHe/Q2E/5feFVWA5PnytyRnu3Cw3GCmI4rHmAK53101R2MPCC+WUwNYYoIk8cRD94tywU/so3LrkplBHblbsgVlDjJ3yf7WoczX/GGGhGsJVS9XyrXrI0GSpSHsYa49me2ydIOfTGFNqjuD6mVa2pkUOhFnJOlZGTqdGXmoR+EE5S/xXL0wysDa+7HiPCK+0iPc81M4FALoEX2++MH3+fvRUGX7YW/dIfs04O6HhXeWuI2za7RcUNE5Rp69MYXh25nZhUDmpMg9Dhg3043+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783531781; c=relaxed/relaxed;
	bh=Z81AqF8sZ0HbKd4OyTLskHjABuyT0Tc0putXPru6w9M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X9DXrj6x/x3bYSQ+MCJ/AijKX/QJYpTKLraQjICfyFWK1aNZuFeur8y+VN6aN1tjC15t2Taczcr/NtdAEEt/pIUCePtEOzthHRJiIN+BGUoWEr+nNpFuYKwtZzG75FZiEVrPHs1X+h6tO2MPU4alN7PcXsun+8NWJv/rKQBhTRmK45SXL5iDeCH0h2vKOW4Mr5lMsUFqOVy1kkd1WvtbPV0JRI9Dy4XmSFVDatc8L/DalJrUZbT7P3cIdXvvDZw7/JtTIkL4K2YZNjg3Wq2bAgrq4YQMyHacZXt0HaIg8ekfcZZoKSX+ZTBp6UEsG+NDQeYOmr4wDc0qiTYlxA6UgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=rendec.net; dkim=pass (2048-bit key; unprotected) header.d=rendec.net header.i=@rendec.net header.a=rsa-sha256 header.s=default header.b=MwinUj84; dkim-atps=neutral; spf=pass (client-ip=80.86.107.70; helo=mail.mindbit.ro; envelope-from=radu@rendec.net; receiver=lists.ozlabs.org) smtp.mailfrom=rendec.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=rendec.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=rendec.net header.i=@rendec.net header.a=rsa-sha256 header.s=default header.b=MwinUj84;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=rendec.net (client-ip=80.86.107.70; helo=mail.mindbit.ro; envelope-from=radu@rendec.net; receiver=lists.ozlabs.org)
Received: from mail.mindbit.ro (xs1.mindbit.ro [80.86.107.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwQ846rbsz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 03:29:40 +1000 (AEST)
Received: from bat.kanata.rendec.net (unknown [24.114.111.125])
	by mail.mindbit.ro (Postfix) with ESMTPSA id C6722C2A01;
	Wed,  8 Jul 2026 20:23:07 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.mindbit.ro C6722C2A01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rendec.net;
	s=default; t=1783531415;
	bh=Z81AqF8sZ0HbKd4OyTLskHjABuyT0Tc0putXPru6w9M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=MwinUj84iH00nexlmnhmDgR8X+WQik+DrvADedzcPZ9CeQY6xX1Fx3GoyEAx9wrw+
	 Qdscs2HlxOLAQsUWmM9C8f5DrkHkoVgKYwJs+XQ2tFPd5t4en+6vUqgSLYxSBdIwBj
	 555LvdKRH7m1aCTa5jMD6siDGQdvrKp961ZSe90G1chGvdgdtY0LoAvKa+i9v8wU5c
	 bWRF7OLablSVqprq4HLnjHYPD0Doh6wC1fnDaN+ZveYxw8RUEs8Ut6dFJfZDIKl5We
	 w78c65fWXzE8Q1+/ZRaJSLn4ncOl+TKAdXUve5QtEGG7DQ85WMF0AHi0oAnduE4Xgt
	 l68qBKty9jNkA==
Message-ID: <4614d1281cace737e3e117bd7242253475a30f58.camel@rendec.net>
Subject: Re: [patch 01/18] powerpc: Move stack randomization after
 syscall_enter_from_user_mode()
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
Date: Wed, 08 Jul 2026 13:22:58 -0400
In-Reply-To: <20260707190253.718191130@kernel.org>
References: <20260707181957.433213175@kernel.org>
	 <20260707190253.718191130@kernel.org>
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

On Tue, 2026-07-07 at 21:05 +0200, Thomas Gleixner wrote:
> add_random_kstack_offset() is invoked before syscall_enter_from_user_mode=
()
> establishes state. That's wrong because add_random_kstack_offset() calls
> into instrumentable code.
>=20
> Move it after syscall_enter_from_user_mode() to ensure that state is
> correctly established.
>=20
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
> =C2=A0arch/powerpc/kernel/syscall.c |=C2=A0=C2=A0=C2=A0 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> --- a/arch/powerpc/kernel/syscall.c
> +++ b/arch/powerpc/kernel/syscall.c
> @@ -19,8 +19,8 @@ notrace long system_call_exception(struc
> =C2=A0	long ret;
> =C2=A0	syscall_fn f;
> =C2=A0
> -	add_random_kstack_offset();
> =C2=A0	r0 =3D syscall_enter_from_user_mode(regs, r0);
> +	add_random_kstack_offset();
> =C2=A0
> =C2=A0	if (unlikely(r0 >=3D NR_syscalls)) {
> =C2=A0		if (unlikely(trap_is_unsupported_scv(regs))) {

Reviewed-by: Radu Rendec <radu@rendec.net>

