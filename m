Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41LjtY3rpczDqHx
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2018 13:25:57 +1000 (AEST)
Date: Thu, 5 Jul 2018 12:42:20 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH kernel v3 2/2] KVM: PPC: Check if IOMMU page is contained
 in the pinned physical page
Message-ID: <20180705024220.GF3450@umbus.fritz.box>
References: <20180704050052.20045-1-aik@ozlabs.ru>
 <20180704050052.20045-3-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KJY2Ze80yH5MUxol"
In-Reply-To: <20180704050052.20045-3-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--KJY2Ze80yH5MUxol
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 04, 2018 at 03:00:52PM +1000, Alexey Kardashevskiy wrote:
> A VM which has:
>  - a DMA capable device passed through to it (eg. network card);
>  - running a malicious kernel that ignores H_PUT_TCE failure;
>  - capability of using IOMMU pages bigger that physical pages
> can create an IOMMU mapping that exposes (for example) 16MB of
> the host physical memory to the device when only 64K was allocated to the=
 VM.
>=20
> The remaining 16MB - 64K will be some other content of host memory, possi=
bly
> including pages of the VM, but also pages of host kernel memory, host
> programs or other VMs.
>=20
> The attacking VM does not control the location of the page it can map,
> and is only allowed to map as many pages as it has pages of RAM.
>=20
> We already have a check in drivers/vfio/vfio_iommu_spapr_tce.c that
> an IOMMU page is contained in the physical page so the PCI hardware won't
> get access to unassigned host memory; however this check is missing in
> the KVM fastpath (H_PUT_TCE accelerated code). We were lucky so far and
> did not hit this yet as the very first time when the mapping happens
> we do not have tbl::it_userspace allocated yet and fall back to
> the userspace which in turn calls VFIO IOMMU driver, this fails and
> the guest does not retry,
>=20
> This stores the smallest preregistered page size in the preregistered
> region descriptor and changes the mm_iommu_xxx API to check this against
> the IOMMU page size. This only allows huge pages use if the entire
> preregistered block is backed with huge pages which are completely
> contained the preregistered chunk; otherwise this defaults to PAGE_SIZE.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

On the grounds that I think this version is safe, which the old one
wasn't.  However it still has some flaws..

[snip]
> @@ -125,7 +126,8 @@ long mm_iommu_get(struct mm_struct *mm, unsigned long=
 ua, unsigned long entries,
>  {
>  	struct mm_iommu_table_group_mem_t *mem;
>  	long i, j, ret =3D 0, locked_entries =3D 0;
> -	struct page *page =3D NULL;
> +	unsigned int pageshift;
> +	struct page *page =3D NULL, *head =3D NULL;
> =20
>  	mutex_lock(&mem_list_mutex);
> =20
> @@ -159,6 +161,7 @@ long mm_iommu_get(struct mm_struct *mm, unsigned long=
 ua, unsigned long entries,
>  		goto unlock_exit;
>  	}
> =20
> +	mem->pageshift =3D 64;
>  	mem->hpas =3D vzalloc(array_size(entries, sizeof(mem->hpas[0])));
>  	if (!mem->hpas) {
>  		kfree(mem);
> @@ -199,9 +202,35 @@ long mm_iommu_get(struct mm_struct *mm, unsigned lon=
g ua, unsigned long entries,
>  			}
>  		}
>  populate:
> +		pageshift =3D PAGE_SHIFT;
> +		if (PageCompound(page)) {
> +			/* Make sure huge page is contained completely */
> +			struct page *tmphead =3D compound_head(page);
> +			unsigned int n =3D compound_order(tmphead);
> +
> +			if (!head) {
> +				/* Is it a head of a huge page? */
> +				if (page =3D=3D tmphead) {
> +					head =3D tmphead;
> +					pageshift +=3D n;
> +				}
> +			} else if (head =3D=3D tmphead) {
> +				/* Still same huge page, good */
> +				pageshift +=3D n;
> +
> +				/* End of the huge page */
> +				if (page - head =3D=3D (1UL << n) - 1)
> +					head =3D NULL;
> +			}
> +		}
> +		mem->pageshift =3D min(mem->pageshift, pageshift);
>  		mem->hpas[i] =3D page_to_pfn(page) << PAGE_SHIFT;
>  	}
> =20
> +	/* We have an incomplete huge page, default to PAGE_SHIFT */
> +	if (head)
> +		mem->pageshift =3D PAGE_SHIFT;
> +

So, if the user attempts to prereg a region which starts or ends in
the middle of a hugepage, this logic will clamp the region's max page
shift down to PAGE_SHIFT.  That's safe, but not optimal.

Suppose userspace had an area backed with 16MiB hugepages, and wanted
to pre-reg a window that was 2MiB aligned, but not 16MiB aligned.  It
would still be safe to allow 2MiB TCEs, but the code above would clamp
it down to 64kiB (or 4kiB).

The code to do it is also pretty convoluted.

I think you'd be better off initializing mem->pageshift to the largest
possible natural alignment of the region:
	mem->pageshift =3D ctz64(ua | (entries << PAGE_SHIFT));

Then it should just be sufficient to clamp pageshift down to
compound_order() + PAGE_SHIFT for each entry.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--KJY2Ze80yH5MUxol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls9hYkACgkQbDjKyiDZ
s5Ii9hAAtzZcY8dGHrdVR9BF3S2V7i6O4Z9KpPaQA7Z2xMSx7Bl+cUwfJyhF1+9q
7D6RNY8ZzVb7buMvk9x4kkSI/Dc/prG7raqNCt22eFQNVLPOiYVzWR1F5e3OuiMv
LCQaJSnn1a2QeaXU4peJQR2WOCQqncsq/RRDg08mhfsKZgDJ6jIce4LtW+oUZxac
oQd5Iv4kcMDP77kocve23nXHCzAWMisyueeh34kg5XK7ezeVeuJstZvERm2/5TB8
LfR/mNiSZjZT/pUyfxSpEfBgcxNULhPVLtC4ZxmfhDdUqhADdzCscFj9zAfGqp9T
kg1Rz1sLFzFWPPGK2FHfN82WanbvPrdy+2+PhVOPRQn24i9JFKwyK97nVix6d2ck
ea4hoTBBx9dUOEHUrgkhLqvxsc6nO1R3wIlKhW8Lp2zOy8PzasoGpWWojbTB+7pq
dh1Ni4moUsj3Ui7FsvG0yMuD0cbj4vsWWrWdfJZlo/RbuJAuiXY6tn91zA2nQ5kf
QZVivNr+391OnDan9DckBr2bxMvQxF5iQR1mrjZu4py5+OOK+ruZwwmamEKfd6xb
ri/B1nd+/6vOEHVsgxFlE+V2RARufclm5tuRLh/MVvtQFBuMBPhP/let2dP4nHkg
zcHDH+X7Mc18D7+ZFVC23CAg/yu/mTsKYHtXN0Qk0FrSgPgAHrc=
=5RH7
-----END PGP SIGNATURE-----

--KJY2Ze80yH5MUxol--
