Return-Path: <linuxppc-dev+bounces-21761-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2414CD5BD0
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 May 2026 19:26:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gSVb474gXz2yrX;
	Sun, 31 May 2026 05:26:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780169200;
	cv=none; b=fJHN0kvkBdvFlcXmu2z2PlJDLkdV5o9poKYlZq9OtJmv8FRXrS9RG84SwUG0wE1Cq9EGMFcIVRNqbgfqCIMCt4Oh0AGGQ/4iRsvlwGK9+vQ1pUT4dSmp5T+yRPS2S1/2Cx42XlGpg4e9kNbxdumrAbZDmzaPjKki7YuTmrlT9FP1tLfKWAzjCotqNjtiJ3K9YdEJFtaWIOWD0nLwPqWve29F77lK6B/fI9fBg19VAEKEroCSvM7x2soZ0otdy4hJeNf8eLS5t6gpPONnBjgbcx/y2h3wAvC0vjeFMwudCHdg1dI+67WMNEkKhZCJ0bjKmKMmi5/A7mkTwzpTcfsjiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780169200; c=relaxed/relaxed;
	bh=z5GsolBXXG87q6U09vPL4wkhz04P58jv7onQiI/rtEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/FHl3s5/YfUGA3XVYsxozgAIGhCb16c/SWOldX9uuMi8WUIsxhmqRgZEaFDgK5ibHDxviqL+CoEKWUfkVnZz4UWNiouyfhbLw6tLLuo6/N6aqYGoYr3vnMytuqlFbBiD9YaTAMPhafSAb54PI02eO07URoSWEnkxrNJhPEgc+ZepuZIPwIL7cfCCRJeVBrVAemv5VBG3JEKYoPmgX5rVp8pFevjwfXRN5SPCkNCLoEQzwSWePCicn2OGS7XoZo/NSF5yqty+pPJdAL8WZKl5MXAiGpIvIShNlfxUS4syuxFXvy0TcCIKzRUzYMtfW323gAdiZcpdkIW8+YzWpoLeQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gE6tY2C1; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gE6tY2C1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gSVb361z3z2yT0
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 May 2026 05:26:39 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D7B8D43652;
	Sat, 30 May 2026 19:26:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7821F00899;
	Sat, 30 May 2026 19:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780169197;
	bh=z5GsolBXXG87q6U09vPL4wkhz04P58jv7onQiI/rtEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gE6tY2C169MjZGxfK1lZvyGSb6rNyisdk9hNjLiqAv/5UjrwIvu6eRjZKaI8FMafi
	 8SmYISFrENntrlZoRw6boLB8gRAwxqNVp47J48Md0Yq4HlZj6+KIfkwYn7vRfw0p7S
	 2Dp32qEn744GwPbS26zLypvHNJ0qxMC/a7I+n2OC82tGMyf340Rh51Z/syVlcLlJ0F
	 Fk2iA8WOWIyhuNhQ2JHVFQx91inAfMk+FJlFeIxjGZ901dFVnb6h5ZBW/81of9YPkN
	 z6bq8VVhQ5VpbdJtYF94j93q7ZArNcDoUMvGFO5jka8c0/vLKPukANTmjTf99wi+16
	 bfm+4HjNQ6bFQ==
Date: Sat, 30 May 2026 12:26:30 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
	Christian Lamparter <chunkeey@gmail.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] crypto: crypto4xx - Remove insecure and unused rng_alg
Message-ID: <20260530192630.GB6807@quark>
References: <20260529220430.34135-1-ebiggers@kernel.org>
 <5c74c261-53cf-4185-a8a0-7554bc9fe5f7@wp.pl>
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
In-Reply-To: <5c74c261-53cf-4185-a8a0-7554bc9fe5f7@wp.pl>

On Sat, May 30, 2026 at 05:05:19PM +0200, Aleksander Jan Bajkowski wrote:
> Hi Eric,
> 
> On 30/05/2026 00:04, Eric Biggers wrote:
> > Remove crypto4xx_rng, as it is insecure and unused:
> > 
> > - It has only a 64-bit security strength, which is highly inadequate.
> >    This can be seen by the fact that crypto4xx_hw_init() seeds it with
> >    only 64 bits of entropy, and the fact that the original commit
> >    mentions that it implements ANSI X9.17 Annex C.
> 
> In addition to a seed, the PRNG also uses ring oscillators as sources of
> entropy. The entropy should be higher than 64b. This is the Rambus EIP-73d
> IP core. The same IP core is built into eip93 (EIP-73a), eip97 (EIP-73d),
> and eip197 (EIP-73d). You can find the documentation online. The complete
> "container" is actually Rambus EIP-94, and one of its parts is EIP-73d.

Just because it may have another source of entropy doesn't mean its
security strength is higher than 64 bits.

I cannot find any documentation other than
https://datasheet.octopart.com/PPC460EX-SUB800T-AMCC-datasheet-11553412.pdf
which says "ANSI X9.17 Annex C compliant using a DES algorithm".

DES actually has a 56-bit key, so maybe I was over-generous.

And according to https://cacr.uwaterloo.ca/hac/about/chap5.pdf ANSI
X9.17 has only a 64-bit state anyway.  So even if we assume the
datasheet is incorrect and the algorithm is actually 3DES which has a
longer key, the state is likely still 64-bit.

So it isn't looking good.  And since it's an undocumented proprietary
design it shouldn't be given the benefit of the doubt either.

> This PRNG is also used internally for Generation IV with IPSEC offload. The
> IPSEC offload implementation for eip93 was recently submitted to upstream.
> I am not sure whether eip94 shares some of the logic for IPSEC offload and
> it will be possible to use some of the code.

That's not related to this patch.

- Eric

