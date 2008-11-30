Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 1/2] powerpc and sparc: Introduce dev_archdata node
	accessors
From: Michael Ellerman <michael@ellerman.id.au>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20081128191323.GA27260@oksana.dev.rtsoft.ru>
References: <20081128191323.GA27260@oksana.dev.rtsoft.ru>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-0bOttrQ0Jzcv3BMzATT6"
Date: Mon, 01 Dec 2008 09:23:42 +1100
Message-Id: <1228083822.11316.9.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	David Miller <davem@davemloft.net>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-0bOttrQ0Jzcv3BMzATT6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2008-11-28 at 22:13 +0300, Anton Vorontsov wrote:
> The name of the device_node field differ across the platforms, so we
> have to implement inlined accessors. This is needed to avoid ugly
> #ifdef in the generic code.


My grep skills may not be 1337 enough, but I only see maybe three uses
of arch_data.prom_node in arch/sparc:

# git grep "\.prom_node" arch/sparc/=20
arch/sparc/include/asm/fb.h:    node =3D dev->archdata.prom_node;
arch/sparc/kernel/smp.c:        cpu_data(id).prom_node =3D cpu_node;
arch/sparc/kernel/of_device.c:  sd->prom_node =3D dp;


And about 15 in arch/powerpc.

Would it be simpler to have sparc use "of_node"? DaveM?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-0bOttrQ0Jzcv3BMzATT6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkzEm4ACgkQdSjSd0sB4dLHLgCgtbUxlfFNTpMLNgSgqQsC6XUw
3+sAoLjRw0lq5NAO8NanZkt6xAYNznxo
=O/Qr
-----END PGP SIGNATURE-----

--=-0bOttrQ0Jzcv3BMzATT6--
