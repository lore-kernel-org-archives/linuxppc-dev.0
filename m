Return-Path: <aik@ozlabs.ru>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vWn5g0Nr6zDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 14:20:20 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id 1so11228876pgz.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Feb 2017 19:20:20 -0800 (PST)
Subject: Re: [PATCH kernel v5 10/10] KVM: PPC: VFIO: Add in-kernel
 acceleration for VFIO
To: David Gibson <david@gibson.dropbear.id.au>
References: <20170222082133.10277-1-aik@ozlabs.ru>
 <20170222082133.10277-11-aik@ozlabs.ru>
 <20170224021432.GH17615@umbus.fritz.box>
 <7b2d6cba-73e7-e846-a520-fc2837694c11@ozlabs.ru>
 <20170224033607.GQ17615@umbus.fritz.box>
 <784555a2-2c4e-5a49-7b7e-68b0417ef5e1@ozlabs.ru>
 <20170227015352.GP17615@umbus.fritz.box>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <09bb107b-b19a-5717-3b2c-a2028f15f443@ozlabs.ru>
Date: Mon, 27 Feb 2017 14:20:13 +1100
MIME-Version: 1.0
In-Reply-To: <20170227015352.GP17615@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KhHpEXuA0DK3EVMLmGkkhjQpEDvASjxre"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KhHpEXuA0DK3EVMLmGkkhjQpEDvASjxre
Content-Type: multipart/mixed; boundary="cSlSUIhiEUjH3Q5n5Nj4AxFTdmP9FF1OS";
 protected-headers="v1"
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Message-ID: <09bb107b-b19a-5717-3b2c-a2028f15f443@ozlabs.ru>
Subject: Re: [PATCH kernel v5 10/10] KVM: PPC: VFIO: Add in-kernel
 acceleration for VFIO
References: <20170222082133.10277-1-aik@ozlabs.ru>
 <20170222082133.10277-11-aik@ozlabs.ru>
 <20170224021432.GH17615@umbus.fritz.box>
 <7b2d6cba-73e7-e846-a520-fc2837694c11@ozlabs.ru>
 <20170224033607.GQ17615@umbus.fritz.box>
 <784555a2-2c4e-5a49-7b7e-68b0417ef5e1@ozlabs.ru>
 <20170227015352.GP17615@umbus.fritz.box>
In-Reply-To: <20170227015352.GP17615@umbus.fritz.box>

--cSlSUIhiEUjH3Q5n5Nj4AxFTdmP9FF1OS
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable

On 27/02/17 12:53, David Gibson wrote:
> On Fri, Feb 24, 2017 at 02:43:05PM +1100, Alexey Kardashevskiy wrote:
>> On 24/02/17 14:36, David Gibson wrote:
>>> On Fri, Feb 24, 2017 at 02:29:14PM +1100, Alexey Kardashevskiy wrote:=

>>>> On 24/02/17 13:14, David Gibson wrote:
>>>>> On Wed, Feb 22, 2017 at 07:21:33PM +1100, Alexey Kardashevskiy
>> wrote:
> [snip]
>>>>>> +static long kvmppc_rm_tce_iommu_unmap(struct kvm *kvm,
>>>>>> +		struct iommu_table *tbl, unsigned long entry)
>>>>>> +{
>>>>>> +	enum dma_data_direction dir =3D DMA_NONE;
>>>>>> +	unsigned long hpa =3D 0;
>>>>>> +	long ret;
>>>>>> +
>>>>>> +	if (iommu_tce_xchg_rm(tbl, entry, &hpa, &dir))
>>>>>> +		return H_HARDWARE;
>>>>>
>>>>> To avoid a double WARN() (and to make the warnings easier to
>>>>> understand) I'd suggest putting a WARN_ON() here, rather than in th=
e
>>>>> callers when they receieve an H_HARDWARE.  IIUC this really shouldn=
't
>>>>> ever happen, and it certainly can't be the guest's fault?
>>>>
>>>>
>>>> Makes sense.
>>>
>>> I guess it might want WARN_ON_ONCE() to avoid spamming the user with
>>> errors for every TCE, though.
>>
>>
>> We do not expect this to happen at all :) I can convert all of them to=

>> _ONCE really as the purpose of WARN_ON is mostly to document what we d=
o not
>> expect.
>=20
> Sure, seems reasonable.
>=20
> [snip]
>>>>>> @@ -220,9 +338,10 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_=
vcpu *vcpu,
>>>>>>  {
>>>>>>  	struct kvmppc_spapr_tce_table *stt;
>>>>>>  	long i, ret =3D H_SUCCESS;
>>>>>> -	unsigned long tces, entry, ua =3D 0;
>>>>>> +	unsigned long tces, entry, ua =3D 0, tce, gpa;
>>>>>>  	unsigned long *rmap =3D NULL;
>>>>>>  	bool prereg =3D false;
>>>>>> +	struct kvmppc_spapr_tce_iommu_table *stit;
>>>>>> =20
>>>>>>  	stt =3D kvmppc_find_table(vcpu->kvm, liobn);
>>>>>>  	if (!stt)
>>>>>> @@ -287,12 +406,24 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm=
_vcpu *vcpu,
>>>>>>  	}
>>>>>> =20
>>>>>>  	for (i =3D 0; i < npages; ++i) {
>>>>>> -		unsigned long tce =3D be64_to_cpu(((u64 *)tces)[i]);
>>>>>> +		tce =3D be64_to_cpu(((u64 *)tces)[i]);
>>>>>> =20
>>>>>>  		ret =3D kvmppc_tce_validate(stt, tce);
>>>>>>  		if (ret !=3D H_SUCCESS)
>>>>>>  			goto unlock_exit;
>>>>>> =20
>>>>>> +		gpa =3D tce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
>>>>>> +
>>>>>> +		list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
>>>>>> +			ret =3D kvmppc_rm_tce_iommu_map(vcpu->kvm,
>>>>>> +					stit->tbl, entry + i, gpa,
>>>>>> +					iommu_tce_direction(tce));
>>>>>> +			if (WARN_ON_ONCE(ret =3D=3D H_HARDWARE))
>>>>>
>>>>> I don't think you need the WARN() here - the only H_HARDWARE failur=
e
>>>>> path in iommu_map() already includes a WARN().
>>>>
>>>>
>>>> True, I can drop it here.
>>>>
>>>>
>>>>>
>>>>>> +				kvmppc_rm_clear_tce(stit->tbl, entry);
>>>>>> +			else if (ret !=3D H_SUCCESS)
>>>>>> +				goto unlock_exit;
>>>>>
>>>>> It's also not clear to me why the H_HARDWARE error path clears the
>>>>> entry, but the other failure paths don't.  Or why an H_HARDWARE wil=
l
>>>>> result in continuing to set the rest of the TCEs, but other failure=
s
>>>>> won't.
>>>>
>>>>
>>>> The idea was that other failures still have some chance that handlin=
g may
>>>> succeed in virtual mode or via QEMU, H_HARDWARE is fatal.
>>>
>>> Um... yes.. but the logic seems to be backwards for that: on
>>> H_HARDWARE you warn and keep going, on other errors you bail out
>>> entirely.
>>
>> By "fatal" I means fatal for this particular hardware TCE(s), no hope =
in
>> trying this particular TCE in virtual mode.
>=20
> Ok... still not following why that means the "fatal" error results in
> continuing to attempt for the rest of the updated TCEs, whereas the
> "non fatal" one bails out.

I was applying the principle that if after all checks done we still canno=
t
update the hardware table, then just clear the TCE and move on. Or I
misunderstood the idea?


> Especially since the bail out will only go
> to virtual mode if ret =3D=3D H_TOO_HARD, which it isn't clear is the o=
nly
> possibility.


H_TOO_HARD goes to virtual mode, H_TOO_HARD in virtual goes to the
userspace (QEMU).

Will "if (WARN_ON_ONCE(ret !=3D H_SUCCESS && ret !=3D H_TOO_HARD))" make =
more
sense?



>=20
>>>> I am just not sure if H_PARAMETER is what I want to return at [1], t=
o make
>>>> the calling code simplier, I could return H_HARDWARE there as well (=
instead
>>>> of H_PARAMETER).
>>>
>>> That sounds right, IIUC the gpa to ua translation shouldn't ever
>>> fail because of something the guest did.=20
>>
>>
>> The guest can easily pass bad TCE/GPA which is not in any registered s=
lot.
>> So it is rather H_PARAMETER.
>=20
> Ah, yes.
>=20
>>> So I'd expect either
>>> H_HARDWARE, or H_TOO_HARD (if there's some hope that virtual mode can=

>>> make the translation when real mode couldn't).
>>
>> No, virtual mode uses the exact same helper.
>=20
> Ok.
>=20


--=20
Alexey


--cSlSUIhiEUjH3Q5n5Nj4AxFTdmP9FF1OS--

--KhHpEXuA0DK3EVMLmGkkhjQpEDvASjxre
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJYs5rtDhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC51d4P/RdO
NpVla1JNTtahVbw4eT7k7ve9nPrX9d4vBVcW0zRLPXt7iIBCS1GZw8nIr1+rqP0o
U1L+Rdv//qw0NJ32RRhiL4qQnqjfIqRkPKIrL7ByqLOx4scxWDWfb5/glnBRloVu
HzCxeuMUruNWjtnUEatSc/amKXw6i+WNGJhKa95N1LqRLnqJOAskU0YE0dN921BX
6gD+1rGvKF+7T5vCvsaK7qc6ifPjA1LC2Bjj0JUs1tCZH9/TD0mhJduWRhU7Qfpy
AHn0RNYaeoBNOYfLtlAB18EN7mylftpCNVhjb6+9lcnQZZ2Q8oCwu4tfv7hWDBGH
CWmQ2GwCHcTfO3osCxiXY3XVCz45j23urE613RTlkjZUnFbIVjjCA+466Vq/D5bY
rdzOEVD4c4ircMyiWrnG3fV4rsyH1grf1W1/b+fdEZ9wfL0jQiPcQZ3ZswA3ye6S
E28s6zo3M+H8fGazd8xIfrnzXBUAsiR7/ikj/mOy6TQIyODk7K/sVMoPDiH3aA/m
48siaFOG65FAil+3tVNmCGjrWx0SLOVewnk5/fsH9EnofJcX0NhY1Kb26VY14TRb
z9Ytg4pYL7WaxiS+DzfhYPJfN97ptCLLhc/3NgWqb8CMxUBgIBx8no4tlM3Z/KAF
MO0YEjr7ZqlJCF/KoOVDePx54tPow4mT6MTIEaSF
=hdCg
-----END PGP SIGNATURE-----

--KhHpEXuA0DK3EVMLmGkkhjQpEDvASjxre--
