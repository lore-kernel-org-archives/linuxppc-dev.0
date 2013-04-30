Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0FB192C00C7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Apr 2013 12:24:34 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dwg@au1.ibm.com>;
 Tue, 30 Apr 2013 12:16:31 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 483F22BB004F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Apr 2013 12:24:29 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3U2AldQ23265418
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Apr 2013 12:10:47 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3U2OS5Y030260
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Apr 2013 12:24:28 +1000
Date: Tue, 30 Apr 2013 12:24:19 +1000
From: David Gibson <dwg@au1.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V7 01/18] mm/THP: HPAGE_SHIFT is not a #define on some
 arch
Message-ID: <20130430022419.GW20202@truffula.fritz.box>
References: <1367177859-7893-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1367177859-7893-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130430022149.GU20202@truffula.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="AAiVQQES42Kk67ff"
In-Reply-To: <20130430022149.GU20202@truffula.fritz.box>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--AAiVQQES42Kk67ff
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2013 at 12:21:49PM +1000, David Gibson wrote:
> On Mon, Apr 29, 2013 at 01:07:22AM +0530, Aneesh Kumar K.V wrote:
> > From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> >=20
> > On archs like powerpc that support different hugepage sizes, HPAGE_SHIFT
> > and other derived values like HPAGE_PMD_ORDER are not constants. So move
> > that to hugepage_init
>=20
> These seems to miss the point.  Those variables may be defined in
> terms of HPAGE_SHIFT right now, but that is of itself kind of broken.
> The transparent hugepage mechanism only works if the hugepage size is
> equal to the PMD size - and PMD_SHIFT remains a compile time constant.
>=20
> There's no reason having transparent hugepage should force the PMD
> size of hugepage to be the default for other purposes - it should be
> possible to do THP as long as PMD-sized is a possible hugepage size.

Oh, also, I'm pretty sure I said something similar on the last
posting.  Receiving review comments and then ignoring them does not
count as "Reviewed-by"...

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--AAiVQQES42Kk67ff
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlF/K1MACgkQaILKxv3ab8ZG0ACdE7EVAPUvYm9ZKpBCGl5kcxUZ
mdAAnjuJ05ld6KGO2nz+O7O1clcnF5kP
=mSnw
-----END PGP SIGNATURE-----

--AAiVQQES42Kk67ff--
