Return-Path: <michael@ellerman.id.au>
Subject: Re: [POWERPC] convert string i/o operations to C
From: Michael Ellerman <michael@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20060920133532.ce818ab7.sfr@canb.auug.org.au>
References: <20060919222351.d27a1a06.sfr@canb.auug.org.au>
	<20060920133532.ce818ab7.sfr@canb.auug.org.au>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-k0/u1sc17w8Pt7lUQwFL"
Date: Wed, 20 Sep 2006 14:38:27 +1000
Message-Id: <1158727107.3129.8.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-k0/u1sc17w8Pt7lUQwFL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-09-20 at 13:35 +1000, Stephen Rothwell wrote:
> This produces essentially the same code and will make the iSeries i/o
> consolidation easier.

A bit more white space would be nice :D, eg:

> +void _insb(volatile u8 __iomem *port, void *buf, long count)
> +{
> +	u8 *tbuf =3D buf;
> +	u8 tmp;
> +
> +	if (unlikely(count <=3D 0))
> +		return;

> +	asm volatile("sync");

> +	do {
> +		tmp =3D *port;
> +		asm volatile("eieio");
> +		*tbuf++ =3D tmp;
> +	} while (--count !=3D 0);

> +	asm volatile("twi 0,%0,0; isync" : : "r" (tmp));
> +}
> +EXPORT_SYMBOL(_insb);

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-k0/u1sc17w8Pt7lUQwFL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBFEMXDdSjSd0sB4dIRAv9wAJ9uY68EqNKOP0vwzTorhArBjpkuHQCeJcIg
yJ3ZQ5LGX1e/ISm6oUdpU/s=
=ZJ3A
-----END PGP SIGNATURE-----

--=-k0/u1sc17w8Pt7lUQwFL--
