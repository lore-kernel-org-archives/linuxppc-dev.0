Return-Path: <linuxppc-dev+bounces-22471-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34DBCD98C7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 08:48:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbbrn1RxSz3bpP;
	Thu, 11 Jun 2026 18:48:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=180.181.231.80
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781167689;
	cv=none; b=jGy6JY0fY2dsaaspWZjXF5NCq63iQ7w0X7vBZdx8vcCKRNAcsH43DOBrToq41mozRwbrDZcxvPufromZRtw6XvsuRHkFefDKdku7ftxhiYMAzDRyMDsgFxtDPyvrqJjAPL4lxp3jmfV73mGdN+zt0IJO7Tw/QDnOzrUWnqs1uzsxay8g2bLpOmJLP+PSy0S4nMZqPHCVrxXhU2fULlWXpbboMAUi44rva6jiPsg1QDu9TBni50iCNUzOsJx5JdzSmQvzox9p/xezgyv/QrB3ZPlfRduIJIvL78BD+ThA7Sko22azqCa/VZSwm2Z/L2S7uvVPGufWfnvLQBFJI33fAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781167689; c=relaxed/relaxed;
	bh=c3j48vW+9D5m6shOf5DXD0lLDgCnzW/Ek78ImnixKSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYhucI9NGiT9i+Znup+97vK/6XqQyP2gbJZmp+vjS7xb8QTPVlkIbKabgNcEGL1bI8l5B2llavFqblkOjgk2KMm/BRB38UfusutNCQMfKPm7tmgnfayrKYj1sMs3uQNOq8YlDxu+oq9uqvEUKgWCHS8LMiUK6CAU+nP4mG5ZuKUao2afcLv3O29XCvr58UCKcL9yJGcSDL6PWzB/MR04an/yC4+pXWwDLegidwbu7ydOdSgXou9wWbKg7plioNX/AkAwUY0rC3TkeD18XzDNX8nkUSbd2o+ZsinbjjH+YVy4QAvCOf09sUo3zE9dDUcOTHV9pxYwFnihymsiAMgBsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; dkim=pass (2048-bit key; unprotected) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=mfixcgMH; dkim-atps=neutral; spf=pass (client-ip=180.181.231.80; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org) smtp.mailfrom=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=mfixcgMH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gondor.apana.org.au (client-ip=180.181.231.80; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org)
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbbrk32nLz2xmV
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 18:48:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=c3j48vW+9D5m6shOf5DXD0lLDgCnzW/Ek78ImnixKSc=; 
	b=mfixcgMHgRBcAHB30u1ynUg9Tappp5HybmPW5Kf0dH0t2yixJzKi56B+GYfSg6n1hJY+tJyXZKm
	WvDL3jwdXRnwT0vodSotZjF2rfihR2H7Km+6JbOoLdBr9QiEjhjcBsw3YCbdd3ii8tra7Id2E79U/
	4HUqFxFL8A7XOJERYfB9B4U6NfdRnxo/cf5Cgx35BdNzkdLuJGwmpOMcOhno/IOC3g51e6N5Pzli2
	d7YaAcBvMPSRxBCbMu+nSE3/GOD/0FqH9i39mRmhA51s4cwvYoaF/yhbDHTmZ36FLVmIAW5mEPHUi
	p6EwG0toEAp7yyWfjlc2FsSb2aquVKwBZZ2A==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wXb4y-00000004XRV-35Ww;
	Thu, 11 Jun 2026 16:48:01 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 11 Jun 2026 16:48:00 +0800
Date: Thu, 11 Jun 2026 16:48:00 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, Christian Lamparter <chunkeey@gmail.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] crypto: crypto4xx - Remove insecure and unused rng_alg
Message-ID: <aip2QHfRK9nEZMMJ@gondor.apana.org.au>
References: <20260529220430.34135-1-ebiggers@kernel.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529220430.34135-1-ebiggers@kernel.org>

On Fri, May 29, 2026 at 03:04:30PM -0700, Eric Biggers wrote:
> Remove crypto4xx_rng, as it is insecure and unused:
> 
> - It has only a 64-bit security strength, which is highly inadequate.
>   This can be seen by the fact that crypto4xx_hw_init() seeds it with
>   only 64 bits of entropy, and the fact that the original commit
>   mentions that it implements ANSI X9.17 Annex C.
> 
>   Another issue was that this driver didn't implement the crypto_rng API
>   correctly, as crypto4xx_prng_generate() didn't return 0 on success.
> 
> - No user of this code is known.  It's usable only theoretically via the
>   "rng" algorithm type of AF_ALG.  But userspace actually just uses the
>   actual Linux RNG (/dev/random etc) instead.  And rng_algs don't
>   contribute entropy to the actual Linux RNG either.  (This may have
>   been confused with hwrng, which does contribute entropy.)
> 
> Fixes: d072bfa48853 ("crypto: crypto4xx - add prng crypto support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  drivers/crypto/Kconfig                  |  1 -
>  drivers/crypto/amcc/crypto4xx_core.c    | 88 -------------------------
>  drivers/crypto/amcc/crypto4xx_core.h    |  4 --
>  drivers/crypto/amcc/crypto4xx_reg_def.h | 11 ----
>  4 files changed, 104 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

