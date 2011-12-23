Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 7BF73B73E9
 for <linuxppc-dev@ozlabs.org>; Sat, 24 Dec 2011 00:23:35 +1100 (EST)
Subject: Re: [PATCH 4/5] KVM: PPC: Book3s HV: Implement get_dirty_log using
 hardware changed bit
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20111215120322.GE20629@bloggs.ozlabs.ibm.com>
Date: Fri, 23 Dec 2011 14:23:30 +0100
Message-Id: <C59FE93D-AD1B-4382-BE8B-FF2DDD22930E@suse.de>
References: <20111215120018.GA20629@bloggs.ozlabs.ibm.com>
 <20111215120322.GE20629@bloggs.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, KVM list <kvm@vger.kernel.org>,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 15.12.2011, at 13:03, Paul Mackerras wrote:

> This changes the implementation of kvm_vm_ioctl_get_dirty_log() for
> Book3s HV guests to use the hardware C (changed) bits in the guest
> hashed page table.  Since this makes the implementation quite =
different
> from the Book3s PR case, this moves the existing implementation from
> book3s.c to book3s_pr.c and creates a new implementation in =
book3s_hv.c.
> That implementation calls kvmppc_hv_get_dirty_log() to do the actual
> work by calling kvm_test_clear_dirty on each page.  It iterates over
> the HPTEs, clearing the C bit if set, and returns 1 if any C bit was
> set (including the saved C bit in the rmap entry).
>=20
> Signed-off-by: Paul Mackerras <paulus@samba.org>
> ---
> arch/powerpc/include/asm/kvm_book3s.h |    2 +
> arch/powerpc/kvm/book3s.c             |   39 ------------------
> arch/powerpc/kvm/book3s_64_mmu_hv.c   |   69 =
+++++++++++++++++++++++++++++++++
> arch/powerpc/kvm/book3s_hv.c          |   37 +++++++++++++++++
> arch/powerpc/kvm/book3s_pr.c          |   39 ++++++++++++++++++
> 5 files changed, 147 insertions(+), 39 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/kvm_book3s.h =
b/arch/powerpc/include/asm/kvm_book3s.h
> index 6ececb4..aa795cc 100644
> --- a/arch/powerpc/include/asm/kvm_book3s.h
> +++ b/arch/powerpc/include/asm/kvm_book3s.h
> @@ -158,6 +158,8 @@ extern long kvmppc_virtmode_h_enter(struct =
kvm_vcpu *vcpu, unsigned long flags,
> 			long pte_index, unsigned long pteh, unsigned =
long ptel);
> extern long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
> 			long pte_index, unsigned long pteh, unsigned =
long ptel);
> +extern long kvmppc_hv_get_dirty_log(struct kvm *kvm,
> +			struct kvm_memory_slot *memslot);
>=20
> extern void kvmppc_entry_trampoline(void);
> extern void kvmppc_hv_entry_trampoline(void);
> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
> index 6bf7e05..7d54f4e 100644
> --- a/arch/powerpc/kvm/book3s.c
> +++ b/arch/powerpc/kvm/book3s.c
> @@ -477,45 +477,6 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu =
*vcpu,
> 	return 0;
> }
>=20
> -/*
> - * Get (and clear) the dirty memory log for a memory slot.
> - */
> -int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm,
> -				      struct kvm_dirty_log *log)
> -{
> -	struct kvm_memory_slot *memslot;
> -	struct kvm_vcpu *vcpu;
> -	ulong ga, ga_end;
> -	int is_dirty =3D 0;
> -	int r;
> -	unsigned long n;
> -
> -	mutex_lock(&kvm->slots_lock);
> -
> -	r =3D kvm_get_dirty_log(kvm, log, &is_dirty);
> -	if (r)
> -		goto out;
> -
> -	/* If nothing is dirty, don't bother messing with page tables. =
*/
> -	if (is_dirty) {
> -		memslot =3D id_to_memslot(kvm->memslots, log->slot);
> -
> -		ga =3D memslot->base_gfn << PAGE_SHIFT;
> -		ga_end =3D ga + (memslot->npages << PAGE_SHIFT);
> -
> -		kvm_for_each_vcpu(n, vcpu, kvm)
> -			kvmppc_mmu_pte_pflush(vcpu, ga, ga_end);
> -
> -		n =3D kvm_dirty_bitmap_bytes(memslot);
> -		memset(memslot->dirty_bitmap, 0, n);
> -	}
> -
> -	r =3D 0;
> -out:
> -	mutex_unlock(&kvm->slots_lock);
> -	return r;
> -}
> -
> void kvmppc_decrementer_func(unsigned long data)
> {
> 	struct kvm_vcpu *vcpu =3D (struct kvm_vcpu *)data;
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c =
b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> index 926e2b9..783cd35 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -870,6 +870,75 @@ void kvm_set_spte_hva(struct kvm *kvm, unsigned =
long hva, pte_t pte)
> 	kvm_handle_hva(kvm, hva, kvm_unmap_rmapp);
> }
>=20
> +static int kvm_test_clear_dirty(struct kvm *kvm, unsigned long =
*rmapp)
> +{
> +	struct revmap_entry *rev =3D kvm->arch.revmap;
> +	unsigned long head, i, j;
> +	unsigned long *hptep;
> +	int ret =3D 0;
> +
> + retry:
> +	lock_rmap(rmapp);
> +	if (*rmapp & KVMPPC_RMAP_CHANGED) {
> +		*rmapp &=3D ~KVMPPC_RMAP_CHANGED;
> +		ret =3D 1;
> +	}
> +	if (!(*rmapp & KVMPPC_RMAP_PRESENT)) {
> +		unlock_rmap(rmapp);
> +		return ret;
> +	}
> +
> +	i =3D head =3D *rmapp & KVMPPC_RMAP_INDEX;
> +	do {
> +		hptep =3D (unsigned long *) (kvm->arch.hpt_virt + (i << =
4));
> +		j =3D rev[i].forw;
> +
> +		if (!(hptep[1] & HPTE_R_C))
> +			continue;
> +
> +		if (!try_lock_hpte(hptep, HPTE_V_HVLOCK)) {
> +			/* unlock rmap before spinning on the HPTE lock =
*/
> +			unlock_rmap(rmapp);
> +			while (hptep[0] & HPTE_V_HVLOCK)
> +				cpu_relax();
> +			goto retry;
> +		}
> +
> +		/* Now check and modify the HPTE */
> +		if ((hptep[0] & HPTE_V_VALID) && (hptep[1] & HPTE_R_C)) =
{
> +			/* need to make it temporarily absent to clear C =
*/
> +			hptep[0] |=3D HPTE_V_ABSENT;
> +			kvmppc_invalidate_hpte(kvm, hptep, i);
> +			hptep[1] &=3D ~HPTE_R_C;
> +			eieio();
> +			hptep[0] =3D (hptep[0] & ~HPTE_V_ABSENT) | =
HPTE_V_VALID;
> +			rev[i].guest_rpte |=3D HPTE_R_C;
> +			ret =3D 1;
> +		}
> +		hptep[0] &=3D ~HPTE_V_HVLOCK;
> +	} while ((i =3D j) !=3D head);
> +
> +	unlock_rmap(rmapp);
> +	return ret;
> +}
> +
> +long kvmppc_hv_get_dirty_log(struct kvm *kvm, struct kvm_memory_slot =
*memslot)
> +{
> +	unsigned long i;
> +	unsigned long *rmapp, *map;
> +
> +	preempt_disable();
> +	rmapp =3D memslot->rmap;
> +	map =3D memslot->dirty_bitmap;
> +	for (i =3D 0; i < memslot->npages; ++i) {
> +		if (kvm_test_clear_dirty(kvm, rmapp))
> +			__set_bit_le(i, map);

So if I read things correctly, this is the only case you're setting =
pages as dirty. What if you have the following:

  guest adds HTAB entry x
  guest writes to page mapped by x
  guest removes HTAB entry x
  host fetches dirty log

You can replace "removes" by "is overwritten by another mapping" if you =
like.


Alex

PS: Always CC kvm@vger for stuff that other might want to review =
(basically all patches)
