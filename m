Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A2A6FDDDE1
	for <linuxppc-dev@ozlabs.org>; Mon, 11 May 2009 12:14:08 +1000 (EST)
Subject: Re: [PATCH] powerpc/mpic: improve interrupt handling performance
From: Michael Ellerman <michael@ellerman.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1241820500-12545-1-git-send-email-galak@kernel.crashing.org>
References: <1241820500-12545-1-git-send-email-galak@kernel.crashing.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-/aok1PSwuUyrsiskbajz"
Date: Mon, 11 May 2009 12:14:07 +1000
Message-Id: <1242008047.7767.33.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-/aok1PSwuUyrsiskbajz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2009-05-08 at 17:08 -0500, Kumar Gala wrote:
> Before when we were setting up the irq host map for mpic we passed in
> just isu_size for the size of the linear map.  However, for a number of
> mpic implementations we have no isu (thus pass in 0) and will end up
> with a no linear map (size =3D 0).  This causes us to always call
> irq_find_mapping() from mpic_get_irq().
>=20
> By moving the allocation of the host map to after we've determined the
> number of sources we can actually benefit from having a linear map for
> the non-isu users that covers all the interrupt sources.

That's a nasty bug, so I think we should do:

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 7d46e5d..2b958d6 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -537,6 +537,7 @@ struct irq_host *irq_alloc_host(struct device_node *of_=
node,
                }
                break;
        case IRQ_HOST_MAP_LINEAR:
+               WARN_ON(revmap_arg =3D=3D 0);
                rmap =3D (unsigned int *)(host + 1);
                for (i =3D 0; i < revmap_arg; i++)
                        rmap[i] =3D NO_IRQ;

To save anyone else the embarrassment :)

cheers

--=-/aok1PSwuUyrsiskbajz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkoHie8ACgkQdSjSd0sB4dJwIQCgg6sTQbLDiAu57sOam8YmTTiT
lo4AoJeFcLLZgAoHsmW8wD7y4gayw0ve
=yE7U
-----END PGP SIGNATURE-----

--=-/aok1PSwuUyrsiskbajz--
