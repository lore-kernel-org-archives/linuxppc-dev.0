Return-Path: <linuxppc-dev+bounces-28635-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91B4CA5FA5
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 09:25:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwRNZ4MdVz2yTQ;
	Thu, 01 Oct 2026 19:25:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790846750;
	cv=none; b=JRWbmXXbl5Jd1wcEd9j8u3xVj7d9qqnUGm4x+fS9tTClkgpJIYRKm0aCrHDuGMtGKyvYfU9ZQFgmE9PfTNSdbSk8uNi1wi5vlPDuoMX4kn1KrY887FsbJpWHq3+oKvLKG9tgtSxfxJctH/dNzeYHtSwf1tjNa/wZnLvWo1LB1SeuBWKFZQOdPlVxeOA/SwjapGBzfvRGbNvBnk7MYDAZ+kaziEM015X7r+epengV7//K5vR1xklZuM04anOHODRLRcOWZ4ly+8+9OFRT8I6Ox5LHE/u0+/yT8eWJ46gEBjgfjdNlIfq2hnCZ0/rEdPx3d7MYR0AW3GiyaFyhenT3Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790846750; c=relaxed/relaxed;
	bh=dRiq/gc/1/v3q1z4vqQ1Z479kjp0uI+oeZqHFxoYK3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdBMeRLE8tuEZRrqpYOA3eDPWec0711wSXP8wfVonnsrlGZatsuchXRlV5euozW6SMNuHVEhvjEE1P9rb/25kudikTY2fI8Gi7ftTJL0ff35lFkTMghslbxHsmYStcioFVcCwlI5AAZiV9g44e1ZrMKLkfFlp18xCA4U4J/47PgzDwfK4CKXEgokcaf+R4OJMLLhL186PqG/l1Lvk+HTY0iRnFQBS1No5LNoJ+6RBP57cSAVT4Q6I4W0nJFU+zMZpYVR/946a5yd91ZRTvRylKAMTnMdGmqDy6bkg1HkCSP0sFKgFzF/BZ6Olgy4zRS0RliQhmG/HPjx3o+yFpErpw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=zx2c4.com; dkim=pass (1024-bit key; unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=WWTEvHs+; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=srs0=73p4=hx=zx2c4.com=jason@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=zx2c4.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=WWTEvHs+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=srs0=73p4=hx=zx2c4.com=jason@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwRNW614nz2y2Z
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 19:25:47 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6B4876022B;
	Thu,  1 Oct 2026 09:25:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC6E1F000FF;
	Thu,  1 Oct 2026 09:25:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=WWTEvHs+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1790846740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dRiq/gc/1/v3q1z4vqQ1Z479kjp0uI+oeZqHFxoYK3k=;
	b=WWTEvHs+Glx9cwBY3B1J4eFsMVayAa8DZTePcEN0LwV8619xjbZb+A3Te+DbQ8bzZJ95Rl
	nakLPPxk3P6NpEgkw8BAvLRde47zWZGiGtwlUURKwXZEieW6g5dYOrgW3q1U+6OPmcgwQQ
	/6QP7vXzfWvWvdrBScZiV3GjkkHM4XE=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id d847d3a4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Oct 2026 09:25:39 +0000 (UTC)
Date: Thu, 1 Oct 2026 11:25:35 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
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
Message-ID: <ar4nD8aRH7wEvTMt@zx2c4.com>
References: <areYMjNcaqe86ds4@zx2c4.com>
 <9d1c338b-368f-4ea2-a12e-c28d49adff5e@kernel.org>
 <are6s5e6On3hpD3M@zx2c4.com>
 <CAKwvOd=BrMfFT88jsvBPhh383qqk5G+J07CsofNu0MVkziyhCg@mail.gmail.com>
 <20260930133813.GA3142230@ax162>
 <ar0a4b9CjL2YHCkY@zx2c4.com>
 <ar0gTS71qxnx9AkW@zx2c4.com>
 <20260930151337.GD3142230@ax162>
 <CAHmME9pA+AntJ6hWoFYpTVjh-NUSd0ZGXp5XiUuhQcq3HjQT3g@mail.gmail.com>
 <ede392d7-3104-4a0f-9fa1-99b22552dcd6@kernel.org>
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
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ede392d7-3104-4a0f-9fa1-99b22552dcd6@kernel.org>

On Thu, Oct 01, 2026 at 06:41:20AM +0200, Christophe Leroy (CS GROUP) wrote:
> Hi,
> 
> Le 30/09/2026 à 17:16, Jason A. Donenfeld a écrit :
> > On Wed, Sep 30, 2026 at 5:13 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >>
> >> On Wed, Sep 30, 2026 at 04:44:29PM +0200, Jason A. Donenfeld wrote:
> >>> Nathan, would this be okay with you?
> >>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.zx2c4.com%2Flinux-rng%2Fcommit%2F%3Fid%3Dd216701724b7d8209ff42150658ad5c712bdb503&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C8f69935bffb344bf0ddc08df1f05e358%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639263782324080837%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=BA7Fyr0%2FynggvBnR%2FpiCvNCQHtNBagqvSb0i11AvoLU%3D&reserved=0
> >>
> >> Can you stick
> >>
> >>    Cc: stable@vger.kernel.org # v6.12+
> >>    Closes: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FClangBuiltLinux%2Flinux%2Fissues%2F2183&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C8f69935bffb344bf0ddc08df1f05e358%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639263782324110679%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=6C8%2FAEQoh%2B8pfgfYQkL7qf5Ue%2F5sAGtfqRptzsSG0CM%3D&reserved=0
> >>
> >> on that? Otherwise, looks good to me, that's basically what I had for my
> >> v3 locally.
> > 
> > Sure, done. Also removed the now-unused array_size.h include.
> 
> I'm still very sceptic with this patch. You are degrading the behaviour 
> with GCC for a problem with CLANG. Why ?
> 
> Before the patch, with both GCC 13 and GCC 16 on powerpc32 I get a 
> pretty standard optimised loop that clears words 4 by 4 (with auto 
> increment of pointer) which is the most optimal on powerpc:
> 
>   3f0:	39 00 00 0c 	li      r8,12
>   3f4:	35 08 ff fc 	addic.  r8,r8,-4
>   3f8:	91 49 00 04 	stw     r10,4(r9)
>   3fc:	91 49 00 08 	stw     r10,8(r9)
>   400:	91 49 00 0c 	stw     r10,12(r9)
>   404:	95 49 00 10 	stwu    r10,16(r9)
>   408:	40 82 ff ec 	bne     3f4 <__c_kernel_getrandom+0x3f4>
> 
> With the patch,
> 
> With GCC 13 I get a very suboptimal loop copying bytes one by one
> 
>   3d8:	39 40 00 34 	li      r10,52
> ...
>   3e4:	39 20 00 00 	li      r9,0
>   3e8:	7d 49 03 a6 	mtctr   r10
>   3ec:	9d 3e 00 01 	stbu    r9,1(r30)
>   3f0:	42 00 ff fc 	bdnz    3ec <__c_kernel_getrandom+0x3ec>
> 
> With GCC 16 I get something a bit better but not as good as before, it 
> is a loop clearing words only one by one and incrementing pointer with 
> an additional insn instead of using auto-increment instruction stwu.
> 
>   3e0:	39 40 00 0d 	li      r10,13
> ...
>   3f0:	7d 49 03 a6 	mtctr   r10
>   3f4:	91 3f 00 00 	stw     r9,0(r31)
>   3f8:	3b ff 00 04 	addi    r31,r31,4
>   3fc:	42 00 ff f8 	bdnz    3f4 <__c_kernel_getrandom+0x3f4>
> 
> Please restrict the patch to clang builds.

Darn. Yea. The naive memset kills optimizations.

Okay, new strategy:

- on clang, pass `-mllvm -max-store-memset=4294967295`
- on gcc, pass `-finline-stringops=memset`

And keep the same code. (Or, better, see if those options generate good
code with b7bad082e113640fc81200ff869e5c2d7a9c29a2 reverted; I would
prefer that simpler initializer.)

Nathan, do these work?

Jason

