Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 70A792C00AE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Apr 2013 12:22:11 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dwg@au1.ibm.com>;
 Tue, 30 Apr 2013 12:14:06 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 652C02CE804A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Apr 2013 12:22:04 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3U2Lv0x23003374
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Apr 2013 12:21:58 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3U2M2Cf016865
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Apr 2013 12:22:03 +1000
Date: Tue, 30 Apr 2013 12:21:49 +1000
From: David Gibson <dwg@au1.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V7 01/18] mm/THP: HPAGE_SHIFT is not a #define on some
 arch
Message-ID: <20130430022149.GU20202@truffula.fritz.box>
References: <1367177859-7893-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1367177859-7893-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Sh7h4lnU5nPTsIof"
In-Reply-To: <1367177859-7893-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sh7h4lnU5nPTsIof
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2013 at 01:07:22AM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>=20
> On archs like powerpc that support different hugepage sizes, HPAGE_SHIFT
> and other derived values like HPAGE_PMD_ORDER are not constants. So move
> that to hugepage_init

These seems to miss the point.  Those variables may be defined in
terms of HPAGE_SHIFT right now, but that is of itself kind of broken.
The transparent hugepage mechanism only works if the hugepage size is
equal to the PMD size - and PMD_SHIFT remains a compile time constant.

There's no reason having transparent hugepage should force the PMD
size of hugepage to be the default for other purposes - it should be
possible to do THP as long as PMD-sized is a possible hugepage size.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Sh7h4lnU5nPTsIof
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlF/Kr0ACgkQaILKxv3ab8YK6ACePQzw/9X5H+l8PCCPLjXKGkKa
pYoAn2p0muo2mU8ZvptskameU9fEeUY/
=f8lO
-----END PGP SIGNATURE-----

--Sh7h4lnU5nPTsIof--
