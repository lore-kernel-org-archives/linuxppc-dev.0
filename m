Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Export flat device tree via debugfs for debugging
From: Michael Ellerman <michael@ellerman.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <7C163A77-FF5F-49E7-87CF-0EA0411FE7A6@kernel.crashing.org>
References: <20060501074044.D552967B55@ozlabs.org>
	<7C163A77-FF5F-49E7-87CF-0EA0411FE7A6@kernel.crashing.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-kLi4FMX8T0SaVI2WcSP4"
Date: Tue, 02 May 2006 10:20:00 +1000
Message-Id: <1146529200.27495.23.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-kLi4FMX8T0SaVI2WcSP4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-05-01 at 12:54 -0500, Kumar Gala wrote:
> On May 1, 2006, at 2:40 AM, Michael Ellerman wrote:
>=20
> > If DEBUG is turned on in prom.c, export the flat device tree via =20
> > debugfs.
> > This has been handy on several occasions.
> >
> > To look at it:
> >  # mount -t debugfs none /sys/kernel/debug
> >  # od -a /sys/kernel/debug/powerpc/flat-device-tree
> >  and/or
> >  # dtc -fI dtb /sys/kernel/debug/powerpc/flat-device-tree -O dts
> >
> > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> > ---
> >
> >  arch/powerpc/kernel/prom.c |   25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > Index: to-merge/arch/powerpc/kernel/prom.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- to-merge.orig/arch/powerpc/kernel/prom.c
> > +++ to-merge/arch/powerpc/kernel/prom.c
> > @@ -30,6 +30,7 @@
> >  #include <linux/bitops.h>
> >  #include <linux/module.h>
> >  #include <linux/kexec.h>
> > +#include <linux/debugfs.h>
> >
> >  #include <asm/prom.h>
> >  #include <asm/rtas.h>
> > @@ -2009,3 +2010,27 @@ void kdump_move_device_tree(void)
> >  	/* XXX should we unreserve the old DT? */
> >  }
> >  #endif /* CONFIG_KEXEC */
> > +
> > +#ifdef DEBUG
>=20
> Shouldn't this also depend on DEBUGFS being built in.

It could, but DEBUG_FS is written so that you don't have to care, so I
didn't :)

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-kLi4FMX8T0SaVI2WcSP4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEVqWwdSjSd0sB4dIRAga0AKCzVNL2ct59ASFohwdMx00nCGEDeQCeJjqH
/PhibFsXJw/7cOOXVtLJvIw=
=vuNj
-----END PGP SIGNATURE-----

--=-kLi4FMX8T0SaVI2WcSP4--
