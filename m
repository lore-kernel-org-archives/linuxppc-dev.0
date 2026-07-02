Return-Path: <linuxppc-dev+bounces-23438-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E63C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 17:39:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grkdp1D0Lz2xdb;
	Fri, 03 Jul 2026 03:39:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783013950;
	cv=none; b=Fn96gwEUtz+g9a4YrNa7u1t2xOVOZfF+WwS1xeYdKUvlSsQv9S6MOfVZN7xZLCVJG4F/fnnyAPx9dBZtRdVR7ig0ts0uO3LBunFj/nvcLnoctpFVq+03nAH5fkgcTZRegfWJvxSFftWtiNA6MOrAI7Z92Vlcj/TZvHjlUpgraN6v3t194nO15XF29CYLcEBFpI5PZG4bU7mf3lOmY6dhm3moC5XmPuzyESpSsoF5XFSrgOj/HC+JHHeNNPdtfL66aP3p2YZkXxK+TasMkT0X1EYH1L37zSXNbHDl8HS5+qFrWAnG0eoi1BeoCqwwh18U9Oo8BedDXJGev6Y/GWDpqw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783013950; c=relaxed/relaxed;
	bh=nqmuPPmfP9VFcLThHSDeBnpXUiiV8nG4V34GV0c7hOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lvJN6Ck1Z3c7FSWqBkUj19DevSiT2Ld81FbpP4m1Ym+NA/YkEnATc4oMMRj/puFxrjF+tRNrAIa0MvmYfYx2GHeC1t3opzy1vY/kV3CCigjpXeTW7mrjxMdOC1Y7RhW36tg7+QNpPOyG96AiNGqUKKiUt0uuFP7zoQ73InBF+ZkiCjZC2kUFi2W2fJ4Vh096ISNd3H5QxrZEsvm+We6Oh+gOSEGZx46bdxIYh3ZVXjcUOpfrj9nDx23Qhf3aZ7A/OUg00btT+l9/9vF91ciktdwgIRg2iz95EkpY67xDxv64uS0Mu919WIy2ZYnZeA8Tf6b288rBTmNaufLYMtmN+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Kc/AXq//; dkim-atps=neutral; spf=pass (client-ip=185.246.84.56; helo=smtpout-02.galae.net; envelope-from=maxime.chevallier@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Kc/AXq//;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.246.84.56; helo=smtpout-02.galae.net; envelope-from=maxime.chevallier@bootlin.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 494 seconds by postgrey-1.37 at boromir; Fri, 03 Jul 2026 03:39:09 AEST
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grkdn3J2Mz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 03:39:07 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 339D41A0DF0;
	Thu,  2 Jul 2026 17:30:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F2B02602EE;
	Thu,  2 Jul 2026 17:30:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 90FCB104C958B;
	Thu,  2 Jul 2026 19:30:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783013447; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=nqmuPPmfP9VFcLThHSDeBnpXUiiV8nG4V34GV0c7hOk=;
	b=Kc/AXq//tuSUAOD406+lAEEvx3VeHJAeHfcb4ALztzre2D+frAtf/I9C8kI5ykr6SF4pX3
	t7zLeeL/l4zixdSRttiAuF9YAtkQ5hiy22Uf5zn9epnwzhpVxJMKg0uxtsgwtsEEtwsMav
	O4JKcL2oVvBd9siz6dqEeUE3qf6bnnUaiIhDU2x0uHEvmFfwgcVVn3V4kAqosy1fnYUVck
	SA9jk5Z8+R6OWunRDah0pF4wi98UWDkdhvt0dSdjB52eeZOE8jDqVd+E7JcO2GYU5lqdrh
	qfnTzmPblF7shcNYUFTE+7DtEUERRUPfMZ8BVIady+0xAyOsNBOZDPySMExAWA==
Message-ID: <7576597d-6910-4d58-95b3-28ca64f42b57@bootlin.com>
Date: Thu, 2 Jul 2026 19:30:39 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 07/14] net: enetc: differentiate phylink
 capabilities for pseudo-MAC and standalone MAC
To: wei.fang@oss.nxp.com, claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
 xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, wei.fang@nxp.com, chleroy@kernel.org
Cc: imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
References: <20260702025714.456233-1-wei.fang@oss.nxp.com>
 <20260702025714.456233-8-wei.fang@oss.nxp.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260702025714.456233-8-wei.fang@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 7/2/26 04:57, wei.fang@oss.nxp.com wrote:
> From: Claudiu Manoil <claudiu.manoil@nxp.com>
> 
> The ENETC pseudo-MACs are proprietary internal links that do not
> implement any standard MII interface, so restrict their supported PHY
> interface modes to PHY_INTERFACE_MODE_INTERNAL only.
> 
> Since pseudo-MACs can operate at any speed between 10Mbps and 25Gbps
> in multiples of 10Mbps, set their MAC capabilities to cover the full
> range of standard full-duplex speeds: 10/100/1000/2500/5000/10000/
> 20000/25000 Mbps.
> 
> For standalone ENETC, expand the supported interface modes to include
> 10GBASER and XGMII in addition to the existing RGMII, SGMII, 1000BASEX,
> 2500BASEX and USXGMII modes, with MAC capabilities up to 10G. MAC_1000
> is replaced with MAC_1000FD to explicitly exclude 1000M half-duplex,
> which is not supported.
> 
> Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


