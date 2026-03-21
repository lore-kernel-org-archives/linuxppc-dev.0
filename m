Return-Path: <linuxppc-dev+bounces-18544-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE661094462
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Mar 2026 09:29:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fdDdq5gKwz2yYq;
	Sat, 21 Mar 2026 20:29:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=180.181.231.80
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774085343;
	cv=none; b=aPkICR64B0OCc+GbAQwecJZsZB2VzjMMB3rtxAPV85nz+BoGT+6XSeK7uzCLBX2+sfXHTiZHh/DabrfTNkPP24YAjHrsefgG22e1UKkjgOt3AFR2O77JIBlWS10kDCfAiyq5+UlJlfltkbV4hLPMmwneR0Ka0Zr7hjVcjesimOPnsHXN0XIiUhqIP5npV7m4TqyJTzu00HqwCmdyOlgPzU4t4JGeJ9xpvbySZW1GEhAWdZbE5QCfMHAOoDumQCUEFMt8J3EXFm9o3sSONaCCMMUWkOeLbxjM9KbvId8SerIakN1TL7AIqW4TxGagAm+CKV+b1ZvJgXRKSYRGOfrg7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774085343; c=relaxed/relaxed;
	bh=J+H11LAznX/cYognNg/use6inBDXVLaU4zUxBBkfRsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHby6q3WRUCZOKleABPLQ2Sc/N9TWcPAXYdnOQ0mtGFpaxwjLKFV/3KLS/CraVf9XzIjxKZHx8cBSsb4IAqYawxF4v6ckFurFKIWKi6ZiIeZ5o1/j+EBvSz69/ycjPshOrY9Z5wA24XfR4oUNoKBQUH5u5+GbZv7vUN7s93i84DP/ewHitMb+S9uSl8zRus0y9+/tjgsIErextFGXSfFiWFU7FzhvfDCfLTaSr5NGTDjRfCiEams0+xtWDsqic6IxiwTermHR+SdXY3C0QFl/6h6h2DydWUDJB8A+PeQNoQI2vRG7ANJoFZojiZuaDgFYyB9HAyA8olj6y7IjJ2/Xw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; dkim=pass (2048-bit key; unprotected) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=n21HfaNi; dkim-atps=neutral; spf=pass (client-ip=180.181.231.80; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org) smtp.mailfrom=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=n21HfaNi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gondor.apana.org.au (client-ip=180.181.231.80; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org)
X-Greylist: delayed 2381 seconds by postgrey-1.37 at boromir; Sat, 21 Mar 2026 20:29:01 AEDT
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fdDdn2wltz2yWy
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2026 20:29:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=J+H11LAznX/cYognNg/use6inBDXVLaU4zUxBBkfRsk=; 
	b=n21HfaNiD/Il9DoR1xKdn2MEHcCWWqQIQueJPl2/miKej9euHnNZmQ6JzsBW0JOQHJem7H49xH9
	VX7zz8H027nCdcXGEBzgjbEoDHu0WWktPE9GWP4F5anVvd5BkwQ8ghcqRCXev/gaIcpEjLX+SfSz8
	bHpyAmYvj+QD9Bu+j8YYPVXMH5ALirspbZ272mZ6fUfotLKgU1ZDxze3z/NIZ9Hs/hrMqUayWIuGM
	c4FIO3dUmvxfbw2TROu2ZcJ4S2KrMwVMUNuZMOiwg92CBdcOW2g+G5Qxfg5DtB/jvU5bCXDNVQujv
	E/xjFGBut4hidpx6I4CzzDzCvwvMMg19QKaA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1w3s11-00GJAS-28;
	Sat, 21 Mar 2026 16:49:04 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 21 Mar 2026 17:49:03 +0900
Date: Sat, 21 Mar 2026 17:49:03 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Haren Myneni <haren@us.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Dan Streetman <ddstreet@ieee.org>, stable@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] crypto: nx - fix bounce buffer leaks in
 nx842_crypto_{alloc,free}_ctx
Message-ID: <ab5bf7kayDrxyUNF@gondor.apana.org.au>
References: <20260311155645.397083-4-thorsten.blum@linux.dev>
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
In-Reply-To: <20260311155645.397083-4-thorsten.blum@linux.dev>

On Wed, Mar 11, 2026 at 04:56:47PM +0100, Thorsten Blum wrote:
> The bounce buffers are allocated with __get_free_pages() using
> BOUNCE_BUFFER_ORDER (order 2 = 4 pages), but both the allocation error
> path and nx842_crypto_free_ctx() release the buffers with free_page().
> Use free_pages() with the matching order instead.
> 
> Fixes: ed70b479c2c0 ("crypto: nx - add hardware 842 crypto comp alg")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/crypto/nx/nx-842.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

