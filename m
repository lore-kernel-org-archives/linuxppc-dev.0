Return-Path: <aik@ozlabs.ru>
Received: from mail-it0-x241.google.com (mail-it0-x241.google.com
 [IPv6:2607:f8b0:4001:c0b::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Lr4Q41c9zF1Gj
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2018 18:04:54 +1000 (AEST)
Received: by mail-it0-x241.google.com with SMTP id d191-v6so1660512ite.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Jul 2018 01:04:54 -0700 (PDT)
Date: Thu, 5 Jul 2018 18:04:41 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, Alex Williamson
 <alex.williamson@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul
 Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH kernel v3 2/2] KVM: PPC: Check if IOMMU page is
 contained in the pinned physical page
Message-ID: <20180705180441.79f8e395@aik.ozlabs.ibm.com>
In-Reply-To: <20180705151904.17de7322@aik.ozlabs.ibm.com>
References: <20180704050052.20045-1-aik@ozlabs.ru>
 <20180704050052.20045-3-aik@ozlabs.ru>
 <20180705024220.GF3450@umbus.fritz.box>
 <20180705151904.17de7322@aik.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/g/InkliHpbLwtL1NTEpMe9w"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/g/InkliHpbLwtL1NTEpMe9w
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Jul 2018 15:19:04 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> On Thu, 5 Jul 2018 12:42:20 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Wed, Jul 04, 2018 at 03:00:52PM +1000, Alexey Kardashevskiy wrote: =
=20
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
> > > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>   =20
> >=20
> > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> >=20
> > On the grounds that I think this version is safe, which the old one
> > wasn't.  However it still has some flaws..
> >=20
> > [snip] =20
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
> > > +   =20
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
> > compound_order() + PAGE_SHIFT for each entry. =20
>=20
>=20
> I like this better, just one question - does hugetlbfs guarantee the @ua
> alignment if backed with an actual huge page?


Turns out it does, never mind, posted v4. Cheers.



--
Alexey

--Sig_/g/InkliHpbLwtL1NTEpMe9w
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEECIb1sawlPgRl/px9ze7KtGKK020FAls90RkACgkQze7KtGKK
023Ovg/+IeR3b4L/P9GKn3eEfziWx8SGBE5OYXtrBOY7i7qDbteKh4jzBSXSyQH6
FoL536+jRVcn6FJA63qqI8icXHzb0t/mtBtM3e1vwFfmbVP2QMizoGHqTl7vBwJ5
HdRS+Ry2aZ6kTuWc1AtJ39ST9FtT6iCOWhXVjhD2lcGtLsZhrqpf5LYyf/mgp0Hf
drGtiZq0AMVeyKg1lNqPTdpH/ZpBndnX/Wlk5/UbyG2J8mTzXmalx+XYrc2LtEfl
CyGSTaBiwBBPx9unqMKVMMYaklYACEAsFNMo5lqN6r1lFbA6dbfcq7In0r32u1WB
+EzZuwZttWu7FBkxSWCauNLB6BdjwRwT6AcW8gTxXXRdm+dUuxe+wPL6liu+Qt5u
4WGTL+3t2zXf+nnLzorYHKTXi0nCLxevbPR9vFw5cnifXyvlHhxjFGCliqs1gOzX
9YtV2HuM4y9QlGcliQf/zg/N8seatgMQvt9NSNTahh3sbjklk9urYVQofAJ6iEHz
fz4jboh98E8CQ7uYesiEUBBh3LihdjvG4kd8jXSrNizp7OGr+toyv4r0n4HSsRpw
mB+3OPm9XX5KCBC1zwSP+uiS+0D35JnyJWjx+octAI6w3QQ+9iA+YjhmpbeCL2nR
uhq/eBp4pfUavDKf3uBZtotoghBu2MBfqn58s2wdxpeXt6995UQ=
=TI9V
-----END PGP SIGNATURE-----

--Sig_/g/InkliHpbLwtL1NTEpMe9w--
