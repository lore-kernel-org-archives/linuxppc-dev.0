Return-Path: <linuxppc-dev+bounces-8208-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D712C369D9
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 May 2025 01:21:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Znx8g1gL6z30P3;
	Thu,  1 May 2025 11:21:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=144.6.53.87
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1746062483;
	cv=none; b=XsDIepD4cqVl8/qpbbQQQ/e09J4dWEi521n4PW1Js02+5k4ebyUb4DBxMRWdRq5RZtvReKSdd/C5QzMMs+gB+BnSaASJs/oUfIEcLW7K7vIsmFDroYv3Gj15tn4oWDe4FSgMxoiqhpSlIHmvbexhjB8L7uuC83m7MgC36cZMHPzkdR3g1l60hf+jfNQKRt6kCb2bYCohGO3F37YvS9ZE811MeGfCPdQbv529G4gkzPBPKqrIzBjjRo2dKCcMpVMvNYPuaFyCtA0IBvAnTxf8J/PzYBwpI6bZ3/FrBWXyKkoDPNr3rPq+rsLFG5JbCHC3C+S5DIrJanPeI7s+j3UhLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1746062483; c=relaxed/relaxed;
	bh=NW5f/6zfXSJgSFBDpq9nG7FU/uxSqKRQHQ8TMd0Poy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djXswK1+v7XPI0rXYxaNEai+SFLdZygotxrrUtUULlZq0ZIO/SHW7ATkx3gPqOwlMIuyLbLaLwKqlLT2A8pHd1ds87Ami/Mlctm6HEbRfh3FKMQ6jgTMXRskqjGKfzeLoGDaljP6IKWllaVW7Bh/mULZHukM7ycP9DPkWrhL5dJKRlxoidQ1eSyuubA4Xwv8elzivOmKRpSgBwuxE8yFL4cahgYqG+0hBlSc6Ago0zvtBUg2N/LG2l6ZeyJAnzARHTCLOU1B03wONny3NS7pMIEisNASl4yhj7tq/f//Xv/d2VBEtsApwmIPn/wITQCzsXE9vCiuHacpb04ai3PNEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; dkim=pass (2048-bit key; unprotected) header.d=hmeau.com header.i=@hmeau.com header.a=rsa-sha256 header.s=formenos header.b=a/NlvQqO; dkim-atps=neutral; spf=pass (client-ip=144.6.53.87; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org) smtp.mailfrom=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=hmeau.com header.i=@hmeau.com header.a=rsa-sha256 header.s=formenos header.b=a/NlvQqO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gondor.apana.org.au (client-ip=144.6.53.87; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Znx8f4V9gz2ygL
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 May 2025 11:21:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=NW5f/6zfXSJgSFBDpq9nG7FU/uxSqKRQHQ8TMd0Poy8=; b=a/NlvQqOeoRlesedjZn7kxOnFw
	uv4a9xzHl7D1VZeIL93rjMMAkhe5hxqE4x0m2n/FWDvbWRvtAX99hxnOhhW6vCIjzXO0BHZ3lqJM5
	RB9c0EnDFbkQGKZre/Y99u6FTj0aU0AbJGl20o5hnmiDJvj7wFkXsXvZtugU3t3vxsaSBA7xX9NFz
	wK8MiCgvwE6zOyaFZ4PnOSV/LXOZB/7xN/Nq+7ZCdajE/MnuryS2PJCBO8luW8qV3BFecbN+Fs9Ot
	Cw+tw3zJmJw9KzUB2KECxEtcp23uuxyS5Q/PBLXt9Z81aTgSodFT60Fy0hM+6eWtxA0rVUI0j3R7q
	BRzxY+2w==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uAIbz-002Qsc-2M;
	Thu, 01 May 2025 09:21:16 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 01 May 2025 09:21:15 +0800
Date: Thu, 1 May 2025 09:21:15 +0800
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
Message-ID: <aBLMi5XOQKJyJGu-@gondor.apana.org.au>
References: <cover.1745992998.git.herbert@gondor.apana.org.au>
 <20250430174543.GB1958@sol.localdomain>
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
In-Reply-To: <20250430174543.GB1958@sol.localdomain>

On Wed, Apr 30, 2025 at 10:45:43AM -0700, Eric Biggers wrote:
>
> As for your sha256_finup "optimization", it's an interesting idea, but
> unfortunately it slightly slows down the common case which is count % 64 < 56,
> due to the unnecessary copy to the stack and the following zeroization.  In the
> uncommon case where count % 64 >= 56 you do get to pass nblocks=2 to
> sha256_blocks_*(), but ultimately SHA-256 is serialized block-by-block anyway,
> so it ends up being only slightly faster in that case, which again is the
> uncommon case.  So while it's an interesting idea, it doesn't seem to actually
> be better.  And the fact that that patch is also being used to submit unrelated,
> more dubious changes isn't very helpful, of course.

I'm more than willing to change sha256_finup if you can prove it
with real numbers that it is worse than the single-block version.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

