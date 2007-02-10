Return-Path: <dgibson@ozlabs.org>
Date: Sat, 10 Feb 2007 11:37:49 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 15/19] bootwrapper: Add initrd information to the device
	tree in ft_finalize().
Message-ID: <20070210003749.GA8276@localhost.localdomain>
References: <20070207230017.GA3758@ld0162-tx32.am.freescale.net>
	<20070207230140.GO3849@ld0162-tx32.am.freescale.net>
	<20070209230207.GA12035@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070209230207.GA12035@mag.az.mvista.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 09, 2007 at 04:02:07PM -0700, Mark A. Greer wrote:
> On Wed, Feb 07, 2007 at 05:01:40PM -0600, Scott Wood wrote:
> 
> Sorry for being so slow on this Scott.
> 
> <snip>
> 
> > diff --git a/arch/powerpc/boot/flatdevtree_misc.c b/arch/powerpc/boot/flatdevtree_misc.c
> > index 04da38f..39fa010 100644
> > --- a/arch/powerpc/boot/flatdevtree_misc.c
> > +++ b/arch/powerpc/boot/flatdevtree_misc.c
> > @@ -33,8 +33,20 @@ static int ft_setprop(const void *phandl
> >  	return ft_set_prop(&cxt, phandle, propname, buf, buflen);
> >  }
> >  
> > -static unsigned long ft_finalize(void)
> > +unsigned long ft_finalize(void)
> 
> This is unnecessary.  There is already global access from
> dt_ops.finalize.
> 
> >  {
> > +	unsigned long initrd_end = initrd.addr + initrd.size;
> > +	void *devp;
> > +
> > +	if (initrd.size && (devp = finddevice("/chosen"))) {
> > +		setprop(devp, "linux,initrd-start", &initrd.addr,
> > +		        sizeof(initrd.addr));
> > +		setprop(devp, "linux,initrd-end", &initrd_end,
> > +		        sizeof(initrd_end));
> > +
> > +		ft_add_rsvmap(&cxt, initrd.addr, initrd.size);
> > +	}
> > +
> 
> IMHO, this is a very unnatural place to put this code.
> It really belongs in main.c.  That's where all the rest
> of the code that accesses initrd.* is.

Agreed.  I have a couple of pending patches that do this in a more
sensible place.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
