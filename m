Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 683E12C00B6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 15:53:37 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dwg@au1.ibm.com>;
 Fri, 12 Apr 2013 15:47:55 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8E5E8357804A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 15:53:32 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3C5qvZL12517834
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 15:52:57 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3C5r1Rr016527
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 15:53:02 +1000
Date: Fri, 12 Apr 2013 15:39:47 +1000
From: David Gibson <dwg@au1.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V5 17/25] powerpc/THP: Implement transparent hugepages
 for ppc64
Message-ID: <20130412053947.GI5065@truffula.fritz.box>
References: <1365055083-31956-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1365055083-31956-18-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130411053823.GE8165@truffula.fritz.box>
 <87sj2xms5u.fsf@linux.vnet.ibm.com>
 <20130412005135.GA5065@truffula.fritz.box>
 <8761zsmj65.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="WHz+neNWvhIGAO8A"
In-Reply-To: <8761zsmj65.fsf@linux.vnet.ibm.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--WHz+neNWvhIGAO8A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2013 at 10:36:58AM +0530, Aneesh Kumar K.V wrote:
> David Gibson <dwg@au1.ibm.com> writes:
>=20
> > On Thu, Apr 11, 2013 at 01:10:29PM +0530, Aneesh Kumar K.V wrote:
> >> David Gibson <dwg@au1.ibm.com> writes:
> >>=20
> >> > On Thu, Apr 04, 2013 at 11:27:55AM +0530, Aneesh Kumar K.V wrote:
> >> >> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> >> >>=20
> >> >> We now have pmd entries covering to 16MB range. To implement THP on=
 powerpc,
> >> >> we double the size of PMD. The second half is used to deposit the p=
gtable (PTE page).
> >> >> We also use the depoisted PTE page for tracking the HPTE informatio=
n. The information
> >> >> include [ secondary group | 3 bit hidx | valid ]. We use one byte p=
er each HPTE entry.
> >> >> With 16MB hugepage and 64K HPTE we need 256 entries and with 4K HPT=
E we need
> >> >> 4096 entries. Both will fit in a 4K PTE page.
> >> >>=20
> >> >> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> >> >> ---
> >> >>  arch/powerpc/include/asm/page.h              |    2 +-
> >> >>  arch/powerpc/include/asm/pgtable-ppc64-64k.h |    3 +-
> >> >>  arch/powerpc/include/asm/pgtable-ppc64.h     |    2 +-
> >> >>  arch/powerpc/include/asm/pgtable.h           |  240 ++++++++++++++=
++++++
> >> >>  arch/powerpc/mm/pgtable.c                    |  314 ++++++++++++++=
++++++++++++
> >> >>  arch/powerpc/mm/pgtable_64.c                 |   13 ++
> >> >>  arch/powerpc/platforms/Kconfig.cputype       |    1 +
> >> >>  7 files changed, 572 insertions(+), 3 deletions(-)
> >> >>=20
> >> >> diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include=
/asm/page.h
> >> >> index 38e7ff6..b927447 100644
> >> >> --- a/arch/powerpc/include/asm/page.h
> >> >> +++ b/arch/powerpc/include/asm/page.h
> >> >> @@ -40,7 +40,7 @@
> >> >>  #ifdef CONFIG_HUGETLB_PAGE
> >> >>  extern unsigned int HPAGE_SHIFT;
> >> >>  #else
> >> >> -#define HPAGE_SHIFT PAGE_SHIFT
> >> >> +#define HPAGE_SHIFT PMD_SHIFT
> >> >
> >> > That looks like it could break everything except the 64k page size
> >> > 64-bit base.
> >>=20
> >> How about=20
> >
> > It seems very dubious to me to have transparent hugepages enabled
> > without explicit hugepages in the first place.
> >
>=20
> IMHO once we have THP, we will not be using explicit hugepages unless we
> want 16GB pages.

We still can't go breaking the combination in the interim.  Especially
if users are already in the habit of invoking things with
libhugetlbfs.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WHz+neNWvhIGAO8A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlFnniMACgkQaILKxv3ab8YEkgCfTgzvvlhBT7NPiDeBmIPw3l6G
3XoAn0V1ou3spdJ2MTyfwp+aWwA6v6oI
=DdOB
-----END PGP SIGNATURE-----

--WHz+neNWvhIGAO8A--
