Return-Path: <linuxppc-dev+bounces-20047-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A1E6FB44C8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 08:06:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g25C52P1wz2xly;
	Fri, 24 Apr 2026 18:06:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777018001;
	cv=none; b=Z5T5qbvFBFNKpUB7Wc+W7FGIwlugcWL9T1j+ZwfnV2b9w9gUO0QIOgfMs154zLaIxPru5UPdW5dHcuSzt1HTPSIAKy0hPNgu8R6d2rB2gQYcfaxtx5klkinqNjsq11xasEAlhXLIcY6rlap1+LpMtlI+qZChOiAQvFReZyppZSlKK3+RiG7PASDVmQ5HUoiU4PNeexkV/d8PnynyK5Dxz45uBQM0k2ehBGjHbYoWkV/Bd0qi2zfWfzEyL1s9KFXU3vzI2EBEchp7t25tcPB2KPjwpTYfbwvQUoGrvlpzSzn31WXA4z0zsczog5LJWmBZmUl45QTBJo9y05Xh4VoSPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777018001; c=relaxed/relaxed;
	bh=/RCpdNlcyc5wjzZkBzWIIC1nFpk179iwlYkDekoHWOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZeQSzDm379QWH+aNQFI3iJ0p6iYQu0kWSawIVnN4XSklgQi0WFnsWQkjVrpzG2D0/LWAO/e20vL/4C8bLJUr9KhlmdFQdcBfKf9CSKapSmk1z0wIaq3jTLANqC8UnMQAjtxxPzH3uz3xAz+dtFQp4hbjDb70eY6Dnu9PHuHaZUhwEGW/4M+OeIWFDhSP9F/cRpi3ju04o6J3prnOnFcVpGbSg2ngp7PZyRKtMUqzNkYVBDctZg4egnv9lgLAqtiMX1s7mNbUAxxMXFeQ9+Vduu/tURmQGVza61uNJhX0vk8/nPKywJeTqMGeqhilOJtx4TmQb5VpsKU8RvzGxXy7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IzuzDeu/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IzuzDeu/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g25C01SN5z2xPL
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 18:06:35 +1000 (AEST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-35e576110adso5257636a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 01:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777017994; x=1777622794; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/RCpdNlcyc5wjzZkBzWIIC1nFpk179iwlYkDekoHWOw=;
        b=IzuzDeu/wsEQMY6dVCUJQ4NdqXiixGNdRw7CotdVSFsDec7zRughwK4YgQ6qbT0nz9
         jPHeEvNJRbCdVbugIC5Pej2ZWESfa6eeNp2yuxOxUL/Oxbt42xfdnR2x3cbhgoNmr42p
         ME8jk2+xH6AOc+KVmR/tNasny+lOcA0RPY1BuLRqX1+2HzotgeY/mv4aQqNqMGQg0bwM
         lFFgJCvEpIaFWQHeEZ/pAjmsnTBL+3sLljTMWnF5Btw6nSgzNK5Oxpmbjo76pN22x5/B
         CDh5omLQp8mZzpT1aPxWrJ2U/8wxM75CA6I/PcS0HjCtH6OBts/lp7kBaaBBc2iKzeTL
         JxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777017994; x=1777622794;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/RCpdNlcyc5wjzZkBzWIIC1nFpk179iwlYkDekoHWOw=;
        b=G0FUzFJjYZDEMcoI/4mzgL9iAItbAh+u1wtj4iHjMyEAtzBmFDMs3ou2g5AF28Gy8f
         QxNGMguEs7irtg+Jhr6pwtv5+siPRlpgjb5mN4Uh91+HsRe2evAKa2CPG79HRrjZsLid
         tcpxoDyPOf67kEaksslomzYJdJhUKJNxniFKzeZTOkq9pfaVIFEJQVbUvTjb9Yckd05i
         3vzkrfwG30Oa+XZVyWCtjk1L8rGzi4FZSv75YqMcrpxwcjorKClkW/cmsXbDW9LN8ElO
         evHztgROTOxxuuIvRTKi2ioUN/8U+wMqx6Dr5uXj8DBHRA5Oqf/XTrHHqRFT5AN5uhuO
         oU3w==
X-Forwarded-Encrypted: i=1; AFNElJ9RLkAnsbvnWzj9d3maG5wTQfhIbAJvskyIYt8l+zaD5BqDSapCZTgkSdVtfpc4030bRzlA4zIrELqp28k=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxwXp98OB3jz8n2NuRvoJ4UzOsXPc2w4z9s0aaNNsP/enidga3B
	Fapv69jPhBj/KeUYaB2oYrnYzCZcIwjoUzIo5GNXfJgzY7jn/izoB/bS
X-Gm-Gg: AeBDievG32s/XUeWTR2lIkr7lc/KuLyf0DTo5p98U5Nywx9zxOAybLBXAod99k09vG9
	fNuG1o3o+k4TH7m8ygVf+fv7mef88wS08libruP65ABB7hF7jib/65XPd3c7jphaycqxF5+kywU
	l6Es4k4G6z3VbvIlT+Y5LG022bnCvlTTbMU3s5cjWdZzhEFhoeuFNHrUjihOCLm4bS81h73Wk0n
	5A5jgeUjMCT5enQEOisqwBF42mkMFY4IqCIzj8CQz/gXMRAbjOwKt2trwOrn3UTipHLUGAKf4Qy
	j1icGNymcaVFMnzyv1F4B5ZJnD2pakxzaMJxwqdD6ASR9IeG5iCJxbuqVuL71Ia+UnMFynci8Y8
	etVImD868tBx73xiQvTkuKTr+0SpZAQsZg1d+XRoObghEYP6QpgYEG3EiH65WbY4fmVHJOuvVpg
	78EJKE0SWc3JaNfBI6wu08Evr17cn22TcuJjIhU3hZy8X4nA25Zbgeb06COo9XSWks6O80ki1H1
	TGl9A==
X-Received: by 2002:a17:90b:3ec5:b0:35f:b4c1:91ea with SMTP id 98e67ed59e1d1-361402ee818mr23969038a91.13.1777017993532;
        Fri, 24 Apr 2026 01:06:33 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-361419739dfsm23565688a91.13.2026.04.24.01.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 01:06:32 -0700 (PDT)
Date: Fri, 24 Apr 2026 13:36:18 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com, 
	aliceryhl@google.com, rostedt@goodmis.org, ardb@kernel.org, sumit.semwal@linaro.org, 
	ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, 
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com, 
	justinstitt@google.com, tamird@kernel.org, arnd@arndb.de, nsc@kernel.org, 
	simona.vetter@ffwll.ch, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH V13 2/7] dma-resv: Fix undefined symbol when
 CONFIG_DMA_SHARED_BUFFER is disabled
Message-ID: <aeskOeb9uBiPptEJ@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260424054742.45832-1-mkchauras@gmail.com>
 <20260424054742.45832-3-mkchauras@gmail.com>
 <b4dcb464-7784-47e2-a973-6d731ab9ccf8@amd.com>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4dcb464-7784-47e2-a973-6d731ab9ccf8@amd.com>

On Fri, Apr 24, 2026 at 09:56:16AM +0200, Christian König wrote:
> On 4/24/26 07:47, Mukesh Kumar Chaurasiya (IBM) wrote:
> > When building with LLVM=1 for architectures like powerpc where
> > CONFIG_DMA_SHARED_BUFFER is not enabled, the build fails with:
> > 
> >   ld.lld: error: undefined symbol: dma_resv_reset_max_fences
> >   >>> referenced by helpers.c
> >   >>>               rust/helpers/helpers.o:(rust_helper_dma_resv_unlock)
> > 
> > The issue occurs because:
> > 1. CONFIG_DEBUG_MUTEXES=y is enabled
> > 2. CONFIG_DMA_SHARED_BUFFER is not enabled
> > 3. dma_resv_reset_max_fences() is declared in the header when
> >    CONFIG_DEBUG_MUTEXES is set
> > 4. But the function is only compiled in drivers/dma-buf/dma-resv.c,
> >    which is only built when CONFIG_DMA_SHARED_BUFFER is enabled
> > 5. Rust helpers call dma_resv_unlock() which calls
> >    dma_resv_reset_max_fences(), causing an undefined symbol
> > 
> > Fix this by making the function declaration conditional on both
> > CONFIG_DEBUG_MUTEXES and CONFIG_DMA_SHARED_BUFFER. When either is
> > disabled, use a static inline stub instead.
> 
> Well we are clearly missing something here, but of hand that doesn't looks like the right fix.
> 
> When CONFIG_DMA_SHARED_BUFFER isn't enabled then the whole dma-resv.h header can't be used at all.
> 
> So you also can't call dma_resv_unlock() from the Rust helpers. Which means that we need to make the Rust helpers somehow depend on CONFIG_DMA_SHARED_BUFFER.
> 
> Alternative would be to provide dummies for the functions in dma-resv.h when CONFIG_DMA_SHARED_BUFFER isn't set, but that looks a bit like it just hides the issue.
> 
> Regards,
> Christian.
> 
What about something like this:

diff --git a/rust/helpers/dma-resv.c b/rust/helpers/dma-resv.c
index 71914d8241e2..53c119f1b144 100644
--- a/rust/helpers/dma-resv.c
+++ b/rust/helpers/dma-resv.c
@@ -2,6 +2,7 @@
 
 #include <linux/dma-resv.h>
 
+#ifdef CONFIG_DMA_SHARED_BUFFER
 __rust_helper
 int rust_helper_dma_resv_lock(struct dma_resv *obj, struct ww_acquire_ctx *ctx)
 {
@@ -12,3 +13,4 @@ __rust_helper void rust_helper_dma_resv_unlock(struct dma_resv *obj)
 {
        dma_resv_unlock(obj);
 }
+#endif

This seems to fix the issue and makes sense, whoever wants to use the
dma shared buffer will anyway enable the config

Regards,
Mukesh
> > 
> > Fixes: 0c6b522abc2a ("dma-buf: cleanup dma-resv shared fence debugging a bit v2")
> > Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> > ---
> >  include/linux/dma-resv.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/dma-resv.h b/include/linux/dma-resv.h
> > index c5ab6fd9ebe8..23c8db0b5214 100644
> > --- a/include/linux/dma-resv.h
> > +++ b/include/linux/dma-resv.h
> > @@ -311,7 +311,7 @@ static inline bool dma_resv_iter_is_restarted(struct dma_resv_iter *cursor)
> >  #define dma_resv_held(obj) lockdep_is_held(&(obj)->lock.base)
> >  #define dma_resv_assert_held(obj) lockdep_assert_held(&(obj)->lock.base)
> > 
> > -#ifdef CONFIG_DEBUG_MUTEXES
> > +#if IS_ENABLED(CONFIG_DEBUG_MUTEXES) && IS_ENABLED(CONFIG_DMA_SHARED_BUFFER)
> >  void dma_resv_reset_max_fences(struct dma_resv *obj);
> >  #else
> >  static inline void dma_resv_reset_max_fences(struct dma_resv *obj) {}
> > --
> > 2.53.0
> > 
> 

