Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id DAF1DDDD1B
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2009 08:40:53 +1100 (EST)
Date: Wed, 25 Mar 2009 14:40:41 -0700 (PDT)
Message-Id: <20090325.144041.128558998.davem@davemloft.net>
To: dada1@cosmosbay.com
Subject: Re: [PATCH] ucc_geth: Move freeing of TX packets to NAPI context.
From: David Miller <davem@davemloft.net>
In-Reply-To: <49CA39EA.6020208@cosmosbay.com>
References: <1237987849.2194.9.camel@gentoo-jocke.transmode.se>
	<49CA39EA.6020208@cosmosbay.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Cc: leoli@freescale.com, netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Eric Dumazet <dada1@cosmosbay.com>
Date: Wed, 25 Mar 2009 15:04:26 +0100

> Joakim Tjernlund a =E9crit :
> > +	/* Tx event processing */
> > +	spin_lock(&ugeth->lock);
> > +	for (i =3D 0; i < ug_info->numQueuesTx; i++) {
> > +		ucc_geth_tx(ugeth->dev, i);
> > +	}
> > +	spin_unlock(&ugeth->lock);
> > +
> =

> Why tx completions dont change "howmany" ?
> It seems strange you changed UCC_GETH_DEV_WEIGHT if not taking into a=
ccount tx event above...

He should leave howmany alone for TX work and use a weight
value of 64 just like most other drivers in the tree do.

Due to the abuse and random ignorant fiddling of the
weight value, I am going to make it something the core
rather than drivers choose.
