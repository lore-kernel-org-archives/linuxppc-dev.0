Return-Path: <dgibson@ozlabs.org>
Date: Mon, 7 Feb 2011 19:30:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 4/6] powerpc/44x: don't use tlbivax on AMP systems
Message-ID: <20110207083053.GB28943@yookeroo>
References: <1296586126-32765-1-git-send-email-shaggy@linux.vnet.ibm.com>
	<1296586126-32765-5-git-send-email-shaggy@linux.vnet.ibm.com>
	<20110202230844.GG3032@yookeroo>
	<1296690839.12290.108.camel@shaggy-w500>
	<20110203050351.GK3032@yookeroo>
	<1296774957.14077.23.camel@shaggy-w500>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1296774957.14077.23.camel@shaggy-w500>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 03, 2011 at 05:15:57PM -0600, Dave Kleikamp wrote:
> On Thu, 2011-02-03 at 16:03 +1100, David Gibson wrote:
> > On Wed, Feb 02, 2011 at 05:53:59PM -0600, Dave Kleikamp wrote:
> > > On Thu, 2011-02-03 at 10:08 +1100, David Gibson wrote:
> > > > On Tue, Feb 01, 2011 at 12:48:44PM -0600, Dave Kleikamp wrote:
> > > > > Since other OS's may be running on the other cores don't use tlbivax
> > > > 
> > > > [snip]
> > > > > +#ifdef CONFIG_44x
> > > > > +void __init early_init_mmu_44x(void)
> > > > > +{
> > > > > +	unsigned long root = of_get_flat_dt_root();
> > > > > +	if (of_flat_dt_is_compatible(root, "ibm,47x-AMP"))
> > > > > +		amp = 1;
> > > > > +}
> > > > > +#endif /* CONFIG_44x */
> > > > 
> > > > A test against a hardcoded compatible string seems a nasty way to do
> > > > this.  Maybe we should define a new boolean property for the root
> > > > node.
> > > 
> > > I'm not crazy about this string, but I needed something in the device
> > > tree to key off of.  Freescale has something similar (i.e.
> > > MPC8572DS-CAMP), so I chose to follow their example.  I'd be happy to
> > > replace it with a boolean property.  Any objection to just using
> > > "amp"?
> > 
> > Bit too short, I think.  I'd suggest either spelling out
> > 'asymmetric-multiprocessor' or 'cooperative-partition' (a more
> > accurate term, IMO).
> 
> I could be wrong, but I thought the A stands for Asynchronous, not
> Asymmetric.  I thought Asymmetric means that different types of tasks
> run on the secondary processors, as on the Cell.

Yeah, I thought so too, but Freescale at least seem to use it this
way.  'Asynchronous' would make even less sense.

>  Anyway, going with
> 'cooperative-partition' would avoid that confusion.
> 
> Shaggy

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
