Return-Path: <linuxppc-dev+bounces-23864-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCDAC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 23:40:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwZMl52qfz3c54;
	Thu, 09 Jul 2026 09:40:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=80.86.107.70
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783544299;
	cv=none; b=Zpe7YEgPkv+jAHYbusuI1kLOhbCnNiMRo+STdVF+CmXBRSmisQFC/PBuGMzkNI2ozTo6HN0B9847bGKdKbjy+HJKtAEcPlq/foJSvrhvk9VMceWH1uOIes+rI2mfKV/nTDpYXFOlbo7FE0c67oY2wtXNwX/7MjzQpNwcDLmG3pg4gb/qzaA4ar3KJ46O3vfZyGxFCf+dwDodeqDprdoEFqKBgh7Hod/seqpDDkOk0ubkLW3AtLeuOzDPF+Edofxc5QXYk/zQ9CVwMOUL+5lb0ZFBmUMMQZY/VVCLkKXM7GORPyKiRYTYb95+bLgxbB/4lT3ssR6DW70RuYbUGhmexQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783544299; c=relaxed/relaxed;
	bh=hJBHj3v5/Gy9cfslRHy86J9BqBTgDtn5Jmjc8wTF3Qk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M7hh8U8WwZoireMa0DqkJY5ms3UcP8CLb68L42hTSR25weExzMAa74TiHdqW1bzJWpt2RswfUugNNPrYRqAf9WojIuBmUsSwGlU+5zMlQSp2duAPrpbDolnXPL4Mour+BEWKhAECfAmqYnKrpSoOk5tOkpbzYfgZx+IFrM0pDrtzSfz4qbCWzxiKEMR/Ahw27VztYzt8WL8deF7ggx70Wze5Zh5NkxUh6loiXUkOdip2EQeshTdLeWo7dpjSS6mtq8/9jq2UGWjw0gSh1nQOjEFF1XUXpsjDSO7Q+Gcr+lWjka0UeCRZiwtFMSARaS4u3y/cDPq1zEm0/6xC8GL9zg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=rendec.net; dkim=pass (2048-bit key; unprotected) header.d=rendec.net header.i=@rendec.net header.a=rsa-sha256 header.s=default header.b=ASe5j6xg; dkim-atps=neutral; spf=pass (client-ip=80.86.107.70; helo=mail.mindbit.ro; envelope-from=radu@rendec.net; receiver=lists.ozlabs.org) smtp.mailfrom=rendec.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=rendec.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=rendec.net header.i=@rendec.net header.a=rsa-sha256 header.s=default header.b=ASe5j6xg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=rendec.net (client-ip=80.86.107.70; helo=mail.mindbit.ro; envelope-from=radu@rendec.net; receiver=lists.ozlabs.org)
Received: from mail.mindbit.ro (xs1.mindbit.ro [80.86.107.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwVmp3q8qz2y7r
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 06:58:18 +1000 (AEST)
Received: from bat.kanata.rendec.net (unknown [24.114.111.125])
	by mail.mindbit.ro (Postfix) with ESMTPSA id 16270C3449;
	Wed,  8 Jul 2026 23:57:54 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.mindbit.ro 16270C3449
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rendec.net;
	s=default; t=1783544296;
	bh=hJBHj3v5/Gy9cfslRHy86J9BqBTgDtn5Jmjc8wTF3Qk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ASe5j6xgqpQoGzd8fN2p0AV5mCM1uJJHCeUg2Rlxt6R3B/rFXg4YDm9qyballB0nF
	 MeA/AN3+LNtRqPRnWZ4RGvlOENBWHlzAAxkuy1RqiTPYNETGIv1etVCKTLohwMPCoB
	 NT/6RCbGnbqh9lOdElft3AHTFq8jVQMEygtI/j0tzDA/4gvnPpYZvymBxJHR3zU5cs
	 Ryz4Il9J/Fs/gye2m6KRNK1BfV12o1cIIRYuxI4bkUCt9PsJIjMYawd5vkU/JPUcgj
	 eyZA8hvZdnwNhc4mJqzKcQusbBCBJYXxbEKsRMMMd2jYEyC+qotSrdgXnQbdMbEvhN
	 tyu/tFqF5098Q==
Message-ID: <c765cd31891e0c222cb78697e55c4caa6dd0bded.camel@rendec.net>
Subject: Re: [patch 07/18] s390/syscall: Use
 enter_from_user_mode_randomize_stack()
From: Radu Rendec <radu@rendec.net>
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Sven Schnelle
 <svens@linux.ibm.com>, 	linux-s390@vger.kernel.org, Michael Ellerman
 <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>,  Huacai Chen
 <chenhuacai@kernel.org>, loongarch@lists.linux.dev, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org, x86@kernel.org, Mark Rutland	
 <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, Andy
 Lutomirski	 <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Richard
 Henderson	 <richard.henderson@linaro.org>, Russell King
 <linux@armlinux.org.uk>,  Catalin Marinas <catalin.marinas@arm.com>, Guo
 Ren <guoren@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,  Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Helge Deller <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,  Richard Weinberger	
 <richard@nod.at>, Chris Zankel <chris@zankel.net>, 
	linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org, 
	linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-um@lists.infradead.org, Arnd Bergmann	
 <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Will Deacon
 <will@kernel.org>,  Brian Cain <bcain@kernel.org>, Michal Simek
 <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,  "David S. Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 linux-snps-arc@lists.infradead.org, 	linux-hexagon@vger.kernel.org,
 linux-openrisc@vger.kernel.org, 	sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, Michal =?ISO-8859-1?Q?Such=E1nek?=	
 <msuchanek@suse.de>, Jonathan Corbet <corbet@lwn.net>, 
	linux-doc@vger.kernel.org
Date: Wed, 08 Jul 2026 16:57:51 -0400
In-Reply-To: <20260707190254.030598804@kernel.org>
References: <20260707181957.433213175@kernel.org>
	 <20260707190254.030598804@kernel.org>
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
> enter_from_user_mode_randomize_stack() replaces enter_from_user_mode() an=
d
> the subsequent invocation of add_random_kstack_offset_irqsoff().
>=20
> As a bonus this avoids the overhead of get/put_cpu_var() in
> add_random_kstack_offset().
>=20
> No functional change.
>=20
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> ---
> =C2=A0arch/s390/kernel/syscall.c |=C2=A0=C2=A0=C2=A0 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> --- a/arch/s390/kernel/syscall.c
> +++ b/arch/s390/kernel/syscall.c
> @@ -97,8 +97,8 @@ void noinstr __do_syscall(struct pt_regs
> =C2=A0{
> =C2=A0	unsigned long nr;
> =C2=A0
> -	enter_from_user_mode(regs);
> -	add_random_kstack_offset();
> +	enter_from_user_mode_randomize_stack(regs);
> +
> =C2=A0	regs->psw =3D get_lowcore()->svc_old_psw;
> =C2=A0	regs->int_code =3D get_lowcore()->svc_int_code;
> =C2=A0	update_timer_sys();

Reviewed-by: Radu Rendec <radu@rendec.net>

