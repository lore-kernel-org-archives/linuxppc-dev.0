Return-Path: <linuxppc-dev+bounces-8211-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35882C3ABA9
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 May 2025 05:19:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zp2R01gvRz2ySN;
	Thu,  1 May 2025 15:19:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=144.6.53.87
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1746076748;
	cv=none; b=CkvKQ6SmhtOLWIH6TfqLRVHDRQ0XZtEVshYPiDcnmgRlEeC2RQd7xETr58Q0IhwkY+zAc1oRzC+y+h5yaS2daKES3OdPCOfUoJSDL/tMnn5CTNuuufn2RwfDrBerxqbHoyOpSjHne93c6Kci0OqZCfXVn1Spimy+K8X0IqzN52ASXQa0kHOzcSQkee6RsDth77S/on8D/0svlKZq9QydYEfdgNzkOXmyB9nXkVNRLmHCSU6wwdWC38kB4hqZz2Rj3j6k+dI+DK0/+h2dSgSq6pSFJWSe3GS3S09QYlfvElPXqavTNzUEhOLL76n44VmbMv3hlYFsDmvUQi69K4uWKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1746076748; c=relaxed/relaxed;
	bh=9t5+R7MBB1CitzsoU7qrOUojn4639+WchyM4zx0d4j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zhqv+XsFCKrG+Irri3hxFnpZ/6xcEvjaZvdGpb+XuXkNNetulCwPE1WRKtKWC1d2sTMHlomouYyBGPlW8RnVzEEWOI7/mW2ua0LtKeF2mAHR68wrUJeM53nDpjh5Jpx4dGVka3YE0zMFNYwJmNuVQyfXIwLCRRSxUtCgL+nDz8LevFDFl2tdJa/5/8I0TJqecMmJqboGnaQO1ceYVD83lCw8p8zON7xEQzCutQGAbfeavpKN7X2gwiDJhqWrSwwWBc+A7DZ1DFWvsExAeWBbD/mshgtvmLhu20tH4qfnTaIkx2C61Nnrjot1odET2zpD4nDN03d9TtP2WDbr4g94ug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; dkim=pass (2048-bit key; unprotected) header.d=hmeau.com header.i=@hmeau.com header.a=rsa-sha256 header.s=formenos header.b=ORsTUm+3; dkim-atps=neutral; spf=pass (client-ip=144.6.53.87; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org) smtp.mailfrom=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=hmeau.com header.i=@hmeau.com header.a=rsa-sha256 header.s=formenos header.b=ORsTUm+3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gondor.apana.org.au (client-ip=144.6.53.87; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zp2Qy2P94z2yQj
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 May 2025 15:19:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=9t5+R7MBB1CitzsoU7qrOUojn4639+WchyM4zx0d4j4=; b=ORsTUm+3tDs7MqOLXniwLbTENu
	6p8Ijou3tB4FtepjWe3F1A6W8IvySh95cZdbo6AzTOgys1fAFOnLjgZl/ixeJAU3uP78oydLi8D//
	yAax6cWpNxoAHYpOezO8beaYeuGHP68V4qdyQTdAirltbeZ3K5W1HWRLRdTu1DRHvIhqGACuMLtsD
	L4/ELm9xRzxjZE9uSzRBsLPKu384XEncFgdp8RWbWcWOQIo8DOJNbz9+cCdkKdgpDc51jJ2r9y5VI
	V7Wcl+IDdkPoN5XAqV8kKx2r8DlOwoCrwVYtmf6WPYNYB7nm6jKdpr5Y35dDNgam3PekRDwUujufp
	tuz3w6FQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uAMK4-002SVz-1M;
	Thu, 01 May 2025 13:19:01 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 01 May 2025 13:19:00 +0800
Date: Thu, 1 May 2025 13:19:00 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
	x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 00/12] crypto: sha256 - Use partial block API
Message-ID: <aBMERARvCQsl-5iN@gondor.apana.org.au>
References: <cover.1745992998.git.herbert@gondor.apana.org.au>
 <20250430174543.GB1958@sol.localdomain>
 <aBLMi5XOQKJyJGu-@gondor.apana.org.au>
 <20250501022617.GA65059@sol.localdomain>
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
In-Reply-To: <20250501022617.GA65059@sol.localdomain>

On Wed, Apr 30, 2025 at 07:26:17PM -0700, Eric Biggers wrote:
>
> Interesting approach -- pushing out misguided optimizations without data, then
> demanding data for them to be reverted.  It's obviously worse for
> len % 64 < 56 for the reason I gave, so this is a waste of time IMO.  But since
> you're insisting on data anyway, here are some quick benchmarks on AMD Zen 5
> (not going to bother formatting into a table):
> 
> Before your finup "optimization":

Thanks, I'll revert to the single-block version.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

