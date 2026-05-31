Return-Path: <linuxppc-dev+bounces-21769-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDA3CD6E5E
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 May 2026 16:01:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gT20C4zJGz2y7r;
	Mon, 01 Jun 2026 02:01:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780243307;
	cv=none; b=OpHM/S8ADmpSHc5Pnqqc5uNS8iNYJjrpVac1biKh26eE4qFh7tnGrtpQ7eN6+MTLkJvHnD/qb5G5+JigC5NK50lCHN/12wTR+bDi5NoDHty9SmQUVlJTxGWwIoQoVEP3A9sh4rAwjHa4GTKVGqXIRI/GvAeoI3m2pr+YSWPWvgpJC6qjAgX38QiWITks5UpZdzzlnpUdDyRI5f6IzN1OQ73JN0iQ7ah3ETxeyut73m7pMtBlm8sadbrnc8hHy2Ktmlb+02+cSr8tD+qmVo4KpK+S0JkKCVl7MbK/rSJ1TVpOYP4CIsg8mO/e6LmWQwN6cxqKQjfIe8ix14zprmmZug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780243307; c=relaxed/relaxed;
	bh=ps2TjyB09tV9voLQd4jP0mWt7CpejjrGG3yYcZeN2+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzGf5rNkZiVDbDw/RC048+C/jyRuQ5xYTHExWPlQWZTybh5K/tfQAhMz3/N+IB8A2HlvMrPs794LcITqNG9IMGoqKUCVTvE5vykp2BKb2eGAoUQKgyofVfpijuwlRaMxXPYBFU9xVdmee4N7fTVgzn+qgQ07IXqy1mgE7TwmuSb/vY99BqpqlLv42OTjaCuxvGvVuIbEunTlO0OZH3uCGa760jek8DXKzXCsxmb426do6CBu42iu75KhZ4YLjRDhEAWNhVAMD2SmYj9dQ8iB5bLc1/p7SoVLKdRQQmB+iUEqFjdVH87AcPbCc5MYd9I1QH8xJjC0Gn/QBsCtiDi3fg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ialh5EIq; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ialh5EIq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gT20B2dLjz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jun 2026 02:01:46 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 856AD418A6;
	Sun, 31 May 2026 16:01:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FF71F00893;
	Sun, 31 May 2026 16:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780243303;
	bh=ps2TjyB09tV9voLQd4jP0mWt7CpejjrGG3yYcZeN2+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ialh5EIqBZjQ1Fuj2nwl996CNtiTfS1EcPFgjXmt7/kZuU6/Qkjf8CwkcdNY2ohX+
	 Vg5ttoC4+58UL+TX7jc4eBQt7clET3tnBW3LOnz7gcFmmCO1YH6moMP65QwkD7Ba/o
	 9OUjlb6xYCHTCSeMayA+hojJ9GgSxnACmNYVqblCSKMkUkTmy2t23TLFxnvE8njWX0
	 CXk6cIYK30sL0dwCORiF1OGWwh5b5QJlGQLiHEGSPTtTtj0xE6F87BUegYqShJ7b7q
	 1j8M+TLJ9YB7hAF4XhGx/4uQFnSH+/DTabyv6nqpLH+osktiIvF+2BICmEMo9SESRM
	 DKscjz1ri6smA==
Date: Sun, 31 May 2026 09:00:20 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
	Christian Lamparter <chunkeey@gmail.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] crypto: crypto4xx - Remove insecure and unused rng_alg
Message-ID: <20260531160020.GA2255@sol>
References: <20260529220430.34135-1-ebiggers@kernel.org>
 <5c74c261-53cf-4185-a8a0-7554bc9fe5f7@wp.pl>
 <20260530192630.GB6807@quark>
 <465adf3a-2c27-43d0-afdb-68ae12b89d10@wp.pl>
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
In-Reply-To: <465adf3a-2c27-43d0-afdb-68ae12b89d10@wp.pl>

On Sun, May 31, 2026 at 12:15:49PM +0200, Aleksander Jan Bajkowski wrote:
> Hi Eric,
> 
> On 30/05/2026 21:26, Eric Biggers wrote:
> > On Sat, May 30, 2026 at 05:05:19PM +0200, Aleksander Jan Bajkowski wrote:
> > > Hi Eric,
> > > 
> > > On 30/05/2026 00:04, Eric Biggers wrote:
> > > > Remove crypto4xx_rng, as it is insecure and unused:
> > > > 
> > > > - It has only a 64-bit security strength, which is highly inadequate.
> > > >     This can be seen by the fact that crypto4xx_hw_init() seeds it with
> > > >     only 64 bits of entropy, and the fact that the original commit
> > > >     mentions that it implements ANSI X9.17 Annex C.
> > > In addition to a seed, the PRNG also uses ring oscillators as sources of
> > > entropy. The entropy should be higher than 64b. This is the Rambus EIP-73d
> > > IP core. The same IP core is built into eip93 (EIP-73a), eip97 (EIP-73d),
> > > and eip197 (EIP-73d). You can find the documentation online. The complete
> > > "container" is actually Rambus EIP-94, and one of its parts is EIP-73d.
> > Just because it may have another source of entropy doesn't mean its
> > security strength is higher than 64 bits.
> > 
> > I cannot find any documentation other than
> > https://datasheet.octopart.com/PPC460EX-SUB800T-AMCC-datasheet-11553412.pdf
> > which says "ANSI X9.17 Annex C compliant using a DES algorithm".
> > 
> > DES actually has a 56-bit key, so maybe I was over-generous.
> > 
> > And according to https://cacr.uwaterloo.ca/hac/about/chap5.pdf ANSI
> > X9.17 has only a 64-bit state anyway.  So even if we assume the
> > datasheet is incorrect and the algorithm is actually 3DES which has a
> > longer key, the state is likely still 64-bit.
> According to the datasheet, there is no second source of entropy. The PRNG
> has three built-in LFSRs. Each of them can be initialized independently. The
> first LFSR is used to generate input data. The second and third are used to
> generate keys for DES encryption. The output of the first LFSR is encrypted
> using 3DES with two 64-bit keys. Between individual DES operations, data is
> XORed with the seed. It sounds like a fairly secure design if properly
> reseeded.
> There is also a newer design (EIP73a) based on the same algorithm. The
> only difference is the replacing of 3DES with AES using a 2TDEA scheme.
> The DES-based variant is more widely used, even in new SoCs.

Okay, it sounds like you're walking back your claim that there's a
second source of entropy.  That leaves just the 64-bit seed that the
driver writes to CRYPTO4XX_PRNG_SEED_L || CRYPTO4XX_PRNG_SEED_H, which
probably corresponds to the "first LFSR" you mentioned.  The driver
doesn't initialize the other LFSRs.

> > So it isn't looking good.  And since it's an undocumented proprietary
> > design it shouldn't be given the benefit of the doubt either.
> > 
> As I mentioned earlier, this IP core is quite well documented[1] (page 198).
> Half of all SOHO routers have the EIP-73d built in. The algorithm is also
> described in TRM for some of these SoCs :)
> 
> List od SoCs with EIP-73d:
> AMCC PPC405EX/PPC460EX,
> Intel/Maxlinear GRX350, URX850,
> Marvell Armada 37x0, 7k, 8k,
> Mediatek MT7623/MT7981/MT7986/MT7987/MT7988,
> Qualcomm IPQ975x.
> 
> [1] https://www.scribd.com/document/734250956/Safexcel-Ip-94-Plb-Sas-v1-5?_gl=1*dng4pf*_up*MQ..*_ga*OTQ4NjkzMTAxLjE3ODAyMjA4ODI.*_ga_Z4ZC50DED6*czE3ODAyMjA4ODEkbzEkZzEkdDE3ODAyMjA4ODEkajYwJGwwJGgw*_ga_8KZ8BV0P5W*czE3ODAyMjA4ODEkbzEkZzEkdDE3ODAyMjA4ODEkajYwJGwwJGgw

The option to download the file is paywalled.

Anyway, even if it turns out that this is secure (it won't), it's still
unused code that should be removed anyway.  The fact that it's not up to
modern security standards just provides some additional motivation.

- Eric

