Return-Path: <linuxppc-dev+bounces-19782-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96FD9F433CB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2026 21:51:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwvx64y4Kz2xSG;
	Thu, 16 Apr 2026 07:51:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776289898;
	cv=none; b=NEYkjsQ7Fn0iNXXXgOPD4KFShNOCeuYDQCeppAlAjvCadxSY1mHy5Cr9t2x4dZgTEjtHJ//KWOnO2aU8qAJ+/bjU+TSV55vTvxWwe3ylWciF6spelHSSNM22C4mAzIfJILnRPpqd/Q0j2LoCNKriFJ+47J6LNlUwgTqVL+8HZzPeyo+7xYMegX98J2ABN349jhVaeJCkkE98bmHeTFnUxCHKcK5hQiS3MDgLPL3Ssq9zq5g5X4tIsWKduFlseee7bSGTpJShXjWc8saII7iXagWXOe1OLIlBnR+437e/a8UEiREhPN2WlZwY+BJjkDFwOsfwN58eTW3jZTeI8EYzxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776289898; c=relaxed/relaxed;
	bh=2WAHLSd4pZqNhNIuWO2SKir7nFz9tsmccVtpfBpLA60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQ1yDl9GECq34uFK5RYeHvk4K9Z/cOhNY9ACdHWXg64ZDMPsn0B7yJaedpa97lOlp4aLSjzQhMz1ss/I+5L743DrGYFC5R0VcWlV3ibFcJCFEpVeYU0eck9AiG+YFGCFYeVt7EihpFzsORRfrmdu/BM7hbgp7zhHMLSrzWsQ/xH2aTp/C6kHpwAI3Ol3zvw9ruzTVnoIL/HtI0wb8upxyQdFXvyokjrML6SruNo2xl8XgTkQmEU/yFNR33mwYUrLCPLJfIRdX+h2WkdFvl57UlOKgi7J+m4s1xke4/V4VFvg4TRtL9itZbYStxOFKXrySFt/BExrMLKMmyCqXje3Kg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GyHizvdg; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GyHizvdg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwvx559Llz2xPL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2026 07:51:37 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 73C9743D33;
	Wed, 15 Apr 2026 21:51:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDEBC19424;
	Wed, 15 Apr 2026 21:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776289890;
	bh=oyZwUyRQzG/nIYpblsarSIbWA3aKj0rWxz5YN4dmVvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GyHizvdglc+29LgsaGAWqaYVL6ZYI/hYXuMgOIsu/Zi8LFkNtJj22L4xRaesCDyxx
	 56gK+ShdTMhvUwTuDaJKwvx75vfy6rkw5u7MBiEkgK9McC6z9JYfSzckKZ/9t8J1rn
	 EMFM+6wpvuDb52SRP9FnDqKPBLVl+tMw9JHUfX4wgCwyUUhgrZUmGqx3tkzNyoi7bW
	 o88eNOnIyBlMxApe04QezRYHHAHC7AScrwcuSyM0v2t9hmLTsFjiurQFT0xr0XhRA/
	 HfkpOdwNDKWy6sINOIFlvmjRtE3LY2uf387N81A9d7rsu9Qrv64u5AViTcWTkOL0Ek
	 y7CyFYVuyJlhg==
Date: Wed, 15 Apr 2026 16:51:26 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Marek Vasut <marex@nabladev.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
	linuxppc-dev@lists.ozlabs.org, linux-sound@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>, Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
	Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: fsl-sai: Document RX/TX BCLK
 swap support
Message-ID: <177628988619.723274.6196056382812573083.robh@kernel.org>
References: <20260404183547.46509-1-marex@nabladev.com>
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
In-Reply-To: <20260404183547.46509-1-marex@nabladev.com>


On Sat, 04 Apr 2026 20:35:00 +0200, Marek Vasut wrote:
> Document support for setting the Bit Clock Swap bit in CR2 register
> via new "fsl,sai-bit-clock-swap" DT property. This bit swaps the
> bit clock used by the transmitter or receiver in asynchronous mode,
> i.e. makes transmitter use RX_BCLK and TX_SYNC, and vice versa,
> makes receiver use TX_BCLK and RX_SYNC.
> 
> Signed-off-by: Marek Vasut <marex@nabladev.com>
> ---
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Nicolin Chen <nicoleotsuka@gmail.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Shengjiu Wang <shengjiu.wang@gmail.com>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: Xiubo Li <Xiubo.Lee@gmail.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-sound@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
> V2: - Drop | from description
>     - Update email, rebase on next
> ---
>  Documentation/devicetree/bindings/sound/fsl,sai.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


