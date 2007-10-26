Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id C5134DDEB7
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 17:24:55 +1000 (EST)
Date: Fri, 26 Oct 2007 17:24:45 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 09/16] Use of_get_next_parent() in axon_msi.c
Message-Id: <20071026172445.634b4f09.sfr@canb.auug.org.au>
In-Reply-To: <4e749fe7078e2c006cf40921cea904833c75263c.1193381582.git.michael@ellerman.id.au>
References: <80449d4682309dbf8cf80816be4f381fe875f3d1.1193381582.git.michael@ellerman.id.au>
	<4e749fe7078e2c006cf40921cea904833c75263c.1193381582.git.michael@ellerman.id.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__26_Oct_2007_17_24_45_+1000_Z9l21nEcMJhMqRBm"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__26_Oct_2007_17_24_45_+1000_Z9l21nEcMJhMqRBm
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Oct 2007 16:54:41 +1000 (EST) Michael Ellerman <michael@ellerman=
.id.au> wrote:
>
> +++ b/arch/powerpc/platforms/cell/axon_msi.c
> @@ -125,7 +125,7 @@ static struct axon_msic *find_msi_translator(struct p=
ci_dev *dev)
>  		return NULL;
>  	}
> =20
> -	for (; dn; tmp =3D of_get_parent(dn), of_node_put(dn), dn =3D tmp) {
> +	for (; dn; dn =3D of_get_next_parent(dn)) {
>  		ph =3D of_get_property(dn, "msi-translator", NULL);
>  		if (ph)
>  			break;

You no longer assign anything to tmp, but just below here, you may jump
to out_error: which will do an of_node_put(tmp).  So you need to
initialise tmp or have another error goto label.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__26_Oct_2007_17_24_45_+1000_Z9l21nEcMJhMqRBm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD4DBQFHIZZFTgG2atn1QN8RAv3BAJilH7BeZ5jZp0djHJkVzIFrdmaUAJ9qNmx7
8eZ58QrMpNWW5Na+Igg3XQ==
=J6tR
-----END PGP SIGNATURE-----

--Signature=_Fri__26_Oct_2007_17_24_45_+1000_Z9l21nEcMJhMqRBm--
