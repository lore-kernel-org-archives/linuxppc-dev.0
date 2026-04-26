Return-Path: <linuxppc-dev+bounces-20103-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544A4FF885C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Apr 2026 07:52:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3Jp43y9zz2yhP;
	Sun, 26 Apr 2026 17:52:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777189964;
	cv=none; b=EIjoO5jb1XKdZrwsa349pDeR7cSS85oibBuhNBAfmkPiwuJABdGIUB8qCD6p+0rt4O2eGEsO1npYVHw5wpxhiRhMc2PoslLdTBP7SAX/JLfeNI5yxpY97ajhQRXR5/NJjV/R665SNsKJgo3Z4XUVpct9L1DQNyyJLEBrqD04GapR8riHmEjfYmoHueO4gge5zIbh+uPQYPrAzNg/jo66NJcTSE52ySZymusqUUJ5HWDVMjyvla82s44UUC2jph6x6nS8LABYTV1N5bozvghIvu4WNvYamP2wohk7OWInNC93X9Fpi8vM2eYQCtVHwGNL0HqAAX3k/YILP6k3MdXjMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777189964; c=relaxed/relaxed;
	bh=8zTG+Dw6oqSR8kg/1RMP0Ayk7RcQFqZXb8XQS8VS+9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GILAR+A20XcEe//vClnPm5OLVcSAjQN1apwZKXBT9vH231u8b63jjzGUKX97+vK/TciD/yz2oL7vz0NE1cAzvKo2206t1CZDxJxTx8fgU+AsC+i3UWsFdHmq0syJ+5DKYyg8PyBjz9t9CpO2C2o8QGVkAE8YGSK7FhHJiHMEM37FiPtokp2K2LwAI4PbR7Cvl+2arcf0eBIrdNl4Olni9PSEJILTzCcKICLd6YFfBlv4hf50GdjwUqJ/hyWsm91OKl0pzBmwc7sJLhVXw1IWqNFkUc5CG1xepe6UPlWHkY9ZmcGF19vGgG1HtGh2fcxL7jqq+WoYqJ2m/J9lVLijIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UyGaxm7y; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UyGaxm7y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3Jp26YlSz2xfX
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 17:52:41 +1000 (AEST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-35f9ab079bdso6102101a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 00:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777189959; x=1777794759; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8zTG+Dw6oqSR8kg/1RMP0Ayk7RcQFqZXb8XQS8VS+9A=;
        b=UyGaxm7ycvT1hp2qCFeAdgdEZEkSQ4wVOSqKmY3dZZrnbtKcmB8wj7rswiYtYrSOh8
         fjUFSK3vohjWCVVsTBK0MCx0+KJ1bWnp2/2dzr7UlQBluYzn0T9IFBN8zTSDWpUTQr2e
         Ki1wbVcL1SUp6T+gCDoCtfVGWj6j5eDkm5BfSMYFX2lWFZLlvBo4u7Tu/gO1DoOmH7Fd
         77pYkF3F97s3RRTMdP3dcsfCgFMyWgKm1a+eOW2YIVFAuCm+Il8Bl9dYac115WFocOL2
         85bcBrU5rsuKWSpSLdtng6N+DNufNs4w28lgX8rhhSptLbtH1R+Mq2Fea7gZx12mrExo
         D52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777189959; x=1777794759;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8zTG+Dw6oqSR8kg/1RMP0Ayk7RcQFqZXb8XQS8VS+9A=;
        b=XqCcwNcMOd13yAmcmXGrc9ohJUBFKjvYGgNT3UjXEBEv+NObnG+X12P7jh/f2C3klu
         07mT+bsGwwqK5mynupe7AN7EfAV7/t/OKyuPajtLW36hU0zur40N6SJsezTUR739rg+n
         OSaFgguWBFGfdR0vpe2/I/5GMxmKLWE378x3HSdW5e31gtMKWmUzZfRrmPNhlXGIuwll
         +78oje8VQgrWfZ9nSavu+139MUAf0qJsYUfIjiZ1nfIzpgkAswSrdHtiNBWMlNUf1LPW
         fGCuW7xS8YE6+kNvJBNKLU0SudgrHd7aKNW7c7jQ/brDILwbl0l7zBpHTGZ/N5cxUgER
         UONg==
X-Forwarded-Encrypted: i=1; AFNElJ/ztKbskmSy5gdadEL3oZPySk/ozYbK+sW/ZHwvQMB0mYSZQfDz14cO6HTBqvQz51G/wQuHbPc7Y6+yceI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyx94ZTwwZj0vL/vWeG5GI5zP3vY1VVvECIUm9mKSA7PBPqv6Rj
	oEkMcAMc+q0eEdxQcrzaK1FbohGYL7YJMa3B+Nl61AI/8RUohNqkdS4R
X-Gm-Gg: AeBDies2VerpiLDZK7BylHkHqgHeQgUBchcvqL27HrcHanVzcRcdijIcnfUYBhgx7ll
	uSFWPzLY6ihbUjkK0pHOQ7oyDN0yKw6f9Dxij5ih9CQLq+O771dru6/p6BSMz+TvNUJ5J+vdO12
	LZxUfjaIwckGnOyBbNYPN1PtQtnPXCYxskd3zkEBRIyRXzuWjOBhxyCsIEjQL7FqseNJFUNFnAv
	gTBy8Cv2YtQE0JZnKHsW6vzV/W9ZIId0zagIcmLbx9LMWZKTVBnv0RDQNGyYAkQ7J0PV/olGoWy
	SpGi7OCo1Em4nQHN3oHC271m2J2nV6y8wS3HTG1AR9NJWRQAR3+9IbJhycoTwj4xq3dLmmCRNRP
	m68PUPMkqnd+wzn7QRg3i/F0pNtM2zOujHI7xstOjUMukLTJ5ppGNSFY79Ni0fp1oLX5pxb2nsB
	CqLnxUVfA6h+rImUAXTml2P69Tc1S2zm4RLWjSOoVuZ4aOw3sY/WvOK35Yn/I04CRLWdm0BRFbJ
	l3TwBP9LA==
X-Received: by 2002:a17:90b:52cf:b0:35e:577c:c9f with SMTP id 98e67ed59e1d1-361403fb305mr37768192a91.9.1777189958672;
        Sun, 26 Apr 2026 00:52:38 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.164.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fba1436sm10396034a91.11.2026.04.26.00.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 00:52:38 -0700 (PDT)
Date: Sun, 26 Apr 2026 13:22:24 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Gary Guo <gary@garyguo.net>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com, 
	aliceryhl@google.com, rostedt@goodmis.org, ardb@kernel.org, sumit.semwal@linaro.org, 
	christian.koenig@amd.com, ojeda@kernel.org, boqun@kernel.org, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, 
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com, 
	justinstitt@google.com, tamird@kernel.org, arnd@arndb.de, nsc@kernel.org, 
	simona.vetter@ffwll.ch, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev, Link Mauve <linkmauve@linkmauve.fr>
Subject: Re: [PATCH V13 5/7] rust: Make __udivdi3() and __umoddi3() panic
Message-ID: <ae3C2gqzoVaovY-h@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260424054742.45832-1-mkchauras@gmail.com>
 <20260424054742.45832-6-mkchauras@gmail.com>
 <DI1E781QPU8F.1C28PL0089NP6@garyguo.net>
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
In-Reply-To: <DI1E781QPU8F.1C28PL0089NP6@garyguo.net>

On Fri, Apr 24, 2026 at 01:43:43PM +0100, Gary Guo wrote:
> On Fri Apr 24, 2026 at 6:47 AM BST, Mukesh Kumar Chaurasiya (IBM) wrote:
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
> Can we always build libcore with `-C opt-level=2` even if
> `CONFIG_CC_OPTIMIZE_FOR_SIZE` is specified? It feels like a better fix than
> stubbing things out.
> 
> Best,
> Gary
> 
The issue is not coming from libcore itself. It's the driver that's
causing this.

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
> > index 2a5428a5503d..ee11fba7a03d 100644
> > --- a/rust/Makefile
> > +++ b/rust/Makefile
> > @@ -616,6 +616,10 @@ ifneq ($(or $(CONFIG_ARM64),$(and $(CONFIG_RISCV),$(CONFIG_64BIT))),)
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

