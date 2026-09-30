Return-Path: <linuxppc-dev+bounces-28583-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B479ECA5FC5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 15:16:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvzDB380Fz2y8d;
	Thu, 01 Oct 2026 01:16:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790781418;
	cv=none; b=JkSR5A7iuifRwk0ylVoDf90XSSfzbUDb+nr0BGRT4pGKtyFR7Tt8bcMcM6O+GXH1QsPHVN1LrwWBpUsUYiZGU0Mi9Hz9GqilPmVgmpAmmSTMP8HVplex3hqLTi5becgl8jybawqzpFQZweWiLJGxQ5OjH7aYF2E0YDBCLVXJiuVhi4ql3mwT1L0BrDO119BTzXR8b+lI03Q175G1UCvBq+dYFQYF1pDMyRznB3pFFV6/FZFI1jZMMsiEU2JFJa1P+gBHQCx3B7f7j1vCrHX2eqC/WaqtL36LkVZ3Fk140satrCcP4r1yY5r0IfSYasuuLEXOIp1R8rXF3Ic+aLW06A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790781418; c=relaxed/relaxed;
	bh=3YhJg/Vg0kUrlQnIKq6WPQNTQH9OtFetyfT9AbDxDuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y4Tz90ItFIYQusMb/u2BmPgRN7aDu5+Rut+FzB8IpurhnQiK8Hxc8QCm3JcgNVQBRiosxf0kNrnGtpFhAN+cLQf2pOgY6DVfCms4KRPXtyAQXIkhLOliNYThHfwpq6ZPHq+Rz8VkyvVdXIsHqHNHHQT/lvmSQ5FoyG1X7ZIvbd2MZtodOeOO7kgZ2+6JfLGMbmBWFr/IHYjO3TQ9+VZtI/8dQdiEewWer9dmoj3m/PPVdvzFW65M+NcXbb8WJnsdRUhMASUkbrhiwkmx+iXMPjfLLM+X33a5AJIpdws6VHR/AzTDoXDJ2/LWRAOWdBJ8CXVGjeG09K91EPEZoqeVqw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=zx2c4.com; dkim=pass (1024-bit key; unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=lif9OX7R; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=srs0=+etc=hw=zx2c4.com=jason@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=zx2c4.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=lif9OX7R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=srs0=+etc=hw=zx2c4.com=jason@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvzD944ZLz2y2J
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 01:16:57 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BD8A143DD1
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 15:16:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABCB1F00899
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 15:16:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=lif9OX7R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1790781409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3YhJg/Vg0kUrlQnIKq6WPQNTQH9OtFetyfT9AbDxDuA=;
	b=lif9OX7RWafdyPA2vmfDWOKBdoGlxav5sM0R59juNsSHRGOJ3cLGwIQADccYOr0Es7uHaM
	U2JHgEuRoM4HW2gbTSyzrG61iftYLSVR+tHEfiptGXjcTCXFxk1AM8v9PuFV6tI2DiwHi2
	rpAspPBUZghSjKDFVGIGFAwuxgjbmY0=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id e53b4df8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 30 Sep 2026 15:16:49 +0000 (UTC)
Received: by mail-ej2-f19.google.com with SMTP id a640c23a62f3a-c2940ff2313so158441666b.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 08:16:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByYSfV30J0EKOAzlKvFfGcScP7Vwa4OjA6c1nJPGpqJmt1BF6maPDSJ2tFuGjSGkGVpTjlpbUQKbahaio8=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mATAqwEQfdx54I6DoAi3lTV22tWb3687cyTphemcdfk4kDsq9W
	mg+gsrXMPKqGoSBV7BW7HCHz+tVY1RIz6B3Ek+1UTKt/F9/fvLiG136bx00+yz+7imDdsXhT4Qv
	xX6LD3w+Mgoe/3iEI/8XxGBiG5pYsRcE=
X-Received: by 2002:a17:907:6095:b0:c29:c575:de84 with SMTP id
 a640c23a62f3a-c2e240ee3f5mr135965366b.8.1790781405942; Wed, 30 Sep 2026
 08:16:45 -0700 (PDT)
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
References: <CAKwvOdmuvn0LZkYEsH84hnOGTYhTtzuWs3wMARtWdTeL6dD9sA@mail.gmail.com>
 <CAKwvOdnxKVpn=nAFaqP+9PTx4PqgHsUVWv6e60Pcr29W_eZrpQ@mail.gmail.com>
 <CAKwvOdmNZL3eFvV3v77GXDzL+XLgz+BT9TA=my0yTnbsHqVeSg@mail.gmail.com>
 <areYMjNcaqe86ds4@zx2c4.com> <9d1c338b-368f-4ea2-a12e-c28d49adff5e@kernel.org>
 <are6s5e6On3hpD3M@zx2c4.com> <CAKwvOd=BrMfFT88jsvBPhh383qqk5G+J07CsofNu0MVkziyhCg@mail.gmail.com>
 <20260930133813.GA3142230@ax162> <ar0a4b9CjL2YHCkY@zx2c4.com>
 <ar0gTS71qxnx9AkW@zx2c4.com> <20260930151337.GD3142230@ax162>
In-Reply-To: <20260930151337.GD3142230@ax162>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Wed, 30 Sep 2026 17:16:34 +0200
X-Gmail-Original-Message-ID: <CAHmME9pA+AntJ6hWoFYpTVjh-NUSd0ZGXp5XiUuhQcq3HjQT3g@mail.gmail.com>
X-Gm-Features: AclHuK-3j-Oh9f_5JCjhD5NbddIhsNHXCyGk_sGVp-iO-7Ny0UWZ0eR4ti5Aiu0
Message-ID: <CAHmME9pA+AntJ6hWoFYpTVjh-NUSd0ZGXp5XiUuhQcq3HjQT3g@mail.gmail.com>
Subject: Re: [PATCH v2] random: vDSO: Avoid call to memset() when zeroing
 reserved in __cvdso_getrandom_data()
To: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 5:13=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> On Wed, Sep 30, 2026 at 04:44:29PM +0200, Jason A. Donenfeld wrote:
> > Nathan, would this be okay with you?
> > https://git.zx2c4.com/linux-rng/commit/?id=3Dd216701724b7d8209ff4215065=
8ad5c712bdb503
>
> Can you stick
>
>   Cc: stable@vger.kernel.org # v6.12+
>   Closes: https://github.com/ClangBuiltLinux/linux/issues/2183
>
> on that? Otherwise, looks good to me, that's basically what I had for my
> v3 locally.

Sure, done. Also removed the now-unused array_size.h include.

Jason

