Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8CAD12C00DD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Apr 2013 15:19:22 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dwg@au1.ibm.com>;
 Tue, 30 Apr 2013 15:07:13 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 7AB752BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Apr 2013 15:19:17 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3U55Z7K22478918
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Apr 2013 15:05:35 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3U5JGhS026987
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Apr 2013 15:19:16 +1000
Date: Tue, 30 Apr 2013 15:17:18 +1000
From: David Gibson <dwg@au1.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V7 09/18] powerpc: Switch 16GB and 16MB explicit
 hugepages to a different page table format
Message-ID: <20130430051718.GB20202@truffula.fritz.box>
References: <1367177859-7893-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1367177859-7893-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="WG0/bXtUnGTsWt66"
In-Reply-To: <1367177859-7893-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--WG0/bXtUnGTsWt66
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2013 at 01:07:30AM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>=20
> We will be switching PMD_SHIFT to 24 bits to facilitate THP impmenetation.
> With PMD_SHIFT set to 24, we now have 16MB huge pages allocated at PGD le=
vel.
> That means with 32 bit process we cannot allocate normal pages at
> all, because we cover the entire address space with one pgd entry. Fix th=
is
> by switching to a new page table format for hugepages. With the new page =
table
> format for 16GB and 16MB hugepages we won't allocate hugepage directory. =
Instead
> we encode the PTE information directly at the directory level. This force=
s 16MB
> hugepage at PMD level. This will also make the page take walk much simple=
r later
> when we add the THP support.
>=20
> With the new table format we have 4 cases for pgds and pmds:
> (1) invalid (all zeroes)
> (2) pointer to next table, as normal; bottom 6 bits =3D=3D 0
> (3) leaf pte for huge page, bottom two bits !=3D 00
> (4) hugepd pointer, bottom two bits =3D=3D 00, next 4 bits indicate size
> of table
>=20
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Mostly ok, except that in several pages your comments imply you have
16M and 16M page directory levels, but you haven't actually made that
change yet.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WG0/bXtUnGTsWt66
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlF/U94ACgkQaILKxv3ab8Z0QQCfQdn7i4FpPxl/wxygybY35S3u
9PEAn27oIHzZf0eXK7sxTx9OhIQB04TP
=jGRf
-----END PGP SIGNATURE-----

--WG0/bXtUnGTsWt66--
