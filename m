Return-Path: <linuxppc-dev+bounces-21760-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80708CD6E49
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 May 2026 19:12:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gSVGS6DMkz2yrX;
	Sun, 31 May 2026 05:12:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780168336;
	cv=none; b=AtDX7vlFO2gmi11Zr7SgwMBCyu5WSDKm7Quk4V8/VJ8ebJvnsGIk0Y5r+zF5I1JF/OCj6L6A1KgQm3vySNtqiQLPFmHPLIRxpkZiudKhKpLvTkDUFhMRNgsgM7PpPedjP/63Z5b/3Hf++6FCCmlOQ2iRt6IIP3+fKpl5IpxNMWS8MHO03pCHA3sRw9SjlSKz27MTqK7kJvSvdzG+p4fXEYTy2olQigPNNNcZ2DAjftKRSqiaH/qL4LWyrgAHSHks/4f8k/PXBBBwTWRyoiEckgyJbnRksyTs5kM3e+VMEcGZdbqtP92GQ5Ecnl2mY7yL4Clp+YpPfaO7dcJB/v13fA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780168336; c=relaxed/relaxed;
	bh=wuWV0UDN7XNlhZhb++Cgiht7/YenA/gl8ofUZVO9VMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNqf1pU4uta2Wp/HREdspEdCdSjOyKbMO+MHZF8R/nS6p2pQ4NL786tvjVK8aU3afvB1eRk7InDyBks6SBi6l1arpPVoFdfHxAZBuGnF5L3Jqna4dZZIMmie/J936mFMYIjV8WJL6kAVWrkF5IR79oMaPKWtXtN5yKaUxkVyK1R11kIxwPQhLGVwBCiraTDp8X5SR8V+Jbjzb1YEFjxuHjsZnnrOHPeKuPYEJWouYBWMSYYURQoEXqNsNz3tbV/+jbCKdm7zyWnfSAZspXCtoKlosK2XVnmcBCHdysQpUgn4AfpuxPCN5ZW1C01Ss5l79mwH78JLbdT4HL81utbWfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bOs1jz+o; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bOs1jz+o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gSVGS1M3vz2yS6
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 May 2026 05:12:16 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 77259408AA;
	Sat, 30 May 2026 19:12:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4BF51F00893;
	Sat, 30 May 2026 19:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780168332;
	bh=wuWV0UDN7XNlhZhb++Cgiht7/YenA/gl8ofUZVO9VMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bOs1jz+oauIQCmArH/fPM8HDOOrAHv/F7bMYh+FHVbJubtmHf+sgKD/tCUW6TEsbE
	 g256mN5wQ8CrEDMqDbFm3vhO/CtWEcENaGGoHDYmArQm1RWWX+mPCxyGX2BubIx9tZ
	 r+RR3/n/qEyxuUkcBhsTBdWLn4rVWGZ/ssSwSB0+X2eFJcaC+y5/m/QBViyZkbfqN+
	 /XonNk8OwW9Yg3ykoNOFeNBkE2Old6QgDvjtPaefzwddrSeOZqxx0tybAxKhLtj160
	 UYMeLhE/juU/JfS1Kg8C2h1ku/qWXuwnN9ckhkB1d2gj+0/8wiHu4702aBTgGhf6ce
	 pEL+SjY785pVw==
Date: Sat, 30 May 2026 12:12:07 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christian Lamparter <chunkeey@gmail.com>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] crypto: crypto4xx - Remove insecure and unused rng_alg
Message-ID: <20260530191207.GA6807@quark>
References: <20260529220430.34135-1-ebiggers@kernel.org>
 <e0b3cfc2-c6da-46d4-9dec-027dafaba74e@gmail.com>
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
In-Reply-To: <e0b3cfc2-c6da-46d4-9dec-027dafaba74e@gmail.com>

On Sat, May 30, 2026 at 12:20:57PM +0200, Christian Lamparter wrote:
> > diff --git a/drivers/crypto/amcc/crypto4xx_reg_def.h b/drivers/crypto/amcc/crypto4xx_reg_def.h
> > index 1038061224da..73d626308a84 100644
> > --- a/drivers/crypto/amcc/crypto4xx_reg_def.h
> > +++ b/drivers/crypto/amcc/crypto4xx_reg_def.h
> > @@ -88,24 +88,13 @@
> >   #define CRYPTO4XX_DMA_CFG	        	0x000600d4
> >   #define CRYPTO4XX_BYTE_ORDER_CFG 		0x000600d8
> >   #define CRYPTO4XX_ENDIAN_CFG			0x000600d8
> > -#define CRYPTO4XX_PRNG_STAT			0x00070000
> > -#define CRYPTO4XX_PRNG_STAT_BUSY		0x1
> >   #define CRYPTO4XX_PRNG_CTRL			0x00070004
> >   #define CRYPTO4XX_PRNG_SEED_L			0x00070008
> >   #define CRYPTO4XX_PRNG_SEED_H			0x0007000c
> > -
> > -#define CRYPTO4XX_PRNG_RES_0			0x00070020
> > -#define CRYPTO4XX_PRNG_RES_1			0x00070024
> > -#define CRYPTO4XX_PRNG_RES_2			0x00070028
> > -#define CRYPTO4XX_PRNG_RES_3			0x0007002C
> > -
> > -#define CRYPTO4XX_PRNG_LFSR_L			0x00070030
> > -#define CRYPTO4XX_PRNG_LFSR_H			0x00070034
> > -
> 
> Hmm, don't think these defines will hurt anyone? As these are part of the hardware spec.
> Or do you forsee a future where AI-Agents will sent patches hallucinating that it "fixed"
> the issue which readds it? I have no idea.

Well, there's not really any point in keeping these when they aren't
used.

- Eric

