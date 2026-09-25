Return-Path: <linuxppc-dev+bounces-28254-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF50FC9832A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 22:19:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hs4r63nfbz2yD8;
	Sat, 26 Sep 2026 08:19:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790374774;
	cv=none; b=lqklUdVxqQde+KsnNydgZ4n0SMDabffCii6ed3sGq2DnVD7rsfGx2hiqvPIKODL5ESFpE/S0BCTFywg8N7fWMF/BO8lytftaKV/4J80QWiVvkDE0FwL2wVMgPWLrb/QZt0d4IUkrf7MqN2SBFMDhpJ3mFVmi2wf/7R5lNq7OTxMSvwgT2wZtFxBNDfqIoqFhKQxQleI32lR9LlQOFz3i38GBaDLQzR34VWOytkW6PRy5NYNCWK4tFR4J83+t+sPMgRnIHmtzM2DCcaiJOY3NR/WZjseaoD8RruVBcjlo6+wA6mBfSCATHT7bmIX63VrYGKB0+7Lqsman5CVAZUPh/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790374774; c=relaxed/relaxed;
	bh=Ub6l+gGnhbpnVJSf1sECQFZws1/JGSNU3EBgSX0gJT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYFfqbCy9Ai0aC/X2Z/NVvBr7ZpbCAeb5XpPmU22vERkx6PirlRgh9mpu2TG//fDfmxcQPI/EBJPmn0Suz/mdNQl5tkpADljfrTAYcztbe+7d3gPhWvmL0kqQ4OGKH12Ksjs7cJVKeEIV2dmUfgQHM8+7vfoBo7T/s1u/lHgkH2ieL/hLasXqzpCfezMRE2qKv1FgrjEqcHPHWYb7aHieIpXGPVnqsoz0euQUtIq7t5jBVq3CUPPzojxIw17+MVwiq/HawsSiuMiB5sJ024y5bAC5sjyKBoV/JKHI0XfpCP4Onab5D1Juu+3Dd/xm15DndZLbhC1CUNoaPb8C/pxNw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PQxXz8Bq; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PQxXz8Bq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hs4r54FdPz2y7p
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 08:19:33 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A6E9D60136;
	Fri, 25 Sep 2026 22:19:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBFD91F00893;
	Fri, 25 Sep 2026 22:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790374770;
	bh=Ub6l+gGnhbpnVJSf1sECQFZws1/JGSNU3EBgSX0gJT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PQxXz8Bqrp5fZyfGD0+JAGV/Kt9gf1keLvC0fg5oDg0FbTEbVJGuxWGMfLX4a64tp
	 AWVr2a0nGnUzgI0wEPXnVpyWA2bs9xiS75lcfbRaZsj6SsbeBpDWwM2a1brofqNtc/
	 PMVzMywMMPqnL/kNGdSX9F63rKLKf3sNQoadBGdYyIoJVHaFD9o2FxX3/eeZttbdAW
	 inqLQvas8M54Ltq6wI4sRbZF3B+T/RIAJD3NcO6l0rUleguc0EzcHCV7vzFkNvo/WV
	 yh0CnZKvY/rQthUclqO6rQJbXjy8+yJDamlNxOKl56QmZxkkB7YCoqP8hpwRiy5WMz
	 6mMauv2SHxwSg==
Date: Fri, 25 Sep 2026 23:19:21 +0100
From: Nathan Chancellor <nathan@kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v2] random: vDSO: Avoid call to memset() when zeroing
 reserved in __cvdso_getrandom_data()
Message-ID: <20260925221921.GA2296912@ax162>
References: <20260925-vdso-getrandom-avoid-memset-llvm-24-v2-1-ce640f872393@kernel.org>
 <CAKwvOdmuvn0LZkYEsH84hnOGTYhTtzuWs3wMARtWdTeL6dD9sA@mail.gmail.com>
 <CAKwvOdnxKVpn=nAFaqP+9PTx4PqgHsUVWv6e60Pcr29W_eZrpQ@mail.gmail.com>
 <CAKwvOdmNZL3eFvV3v77GXDzL+XLgz+BT9TA=my0yTnbsHqVeSg@mail.gmail.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmNZL3eFvV3v77GXDzL+XLgz+BT9TA=my0yTnbsHqVeSg@mail.gmail.com>

On Fri, Sep 25, 2026 at 03:00:46PM -0700, Nick Desaulniers wrote:
> > > > +static inline void *memset_inline(void *dst, int value, size_t size)
> > > > +{
> > > > +       char *d = dst;
> > > > +
> > > > +       while (size--)
> > > > +               *d++ = value;
> > > > +
> > > > +       return d;
> > > > +}
> > >
> > > Does this work?
> > > https://godbolt.org/z/Tx6EaGMfb
> >
> > Hmmm...possibly.
> > https://godbolt.org/z/ec9rzd9Yf
> > I don't get it...
> 
> Just keep it under 2 pages, it will be fine:
> https://godbolt.org/z/qqoMqfxev

Yeah, it might be worth a comment that this is only safe for small
values of size so it should not be blindly copied elsewhere (although I
guess if it is, the outlined version exists in the majority of other
places).

-- 
Cheers,
Nathan

