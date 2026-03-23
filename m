Return-Path: <linuxppc-dev+bounces-18614-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CCA1EC01B1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 09:49:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffT116G97z2ySc;
	Mon, 23 Mar 2026 20:49:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:4d48:ad52:32c8:5054:ff:fe00:142"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774259397;
	cv=none; b=WRbbFBje6TaTDtJNB8KQSRag3orsgcZJnoNk817jDlM4GPuH0CRqytLEoRYgU7pEx5gSMoNyDVA7de+WFPjQPUeEyG3dtloaJ3NJaQ5cTH5HGW66+HY6vuO3sVziiLAJBjEzM4AC8Nx6obIXpUUsko1XQSe3nBope0uyvHroCQoedArHq6A74lKDcHOJT4B6dIvEi6b3YdL0JyJdHjmb2HoIG8XXuMTeCrPMWSpQBUxqsgAJ0YQh3+ccmm6tOIZD9MY+b2WhZtZ63HPqPA2U6cdWNTgIXUTCiL3mOhNsA35YAE2MHWLB8RrN3B33sg7gI3OcBBbjjQjLGXJsDSsrBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774259397; c=relaxed/relaxed;
	bh=ze5ETx/U/7MNxR8MXWbZ3oXcMSugHqDKn2wVuG7ra88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZ+pyO4LM2udnb5EBUeUwXFlMXMuf9vbHZgveVKmZ6Dvk+mmymtmjS7OVCffqEjBn5Rm9H9gqyuI5tcKLxJ+pktP0/7FOC2jEpT+77RBmsILNY1Wn2lyo+2CEeGXeAVTMMj4k9znOLVzuK+OC4/D5bWx1HhvHSnlpoKE/Wsmed/1zSCu0WyBWqm5aciZteaFEyIVz/xTtaQY0sEKv5QUptCJ6Y7l/Hihm7r5S76QSbJNv8H54CXb68iVa/C9ui1X1I46o8V9JNzmJG+JWppuR86+9gtfVnNf7DX3jD4603WU2AcA7ENHdT/zLduHA2a0l9CUCCzFHowvrWJF18COjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; dkim=pass (2048-bit key; secure) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.a=rsa-sha256 header.s=pandora-2019 header.b=eUGrZECN; dkim-atps=neutral; spf=none (client-ip=2001:4d48:ad52:32c8:5054:ff:fe00:142; helo=pandora.armlinux.org.uk; envelope-from=linux+linuxppc-dev=lists.ozlabs.org@armlinux.org.uk; receiver=lists.ozlabs.org) smtp.mailfrom=armlinux.org.uk
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.a=rsa-sha256 header.s=pandora-2019 header.b=eUGrZECN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=armlinux.org.uk (client-ip=2001:4d48:ad52:32c8:5054:ff:fe00:142; helo=pandora.armlinux.org.uk; envelope-from=linux+linuxppc-dev=lists.ozlabs.org@armlinux.org.uk; receiver=lists.ozlabs.org)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffT106Bc1z2ySb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 20:49:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ze5ETx/U/7MNxR8MXWbZ3oXcMSugHqDKn2wVuG7ra88=; b=eUGrZECNA51voE32i31QjaUAjf
	7OkBg63xFi7AlouLEgoG7RhJiyKaFD8UNYjySI3YXHajS8/lsDmdcUaiEfzWm7j+h4JrTGkNPstq0
	gaLR8j09J+NralvErg9+2AqahEiteJHprUmtvwdRKQGwvpisOaKOTCXr8i611xKiWG3QOGEr58KHR
	Rz36iy8O6wkx+5sdmC3XfHxNrsKsqC2HATT/StCU0d6fwNHx0HeU0CTYpWKQMShRe1WRqjo05fllQ
	YZuuy2ehGzP+qKTk5NjXTQIIY2p35atMT/+Laf4vhLNVycY5M8n+8k8dphiOqmJdaXNOYnIlmValW
	3pH+dkUw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58016)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w4bS9-000000000Bx-0XtG;
	Mon, 23 Mar 2026 09:20:05 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w4bS6-000000003uf-0hU7;
	Mon, 23 Mar 2026 09:20:02 +0000
Date: Mon, 23 Mar 2026 09:20:02 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, f.fainelli@gmail.com,
	frank.li@nxp.com, chleroy@kernel.org, horms@kernel.org,
	andrew@lunn.ch, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 net-next 13/14] net: dsa: netc: initialize buffer bool
 table and implement flow-control
Message-ID: <acEFwqmAvWls_9Ef@shell.armlinux.org.uk>
References: <20260323060752.1157031-1-wei.fang@nxp.com>
 <20260323060752.1157031-14-wei.fang@nxp.com>
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
In-Reply-To: <20260323060752.1157031-14-wei.fang@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Mar 23, 2026 at 02:07:51PM +0800, Wei Fang wrote:
> @@ -1288,7 +1411,17 @@ static void netc_mac_link_up(struct phylink_config *config,
>  		netc_port_set_rmii_mii_mac(np, speed, duplex);
>  	}
>  
> +	if (duplex == DUPLEX_HALF) {
> +		/* As per 802.3 annex 31B, PAUSE frames are only supported
> +		 * when the link is configured for full duplex operation.
> +		 */
> +		tx_pause = false;
> +		rx_pause = false;
> +	}

I keep seeing this totally unnecessary code in reviews of mac_link_up()
methods. See phylink_resolve_an_pause().

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

