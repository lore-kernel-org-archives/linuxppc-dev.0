Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41MNDG56pTzF2Wl
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jul 2018 15:13:34 +1000 (AEST)
Date: Fri, 6 Jul 2018 15:06:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH kernel v3 2/2] KVM: PPC: Check if IOMMU page is contained
 in the pinned physical page
Message-ID: <20180706050659.GO3450@umbus.fritz.box>
References: <20180704050052.20045-1-aik@ozlabs.ru>
 <20180704050052.20045-3-aik@ozlabs.ru>
 <20180705024220.GF3450@umbus.fritz.box>
 <20180705151904.17de7322@aik.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="c2gYorpyS4gG0T74"
In-Reply-To: <20180705151904.17de7322@aik.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--c2gYorpyS4gG0T74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 05, 2018 at 03:19:04PM +1000, Alexey Kardashevskiy wrote:
> On Thu, 5 Jul 2018 12:42:20 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Wed, Jul 04, 2018 at 03:00:52PM +1000, Alexey Kardashevskiy wrote:
> > > A VM which has:
> > >  - a DMA capable device passed through to it (eg. network card);
> > >  - running a malicious kernel that ignores H_PUT_TCE failure;
> > >  - capability of using IOMMU pages bigger that physical pages
> > > can create an IOMMU mapping that exposes (for example) 16MB of
> > > the host physical memory to the device when only 64K was allocated to=
 the VM.
> > >=20
> > > The remaining 16MB - 64K will be some other content of host memory, p=
ossibly
> > > including pages of the VM, but also pages of host kernel memory, host
> > > programs or other VMs.
> > >=20
> > > The attacking VM does not control the location of the page it can map,
> > > and is only allowed to map as many pages as it has pages of RAM.
> > >=20
> > > We already have a check in drivers/vfio/vfio_iommu_spapr_tce.c that
> > > an IOMMU page is contained in the physical page so the PCI hardware w=
on't
> > > get access to unassigned host memory; however this check is missing in
> > > the KVM fastpath (H_PUT_TCE accelerated code). We were lucky so far a=
nd
> > > did not hit this yet as the very first time when the mapping happens
> > > we do not have tbl::it_userspace allocated yet and fall back to
> > > the userspace which in turn calls VFIO IOMMU driver, this fails and
> > > the guest does not retry,
> > >=20
> > > This stores the smallest preregistered page size in the preregistered
> > > region descriptor and changes the mm_iommu_xxx API to check this agai=
nst
> > > the IOMMU page size. This only allows huge pages use if the entire
> > > preregistered block is backed with huge pages which are completely
> > > contained the preregistered chunk; otherwise this defaults to PAGE_SI=
ZE.
> > >=20
> > > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru> =20
> >=20
> > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> >=20
> > On the grounds that I think this version is safe, which the old one
> > wasn't.  However it still has some flaws..
> >=20
> > [snip]
> > > @@ -125,7 +126,8 @@ long mm_iommu_get(struct mm_struct *mm, unsigned =
long ua, unsigned long entries,
> > >  {
> > >  	struct mm_iommu_table_group_mem_t *mem;
> > >  	long i, j, ret =3D 0, locked_entries =3D 0;
> > > -	struct page *page =3D NULL;
> > > +	unsigned int pageshift;
> > > +	struct page *page =3D NULL, *head =3D NULL;
> > > =20
> > >  	mutex_lock(&mem_list_mutex);
> > > =20
> > > @@ -159,6 +161,7 @@ long mm_iommu_get(struct mm_struct *mm, unsigned =
long ua, unsigned long entries,
> > >  		goto unlock_exit;
> > >  	}
> > > =20
> > > +	mem->pageshift =3D 64;
> > >  	mem->hpas =3D vzalloc(array_size(entries, sizeof(mem->hpas[0])));
> > >  	if (!mem->hpas) {
> > >  		kfree(mem);
> > > @@ -199,9 +202,35 @@ long mm_iommu_get(struct mm_struct *mm, unsigned=
 long ua, unsigned long entries,
> > >  			}
> > >  		}
> > >  populate:
> > > +		pageshift =3D PAGE_SHIFT;
> > > +		if (PageCompound(page)) {
> > > +			/* Make sure huge page is contained completely */
> > > +			struct page *tmphead =3D compound_head(page);
> > > +			unsigned int n =3D compound_order(tmphead);
> > > +
> > > +			if (!head) {
> > > +				/* Is it a head of a huge page? */
> > > +				if (page =3D=3D tmphead) {
> > > +					head =3D tmphead;
> > > +					pageshift +=3D n;
> > > +				}
> > > +			} else if (head =3D=3D tmphead) {
> > > +				/* Still same huge page, good */
> > > +				pageshift +=3D n;
> > > +
> > > +				/* End of the huge page */
> > > +				if (page - head =3D=3D (1UL << n) - 1)
> > > +					head =3D NULL;
> > > +			}
> > > +		}
> > > +		mem->pageshift =3D min(mem->pageshift, pageshift);
> > >  		mem->hpas[i] =3D page_to_pfn(page) << PAGE_SHIFT;
> > >  	}
> > > =20
> > > +	/* We have an incomplete huge page, default to PAGE_SHIFT */
> > > +	if (head)
> > > +		mem->pageshift =3D PAGE_SHIFT;
> > > + =20
> >=20
> > So, if the user attempts to prereg a region which starts or ends in
> > the middle of a hugepage, this logic will clamp the region's max page
> > shift down to PAGE_SHIFT.  That's safe, but not optimal.
> >=20
> > Suppose userspace had an area backed with 16MiB hugepages, and wanted
> > to pre-reg a window that was 2MiB aligned, but not 16MiB aligned.  It
> > would still be safe to allow 2MiB TCEs, but the code above would clamp
> > it down to 64kiB (or 4kiB).
> >=20
> > The code to do it is also pretty convoluted.
> >=20
> > I think you'd be better off initializing mem->pageshift to the largest
> > possible natural alignment of the region:
> > 	mem->pageshift =3D ctz64(ua | (entries << PAGE_SHIFT));
> >=20
> > Then it should just be sufficient to clamp pageshift down to
> > compound_order() + PAGE_SHIFT for each entry.
>=20
>=20
> I like this better, just one question - does hugetlbfs guarantee the @ua
> alignment if backed with an actual huge page?

So, yeah it does, as you determined.  And it has to - I don't know of
any MMU that allows for large pages that aren't naturally aligned, so
the uas would have to be aligned to actually map the pages into
userspace.

But... there's another more subtle case that I'm less sure about.
What you're actually checking for here is a compound page on the
physical side.  A hugetlbfs mapping in userspace is the main case
where I'd expect that, but, I'm not absolutely certain there can't be
some other case where a compound page is used to back a normal 64k
mapping in a user process.  If that is possible, it would probably
also be possible for the UA to end up misaligned with the compound
page's natural alignment.

I don't know of any case where that could happen, but I'm far from
confident it doesn't exist.  Things to consider:
   - mapping hugetlbfs, then mremap()ing part of it
   - a SHARED mapping, where it's aligned in one process and gets
     THPed, but is not aligned in the other
   - mmap() from a device or subsystem that provides some kind
     of IO or special memory that's handled with compound pages on the
     kernel side, but is just mapped into userspace with regular 64k
     PTEs
   - One process mapping libhugetlbfs, then another (say a debugger_
     attempting to map the first process's address space via
     /proc/pid/mem)
   - ..and that's just the ones I could think of quickly

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--c2gYorpyS4gG0T74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls++PEACgkQbDjKyiDZ
s5J4Vg/9EpeUZpkUwOZetSgQXKVhBcW7UCnk9xafFoL2EHomsDH4jKjB4SZr6qmc
UCizgEpMjXVDa9P1QIlDfE3HWaqy4UTPaxOyy6svNMtZy+BXCLPlSURZ9r8RqO0y
DewB/dOdAfUoSrIUcd78mZ7Mgnt/Rz5xiWCFz+9UQ4M0N4CSiyC1W8lJDFS7Cx5p
sJ0wZYsK+g1euycQjeRNE1Pe7ZBoSMOx939OcKXRY43hRZzAMkeaLkGSYwKra3Qr
jJcduCZwQloo7rQftQnhngtUDJhvXetUpCcaZwbWP0DmteKkqqod0zt0MO98rzhT
N3QxQjc99Oi2SNjUr8HMVPh4pSs2UOPj+Rb4uDfCfloiyPSY5JRr7bXqwJlhQrjb
npqmdlStUPuct0lAg7gTtqd4wZ+2TQ4o09PpB9rzVM0Agxm9d1pRJUNTKNL2hUqL
0yZQfGGVY3ptTRwwIZkeVOO2WYwRMxdD9p23aAIqtla5XFYRKC06Jr+sdFsGRGqQ
2zgvosNaAYiTI+5iV876lgh6RKEsyg277g9Lru7MBFBQ2+AYOtDZV4uvp2biCPnE
aRdprixZdRvl5FuJCmMGywCCIwEBpe/pYr2GIFSQnoAY9JluliQBxQpYudFmOlws
5TSsyJoLJigjHbQlqTJOZZLWaljO262o8BEVuHJ9EeuCFbjApzc=
=z7Db
-----END PGP SIGNATURE-----

--c2gYorpyS4gG0T74--
