Return-Path: <linuxppc-dev+bounces-19387-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86927EF4EA4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2026 09:08:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fq3Qc0Jwqz2yfS;
	Mon, 06 Apr 2026 19:08:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775466503;
	cv=none; b=dJt1lIL3Slhu0VnXHMdHotZvMKf1ufl1DGOrD5diz6apUC4DwLgqeAI/lZYewVp5UpbI/XHtCXb5u014JWiDteJFZ2eonXosqiG82y0XrQXJxtJUwBw3FJjP7WiHh3sPBTggMKUG40IjBGo6J/af40sCKEdnflMMp2WFPwI1qY0VG7ITura2ieyAXeRxW5pI3I+MKsf/5NQrOx74QByLNUtN9fGmZeSp7pK3f59/sHKgX0zbMJKqbU6Eh9sbhNL+djECHQw3CN3HUVaBp6DXIa3fmo8J0jzPtq4K+5xVxTFjF3SXPRUqBjL07t49UfSjyCcceDAMOilzIKnvrkO3/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775466503; c=relaxed/relaxed;
	bh=2DC9+ivYheyMqrfOIx67QW7cPRjoGiCh9Shramalnog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HA6mR4CCf5kkXoilJLsvT58i7f/FJlG5QasyjPfzjCx2G/hdpCwWVUA5+73RIBOc1Ah7COkf5fg5E+umks9uZhWuDaybdmODMNFxXdw4xay7pEFrcC5YRZKRN40gHA6UAS26qQuybhgCBnvATWSDJbsUIzWQPOR707OjaSNyczFt7yUnq+Dilq/IHDdE3WmhwryCsofpoFRMWylHXJ6K/eD20fc8waiCFIeGq17THzv3IFSJUN19nkMCSukRxj3K9VvHQiKgPj8tbWNKK6vfjR/Fbz/DMZKa/2Ag5y9HJcx0tOFBtBhMJ4z6mut3i1xKFQD0A8CdvYcetD6snJ3rWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZlMd4qb4; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZlMd4qb4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fq3QZ3zkbz2ySV
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Apr 2026 19:08:21 +1000 (AEST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-82ce09b4197so1507226b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Apr 2026 02:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775466498; x=1776071298; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2DC9+ivYheyMqrfOIx67QW7cPRjoGiCh9Shramalnog=;
        b=ZlMd4qb4cg0SHZffMvp0TjgmowHgYdOXXQHRx9SoZxve/n2+/TKB+RLfkvbs/7n5g8
         mDIkjcw4LgVE7HwZxbdh7nDGxukbD1qmIa2SD5VBAKs4Fooysc3wGkBE8ALOo8ylZPK7
         anqRtNTxjvHaKvdgV4hD9bWheFlnd3mGnZyw7i6n7d3z9zM4mez5wY3VTL74IjqLhZiG
         O+VzmvCyBDiSjyTZKsTKTJK9QE+mMtKwRIN7yS1JtI14OXyzO+4iRn18t2kqO/ZFzZzC
         eM8xCdFDuxApJr1zUeRJTXpVkmtSRncVuBqsgn3Yy/ExVqcujQuuM2aS5ClQCxweinIk
         6vEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775466498; x=1776071298;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2DC9+ivYheyMqrfOIx67QW7cPRjoGiCh9Shramalnog=;
        b=hQXQ5W89VdY7Ul5pgQKSauE4I/UsFKxlIDXPkwwYxVxRM/rMpdshCl/Q0mQYsQVtgv
         TWgg+8tLdsyxV/S1o4mdDN2lQQUBQwljTjEuKWGkv770vUXuNkETxKVhdZEAZVXTugQw
         2dNFr0YaKlYzI8eQeV8QHRNr29aCJs933oklpOs0rMpeLzG7jl8IF1T3Iibs0XbHPmEy
         2MBHBsc4Ipe5MiDhIpOosj7uKC1Vlct0xKU1KTF+Ntdp7I5zvM80m13500QHqnR+Cp2Y
         yFavx3rIoYlBrfyhZRHPGjN9OI6oiqLVWgdhgRfO6XzQVAyrDYVs6IW2/t0gCVRU0RZ8
         OL3w==
X-Forwarded-Encrypted: i=1; AJvYcCX1NWpbuWwZ5vuFpLD1/65YYxr62mqovrDm/+oclRRJQBAZIebexScu9048FkdNZGV1FSd9BGzQZOEn7PI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxpl72NA5NriWNQgLnY1HMrOQXp/vZGUuPhSQ7PJhVm1xzlv/Il
	J0QQF1Y6Ea6RF2nTCVD1wwRgcCcMSKBBMSGguP5jYZysfmy3r8qUIvXe
X-Gm-Gg: AeBDietb/4Vdi4lnp5gRi0xea4/cphMsF+RJcgRWPODmdyCxOhbE/APxuySmEAwONoA
	Mn6wvzFEDjfI0+UXcePHEukzPFLioR2CSqMLBYUFe6ql+7cOBMX2k7t17d4JGjLR6N7bvfpcJ2+
	W1Ch2EB5F2Yzuycqa72Dvpts3k5w4wKRksFVectmITtitgWMEltyuGwRs4R/zkcKxfrKC3bscDM
	kh4vtt4CRcogqf/zsInawvEusaqrn3KZcI6LXaYzU1d0v6L4SKq1axgAMGH4HpDDcn1o4YUu0tf
	M1fAYIGXK/dlfzcI/gZ9aLgxQhq6S2vnsEo6yb1CmZGqfRU/VdZhYmI2Cr6BB8M2Sq2DrnAhT2R
	pg8DWerQWEexDGjiA1Wna/dGiguwoooOGrDezZAmIEs/9hlrxsLaKD5FmO9CbInqIMgwu46Lf/6
	dUI+2txXdUx3Z9/VDQwutCRIqYEfZiKz34CUFtLVwEXJo0rgUac0Q8Kiz0rvicYwSdl5c=
X-Received: by 2002:a05:6a00:4649:b0:82c:ddbb:7db3 with SMTP id d2e1a72fcca58-82d0da8bc37mr11678758b3a.25.1775466498220;
        Mon, 06 Apr 2026 02:08:18 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9cf065asm12787649b3a.8.2026.04.06.02.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 02:08:17 -0700 (PDT)
Date: Mon, 6 Apr 2026 14:38:06 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com, 
	aliceryhl@google.com, rostedt@goodmis.org, ardb@kernel.org, ojeda@kernel.org, 
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Subject: Re: [PATCH V9 1/4] rust: Fix "multiple candidates for rmeta
 dependency core" error
Message-ID: <adNuUxsGl_Tm4Nd7@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260404121610.1956528-1-mkchauras@gmail.com>
 <20260404121610.1956528-2-mkchauras@gmail.com>
 <CANiq72k1KN68wG_dh0GcTyfiXUyrVUErJ5D8AOaV6z6=sX4BAg@mail.gmail.com>
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
In-Reply-To: <CANiq72k1KN68wG_dh0GcTyfiXUyrVUErJ5D8AOaV6z6=sX4BAg@mail.gmail.com>

On Sat, Apr 04, 2026 at 11:04:08PM +0200, Miguel Ojeda wrote:
> On Sat, Apr 4, 2026 at 2:16 PM Mukesh Kumar Chaurasiya (IBM)
> <mkchauras@gmail.com> wrote:
> >
> > When building Rust code with LLVM=1 with -j1, rustc was encountering
> > an error:
> > "multiple candidates for `rmeta` dependency `core` found", with two
> > candidates:
> > 1. The host's standard library from the rustup toolchain
> > 2. The kernel's custom libcore.rmeta in the rust/ directory
> 
> Please clarify in what conditions this happens, e.g. when building
> natively in an architecture like powerpc for which the target (...)
> 
> Otherwise, it sounds like this is something that would be happening to
> essentially everyone just by building with `-j1`, which is not the
> case.
> 
> Also, since you may need to reword a bit, please take the chance to
> use the present tense to describe the current state, and then the
> imperative for what is changed. (The past is usually used for
> something that already changed in the past, not for something that
> still happens before the patch is applied -- I hope that makes sense).
> 
Yeah this makes sense. Will reword the whole thing and send out a new
revision.

> > - Update rustdoc-pin_init to use explicit --extern paths for proc macros
> >   as pin-init also needs alloc crate from -L$(objtree)/rust. So the proc
> >   macros needs an absolute path
> 
> As Gary mentioned, this list may be too exhaustive, i.e. one needs to
> see it in the diff anyway. Usually what we do is try to summarize, and
> most importantly, explain the "why".
> 
> Also, it doesn't seem like the list covers every change anyway if that
> was the intention, e.g. the removal of `--out-dir`.
>
Ohk, will rewrite this part also.

> > -rustdoc-quote: private rustc_target_flags = $(quote-flags)
> > +rustdoc-quote: private rustc_target_flags = $(quote-flags) \
> > +    --extern proc_macro2
> 
> Hmm... why is this needed? The variable already carries the flag, no?
> 
Oh yeah. Will fix this.
> > -               --out-dir $(objtree)/$(obj) -L$(objtree)/$(obj) \
> 
> This looks like an important removal that is not explained/mentioned elsewhere.
> 
Ohk, will explain this in commit message.

> Also, is there a reason why we cannot keep the `-L` here instead of
> adding it in every proc macro library?
> 
Will move the `-L` here instead of each lib.
> > +    --extern pin_init_internal=$(abspath $(objtree)/$(obj)/$(libpin_init_internal_name)) \
> > +    --extern macros=$(abspath $(objtree)/$(obj)/$(libmacros_name)) \
> > +    $(call cfgs-to-flags,$(pin_init-cfgs)) \
> 
> Hmm... This special handling isn't great, and the fact that it means
> hardcoding/duplicating `pin_init-flags`.
> 
> Should we move the proc macros too?
> 
Let me find a cleaner way to do this. Will do something about this in
next revision.

> > -               --crate-type proc-macro -L$(objtree)/$(obj) \
> > +               --crate-type proc-macro \
> > +               -L$(objtree)/$(obj)/host \
> 
> Spurious newline added?
> 
Will remove this.

> > -               @$(objtree)/include/generated/rustc_cfg $<
> > +               @$(objtree)/include/generated/rustc_cfg \
> > +               $(rustc_target_flags) \
> > +               $<
> 
> Why is the variable moved here?
> 
Will fix this too.

> Thanks!
> 
> Cheers,
> Miguel

Thanks for the detailed review.

Regards,
Mukesh

