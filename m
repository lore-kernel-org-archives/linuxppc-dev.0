Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AE1B2DDEDD
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 03:55:12 +1100 (EST)
Date: Thu, 8 Nov 2007 10:55:08 -0600
From: Scott Wood <scottwood@freescale.com>
To: Roel Kluin <12o3l@tiscali.nl>
Subject: Re: inbalanced ioremap/iounmap? in cpm_pic_init();
	arch/powerpc/sysdev/commproc.c
Message-ID: <20071108165508.GB4356@loki.buserror.net>
References: <473235C6.2050104@tiscali.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <473235C6.2050104@tiscali.nl>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 07, 2007 at 11:01:42PM +0100, Roel Kluin wrote:
> It appears to me that ioremap/iounmap in cpm_pic_init() is imbalanced. I
> am not certain about this, nor was the patch tested. please review.

You missed several error paths...  and if we're going to clean up the error
handling for this function, we might as well free cpm_pic_host, and do an
of_node_put() before the second of_find_compatible_node(), as well.

> @@ -187,13 +187,15 @@ unsigned int cpm_pic_init(void)
>  		goto end;
>  
>  	if (setup_irq(eirq, &cpm_error_irqaction))
>  		printk(KERN_ERR "Could not allocate CPM error IRQ!");
>  
>  	setbits32(&cpic_reg->cpic_cicr, CICR_IEN);
> -
> +	goto end;
> +io_out:
> +	iounmap(cpic_reg);
>  end:
>  	of_node_put(np);
>  	return sirq;
>  }

Ick.  Maybe better to just duplicate the of_node_put().

-Scott
