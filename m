Return-Path: <linuxppc-dev+bounces-20053-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD10FB44D9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 08:34:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g25qG1MfSz2xwH;
	Fri, 24 Apr 2026 18:34:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::435"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777019674;
	cv=none; b=G0lBsNIB8eWnRwPxOZyHK5qa8vJqsJPlM+Co0aDCSW+4SsVzDulJ2uIlYo9b812kFkAnryf0tVZ/XjZdsZP88MnGEdQEPpLRRyoKix6AtA6wgFAKiUN2fD/np8rwByzE34ECJngbFBZzWRiGXE7+DZw6331F0cjGH2BIaPk9Hb6hO88A2ZQf1vJ45TyDQ5YwPRAoy7rmbkR1/SAQAQlNtz610UWlE5beexPS93dRElX38fZ8XJPspFhHDthqDHlADQXMNIZ3GQ5HLEYGVWgY96/JasfQP5CM9lHkNJ8PFn98cyemKxgMWSDHLV6wt5VvZFx71aSLLuTf5iA2szu7Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777019674; c=relaxed/relaxed;
	bh=/LSr35TcIMW6wVIpT4GYu71Od3lJHQ6iIOnrBrPvpf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTYu02jkejwXsKTdIuxLAbDKW1ompIQ0GcchiRYjP2vZfDCRzil3nSseTeVZGNpmI0IluYtANCJxsvMo+QilxWUaq4Gzr0GGnG+/2qCxJXC+349UauFA6ci0aJprn2xvIsS6VanVyI3tt6N5scQIHjdkOtYOTpYT5zXfm/RDu0ePXQZTVq1gA5T2ErDvcrStkt/zDaq4The3zORbv1A6UBc+YTZFLxGKN5Q+DtEJ9nLOCNckExpxIkQx8dgaV3rpkY4ICTsF5WFPkJDGj37I7mkS0rcdDRKGsBpvIf/5rOKhh80xLpAM+tMkmRPJDlCQq9Gg12KEyajGnK3snEhudQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qIf1TFKU; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qIf1TFKU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g25q73vxqz2xly
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 18:34:26 +1000 (AEST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-82748257f5fso4613180b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 01:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777019664; x=1777624464; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/LSr35TcIMW6wVIpT4GYu71Od3lJHQ6iIOnrBrPvpf8=;
        b=qIf1TFKU8e56xalIMbo+Rxru8cN0NpKFuXiePcLnbzYY3nnYWnH305esCu0v2pgvQC
         VtPfRVuHu3hn2Bw9FBKvqoz94mZRg5teXv3ZCMUTF1diUH0bOBEiTc8uRBH8CdWRxxMb
         VjpsWIbDz3FHZd2dNIM26stv4a3pGqILGB0n0vmxPGGXe3GAi+fTvCZO6dih8gOFO7+6
         MbrAkqZmRFsFO8jRi4jD+HC5M5UHgdO+acrgMUa03vYKkvZ7NicqCTbNV10h9D3CPdHB
         i4Hy/G6yyyyTdTiziKArbT5uOHYoVIxcpMxrjQPVRLEXsdzXJROs7GLoZ8D7RbY3KLBA
         bJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777019664; x=1777624464;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/LSr35TcIMW6wVIpT4GYu71Od3lJHQ6iIOnrBrPvpf8=;
        b=CnkrKqNMrRG9nRAfAMufLnc0vv8PbM9QSWSADGRD6zlSpKdCtbaLTa7UKAiNZAh/52
         eBQtge2vuHP5ChI4cjQibOXJk4eOPzrwS0lpEGabzC3vQuObp/dXKBS1Bj1isuWAZRll
         xLM/u40mCadoq+3A8/po970RlQ50lNuu8PTuNOEfOvIpgV9ttWI11AHaHbKT/6eg/ClS
         aFovAxkJr6HG19E809xMhw/z039ek2GnzPsz2jRNf5h/G8NML4iWrPc3Fpc7wa2Om3Uu
         2xKyMPoAKJtNszSduDDNG1u8BfnHopHPSY8bk+4A2o9A3NxmdOVY+591tAF5N2jJuNs6
         I+dw==
X-Forwarded-Encrypted: i=1; AFNElJ9ZL7oI07DlZKe+IEg2znJU3TlcMNflXOIrJ7cmBRfBIfyjtcy+V+R5jpTDiWYsOMNElgIoOrTe2PC2Zrk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy/RsY5WhFAnG8jWpe4THykItvLBtF0Q/MNHw/49Wjeoe5MIR6t
	U8ztnTdbQB+gvnNa9PUD6z0JkpL7LsJh7CMwqcFc2jBvjt8cSZBD54B9
X-Gm-Gg: AeBDieugye1eH9RHscqL3Zb2wWjA+QEZRbwdhDg2Bbd/7U/b7nK/dg2Da4Bzw/OVcUc
	48/1x3A9GDkkcqyc4ZJl5abFMlu/ExETfNm/Jeou4rOZWJeZLYcBtVadI3AOTS91oc5qrFmBKqV
	yHHYWVZfPP9mTkpq0MQBxzpIzwaceci7zb2fK5ezoz3lIzR7FcEspuebUSMZ3ujaexpA0eT/Jj7
	XVUnzUm/e3Lz4cdCl4/2xaCzFt1SZ9baU5jxfE6Dg6kwcTU8d5QG6MIDuskdcHAcL4kscLwaAqX
	huZ98eg4by66JV1pQpVpRQ2EILRpMsS/vylmiV/wvfeZCMjO15ZSWpfmq0Zrj014uSeXIUHDnqQ
	/iUQoHON9EdaM0O75uSPbiKxajei/7prs4BTm3s0veVH27VN9bhldwgpeQkQH0F+WBQXSWvHJiE
	yjwmtMfEAG25MqNpJ91BnAhB/SBzqKCoLBU/yCEgHMHfHIYZ2phwIAYP/EYksm4c3eevTQJNncN
	U3jhQ==
X-Received: by 2002:a05:6a00:3e09:b0:82f:456c:29f1 with SMTP id d2e1a72fcca58-82f8b385c38mr26954369b3a.12.1777019663822;
        Fri, 24 Apr 2026 01:34:23 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebe92desm22485595b3a.44.2026.04.24.01.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 01:34:23 -0700 (PDT)
Date: Fri, 24 Apr 2026 14:04:10 +0530
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
Message-ID: <aesqe2NKWhkT4kc2@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260424054742.45832-1-mkchauras@gmail.com>
 <20260424054742.45832-3-mkchauras@gmail.com>
 <b4dcb464-7784-47e2-a973-6d731ab9ccf8@amd.com>
 <aeskOeb9uBiPptEJ@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <a2241936-579f-4fa6-a9ec-49325d44413f@amd.com>
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
In-Reply-To: <a2241936-579f-4fa6-a9ec-49325d44413f@amd.com>

On Fri, Apr 24, 2026 at 10:25:25AM +0200, Christian König wrote:
> On 4/24/26 10:06, Mukesh Kumar Chaurasiya wrote:
> > [Sie erhalten nicht häufig E-Mails von mkchauras@gmail.com. Weitere Informationen, warum dies wichtig ist, finden Sie unter https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > On Fri, Apr 24, 2026 at 09:56:16AM +0200, Christian König wrote:
> >> On 4/24/26 07:47, Mukesh Kumar Chaurasiya (IBM) wrote:
> >>> When building with LLVM=1 for architectures like powerpc where
> >>> CONFIG_DMA_SHARED_BUFFER is not enabled, the build fails with:
> >>>
> >>>   ld.lld: error: undefined symbol: dma_resv_reset_max_fences
> >>>   >>> referenced by helpers.c
> >>>   >>>               rust/helpers/helpers.o:(rust_helper_dma_resv_unlock)
> >>>
> >>> The issue occurs because:
> >>> 1. CONFIG_DEBUG_MUTEXES=y is enabled
> >>> 2. CONFIG_DMA_SHARED_BUFFER is not enabled
> >>> 3. dma_resv_reset_max_fences() is declared in the header when
> >>>    CONFIG_DEBUG_MUTEXES is set
> >>> 4. But the function is only compiled in drivers/dma-buf/dma-resv.c,
> >>>    which is only built when CONFIG_DMA_SHARED_BUFFER is enabled
> >>> 5. Rust helpers call dma_resv_unlock() which calls
> >>>    dma_resv_reset_max_fences(), causing an undefined symbol
> >>>
> >>> Fix this by making the function declaration conditional on both
> >>> CONFIG_DEBUG_MUTEXES and CONFIG_DMA_SHARED_BUFFER. When either is
> >>> disabled, use a static inline stub instead.
> >>
> >> Well we are clearly missing something here, but of hand that doesn't looks like the right fix.
> >>
> >> When CONFIG_DMA_SHARED_BUFFER isn't enabled then the whole dma-resv.h header can't be used at all.
> >>
> >> So you also can't call dma_resv_unlock() from the Rust helpers. Which means that we need to make the Rust helpers somehow depend on CONFIG_DMA_SHARED_BUFFER.
> >>
> >> Alternative would be to provide dummies for the functions in dma-resv.h when CONFIG_DMA_SHARED_BUFFER isn't set, but that looks a bit like it just hides the issue.
> >>
> >> Regards,
> >> Christian.
> >>
> > What about something like this:
> > 
> > diff --git a/rust/helpers/dma-resv.c b/rust/helpers/dma-resv.c
> > index 71914d8241e2..53c119f1b144 100644
> > --- a/rust/helpers/dma-resv.c
> > +++ b/rust/helpers/dma-resv.c
> > @@ -2,6 +2,7 @@
> > 
> >  #include <linux/dma-resv.h>
> > 
> > +#ifdef CONFIG_DMA_SHARED_BUFFER
> >  __rust_helper
> >  int rust_helper_dma_resv_lock(struct dma_resv *obj, struct ww_acquire_ctx *ctx)
> >  {
> > @@ -12,3 +13,4 @@ __rust_helper void rust_helper_dma_resv_unlock(struct dma_resv *obj)
> >  {
> >         dma_resv_unlock(obj);
> >  }
> > +#endif
> > 
> > This seems to fix the issue and makes sense, whoever wants to use the
> > dma shared buffer will anyway enable the config
> 
> Yeah that directions makes sense.
> 
> I would maybe go a step further and don't even compile rust/helpers/dma-resv.c when CONFIG_DMA_SHARED_BUFFER isn't set.
> 
This makes sense.
> But if that is not possible for some reason then this solution is perfectly fine with me as well.
> 
> The general goal is to make the error messages when you haven't set CONFIG_DMA_SHARED_BUFFER and still try to use the DMA-buf functions easy to understand and not something cryptic.
> 
> Thanks,
> Christian.
>

What about this one?

diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 625921e27dfb..09ee5cac600d 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -57,7 +57,9 @@
 #include "cred.c"
 #include "device.c"
 #include "dma.c"
+#ifdef CONFIG_DMA_SHARED_BUFFER
 #include "dma-resv.c"
+#endif
 #include "drm.c"
 #include "err.c"
 #include "irq.c"

Regards,
Mukesh

> > 
> > Regards,
> > Mukesh
> >>>
> >>> Fixes: 0c6b522abc2a ("dma-buf: cleanup dma-resv shared fence debugging a bit v2")
> >>> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> >>> ---
> >>>  include/linux/dma-resv.h | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/include/linux/dma-resv.h b/include/linux/dma-resv.h
> >>> index c5ab6fd9ebe8..23c8db0b5214 100644
> >>> --- a/include/linux/dma-resv.h
> >>> +++ b/include/linux/dma-resv.h
> >>> @@ -311,7 +311,7 @@ static inline bool dma_resv_iter_is_restarted(struct dma_resv_iter *cursor)
> >>>  #define dma_resv_held(obj) lockdep_is_held(&(obj)->lock.base)
> >>>  #define dma_resv_assert_held(obj) lockdep_assert_held(&(obj)->lock.base)
> >>>
> >>> -#ifdef CONFIG_DEBUG_MUTEXES
> >>> +#if IS_ENABLED(CONFIG_DEBUG_MUTEXES) && IS_ENABLED(CONFIG_DMA_SHARED_BUFFER)
> >>>  void dma_resv_reset_max_fences(struct dma_resv *obj);
> >>>  #else
> >>>  static inline void dma_resv_reset_max_fences(struct dma_resv *obj) {}
> >>> --
> >>> 2.53.0
> >>>
> >>
> 

