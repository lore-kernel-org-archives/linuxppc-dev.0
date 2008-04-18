Return-Path: <dgibson@ozlabs.org>
Date: Fri, 18 Apr 2008 10:35:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Gortmaker <paul.gortmaker@gmail.com>
Subject: Re: [PATCH] 86xx: mark functions static, other minor cleanups
Message-ID: <20080418003502.GC8724@yookeroo.seuss>
References: <1207933186-20555-1-git-send-email-paul.gortmaker@windriver.com>
	<20080411171628.GA3203@loki.buserror.net>
	<20080411184312.GA23941@windriver.com>
	<28ac27892f91a47cd620aee7b7b9ecdb@kernel.crashing.org>
	<7d1d9c250804141832pa9c9fbbicf4939c9854dc5f5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7d1d9c250804141832pa9c9fbbicf4939c9854dc5f5@mail.gmail.com>
Cc: Scott Wood <scottwood@freescale.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	linuxppc-dev@ozlabs.org, sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 14, 2008 at 09:32:44PM -0400, Paul Gortmaker wrote:
> On Fri, Apr 11, 2008 at 3:11 PM, Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> >
> > > Updated as per above, and with tickerized prefixes for sbc8641.
> > >
> >
> >  Care to try once more?  It's only "tickerized" if it's in all
> >  uppercase.
> 
> I'm looking at what exists in arch/powerpc/boot/dts/* and I'm
> not seeing too much uppercase - here is a sample:
> 
> ebony.dts:        compatible = "ibm,ebony";
> ep405.dts:        compatible = "ibm,uic";
> ep8248e.dts:    compatible = "fsl,ep8248e";
> bamboo.dts:     compatible = "amcc,bamboo";
> cm5200.dts:     compatible = "schindler,cm5200";
> ep88xc.dts:     compatible = "fsl,ep88xc";
> haleakala.dts:  compatible = "amcc,kilauea";
> holly.dts:         compatible = "ibm,holly";
> katmai.dts:     compatible = "amcc,katmai";
> kilauea.dts:    compatible = "amcc,kilauea";
> lite5200b.dts:  compatible = "fsl,lite5200b";
> motionpro.dts:  compatible = "promess,motionpro";
> mpc8272ads.dts: compatible = "fsl,mpc8272ads";
> mpc866ads.dts:  compatible = "fsl,mpc866ads";
> 
> > > +       compatible = "wind,sbc8641";
> 
> To me this looks in keeping with the rest.  And I prefer
> with the lower case, actually.  (Apparently so do a lot of
> other people...)

The confusion arises due to a difference between historical OF
practice, and current flattened DT practice.

Historically, as Segher says, uppercase names are stock tickers (and
thereby a centrally registered, guaranteed-unique namespace).
Lowercase names are a free-for-all, no central management, put pick a
reasonable name and it will probably be ok.

Use of the formal uppercase names in OF practice isn't particularly
common - there certainly are AAPL, and IBM, names out there but
they're rather outnumbered by the informal lowercase prefixes.  Which
is why most of us doing flattened tree work didn't realise the
distinction.  So, the flattened tree Linux community independently
came up with the convention of using stock tickers as a way of
uniqueifying the names - but used lowercase names.

So, it's a bit of a mess.  Here's my recommended procedure:

	* If you can find a single dominant existing practice for the
vendor in question, use that.  (Consider both OF and flattened tree
practice). i.e. existing practice trumps all.

	* If you can't find any existing practice and need to make a
new prefix, use the stock ticker.

	* If you find more than one existing practice (and none is
clearly dominant), take it to the list and we can argue about it.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
