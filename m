Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 4777FDDE9F
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Oct 2007 22:21:28 +1000 (EST)
Date: Sun, 7 Oct 2007 22:21:19 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marian Balakowicz <m8@semihalf.com>
Subject: Re: [POWERPC 03/15] [POWERPC] TQM5200 board support
Message-Id: <20071007222119.4deabccc.sfr@canb.auug.org.au>
In-Reply-To: <4708C0DA.2040606@semihalf.com>
References: <47075FA7.3030108@semihalf.com>
	<4708C0DA.2040606@semihalf.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__7_Oct_2007_22_21_19_+1000_69g+arbNm5ApJqxw"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sun__7_Oct_2007_22_21_19_+1000_69g+arbNm5ApJqxw
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 07 Oct 2007 13:19:54 +0200 Marian Balakowicz <m8@semihalf.com> wrot=
e:
>
> +++ b/arch/powerpc/platforms/52xx/tqm5200.c
>
> +#include <asm/prom.h>

You need this for the flattened device tree stuff, so good. However ...

> +#include <asm/of_platform.h>

You should not include this file.  And you actually don't use any of the
of_platform routines, but you do need linux/of.h for the of_find_ ...
routines.

> +void tqm5200_show_cpuinfo(struct seq_file *m)
> +{
> +	struct device_node* np =3D of_find_all_nodes(NULL);

Not sure about this - if you want to find the root node, then you should
probably do that explicitly.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__7_Oct_2007_22_21_19_+1000_69g+arbNm5ApJqxw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHCM9FTgG2atn1QN8RAg7/AJ9ehQMSmMoinnH8qc8HUsg4x3E3WgCeL5si
gv3xpzGn3tNpZkq4ADXk6BU=
=hOxT
-----END PGP SIGNATURE-----

--Signature=_Sun__7_Oct_2007_22_21_19_+1000_69g+arbNm5ApJqxw--
