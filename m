Return-Path: <linuxppc-dev+bounces-23862-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F00EAC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 23:38:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwZKK55Hyz3c2l;
	Thu, 09 Jul 2026 09:38:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=80.86.107.70
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783535862;
	cv=none; b=mCsCcM/boZ3Ed8VRqyzIjA67tdWR8d4vsNpEkzhhbSz1xGLe1KtU5EjI5k790ZKK6oj6aVqzQlvBqWd83AqXEB/DzEE3iO6Ew1zk9dXVjmbjn6K/gTJyhL+v0B+9w8wkqhqWd6mK5ajrBxmwE/O9jQDIehrOxMZMczB4mOM4yyNT2AcI+tF90m5byIMZNx0NPq6tMuB9ilG7zgZY2MWyoHosllNZCTL7PJLLPZd85XXMMQ1dEK6N9h33kQSf4+abqvnOVck8xxBMWkgjgQ+/HOAztDQynm3IrkwjUcWtuHZzEOHUFQ/5bERre/kaSVLFnzqGjqO7SFIb/XX06y7Pow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783535862; c=relaxed/relaxed;
	bh=J8eh6Rp71aMkUZPGbdf4HwpQyZ/mRcCB+VtPzFZfm0s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JiMywFMlJmAHhK1kx/Nsa0b7g6L0BQvcPO/7c5NCE5qOAE2f8fLVgKJtcpO4TZI9rJHGUQaxRLsjujIGhjtTs+Hy1MyRH1Laf3S3Ju33/Dngw+ZVd4vROOXS2b4uMaw4k6NE4zAGc4EqJtqeaYutK2H4ToMRt0eZBA0DGoR4flnYFcx+zdtJ2qx7/pqq2Udx79psr0jdy6hSsLCkwoXyuekOffMtO8knh1fWG4D27tSIRiCkoqGIGLQCS6Bm/jy01A7ufb2SJmTvtHPXjyIIew4Id1d6n9goIrpURR5xSE4c4FGoo2Ho+tNxTKEXcBeC83pFc6RaERyVJ31nkoPuPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=rendec.net; dkim=pass (2048-bit key; unprotected) header.d=rendec.net header.i=@rendec.net header.a=rsa-sha256 header.s=default header.b=MYg2quQs; dkim-atps=neutral; spf=pass (client-ip=80.86.107.70; helo=mail.mindbit.ro; envelope-from=radu@rendec.net; receiver=lists.ozlabs.org) smtp.mailfrom=rendec.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=rendec.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=rendec.net header.i=@rendec.net header.a=rsa-sha256 header.s=default header.b=MYg2quQs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=rendec.net (client-ip=80.86.107.70; helo=mail.mindbit.ro; envelope-from=radu@rendec.net; receiver=lists.ozlabs.org)
Received: from mail.mindbit.ro (xs1.mindbit.ro [80.86.107.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwRfZ25p5z2xWY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 04:37:42 +1000 (AEST)
Received: from bat.kanata.rendec.net (unknown [24.114.111.125])
	by mail.mindbit.ro (Postfix) with ESMTPSA id BD677C343E;
	Wed,  8 Jul 2026 21:37:17 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.mindbit.ro BD677C343E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rendec.net;
	s=default; t=1783535859;
	bh=J8eh6Rp71aMkUZPGbdf4HwpQyZ/mRcCB+VtPzFZfm0s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=MYg2quQsJUR7e8ayAFMJcRvjHsrwKzUQqkhrJdU4nanpzL1jX14m8Z+Ds91DdqoKn
	 QJReaLyNa/iLaBx/8t9LaIJgpO/V9u0Qk+ctVFHOLXc1PsNN77To6wbQLDR/wbO2Jd
	 LI7Oyckd8G3uDywiL3AEPP+/6veZtLhQL8vDm8MBdhsqbXlk1PXB64z0Yki4BQsRic
	 1MYR+Jrgudnmn+eQyNCJp23VAJq+mVC5zubA5AQHg1rSP6wds0PtsFuUt0GISnCwHY
	 EbF0YrfTMJrddRnwe6si6lyEajabery7sEfS+bc1aT49zcfePemMerT/qsFH4wmqB6
	 HEkaGc5AmP+eg==
Message-ID: <335387752ace30084a3f709acf34556443300d1f.camel@rendec.net>
Subject: Re: [patch 04/18] loongarch/syscall: Use
 syscall_enter_from_user_mode_randomize_stack()
From: Radu Rendec <radu@rendec.net>
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Huacai Chen
 <chenhuacai@kernel.org>, 	loongarch@lists.linux.dev, Michael Ellerman
 <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>,  Paul Walmsley	
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
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
Date: Wed, 08 Jul 2026 14:37:13 -0400
In-Reply-To: <20260707190253.865955911@kernel.org>
References: <20260707181957.433213175@kernel.org>
	 <20260707190253.865955911@kernel.org>
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
> syscall_enter_from_user_mode_randomize_stack() replaces
> syscall_enter_from_user_mode() and the subsequent invocation of
> add_random_kstack_offset().
>=20
> The advantage is that it applies the stack randomization right after
> enter_from_user_mode() and thereby avoids the overhead of get/put_cpu_var=
()
> as that code is invoked with interrupts disabled.
>=20
> No functional change.
>=20
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: loongarch@lists.linux.dev
> ---
> =C2=A0arch/loongarch/kernel/syscall.c |=C2=A0=C2=A0=C2=A0 5 +----
> =C2=A01 file changed, 1 insertion(+), 4 deletions(-)
>=20
> --- a/arch/loongarch/kernel/syscall.c
> +++ b/arch/loongarch/kernel/syscall.c
> @@ -11,7 +11,6 @@
> =C2=A0#include <linux/linkage.h>
> =C2=A0#include <linux/nospec.h>
> =C2=A0#include <linux/objtool.h>
> -#include <linux/randomize_kstack.h>
> =C2=A0#include <linux/syscalls.h>
> =C2=A0#include <linux/unistd.h>
> =C2=A0
> @@ -70,9 +69,7 @@ void noinstr __no_stack_protector do_sys
> =C2=A0	regs->orig_a0 =3D regs->regs[4];
> =C2=A0	regs->regs[4] =3D -ENOSYS;
> =C2=A0
> -	nr =3D syscall_enter_from_user_mode(regs, nr);
> -
> -	add_random_kstack_offset();
> +	nr =3D syscall_enter_from_user_mode_randomize_stack(regs, nr);
> =C2=A0
> =C2=A0	if (nr < NR_syscalls) {
> =C2=A0		syscall_fn =3D sys_call_table[array_index_nospec(nr, NR_syscalls)=
];

Reviewed-by: Radu Rendec <radu@rendec.net>

