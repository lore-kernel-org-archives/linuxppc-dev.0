Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] [POWERPC] Clean up some linker and symbol usage
From: Michael Ellerman <michael@ellerman.id.au>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18412.10838.984230.869068@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.64.0803271452540.12382@blarg.am.freescale.net>
	<18412.10838.984230.869068@cargo.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-cZpfKRuyyZLmgFj+YMVM"
Date: Fri, 28 Mar 2008 11:45:38 +1100
Message-Id: <1206665138.8173.3.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-cZpfKRuyyZLmgFj+YMVM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Fri, 2008-03-28 at 10:14 +1100, Paul Mackerras wrote:
> Kumar Gala writes:
>=20
> > @@ -1124,7 +1124,7 @@ void __init early_init_devtree(void *params)
> >  	parse_early_param();
> >=20
> >  	/* Reserve LMB regions used by kernel, initrd, dt, etc... */
> > -	lmb_reserve(PHYSICAL_START, __pa(klimit) - PHYSICAL_START);
> > +	lmb_reserve(__pa(_stext), _end - _stext);
>=20
> In the kdump case where the kernel starts at the 32MB point
> (physical), wouldn't we want to reserve the first 32MB of RAM so that
> it can't get allocated and used for random things?  Doesn't that first
> 32MB contain the old kernel that we want to write out?

For kdump there is nMB of memory reserved at 32MB for the 2nd kernel,
and that's all it gets, all of the other memory is the old kernel text
or the old kernel's data.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-cZpfKRuyyZLmgFj+YMVM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBH7D+ydSjSd0sB4dIRAonZAKCxsT/9N3sgH+DN9bJ3Zo2d/njJBQCgwSBd
HE3Ild6RBUFRDk/9tj1l0/s=
=Buwa
-----END PGP SIGNATURE-----

--=-cZpfKRuyyZLmgFj+YMVM--
