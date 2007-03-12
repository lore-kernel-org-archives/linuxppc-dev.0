Return-Path: <dgibson@ozlabs.org>
Date: Tue, 13 Mar 2007 10:29:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 16/19] bootwrapper: Add xlate_reg(),
	and use it to find serial registers.
Message-ID: <20070312232925.GA29506@localhost.localdomain>
References: <20070312204202.GP28545@ld0162-tx32.am.freescale.net>
	<20070312230148.GG31268@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070312230148.GG31268@mag.az.mvista.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 12, 2007 at 04:01:48PM -0700, Mark A. Greer wrote:
> On Mon, Mar 12, 2007 at 02:42:02PM -0600, Scott Wood wrote:
> 
> > diff --git a/arch/powerpc/boot/ns16550.c b/arch/powerpc/boot/ns16550.c
> > index 1ffe72e..cce7a11 100644
> > --- a/arch/powerpc/boot/ns16550.c
> > +++ b/arch/powerpc/boot/ns16550.c
> > @@ -55,10 +55,15 @@ static u8 ns16550_tstc(void)
> >  int ns16550_console_init(void *devp, struct serial_console_data *scdp)
> >  {
> >  	int n;
> > +	unsigned long reg_phys;
> >  
> >  	n = getprop(devp, "virtual-reg", &reg_base, sizeof(reg_base));
> > -	if (n != sizeof(reg_base))
> > -		return -1;
> > +	if (n != sizeof(reg_base)) {
> > +		if (!xlate_reg(devp, 0, &reg_phys, NULL))
> > +			return -1;
> > +
> > +		reg_base = (void *)reg_phys;
> > +	}
> 
> NACK.
> 
> 'virtual-reg' _is_ the fully translated virtual address.
> Its simply the virtual address that maps to the fully translated
> physical addr in the 'reg' property.
> 
> Even if it wasn't, 'ranges' only work for physical/'reg' properties
> and can't be used for a virtual one--you'd have to make a parellel
> 'ranges' thingy for 'virtual-reg'.

I think you're misreading, Mark.  The patch only attempts to translate
the reg if the virtual-reg property is *not* valid.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
