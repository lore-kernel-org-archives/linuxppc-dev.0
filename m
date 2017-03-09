Return-Path: <aik@ozlabs.ru>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vf83x6RpRzDqXj
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Mar 2017 22:55:56 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id g2so2144553pge.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Mar 2017 03:55:56 -0800 (PST)
Subject: Re: [PATCH kernel v7 10/10] KVM: PPC: VFIO: Add in-kernel
 acceleration for VFIO
To: David Gibson <david@gibson.dropbear.id.au>
References: <20170308030011.26780-1-aik@ozlabs.ru>
 <20170308030011.26780-11-aik@ozlabs.ru>
 <20170309064737.GO19967@umbus.fritz.box>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <0113dbb0-9e78-89e5-f276-756fc7f5a9b7@ozlabs.ru>
Date: Thu, 9 Mar 2017 22:55:48 +1100
MIME-Version: 1.0
In-Reply-To: <20170309064737.GO19967@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="W8Eqwe7eArujlFpngBt050w5HW8jnq0KA"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--W8Eqwe7eArujlFpngBt050w5HW8jnq0KA
Content-Type: multipart/mixed; boundary="I9bhBTQVuLGhl56AAC4BjxbWRSKUfBT9C";
 protected-headers="v1"
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Message-ID: <0113dbb0-9e78-89e5-f276-756fc7f5a9b7@ozlabs.ru>
Subject: Re: [PATCH kernel v7 10/10] KVM: PPC: VFIO: Add in-kernel
 acceleration for VFIO
References: <20170308030011.26780-1-aik@ozlabs.ru>
 <20170308030011.26780-11-aik@ozlabs.ru>
 <20170309064737.GO19967@umbus.fritz.box>
In-Reply-To: <20170309064737.GO19967@umbus.fritz.box>

--I9bhBTQVuLGhl56AAC4BjxbWRSKUfBT9C
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable

On 09/03/17 17:47, David Gibson wrote:
> On Wed, Mar 08, 2017 at 02:00:11PM +1100, Alexey Kardashevskiy wrote:
>> This allows the host kernel to handle H_PUT_TCE, H_PUT_TCE_INDIRECT
>> and H_STUFF_TCE requests targeted an IOMMU TCE table used for VFIO
>> without passing them to user space which saves time on switching
>> to user space and back.
>>
>> This adds H_PUT_TCE/H_PUT_TCE_INDIRECT/H_STUFF_TCE handlers to KVM.
>> KVM tries to handle a TCE request in the real mode, if failed
>> it passes the request to the virtual mode to complete the operation.
>> If it a virtual mode handler fails, the request is passed to
>> the user space; this is not expected to happen though.
>>
>> To avoid dealing with page use counters (which is tricky in real mode)=
,
>> this only accelerates SPAPR TCE IOMMU v2 clients which are required
>> to pre-register the userspace memory. The very first TCE request will
>> be handled in the VFIO SPAPR TCE driver anyway as the userspace view
>> of the TCE table (iommu_table::it_userspace) is not allocated till
>> the very first mapping happens and we cannot call vmalloc in real mode=
=2E
>>
>> If we fail to update a hardware IOMMU table unexpected reason, we just=

>> clear it and move on as there is nothing really we can do about it -
>> for example, if we hot plug a VFIO device to a guest, existing TCE tab=
les
>> will be mirrored automatically to the hardware and there is no interfa=
ce
>> to report to the guest about possible failures.
>>
>> This adds new attribute - KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE - to
>> the VFIO KVM device. It takes a VFIO group fd and SPAPR TCE table fd
>> and associates a physical IOMMU table with the SPAPR TCE table (which
>> is a guest view of the hardware IOMMU table). The iommu_table object
>> is cached and referenced so we do not have to look up for it in real m=
ode.
>>
>> This does not implement the UNSET counterpart as there is no use for i=
t -
>> once the acceleration is enabled, the existing userspace won't
>> disable it unless a VFIO container is destroyed; this adds necessary
>> cleanup to the KVM_DEV_VFIO_GROUP_DEL handler.
>>
>> As this creates a descriptor per IOMMU table-LIOBN couple (called
>> kvmppc_spapr_tce_iommu_table), it is possible to have several
>> descriptors with the same iommu_table (hardware IOMMU table) attached
>> to the same LIOBN; we do not remove duplicates though as
>> iommu_table_ops::exchange not just update a TCE entry (which is
>> shared among IOMMU groups) but also invalidates the TCE cache
>> (one per IOMMU group).
>>
>> This advertises the new KVM_CAP_SPAPR_TCE_VFIO capability to the user
>> space.
>>
>> This finally makes use of vfio_external_user_iommu_id() which was
>> introduced quite some time ago and was considered for removal.
>>
>> Tests show that this patch increases transmission speed from 220MB/s
>> to 750..1020MB/s on 10Gb network (Chelsea CXGB3 10Gb ethernet card).
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>=20
> There are still a few oddities in the error paths.
>=20
> [snip]
>> +static long kvmppc_tce_iommu_unmap(struct kvm *kvm,
>> +		struct iommu_table *tbl, unsigned long entry)
>> +{
>> +	enum dma_data_direction dir =3D DMA_NONE;
>> +	unsigned long hpa =3D 0;
>> +	long ret;
>> +
>> +	if (iommu_tce_xchg(tbl, entry, &hpa, &dir))
>> +		return H_HARDWARE;
>=20
> IIR previous discussions properly, an xchg() failure should be a
> WARN_ON().

Well, it could, I'll add. It just feels sometime that having both WARN_ON=

and H_HARDWARE is kind of redundant.


> [snip]
>> +static long kvmppc_rm_tce_iommu_mapped_dec(struct kvm *kvm,
>> +		struct iommu_table *tbl, unsigned long entry)
>> +{
>> +	struct mm_iommu_table_group_mem_t *mem =3D NULL;
>> +	const unsigned long pgsize =3D 1ULL << tbl->it_page_shift;
>> +	unsigned long *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
>> +
>> +	if (WARN_ON_ONCE_RM(!pua))
>> +		return H_HARDWARE;
>> +
>> +	pua =3D (void *) vmalloc_to_phys(pua);
>> +	if (!pua)
>> +		return H_TOO_HARD;
>=20
> Here a vmalloc translation failure is treated as an H_TOO_HARD..

Ah, here is an oddity, here should be WARN_ON + H_HARDWARE and the if(!pu=
a)
check should not do WARN_ON and return H_TOO_HARD, I did not hit this
because the hardware is empty when VFIO starts using it so there is nothi=
ng
to unmap initial H_STUFF_TCE happens.

>=20
>> +
>> +	mem =3D mm_iommu_lookup_rm(kvm->mm, *pua, pgsize);
>> +	if (!mem)
>> +		return H_TOO_HARD;
>> +
>> +	mm_iommu_mapped_dec(mem);
>> +
>> +	*pua =3D 0;
>> +
>> +	return H_SUCCESS;
>> +}
>> +
>> +static long kvmppc_rm_tce_iommu_unmap(struct kvm *kvm,
>> +		struct iommu_table *tbl, unsigned long entry)
>> +{
>> +	enum dma_data_direction dir =3D DMA_NONE;
>> +	unsigned long hpa =3D 0;
>> +	long ret;
>> +
>> +	if (iommu_tce_xchg_rm(tbl, entry, &hpa, &dir))
>> +		return H_HARDWARE;
>=20
> Another xchg failure where I'd expect a WARN.


The realmode's iommu_tce_xchg_rm() does SetPageDirty() if
realmode_pfn_to_page() succeeded but realmode_pfn_to_page() may fail if t=
he
requested page struct is split between 2 system pages in real addressspac=
e
but not in virtual address space where page structs are mapped to
0xfxxx.xxxx.xxxx.xxxx.


>=20
>> +
>> +	if (dir =3D=3D DMA_NONE)
>> +		return H_SUCCESS;
>> +
>> +	ret =3D kvmppc_rm_tce_iommu_mapped_dec(kvm, tbl, entry);
>> +	if (ret)
>> +		iommu_tce_xchg_rm(tbl, entry, &hpa, &dir);
>> +
>> +	return ret;
>> +}
>> +
>> +static long kvmppc_rm_tce_iommu_map(struct kvm *kvm, struct iommu_tab=
le *tbl,
>> +		unsigned long entry, unsigned long ua,
>> +		enum dma_data_direction dir)
>> +{
>> +	long ret;
>> +	unsigned long hpa =3D 0;
>> +	unsigned long *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
>> +	struct mm_iommu_table_group_mem_t *mem;
>> +
>> +	if (!pua)
>> +		/* it_userspace allocation might be delayed */
>> +		return H_TOO_HARD;
>> +
>> +	mem =3D mm_iommu_lookup_rm(kvm->mm, ua, 1ULL << tbl->it_page_shift);=

>> +	if (!mem)
>> +		return H_TOO_HARD;
>> +
>> +	if (WARN_ON_ONCE_RM(mm_iommu_ua_to_hpa_rm(mem, ua, &hpa)))
>> +		return H_HARDWARE;
>> +
>> +	pua =3D (void *) vmalloc_to_phys(pua);
>> +	if (WARN_ON_ONCE_RM(!pua))
>=20
> .. but here a more or less identical vmalloc translation failure is
> treated as a WARN.  Is it TOO_HARD, or WARN?

This one is correct.


>=20
>> +		return H_HARDWARE;
>> +
>> +	if (WARN_ON_ONCE_RM(mm_iommu_mapped_inc(mem)))
>> +		return H_CLOSED;
>> +
>> +	ret =3D iommu_tce_xchg_rm(tbl, entry, &hpa, &dir);
>> +	if (ret) {
>> +		mm_iommu_mapped_dec(mem);
>> +		return H_TOO_HARD;
>=20
> And another xchg failure that I'd expect to be a warn


Here it is the realmode's iommu_tce_xchg again.


>=20
>> +	}
>> +
>> +	if (dir !=3D DMA_NONE)
>> +		kvmppc_rm_tce_iommu_mapped_dec(kvm, tbl, entry);
>> +
>> +	*pua =3D ua;
>> +
>> +	return 0;
>> +}
>> +
>>  long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>>  		unsigned long ioba, unsigned long tce)
>>  {
>>  	struct kvmppc_spapr_tce_table *stt;
>>  	long ret;
>> +	struct kvmppc_spapr_tce_iommu_table *stit;
>> +	unsigned long entry, ua =3D 0;
>> +	enum dma_data_direction dir;
>> =20
>>  	/* udbg_printf("H_PUT_TCE(): liobn=3D0x%lx ioba=3D0x%lx, tce=3D0x%lx=
\n", */
>>  	/* 	    liobn, ioba, tce); */
>> @@ -182,7 +304,32 @@ long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, u=
nsigned long liobn,
>>  	if (ret !=3D H_SUCCESS)
>>  		return ret;
>> =20
>> -	kvmppc_tce_put(stt, ioba >> stt->page_shift, tce);
>> +	dir =3D iommu_tce_direction(tce);
>> +	if ((dir !=3D DMA_NONE) && kvmppc_gpa_to_ua(vcpu->kvm,
>> +			tce & ~(TCE_PCI_READ | TCE_PCI_WRITE), &ua, NULL))
>> +		return H_PARAMETER;
>> +
>> +	entry =3D ioba >> stt->page_shift;
>> +
>> +	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
>> +		if (dir =3D=3D DMA_NONE)
>> +			ret =3D kvmppc_rm_tce_iommu_unmap(vcpu->kvm,
>> +					stit->tbl, entry);
>> +		else
>> +			ret =3D kvmppc_rm_tce_iommu_map(vcpu->kvm,
>> +					stit->tbl, entry, ua, dir);
>> +
>> +		if (ret =3D=3D H_SUCCESS)
>> +			continue;
>> +
>> +		if (ret =3D=3D H_TOO_HARD)
>> +			return ret;
>> +
>> +		WARN_ON_ONCE_RM(1);
>> +		kvmppc_rm_clear_tce(stit->tbl, entry);
>> +	}
>> +
>> +	kvmppc_tce_put(stt, entry, tce);
>> =20
>>  	return H_SUCCESS;
>>  }
>> @@ -223,6 +370,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu =
*vcpu,
>>  	unsigned long tces, entry, ua =3D 0;
>>  	unsigned long *rmap =3D NULL;
>>  	bool prereg =3D false;
>> +	struct kvmppc_spapr_tce_iommu_table *stit;
>> =20
>>  	stt =3D kvmppc_find_table(vcpu->kvm, liobn);
>>  	if (!stt)
>> @@ -293,6 +441,27 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu=
 *vcpu,
>>  		if (ret !=3D H_SUCCESS)
>>  			goto unlock_exit;
>> =20
>> +		ua =3D 0;
>> +		if (kvmppc_gpa_to_ua(vcpu->kvm,
>> +				tce & ~(TCE_PCI_READ | TCE_PCI_WRITE),
>> +				&ua, NULL))
>> +			return H_PARAMETER;
>> +
>> +		list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
>> +			ret =3D kvmppc_rm_tce_iommu_map(vcpu->kvm,
>> +					stit->tbl, entry + i, ua,
>> +					iommu_tce_direction(tce));
>> +
>> +			if (ret =3D=3D H_SUCCESS)
>> +				continue;
>> +
>> +			if (ret =3D=3D H_TOO_HARD)
>> +				goto unlock_exit;
>> +
>> +			WARN_ON_ONCE_RM(1);
>> +			kvmppc_rm_clear_tce(stit->tbl, entry);
>> +		}
>> +
>>  		kvmppc_tce_put(stt, entry + i, tce);
>>  	}
>> =20
>> @@ -309,6 +478,7 @@ long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
>>  {
>>  	struct kvmppc_spapr_tce_table *stt;
>>  	long i, ret;
>> +	struct kvmppc_spapr_tce_iommu_table *stit;
>> =20
>>  	stt =3D kvmppc_find_table(vcpu->kvm, liobn);
>>  	if (!stt)
>> @@ -322,6 +492,24 @@ long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,=

>>  	if (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ))
>>  		return H_PARAMETER;
>> =20
>> +	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
>> +		unsigned long entry =3D ioba >> stit->tbl->it_page_shift;
>> +
>> +		for (i =3D 0; i < npages; ++i) {
>> +			ret =3D kvmppc_rm_tce_iommu_unmap(vcpu->kvm,
>> +					stit->tbl, entry + i);
>> +
>> +			if (ret =3D=3D H_SUCCESS)
>> +				continue;
>> +
>> +			if (ret =3D=3D H_TOO_HARD)
>> +				return ret;
>> +
>> +			WARN_ON_ONCE_RM(1);
>> +			kvmppc_rm_clear_tce(stit->tbl, entry);
>> +		}
>> +	}
>> +
>>  	for (i =3D 0; i < npages; ++i, ioba +=3D (1ULL << stt->page_shift))
>>  		kvmppc_tce_put(stt, ioba >> stt->page_shift, tce_value);
>> =20
>> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
>> index 95c91a9de351..62bdd6c48107 100644
>> --- a/arch/powerpc/kvm/powerpc.c
>> +++ b/arch/powerpc/kvm/powerpc.c
>> @@ -538,6 +538,8 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, =
long ext)
>>  #ifdef CONFIG_PPC_BOOK3S_64
>>  	case KVM_CAP_SPAPR_TCE:
>>  	case KVM_CAP_SPAPR_TCE_64:
>> +		/* fallthrough */
>> +	case KVM_CAP_SPAPR_TCE_VFIO:
>>  	case KVM_CAP_PPC_RTAS:
>>  	case KVM_CAP_PPC_FIXUP_HCALL:
>>  	case KVM_CAP_PPC_ENABLE_HCALL:
>> diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
>> index d32f239eb471..2b7dc22265fe 100644
>> --- a/virt/kvm/vfio.c
>> +++ b/virt/kvm/vfio.c
>> @@ -20,6 +20,10 @@
>>  #include <linux/vfio.h>
>>  #include "vfio.h"
>> =20
>> +#ifdef CONFIG_SPAPR_TCE_IOMMU
>> +#include <asm/kvm_ppc.h>
>> +#endif
>> +
>>  struct kvm_vfio_group {
>>  	struct list_head node;
>>  	struct vfio_group *vfio_group;
>> @@ -211,6 +215,9 @@ static int kvm_vfio_set_group(struct kvm_device *d=
ev, long attr, u64 arg)
>> =20
>>  		mutex_unlock(&kv->lock);
>> =20
>> +#ifdef CONFIG_SPAPR_TCE_IOMMU
>> +		kvm_spapr_tce_release_iommu_group(dev->kvm, vfio_group);
>> +#endif
>>  		kvm_vfio_group_set_kvm(vfio_group, NULL);
>> =20
>>  		kvm_vfio_group_put_external_user(vfio_group);
>> @@ -218,6 +225,53 @@ static int kvm_vfio_set_group(struct kvm_device *=
dev, long attr, u64 arg)
>>  		kvm_vfio_update_coherency(dev);
>> =20
>>  		return ret;
>> +
>> +#ifdef CONFIG_SPAPR_TCE_IOMMU
>> +	case KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE: {
>> +		struct kvm_vfio_spapr_tce param;
>> +		unsigned long minsz;
>> +		struct kvm_vfio *kv =3D dev->private;
>> +		struct vfio_group *vfio_group;
>> +		struct kvm_vfio_group *kvg;
>> +		struct fd f;
>> +
>> +		minsz =3D offsetofend(struct kvm_vfio_spapr_tce, tablefd);
>> +
>> +		if (copy_from_user(&param, (void __user *)arg, minsz))
>> +			return -EFAULT;
>> +
>> +		if (param.argsz < minsz || param.flags)
>> +			return -EINVAL;
>> +
>> +		f =3D fdget(param.groupfd);
>> +		if (!f.file)
>> +			return -EBADF;
>> +
>> +		vfio_group =3D kvm_vfio_group_get_external_user(f.file);
>> +		fdput(f);
>> +
>> +		if (IS_ERR(vfio_group))
>> +			return PTR_ERR(vfio_group);
>> +
>> +		ret =3D -ENOENT;
>> +
>> +		mutex_lock(&kv->lock);
>> +
>> +		list_for_each_entry(kvg, &kv->group_list, node) {
>> +			if (kvg->vfio_group !=3D vfio_group)
>> +				continue;
>> +
>> +			ret =3D kvm_spapr_tce_attach_iommu_group(dev->kvm,
>> +					param.tablefd, vfio_group);
>> +
>> +			break;
>> +		}
>> +
>> +		mutex_unlock(&kv->lock);
>> +
>> +		return ret;
>> +	}
>> +#endif /* CONFIG_SPAPR_TCE_IOMMU */
>>  	}
>> =20
>>  	return -ENXIO;
>> @@ -242,6 +296,9 @@ static int kvm_vfio_has_attr(struct kvm_device *de=
v,
>>  		switch (attr->attr) {
>>  		case KVM_DEV_VFIO_GROUP_ADD:
>>  		case KVM_DEV_VFIO_GROUP_DEL:
>> +#ifdef CONFIG_SPAPR_TCE_IOMMU
>> +		case KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE:
>> +#endif
>>  			return 0;
>>  		}
>> =20
>> @@ -257,6 +314,9 @@ static void kvm_vfio_destroy(struct kvm_device *de=
v)
>>  	struct kvm_vfio_group *kvg, *tmp;
>> =20
>>  	list_for_each_entry_safe(kvg, tmp, &kv->group_list, node) {
>> +#ifdef CONFIG_SPAPR_TCE_IOMMU
>> +		kvm_spapr_tce_release_iommu_group(dev->kvm, kvg->vfio_group);
>> +#endif
>>  		kvm_vfio_group_set_kvm(kvg->vfio_group, NULL);
>>  		kvm_vfio_group_put_external_user(kvg->vfio_group);
>>  		list_del(&kvg->node);
>=20


--=20
Alexey


--I9bhBTQVuLGhl56AAC4BjxbWRSKUfBT9C--

--W8Eqwe7eArujlFpngBt050w5HW8jnq0KA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJYwULEDhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5OgIP/3V1
DqddkQjGY8pfegw7pLbiajIu/CK8Tyh8HrsfFBDNY1nt57/85sGt25PclP9mMNI2
LXk002VTctjCpqEjKkorTyitKhr+pdDocSnx7PtBksC171l0wswLayDWAexNcc0p
gAr6qkWBU5MdoCPHa8Vv1eABZqp6Oj6/UDSgdrlDHPI206qdYW6Fd7gfmKioK33B
X93yQ21a6oWKgirbPNuuAnStgVWnljGvTNQ4L1lewR38S2dVoSbYtDfP64uwLY5O
t8E+dR17SGW3orpuRkviYPdbHyORQFnkUovSCeQGYcIWhQiNiBqmAPJuvzaa6yx4
8mmOJNng0LK9Cj0reWKRyFFRGOl4U+dlLAJyx+AgTVqud34kzvFYGXHAI96XH5P+
9ccd/h2yu5xHb5EHXc1R4TWOAyXzaoBLBs1LyTRR+Y3emO1mpdUrrbBLlDEtCOV6
K77+Uys+isU2HXKKVOluRYtntE5klNK4qlGohdelmjf3ar2jJ5SKNU7put8RnA6V
5xvxUul43+yREmZ/iSQaHYifCKYYKNOjaqa/8H1sUeEqcrqGvQLeR0fJ62bpMgXU
jEcUtHe7zJERTRyFsdgNXoKXGcclTK1bCdLY+078Bqqn1+WynhECbCf1eq5Ms/XS
3LtLIA0RPPc2AKZW2SMPUVQkxnQE3nHq4CZa90Ze
=eo6B
-----END PGP SIGNATURE-----

--W8Eqwe7eArujlFpngBt050w5HW8jnq0KA--
