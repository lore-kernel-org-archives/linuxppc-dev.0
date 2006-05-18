Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH][resend] udbg_printf() formatting attribute
From: Michael Ellerman <michael@ellerman.id.au>
To: Jimi Xenidis <jimix@watson.ibm.com>
In-Reply-To: <34FAC3E5-F717-4640-B094-312C8773852E@watson.ibm.com>
References: <E1FgORv-0001dS-Hu@heater.watson.ibm.com>
	<1147908963.7360.1.camel@localhost.localdomain>
	<34FAC3E5-F717-4640-B094-312C8773852E@watson.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-mfhCpqm0V/VLTuLqdxDx"
Date: Fri, 19 May 2006 01:56:45 +1000
Message-Id: <1147967806.8469.10.camel@localhost.localdomain>
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


--=-mfhCpqm0V/VLTuLqdxDx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-05-18 at 08:22 -0400, Jimi Xenidis wrote:
> On May 17, 2006, at 7:36 PM, Michael Ellerman wrote:
>=20
> > On Wed, 2006-05-17 at 12:00 -0400, jimix@watson.ibm.com wrote:
> >> -	pr_debug("%s: current_entitled =3D %lu, current_weight =3D %lu\n",
> >> +	pr_debug("%s: current_entitled =3D %lu, current_weight =3D %u\n",
> >>  		 __FUNCTION__, current_entitled, current_weight);
> >>
> >> -	pr_debug("%s: new_entitled =3D %lu, new_weight =3D %lu\n",
> >> +	pr_debug("%s: new_entitled =3D %lu, new_weight =3D %u\n",
> >>  		 __FUNCTION__, *new_entitled_ptr, *new_weight_ptr);
> >
> > But pr_debug() calls printk, not udbg_printf() ?
>=20
> Now _thats_ funny!
> Then I'm so happy to have found and fixed this compiler warning :)

Haha, nice one Jimi :D

> >> -extern void udbg_printf(const char *fmt, ...);
> >> +extern void udbg_printf(const char *fmt, ...)
> >> +	__attribute__ ((format (printf, 1, 2)));
>=20
> I believe this chunk is still goodness as it will catch format issues =20
> for developers.

I'm actually hoping to get rid of udbg_printf(), but if I can't we
should stick this in I guess. The real problem IMHO is that debug
printks rot because they're rarely compiled, not sure what to do about
that.

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-mfhCpqm0V/VLTuLqdxDx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEbJk9dSjSd0sB4dIRAnz+AJwPxuBsvAW0KrTCdznsBcCARvOpBwCdF0r+
EgAhJHlIRaoXYQJWR2J8b68=
=WoTg
-----END PGP SIGNATURE-----

--=-mfhCpqm0V/VLTuLqdxDx--
