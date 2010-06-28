Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7F79CB6F44
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 28 Jun 2010 18:55:47 +1000 (EST)
Subject: Re: [PATCH] KVM: PPC: Add generic hpte management functions
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <4C285D1C.5060508@redhat.com>
Date: Mon, 28 Jun 2010 10:55:39 +0200
Message-Id: <20417D40-9345-485B-9201-8B3722B7457F@suse.de>
References: <1277507817-626-1-git-send-email-agraf@suse.de>
	<1277507817-626-2-git-send-email-agraf@suse.de>
	<4C285D1C.5060508@redhat.com>
To: Avi Kivity <avi@redhat.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 28.06.2010, at 10:28, Avi Kivity wrote:

> On 06/26/2010 02:16 AM, Alexander Graf wrote:
>> Currently the shadow paging code keeps an array of entries it knows =
about.
>> Whenever the guest invalidates an entry, we loop through that entry,
>> trying to invalidate matching parts.
>>=20
>> While this is a really simple implementation, it is probably the most
>> ineffective one possible. So instead, let's keep an array of lists =
around
>> that are indexed by a hash. This way each PTE can be added by 4 =
list_add,
>> removed by 4 list_del invocations and the search only needs to loop =
through
>> entries that share the same hash.
>>=20
>> This patch implements said lookup and exports generic functions that =
both
>> the 32-bit and 64-bit backend can use.
>>=20
>>=20
>> +
>> +static inline u64 kvmppc_mmu_hash_pte(u64 eaddr) {
>> +	return hash_64(eaddr>>  PTE_SIZE, HPTEG_HASH_BITS_PTE);
>> +}
>> +
>> +static inline u64 kvmppc_mmu_hash_vpte(u64 vpage) {
>> +	return hash_64(vpage&  0xfffffffffULL, HPTEG_HASH_BITS_VPTE);
>> +}
>> +
>> +static inline u64 kvmppc_mmu_hash_vpte_long(u64 vpage) {
>> +	return hash_64((vpage&  0xffffff000ULL)>>  12,
>> +		       HPTEG_HASH_BITS_VPTE_LONG);
>> +}
>>  =20
>=20
> Still with the wierd coding style?

Not sure what's going on there. My editor displays it normally. Weird.

>=20
>> +static void kvmppc_mmu_pte_flush_all(struct kvm_vcpu *vcpu)
>> +{
>> +	struct hpte_cache *pte, *tmp;
>> +	int i;
>> +
>> +	for (i =3D 0; i<  HPTEG_HASH_NUM_VPTE_LONG; i++) {
>> +		struct list_head *list =
=3D&vcpu->arch.hpte_hash_vpte_long[i];
>> +
>> +		list_for_each_entry_safe(pte, tmp, list, list_vpte_long) =
{
>> +			/* Jump over the helper entry */
>> +			if (&pte->list_vpte_long =3D=3D list)
>> +				continue;
>>  =20
>=20
> I don't think l_f_e_e_s() will ever give you the head back.

Uh. Usually you have struct list_head in a struct and you point to the =
first entry to loop over all. So if it doesn't return the first entry, =
that would seem very counter-intuitive.

>=20
>> +
>> +			invalidate_pte(vcpu, pte);
>> +		}
>>  =20
>=20
> Does invalidate_pte() remove the pte?  doesn't seem so, so you can =
drop the _safe iteration.

Yes, it does.

>=20
>> +	}
>> +}
>> +
>> +void kvmppc_mmu_pte_flush(struct kvm_vcpu *vcpu, ulong guest_ea, =
ulong ea_mask)
>> +{
>> +	u64 i;
>> +
>> +	dprintk_mmu("KVM: Flushing %d Shadow PTEs: 0x%lx&  0x%lx\n",
>> +		    vcpu->arch.hpte_cache_count, guest_ea, ea_mask);
>> +
>> +	guest_ea&=3D ea_mask;
>> +
>> +	switch (ea_mask) {
>> +	case ~0xfffUL:
>> +	{
>> +		struct list_head *list;
>> +		struct hpte_cache *pte, *tmp;
>> +
>> +		/* Find the list of entries in the map */
>> +		list =
=3D&vcpu->arch.hpte_hash_pte[kvmppc_mmu_hash_pte(guest_ea)];
>> +
>> +		/* Check the list for matching entries */
>> +		list_for_each_entry_safe(pte, tmp, list, list_pte) {
>> +			/* Jump over the helper entry */
>> +			if (&pte->list_pte =3D=3D list)
>> +				continue;
>>  =20
>=20
> Same here.
>=20
>> +
>> +			/* Invalidate matching PTE */
>> +			if ((pte->pte.eaddr&  ~0xfffUL) =3D=3D guest_ea)
>> +				invalidate_pte(vcpu, pte);
>> +		}
>> +		break;
>> +	}
>>  =20
>=20
> Would be nice to put this block into a function.

Yup.

>=20
>> +	case 0x0ffff000:
>> +		/* 32-bit flush w/o segment, go through all possible =
segments */
>> +		for (i =3D 0; i<  0x100000000ULL; i +=3D 0x10000000ULL)
>> +			kvmppc_mmu_pte_flush(vcpu, guest_ea | i, =
~0xfffUL);
>> +		break;
>> +	case 0:
>> +		/* Doing a complete flush ->  start from scratch */
>> +		kvmppc_mmu_pte_flush_all(vcpu);
>> +		break;
>> +	default:
>> +		WARN_ON(1);
>> +		break;
>> +	}
>> +}
>> +
>> +/* Flush with mask 0xfffffffff */
>> +static void kvmppc_mmu_pte_vflush_short(struct kvm_vcpu *vcpu, u64 =
guest_vp)
>> +{
>> +	struct list_head *list;
>> +	struct hpte_cache *pte, *tmp;
>> +	u64 vp_mask =3D 0xfffffffffULL;
>> +
>> +	list =
=3D&vcpu->arch.hpte_hash_vpte[kvmppc_mmu_hash_vpte(guest_vp)];
>> +
>> +	/* Check the list for matching entries */
>> +	list_for_each_entry_safe(pte, tmp, list, list_vpte) {
>> +		/* Jump over the helper entry */
>> +		if (&pte->list_vpte =3D=3D list)
>> +			continue;
>>  =20
>=20
> list cannot contain list.  Or maybe I don't understand the data =
structure.  Isn't it multiple hash tables with lists holding matching =
ptes?

It is multiple hash tables with list_heads that are one element of a =
list that contains the matching ptes. Usually you'd have

struct x {
  struct list_head;
  int foo;
  char bar;
};

and you loop through each of those elements. What we have here is

struct list_head hash[..];

and some loose struct x's. The hash's "next" element is a struct x.

The "normal" way would be to have "struct x hash[..];" but I figured =
that eats too much space.

>=20
>> +
>> +		/* Invalidate matching PTEs */
>> +		if ((pte->pte.vpage&  vp_mask) =3D=3D guest_vp)
>> +			invalidate_pte(vcpu, pte);
>> +	}
>> +}
>> +
>>=20
>> +
>> +void kvmppc_mmu_pte_pflush(struct kvm_vcpu *vcpu, ulong pa_start, =
ulong pa_end)
>> +{
>> +	struct hpte_cache *pte, *tmp;
>> +	int i;
>> +
>> +	dprintk_mmu("KVM: Flushing %d Shadow pPTEs: 0x%lx - 0x%lx\n",
>> +		    vcpu->arch.hpte_cache_count, pa_start, pa_end);
>> +
>> +	for (i =3D 0; i<  HPTEG_HASH_NUM_VPTE_LONG; i++) {
>> +		struct list_head *list =
=3D&vcpu->arch.hpte_hash_vpte_long[i];
>> +
>> +		list_for_each_entry_safe(pte, tmp, list, list_vpte_long) =
{
>> +			/* Jump over the helper entry */
>> +			if (&pte->list_vpte_long =3D=3D list)
>> +				continue;
>> +
>> +			if ((pte->pte.raddr>=3D pa_start)&&
>> +			    (pte->pte.raddr<  pa_end)) {
>> +				invalidate_pte(vcpu, pte);
>> +			}
>>  =20
>=20
> Extra braces.

Yeah, for two-lined if's I find it more readable that way. Is it =
forbidden?

>=20
>> +		}
>> +	}
>> +}
>> +
>>=20
>> +
>> +static void kvmppc_mmu_hpte_init_hash(struct list_head *hash_list, =
int len)
>> +{
>> +	int i;
>> +
>> +	for (i =3D 0; i<  len; i++) {
>> +		INIT_LIST_HEAD(&hash_list[i]);
>> +	}
>> +}
>>  =20
>=20
> Extra braces.

Yup.

>=20
>> +
>> +int kvmppc_mmu_hpte_init(struct kvm_vcpu *vcpu)
>> +{
>> +	char kmem_name[128];
>> +
>> +	/* init hpte slab cache */
>> +	snprintf(kmem_name, 128, "kvm-spt-%p", vcpu);
>> +	vcpu->arch.hpte_cache =3D kmem_cache_create(kmem_name,
>> +		sizeof(struct hpte_cache), sizeof(struct hpte_cache), 0, =
NULL);
>>  =20
>=20
> Why not one global cache?

You mean over all vcpus? Or over all VMs? Because this way they don't =
interfere. An operation on one vCPU doesn't inflict anything on another. =
There's also no locking necessary this way.


Alex
