Return-Path: <linuxppc-dev+bounces-24385-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4775C44515
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 21:18:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h22nZ6F57z3c3D;
	Sat, 18 Jul 2026 07:18:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::b9"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784323090;
	cv=none; b=VrCwLG2hlDECCO5j+wEhNywumLqGx6GTRgnrswdjWgqQSTSHyBjrBz6eUMn9ekh0Y5lE5WqPv/o8rq/4ATueusw2N+x1hzX5cgSUh7SdXKxnLtzfw+XfNSTh39yFaR64BSylb73Swzj/oI4FrzjWzo/Xl924GlxOXjeNMZdZ0vjwd2IHY734PcawGFjpvj8PpiOtiraa4ycE32mfiTGoLQJG5kk/yPg3OUSIjGEB2FoVxf41k0bFhmpi6/IKtkOk3bstX10bZ/EI1RLG7IY2TclyrvscgnnregycCQ4E21WVwcx/YJbFbap1Xej4didhSdSnxhFf64AJVM6Xef1pkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784323090; c=relaxed/relaxed;
	bh=HqBcCrxowAEuvpS1VnojAGqWPLHKqqkN7sCJDX8WoI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JnMZKS8o4mE2tPYWcBqGAoe+saB5MIQOnO+JikZ0AkQoHoEBlHXcJte5kXFem1od8vQ0Zfml/zuREe+jpaF1Re0sIcR5GdJWd2h+6HTM7rwfCmC3AMHfh4Q6Jd5IXLMQZ1ZqL3WMKZ45JJXFyGmPspaDyqKJewetj+8jUoHXk7Z+2qDY47haAxZ6TCgOMBQLqbkSuG3dA013XwHLN5G3w04L+nAfpdg/yK4Xqkf+tUVrLRTpuPFhSjH4C4SjUX+XGhbNwVU2aLIoSj+6lvcqHSt5hiCZjimrm1sEWSnPe12+AU0XemLvWR2D2UBGwjSRdUfQ/WpZsUOXPyW1uLudDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=D+L9j1Bn; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::b9; helo=out-185.mta0.migadu.com; envelope-from=sean.anderson@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=D+L9j1Bn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::b9; helo=out-185.mta0.migadu.com; envelope-from=sean.anderson@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 379 seconds by postgrey-1.37 at boromir; Sat, 18 Jul 2026 07:18:06 AEST
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h22nV2gHQz2y71
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2026 07:18:05 +1000 (AEST)
Message-ID: <4f7497cf-83ed-47cd-2e7b-d06ebe319b61@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784322660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HqBcCrxowAEuvpS1VnojAGqWPLHKqqkN7sCJDX8WoI8=;
	b=D+L9j1Bneg2mTXnnueQK19Z3EXiWHml3iAuPV1fJhNIslaATc9LN/awYdTJMg5D69+kB77
	pLBqCryPn9z5kH4a+dRruWBp6czddjAWvr/XfI32067eBGWWaovDXO4Sx+eHb9OSGFaVJS
	upgXd62cmDaQWT5RKRRSTFdN5VdPAyQ=
Date: Fri, 17 Jul 2026 17:10:56 -0400
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
Subject: Re: [PATCH net v3] net: dpaa: fix mode setting
Content-Language: en-US
To: Michael Walle <mwalle@kernel.org>, Madalin Bucur <madalin.bucur@nxp.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Christian Zigotzky <info@xenosoft.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <20260717132401.2653252-1-mwalle@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20260717132401.2653252-1-mwalle@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/17/26 09:20, Michael Walle wrote:
> Before converting to the phylink interface, the init function would have
> set a non-reserved I/F mode in the maccfg2 register. After converting to
> phylink, 0 is written as mode, which is a reserved value (although it's
> the hardware default). Without a valid mode, a SGMII link is never
> established between the MAC and the PHY and thus .link_up() is never
> called which could set the correct mode according to the actual speed.
> 
> Fix it by setting the maximum speed of the phy_interface_t in use in
> .mac_config() - just like the driver did before the phylink conversion.
> 
> Fixes: 5d93cfcf7360 ("net: dpaa: Convert to phylink")
> Suggested-by: Sean Anderson <sean.anderson@linux.dev>
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
> I didn't grab Sean's Rb tag as this is somewhat different.
> 
> Changes in v3:
>   - keep the mode setting also in .adjust_link().
>   - reword the commit message, to be (hopefully) more precise
>   - Link to v2: https://lore.kernel.org/r/20260710143430.2276141-1-mwalle@kernel.org/
> 
> Changes in v2:
>   - the setting is/was based on the maximum speed, not the current
>     speed. thus, move the setting into mac_config().
>   - Link to v1: https://lore.kernel.org/r/20260706121011.1948906-1-mwalle@kernel.org/
> 
>   .../net/ethernet/freescale/fman/fman_dtsec.c    | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fman/fman_dtsec.c b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
> index fe35703c509e..b8d70c0ecb6c 100644
> --- a/drivers/net/ethernet/freescale/fman/fman_dtsec.c
> +++ b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
> @@ -900,22 +900,28 @@ static void dtsec_mac_config(struct phylink_config *config, unsigned int mode,
>   {
>   	struct mac_device *mac_dev = fman_config_to_mac(config);
>   	struct dtsec_regs __iomem *regs = mac_dev->fman_mac->regs;
> -	u32 tmp;
> +	u32 ecntrl, maccfg2;
> +
> +	maccfg2 = ioread32be(&regs->maccfg2);
> +	maccfg2 &= ~(MACCFG2_NIBBLE_MODE | MACCFG2_BYTE_MODE);
>   
>   	switch (state->interface) {
>   	case PHY_INTERFACE_MODE_RMII:
> -		tmp = DTSEC_ECNTRL_RMM;
> +		ecntrl = DTSEC_ECNTRL_RMM;
> +		maccfg2 |= MACCFG2_NIBBLE_MODE;
>   		break;
>   	case PHY_INTERFACE_MODE_RGMII:
>   	case PHY_INTERFACE_MODE_RGMII_ID:
>   	case PHY_INTERFACE_MODE_RGMII_RXID:
>   	case PHY_INTERFACE_MODE_RGMII_TXID:
> -		tmp = DTSEC_ECNTRL_GMIIM | DTSEC_ECNTRL_RPM;
> +		ecntrl = DTSEC_ECNTRL_GMIIM | DTSEC_ECNTRL_RPM;
> +		maccfg2 |= MACCFG2_BYTE_MODE;
>   		break;
>   	case PHY_INTERFACE_MODE_SGMII:
>   	case PHY_INTERFACE_MODE_1000BASEX:
>   	case PHY_INTERFACE_MODE_2500BASEX:
> -		tmp = DTSEC_ECNTRL_TBIM | DTSEC_ECNTRL_SGMIIM;
> +		ecntrl = DTSEC_ECNTRL_TBIM | DTSEC_ECNTRL_SGMIIM;
> +		maccfg2 |= MACCFG2_BYTE_MODE;
>   		break;
>   	default:
>   		dev_warn(mac_dev->dev, "cannot configure dTSEC for %s\n",
> @@ -923,7 +929,8 @@ static void dtsec_mac_config(struct phylink_config *config, unsigned int mode,
>   		return;
>   	}
>   
> -	iowrite32be(tmp, &regs->ecntrl);
> +	iowrite32be(ecntrl, &regs->ecntrl);
> +	iowrite32be(maccfg2, &regs->maccfg2);
>   }
>   
>   static void dtsec_link_up(struct phylink_config *config, struct phy_device *phy,

Reviewed-by: Sean Anderson <sean.anderson@linux.dev>

Christian, can you test this patch with ethernet at 100/1G speed if you still have
access to those P5020/P5040 boards?

https://lore.kernel.org/all/0bfc8f3d-cb62-25f4-2590-ff424adbe48a@xenosoft.de/

