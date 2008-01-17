Return-Path: <mgreer@mvista.com>
Date: Wed, 16 Jan 2008 17:35:13 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 4/4 v2] powerpc: Katana750i - Add platform support
Message-ID: <20080117003513.GB1917@mag.az.mvista.com>
References: <20080114225150.GB21940@mag.az.mvista.com>
	<20080114230057.GC22862@mag.az.mvista.com>
	<20080116221210.GC7228@mag.az.mvista.com>
	<20080117102702.5e21fc22.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080117102702.5e21fc22.sfr@canb.auug.org.au>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 17, 2008 at 10:27:02AM +1100, Stephen Rothwell wrote:
> Hi Mark,
> 
> On Wed, 16 Jan 2008 15:12:10 -0700 "Mark A. Greer" <mgreer@mvista.com> wrote:
> >
> > +static void __init katana750i_setup_arch(void)
> > +{
> > +	struct device_node *np;
> > +	phys_addr_t paddr;
> > +	const unsigned int *reg;
> > +
> > +	np = of_find_compatible_node(NULL, NULL, "katana750i,cpld");
> > +	if (!np)
> > +		printk(KERN_WARNING "No CPLD DT node; functionality reduced\n");
> > +	else {
> > +		reg = of_get_property(np, "reg", NULL);
> > +		if (!reg)
> > +			printk(KERN_WARNING "No CPLD reg property; "
> > +					"functionality reduced\n");
> > +		else {
> > +			paddr = of_translate_address(np, reg);
> > +			of_node_put(np);
> > +			cpld_base = ioremap(paddr, reg[1]);
> > +		}
> > +	}
> 
> You need an of_node_put(np) for the !reg case above.  Maybe you should
> just put it after the else clause instead of in it.

Erg, yes...duh.

Thanks again, Stephen.

Mark
