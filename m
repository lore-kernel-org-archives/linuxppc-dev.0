Return-Path: <linuxppc-dev+bounces-10545-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB7D1C87FCA
	for <linuxppc-dev@archiver.kernel.org>; Sun,  3 Aug 2025 22:14:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bwDWS3DKHz2xlQ;
	Mon,  4 Aug 2025 08:14:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754259284;
	cv=none; b=dGYfOcSh1DNL91YvqTLkdjh4jX8XvsCG+ThwtUAcTRlBMKTGDEzXs1eBQAz0aHJBBBbuaaWt+vlXBcxMrYuND0+rXCmoUS0QLDZk3TkuiGgLaVfTVaYiO2yCBuWgBmzVgX9M0LGS/dpkLKS/C5SHdEqfrYef7BuQH0KSFB4Lc5l0j17zRMlx1EGBCXEQFlGJVr65TW5DQHhDRBsSbd34vBqjbrFXCClkVlBfDAY9DBApeVsHayaKkBs4iFzfoIwjyT7kOaaChKe0JpAVmaewnNgau8Vlyc3bYfgKXyzQGKA3lIs9iGZTvb4lDRo/pnwnuKDosgdu8op50JUgw72uDw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754259284; c=relaxed/relaxed;
	bh=z5FEu09wyOorgtN/1Xa4UXHn49U7IKwKjfXbwPFURuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lidofW/0AaVhEqaOT9LQy9Dr3HnS7LCQ057oX6OkmomrwRtvNbwoO55qrwdn1Ez6PkGnrgTuCQrPKlq2meI0gEAM2e3exJo/SnsXhASymIOrwJulB5ZyV/GG97gN7K5z6Ksa7CO/1jDqex9JYqWQEgWa3Qm3Qm+LsQ6hyCOUegeEx0ctGOqGIIU8bD3jk/AyB3M/dVUJftevUWaS7CetsSUvAdm9PHvEhLW25IkgqCZf15IxxdWWgCZon2x3qPEWTgZvBoppqtMNLbmnRVlkz3Nuk+S6qMuRdK2w8QYohmb5iWhHjm+1q73ehn3tXpyIYrbDyWbLJJC4OHzavtOCrA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oi1RAm7F; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oi1RAm7F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bwDWR5JmTz2xgQ
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Aug 2025 08:14:43 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 268AF459DF;
	Sun,  3 Aug 2025 22:14:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C19C4CEEB;
	Sun,  3 Aug 2025 22:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754259281;
	bh=olBu8GPPnFxFEX4luPW3wJTVVnKXrQ1s0KYtdiIrtTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oi1RAm7FfD6VjSXeapdnG5lXDK7EnlVbGejmSeausFjUEs6WbuvR6W5xCq9f9xAuK
	 fvPl4Xt+c4HdOfN360VF9KCTEhY4g+AcPgI01/ERRKWQH+Q/r22CfMVE7zMv2l80Aq
	 ozbMOM7QnfbyAobaz2lWPSUrLqzzYT4mxa01h7UZi33nMcxjs8VTH7RllzpnCz9+oo
	 fl4NtXZBBWKtMOhq/HD4o90xjV0ANn7ipqKKI5artQFunZhwqdAnm1my0zxiA8ZrT5
	 eiIFPXT+hQSdRbqGrXkCWdIe8PobgwR06E3DMRLquXtw+dLHDcU/iVTFqVyJ3lYLeb
	 ltEITkCxvbLoQ==
Date: Sun, 3 Aug 2025 15:14:38 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>, linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 3/7] crypto: powerpc/md5 - Remove PowerPC optimized MD5
 code
Message-ID: <20250803221438.GA119835@quark>
References: <20250803204433.75703-1-ebiggers@kernel.org>
 <20250803204433.75703-4-ebiggers@kernel.org>
 <aI_djr4v-3nQqG9E@gate>
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
In-Reply-To: <aI_djr4v-3nQqG9E@gate>

On Sun, Aug 03, 2025 at 05:07:10PM -0500, Segher Boessenkool wrote:
> On Sun, Aug 03, 2025 at 01:44:29PM -0700, Eric Biggers wrote:
> > MD5 is insecure,
> 
> Really?  Have you found an attack?  Can you explain it to the rest of
> the world?
> 
> MD5 is not recommended for future cryptographic purposes, there have
> been some collission "attacks" on it (quotes because such a thing is
> never an attack at all, merely an indication that not all is well with
> it, somewhere in the future an actual vulnerability might be found).
> 
> Since there are newer, better, *cheaper* alternatives available, of
> course you should not use MD5 for anything new anymore.  But claiming it
> is insecure is FUD.

Many attacks, including practical attacks, have been found on MD5 over
the past few decades.  Check out https://en.wikipedia.org/wiki/MD5

> > This commit removes the PowerPC optimized MD5 code.
> 
> Why?  It would help to have real arguments for it!

Sure, check out the commit message which mentioned multiple reasons why
maintaining this code is not worthwhile.

- Eric

