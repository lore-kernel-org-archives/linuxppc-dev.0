Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id C648DDDE1E
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 17:29:16 +1000 (EST)
Date: Fri, 26 Oct 2007 17:29:09 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 11/16] Use of_get_next_child() in eeh_restore_bars()
Message-Id: <20071026172909.f7a085e9.sfr@canb.auug.org.au>
In-Reply-To: <ef7facd658919117aa7c693b4eeb12241ca859d8.1193381582.git.michael@ellerman.id.au>
References: <80449d4682309dbf8cf80816be4f381fe875f3d1.1193381582.git.michael@ellerman.id.au>
	<ef7facd658919117aa7c693b4eeb12241ca859d8.1193381582.git.michael@ellerman.id.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__26_Oct_2007_17_29_09_+1000_XiCUkQD=ysSkH40_"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__26_Oct_2007_17_29_09_+1000_XiCUkQD=ysSkH40_
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Oct 2007 16:54:43 +1000 (EST) Michael Ellerman <michael@ellerman=
.id.au> wrote:
>
> +++ b/arch/powerpc/platforms/pseries/eeh.c
> @@ -841,11 +841,8 @@ void eeh_restore_bars(struct pci_dn *pdn)
>  	if ((pdn->eeh_mode & EEH_MODE_SUPPORTED) && !IS_BRIDGE(pdn->class_code))
>  		__restore_bars (pdn);
> =20
> -	dn =3D pdn->node->child;
> -	while (dn) {
> +	for (dn =3D NULL; (dn =3D of_get_next_child(pdn->node, dn));)

Just wondering if we need

#define for_each_child_node(dn, parent) \
	for (dn =3D of_get_next_child(parent, NULL); dn; \
		dn =3D of_get_next_child(parent, dn))

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__26_Oct_2007_17_29_09_+1000_XiCUkQD=ysSkH40_
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHIZdLTgG2atn1QN8RAh8XAJ9MBXqP2K1tTjiG5gr3ZDSzns4xiQCfd1Ak
K1AXryAMUFQeTOqh0BwmyPI=
=X3n8
-----END PGP SIGNATURE-----

--Signature=_Fri__26_Oct_2007_17_29_09_+1000_XiCUkQD=ysSkH40_--
