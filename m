Return-Path: <linuxppc-dev+bounces-25658-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754FEC5AC82
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2026 07:14:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJQxF4c7lz309y;
	Mon, 10 Aug 2026 17:14:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786346081;
	cv=none; b=Rfk/p/W5XWWb0waK7XKgj2DXfUnltQu0U0cNABEpkGtJrwX7kcgTwSZBXhU7kYfgR0hDyFyt3G9ug1303GCRxQMQcKDZnblPJJCydq/OPJIO/GsUjhbh4hp6Bntxx5u3mur81NEJrFIOwRpkF7rg0DG0OxR/6EVjx6WXCjWGWz764ppPv3RfZTVE6HZF4v6/czsKEc2KdF/50OCGwLuev9dvnQeodacPC+uymjsqVh7DLg/uXV4WmjMW8kZUA7jFyLlnwZQ189rA8dtHvtxnXWsWgJuWDst3/x7jUF+IOho0JpF3M4H2ib4I51MivPKNBXa1waM9MVuc78RBVu4CiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786346081; c=relaxed/relaxed;
	bh=3tNAkI5vPOVX8HetVxMd0XhWn0MZflkc+mnZkRCDPdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlgD3ZsajLBJQl2Tcg3cKNw/iDS5upNMnXlpbKkU+Nqdkdpmg4SCNP5s7Zq0fKw+5utnUNZtTASZa0Dr/wqbZJLMhGc87ybmXLlwf4oJ3DuEp8xWYh4zp0AcnThbMNafYwrzKUGttO3TD0cdDfTxGRjVRm1BwG45eTzdv0qQFDQ1piUnqtUyIOI81NC9Ba7bad8u6yLrKhBRUYmdxT+PeOeFEVieECmv2z9n7u2ynjVJXdps9+3o1WqTLv/0KkPwNIImcbid8q8HgmHYR8UvrxMtkzUg0/OCaKfWSfAv1P+yF/monhMI7kxye4f6Cj7W9K9H+Ccdf8sG7M1olgrv9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X7ronXcd; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X7ronXcd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJQxC1L6lz305D
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2026 17:14:39 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B2AE640224;
	Mon, 10 Aug 2026 07:14:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1DD1F000E9;
	Mon, 10 Aug 2026 07:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786346072;
	bh=3tNAkI5vPOVX8HetVxMd0XhWn0MZflkc+mnZkRCDPdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X7ronXcdvcEuXosufT2+KbF+82VRzRQueYNYrv0YC5Isef6VGJZAU5v3WP6mwLZcq
	 5GQAxziFxT6+xFMhaN4tm8zVRzhlzet+1skX2m34LVhRnoewm+q3XqAK8hz1sMPq86
	 aE+SAHptjsCt5rJraZByYq5DR5iv+B1azs+6wbgX+BXdY+TU+DayG1YwlPTaX0n+vG
	 4uy8yPi2Gtrotr/TgpmFSXtNyc64OFkG3BA0jV7aZp1nZcJJ/raqSuvQWiPcU3VBss
	 aAORSjvJcAjsjvkq9T6s4sLCOIseteyYPwrhlB4fCfFnA5FfFPlTXp152Bv7UixqiD
	 7AUL3GPkpqpUw==
Date: Mon, 10 Aug 2026 09:14:28 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: shengjiu.wang@oss.nxp.com
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, Frank.Li@nxp.com, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, shawnguo@kernel.org, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com, 
	Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com, perex@perex.cz, tiwai@suse.com, 
	linuxppc-dev@lists.ozlabs.org, Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v3 1/5] ASoC: dt-bindings: fsl,imx-asrc: update port
 binding to support multiple paths
Message-ID: <20260810-normal-cuscus-of-argument-4b230b@quoll>
References: <20260804100218.49587-1-shengjiu.wang@oss.nxp.com>
 <20260804100218.49587-2-shengjiu.wang@oss.nxp.com>
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
In-Reply-To: <20260804100218.49587-2-shengjiu.wang@oss.nxp.com>

On Tue, Aug 04, 2026 at 06:02:14PM +0800, shengjiu.wang@oss.nxp.com wrote:
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
> 
> The i.MX ASRC hardware supports up to three conversion pairs (A, B, C).

Which SoC? Did you read this binding you are changing?

> The existing binding exposed only a single generic audio-graph port,
> which cannot represent independent conversion paths when multiple pairs
> are in use simultaneously.
> 
> Add a ports container that enumerates up to three sub-ports, each
> representing an independent conversion path:
>   port@0 -- conversion path 0
>   port@1 -- conversion path 1
>   port@2 -- conversion path 2
> 
> Each sub-port references audio-graph-port.yaml as before. Hardware pairs
> are allocated dynamically at stream open time; each active stream
> direction (playback or capture) on a port consumes one hardware pair.
> 
> For backwards compatibility, keep the old single port property but mark

Why? Did the old hardware change that it has more ports/paths?

> it deprecated. A schema constraint (not: required: [port, ports]) ensures
> that both forms cannot be used at the same time. The binding example is
> updated to show the preferred ports form.
> 
> No existing upstream DTS file for fsl,imx-asrc uses the previously
> documented single 'port' node, so this change does not break any
> in-tree device tree.

Does it break other users of this binding?

Why mentioning upstream in the first place? Either this change breaks
ABI or not, explain that.


Best regards,
Krzysztof


