Return-Path: <jason.mcmullan@timesys.com>
Received: from exchange.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id 931BE67A73
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Mar 2005 07:58:26 +1100 (EST)
From: Jason McMullan <jason.mcmullan@timesys.com>
To: Wade Farnsworth <wfarnsworth@mvista.com>
In-Reply-To: <1110913681.24673.42.camel@rhino.az.mvista.com>
References: <1110907039.24673.12.camel@rhino.az.mvista.com>
	<20050315184153.GB28823@gate.ebshome.net>
	<1110913681.24673.42.camel@rhino.az.mvista.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-07YD5pPoeoFy4mrSJ4te"
Date: Tue, 15 Mar 2005 15:58:23 -0500
Message-Id: <1110920303.5937.103.camel@ad.doubleclick.net>
Mime-Version: 1.0
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 1/3] PPC440EP SoC and Bamboo board support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-07YD5pPoeoFy4mrSJ4te
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I think your setup for BAMBOO_PCIL0_PTM1MS is actually incorrect.
According to the AMCC 440EP docs, BAMBOO_PCIL0_PTM1MS is a mask,
so the correct code should look more like:

        memory_size =3D 0xffffffff - (memory_size - 1);
	PCI_WRITEL(memory_size | 1, BAMBOO_PCIL0_PTM1MS);

(assuming 'memory_size' is a power of 2)

--=20
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation


--=-07YD5pPoeoFy4mrSJ4te
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCN0xv8/0vJ5szK6kRAjl0AKDDN196uD2XZ25BNpnmgIoR2zAhhACeMJR+
dEtGIIA5+A7HpkXCJ+dZYUs=
=7Wzn
-----END PGP SIGNATURE-----

--=-07YD5pPoeoFy4mrSJ4te--
