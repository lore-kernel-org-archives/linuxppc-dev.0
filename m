Return-Path: <linuxppc-dev+bounces-16098-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C23AED262B2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Jan 2026 08:04:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dwxXy2313z2xqD;
	Wed, 21 Jan 2026 19:04:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768982642;
	cv=none; b=nB178CHL3B/jmL7Bz1Ha5st7wicPwaiqr5/OFJNgLwV2bYyeWPKD27VR/OdAE4AwR6IfsiTM3+5pr3f8onlC+z2auBP02i6yxSUyg87Ys1Ju/E1XcuZmaM/rZKDZQjPNDrZ6CllU+RsdExj5qLdnjNLa2nKQ4bSHLcEPwVR7bpT6osa6rrXiYEO3tHtD+S5IHZ6pb6LkIvd2Id4g7RwoAZ8uc3FEdgoByrhqGpruRmydUYNaRV4gNnr1475ppWMvYGgpUB96MqRHZrvydRjdSoTvjYp0ceEAuCIfARSjkf2dkBT6bsYgVLlIAwnZ3wQ4JVBhtqMhfYdh8Kr/nLui4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768982642; c=relaxed/relaxed;
	bh=Xv3xSS/bdGOprgZ1T80+vXW0tSiJgpNOTTOrjvC+KbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0bx8hKj7c+L6clQPH1YDkS+csQ3czTlClKpi4ElERCr5ZyBUXAViX8lV1Ekh+UI/q505T5Gxbxw9kxdOM+wiyTYp3LHgG3F6FmW/pWX8gonTjlix2BVWHWUs1bc2smj9obKJPqIRi9sd6E1UtD86+wZ6ExguGe+6phJz9wS4uwh8q3r60m94uvZRjW/BaogFhym73FfcInTSGL+M1XJnponzvTahd4QrrMd8qB/LS+D5Bv+JHxeIAjylln3IaGl/321LJLjfEjlw92fhL/W4jjCDNlJuWv6FZYwKiieN8y7M8rd+qJFdJQTTdZkoZGt7FIazyXwf7zpwgt8q36LtQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nZ1vmbG+; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nZ1vmbG+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dwxXx32lgz2xm5
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2026 19:04:01 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CCC4540871;
	Wed, 21 Jan 2026 08:03:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E830C116D0;
	Wed, 21 Jan 2026 08:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768982638;
	bh=PsqDsmtUvSMoAGPchw0ANb9blEgv2FuLIEh2Q6T95uo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nZ1vmbG+beB2iwfhyj3XVTL2l++mCmI6l5ZmExwsa68lW58lTMGsTDs6Xs+ZkM6oy
	 Og7ixvumC6seNlVkVoEBb/17yi/LiSgNvXmuCkRw6rtwKL+atFAfvaPCNZpzLog7q1
	 YDFBy3X69Liig5y8ZQy8ResbG6BcbU21IVgsfcLmDSjvmI/cQ3g02sqjxZpguNdKjC
	 OndH9JSnSqgOMh7/uw7/5d3igi6NzPxuluvUmUkxQQJyoKVrpR35g3GbSaDGQzOiFx
	 ItIpu/Qn7FJrpCpj+xKt7Xbhlkgk2ODhP6QDdS1xSDJeyfhExvHl77ubmICS9ntTE+
	 0pCtHucBM4DcA==
Date: Wed, 21 Jan 2026 09:03:56 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, 
	tiwai@suse.com, linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/4] ASoC: dt-bindings: fsl,sai: Add AUDMIX mode
 support on i.MX952
Message-ID: <20260121-careful-beige-iguana-c32bbd@quoll>
References: <20260120035210.1593742-1-shengjiu.wang@nxp.com>
 <20260120035210.1593742-3-shengjiu.wang@nxp.com>
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
In-Reply-To: <20260120035210.1593742-3-shengjiu.wang@nxp.com>

On Tue, Jan 20, 2026 at 11:52:08AM +0800, Shengjiu Wang wrote:
> The SAI can connect to AUDMIX, but AUDMIX can be bypassed or not on
> i.MX952, so add 'fsl,sai-amix-mode' property for this feature, with
> this property present, then SAI driver will try to config the setting,

I am still not sure this is hardware static property. You say "can be
bypassed", so I imagine same board could have it bypassed or not,
depending on use case (so mixers).

> fsl,sai-amix-mode = <0> is bypass mode, fsl,sai-amix-mode = <1> is
> the AUDMIX mode.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,sai.yaml       | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,sai.yaml b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> index d838ee0b61cb..7808c324eebc 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> +++ b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> @@ -133,6 +133,13 @@ properties:
>          - description: dataline mask for 'rx'
>          - description: dataline mask for 'tx'
>  
> +  fsl,sai-amix-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint32

Anyway, string is more readable.

> +    description:
> +      The audmix module is bypassed from hardware or not.
> +      Bypass AUDMIX(0), AUDMIX mode(1)

Drop last sentence and use enum [ bypass, mode-1-whatever-this-means ]

> +    enum: [0, 1]

What is the default? What is the meaning of lack of this property?

> +
>    fsl,sai-mclk-direction-output:
>      description: SAI will output the SAI MCLK clock.
>      type: boolean
> @@ -180,6 +187,15 @@ allOf:
>        properties:
>          fsl,sai-synchronous-rx: false
>  
> +  - if:
> +      required:
> +        - fsl,sai-amix-mode
> +    then:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,imx952-sai

There is no such compatible.

> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.34.1
> 

