Return-Path: <linuxppc-dev+bounces-20532-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F9CACD3439
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2026 22:22:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9qdK2yg8z2xSb;
	Thu, 07 May 2026 08:22:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778106165;
	cv=none; b=oHCczXDRwir3+/s4y/pOlKNBWNTgEHPw4mIDUARB1ghFRYMXKOsqZhfn9PyafWGDB9wZz1VkBeaamYn2JjEPnghL0sdlgMMnf8X6rAsjNTRyZv2QdZMDdNXTmrfakDAzDutnyc/lXHx+V+Sw8R2/KIRCFKYEQldnRiWYd1NkmQ+lUzVfdqfjQKI0wapM22uk2QBPdkbtNBBiCV1WEq4rA6OssP98VzUtjfd/oL7b+6dQMHIfdjt22ZiXuIQljA8rglAbMKuJEHh1ArRvAshlSpOihp08hcdU1YGtzaqoM0bU9l0vn1oigSbV/dS0cl1IwOMdy8wo36nauk/6G9J3/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778106165; c=relaxed/relaxed;
	bh=3U7fwx8o37KuZiuzGnaDeWgNwO4CVqMdSeoPW8/HUYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJ5vMiq8OyjQ5obHZwBB52xXbnKhbXFVU/wZn6YulNre6cuMql4BSbOTHlMKONtV4q0Xi1rCVJQ/5J4vH7uT8nrKak6sg+rergKpyKeulB7zDu0IE+J8r+P5vsU7CchxKMdDfELUDC7EY6zmvVjATLHkgtBDPsFkuuBG8irVIDbUwWMRg1SRklRerUb19XIst1AQHTsvSANSduA0EU8al4l1+tILX7jusOJYqdMbCK3CrwaUKsHLB0xxK1seXmCxvIfS+BLVY787ufKcG9/dlPwEnYb8giq09kZXr5xTKnDZl9X1z6ickR776RJgNXeJi+iBszGsmRB+EMNOnzU2wA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BmmjiaY0; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BmmjiaY0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9qdJ3hbKz2xGY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2026 08:22:44 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9E0C440C27;
	Wed,  6 May 2026 22:22:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83875C2BCB0;
	Wed,  6 May 2026 22:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778106161;
	bh=hwqxnsO+ALySBum5tOGbNdnlNfkkmm95U+0x4x3rmDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BmmjiaY0RCKWxcyRYn2cz29/lsX5fQSz/IWZDpve0Lp5yKmf/XZsTwBAdiItqQd/v
	 ytC2W+0oI2bJTUNIej5Jc16Nv+73nR7hOaLcRa6C/io0s4Gf9lfn/Zu+GltbUyfwFs
	 TIUDbWVJQkZ5ZchQJqKyK5kSM7slM0d8bOBHouiNcF0XxWczgQHo/qzF20tPEKl8MQ
	 MeHr5le2grDqsuthLd1VI/GvFceYfilCV/zERRmhRWir3hxR044MvPW711jreeywR0
	 QaeYfEweLTOjLbilLinl8omGMgd15zx90I5ka2o6rJBcVyW/VYTzd6L5z84wgV7uHI
	 RE7DF+tOVEU8w==
Date: Wed, 6 May 2026 17:22:38 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: linux-kernel@vger.kernel.org, chleroy@kernel.org, edumazet@google.com,
	frank.li@nxp.com, kuba@kernel.org, netdev@vger.kernel.org,
	vladimir.oltean@nxp.com, devicetree@vger.kernel.org,
	linux@armlinux.org.uk, conor+dt@kernel.org, horms@kernel.org,
	davem@davemloft.net, andrew+netdev@lunn.ch, xiaoning.wang@nxp.com,
	pabeni@redhat.com, krzk+dt@kernel.org,
	linuxppc-dev@lists.ozlabs.org, claudiu.manoil@nxp.com,
	f.fainelli@gmail.com, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v5 net-next 02/15] dt-bindings: net: dsa: add NETC switch
Message-ID: <177810615811.3413821.3835724819820623979.robh@kernel.org>
References: <20260430024945.3413973-1-wei.fang@nxp.com>
 <20260430024945.3413973-3-wei.fang@nxp.com>
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
In-Reply-To: <20260430024945.3413973-3-wei.fang@nxp.com>


On Thu, 30 Apr 2026 10:49:32 +0800, Wei Fang wrote:
> Add bindings for NETC switch. This switch is a PCIe function of NETC IP,
> it supports advanced QoS with 8 traffic classes and 4 drop resilience
> levels, and a full range of TSN standards capabilities. The switch CPU
> port connects to an internal ENETC port, which is also a PCIe function
> of NETC IP. So these two ports use a light-weight "pseudo MAC" instead
> of a back-to-back MAC, because the "pseudo MAC" provides the delineation
> between switch and ENETC, this translates to lower power (less logic and
> memory) and lower delay (as there is no serialization delay across this
> link).
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/net/dsa/nxp,netc-switch.yaml     | 127 ++++++++++++++++++
>  1 file changed, 127 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


