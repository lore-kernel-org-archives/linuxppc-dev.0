Return-Path: <linuxppc-dev+bounces-21504-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD25CD5BC8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 08:53:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPmjv0Wpvz2y8t;
	Tue, 26 May 2026 18:53:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779785587;
	cv=none; b=RUvQHBUDH9tgha06s2WqrC9ZpGmLMa4GW2yHkU/HCu79WHcF0n8FJuNOHGp7HFoN4Mum1crruhWzTquy5SplgqJv4rWgIRRmDBzbL+wnhP4Tv3jvemfy2RgdqkD20aWB66A0cQaaw+QsWjUuqHMoErz33vgT07mbFTITMDIX8eJ2P/snalC5Yk3+yuFV0/TJYh3yWt7boNjrpoDi7eR9/z7wRgfPzI6C0gQFvWuysyLakrNy4mt17TzZPPhB7jKDrIUZcvQ8AFyQNJYAwlPnYdT8pDaYbiWG3iyfhY3SVTU4Lo/+KP/nZf4NFJc0kmml6kthxvHbjx88l7SK3HS3EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779785587; c=relaxed/relaxed;
	bh=InJMAp5dveD8bJ+7VPqWcHSAuX65wXSmTpY0vYoc1U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afvSgnRi8sW0EO1hITNv4YykLeFVrhfKoQJPzRpEVIOXeOE3fqQEetjuF6Kjr9QFEt92BfTHnkZSXdXM6Yir5cE4v1qR58V22xOxTt2ItaeDTIqcSQJf2SQ2OGNw9rlYSp39NGLwBM+HCEzA0pXDv/ftmewQpYWQnIya0hbHAxBmst/X7Re7967KTN2mMMYqecEHSYgiX3R+rfLhbAT9FhpRn5lTADI1G7J53Jj0ZTtfm7yRJlL2R5Hi4w/fR1q/mZNf7dny6P4Vh6bSvPFMegh9yYV0eElOM54z3jEXZs4e56k+benSowt1Uan0pTAgDWpXd298ZcECdfdQa+YMtQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HBl5qOGT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HBl5qOGT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPmjs3NdWz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 18:53:04 +1000 (AEST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-837dfccd950so4786153b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 01:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779785581; x=1780390381; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=InJMAp5dveD8bJ+7VPqWcHSAuX65wXSmTpY0vYoc1U0=;
        b=HBl5qOGTCiQ4UW1sW0vRivfpSOaGmjKzteVt5C0Pvh4Z27NYJw8v48EjCX+wtTM4XL
         mOnV6MyEzzUiblJBDWbasKn97EV9u7WdjrORy69jvMAzfyv/GZqWWHp0uFM5/9wYxJJU
         JhYNGLrfEIH7/AFcQumhRt+cid8cjX3TvY8rlerG+fmJkBxJJZuELzJ1yEYGhZIifrg/
         HBOx5eaqfOWD9NmLJaaBFHBtwb0qKX5wOeXZAfRHj/ylrwfb4nTX0bi4e/JK8ia9MlvK
         1093LNtKtGZ6eVni7aOwHI89HiFRWcix+nv3tSGAHujfYWxYvKUSgt2+dVZDmiq+PxHT
         iXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779785581; x=1780390381;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=InJMAp5dveD8bJ+7VPqWcHSAuX65wXSmTpY0vYoc1U0=;
        b=B4lW/SFbn5awgkGFUsKN1yAQPZmyBBa52NIBu7fI5qi8niZcX3QGxHvanzuGnSbDJw
         lReG10GMGYFeayO7B7l90YkUCUiHp3+URUW0vVpyEcoh6fElvRowg4B2+38g0S5s+/YH
         e9/Z1l6ZggD5mWSnJKqAt4vvZ18DvzdJ44xKPJLPYuIL/1cx+0JBBfkYSdWQHsUMcQ3+
         K/GeGcO6uOsJfDv1XGprKZhdeFboj33CdYJErL38jAzUaAPL8Cxu9X0Y6t7FVfHTrTA1
         +Q9uTm+aDUxj+AiND3kVhacfXeyvNzHt1ZXkz5g611iPBq6RHQ08g4powfk36la9wZAW
         sUcA==
X-Forwarded-Encrypted: i=1; AFNElJ/yrC9dwQUbMhbOpQpkIXU+DYY0nXNz1MInsmbO2lDqDBDGFdt16QFeIDFETHT9kZZ9P2Yw5v1eQ95dsOA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxEHYRbR6wGfF1nTfL8G9Lpt2rQvF5LnODOewWZFMdKM5ARucRy
	sIzIjYnmdfTPsGHnwz/mHIf8GwCnfhuxvxF8PB5EkNisTgTBbVypH4dF
X-Gm-Gg: Acq92OEfh6ftgeuw3di3eyQwQ+UsC6YXxamW/pGtQ+FLL793279DAkTU3SZ0s+4CFj3
	6IvpA5gXRRdOXiDdHfMFSS3uze97SZBrQ2VC5FtCREks6Vr7ADLA/L6WZwcoEgbvlT3b2VzZXMk
	jBslXYWptTrXv2bQOWHC87Mb9iMih4LEFg7pG3PQrpZqhcrf2gdMhEqtejLJftK26sabFhh4aof
	AX+SyuQffSwjUCckZyxl2h12x4b9xd+1wIOV0gFX75saP6kO/fX3Sf4SVv5iVMa5U4OqhV2fdwl
	pIU78rjabdTNzvvkJCxMwSHaJXsb9Y/OcEKM66XuyL3f6aWido2JcMdd8L/yIg+YGXpT/cTJwl9
	j8z0GFDQT67jHBO0LsLR5if/XkAPQNXGH6qBfbh/hbkUiHZovPOdXtX1Uil2KTeSyH1j5JMLkEJ
	5ny5F9b+GaHedOdqtBCaXfD+72Kldh6Ub+n/78x1/8efcWTw/ewc3yeKuDRDnk+WF6x58=
X-Received: by 2002:a05:6a00:2da4:b0:837:e9cc:d465 with SMTP id d2e1a72fcca58-8415f19e22fmr16062880b3a.20.1779785581098;
        Tue, 26 May 2026 01:53:01 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164b06fa2sm13385336b3a.23.2026.05.26.01.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 01:53:00 -0700 (PDT)
Date: Tue, 26 May 2026 14:22:49 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com, 
	aliceryhl@google.com, rostedt@goodmis.org, ardb@kernel.org, ojeda@kernel.org, 
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	daniel.almeida@collabora.com, acourbot@nvidia.com, fujita.tomonori@gmail.com, 
	gregkh@linuxfoundation.org, prafulrai522@gmail.com, tamird@kernel.org, kees@kernel.org, 
	lyude@redhat.com, airlied@gmail.com, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH V16 4/7] rust/powerpc: Set min rustc version for powerpc
Message-ID: <ahVb4k-2rC4EYZF9@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260520064630.1785283-1-mkchauras@gmail.com>
 <20260520064630.1785283-5-mkchauras@gmail.com>
 <CANiq72nPOMkZXpMpwTLFg4xjFfmyf_O_x2FN_nrNBsxeNu178Q@mail.gmail.com>
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
In-Reply-To: <CANiq72nPOMkZXpMpwTLFg4xjFfmyf_O_x2FN_nrNBsxeNu178Q@mail.gmail.com>

On Mon, May 25, 2026 at 08:16:53PM +0200, Miguel Ojeda wrote:
> On Wed, May 20, 2026 at 8:48 AM Mukesh Kumar Chaurasiya (IBM)
> <mkchauras@gmail.com> wrote:
> >
> > Minimum `rustc` version required for powerpc is 1.95 as some critical
> > features required for compiling rust code for kernel are not there.
> 
> Which critical features?
Hey Miguel,

Right now i can only think of inline asm. I can rerun the whole thing
with 1.85 and figure out the issues with 1.85. I'll get back on this.

>
> > For example Stable inline asm support which got merged in 1.95.
> 
> It is not needed that the support is stable, but rather that
> everything you may need works.
> 
I wanted inline asm be stable, I was skeptical about inline asm to be
unstable and potentially messing up the whole system. That's the reason
I waited for the stable support to get merged before sending out this
patch series.

> From a quick test (with a dummy example that may not be
> representative), ppc64 inline assembly seems to work for a long time,
> way before Rust 1.95.
> 
> So, which is the actual version that it is needed? i.e. 1.95.0 doesn't
> seem to be required at least due to that.
> 
Yeah it may be true. I'll test out the 1.85 rustc and come back with the
results.

> That is why I am asking about the critical features above, because it
> may be that this works since earlier versions.
> 
> (I wonder if this patch and s390's similar one influenced each other?)
>
I am not aware of s390x way of approaching support for rust so can't say
anything about that.

> Thanks!
> 
> Cheers,
> Miguel

Regards,
Mukesh


