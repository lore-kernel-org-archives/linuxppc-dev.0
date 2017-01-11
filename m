Return-Path: <aik@ozlabs.ru>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tyzfY4rJPzDqK5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 17:35:32 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id 204so6058031pge.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 22:35:32 -0800 (PST)
Subject: Re: [PATCH kernel v2 05/11] KVM: PPC: Use preregistered memory API to
 access TCE list
To: David Gibson <david@gibson.dropbear.id.au>
References: <20161218012900.18142-1-aik@ozlabs.ru>
 <20161218012900.18142-6-aik@ozlabs.ru>
 <20161221040843.GD13024@umbus.fritz.box>
 <ef7b6306-a403-390f-ac25-5cffd546d66b@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <342e6541-7d92-fe4b-cb3a-8ab4cd3b6e02@ozlabs.ru>
Date: Wed, 11 Jan 2017 17:35:21 +1100
MIME-Version: 1.0
In-Reply-To: <ef7b6306-a403-390f-ac25-5cffd546d66b@ozlabs.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="TelvDtFwpXksn5IpCFvporMtQIsXccen3"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TelvDtFwpXksn5IpCFvporMtQIsXccen3
Content-Type: multipart/mixed; boundary="VbQ6PTQsnAa8A3oGV9loF0XAAFV96P5xn";
 protected-headers="v1"
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Message-ID: <342e6541-7d92-fe4b-cb3a-8ab4cd3b6e02@ozlabs.ru>
Subject: Re: [PATCH kernel v2 05/11] KVM: PPC: Use preregistered memory API to
 access TCE list
References: <20161218012900.18142-1-aik@ozlabs.ru>
 <20161218012900.18142-6-aik@ozlabs.ru>
 <20161221040843.GD13024@umbus.fritz.box>
 <ef7b6306-a403-390f-ac25-5cffd546d66b@ozlabs.ru>
In-Reply-To: <ef7b6306-a403-390f-ac25-5cffd546d66b@ozlabs.ru>

--VbQ6PTQsnAa8A3oGV9loF0XAAFV96P5xn
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable

On 21/12/16 19:57, Alexey Kardashevskiy wrote:
> On 21/12/16 15:08, David Gibson wrote:
>> On Sun, Dec 18, 2016 at 12:28:54PM +1100, Alexey Kardashevskiy wrote:
>>> VFIO on sPAPR already implements guest memory pre-registration
>>> when the entire guest RAM gets pinned. This can be used to translate
>>> the physical address of a guest page containing the TCE list
>>> from H_PUT_TCE_INDIRECT.
>>>
>>> This makes use of the pre-registrered memory API to access TCE list
>>> pages in order to avoid unnecessary locking on the KVM memory
>>> reverse map as we know that all of guest memory is pinned and
>>> we have a flat array mapping GPA to HPA which makes it simpler and
>>> quicker to index into that array (even with looking up the
>>> kernel page tables in vmalloc_to_phys) than it is to find the memslot=
,
>>> lock the rmap entry, look up the user page tables, and unlock the rma=
p
>>> entry. Note that the rmap pointer is initialized to NULL
>>> where declared (not in this patch).
>>>
>>> If a requested chunk of memory has not been preregistered,
>>> this will fail with H_TOO_HARD so the virtual mode handle can
>>> handle the request.
>>>
>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>> ---
>>> Changes:
>>> v2:
>>> * updated the commit log with David's comment
>>> ---
>>>  arch/powerpc/kvm/book3s_64_vio_hv.c | 65 +++++++++++++++++++++++++++=
+---------
>>>  1 file changed, 49 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/b=
ook3s_64_vio_hv.c
>>> index d461c440889a..a3be4bd6188f 100644
>>> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
>>> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
>>> @@ -180,6 +180,17 @@ long kvmppc_gpa_to_ua(struct kvm *kvm, unsigned =
long gpa,
>>>  EXPORT_SYMBOL_GPL(kvmppc_gpa_to_ua);
>>> =20
>>>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
>>> +static inline bool kvmppc_preregistered(struct kvm_vcpu *vcpu)
>>> +{
>>> +	return mm_iommu_preregistered(vcpu->kvm->mm);
>>> +}
>>> +
>>> +static struct mm_iommu_table_group_mem_t *kvmppc_rm_iommu_lookup(
>>> +		struct kvm_vcpu *vcpu, unsigned long ua, unsigned long size)
>>> +{
>>> +	return mm_iommu_lookup_rm(vcpu->kvm->mm, ua, size);
>>> +}
>>
>> I don't see that there's much point to these inlines.
>>
>>>  long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,=

>>>  		unsigned long ioba, unsigned long tce)
>>>  {
>>> @@ -260,23 +271,44 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vc=
pu *vcpu,
>>>  	if (ret !=3D H_SUCCESS)
>>>  		return ret;
>>> =20
>>> -	if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, &rmap))
>>> -		return H_TOO_HARD;
>>> +	if (kvmppc_preregistered(vcpu)) {
>>> +		/*
>>> +		 * We get here if guest memory was pre-registered which
>>> +		 * is normally VFIO case and gpa->hpa translation does not
>>> +		 * depend on hpt.
>>> +		 */
>>> +		struct mm_iommu_table_group_mem_t *mem;
>>> =20
>>> -	rmap =3D (void *) vmalloc_to_phys(rmap);
>>> +		if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, NULL))
>>> +			return H_TOO_HARD;
>>> =20
>>> -	/*
>>> -	 * Synchronize with the MMU notifier callbacks in
>>> -	 * book3s_64_mmu_hv.c (kvm_unmap_hva_hv etc.).
>>> -	 * While we have the rmap lock, code running on other CPUs
>>> -	 * cannot finish unmapping the host real page that backs
>>> -	 * this guest real page, so we are OK to access the host
>>> -	 * real page.
>>> -	 */
>>> -	lock_rmap(rmap);
>>> -	if (kvmppc_rm_ua_to_hpa(vcpu, ua, &tces)) {
>>> -		ret =3D H_TOO_HARD;
>>> -		goto unlock_exit;
>>> +		mem =3D kvmppc_rm_iommu_lookup(vcpu, ua, IOMMU_PAGE_SIZE_4K);
>>> +		if (!mem || mm_iommu_ua_to_hpa_rm(mem, ua, &tces))
>>> +			return H_TOO_HARD;
>>> +	} else {
>>> +		/*
>>> +		 * This is emulated devices case.
>>> +		 * We do not require memory to be preregistered in this case
>>> +		 * so lock rmap and do __find_linux_pte_or_hugepte().
>>> +		 */
>>
>> Hmm.  So this isn't wrong as such, but the logic and comments are
>> both misleading.  The 'if' here isn't really about VFIO vs. emulated -=

>> it's about whether the mm has *any* preregistered chunks, without any
>> regard to which particular device you're talking about.  For example
>> if your guest has two PHBs, one with VFIO devices and the other with
>> emulated devices, then the emulated devices will still go through the
>> "VFIO" case here.
>=20
> kvmppc_preregistered() checks for a single pointer, kvmppc_rm_ua_to_hpa=
()
> goes through __find_linux_pte_or_hugepte() which is unnecessary
> complication here.
>=20
> s/emulated devices case/case of a guest with emulated devices only/ ?
>=20
>=20
>> Really what you have here is a fast case when the tce_list is in
>> preregistered memory, and a fallback case when it isn't.  But that's
>> obscured by the fact that if for whatever reason you have some
>> preregistered memory but it doesn't cover the tce_list, then you don't=

>> go to the fallback case here, but instead fall right back to the
>> virtual mode handler.
>=20
> This is purely acceleration, I am trying to make obvious cases faster, =
and
> other cases safer. If some chunk is not preregistered but others are an=
d
> there is H_PUT_TCE_INDIRECT with tce_list from non-preregistered memory=
,
> then I have no idea what this userspace is and what it is doing, so I j=
ust
> do not want to accelerate anything for it in real mode (I have poor
> imagination and since I cannot test it - I better drop it).
>=20
>=20
>> So, I think you should either:
>>     1) Fallback to the code below whenever you can't access the
>>        tce_list via prereg memory, regardless of whether there's any
>>        _other_ prereg memory
>=20
> Using prereg was the entire point here as if something goes wrong (i.e.=

> some TCE fails to translate), I may stop in a middle of TCE list and wi=
ll
> have to do complicated rollback to pass the request in the virtual mode=
 to
> finish processing (note that there is nothing to revert when it is
> emulated-devices-only-guest).
>=20
>=20
>> or
>>     2) Drop the code below entirely and always return H_TOO_HARD if
>>        you can't get the tce_list from prereg.
>=20
> This path cannot fail for emulated device and it is really fast path, w=
hy
> to drop it?
>=20
>=20
> I am _really_ confused now. In few last respins this was not a concern,=
 now
> it is - is the patch this bad and 100% needs to be reworked? I am tryin=
g to
> push it last 3 years now :(
>=20


Ping?


>=20
>>
>>> +		if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, &rmap))
>>> +			return H_TOO_HARD;
>>> +
>>> +		rmap =3D (void *) vmalloc_to_phys(rmap);
>>> +
>>> +		/*
>>> +		 * Synchronize with the MMU notifier callbacks in
>>> +		 * book3s_64_mmu_hv.c (kvm_unmap_hva_hv etc.).
>>> +		 * While we have the rmap lock, code running on other CPUs
>>> +		 * cannot finish unmapping the host real page that backs
>>> +		 * this guest real page, so we are OK to access the host
>>> +		 * real page.
>>> +		 */
>>> +		lock_rmap(rmap);
>>> +		if (kvmppc_rm_ua_to_hpa(vcpu, ua, &tces)) {
>>> +			ret =3D H_TOO_HARD;
>>> +			goto unlock_exit;
>>> +		}
>>>  	}
>>> =20
>>>  	for (i =3D 0; i < npages; ++i) {
>>> @@ -290,7 +322,8 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu=
 *vcpu,
>>>  	}
>>> =20
>>>  unlock_exit:
>>> -	unlock_rmap(rmap);
>>> +	if (rmap)
>>> +		unlock_rmap(rmap);
>>> =20
>>>  	return ret;
>>>  }
>>
>=20
>=20


--=20
Alexey


--VbQ6PTQsnAa8A3oGV9loF0XAAFV96P5xn--

--TelvDtFwpXksn5IpCFvporMtQIsXccen3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJYddIqDhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5DyoP/Rnw
FI0ydr0Nl8MYReSRYYmPpjLjsO/4z5hvW88lzFjyUbhhsPbPEAsh2i7iPYfVD9IR
HxOV/nKGMH9mqi0pxExA7eWK8CSVLSRj3fGZQgBOJwI8j20rtyOLS20vCxiRYG/B
3x7xzHMnCk0SEA4ueT9TUvrsvL5jcBng5U0tMLCNs+sGQAeeqGVINgtOURdlvYf5
qeUmeKT6R9GjETTyII4G7Rr06A3Ev0ePw8y7Tez7bnNYvjLRr+fstyvUQ3RBfFeX
JctlARoGXpUxGUXNnWmRNLng1nAxv3EVgrox8Yweq6A/BapeApdHBBevND1Ur3+H
l1ddw21vBXxYVDl2hKXAcf8k1L9ZeKRu4Cn3LmRdnPzEJy5wuCLeyZCyMKq0NXiO
rAmO9BzJmTOWoLmL1scaq3fxfYWCjbIGWvRVfCj7tpazQIU/PIipA1H9X3m4HUnm
HRnPl6HvW1cmLQG1eiD2nKL4jjBmAmQw5Fe+kERyez/76voIYsuDhO151zuXClxw
XFBvlshzGf3WrquTVjRV7UAx9SKd/uOCLp5cmEI9gcffRUe/TyFfswa7SL2o3kVe
tA6NpW5U62l4tnUt4X5crOuMN0RBKleiP1DTufcxA/9uvzDo1zhYPhZm5inI8FXT
T7hR8TppRsdGCTmMJtlutWNkxuxHbYT2jWV9A1Yn
=IilH
-----END PGP SIGNATURE-----

--TelvDtFwpXksn5IpCFvporMtQIsXccen3--
