Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 7B424DDF2B
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2007 04:04:51 +1000 (EST)
Date: Tue, 24 Apr 2007 11:04:56 -0700 (PDT)
Message-Id: <20070424.110456.124867547.davem@davemloft.net>
To: jdl@freescale.com
Subject: Re: [PATCH 1/6] Start split out of common open firmware code
From: David Miller <davem@davemloft.net>
In-Reply-To: <AF0367BA48C55940A43CCF08DF35553C011ECCD1@az33exm24.fsl.freescale.net>
References: <20070424223245.78f4fdfb.sfr@canb.auug_.org.au>
	<f64705c9250a93dcb7a4015b9a0d5667@kernel.crashing.org>
	<AF0367BA48C55940A43CCF08DF35553C011ECCD1@az33exm24.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: "Loeliger Jon-LOELIGER" <jdl@freescale.com>
Date: Tue, 24 Apr 2007 07:47:10 -0700

>  
> > > +int of_n_addr_cells(struct device_node *np)
> > > +{
> > > +	const int *ip;
> > > +
> > > +	do {
> > > +		if (np->parent)
> > > +			np = np->parent;
> > > +		ip = of_get_property(np, "#address-cells", NULL);
> > > +		if (ip)
> > > +			return *ip;
> > > +	} while (np->parent);
> > > +	/* No #address-cells property for the root node */
> > > +	return OF_ROOT_NODE_ADDR_CELLS_DEFAULT;
> > > +}
> > > +EXPORT_SYMBOL(of_n_addr_cells);
> > 
> > While I realise your patch is just moving stuff around,
> > can this be fixed please?  A missing "#address-cells"
> > property means "two cells", not "inherit from parent".
> > The few platforms with a broken tree should just be
> > fixed (patch the tree in the bootwrapper, or perhaps
> > _do_ use this workaround, but only on the affected
> > platforms).
> > 
> > > +int of_n_size_cells(struct device_node *np)
> > 
> > Same here (the default is one cell though).
> 
> Agreed.  We actually discussed this quite some time ago.

I totally disagree that you should be changing anything
during these consolidations.

Move the code around in one pass where you can _VERIFY_
that things are precisely the same and won't break.

Then later you can get fancy and change things however you
wish.

You people giving comments like this have your priorities totally
screwed up and you are doing nothing but unnecessarily slowing down
this wonderful consolidation.  Even worse you might even be giving
Stephen a disincentive to keep working actively on this.

So please STOP THIS CRAP now, thanks.

Everything so far is pure whining, and has nothing to do with
the substance of what Stephen is trying to accomplish, a
_CODE CONSOLIDATION_.  So please don't get in the way of that
effort.
