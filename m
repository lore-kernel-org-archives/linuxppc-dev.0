Return-Path: <linuxppc-dev+bounces-20130-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F258FF885D
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Apr 2026 11:55:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3Q9d4Ytfz2ygY;
	Sun, 26 Apr 2026 21:55:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777204501;
	cv=none; b=JlH1FEKn1SjOnH7QETlejZ/8HYqTeahMoH7rdrKMpXJYWBD5qyng18SZ2C3d4A1qB+eF/YLEPogNkE6NHbTQK2IvWXlfP/1U5OJLUVlnAA3/HfueGYlWAqFHr0ffYXFhe7zNXohVOClkK3aPv4jEvJlVEHNz+V1ZsMS2i5WLa4mprFLcxh2Ds4Fe+NmhXJHndM42ZVazSltPA3LL14YeDOpJOW5rtzxq4gf+cbKsMbNm+dsRVHWy9TnUOzhCQVIiopURkKTe6OpuR7HVI6qzrCtzg7YRQRhRipjWXHR1ppOmyy9z8MB9swgCgvF8kqWllxuBdJ4qRh45xP/npzdOhw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777204501; c=relaxed/relaxed;
	bh=EOUGdGocvy3Me4myqdA0xbgNTAj2NUsoVcgMrrjsU4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMNMLqkrncp4wzPki5K7NiN7pY+IQEg0n0uUVnfo1gQHAYUDrmMViA7TH0WGo7E31YVh+UKakNb9OLckTGwDcgPrFDLj05M2ouG3XECjFDQzgW0/JNwyGe0ZGFzZXS5Si3MH/06SATy+29dXQJcQMWmzM/hanyo9vHRlFeAz4hoFgXslgC+2gEoEHjazzusknmv1dC+jAOqpNLMSumbivj8iah8GlxCJFqPwZz+ChQ8ZndJRCwinvl5CAOaNxhS9kOnLN2T4HBdmKjQ7fIveKZTsrRuhtgD7PVzsMzoCpFQjzE3d4gq0/mod5DQAl94E9xGy7VHXUJJ+CyKx752VEg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CTbziF9P; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CTbziF9P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3Q9c4dbhz2ySV
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 21:54:59 +1000 (AEST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-35d971fb6f1so7449722a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 04:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777204498; x=1777809298; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EOUGdGocvy3Me4myqdA0xbgNTAj2NUsoVcgMrrjsU4E=;
        b=CTbziF9Pc9dugdq+yaMCCr81JhNZgcalOqx3g/Q1XWnEWOc4eJEkGCda59/rXaoZcN
         GaOJD97hUU3mTdRyZdWjIq+kp22bBQ+0nFHdaEgPb4qT5bVkTC32LTLAEtS1D96vGiJ1
         LG8IG2ie/3PeYlvRlp7JPzKEysNskM9Q1jkg/tkmpBCzH7UZ8c39pkHWS0pwVVpDtjF+
         0lXr0xP9OHsIow8EWiPqzS4kDZKHjJs0T5Zt8rtiGMyVc7vZty2eUF7CG2g50ozee0mH
         W1gM0cHtnnELl4yjKNvG+P/ckMj6xCg1LSubTgfw2WPtPc2dH3zP37penlUSAv4ycpag
         K5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777204498; x=1777809298;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EOUGdGocvy3Me4myqdA0xbgNTAj2NUsoVcgMrrjsU4E=;
        b=gsrkNfyDMJZeKh49xO+J6DQ568uMR5Vk4uEhsm8GYXqKduxJfHPu3ZAVDFZFLKDkVr
         tbJU7PIKoUzcyJPojACPFhm72ZdqeSBUHMA9mOCPoHLSEDcYdxwnMnBGMzayzzjMRN12
         qd+2u1x9ahPinG77l9R62/JLTTytm8ECs7KSgKL9wrx/twFJM8LP9nFNu08zy5E/NWYp
         ZVmp6dxgEyQDXMwJrygBeJmldBAnqrrLvn9OQ3evyDpYzXnfOb9MSg4pEPwT8knAF0pP
         t6zTDhIKyqHYVbtNMp4w08FZfAxB39YYoM/dXz6Yg35EhXzUz5zzsHpxn6NZRUMNirFG
         YQxQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Gjpjf1BBrqYRHlEudgwosQmmCUrBlyJIgKueZN7xcGxWqrKbxyJt71huR/sxDlcfDlN+cu0shkV76FJA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YznPCvilfpfvazYymy8Q/Io7xbupZ5LSgUJ4bB/7iFO0d8dgiHf
	AkXebnc/1lCvDiNiH8v7KvmULOJG17FOc8OV8pyYW59Cvra4SAXPdCJg
X-Gm-Gg: AeBDietxer27/J7FZ7ks9uDckN40LvpY1x6RpHkdIRN3B5vGZll2KKPJFrwH4RMMKxm
	8UNFqNt34F5EUlgx/aoG3UYqaV1pdNQB5vCFjeY+LZy+KivKo61ZxxI6biLCAx2B2lBXFq5B+5l
	nTNe8tCFkPMX69C5+0CrdW2TxigNQdxVKmlUpNChsFMRHt+L1M4qY64HAcmEKpXPlAZIwitm3Bl
	GboEWbBck3C7Sg7x9K4JRi8wJLgFO8WTwDK20/qJe7wv5cRgLgUT9hAhcPWbHzOA/bvGMQPM9oG
	pboG/kVJRd7H5H1PYYiJFZAVrMfQjzDe9HYzKSBKsIz3VeAH7Ktw99AtVN/+jEQ2IDG9LyKNMDC
	bpK4jrFtBjPpJAyXMZ1UuIyRaY6SzMWmUSSHZOjFoMTPYlNa4fBQYToFkM6dLruFX2e6rwlIPtN
	fiujMlVabMJK+7zQ8ENPm2tjsrF+fZ8AetF7IkqYjgsuhDuLfyq7+xDHUEL4ES3TuRSfk/3sCL7
	jY/dmjEUQ==
X-Received: by 2002:a05:6a20:2591:b0:39f:3ca8:a331 with SMTP id adf61e73a8af0-3a08d7372b4mr44232635637.16.1777204497670;
        Sun, 26 Apr 2026 04:54:57 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.164.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c797701d9bfsm21241887a12.16.2026.04.26.04.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 04:54:57 -0700 (PDT)
Date: Sun, 26 Apr 2026 17:24:42 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com, 
	aliceryhl@google.com, rostedt@goodmis.org, ardb@kernel.org, ojeda@kernel.org, 
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	daniel.almeida@collabora.com, fujita.tomonori@gmail.com, viresh.kumar@linaro.org, 
	prafulrai522@gmail.com, gregkh@linuxfoundation.org, arnd@arndb.de, tamird@kernel.org, 
	lyude@redhat.com, airlied@gmail.com, j@jannau.net, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, llvm@lists.linux.dev, 
	Link Mauve <linkmauve@linkmauve.fr>
Subject: Re: [PATCH V14 5/7] rust: Make __udivdi3() and __umoddi3() panic
Message-ID: <ae38Eh_HgkJR0jTo@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260426085725.2090827-1-mkchauras@gmail.com>
 <20260426085725.2090827-6-mkchauras@gmail.com>
 <20260426124921.28eb433f@pumpkin>
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
In-Reply-To: <20260426124921.28eb433f@pumpkin>

On Sun, Apr 26, 2026 at 12:49:21PM +0100, David Laight wrote:
> On Sun, 26 Apr 2026 14:27:23 +0530
> "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com> wrote:
> 
> > From: Link Mauve <linkmauve@linkmauve.fr>
> > 
> > The core crate currently depends on these two functions for i64/u64/
> > i128/u128/core::time::Duration formatting, but we shouldn’t use that in
> > the kernel so let’s panic if they are ever called.
> > 
> > This doesn’t yet fix drm_panic_qr.rs, which also uses __udivdi3 when
> > CONFIG_CC_OPTIMIZE_FOR_SIZE=y, but at least makes the rest of the kernel
> > build on PPC32.
> 
> This needs resolving properly.
> 
Hey David,

Yeah I agree, we need to find a proper fix for this. This is under my
todo list. Currently we are enabling experimental support for powerpc
and we are trying to get the basic kernel to work as of now. panicking
kernel also doesn't seems like a good idea as of now to me, we are
working towards it, we'll come up with a solution soon. Meanwhile we
want atleast the build to work.

Regards,
Mukesh
> > 
> > Signed-off-by: Link Mauve <linkmauve@linkmauve.fr>
> > Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> > ---
> >  rust/Makefile             | 4 ++++
> >  rust/compiler_builtins.rs | 6 ++++++
> >  2 files changed, 10 insertions(+)
> > 
> > diff --git a/rust/Makefile b/rust/Makefile
> > index f6369d121c50..9aa18cff2fae 100644
> > --- a/rust/Makefile
> > +++ b/rust/Makefile
> > @@ -615,6 +615,10 @@ ifneq ($(or $(CONFIG_ARM64),$(and $(CONFIG_RISCV),$(CONFIG_64BIT))),)
> >  		__ashrti3 \
> >  		__ashlti3 __lshrti3
> >  endif
> > +ifdef CONFIG_PPC32
> > +	redirect-intrinsics += \
> > +		__udivdi3 __umoddi3
> > +endif
> >  
> >  ifdef CONFIG_MODVERSIONS
> >  cmd_gendwarfksyms = $(if $(skip_gendwarfksyms),, \
> > diff --git a/rust/compiler_builtins.rs b/rust/compiler_builtins.rs
> > index dd16c1dc899c..fc6b54636dd5 100644
> > --- a/rust/compiler_builtins.rs
> > +++ b/rust/compiler_builtins.rs
> > @@ -97,5 +97,11 @@ pub extern "C" fn $ident() {
> >      __aeabi_uldivmod,
> >  });
> >  
> > +#[cfg(target_arch = "powerpc")]
> > +define_panicking_intrinsics!("`u64` division/modulo should not be used", {
> > +    __udivdi3,
> > +    __umoddi3,
> > +});
> > +
> >  // NOTE: if you are adding a new intrinsic here, you should also add it to
> >  // `redirect-intrinsics` in `rust/Makefile`.
> 

