Return-Path: <jeremy.kerr@canonical.com>
From: Jeremy Kerr <jeremy.kerr@canonical.com>
To: michael@ellerman.id.au
Subject: Re: [PATCH] of/flattree: use callback to setup initrd from /chosen
Date: Tue, 22 Dec 2009 18:54:37 +0800
References: <1261474791.289871.854376051633.1.gpush@pororo>
	<1261478868.10767.2.camel@concordia>
In-Reply-To: <1261478868.10767.2.camel@concordia>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <200912221854.37572.jeremy.kerr@canonical.com>
Cc: microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

> >  void early_init_dt_setup_initrd_arch(unsigned long start,
> > 				      unsigned long end);
> 
> arch_early_init_dt_setup_initrd() makes more sense to me, but ..

<foo>_arch has been the general convention for arch-specific hooks in 
drivers/of/.

> > +#ifdef CONFIG_BLK_DEV_INITRD
> > +void __init early_init_dt_setup_initrd_arch(unsigned long start,
> > +		unsigned long end)
> > +{
> > +	initrd_start = (unsigned long)__va(start);
> > +	initrd_end = (unsigned long)__va(end);
> > +	initrd_below_start_ok = 1;
> > +}
> > +#endif
> 
> Given you have two identical implementations why not make that the
> default and make it weak, and let ARM override it.

Yeah, that would be good too; just been avoiding weak as a potential source of 
magic voodoo complexity. Grant - up to you on this one.

Cheers,


Jeremy
