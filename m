Return-Path: <linuxppc-dev+bounces-25839-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D108C5CFCF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 07:22:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLtwS4D33z2ynr;
	Fri, 14 Aug 2026 17:22:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786692152;
	cv=none; b=lbPqcPqIk2L+pOnf4V+izBisdLCL+gv+Dg/Q3N2aMC3Y0Ipk42zdqyjg1WVyvsKLRahjtDm3qPH/uO9eAhRlfB6H76O4vtwf+oBsbbyyhCpvV/XTjy50DZa6vmzGRz4ZZsn7RTUjDQIAAfa0SCESK1cwHXglXah0j/vmfkoH4YnzeCGZHytGHR9JQ7vVa2wgWfMrBuYi21NLBdsAcjpS4aL7Rb60M60RvOo0j+8juJ5I82i3eFmF9EFGY4nUAjykCe81ALhVuCHuuxHIgbU9FTSf4rI+oVP3mWLY/K5I2tA7mHth5LQ6ejx0ZXUlDQXlNmLXNw5gh1vL+1b8fTtdyA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786692152; c=relaxed/relaxed;
	bh=5nsasYsVpqPL+PS1T0O/OPdX2crYTy9APW+0J4EPsqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THHAjGNiPe3cXpGU7qx8AIkrt3M1nppgSB4UWOJ8dUE6IEOa+poUAmGrg22i9JjGriJjJLcRzIQdSjQlJ7tB4Ii4707lomKtjrGdwAgDpmBqLbM80TrH87DT5HRBwSaHQAXVYHZtaov3HXHhM893WBZyv2lrdI1KTP0yhIxlUJ+RAT/uzdQDzDmNmvw1JuOpZQg60/XNdUhgNLB6HY5hY9QyzofNlMkMHNfbXCdMjjKifB9S6ZMatIR2K5+O/PQ3Q1pJlrbYgTmM6wibvGfnQW1Kez6ZAbYvMUJLJmrbLKrsd89ZKCKXcj0eoiHS0RbacF6/fuo7tqUrBcp0uCJfEQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PZdJsjtL; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PZdJsjtL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLtwR6Hsqz2yNj
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 17:22:31 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9D43840BE0;
	Fri, 14 Aug 2026 07:22:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D2D1F000E9;
	Fri, 14 Aug 2026 07:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786692148;
	bh=5nsasYsVpqPL+PS1T0O/OPdX2crYTy9APW+0J4EPsqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PZdJsjtLrZaFxUGs51rCB2U5saAMMm258m1HgOetllheuxIWBY1CFZe021AXh+TXE
	 GxF6usQ77ZAsfcgTlgOUWii2nkiEZbuOkDM1y/W6RfnHoTDDTevU/cHYtBStaLKC+N
	 UUow+nBQMBTvdgudOMX8RBOfNqm0qGJPdoWfz2T3Ymj7wvsh4YVyU/xeHz1X2wVDUB
	 K4cipgmFGR3OlyHHYcIYgljLPI3xS3golURmvxFY7+R1LgXzXAPVyMpMHmeDrOxAIv
	 TBetY3QtoOeqrSb024QBNWulX6lBiizlkBANiqfD47MXe7BZCs0k8hUEECvWbRatjT
	 +gRohztSaNwQg==
Date: Fri, 14 Aug 2026 09:22:18 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: shengjiu.wang@oss.nxp.com
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, Frank.Li@nxp.com, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, shawnguo@kernel.org, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com, 
	Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com, perex@perex.cz, tiwai@suse.com, 
	linuxppc-dev@lists.ozlabs.org, Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v4 2/5] ASoC: dt-bindings: fsl,easrc: add ports binding
 for multiple conversion paths
Message-ID: <20260814-pegasus-of-phenomenal-charisma-c1b3ea@quoll>
References: <20260813070020.719810-1-shengjiu.wang@oss.nxp.com>
 <20260813070020.719810-3-shengjiu.wang@oss.nxp.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260813070020.719810-3-shengjiu.wang@oss.nxp.com>

On Thu, Aug 13, 2026 at 03:00:17PM +0800, shengjiu.wang@oss.nxp.com wrote:
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
> 
> The i.MX EASRC hardware supports up to four conversion contexts
> (A, B, C, D). Add a ports container property to the binding to allow
> each independent conversion path to be represented as an individual
> audio-graph port:
> 
>   port@0 -- conversion path 0
>   port@1 -- conversion path 1
>   port@2 -- conversion path 2
>   port@3 -- conversion path 3
> 
> Each sub-port references audio-graph-port.yaml and follows the standard
> audio-graph binding conventions. Contexts are allocated dynamically at
> stream open time; each active stream direction (playback or capture) on
> a port consumes one hardware context.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,easrc.yaml  | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


