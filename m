Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91714606A329
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Oct 2026 01:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=gkhjrsVg
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7w6G0S4dz2y2J;
	Tue, 20 Oct 2026 12:38:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792460293;
	cv=none; b=A5lYXAi74b1/uDHobC9evx3QCwFWJ+IH5pIESXecwWCyCPU5k8FYg3QuRLeINXg1XhQbCb9GOMrs1/snY84EEPdBoTPqeuHbHOFUZmx+5uVMvu7QtLkexVyehLrA9TiXdYBkFMurHtY2aHGR+ljPrVrs1D+rhV/dO738cS/b+vVTXL9ql/9d097/uZYFpRdhrUnqko7IokAff3UNwfrnk/NcFe0RXFME8oDASEuRj40jG36pvTFTe5bOXGSn+XYfRBQg9wKfIlK/FfvXmKzUzI0+LYX8C+XqgECKUs2wYKT14xFf8TsWAUgFhNKEO8bvXZQDHg3fkCQJCyCbcq263Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792460293; c=relaxed/relaxed;
	bh=PbjFjYksln6X5VCuok/GYUEp4Jt2bFAm9SetP90rGcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MobUSw3HYwVcv7jxXIgc1NMsowsH6qCMQWTC/EKPftqErVBJUl1A+yvaR79yRu6kZq1XzA3sAip36E+rEhCbUEz6h29LiLiQWNHyhac9r8jYJesQNdyYb3W9YEsoXLICw0Jtk+9ddeb8/uzhJrAPXk//1do+vBwPt3W9EdL4mr0X76u5/KmpKMcR+MQ0MrYAo+xolqdgdEd24qYPToGxTNDNHMCxB6uZYz+WsKH9ChFp5yHhkgZldKhxBClZMNvFaYpYp73f1LCnKh26P78Q15sh6I8nsZYcF3iDCzV/eHI7U6cbkSVZ4Q+Fos8h0Z4q2EoFAzoD9W7c2Go61bciPw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=gkhjrsVg; dkim-atps=neutral; spf=pass (client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com; envelope-from=marex@nabladev.com; receiver=lists.ozlabs.org) smtp.mailfrom=nabladev.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=gkhjrsVg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nabladev.com (client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com; envelope-from=marex@nabladev.com; receiver=lists.ozlabs.org)
Received: from mx.nabladev.com (mx.nabladev.com [IPv6:2a00:f820:417:0:178:251:229:89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bit raw public key) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7w6C2TdCz2xln
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2026 12:38:10 +1100 (AEDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E71FA108825;
	Tue, 20 Oct 2026 03:37:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1792460281;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=PbjFjYksln6X5VCuok/GYUEp4Jt2bFAm9SetP90rGcM=;
	b=gkhjrsVg8YdzKJiWw+oBJJoGOWMSaX2plJh2ECGP6pobGez/hDtH0UV4Rc2GlxMKP/fXbF
	mFRHOvJDQ5/kcprfkbErcvoAO2cidfW1VgzDUdVmsiwoKZq51M2pIyMSiB9+mFd5e2Y+XE
	zIrWXd21uoO8qiwXwxlMoS1cEEkqb5V7RipLdtD1smpxlx42HVcI2xhjn7frxAydftEr9K
	BRNUqGr0Hyai2/OODFby0KhwLg52WWQJ0Ndu4cZfDaERlK07618LcHO8wB2hrcFgrUvMa/
	vQkCTJEDpb9ssDuGPZeYe/7oi7OrMmtFkutPvii2Ku6bc20iYPHtQno+K7cwGw==
Message-ID: <fe920b05-6d89-4dc1-83d3-0664fbc2e00c@nabladev.com>
Date: Mon, 19 Oct 2026 18:10:18 +0200
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
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
 <661412ff-3942-4d1c-be6f-1ef6c54620fd@nabladev.com>
 <AS4PR04MB933821150913BDCF35C4827F88982@AS4PR04MB9338.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <AS4PR04MB933821150913BDCF35C4827F88982@AS4PR04MB9338.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/19/26 4:59 AM, Wei Fang wrote:

Hello Wei,

>>>>> +int enetc_mdio_update_mdc_div(struct mii_bus *bus) {
>>>>> +	struct enetc_mdio_priv *mdio_priv = bus->priv;
>>>>> +	struct device *dev = bus->parent;
>>>>> +	struct clk *enet_clk;
>>>>> +	u32 div, mdc_freq;
>>>>> +
>>>>> +	if (device_property_read_u32(dev, "clock-frequency", &mdc_freq))
>>>>> +		return 0;
>>>>> +
>>>>> +	enet_clk = devm_clk_get(dev, NULL);
>>>>> +	if (IS_ERR(enet_clk))
>>>>> +		return dev_err_probe(dev, PTR_ERR(enet_clk),
>>>>> +				     "Input clock unknown, not changing MDC
>>>> frequency\n");
>>>>
>>>> binding said clock is optional. If return failure here, it will block
>>>> existing dts, which have not clock property.
>>>>
>>>
>>> For EMDIO device, the clocks property is not added to
>>> fsl,enetc-mdio.yaml, I suppose this property should be added to the
>>> dt-binding doc if the clock is really needed here.
>>
>> Isn't this what 1/2 in this series does ? (maybe I misunderstood this
>> paragraph)
> 
> Sorry, my email filtered out the 1/2 patch, so I missed it.

No worries.

>>> For ENETC device, we already have a 'ref' clock in the enetc node, so
>>> devm_clk_get(dev, NULL) may get the 'ref' clock rather than the system
>>> clock of NETC.
>> Shouldn't the clock be described in the MDIO DT node ?
> 
> The enetc_mdio_read_* and enetc_mdio_write_* interfaces are not only
> used by EMDIO devices, the ENETCs and NETC switches also use them.
> NETC switches and ENETCs can access external PHYs or internal PCS/Serdes
> through their own port MDIO registers, instead of through EMDIO devices.
> 
> Your first patch only modified the EMDIO binding-doc, not the ENETC and
> switch binding-doc.
So I need to patch also 
Documentation/devicetree/bindings/net/dsa/mscc,ocelot.yaml ? Any other 
binding document ?

Thank you for your help !

