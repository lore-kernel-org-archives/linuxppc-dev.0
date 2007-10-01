Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3934BDDE35
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 10:00:39 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9200V02003733
	for <linuxppc-dev@ozlabs.org>; Mon, 1 Oct 2007 20:00:31 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9200Vbq542564
	for <linuxppc-dev@ozlabs.org>; Mon, 1 Oct 2007 20:00:31 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9200VK6020121
	for <linuxppc-dev@ozlabs.org>; Mon, 1 Oct 2007 20:00:31 -0400
Subject: Re: PowerPC: new EMAC driver typo fix
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Valentine Barshak <vbarshak@ru.mvista.com>
In-Reply-To: <20071001142316.GA24156@ru.mvista.com>
References: <20071001142316.GA24156@ru.mvista.com>
Content-Type: text/plain
Date: Mon, 01 Oct 2007 18:57:08 -0500
Message-Id: <1191283028.10089.15.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-10-01 at 18:23 +0400, Valentine Barshak wrote:
> This looks like typo. Please, apply this patch to fix.
> 
> diff -ruNp linux-2.6.orig/drivers/net/ibm_newemac/core.c linux-2.6/drivers/net/ibm_newemac/core.c
> --- linux-2.6.orig/drivers/net/ibm_newemac/core.c	2007-10-01 17:23:35.000000000 +0400
> +++ linux-2.6/drivers/net/ibm_newemac/core.c	2007-10-01 17:44:57.000000000 +0400
> @@ -1232,9 +1232,9 @@ static inline int emac_xmit_finish(struc
>  	 * instead
>  	 */
>  	if (emac_has_feature(dev, EMAC_FTR_EMAC4))
> -		out_be32(&p->tmr0, EMAC_TMR0_XMIT);
> -	else
>  		out_be32(&p->tmr0, EMAC4_TMR0_XMIT);
> +	else
> +		out_be32(&p->tmr0, EMAC_TMR0_XMIT);
> 
>  	if (unlikely(++dev->tx_cnt == NUM_TX_BUFF)) {
>  		netif_stop_queue(ndev);

No Signed-off-by: line.

The patch looks sane otherwise.  David, Ben, comments?

josh
