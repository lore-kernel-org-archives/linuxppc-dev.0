Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9D8E4DDE1B
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 18:58:42 +1000 (EST)
Subject: Re: [PATCH] ibm_newemac: Fixes entry of short packets
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: SathyaNarayanan <sathyan@teamf1.com>
In-Reply-To: <1946a170806262336y4aa3621at16520fc546bbe4b1@mail.gmail.com>
References: <1214225705-25850-1-git-send-email-sr@denx.de>
	<1214263257.8011.278.camel@pasglop>
	<1946a170806262336y4aa3621at16520fc546bbe4b1@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 27 Jun 2008 18:58:34 +1000
Message-Id: <1214557114.8011.539.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>, netdev@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>         
> 
> Actually , short packets are not allowed to flow through the higher
> layers, If any of the layer tried to use the extra room available may
> hit wit crash .
> Since it is a invalid packet it has to be dropped and freed in driver.
> Actually if you see in code, the other invalid packets are also
> handelled similar.

My point is they should not. The rx skb should be kept in the ring for
further rx (ie, the data ignored and re-use the skb). A bit like we do
when we decide the packet is small enough to be copied to a new skb.

Ie. Move you test above the threshold test and recycle the skb.

We need to fix the usage of the dma operations in this driver anyway
and this will make it easier as we'll be able to avoid re-mapping an
skb we just recycle. (the current driver never unmaps which means it
can't be used with an iommu, which is a problem on some cell based
platforms).

Ben.
