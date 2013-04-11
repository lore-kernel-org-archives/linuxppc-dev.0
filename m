Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B12822C00D6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 11:53:05 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dwg@au1.ibm.com>;
 Thu, 11 Apr 2013 11:45:35 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 64E143578054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 11:52:55 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3B1qJJU51183744
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 11:52:20 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3B1qNIZ024244
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 11:52:24 +1000
Date: Thu, 11 Apr 2013 11:20:56 +1000
From: David Gibson <dwg@au1.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V5 06/25] powerpc: Reduce PTE table memory wastage
Message-ID: <20130411012056.GL8165@truffula.fritz.box>
References: <1365055083-31956-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1365055083-31956-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130410044611.GF8165@truffula.fritz.box>
 <8738uyq4om.fsf@linux.vnet.ibm.com>
 <20130410070403.GH8165@truffula.fritz.box>
 <87r4iiom8a.fsf@linux.vnet.ibm.com>
 <87eheinuq5.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="1hVIwB4NpNcOOTEe"
In-Reply-To: <87eheinuq5.fsf@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--1hVIwB4NpNcOOTEe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2013 at 11:17:30PM +0530, Aneesh Kumar K.V wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
>=20
> > David Gibson <dwg@au1.ibm.com> writes:
> >
> >> On Wed, Apr 10, 2013 at 11:59:29AM +0530, Aneesh Kumar K.V wrote:
> >>> David Gibson <dwg@au1.ibm.com> writes:
> >>> > On Thu, Apr 04, 2013 at 11:27:44AM +0530, Aneesh Kumar K.V wrote:
> >> [snip]
> >>> >> @@ -97,13 +100,45 @@ void __destroy_context(int context_id)
> >>> >>  }
> >>> >>  EXPORT_SYMBOL_GPL(__destroy_context);
> >>> >> =20
> >>> >> +#ifdef CONFIG_PPC_64K_PAGES
> >>> >> +static void destroy_pagetable_page(struct mm_struct *mm)
> >>> >> +{
> >>> >> +	int count;
> >>> >> +	struct page *page;
> >>> >> +
> >>> >> +	page =3D mm->context.pgtable_page;
> >>> >> +	if (!page)
> >>> >> +		return;
> >>> >> +
> >>> >> +	/* drop all the pending references */
> >>> >> +	count =3D atomic_read(&page->_mapcount) + 1;
> >>> >> +	/* We allow PTE_FRAG_NR(16) fragments from a PTE page */
> >>> >> +	count =3D atomic_sub_return(16 - count, &page->_count);
> >>> >
> >>> > You should really move PTE_FRAG_NR to a header so you can actually =
use
> >>> > it here rather than hard coding 16.
> >>> >
> >>> > It took me a fair while to convince myself that there is no race he=
re
> >>> > with something altering mapcount and count between the atomic_read()
> >>> > and the atomic_sub_return().  It could do with a comment to explain
> >>> > why that is safe.
> >>> >
> >>> > Re-using the mapcount field for your index also seems odd, and it t=
ook
> >>> > me a while to convince myself that that's safe too.  Wouldn't it be
> >>> > simpler to store a pointer to the next sub-page in the mm_context
> >>> > instead? You can get from that to the struct page easily enough wit=
h a
> >>> > shift and pfn_to_page().
> >>>=20
> >>> I found using _mapcount simpler in this case. I was looking at it not
> >>> as an index, but rather how may fragments are mapped/used already.
> >>
> >> Except that it's actually (#fragments - 1).  Using subpage pointer
> >> makes the fragments calculation (very slightly) harder, but the
> >> calculation of the table address easier.  More importantly it avoids
> >> adding effectively an extra variable - which is then shoehorned into a
> >> structure not really designed to hold it.
> >
> > Even with subpage pointer we would need mm->context.pgtable_page or
> > something similar. We don't add any other extra variable right ?. Let me
> > try what you are suggesting here and see if that make it simpler.
>=20
>=20
> Here is what I ended up with. I will fold this in next update

Yeah, that looks better to me.  Note that ~PAGE_MASK is the more usual
idiom, rather than (PAGE_SIZE - 1).

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1hVIwB4NpNcOOTEe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlFmD/gACgkQaILKxv3ab8aZrQCeNm9q2cMp6yjvaoKZJAkaNHqh
z9QAn1JbXFwS7F+ueRQwb2lJQUy8Hi5m
=fNZH
-----END PGP SIGNATURE-----

--1hVIwB4NpNcOOTEe--
