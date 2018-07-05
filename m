Return-Path: <aik@ozlabs.ru>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41LmPK4bh2zDqHx
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2018 15:19:16 +1000 (AEST)
Received: by mail-pl0-x244.google.com with SMTP id t6-v6so697613plo.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Jul 2018 22:19:16 -0700 (PDT)
Date: Thu, 5 Jul 2018 15:19:04 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, Alex Williamson
 <alex.williamson@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul
 Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH kernel v3 2/2] KVM: PPC: Check if IOMMU page is
 contained in the pinned physical page
Message-ID: <20180705151904.17de7322@aik.ozlabs.ibm.com>
In-Reply-To: <20180705024220.GF3450@umbus.fritz.box>
References: <20180704050052.20045-1-aik@ozlabs.ru>
 <20180704050052.20045-3-aik@ozlabs.ru>
 <20180705024220.GF3450@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/zEOzHve390wP_AdolKtBwuz"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/zEOzHve390wP_AdolKtBwuz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Jul 2018 12:42:20 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Jul 04, 2018 at 03:00:52PM +1000, Alexey Kardashevskiy wrote:
> > A VM which has:
> >  - a DMA capable device passed through to it (eg. network card);
> >  - running a malicious kernel that ignores H_PUT_TCE failure;
> >  - capability of using IOMMU pages bigger that physical pages
> > can create an IOMMU mapping that exposes (for example) 16MB of
> > the host physical memory to the device when only 64K was allocated to t=
he VM.
> >=20
> > The remaining 16MB - 64K will be some other content of host memory, pos=
sibly
> > including pages of the VM, but also pages of host kernel memory, host
> > programs or other VMs.
> >=20
> > The attacking VM does not control the location of the page it can map,
> > and is only allowed to map as many pages as it has pages of RAM.
> >=20
> > We already have a check in drivers/vfio/vfio_iommu_spapr_tce.c that
> > an IOMMU page is contained in the physical page so the PCI hardware won=
't
> > get access to unassigned host memory; however this check is missing in
> > the KVM fastpath (H_PUT_TCE accelerated code). We were lucky so far and
> > did not hit this yet as the very first time when the mapping happens
> > we do not have tbl::it_userspace allocated yet and fall back to
> > the userspace which in turn calls VFIO IOMMU driver, this fails and
> > the guest does not retry,
> >=20
> > This stores the smallest preregistered page size in the preregistered
> > region descriptor and changes the mm_iommu_xxx API to check this against
> > the IOMMU page size. This only allows huge pages use if the entire
> > preregistered block is backed with huge pages which are completely
> > contained the preregistered chunk; otherwise this defaults to PAGE_SIZE.
> >=20
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru> =20
>=20
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> On the grounds that I think this version is safe, which the old one
> wasn't.  However it still has some flaws..
>=20
> [snip]
> > @@ -125,7 +126,8 @@ long mm_iommu_get(struct mm_struct *mm, unsigned lo=
ng ua, unsigned long entries,
> >  {
> >  	struct mm_iommu_table_group_mem_t *mem;
> >  	long i, j, ret =3D 0, locked_entries =3D 0;
> > -	struct page *page =3D NULL;
> > +	unsigned int pageshift;
> > +	struct page *page =3D NULL, *head =3D NULL;
> > =20
> >  	mutex_lock(&mem_list_mutex);
> > =20
> > @@ -159,6 +161,7 @@ long mm_iommu_get(struct mm_struct *mm, unsigned lo=
ng ua, unsigned long entries,
> >  		goto unlock_exit;
> >  	}
> > =20
> > +	mem->pageshift =3D 64;
> >  	mem->hpas =3D vzalloc(array_size(entries, sizeof(mem->hpas[0])));
> >  	if (!mem->hpas) {
> >  		kfree(mem);
> > @@ -199,9 +202,35 @@ long mm_iommu_get(struct mm_struct *mm, unsigned l=
ong ua, unsigned long entries,
> >  			}
> >  		}
> >  populate:
> > +		pageshift =3D PAGE_SHIFT;
> > +		if (PageCompound(page)) {
> > +			/* Make sure huge page is contained completely */
> > +			struct page *tmphead =3D compound_head(page);
> > +			unsigned int n =3D compound_order(tmphead);
> > +
> > +			if (!head) {
> > +				/* Is it a head of a huge page? */
> > +				if (page =3D=3D tmphead) {
> > +					head =3D tmphead;
> > +					pageshift +=3D n;
> > +				}
> > +			} else if (head =3D=3D tmphead) {
> > +				/* Still same huge page, good */
> > +				pageshift +=3D n;
> > +
> > +				/* End of the huge page */
> > +				if (page - head =3D=3D (1UL << n) - 1)
> > +					head =3D NULL;
> > +			}
> > +		}
> > +		mem->pageshift =3D min(mem->pageshift, pageshift);
> >  		mem->hpas[i] =3D page_to_pfn(page) << PAGE_SHIFT;
> >  	}
> > =20
> > +	/* We have an incomplete huge page, default to PAGE_SHIFT */
> > +	if (head)
> > +		mem->pageshift =3D PAGE_SHIFT;
> > + =20
>=20
> So, if the user attempts to prereg a region which starts or ends in
> the middle of a hugepage, this logic will clamp the region's max page
> shift down to PAGE_SHIFT.  That's safe, but not optimal.
>=20
> Suppose userspace had an area backed with 16MiB hugepages, and wanted
> to pre-reg a window that was 2MiB aligned, but not 16MiB aligned.  It
> would still be safe to allow 2MiB TCEs, but the code above would clamp
> it down to 64kiB (or 4kiB).
>=20
> The code to do it is also pretty convoluted.
>=20
> I think you'd be better off initializing mem->pageshift to the largest
> possible natural alignment of the region:
> 	mem->pageshift =3D ctz64(ua | (entries << PAGE_SHIFT));
>=20
> Then it should just be sufficient to clamp pageshift down to
> compound_order() + PAGE_SHIFT for each entry.


I like this better, just one question - does hugetlbfs guarantee the @ua
alignment if backed with an actual huge page?


--
Alexey

--Sig_/zEOzHve390wP_AdolKtBwuz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEECIb1sawlPgRl/px9ze7KtGKK020FAls9qkkACgkQze7KtGKK
020YkA/+MKOGw2E55GkLCBKYYFi8ZEoZDnoi4RTK+GbZzZAOSyWsTXzComXnj8yL
XQgOEV2EhL+Hg2zKPDWkdgi2wi8s5H5eAPuKUo9N5Qlv+iJR+PBVeQirEMtUXl1W
0YzrYVxoQCgUEdyJF6x0cmYuYQ2jQ6ZklBcJ8G9OT8fOxVGaqW+14bd33eCQXECw
ArG2XFyEzLnCMr1DA44M9iwrRBf7qrCgzckct9n6ldn536139uVfsgYiZr6DZmoD
8btabWh2yKmMG/49N6jmE8JZCCMSYG+NYbJOQupRuETe8pK84IkKfNY9ys9vHMHF
ODrshDMcnrtrLnZ0HunVDIfXqbMRkqs9BQ1ya2CrUI8uIe25CIlLJUi6b48RtTSX
3tqNuaSErYcrp8Hbue0hQkSQSn+Vk+yX+zffQBz4Kv4RTWKaJedyVGOWLfd6JVvs
MwoG+CgaOSoPG+20JW7X0+Dk3bXkny94dGTlzt0n2Js/bjfvYgt8lUN3iHRVNEx5
YKkQrvKoFYi2NLyMnvQcQ4ZJoiwtnP2ubBa3ET4qKAtKy+LuBKEU6UDh+ksgdrqf
MmKQkpN7HzdZQx4Tn3VvFlU3nUkMDFRq25Zgl0AqGEoCrPG8DdY3UQqf4IFUVFi1
wlsd9tic1NokwnHzPqIdo1E77fGyHDXZuGZESk/avVhJxLRCaoM=
=Ehg6
-----END PGP SIGNATURE-----

--Sig_/zEOzHve390wP_AdolKtBwuz--
