Return-Path: <mikey@ozlabs.org>
To: michael@ellerman.id.au
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc: Make RTAS console init generic 
In-reply-to: <1155705695.12715.7.camel@localhost.localdomain> 
References: <20060816040040.1E20967B55@ozlabs.org>
	<1155705695.12715.7.camel@localhost.localdomain>
Date: Wed, 16 Aug 2006 10:22:56 -0500
Sender: mikey@ozlabs.org
Message-Id: <20060816152303.7AF4967B5A@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org
Reply-To: Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <1155705695.12715.7.camel@localhost.localdomain> you wrote:
> 
> --=-PNKyW5KJv4630LcmkXVt
> Content-Type: text/plain
> Content-Transfer-Encoding: quoted-printable
> 
> On Tue, 2006-08-15 at 23:00 -0500, Michael Neuling wrote:
> > The RTAS console doesn't have to be Cell specific.  If we have both
> > the put and get char RTAS functions, init the rtas console.
> >=20
> > Index: linux-2.6-ozlabs/arch/powerpc/kernel/rtas.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-2.6-ozlabs.orig/arch/powerpc/kernel/rtas.c
> > +++ linux-2.6-ozlabs/arch/powerpc/kernel/rtas.c
> > @@ -910,6 +910,11 @@ int __init early_init_dt_scan_rtas(unsig
> >  	basep =3D of_get_flat_dt_prop(node, "get-term-char", NULL);
> >  	if (basep)
> >  		rtas_getchar_token =3D *basep;
> > +
> > +	if (rtas_putchar_token !=3D RTAS_UNKNOWN_SERVICE &&
> > +	    rtas_getchar_token !=3D RTAS_UNKNOWN_SERVICE)
> > +		udbg_init_rtas_console();
> > +
> >  #endif
> > =20
> >  	/* break now */
> > Index: linux-2.6-ozlabs/arch/powerpc/platforms/cell/setup.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-2.6-ozlabs.orig/arch/powerpc/platforms/cell/setup.c
> > +++ linux-2.6-ozlabs/arch/powerpc/platforms/cell/setup.c
> > @@ -150,10 +150,6 @@ static int __init cell_probe(void)
> >  	    !of_flat_dt_is_compatible(root, "IBM,CPBW-1.0"))
> >  		return 0;
> > =20
> > -#ifdef CONFIG_UDBG_RTAS_CONSOLE
> > -	udbg_init_rtas_console();
> > -#endif
> > -
> 
> I'd like to see it still guarded by UDBG_RTAS_CONSOLE, otherwise there's
> no way to select a different type of early console on a machine which
> has those tokens in the device tree.

Agreed but that section in rtas.c is already guarded by
UDBG_RTAS_CONSOLE.  After applying the patch, it looks like: 

#ifdef CONFIG_UDBG_RTAS_CONSOLE
	basep = of_get_flat_dt_prop(node, "put-term-char", NULL);
	if (basep)
		rtas_putchar_token = *basep;

	basep = of_get_flat_dt_prop(node, "get-term-char", NULL);
	if (basep)
		rtas_getchar_token = *basep;

	if (rtas_putchar_token != RTAS_UNKNOWN_SERVICE &&
	    rtas_getchar_token != RTAS_UNKNOWN_SERVICE)
		udbg_init_rtas_console();

#endif

Mikey
