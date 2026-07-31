Return-Path: <linuxppc-dev+bounces-25189-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB951C5516F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2026 22:59:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hBhN70Ml0z2xlV;
	Sat, 01 Aug 2026 08:59:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785538774;
	cv=none; b=mGbUVsE4fmmRuKcxaNi2wGXm+Mrj9yUq7Luu2yb0FtPp2Hllh+S/Wtm0DCrjHw3xs9ebMdVeY1vvOYLBJtQgszUrRcJiVocdCzrcQNZU9Yeg+kzl8AqvJPkc4FpvOQz1pu7gGSq4lAlO0IojgBgVR0MH4d3O2RETKdq8AFOhci2Odus5wlJblvl1l4k81emrTfSil2uq9FSCsepKsxIAVAQ8sMeXJ5Qh/axmDSg59GZbVlTDBZW4WvK7v/u7LzvZp76npFko/fwhQAEK14adXH+oPnL9S5BRs5x3hFsTIPeLevU/HsLPVE7z2lT6VIJTyJ0PE86pJmnOB4bodaWI+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785538774; c=relaxed/relaxed;
	bh=MfyPXuzHFrgeP1BY9ER7yd6RDg+vnAlA5a1UueZqk9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewkLGO867l2HZWB7Izy+Ui6jlEjzLr+ua5YLFKCQdHd+bRxrg9TbJM8ho3h/3ZlwO8xWIG9TYEyJn8o+yxnzV55wcecZmUFh04pfY1lr051QHut9RqBOxN6YI+1nGmTp2yNZN6JeALW0a8uhSZovwyZwj0nrrPlhlO6uZBamjDxVST2ZmxQCky6EyM6+xbzwkyHllRenV1H849aFI2EU+aMTD+B7sLaCwOmHSu0E4YR5duRQMMIhEKS1aBv4Dgk5Y0gVXwys2jkiLv/HMfaFCj7b2j2hT1fHz14yeZemuGcHPpQni4hkmykEN5AkJSEzGnMGxTJT8GfjZEtJx++ccA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bS9G3Tec; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bS9G3Tec;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hBhN55LFWz2xg8
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 01 Aug 2026 08:59:33 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 18280600DA;
	Fri, 31 Jul 2026 22:59:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72EA1F00AC4;
	Fri, 31 Jul 2026 22:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785538770;
	bh=MfyPXuzHFrgeP1BY9ER7yd6RDg+vnAlA5a1UueZqk9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bS9G3Tec/7Iy9FTjR8vc35fepxYxeZolPIHJV02pj2ppUGeoTRKcFKKGhRbqiSXew
	 HsOvWKZBgUpMdQ/eyCcedegXjjYiRJwoWtzh61y7pDRek2U2DCufuxMLjYuCaDsRD/
	 BPreSUDR6nrs8I/HbLH1ojemW4lQ3rlq1E/EpeW3aylLWZ/blntGAjantnwPuabuGd
	 GnBywAxhFeSOEeLz0MQySmdvT6qj4wfTxvDMR3vjK7GAyVSDUjaVtaKu6j+txfsZTq
	 EXoV9Rp/xNnSavV7kTsyHEVeIOUyVSX6W5j+3+zd5YL0q3iFt3WaFGvMJk/gFCOxNK
	 sWLwJX8xX0c0w==
Date: Fri, 31 Jul 2026 17:59:30 -0500
From: Rob Herring <robh@kernel.org>
To: shengjiu.wang@oss.nxp.com
Cc: lgirdwood@gmail.com, broonie@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, Frank.Li@nxp.com, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, shawnguo@kernel.org,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com, perex@perex.cz,
	tiwai@suse.com, linuxppc-dev@lists.ozlabs.org,
	Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH 1/4] dt-bindings: sound: fsl,imx-asrc: update port
 binding to support multiple pairs
Message-ID: <20260731225930.GA2098187-robh@kernel.org>
References: <20260720095450.1618747-1-shengjiu.wang@oss.nxp.com>
 <20260720095450.1618747-2-shengjiu.wang@oss.nxp.com>
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
In-Reply-To: <20260720095450.1618747-2-shengjiu.wang@oss.nxp.com>

On Mon, Jul 20, 2026 at 05:54:47PM +0800, shengjiu.wang@oss.nxp.com wrote:
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
> 
> The i.MX ASRC hardware supports up to three conversion pairs (A, B, C).
> The existing binding exposed only a single generic audio-graph port,
> which cannot represent the individual pair endpoints.
> 
> Add a ports container that enumerates three named sub-ports:
>   port@0 -- pair A
>   port@1 -- pair B
>   port@2 -- pair C
> 
> Each sub-port references audio-graph-port.yaml as before.
> 
> For backwards compatibility, keep the old single port property but mark
> it deprecated. A schema constraint (not: required: [port, ports]) ensures
> that both forms cannot be used at the same time. Update the examples to
> show both the new ports form and the deprecated port form.
> 
> No existing upstream DTS file for fsl,imx-asrc uses the previously
> documented single 'port' node, so this change does not break any
> in-tree device tree.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../bindings/sound/fsl,imx-asrc.yaml          | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml b/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
> index 608defc93c1e..18d252722aa8 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
> +++ b/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
> @@ -78,9 +78,29 @@ properties:
>    power-domains:
>      maxItems: 1
>  
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    properties:
> +      port@0:
> +        $ref: audio-graph-port.yaml#
> +        unevaluatedProperties: false
> +        description: port for pair A
> +
> +      port@1:
> +        $ref: audio-graph-port.yaml#
> +        unevaluatedProperties: false
> +        description: port for pair B
> +
> +      port@2:
> +        $ref: audio-graph-port.yaml#
> +        unevaluatedProperties: false
> +        description: port for pair C
> +
>    port:
>      $ref: audio-graph-port.yaml#
>      unevaluatedProperties: false
> +    deprecated: true
> +    description: deprecated, use ports instead
>  
>    fsl,asrc-rate:
>      $ref: /schemas/types.yaml#/definitions/uint32
> @@ -125,6 +145,10 @@ required:
>    - fsl,asrc-width
>  
>  allOf:
> +  - not:
> +      required:
> +        - port
> +        - ports
>    - $ref: dai-common.yaml#
>    - if:
>        properties:
> @@ -188,3 +212,57 @@ examples:
>              };
>         };
>      };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/clock/imx6qdl-clock.h>
> +    asrc1: asrc@2034000 {

Drop unused label.

Presumably the existing example uses the deprecated 'port'. If so, just 
modify it to use ports and drop the deprecated part.

Rob

