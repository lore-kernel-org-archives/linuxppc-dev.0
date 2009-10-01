Return-Path: <michael@ellerman.id.au>
Subject: Re: 64bit kernel is huge
From: Michael Ellerman <michael@ellerman.id.au>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20090928074503.GB16073@kryten>
References: <20090928074503.GB16073@kryten>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-IE2dVYga3bboGJnIyw8k"
Date: Thu, 01 Oct 2009 13:36:16 +1000
Message-Id: <1254368176.11564.85.camel@concordia>
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-IE2dVYga3bboGJnIyw8k
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2009-09-28 at 17:45 +1000, Anton Blanchard wrote:
> Hi,
>=20
> I've found at least one machine that wont boot 2.6.31-rc* with a=20
> pseries_defconfig. If I move real-base from 0xc00000 to 0xd00000 it
> boots fine.
>=20
> # size vmlinux
>    text	   data	    bss	    dec	    hex	filename
> 9812942	1982496	1105228	12900666	 c4d93a	vmlinux
>=20
> Looks like we blow right through the 12MB mark. It desperately needs to e=
at
> less and lose weight.
>=20
> Here are some of the problem areas:
>=20
> 131072  lppaca
> 65536   paca
>=20
> I think we've attacked these before, not sure if there is anything left
> we can trim.

Why can't we dynamically allocate all but one paca? I seem to recall
Mikey tried it but it didn't work?

And on !ISERIES we should be able to allocate the lppacas too I think,
the HV doesn't know about them until register_vpa().

cheers

--=-IE2dVYga3bboGJnIyw8k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkrEI7AACgkQdSjSd0sB4dLUvQCfT/kla/9qLkiNNwScNiAPWHMJ
Y0EAnjDHrarkqIdcAvJqbCduVLCMtbPU
=9j1E
-----END PGP SIGNATURE-----

--=-IE2dVYga3bboGJnIyw8k--
