Return-Path: <linuxppc-dev+bounces-16097-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FB7D262B2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Jan 2026 07:59:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dwxS86BTzz2yFg;
	Wed, 21 Jan 2026 18:59:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768982392;
	cv=none; b=olQRX+dj38x+WLKcw4ZKhuCc8odsz50h1A/9CkE8aZK8KQBy/uaFurbdXe18yBmgPk0hRe8M1ENVMug5xteUqk1yf1bmM4UJXjt0ZySVEos07OGeDjIOOyt71IPd9wPMR/IWlk8Pz+iV9qDl9rz+2fWk8QKcvWoh/w+2gdJSuP1tE91hgVzCrNHyXo8JCSqEYPxrULZNDef9jBZS3bWD/6R53FXqJqug8RHjpR21oEBFBdFodY40X8cFNaOOrP0+dxb9Efcntz9SLkQOw6APjn0xOmqy4FTf3LaEXnCWsR6WKBT96LEezKA1hoiesp+ggiATodzMA8vkTkX1X3Xadw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768982392; c=relaxed/relaxed;
	bh=6P0JX3xThF3EUdvfUoqh9VeURr09+ojeY4lRHnuXznQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cIZntKOtQRthqoY4b4lnS3Kaa27fa5k1QYP7/7izmLsiy1xDbdTOp1nabHYKE7DAJ4cRLp0CTjIrjc9nQTWkcWqxjJmHark17JFshqJ+vpckexL1BtOydiljBpAeqEyl7Ru+lb6KV0SUZMUET3AAbrcWRJAZySf+0QiK6SOPrbTkWdLAhq3kZHcTR06lGb2BewU5nhS6YFLINN/ro7g3IzwSp/96QED+pAyJg9N5A3R1J/jpKoiSRL248WRvPvxOVMRfmtiS9DhTTgMsK1lb4g3fV7YcuJef+dUjydGP32jxZvJzgOhPssrFAjOCLuDvoyLCLrEh/a6rAbzdaRn8DQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CgM8GGSm; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CgM8GGSm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dwxS82Pr6z2xm5
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2026 18:59:52 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 703D540628;
	Wed, 21 Jan 2026 07:59:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19E6C16AAE;
	Wed, 21 Jan 2026 07:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768982390;
	bh=lVIWh4J9elC8/GQ5p9OTBhZ3dYWROl05hspT5Eh9jUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CgM8GGSmTqWHJFpegeG2+oUmnmm6z5KRc+iEZY7EKuqzS9jjDWkkIEYjBS59bJ0G9
	 AZBf017wyEGE6D9Cm8xLFOKDs/GvRvujbc2udpU/OVaNGTlzpaTvrc4OCU5QAysSHB
	 T96kur/kbzI5zLzcVl6JzarBgfDhxrbNO83tEbsqCHDgt8m9OJ97NHry0ZwM2G/O9g
	 iCpDPG3XS385yk5vQEZJADykqyaQfqnHggcm3tdYaCs7TCjuwMr2qc6VWyH5tG62f8
	 dwfSCnAVCmh9FgPf+EmOiiH0CUkz0C924vXyOrm4QaHBbYPGUZZCBFqHOciluZizDO
	 d4BQ6AS6TkHIQ==
Date: Wed, 21 Jan 2026 08:59:47 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, 
	tiwai@suse.com, linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/4] ASoC: dt-bindings: fsl,audmix: Add support for
 i.MX952 platform
Message-ID: <20260121-magpie-of-wondrous-tenacity-6cf6fb@quoll>
References: <20260120035210.1593742-1-shengjiu.wang@nxp.com>
 <20260120035210.1593742-2-shengjiu.wang@nxp.com>
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
In-Reply-To: <20260120035210.1593742-2-shengjiu.wang@nxp.com>

On Tue, Jan 20, 2026 at 11:52:07AM +0800, Shengjiu Wang wrote:
> There is no power domain defined on i.MX952, so make power-domains to be
> dedicated to i.MX8QM.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,audmix.yaml    | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>

With changes to commit msg:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


