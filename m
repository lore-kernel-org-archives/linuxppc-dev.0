Return-Path: <linuxppc-dev+bounces-29614-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D2ACCF2C4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2026 21:27:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5yhc3MKkz2yhP;
	Sat, 17 Oct 2026 08:27:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792186064;
	cv=none; b=JzYb9wtlFknT+knL0nPZTosGFBuI5pRoVU6uCMuL5lq7FhSflpXYiK0MqX6nsIlYKgKKkAsf0Eg4g7bnGhan8hTWkWwJAVH4usfz2XLKJOEr0ta/5yO5CjfcFhkfWCQM/Qx5a80jnPCsHIeayuSq0S9dqJzMrbYzVwoXJofsSRcU0tufOM3L2/8Zdq58fFkKRgmdUQ+4vaFNQw/Jfukdll82Ne6mM/nrafjuU/wASNLKPE4SMLoc9zlEouLU4aks3SWWlBzIE/92K1M5aBc/1LcDjMIdzp/pf4Ll5zhBMIhkSp97KKUV7W6aDYnKypTh5bC65oym4/0Pu43MZ7advQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792186064; c=relaxed/relaxed;
	bh=vtJqI8YsdfW+gxZii/Z1VxgXOvJbDlTlvuwqPo5TN7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ftdkaf1JSx5ewLDpHVM/pXtTFcAfzADP8rCB/hU3w/AEyaJccp7gzSfh2/O7UGZUNBeial95hi+iJV3M1Jzzk0AhPIwNbyi62Mun5PZr4YUbX3+yJnDFjOPeTxOQdAbBfXc14U7ahPhpIhjJspqjmUQcwg4CJCKMspXN/T0uTLZ3khLo9ztXOtZOM8+R7gsg2leKDq0y3gYBMFfKhPGKmWQW9rAD6FcXDNTVEE2Jk9JLYkFdHHQumhK82vduOaGXn3mdz4AWDOn5hz0K7dAgpn1uCLzzRaTzmp7x3hLqRDfd2fs7l5fEo898EsK7+7JraxvokKHihpclCCkJmoHrFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=PQIUNC0c; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=PQIUNC0c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
X-Greylist: delayed 1660 seconds by postgrey-1.37 at boromir; Sat, 17 Oct 2026 08:27:41 AEDT
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5yhY75jLz2y1W
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2026 08:27:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vtJqI8YsdfW+gxZii/Z1VxgXOvJbDlTlvuwqPo5TN7o=; b=PQIUNC0cBfW3xjCJn68w+s6Mu9
	7UVTgRDCwAq5q5Arp2OOnFwHbgt+dzVnbbuPvzO87RJJLzD7RwR9uZPrRc6VNDX6rS3aoIFjE5E+y
	UB8vktCQsOT6lvsEpXyhvuHkcZfwvPrSQa2Xs1XTXBv2SBTSDIPYfxjLyAvSSk8OMsAU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xHp1S-00BDxQ-DV; Fri, 16 Oct 2026 22:59:26 +0200
Date: Fri, 16 Oct 2026 22:59:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Marek Vasut <marex@nabladev.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <vladimir.oltean@nxp.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	UNGLinuxDriver@microchip.com, Wei Fang <wei.fang@nxp.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [net-next,PATCH 2/2] enetc: Make eMDIO MDC rate configurable
 from DT
Message-ID: <725fe351-bdd0-4b53-b551-0f638d02f98a@lunn.ch>
References: <20261016193344.115518-1-marex@nabladev.com>
 <20261016193344.115518-2-marex@nabladev.com>
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
In-Reply-To: <20261016193344.115518-2-marex@nabladev.com>

> +	div = ((clk_get_rate(enet_clk) / mdc_freq) - 1) / 4;
> +	if (div < 5 || div > 0x1ff)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Requested MDC frequency is out of range, ignoring\n");

Returning -EINVAL is not really 'ignoring' the invalid value. Since
these are optional properties which are present, if they are not valid
returning an error is good. So please fix the message.

Why is dev < 5 an issue?

	Andrew

