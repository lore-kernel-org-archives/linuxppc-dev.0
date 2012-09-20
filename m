Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1D8C02C0098
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2012 19:01:57 +1000 (EST)
Subject: Re: [PATCH] powerpc-kvm: fixing page alignment for TCE
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1346744187-31226-1-git-send-email-aik@ozlabs.ru>
Date: Thu, 20 Sep 2012 11:01:46 +0200
Message-Id: <429A2CD3-5DEB-4C5D-A204-E06B1C0B6F88@suse.de>
References: <1346744035-31154-1-git-send-email-aik@ozlabs.ru>
 <1346744187-31226-1-git-send-email-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 04.09.2012, at 09:36, Alexey Kardashevskiy wrote:

> From: Paul Mackerras <paulus@samba.org>
>=20
> TODO: ask Paul to make a proper message.

TODO?

Also, Ben or Paul, please ack if you think it's correct.


Alex

>=20
> This is the fix for a host kernel compiled with a page size
> other than 4K (TCE page size). In the case of a 64K page size,
> the host used to lose address bits in hpte_rpn().
> The patch fixes it.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> arch/powerpc/kvm/book3s_64_mmu_hv.c |    9 ++++-----
> 1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c =
b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> index 80a5775..a41f11b 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -503,7 +503,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run =
*run, struct kvm_vcpu *vcpu,
> 	struct kvm *kvm =3D vcpu->kvm;
> 	unsigned long *hptep, hpte[3], r;
> 	unsigned long mmu_seq, psize, pte_size;
> -	unsigned long gfn, hva, pfn;
> +	unsigned long gpa, gfn, hva, pfn;
> 	struct kvm_memory_slot *memslot;
> 	unsigned long *rmap;
> 	struct revmap_entry *rev;
> @@ -541,15 +541,14 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run =
*run, struct kvm_vcpu *vcpu,
>=20
> 	/* Translate the logical address and get the page */
> 	psize =3D hpte_page_size(hpte[0], r);
> -	gfn =3D hpte_rpn(r, psize);
> +	gpa =3D (r & HPTE_R_RPN & ~(psize - 1)) | (ea & (psize - 1));
> +	gfn =3D gpa >> PAGE_SHIFT;
> 	memslot =3D gfn_to_memslot(kvm, gfn);
>=20
> 	/* No memslot means it's an emulated MMIO region */
> -	if (!memslot || (memslot->flags & KVM_MEMSLOT_INVALID)) {
> -		unsigned long gpa =3D (gfn << PAGE_SHIFT) | (ea & (psize =
- 1));
> +	if (!memslot || (memslot->flags & KVM_MEMSLOT_INVALID))
> 		return kvmppc_hv_emulate_mmio(run, vcpu, gpa, ea,
> 					      dsisr & DSISR_ISSTORE);
> -	}
>=20
> 	if (!kvm->arch.using_mmu_notifiers)
> 		return -EFAULT;		/* should never get here */
> --=20
> 1.7.10.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
