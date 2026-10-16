Return-Path: <linuxppc-dev+bounces-29626-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1941CCF2CA
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Oct 2026 17:33:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j6TRH4XPvz2yTQ;
	Sun, 18 Oct 2026 04:32:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792258379;
	cv=none; b=L68QdiH4wwf3+rmy+UXS/IvSYtS0xsoRTrYe83nT7Jz8TVYojkK/XA9c5CmJPdslnpQaEhd3F0+YUnqRxaQj6RqG+HrisADs1EnVVlmi+bXi77hb7sG7HBNJB5UIrLTNph/ZX8SYGhDG+4HLDxiPnU4ESOpoj/nLJiY5+a4gpdLQ8ZRDypZ0OWzA1xmPGaJEdeZimTbkC3lWdlm8xorBdDcvBT7TGKQoBycPtSte6A7Qn9qHNUbpQQ1cVIiWt+WkXJoOckwAM15MOkibb7iJs+d3zNh4IkxJqQeyEowl4Cl2ydENBPpzj/4T4J/DLmX+n/8l3YwsdXxQtR5YKGD1rA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792258379; c=relaxed/relaxed;
	bh=0PboifeeUBu+En/QUnp8Dze9H/89JQuESMLCW2nSTi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WSRxFjc+TUPyTJYg/DT/SptO02qTqABC4p6Zu4i87kf7icPAlGTlO8+5xjpnUbb8O9K9ITeh6ej62zX9b4rdRLDWxo+wHVQYiXqEO+pOUP/zh0j/UW814qSzic3CmvdOxTEzDrfc/vIiUyKsmn4C+3yw09upKTwd/leZ/ltcy4Txpej/t54GceVflOt7PV9/QAi9T0efAysIwINZu1GhSjLa0bF0Bha0chcINwZQ3ZJHRcWTCr9kW2870Jvx0D5Q53Ch0zGHwU6V8d8j7/JyeKntvk1gJoRWcPya3WN/tN4F99DCQuhY0YLicZDuqESyfEff3MF10qYpREjZ4To4wQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=bYit+MJr; dkim-atps=neutral; spf=pass (client-ip=178.251.229.89; helo=mx.nabladev.com; envelope-from=marex@nabladev.com; receiver=lists.ozlabs.org) smtp.mailfrom=nabladev.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=bYit+MJr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nabladev.com (client-ip=178.251.229.89; helo=mx.nabladev.com; envelope-from=marex@nabladev.com; receiver=lists.ozlabs.org)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j6TRG6PHWz2xbQ
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2026 04:32:58 +1100 (AEDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E0413109C7B;
	Sat, 17 Oct 2026 19:32:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1792258372;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=0PboifeeUBu+En/QUnp8Dze9H/89JQuESMLCW2nSTi0=;
	b=bYit+MJr1x/TFwh8IMEuyMS7y0hQzeHzdvc+wxFOClJEgGlZ2xFrqX0Gsy/uxeqFVO66+b
	joHDJ4BBaEypkc8u8iVW6fOBJEfOZ8tpFhoSqqKFlpsICoa5e6b4XakyisLlGXQfH6gHHg
	bBZa7EyiOiqQa/dYNYB6iwXJ9mDbHRd09YwHoRa+jilLYMYkHL7liejfjEFbalR7F0B+MW
	cFfHcgKJKy+FTE3jDkjKjH9Z62rVtb7aZwnrOwGqtaxGLmyh3dvyMhijQVDiB/FHyzNUHA
	6GwoK9Z+xorwKfo5C592zxEVbAR8E63pIeFN6+hLO1NEVuw/NkCZjEXvO3Wh3A==
Message-ID: <32239c97-e1dc-416d-8570-f681f91df0c8@nabladev.com>
Date: Sat, 17 Oct 2026 00:26:36 +0200
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
To: Andrew Lunn <andrew@lunn.ch>
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
 <20261016193344.115518-2-marex@nabladev.com>
 <725fe351-bdd0-4b53-b551-0f638d02f98a@lunn.ch>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <725fe351-bdd0-4b53-b551-0f638d02f98a@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 10/16/26 10:59 PM, Andrew Lunn wrote:
>> +	div = ((clk_get_rate(enet_clk) / mdc_freq) - 1) / 4;
>> +	if (div < 5 || div > 0x1ff)
>> +		return dev_err_probe(dev, -EINVAL,
>> +				     "Requested MDC frequency is out of range, ignoring\n");
> 
> Returning -EINVAL is not really 'ignoring' the invalid value. Since
> these are optional properties which are present, if they are not valid
> returning an error is good. So please fix the message.

All right, done in V2, thanks !

> Why is dev < 5 an issue?
The clock would be way too fast, on MX95 that would be over 33 MHz.

