Return-Path: <linuxppc-dev+bounces-29627-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57070CCF2C4
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Oct 2026 17:34:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j6TSj2wmXz2xqr;
	Sun, 18 Oct 2026 04:34:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792258453;
	cv=none; b=QNJs395BN+6b8UjEXmqlbGO/w0iAArBSV9zoBffdhK7/ptjweqxogwPAxsnyQ6laIo2x1GVEM4w2BSoGAssOuO+UfsweGG/6l9hC4OgNfI6EFMnXiWJSKVc/Ks0ZLlATF0IADbtkKpshcaA8Ha3ZSzPKzCVRp5vEecBgVI8YxyEJVVvF6/3PXhppmGA6rEYtdaSNQptimsoqrvG6E6jzDefVjPoOT5DcDeFP/aSU32K+Al6LVkwoJ/8qvTRb02ukMo3o4Qf7kvh+XP74DEUr0s2/HMWmznbnLY90+8Q7XO4epNjALxeGujZNLGFCZFlRFeqWkrRUeIIXAUTdIgNq6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792258453; c=relaxed/relaxed;
	bh=7ZMZTPvh9tMJLNdO7mYMSY3WuW2Rj56qTgdyt1nrogg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZiT8Rhosk15TUUEHo2YEbZwWLb45zc8RTWjgLlGcJB0NGRrm6Wb7e6ooUS8iTI7pZIE2o6H0n0NIkxr44iVtqSQpToqxsvwHbMHC9fryXQj6WW+JoVrJ31k5tiWg7nPaIZG5y34Xb8XKWghanteLAmrDlf6D8s8JIsqDayL4Hd31FqDCXIJpB6RdsUgZ42u19kmvlvKl/Q7t9gkzfVunjXW2ftlTLz8b4V1fzYBN7Ua32MC0bansKTimJx/eiMq79I8FabN76foMLnq3pnIw/AsIrU/WtKLAJwCUrdE/SBncYRwRPtg6KFfdUAkKG2E1ZPG9pBSFUnCZl9GUieBShg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=JUi7yPBl; dkim-atps=neutral; spf=pass (client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com; envelope-from=marex@nabladev.com; receiver=lists.ozlabs.org) smtp.mailfrom=nabladev.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=JUi7yPBl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nabladev.com (client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com; envelope-from=marex@nabladev.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 79208 seconds by postgrey-1.37 at boromir; Sun, 18 Oct 2026 04:34:12 AEDT
Received: from mx.nabladev.com (mx.nabladev.com [IPv6:2a00:f820:417:0:178:251:229:89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bit raw public key) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j6TSh0DHLz2xmk
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2026 04:34:12 +1100 (AEDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D57DB105FB3;
	Sat, 17 Oct 2026 19:34:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1792258444;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=7ZMZTPvh9tMJLNdO7mYMSY3WuW2Rj56qTgdyt1nrogg=;
	b=JUi7yPBlYsym0othMpS5J+dTlNByXsPSEu0yY4K0tzee4Mt9vKkHtjALk4Ja3quKrwHpRh
	RgJqSt5ELaOBgXRZRS0gPjFgRJF1KwXPCRMzrVv0zXYULmKVTka5wtOtbm3aFb9p1SThEa
	4IBTpweRBmkOciJT6N8lDjHSoxwuthk1O3O8yfEBQs4Z1O1+uf1wucrSW58ruCmicU0k2J
	Wf+yJTTG0evga8/qKX6V02dmTc7LgNUVNjEMo9iS7vB3ukx+ClYxZkXpKevehAxUfujOMV
	ELmsH9+znF2F2K3wsV9+j63Rwlo9faZGEv7X0Dd7ewh9APWWWIKnN+52fUyByA==
Message-ID: <661412ff-3942-4d1c-be6f-1ef6c54620fd@nabladev.com>
Date: Sat, 17 Oct 2026 19:30:37 +0200
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
Subject: Re: [net-next,PATCH 2/2] enetc: Make eMDIO MDC rate configurable from
 DT
To: Wei Fang <wei.fang@nxp.com>, "Frank Li (OSS)" <frank.li@oss.nxp.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Clark Wang <xiaoning.wang@nxp.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>, Conor Dooley <conor+dt@kernel.org>,
 Eric Dumazet <edumazet@kernel.org>, Frank Li <frank.li@nxp.com>,
 Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <20261016193344.115518-1-marex@nabladev.com>
 <20261016193344.115518-2-marex@nabladev.com> <atKDNdxl0w65s8yQ@SMW015318>
 <DB9PR04MB933217F7ADCB6223A44DACA7889A2@DB9PR04MB9332.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <DB9PR04MB933217F7ADCB6223A44DACA7889A2@DB9PR04MB9332.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 10/17/26 4:24 AM, Wei Fang wrote:

[...]

>>> +int enetc_mdio_update_mdc_div(struct mii_bus *bus)
>>> +{
>>> +	struct enetc_mdio_priv *mdio_priv = bus->priv;
>>> +	struct device *dev = bus->parent;
>>> +	struct clk *enet_clk;
>>> +	u32 div, mdc_freq;
>>> +
>>> +	if (device_property_read_u32(dev, "clock-frequency", &mdc_freq))
>>> +		return 0;
>>> +
>>> +	enet_clk = devm_clk_get(dev, NULL);
>>> +	if (IS_ERR(enet_clk))
>>> +		return dev_err_probe(dev, PTR_ERR(enet_clk),
>>> +				     "Input clock unknown, not changing MDC
>> frequency\n");
>>
>> binding said clock is optional. If return failure here, it will block
>> existing dts, which have not clock property.
>>
> 
> For EMDIO device, the clocks property is not added to
> fsl,enetc-mdio.yaml, I suppose this property should be added to the
> dt-binding doc if the clock is really needed here.

Isn't this what 1/2 in this series does ? (maybe I misunderstood this 
paragraph)

> For ENETC device, we already have a 'ref' clock in the enetc node,
> so devm_clk_get(dev, NULL) may get the 'ref' clock rather than the
> system clock of NETC.
Shouldn't the clock be described in the MDIO DT node ?

