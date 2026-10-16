Return-Path: <linuxppc-dev+bounces-29625-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD41CCF2C4
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Oct 2026 17:32:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j6TR827vQz2xmk;
	Sun, 18 Oct 2026 04:32:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792258372;
	cv=none; b=PXDAaAFsSn6gLRYqdCNEpHhp0uv5KIuCjeWovScXDtA+FmRs0TOm4YxXXS4rozY/VGfDazeDcoOXbPcVcfq1BhZjuizChEWMmFeFW86It52lOmI+7nZmTKOrMKiCtnKUxQXJWDY0ERPi3rBFLmqoKqtSM/9czPi9L9rpUZCCCHOGjUD9qS+Hl2ZbuyM2Xj7NuT3yjHldMwxlof2wH3FtcOddd9UAr9VmStorMnKXN6A9bisAnRh08M5ruYjfVcsYadJGYGliJEEdsg5qSwxvxmcMG4lY43Q8sLvlcG9Q64+GX95hyEkyWjhhT0AfjSAXnSx3zmfSxC25PnBbl0IEEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792258372; c=relaxed/relaxed;
	bh=gOGIRzzzR0vzZdCdgNOPxzBc4k7KuaPHEI2DL4pIPwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mFOqNAs32jabMwT21nwChwbw9QqXKz62Yojnn3HMHn7+J2ue+Em91AoEJtEsm4eg+8pm5u+U+jCYOfVqI0S9ycnbMKuYHKtrbzb4aP7HmG3STi8dF++DJdfWXCl3dpMDriUDDVPp6BsQIz5bJJWaDxu8y3xTJOkrU0twO1i9ubJPgnabK0x3ViN4fBzs4D0RPkWunuBKSrlXI5PaV7YDRyny9Df8PdjfOTXPSI0LE2bTjGF02ilmVyPIi8Cnuw+TkjzPyh+7zRtAfJAizGx5OX7p8lhnOPRbSpEdlibYsw6PZWa2vb9iabfhCutsPTrI0u40IAJZ+RqVW9yLQiLmmQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=NJe2De6d; dkim-atps=neutral; spf=pass (client-ip=178.251.229.89; helo=mx.nabladev.com; envelope-from=marex@nabladev.com; receiver=lists.ozlabs.org) smtp.mailfrom=nabladev.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=NJe2De6d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nabladev.com (client-ip=178.251.229.89; helo=mx.nabladev.com; envelope-from=marex@nabladev.com; receiver=lists.ozlabs.org)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bit raw public key) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j6TR54h3Mz2xbQ
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2026 04:32:48 +1100 (AEDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F16D8105FB3;
	Sat, 17 Oct 2026 19:32:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1792258360;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=gOGIRzzzR0vzZdCdgNOPxzBc4k7KuaPHEI2DL4pIPwY=;
	b=NJe2De6d9yMBsAIyHgnWUF4nKZu9OND0sgMZkUEkHsg5woqC9kyaczQTArtK2tevf2S6tM
	9qn9wzt/NbkmDwrS13Ii2WUGTm3CACAwuYOmutnz6HUCrAF5GaxlDiQrCf3C1D8P3b1sZw
	OPl+JEYCiGVaHUGpeg1OkTzzIWz4BXWs1/U8xJ68XuG+3Q+7qx0joL1hDuTDsrEV7X9CYl
	D80mBi99+Z8KMgxo3mOvl6x7xwk2unBMI3G0jrmny1O2sHtH1BbbBE5vC8SZEl9V6upivH
	3t4xCn7VqbbSnYNmjKUbUuzX1JS+tuppNZUEDxHDuvg/yV+xR7pcxUMJ6DDLpA==
Message-ID: <329d56ac-00ce-4fb6-87fc-eeb14ed78959@nabladev.com>
Date: Sat, 17 Oct 2026 00:04:14 +0200
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
To: Frank Li <Frank.li@oss.nxp.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <vladimir.oltean@nxp.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Clark Wang <xiaoning.wang@nxp.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>, Conor Dooley <conor+dt@kernel.org>,
 Eric Dumazet <edumazet@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 UNGLinuxDriver@microchip.com, Wei Fang <wei.fang@nxp.com>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <20261016193344.115518-1-marex@nabladev.com>
 <20261016193344.115518-2-marex@nabladev.com> <atKDNdxl0w65s8yQ@SMW015318>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <atKDNdxl0w65s8yQ@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 10/16/26 10:04 PM, Frank Li wrote:

[...]

>> +int enetc_mdio_update_mdc_div(struct mii_bus *bus)
>> +{
>> +	struct enetc_mdio_priv *mdio_priv = bus->priv;
>> +	struct device *dev = bus->parent;
>> +	struct clk *enet_clk;
>> +	u32 div, mdc_freq;
>> +
>> +	if (device_property_read_u32(dev, "clock-frequency", &mdc_freq))
>> +		return 0;
>> +
>> +	enet_clk = devm_clk_get(dev, NULL);
>> +	if (IS_ERR(enet_clk))
>> +		return dev_err_probe(dev, PTR_ERR(enet_clk),
>> +				     "Input clock unknown, not changing MDC frequency\n");
> 
> binding said clock is optional. If return failure here, it will block
> existing dts, which have not clock property.
> 
> should be devm_clk_get_optional()?
Existing DTs are fine, since they don't define clock-frequency property. 
And whoever wants to define clock-frequency property, they also must 
provide clock property.

