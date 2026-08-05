Return-Path: <linuxppc-dev+bounces-25438-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C27BBC55ABA
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2026 12:22:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFV0G2Lcsz2yMl;
	Wed, 05 Aug 2026 22:22:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=82.65.109.163
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785932526;
	cv=none; b=lfFsotYiJCHLDD/i0pKMORgHEhPD9ttEWCn4iUcAAf6HkrwvWdApuLe0LPkqQ/NEHgY4dB9+ko/9wlHBjXdyMl+eAswYYj+zKnu99zzigIk7o8RkCKVJ7mX45jTGC3VNHs+4YKXun7VlT7D3wyPMuk0VWTDAb0E82oqUN/MrkMuvX0EL0x+tnqrdx9ph/aKnB79lfaxK8Rwp+5Xkad5Bk4twN7fcB8Iw4dSnn7Ynf3tKdh8ljUQ9bNqlgriJgMNsHX6hXoLYjwd7MYK8eh4OY42Nq8xUhhFUQEFJK0kaAX0o+K/VTCvsxYrhw+UHk9A/gDnJEAyxgZWwNx7lUZ+iTA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785932526; c=relaxed/relaxed;
	bh=Q7ZRWBSwbv9Su7uyVJTmmfq6ln2NfjYL+T8OJa2asFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B26+odmSFNOmlkqloDbds+V7nB2XJNxOe9yrYCJJNhwobwIlaT7IWJFmf71nvj2RAPZiYiRNd6WMQR3LAvSqQ8Pi1EGu5FFUIBAjZq60pCmg+vX0xRSxvhA7vy0/1hQ8sss3cpUVjoAQtY+7RkUvqFtVPyvNI7U9ifE6HuV8U10CBUsI6WQenYvtq5Ya94QDs3ZbplikAJ9Jp5gi9euNh5tzdCdIhGTMCCDBq4yPc6BIlKnhqi6cjgn9T8xshq6V2RtzeGZMsVH//NEfz1j9KYfZB2wnZFrpOenAGQIGEwl7QXO4j+afQzzPuLro1dw6FBNtV+yj7yLylfSm1ze26w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass (client-ip=82.65.109.163; helo=linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org) smtp.mailfrom=linkmauve.fr
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linkmauve.fr (client-ip=82.65.109.163; helo=linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org)
Received: from linkmauve.fr (linkmauve.fr [82.65.109.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFV0F1ZMYz2y8c
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 22:22:04 +1000 (AEST)
Received: by linkmauve.fr (Postfix, from userid 1000)
	id 0B87B70A144F; Wed, 05 Aug 2026 14:21:59 +0200 (CEST)
Date: Wed, 5 Aug 2026 14:21:59 +0200
From: Link Mauve <linkmauve@linkmauve.fr>
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Link Mauve <linkmauve@linkmauve.fr>,
	Madhavan Srinivasan <maddy@linux.ibm.com>, mpe@ellerman.id.au,
	npiggin@gmail.com, chleroy@kernel.org, peterz@infradead.org,
	jpoimboe@kernel.org, jbaron@akamai.com, aliceryhl@google.com,
	rostedt@goodmis.org, ardb@kernel.org, ojeda@kernel.org,
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
	dakr@kernel.org, daniel.almeida@collabora.com, tamird@kernel.org,
	acourbot@nvidia.com, work@onurozkan.dev, ndesaulniers@google.com,
	morbo@google.com, justinstitt@google.com, fujita.tomonori@gmail.com,
	joelagnelf@nvidia.com, gregkh@linuxfoundation.org,
	prafulrai522@gmail.com, nsc@kernel.org, japo@linux.ibm.com,
	lina+kernel@asahilina.net, j@jannau.net, airlied@gmail.com,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH V17 0/7] Rust Support for powerpc
Message-ID: <anMq59xoOrusKKl2@desktop>
References: <20260708082454.1254320-1-mkchauras@gmail.com>
 <178574013457.29744.6211258618175255546.b4-ty@linux.ibm.com>
 <anG67Q6Y59kDqh-c@desktop>
 <20260804202217.GA1109939@ax162>
 <anMnoT0KLd5PRGmX@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
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
In-Reply-To: <anMnoT0KLd5PRGmX@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
Jabber-ID: linkmauve@linkmauve.fr

On Wed, Aug 05, 2026 at 05:40:42PM +0530, Mukesh Kumar Chaurasiya wrote:
[…]
> For these warnings below diff should fix it. I'll send out a patch soon.
> 
> diff --git a/rust/uapi/uapi_helper.h b/rust/uapi/uapi_helper.h
> index 06d7d1a2e8da..acec2d2fede7 100644
> --- a/rust/uapi/uapi_helper.h
> +++ b/rust/uapi/uapi_helper.h
> @@ -6,7 +6,7 @@
>   * Sorted alphabetically.
>   */
>  
> -#include <uapi/asm-generic/ioctl.h>
> +#include <uapi/linux/ioctl.h>
>  #include <uapi/drm/drm.h>
>  #include <uapi/drm/nova_drm.h>
>  #include <uapi/drm/panthor_drm.h>

You likely want to keep the alphabetical sort here.

> 
> Regards,
> Mukesh
> 
> > when building this series in next-20260804 with rustc 1.97.1. I am not
> > sure where the clang diagnostic warnings come from. I assume the target
> > feature warnings are expected but it would be good to get those
> > addressed sooner rather than later. I see '-hard-float' has an issue
> > open
> > 
> >   https://github.com/rust-lang/rust/issues/117347
> > 
> > but I don't think I see issues open for the other ones.
> > 
> > -- 
> > Cheers,
> > Nathan

-- 
Link Mauve

