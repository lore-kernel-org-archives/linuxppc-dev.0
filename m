Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E8DE72C00BF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 13:42:04 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dwg@au1.ibm.com>;
 Thu, 11 Apr 2013 13:34:37 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B43F92BB0058
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 13:41:55 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3B3SZcD5112276
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 13:28:36 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3B3frVX027833
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 13:41:54 +1000
Date: Thu, 11 Apr 2013 13:20:03 +1000
From: David Gibson <dwg@au1.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V5 09/25] powerpc: Fix hpte_decode to use the correct
 decoding for page sizes
Message-ID: <20130411032003.GS8165@truffula.fritz.box>
References: <1365055083-31956-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1365055083-31956-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="OowMmFE4aK71mEhh"
In-Reply-To: <1365055083-31956-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--OowMmFE4aK71mEhh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2013 at 11:27:47AM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>=20
> As per ISA doc, we encode base and actual page size in the LP bits of
> PTE. The number of bit used to encode the page sizes depend on actual
> page size.  ISA doc lists this as
>=20
>    PTE LP     actual page size
> rrrr rrrz 	>=3D8KB
> rrrr rrzz	>=3D16KB
> rrrr rzzz 	>=3D32KB
> rrrr zzzz 	>=3D64KB
> rrrz zzzz 	>=3D128KB
> rrzz zzzz 	>=3D256KB
> rzzz zzzz	>=3D512KB
> zzzz zzzz 	>=3D1MB
>=20
> ISA doc also says
> "The values of the =E2=80=9Cz=E2=80=9D bits used to specify each size, al=
ong with all possible
> values of =E2=80=9Cr=E2=80=9D bits in the LP field, must result in LP val=
ues distinct from
> other LP values for other sizes."
>=20
> based on the above update hpte_decode to use the correct decoding for LP =
bits.
>=20
> Acked-by: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OowMmFE4aK71mEhh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlFmK+MACgkQaILKxv3ab8akdgCdHfqzHW5v6BVA7mu4VZ7FJI54
wDAAn2fFJMLq67MmyH++f57HGe5O/LhK
=P2Me
-----END PGP SIGNATURE-----

--OowMmFE4aK71mEhh--
