Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E4A51DDEEF
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 03:49:26 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l92HnLat028338
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Oct 2007 13:49:21 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l92HnFKO456984
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Oct 2007 11:49:19 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l92HnFrm025195
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Oct 2007 11:49:15 -0600
Date: Tue, 2 Oct 2007 12:49:14 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH] Fix typo in new EMAC driver.
Message-ID: <20071002124914.251e588c@weaponx.rchland.ibm.com>
In-Reply-To: <20071002120107.GA21847@ru.mvista.com>
References: <1191283028.10089.15.camel@localhost.localdomain>
	<20071002120107.GA21847@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, jeff@garzik.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2 Oct 2007 16:01:07 +0400
Valentine Barshak <vbarshak@ru.mvista.com> wrote:

> Fix an obvious typo in emac_xmit_finish.
> 
> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>

Looks fine to me.  Jeff, do you want to take this through netdev for
2.6.24?

josh

> ---
>  drivers/net/ibm_newemac/core.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
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
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
