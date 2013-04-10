Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 96B7B2C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 17:04:28 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dwg@au1.ibm.com>;
 Wed, 10 Apr 2013 17:02:13 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id DC7A53578053
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 17:04:18 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3A6oUFr7536922
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 16:50:30 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3A73m1A027472
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 17:03:48 +1000
Date: Wed, 10 Apr 2013 17:04:03 +1000
From: David Gibson <dwg@au1.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V5 06/25] powerpc: Reduce PTE table memory wastage
Message-ID: <20130410070403.GH8165@truffula.fritz.box>
References: <1365055083-31956-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1365055083-31956-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130410044611.GF8165@truffula.fritz.box>
 <8738uyq4om.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="QDIl5R72YNOeCxaP"
In-Reply-To: <8738uyq4om.fsf@linux.vnet.ibm.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--QDIl5R72YNOeCxaP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2013 at 11:59:29AM +0530, Aneesh Kumar K.V wrote:
> David Gibson <dwg@au1.ibm.com> writes:
> > On Thu, Apr 04, 2013 at 11:27:44AM +0530, Aneesh Kumar K.V wrote:
[snip]
> >> @@ -97,13 +100,45 @@ void __destroy_context(int context_id)
> >>  }
> >>  EXPORT_SYMBOL_GPL(__destroy_context);
> >> =20
> >> +#ifdef CONFIG_PPC_64K_PAGES
> >> +static void destroy_pagetable_page(struct mm_struct *mm)
> >> +{
> >> +	int count;
> >> +	struct page *page;
> >> +
> >> +	page =3D mm->context.pgtable_page;
> >> +	if (!page)
> >> +		return;
> >> +
> >> +	/* drop all the pending references */
> >> +	count =3D atomic_read(&page->_mapcount) + 1;
> >> +	/* We allow PTE_FRAG_NR(16) fragments from a PTE page */
> >> +	count =3D atomic_sub_return(16 - count, &page->_count);
> >
> > You should really move PTE_FRAG_NR to a header so you can actually use
> > it here rather than hard coding 16.
> >
> > It took me a fair while to convince myself that there is no race here
> > with something altering mapcount and count between the atomic_read()
> > and the atomic_sub_return().  It could do with a comment to explain
> > why that is safe.
> >
> > Re-using the mapcount field for your index also seems odd, and it took
> > me a while to convince myself that that's safe too.  Wouldn't it be
> > simpler to store a pointer to the next sub-page in the mm_context
> > instead? You can get from that to the struct page easily enough with a
> > shift and pfn_to_page().
>=20
> I found using _mapcount simpler in this case. I was looking at it not
> as an index, but rather how may fragments are mapped/used already.

Except that it's actually (#fragments - 1).  Using subpage pointer
makes the fragments calculation (very slightly) harder, but the
calculation of the table address easier.  More importantly it avoids
adding effectively an extra variable - which is then shoehorned into a
structure not really designed to hold it.

> Using
> subpage pointer in mm->context.xyz means, we have to calculate the
> number of fragments used/mapped via the pointer. We need the fragment
> count so that we can drop page reference count correctly here.
>=20
>=20
> >
> >> +	if (!count) {
> >> +		pgtable_page_dtor(page);
> >> +		reset_page_mapcount(page);
> >> +		free_hot_cold_page(page, 0);
> >
> > It would be nice to use put_page() somehow instead of duplicating its
> > logic, though I realise the sparc code you've based this on does the
> > same thing.
>=20
> That is not exactly put_page. We can avoid lots of check in this
> specific case.

[snip]
> >> +static pte_t *__alloc_for_cache(struct mm_struct *mm, int kernel)
> >> +{
> >> +	pte_t *ret =3D NULL;
> >> +	struct page *page =3D alloc_page(GFP_KERNEL | __GFP_NOTRACK |
> >> +				       __GFP_REPEAT | __GFP_ZERO);
> >> +	if (!page)
> >> +		return NULL;
> >> +
> >> +	spin_lock(&mm->page_table_lock);
> >> +	/*
> >> +	 * If we find pgtable_page set, we return
> >> +	 * the allocated page with single fragement
> >> +	 * count.
> >> +	 */
> >> +	if (likely(!mm->context.pgtable_page)) {
> >> +		atomic_set(&page->_count, PTE_FRAG_NR);
> >> +		atomic_set(&page->_mapcount, 0);
> >> +		mm->context.pgtable_page =3D page;
> >> +	}
> >
> > .. and in the unlikely case where there *is* a pgtable_page already
> > set, what then?  Seems like you should BUG_ON, or at least return NULL
> > - as it is you will return the first sub-page of that page again,
> > which is very likely in use.
>=20
>=20
> As explained in the comment above, we return with the allocated page
> with fragment count set to 1. So we end up having only one fragment. The
> other option I had was to to free the allocated page and do a
> get_from_cache under the page_table_lock. But since we already allocated
> the page, why not use that ?. It also keep the code similar to
> sparc.

My point is that I can't see any circumstance under which we should
ever hit this case.  Which means if we do something is badly messed up
and we should BUG() (or at least WARN()).

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--QDIl5R72YNOeCxaP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlFlDuMACgkQaILKxv3ab8bJowCdGoCAUvdKxMrOkkdVsiXYxNvl
TS8An3QIO0wDZykA8aT0GIrWMb0TQnut
=jMxj
-----END PGP SIGNATURE-----

--QDIl5R72YNOeCxaP--
