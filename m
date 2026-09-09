Return-Path: <linuxppc-dev+bounces-27003-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6D9C79FB9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 19:38:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgB1f4c61z3000;
	Thu, 10 Sep 2026 05:38:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:39::10" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788982710;
	cv=pass; b=GxRzJ/RFrjavDUY66Y1p5Re+QC9JuxuVA4vaqHKSVH19dIB2qqIHUmFV0M4p9cc087j7pQFrMfvt1tMOhnsPohFrHk2sC37suLY9Ye7LW3N0ZQINCehl6yVS77EzSdN3F09tud4OGaThIMLaH+9pMxeDplI+qcSqClDt73+k0BcuWWKmzsUPei4pa2jSnG+1k0F5MOieX1kjZxd5teNRGf+wsJx6dFtH3E6axCYgp1BKunKimun5EgGs8lC3V2oVHk1Y3D2esRIVflBfdY2aajVcc5H6KHALJHmYBn1ZDhroGlcRJy7EQ7GH2sVpCqJMXNvViTCWpzIeG/BIezU4DQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788982710; c=relaxed/relaxed;
	bh=1ydOjuoTgA1JS+qa07cHIVSm0i9RHzfwwnuAwNBt4m4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DFOLY0bi7tn1NjJ1Ki0lG4S/AYrVrAYYa5CBYtTIFlKO026tIT6k6wAtbZB9RFDYnpQtXoEI2o5ThYyWJR9KUe8H5kBOfCYSIK3ZjGmDy5qW9KUQ0QRfH5SX6hhP9umGQ7c3Blqa8emCEt04c2vh1wsrcCE2O5zWvGR9H7+tNj71UZuY8u/AbHmIgskIFG603f8Z2CqH37RSMIrtarDnod7lwLStw7HvplvPEDFprfZNLAVWV38npu5ne+vrEaeQTgXQcv6k/yJkoRRUzIaL8sgdX47/LlxIC5gUSU760qFvhYObjZj2FKIXZzBjS9kQY+UW6AkSB6UCWZ0jcr30+w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MYATLZgA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MYATLZgA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com [IPv6:2607:f8b0:4864:39::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hgB1d1l0Sz2yys
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 05:38:28 +1000 (AEST)
Received: by mail-pj2-x10.google.com with SMTP id 98e67ed59e1d1-39666bed442so1074846a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 12:38:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788982705; cv=none;
        d=google.com; s=arc-20260327;
        b=KbIRNY0LqUd9Q5YmIAZld+hAlcKyS/dv74gcSjggotHDWvTTT0zuLXFj6sS8mmg6vA
         H2xyUB+Adfish4gArVakstdYecHGDoGFVWiT3GI6hubug+R0MD7+U0zV5Jf1RYJsRalF
         GuEuC3H8HRi4Ij6Qgs84A7OyRuAWHr2pqzq7Yshjy9RVsY6kebvYmD9+YhrlU4f58qRR
         +4bIy/VcVMBVT4brtUWMS9P47wvkTOB3fvnHp+7ud5xOsx5JFENuTXhHLMSGsER6B0b0
         u0T+ndBdVLLLspHAu5qWYqwiydq5foWI8JlN9+n7KKBoD1rdUpjU36WsNyQaw0h/Pp39
         Avmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1ydOjuoTgA1JS+qa07cHIVSm0i9RHzfwwnuAwNBt4m4=;
        fh=wIj4BuBvp5Ztk1dhH1eaqKJlOhJl3WjIoPMS8s57kdk=;
        b=k7VQ8C8a9dDi/BpSVYCmCMGdmLua4SZw924RsOqQwM3B/KUPuqeDrsmBPBIHetZVgX
         yo7jY1cQQftrGr9E0d7K4OLpXIXBQaMYYwu/WqvTlsWxryMZAoFcRfTSddKqMGWwkCnA
         YNRJfSvwTvTbBWVArj5Cv1EoxRRECG/jePfnqRmTiW+9UjFT2lOiopteyKSq/aJWectJ
         U+zhRqxXPU7FiaNL048C7jDckk9ckVKuJEW0Azw5beA6KXESJeM2suIT5//o2Ao2gpIj
         O12eXyAy4iEYEiP8T/cycLuWxfl/zsaTgPJZE/JYfq6Jl9zcl59GcwhID92GJux6SNP/
         NGKA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788982705; x=1789587505; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1ydOjuoTgA1JS+qa07cHIVSm0i9RHzfwwnuAwNBt4m4=;
        b=MYATLZgA6aIEb4uGGfnRHAZGjKdnpGJboE2GLfeji6/ZNgZbIiv4B4vIwjVYps7opX
         3qQyqVr4RdwKjb1tor8YxB2xZje0NAsnaI4V1GKTkE7YzR3tElmppHdkw8VjScuwdL2w
         3WAHDTHoa850PAHIBDB/IKLHj6dGFX5V3+eRMsl+6ZsvsNiYCtFNQL/ALIUTooiIihK1
         xjefJipASe/dDerfi93VLnrH3QSQziqFabz7qcHizsRTQNmE9bTmzRsUAzQcjIveKoB9
         45HqDqBPbnjGoTfOi/MlspYDSVQFIadMNhlkDuhtnNZAJB2cLY+MUgClk/T4Rc/2oIAh
         3D9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788982705; x=1789587505;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1ydOjuoTgA1JS+qa07cHIVSm0i9RHzfwwnuAwNBt4m4=;
        b=d+7Nv81Y/Km5BNBSg5VCMDkpaS8W5t22JyUpEjs3qWGJlpTGqJDVJG1nf31kTn0HtA
         8mA8CIQ2/CKab17P/TuZAuy3PbRvBmwOxQJhLGbLgYYahkqHVAFgF0Qa8P5q7w5+AB69
         vkuhWvdMK9Z6JI0jfR+ilAvt3CEvOAOty8fWiYrcwGXmmZy+IIMBuHbLXv6/Cw6js52X
         ZxydPO8dJsPPhpmIfl0SDn65MhptErAHB5cyhKKCxP09QpkgObFwnw5B6m8kZ28FVg96
         OJEfdqyFIXBD8NnWLlGWsxTUCOO8oXmguRAUGrduq0HrYlsvLIOl3YPu+vU/PYj3x07g
         xhtw==
X-Forwarded-Encrypted: i=1; AKwUvBzOT8UD1p/ZPvzOkO0gPm8hHYhN6+HMoDF3TDpqfLhHtgzBRoHzv5cK9zpGfUoqnp8J+DoWITCi1FCjzko=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mdMxah/ffn3ii/LRlHLFZKqq/4wWMVkeg25YFUejhVJMpGHaDg
	27DSjexUlBwIJsx73ar/PSN4UrGuf+siwvGa44zPaqPf87w2NbNqWdyVuB9QEStaCAxhgorMFNH
	XcFLm0w2YDglPPbdSGxNgNNvJ6AspdBs=
X-Gm-Gg: AYBFou3QRPoDGJ0zyeXsjdfJhOdkP4qiBsgZmaWU5zMNWsAt6kyCXnOyslt69lm1w0/
	ME2WkJYEh8xM8+lFgViFVg5shqH/3tlyuuHpyiui7cGx8siPIuzkiu5nfuJ+0ZCdg+luBjykOSL
	RH4t5F8w1HKHa9cptCVpXMTuRoXnerOpMGPKw6B2CNo9wpj2roLXP+CR/QRtO6ShfSYNcCm0grj
	KJpR8ZChHg/8so8nmTAy038tGcDYn15fDG6HQurPPEsegMl58gQvK1B+7vvDKcJ7FBSX6QSixVo
	qPzlT2yRNBtOdGNra69yT4vBe9RZhScN5H58MI/8GjCoO9T4jvEtxt9mGnkaZPfihTN2SF3pWUU
	AaBtOf3/rGdie1EbpmRVigfgk/5WMSm0VmEtfXsMiRqgtaHDmK5Kb9GFgG/NLpsPmS+86rkfTzT
	/IfqnjHpagH1H0b16vFP6rehWERCkbEKfcFQUq3O0NwmdCu7IiZpk=
X-Received: by 2002:a17:90b:3fcc:b0:39b:3505:c72f with SMTP id
 98e67ed59e1d1-39d77b83048mr824934a91.6.1788982705356; Wed, 09 Sep 2026
 12:38:25 -0700 (PDT)
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
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-12-3a93791af1cf@linutronix.de>
 <20260908071911.GU4120091@noisy.programming.kicks-ass.net> <ABBC0C50-847F-406A-B426-55D0C2BE15EA@zytor.com>
In-Reply-To: <ABBC0C50-847F-406A-B426-55D0C2BE15EA@zytor.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 9 Sep 2026 21:38:11 +0200
X-Gm-Features: AcwNN1V9A4D3jn7pum7crGv8bcA9jfLyy60O95H9hOe-jZGhQ7AzCwKSAv7z5Dg
Message-ID: <CANiq72=T1487Y7TpAa4c2eTJFMLHoe5Qc7+tRkbkmvrDjfmuvw@mail.gmail.com>
Subject: Re: [PATCH v5 12/24] vdso: Add the vdsocheck tool
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Andy Lutomirski <luto@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Kees Cook <kees@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Christophe Leroy <chleroy@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Nicolas Schier <nsc@kernel.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, linux-mm@kvack.org, 
	linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
	linux-s390@vger.kernel.org, linux-mips@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Jan Stancek <jstancek@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 9:33=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wrote=
:
>
> It was going to happen, and now we'll have to suffer the instability of r=
ust...

What instability?

Cheers,
Miguel

