Return-Path: <linuxppc-dev+bounces-23857-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E6FEC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 23:35:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwZGk007zz2yd7;
	Thu, 09 Jul 2026 09:35:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=80.86.107.70
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783531513;
	cv=none; b=khlgko9grYRjZ1PeEAbpxViZGt/FUxZ4wbluqXyFK9dprTX001mydl8syWIe3CTVTO6BouB8wmAcG2aMu5aYCqpHTZ2tCg304Vha/g0/2t/Xk2XenGCXTpOuqFK+cxlzt3w61PCaUVe2DIIkhmV+N3Kn4RtxdGZudJT0VR0+22DWVdJBwYwS6mizrjTITJmRFBoK+OH047e8g+NGlntUWx8aoZq7wk5uiIJ1LA+R4+TfHlwwj6mP4RLq28lOeox3iWpkVEKs0c+kq0nnoISdNXaPtZKXkByOTKPREFlMTenKHujZc/F7ocPo9Ff16EYyhyZkBah0JPQGSeahZbuhVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783531513; c=relaxed/relaxed;
	bh=oMlf4rzg7sFMgtBO8f/rqo4QHF22NzBws1cUSUO+r80=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HUYFW8LemYZsoH/4VY9aSJx4WtVSQXU24xIPrJlyRiu+xfDO++AdAOYRgOhqOarMMWdIl7U0fpOrlPr17rnYIS5zHnJYRI9EeAQNP8HPM6WEU7zey/NzcOH9fQErIV7LWHPk9RYjKKBc3HdfcDt0OYOD6bmHQmgu/eRovj3/CZplw+BolQpsNk7a/PpkIAfJpPmqiHeEXT8CuDlHQAGmktgxMuTR6LeZ7oHOnHAtacn+pXV2P3QpdZeUhpnaR10oCxSj0gFzkn5qGvPzJHxXpDSaCdA9F/Kkj5PnM3Y5CFcWA8Dbxk5tnMB9KNRcTJMBK9aF7GUet+sxf/e3W94GYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=rendec.net; dkim=pass (2048-bit key; unprotected) header.d=rendec.net header.i=@rendec.net header.a=rsa-sha256 header.s=default header.b=OJuzJLG2; dkim-atps=neutral; spf=pass (client-ip=80.86.107.70; helo=mail.mindbit.ro; envelope-from=radu@rendec.net; receiver=lists.ozlabs.org) smtp.mailfrom=rendec.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=rendec.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=rendec.net header.i=@rendec.net header.a=rsa-sha256 header.s=default header.b=OJuzJLG2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=rendec.net (client-ip=80.86.107.70; helo=mail.mindbit.ro; envelope-from=radu@rendec.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 87 seconds by postgrey-1.37 at boromir; Thu, 09 Jul 2026 03:25:10 AEST
Received: from mail.mindbit.ro (xs1.mindbit.ro [80.86.107.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwQ2t2Y54z2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 03:25:10 +1000 (AEST)
Received: from bat.kanata.rendec.net (unknown [24.114.111.125])
	by mail.mindbit.ro (Postfix) with ESMTPSA id 1E89DC2B1F;
	Wed,  8 Jul 2026 20:24:38 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.mindbit.ro 1E89DC2B1F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rendec.net;
	s=default; t=1783531507;
	bh=oMlf4rzg7sFMgtBO8f/rqo4QHF22NzBws1cUSUO+r80=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=OJuzJLG2oJHC8E6/z6u4YL1brifg3n0KypZd9zeBUsdEd6uLxd+9vUKIXm8fNb+sD
	 40TB/onHyQSWEZ0oPdpje/xAjGna37MjawhgGr3bVxva9cjLjk1XfUhqToNdmtUx7z
	 YMvmViVzUq9/FTET4wtq/Yhx/L0ZlUxPuNUXmfoDanL5GBZtufQoF3ZbsskDV434aw
	 kxDRuhqvAGGem4j2hDVIoI59nXr2IxQ3aAqoNF0TEbKK88RSrx6CqBol40sxnwMfxK
	 rd7e4S6y5Zb6OYXlWmLIfxqvBAfINm0f8D7u03YVplchQ7tuJ84O05FoHalkh1Nik9
	 f0YRdybiCZuUQ==
Message-ID: <db4b8c27df9be997f935928f2624a863a1f998d6.camel@rendec.net>
Subject: Re: [patch 02/18] randomize_kstack: Provide
 add_random_kstack_offset_irqsoff()
From: Radu Rendec <radu@rendec.net>
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, 
 Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde
 <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,  Huacai Chen
 <chenhuacai@kernel.org>, loongarch@lists.linux.dev, Paul Walmsley
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
Date: Wed, 08 Jul 2026 13:24:33 -0400
In-Reply-To: <20260707190253.768842729@kernel.org>
References: <20260707181957.433213175@kernel.org>
	 <20260707190253.768842729@kernel.org>
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
> add_random_kstack_offset() uses get/put_cpu_var() which is pointless
> overhead when it is invoked from low level entry code with interrupts
> disabled.
>=20
> Provide a irqsoff() variant, which avoids that.
>=20
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Kees Cook <kees@kernel.org>
> ---
> =C2=A0include/linux/randomize_kstack.h |=C2=A0=C2=A0 19 +++++++++++++++++=
++
> =C2=A01 file changed, 19 insertions(+)
>=20
> --- a/include/linux/randomize_kstack.h
> +++ b/include/linux/randomize_kstack.h
> @@ -77,8 +77,27 @@ static __always_inline u32 get_kstack_of
> =C2=A0	}								\
> =C2=A0} while (0)
> =C2=A0
> +/**
> + * add_random_kstack_offset_irqsoff - Increase stack utilization by a ra=
ndom offset.
> + *
> + * This should be used in the syscall entry path after user registers ha=
ve been
> + * stored to the stack. Interrupts must be still disabled.
> + */
> +#define add_random_kstack_offset_irqsoff()					\
> +do {										\
> +	lockdep_assert_irqs_disabled();						\
> +	if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,		\
> +				&randomize_kstack_offset)) {			\
> +		u32 offset =3D prandom_u32_state(raw_cpu_ptr(&kstack_rnd_state));	\
> +		u8 *ptr =3D __kstack_alloca(KSTACK_OFFSET_MAX(offset));		\
> +		/* Keep allocation even after "ptr" loses scope. */		\
> +		asm volatile("" :: "r"(ptr) : "memory");			\
> +	}									\
> +} while (0)
> +
> =C2=A0#else /* CONFIG_RANDOMIZE_KSTACK_OFFSET */
> =C2=A0#define add_random_kstack_offset()		do { } while (0)
> +#define add_random_kstack_offset_irqsoff()	do { } while (0)
> =C2=A0#endif /* CONFIG_RANDOMIZE_KSTACK_OFFSET */
> =C2=A0
> =C2=A0#endif

Reviewed-by: Radu Rendec <radu@rendec.net>

