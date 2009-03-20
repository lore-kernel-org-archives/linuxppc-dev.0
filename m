Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2EA77DDEEF
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 16:38:25 +1100 (EST)
Subject: Re: [PATCH] powerpc 4xx EMAC driver: device name reported on
	timeout is not correct
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mikhail Zolotaryov <lebon@lebon.org.ua>
In-Reply-To: <49B6B240.8030701@lebon.org.ua>
References: <49B6B240.8030701@lebon.org.ua>
Content-Type: text/plain
Date: Fri, 20 Mar 2009 16:38:13 +1100
Message-Id: <1237527493.25062.565.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2009-03-10 at 20:32 +0200, Mikhail Zolotaryov wrote:
> Hi,
> 
> not critical problem here.
> 
> IBM EMAC driver performs device reset (drivers/net/ibm_newemac/core.c: 
> emac_probe() -> emac_init_phy() -> emac_reset()) before registering 
> appropriate net_device (emac_probe() -> register_netdev()), so 
> net_device name contains raw format string during EMAC reset ("eth%d").
> 
> If the case of reset timeout, emac_report_timeout_error() function is 
> called to report an error. The problem is this function uses net_device 
> name to report device related, which is not correct, as a result in the 
> kernel log buffer we see:
> 
> eth%d: reset timeout
> 
> The solution is to print device_node full_name instead. After applying 
> the patch proposed, error string is like the following:
> 
> /plb/opb/ethernet@ef600e00: reset timeout
> 
> 
> Signed-off-by: Mikhail Zolotaryov <lebon@lebon.org.ua>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Please submit with my Ack included to the netdev list.

Cheers,
Ben.

> 
> 
> plain text document attachment (emac_report_timeout_error.patch)
> --- linux-2.6/drivers/net/ibm_newemac/core.c.orig	2009-03-10 20:24:12.000000000 +0200
> +++ linux-2.6/drivers/net/ibm_newemac/core.c		2009-03-10 20:29:12.000000000 +0200
> @@ -134,7 +134,7 @@
>  				  EMAC_FTR_440EP_PHY_CLK_FIX))
>  		DBG(dev, "%s" NL, error);
>  	else if (net_ratelimit())
> -		printk(KERN_ERR "%s: %s\n", dev->ndev->name, error);
> +		printk(KERN_ERR "%s: %s\n", dev->ofdev->node->full_name, error);
>  }
>  
>  /* EMAC PHY clock workaround:
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
