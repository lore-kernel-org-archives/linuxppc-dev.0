Return-Path: <linuxppc-dev+bounces-8025-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFCBC369D5
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Apr 2025 10:50:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zl6266T3mz2xfR;
	Sat, 26 Apr 2025 20:50:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=144.6.53.87
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745664654;
	cv=none; b=WUa5qsOO0YndeKS6IYSbp8fUw2Gp5wZgNcMyXYf9JhXvLlIKVySqg77ONBMb/wZTjjDanulC9d66yZc8WjczL7bPTWJd8ZThTY8PHrRSXyTNMbTeK6eBMvmE4rSvkYMzEioMEcf1xf1NKg5ihQxG7Z4aJ+xpKryvx1P/7HMWIKe3lxxTkvnGcNopqbTGdHGbFIs3PSmPlGAvDCioF7g7YDD5pZhtKGKAQaBMFHlG5UutYWX47+x6jXh3pk511vhhFAJsNMPTnvT+3MWnTaWgtgCabLVSpDtD7ROzcLplcFsOBA84LtDjp0mW2cA45fupsQQ5S7qD1o4FV8nQj4u0QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745664654; c=relaxed/relaxed;
	bh=r/BRgULQpLgk5YaJQHiFfQ2T48zm7WZ1sUrce8geWiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZKLYVxGKRb/0Y1U4m9FFl2gAqhRP7HFqY4IfxWdcqDSDzDbhISmH1HnjXa1wf+arTUpw0pzcWbXjviPBu+lrsbTVPyMRV8PPoDYoNLEQ4+oU+lhJhFAL0qBurHzL/eUJ9HuOa8lvIgXpbJid8W3MnbKNgSEeM++pVEQNJmA8yySBFYyRk2xJi8GF5nRzqv84ILxvJAb7zaI/JsAO6CkRYi/OSDRe2oe/YS5jQa0w79fCwiayXK/FhY+ZNeUAiTtgPsFQ8vLxvTBZAvhRm62tXntkT6z4EEKGqAV4TXFdcACpP1w45n3NT6lf38szKV10uN4nOOfSo0N72DHLm4qXnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; dkim=pass (2048-bit key; unprotected) header.d=hmeau.com header.i=@hmeau.com header.a=rsa-sha256 header.s=formenos header.b=FQPHHqJJ; dkim-atps=neutral; spf=pass (client-ip=144.6.53.87; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org) smtp.mailfrom=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=hmeau.com header.i=@hmeau.com header.a=rsa-sha256 header.s=formenos header.b=FQPHHqJJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gondor.apana.org.au (client-ip=144.6.53.87; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zl6250dKNz2xYl
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Apr 2025 20:50:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=r/BRgULQpLgk5YaJQHiFfQ2T48zm7WZ1sUrce8geWiQ=; b=FQPHHqJJ4Yp8xo1uAdrbIDyO/e
	+BeauuZagD3c6w+tzPWasqnF44Xz1u41rfxeZt31BrsWb4sbITdmFC5S4/OrY8vhIvTZ/a5BNLm33
	ZkQr1v5nqim7o3ovlQFYoK0XcuQ3ntQUG6T5hc7E23aM0Igezsg2g1BRcr1VXpv1uiU1P5G9RMIsY
	Z0BBvdThrLHvb9tbmeMgnNIMXxWEI/MvsANPU2DsWSqlTcfSIt+mlLeo5b6AJh4I6ZEq1l0nSLHaN
	hTnppKLHw5w4hLDrM6g2raOMJ8TIQa14U85c3jGYzRtS02nib6cJdDcxF0CYxwfHa5ahLdr03R7Mb
	0oUSHsgA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u8d7L-001CiC-1a;
	Sat, 26 Apr 2025 18:50:44 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 26 Apr 2025 18:50:43 +0800
Date: Sat, 26 Apr 2025 18:50:43 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
	linux-s390@vger.kernel.org, x86@kernel.org, ardb@kernel.org,
	Jason@zx2c4.com, torvalds@linux-foundation.org
Subject: Re: [PATCH 11/13] crypto: x86/sha256 - implement library instead of
 shash
Message-ID: <aAy6g3nblKtRj1l3@gondor.apana.org.au>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250426065041.1551914-12-ebiggers@kernel.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel

Eric Biggers <ebiggers@kernel.org> wrote:
>
> +void sha256_blocks_arch(u32 state[SHA256_STATE_WORDS],
> +                       const u8 *data, size_t nblocks)
> +{
> +       if (static_branch_likely(&have_sha256_x86) && crypto_simd_usable()) {
> +               kernel_fpu_begin();
> +               static_call(sha256_blocks_x86)(state, data, nblocks);
> +               kernel_fpu_end();
> +       } else {
> +               sha256_blocks_generic(state, data, nblocks);
> +       }

Why did you restore the SIMD fallback path? Please provide a real
use-case for doing SHA2 in a hardirq or I'll just remove it again.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

