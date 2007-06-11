Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DE53EDDEEA
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 04:57:11 +1000 (EST)
In-Reply-To: <1181548417.5217.13.camel@mark>
References: <1181548417.5217.13.camel@mark>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9A3A59AA-FADC-4A98-9129-0E00F122188E@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH] MII bitbang driver should generate MII bus phy_mask
	dynamically
Date: Mon, 11 Jun 2007 13:57:20 -0500
To: Mark Zhan <rongkai.zhan@windriver.com>
Cc: netdev@vger.kernel.org, Vitaly Bordug <vbordug@ru.mvista.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 11, 2007, at 02:53, Mark Zhan wrote:

> Current MII bitbang bus driver hard-codes the phy mask of mii_bus to
> ~0x09, which is actually specific to the FSL boards. This patch will
> make the bitbang driver to generate MII bus phy_mask dynamically,  
> by the
> PHY irq info provided by the platform.
>
> Signed-off-by: Mark Zhan <rongkai.zhan@windriver.com>

[...]

>
> +	new_bus->phy_mask = 0xFFFFFFFF;
> +	for (i = 0; i < PHY_MAX_ADDR; i++)
> +		if (pdata->irq[i] != -1)
> +			new_bus->phy_mask &= ~(1 << i);
> +


This doesn't work.  There are a couple of things wrong:

1) Don't use -1, use PHY_POLL

2) As you can tell from #1, the absence of a set interrupt for a  
particular PHY does not indicate it doesn't exist.  Rather, it  
indicates it doesn't have an interrupt.

I think you need to add a phy_mask to the platform data, and then set  
it appropriately.  We also need to look into adding that for the mdio  
nodes in the device tree, so it will get passed in properly.

Andy
