Return-Path: <linuxppc-dev+bounces-20058-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F122CFE51F8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 09:43:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g27Ld3m52z2xnl;
	Fri, 24 Apr 2026 19:43:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:e0a:1040:9780:49:5ff:fe41:d261"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777023801;
	cv=none; b=RZpUc5JJBOBT1OXo5gUcAup3+l3pnYyQ9dsAb/tMgjy5gDS6/Zdgqbs4xO3bQjWY4FtrXtg81/nd6HOLABpLO/6Guyp3D/z8wQg4jXyYQvOWQRDB1P9HIawULaXAg9ws3emtQliOTiwP6bl3O5o2UbFJU2reE1DjNjVWnf4+nqSmlx7ydiBLTmmVtgIPORaMTe1g5EpSDCWJ5Sir5GlpECNzGKE1sIJ4RVaWaQhMt7SQFUIdVLNv91cng9dy7iv+4tzW0TrvU/ioOJ2s8IVruvKgUMlw2lvEfb6Yr6zRDoBnOpZkgtc9fbJP2fykCgs9TtBKILx/hT3gUZGZeCN8DA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777023801; c=relaxed/relaxed;
	bh=EXaW/5c99Gv6pdDizpLT1TvOmGIqGlUHl5Sod8hEmI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iup4SrUM1hRFzQG9a9WMdZWxS0vIA8YWpRsDpixzaWtrzJmAtLu7EUUZyOfj7ih2H8mlS2Anp7laglWHuGROybkKqI4cRr0jYR9/W9OWOrkDUcuvw3L1REmDb5wykO/Pw6sQKdravi7kwIKoC4LvNNASvBQAkGpFkrNXoshS5DNwpYn+L77B2aRHM2u7pdxnZk9s4x9ucmSwBVT0uzeF4hK8LoV1ZY4qWYw0Nfbn9S6I3uJA2NVxm74+Head2wEbgJBiuvm8TK8c/wVr3C15wTsBUEHLOP0LLrw9mVsnL/9igW7TqUwU17lbVKCKnXJZFjCuTfg1Qm4EaPEt8qEsvQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass (client-ip=2a01:e0a:1040:9780:49:5ff:fe41:d261; helo=luna.linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org) smtp.mailfrom=linkmauve.fr
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linkmauve.fr (client-ip=2a01:e0a:1040:9780:49:5ff:fe41:d261; helo=luna.linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org)
Received: from luna.linkmauve.fr (unknown [IPv6:2a01:e0a:1040:9780:49:5ff:fe41:d261])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g27Lc2Twvz2xZK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 19:43:19 +1000 (AEST)
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id AD74AF4089F; Fri, 24 Apr 2026 11:43:11 +0200 (CEST)
Date: Fri, 24 Apr 2026 11:43:11 +0200
From: Link Mauve <linkmauve@linkmauve.fr>
To: David Laight <david.laight.linux@gmail.com>
Cc: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
	jbaron@akamai.com, aliceryhl@google.com, rostedt@goodmis.org,
	ardb@kernel.org, sumit.semwal@linaro.org, christian.koenig@amd.com,
	ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com, morbo@google.com,
	justinstitt@google.com, tamird@kernel.org, arnd@arndb.de,
	nsc@kernel.org, simona.vetter@ffwll.ch,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev, Link Mauve <linkmauve@linkmauve.fr>
Subject: Re: [PATCH V13 5/7] rust: Make __udivdi3() and __umoddi3() panic
Message-ID: <aes7L3M1d_LvvGKa@luna>
References: <20260424054742.45832-1-mkchauras@gmail.com>
 <20260424054742.45832-6-mkchauras@gmail.com>
 <20260424101425.6bde0e17@pumpkin>
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
In-Reply-To: <20260424101425.6bde0e17@pumpkin>
Jabber-ID: linkmauve@linkmauve.fr

On Fri, Apr 24, 2026 at 10:14:25AM +0100, David Laight wrote:
> On Fri, 24 Apr 2026 11:17:40 +0530
> "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com> wrote:
> 
> > From: Link Mauve <linkmauve@linkmauve.fr>
> > 
> > The core crate currently depends on these two functions for i64/u64/
> > i128/u128/core::time::Duration formatting, but we shouldn’t use that in
> > the kernel so let’s panic if they are ever called.
> 
> Ugg.
> Surely you can make it a link-time failure?
> Or change the underlying code to avoid the divide.

This is currently a link-time failure, which means if any of the core
crate or drm_panic_qr are linked in, the kernel will fail to link.

And since we rely on core, that means no kernel can be built on PowerPC
without this patch.

A possible solution would be to change the core crate to not divide
u64s, but the last time I tried to do that I couldn’t quite figure out
how to do formatting without it, maybe I will just open an issue against
Rust.

> 
> 	David
> 
> > 
> > This doesn’t yet fix drm_panic_qr.rs, which also uses __udivdi3 when
> > CONFIG_CC_OPTIMIZE_FOR_SIZE=y, but at least makes the rest of the kernel
> > build on PPC32.
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
> 

-- 
Link Mauve

