Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 05AA8474D2
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 03:11:10 +1100 (EST)
Message-ID: <496E0E85.7060801@freescale.com>
Date: Wed, 14 Jan 2009 10:10:45 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH] fsldma: print correct IRQ on mpc83xx
References: <1231944284-18296-1-git-send-email-jacmet@sunsite.dk>
In-Reply-To: <1231944284-18296-1-git-send-email-jacmet@sunsite.dk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, dan.j.williams@intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Peter Korsgaard wrote:

> @@ -875,7 +875,8 @@ static int __devinit fsl_dma_chan_probe(struct fsl_dma_device *fdev,
>  	}
>  
>  	dev_info(fdev->dev, "#%d (%s), irq %d\n", new_fsl_chan->id,
> -				compatible, new_fsl_chan->irq);
> +		 compatible,
> +		 new_fsl_chan->irq != NO_IRQ ? new_fsl_chan->irq : fdev->irq);

Wouldn't it be better to make sure that, on 83xx, new_fsl_chan->irq has the same
value as fdev->irq before we get here?

-- 
Timur Tabi
Linux kernel developer at Freescale
