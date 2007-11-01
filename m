Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AA1F1DDE00
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Nov 2007 07:42:36 +1100 (EST)
Subject: Re: [PATCH] net: Add 405EX support to new EMAC driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200711011554.04935.sr@denx.de>
References: <200711011554.04935.sr@denx.de>
Content-Type: text/plain
Date: Fri, 02 Nov 2007 07:37:01 +1100
Message-Id: <1193949421.6541.10.camel@pasglop>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2007-11-01 at 15:54 +0100, Stefan Roese wrote:
> This patch adds support for the 405EX to the new EMAC driver.
> 
> Tested on AMCC Kilauea.

 .../...

> diff --git a/drivers/net/ibm_newemac/rgmii.c b/drivers/net/ibm_newemac/rgmii.c
> index de41695..e393f68 100644
> --- a/drivers/net/ibm_newemac/rgmii.c
> +++ b/drivers/net/ibm_newemac/rgmii.c
> @@ -140,9 +140,6 @@ void rgmii_get_mdio(struct of_device *ofdev, int input)
>  
>  	RGMII_DBG2(dev, "get_mdio(%d)" NL, input);
>  
> -	if (dev->type != RGMII_AXON)
> -		return;
> -
>  	mutex_lock(&dev->lock);

That will break 440GX boards that need to use the RGMII for data and the
ZMII for MDIO.

You may want to change the name RGMII_AXON something like RGMII_HAS_MDIO
instead and set that for 405EX as well instead.

Ben.
