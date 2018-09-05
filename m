Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 424t5p62YpzF374
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2018 15:47:58 +1000 (AEST)
Date: Wed, 5 Sep 2018 13:59:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Don't use compound_order to
 determine host mapping size
Message-ID: <20180905035952.GJ2679@umbus.fritz.box>
References: <20180904081601.32703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VIOdPewhitSMo36n"
In-Reply-To: <20180904081601.32703-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--VIOdPewhitSMo36n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 04, 2018 at 06:16:01PM +1000, Nicholas Piggin wrote:
> THP paths can defer splitting compound pages until after the actual
> remap and TLB flushes to split a huge PMD/PUD. This causes radix
> partition scope page table mappings to get out of synch with the host
> qemu page table mappings.
>=20
> This results in random memory corruption in the guest when running
> with THP. The easiest way to reproduce is use KVM baloon to free up
> a lot of memory in the guest and then shrink the balloon to give the
> memory back, while some work is being done in the guest.
>=20
> Cc: Paul Mackerras <paulus@ozlabs.org>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Seems to fix the problem on my test case.

Tested-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/kvm/book3s_64_mmu_radix.c | 88 ++++++++++----------------
>  1 file changed, 34 insertions(+), 54 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/bo=
ok3s_64_mmu_radix.c
> index 0af1c0aea1fe..d8792445d95a 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
> @@ -525,8 +525,8 @@ int kvmppc_book3s_radix_page_fault(struct kvm_run *ru=
n, struct kvm_vcpu *vcpu,
>  				   unsigned long ea, unsigned long dsisr)
>  {
>  	struct kvm *kvm =3D vcpu->kvm;
> -	unsigned long mmu_seq, pte_size;
> -	unsigned long gpa, gfn, hva, pfn;
> +	unsigned long mmu_seq;
> +	unsigned long gpa, gfn, hva;
>  	struct kvm_memory_slot *memslot;
>  	struct page *page =3D NULL;
>  	long ret;
> @@ -623,9 +623,10 @@ int kvmppc_book3s_radix_page_fault(struct kvm_run *r=
un, struct kvm_vcpu *vcpu,
>  	 */
>  	hva =3D gfn_to_hva_memslot(memslot, gfn);
>  	if (upgrade_p && __get_user_pages_fast(hva, 1, 1, &page) =3D=3D 1) {
> -		pfn =3D page_to_pfn(page);
>  		upgrade_write =3D true;
>  	} else {
> +		unsigned long pfn;
> +
>  		/* Call KVM generic code to do the slow-path check */
>  		pfn =3D __gfn_to_pfn_memslot(memslot, gfn, false, NULL,
>  					   writing, upgrade_p);
> @@ -639,63 +640,42 @@ int kvmppc_book3s_radix_page_fault(struct kvm_run *=
run, struct kvm_vcpu *vcpu,
>  		}
>  	}
> =20
> -	/* See if we can insert a 1GB or 2MB large PTE here */
> -	level =3D 0;
> -	if (page && PageCompound(page)) {
> -		pte_size =3D PAGE_SIZE << compound_order(compound_head(page));
> -		if (pte_size >=3D PUD_SIZE &&
> -		    (gpa & (PUD_SIZE - PAGE_SIZE)) =3D=3D
> -		    (hva & (PUD_SIZE - PAGE_SIZE))) {
> -			level =3D 2;
> -			pfn &=3D ~((PUD_SIZE >> PAGE_SHIFT) - 1);
> -		} else if (pte_size >=3D PMD_SIZE &&
> -			   (gpa & (PMD_SIZE - PAGE_SIZE)) =3D=3D
> -			   (hva & (PMD_SIZE - PAGE_SIZE))) {
> -			level =3D 1;
> -			pfn &=3D ~((PMD_SIZE >> PAGE_SHIFT) - 1);
> -		}
> -	}
> -
>  	/*
> -	 * Compute the PTE value that we need to insert.
> +	 * Read the PTE from the process' radix tree and use that
> +	 * so we get the shift and attribute bits.
>  	 */
> -	if (page) {
> -		pgflags =3D _PAGE_READ | _PAGE_EXEC | _PAGE_PRESENT | _PAGE_PTE |
> -			_PAGE_ACCESSED;
> -		if (writing || upgrade_write)
> -			pgflags |=3D _PAGE_WRITE | _PAGE_DIRTY;
> -		pte =3D pfn_pte(pfn, __pgprot(pgflags));
> +	local_irq_disable();
> +	ptep =3D __find_linux_pte(vcpu->arch.pgdir, hva, NULL, &shift);
> +	pte =3D *ptep;
> +	local_irq_enable();
> +
> +	/* Get pte level from shift/size */
> +	if (shift =3D=3D PUD_SHIFT &&
> +	    (gpa & (PUD_SIZE - PAGE_SIZE)) =3D=3D
> +	    (hva & (PUD_SIZE - PAGE_SIZE))) {
> +		level =3D 2;
> +	} else if (shift =3D=3D PMD_SHIFT &&
> +		   (gpa & (PMD_SIZE - PAGE_SIZE)) =3D=3D
> +		   (hva & (PMD_SIZE - PAGE_SIZE))) {
> +		level =3D 1;
>  	} else {
> -		/*
> -		 * Read the PTE from the process' radix tree and use that
> -		 * so we get the attribute bits.
> -		 */
> -		local_irq_disable();
> -		ptep =3D __find_linux_pte(vcpu->arch.pgdir, hva, NULL, &shift);
> -		pte =3D *ptep;
> -		local_irq_enable();
> -		if (shift =3D=3D PUD_SHIFT &&
> -		    (gpa & (PUD_SIZE - PAGE_SIZE)) =3D=3D
> -		    (hva & (PUD_SIZE - PAGE_SIZE))) {
> -			level =3D 2;
> -		} else if (shift =3D=3D PMD_SHIFT &&
> -			   (gpa & (PMD_SIZE - PAGE_SIZE)) =3D=3D
> -			   (hva & (PMD_SIZE - PAGE_SIZE))) {
> -			level =3D 1;
> -		} else if (shift && shift !=3D PAGE_SHIFT) {
> -			/* Adjust PFN */
> -			unsigned long mask =3D (1ul << shift) - PAGE_SIZE;
> -			pte =3D __pte(pte_val(pte) | (hva & mask));
> -		}
> -		pte =3D __pte(pte_val(pte) | _PAGE_EXEC | _PAGE_ACCESSED);
> -		if (writing || upgrade_write) {
> -			if (pte_val(pte) & _PAGE_WRITE)
> -				pte =3D __pte(pte_val(pte) | _PAGE_DIRTY);
> -		} else {
> -			pte =3D __pte(pte_val(pte) & ~(_PAGE_WRITE | _PAGE_DIRTY));
> +		level =3D 0;
> +
> +		/* Can not cope with unknown page shift */
> +		if (shift && shift !=3D PAGE_SHIFT) {
> +			WARN_ON_ONCE(1);
> +			return -EFAULT;
>  		}
>  	}
> =20
> +	pte =3D __pte(pte_val(pte) | _PAGE_EXEC | _PAGE_ACCESSED);
> +	if (writing || upgrade_write) {
> +		if (pte_val(pte) & _PAGE_WRITE)
> +			pte =3D __pte(pte_val(pte) | _PAGE_DIRTY);
> +	} else {
> +		pte =3D __pte(pte_val(pte) & ~(_PAGE_WRITE | _PAGE_DIRTY));
> +	}
> +
>  	/* Allocate space in the tree and write the PTE */
>  	ret =3D kvmppc_create_pte(kvm, pte, gpa, level, mmu_seq);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VIOdPewhitSMo36n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluPVLgACgkQbDjKyiDZ
s5K+PhAAjWfhWskfOzZYmLAO6mEwuFRSiTBlyX1FZuak3grwfV9ppT0+pLu6xVG5
wyPH2XPXuV0MjPGFJxCSgSNiQSD0XbhqCDtA84GwMMnP0utXnzytw+6RLcF+vjWB
4K3ED3PMAtwC8s9VUy6yOpeOA7eY0z4iPSt3RCKuCUxarGWu9LrdywlcIp9n5l0e
gWNgcgT7U7mxv+6Oy1LpO83QAMsNQ8S5hxl+EEvG847iEiIOQwTCC/w5cRgOLef0
+bnYcYT4kFW8ZyFS2rTWhn8VlMCivdlodWX6e5a7uVp72cyPrzcKBikbA/e3xMuP
l2W6+daSFMiH3QwaDkIcJ+xwuh58r3ovKMsW10TDmHVGRVIQDZzdjGNvh3UofJcB
EVSZVWushnUsZcRjIDYM4Dis5i4uKmKj2XBuExe91mOQFoew82pLXLx0tAp5ufrU
iIhNAugxSYfCcOIW34BjkV/EKJyCZs3fQJpBBckTVywZnHMAWogrmOqqPyDXfyLt
f72yHjkqnoBrKL56r8kjoBjLAEGZN2UY9FO3faTq0XCdIi5YJa+Khko/RfcloW4e
wFVvxilpE3rSgrNkh8CxrJkEQlqodqSr6ngD5e2Z6/JwQohdAE32rvxDiR6eC0au
6z+sGNnXeR2fs6pUtHXeCjY6ltOG7yPtVaVBvlIaYOCJOaHSNfs=
=w0kN
-----END PGP SIGNATURE-----

--VIOdPewhitSMo36n--
