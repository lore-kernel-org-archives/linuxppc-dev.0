Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9XTd54N1zDr1m
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 14:48:53 +1000 (AEST)
Date: Fri, 12 Aug 2016 14:17:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH kernel 10/15] KVM: PPC: Use preregistered memory API to
 access TCE list
Message-ID: <20160812041740.GM16493@voom.fritz.box>
References: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
 <1470213656-1042-11-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Aaj1jBvBEV7KRjLi"
In-Reply-To: <1470213656-1042-11-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Aaj1jBvBEV7KRjLi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 03, 2016 at 06:40:51PM +1000, Alexey Kardashevskiy wrote:
> VFIO on sPAPR already implements guest memory pre-registration
> when the entire guest RAM gets pinned. This can be used to translate
> the physical address of a guest page containing the TCE list
> from H_PUT_TCE_INDIRECT.
>=20
> This makes use of the pre-registrered memory API to access TCE list
> pages in order to avoid unnecessary locking on the KVM memory
> reverse map as we know that all of guest memory is pinned and
> we have a flat array mapping GPA to HPA which makes it simpler and
> quicker to index into that array (even with looking up the
> kernel page tables in vmalloc_to_phys) than it is to find the memslot,
> lock the rmap entry, look up the user page tables, and unlock the rmap
> entry. Note that the rmap pointer is initialized to NULL where declared
> (not in this patch).
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v2:
> * updated the commit log with Paul's comment
> ---
>  arch/powerpc/kvm/book3s_64_vio_hv.c | 65 ++++++++++++++++++++++++++++---=
------
>  1 file changed, 49 insertions(+), 16 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3=
s_64_vio_hv.c
> index d461c44..a3be4bd 100644
> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> @@ -180,6 +180,17 @@ long kvmppc_gpa_to_ua(struct kvm *kvm, unsigned long=
 gpa,
>  EXPORT_SYMBOL_GPL(kvmppc_gpa_to_ua);
> =20
>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> +static inline bool kvmppc_preregistered(struct kvm_vcpu *vcpu)
> +{
> +	return mm_iommu_preregistered(vcpu->kvm->mm);
> +}
> +
> +static struct mm_iommu_table_group_mem_t *kvmppc_rm_iommu_lookup(
> +		struct kvm_vcpu *vcpu, unsigned long ua, unsigned long size)
> +{
> +	return mm_iommu_lookup_rm(vcpu->kvm->mm, ua, size);
> +}
> +
>  long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>  		unsigned long ioba, unsigned long tce)
>  {
> @@ -260,23 +271,44 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *=
vcpu,
>  	if (ret !=3D H_SUCCESS)
>  		return ret;
> =20
> -	if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, &rmap))
> -		return H_TOO_HARD;
> +	if (kvmppc_preregistered(vcpu)) {
> +		/*
> +		 * We get here if guest memory was pre-registered which
> +		 * is normally VFIO case and gpa->hpa translation does not
> +		 * depend on hpt.
> +		 */
> +		struct mm_iommu_table_group_mem_t *mem;
> =20
> -	rmap =3D (void *) vmalloc_to_phys(rmap);
> +		if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, NULL))
> +			return H_TOO_HARD;

Wouldn't it be clearer to put the gpa->ua lookup outside the if?
You'd have to throw away the rmap you get in the prereg case, but it
shouldn't be harmful, should it?

> =20
> -	/*
> -	 * Synchronize with the MMU notifier callbacks in
> -	 * book3s_64_mmu_hv.c (kvm_unmap_hva_hv etc.).
> -	 * While we have the rmap lock, code running on other CPUs
> -	 * cannot finish unmapping the host real page that backs
> -	 * this guest real page, so we are OK to access the host
> -	 * real page.
> -	 */
> -	lock_rmap(rmap);
> -	if (kvmppc_rm_ua_to_hpa(vcpu, ua, &tces)) {
> -		ret =3D H_TOO_HARD;
> -		goto unlock_exit;
> +		mem =3D kvmppc_rm_iommu_lookup(vcpu, ua, IOMMU_PAGE_SIZE_4K);
> +		if (!mem || mm_iommu_ua_to_hpa_rm(mem, ua, &tces))
> +			return H_TOO_HARD;

This doesn't fall back to the rmap approach if it can't locate the
page in question in the prereg map.  IIUC that means that this will
now work less well than previously if you have a userspace which
preregisters some memory, but not all of guest RAM.  I'm not sure if
we care about that, since no such userspace currently exists.


> +	} else {
> +		/*
> +		 * This is emulated devices case.

This is a bit misleading - this case will only be triggered if there
are *no* prereg-ed VFIO devices.  The case above can be used even for
emulated devices, if there happen to also be VFIO devices present
which have preregistered guest RAM.

> +		 * We do not require memory to be preregistered in this case
> +		 * so lock rmap and do __find_linux_pte_or_hugepte().
> +		 */
> +		if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, &rmap))
> +			return H_TOO_HARD;
> +
> +		rmap =3D (void *) vmalloc_to_phys(rmap);
> +
> +		/*
> +		 * Synchronize with the MMU notifier callbacks in
> +		 * book3s_64_mmu_hv.c (kvm_unmap_hva_hv etc.).
> +		 * While we have the rmap lock, code running on other CPUs
> +		 * cannot finish unmapping the host real page that backs
> +		 * this guest real page, so we are OK to access the host
> +		 * real page.
> +		 */
> +		lock_rmap(rmap);
> +		if (kvmppc_rm_ua_to_hpa(vcpu, ua, &tces)) {
> +			ret =3D H_TOO_HARD;
> +			goto unlock_exit;
> +		}
>  	}
> =20
>  	for (i =3D 0; i < npages; ++i) {
> @@ -290,7 +322,8 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vc=
pu,
>  	}
> =20
>  unlock_exit:
> -	unlock_rmap(rmap);
> +	if (rmap)
> +		unlock_rmap(rmap);
> =20
>  	return ret;
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Aaj1jBvBEV7KRjLi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXrU3kAAoJEGw4ysog2bOSHRYQAKlgoac9IoT6Ykl/bGCnqB8c
UDJvZVCenXc9b/s6+oEgOcyb6rI5Bsk7zPf5d4mDsQcFoeq6UHD0JZHWAl+AZDnf
2SH4WdFFXeaDbHjBkWGxcb7KeTBV1Ic9dUe7kBIBG+ZIKM5idb7V3ULtacFsvGfC
TILFa9f4bJkIwOD4ZLJEFRi+qpxHiCrWhefL/Tod+LYkGT1zF3SCPCyf2lqaiNa4
SHaucQLS8npwbtAXogGrdQJxLIBboJUBDW9i6fmA8qUzG7K0h8IaP3KQtKK9cCda
NcXwrjDbLBhSxXlpMP4iCY1c0oTQyjFZtr5lsEkROWiGZdhLcANZSSqULGgeQNJI
+YLzUoVMTqj6jqzr5Irw5vhyVk+JVNhTyC1RFyNpgyo2Fbv6rmGjaO1WSBxZX3Kf
C0zwhKC7neaCwfQnI8r7gsk8SMFBEaZjJbtQCyEQTa2NLtYsdAGIxjG/qALFagtM
orAG6KuBA/8cqYPxSCPgzkh4AmYkaGYbJ6sVbbQXxHPoL9FCdW6f/3CvOX1wypD9
XnlKetukOCHB9hl5xAn023HLPrsEufY9OzKS6bTiPlV+fk2wcVvimcNLZUo0zWQX
NG3unRqQdMQ/kGCBQCrj9r0kaWLGCxMf1UcLfCC/xgxhQZUPnRP09e80IGIzmuUZ
Pi1JphlgJ1azM4MSCkLG
=YNSN
-----END PGP SIGNATURE-----

--Aaj1jBvBEV7KRjLi--
