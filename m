Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 02333DDDE6
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Oct 2007 00:38:55 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9CEcqGB012524
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 10:38:52 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9CEcqim495576
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 08:38:52 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9CEcqnS001126
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 08:38:52 -0600
Subject: Re: [PATCH] NEW EMAC Fix RGMII build error: use
	of_device_is_compatible
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Valentine Barshak <vbarshak@ru.mvista.com>
In-Reply-To: <20071012130445.GA14704@ru.mvista.com>
References: <20071012130445.GA14704@ru.mvista.com>
Content-Type: text/plain
Date: Fri, 12 Oct 2007 09:37:01 -0500
Message-Id: <1192199821.3061.41.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-10-12 at 17:04 +0400, Valentine Barshak wrote:
> Fix build RGMII error: use of_device_is_compatible()
> insteadof now deprecated device_is_compatible() function.
> 
> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

Jeff, this should go into 2.6.24 please.

josh
> ---
>  drivers/net/ibm_newemac/rgmii.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff -pruN linux-2.6.orig/drivers/net/ibm_newemac/rgmii.c linux-2.6/drivers/net/ibm_newemac/rgmii.c
> --- linux-2.6.orig/drivers/net/ibm_newemac/rgmii.c	2007-10-12 16:02:41.000000000 +0400
> +++ linux-2.6/drivers/net/ibm_newemac/rgmii.c	2007-10-12 16:49:07.000000000 +0400
> @@ -251,7 +251,7 @@ static int __devinit rgmii_probe(struct 
>  	}
> 
>  	/* Check for RGMII type */
> -	if (device_is_compatible(ofdev->node, "ibm,rgmii-axon"))
> +	if (of_device_is_compatible(ofdev->node, "ibm,rgmii-axon"))
>  		dev->type = RGMII_AXON;
>  	else
>  		dev->type = RGMII_STANDARD;
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
