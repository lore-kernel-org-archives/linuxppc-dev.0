Return-Path: <michael@ellerman.id.au>
Subject: Re: Dynamic-ftrace not working in PlayStation3
From: Michael Ellerman <michael@ellerman.id.au>
To: Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <alpine.DEB.1.10.0901292234520.6222@gandalf.stny.rr.com>
References: <a25370a30901260639u3ab97112qf6688667d39e6706@mail.gmail.com>
	<49827003.5050307@am.sony.com>
	<alpine.DEB.1.10.0901292234520.6222@gandalf.stny.rr.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-PPAuCtfwhHAvjpnIBiML"
Date: Fri, 30 Jan 2009 16:44:41 +1100
Message-Id: <1233294281.8497.9.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Remis Lima Baima <remis.developer@googlemail.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-PPAuCtfwhHAvjpnIBiML
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2009-01-29 at 22:38 -0500, Steven Rostedt wrote:
> On Thu, 29 Jan 2009, Geoff Levand wrote:
>=20
> > >=20
> > > //*******************************************************************=
******************************************************************
> > > ip:d000000000045aec jumps to d000000000046340 r2: d000000000050c00
> > > 3d82ffff 398c5740 ffff5740 toc: d000000000046360 c0000000 00007cac
> > > ip:d0000000000458d0 jumps to d000000000046340 r2: d000000000050c00
> > > 3d82ffff 398c5740 ffff5740 toc: d000000000046360 c0000000 00007cac
> > > ip:d000000000045838 jumps to d000000000046340 r2: d000000000050c00
> > > 3d82ffff 398c5740 ffff5740 toc: d000000000046360 c0000000 00007cac
> > > ip:d0000000000456dc jumps to d000000000046340 r2: d000000000050c00
> > > 3d82ffff 398c5740 ffff5740 toc: d000000000046360 c0000000 00007cac
> > ...
>=20
> So I take it that the above showed that the code worked for some?
>=20
> > > ps3_system_bus_match:362: dev=3D11.0(lpm_01), drv=3D11.0(ps3-lpm): ma=
tch
> > > ps3_system_bus_match:362: dev=3D11.0(lpm_01), drv=3D11.0(ps3-lpm): ma=
tch
> > > ps3-lpm lpm_01:  <- ps3_lpm_probe:1245:
> > > ip:d0000000003fe280 jumps to d0000000003ffad8 r2: d000000000422c70
>=20
> Could you find out what that function is? Perhaps do a:
>=20
> 	printk("ip:%pF\n", ip);
>=20
> As long as you have kallsyms on, that should point to the function that's=
=20
> the problem.
>=20
> > > 3d82fffe 398cce68 fffece68 toc: d00000000040faf8 6c656400 5f5f6b73
> > > addr does not match
> > > ptr: 6c6564005f5f6b73
>=20
> ptr is the same info as the last line above.

6c656400 5f5f6b73 =3D "led\0__ks"

:)

> > --- a/arch/powerpc/kernel/ftrace.c
> > +++ b/arch/powerpc/kernel/ftrace.c
> > @@ -23,7 +23,7 @@
> >  #if 0
>=20
> Heh, I would have just done:
>=20
> - #if 0
> + #if 1
>=20
> ;-)

Should do s/DEBUGP/pr_debug/g

cheers


--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-PPAuCtfwhHAvjpnIBiML
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmCk8kACgkQdSjSd0sB4dKQ0gCcDnvyTZi9Ehz6xltUg3hqTBBg
0hMAniqRhSAa52BMSWGMR9aHikvNCtnu
=tums
-----END PGP SIGNATURE-----

--=-PPAuCtfwhHAvjpnIBiML--
