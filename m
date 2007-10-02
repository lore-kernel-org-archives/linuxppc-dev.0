Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B6BF7DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 10:10:52 +1000 (EST)
Subject: Re: PowerPC: new EMAC driver typo fix
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <1191283028.10089.15.camel@localhost.localdomain>
References: <20071001142316.GA24156@ru.mvista.com>
	<1191283028.10089.15.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 02 Oct 2007 10:10:33 +1000
Message-Id: <1191283833.6310.42.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2007-10-01 at 18:57 -0500, Josh Boyer wrote:
> On Mon, 2007-10-01 at 18:23 +0400, Valentine Barshak wrote:
> > This looks like typo. Please, apply this patch to fix.
> > 
> > diff -ruNp linux-2.6.orig/drivers/net/ibm_newemac/core.c linux-2.6/drivers/net/ibm_newemac/core.c
> > --- linux-2.6.orig/drivers/net/ibm_newemac/core.c	2007-10-01 17:23:35.000000000 +0400
> > +++ linux-2.6/drivers/net/ibm_newemac/core.c	2007-10-01 17:44:57.000000000 +0400
> > @@ -1232,9 +1232,9 @@ static inline int emac_xmit_finish(struc
> >  	 * instead
> >  	 */
> >  	if (emac_has_feature(dev, EMAC_FTR_EMAC4))
> > -		out_be32(&p->tmr0, EMAC_TMR0_XMIT);
> > -	else
> >  		out_be32(&p->tmr0, EMAC4_TMR0_XMIT);
> > +	else
> > +		out_be32(&p->tmr0, EMAC_TMR0_XMIT);
> > 
> >  	if (unlikely(++dev->tx_cnt == NUM_TX_BUFF)) {
> >  		netif_stop_queue(ndev);
> 
> No Signed-off-by: line.
> 
> The patch looks sane otherwise.  David, Ben, comments?

It does definitely look like a genuine typo so Acked by me.

Ben.
