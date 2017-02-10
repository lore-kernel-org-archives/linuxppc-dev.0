Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vKM0M53DrzDq8g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2017 15:09:39 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id o64so627201pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Feb 2017 20:09:39 -0800 (PST)
Subject: Re: [PATCH kernel v4 08/10] KVM: PPC: Separate TCE validation from
 update
To: David Gibson <david@gibson.dropbear.id.au>
References: <20170207071711.28938-1-aik@ozlabs.ru>
 <20170207071711.28938-9-aik@ozlabs.ru> <20170209035151.GA14524@umbus>
 <609bac92-9567-6250-c728-76c1f69b8271@ozlabs.ru>
 <20170210030723.GG27610@umbus.fritz.box>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <55f38121-2cb1-9641-d837-a2facf6e9448@ozlabs.ru>
Date: Fri, 10 Feb 2017 15:09:30 +1100
MIME-Version: 1.0
In-Reply-To: <20170210030723.GG27610@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XSHlLEHkiUPNnwUULADbJcsnrouUWddLc"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XSHlLEHkiUPNnwUULADbJcsnrouUWddLc
Content-Type: multipart/mixed; boundary="5ruN2eM06VfE09bkXJ1TtoP3uW0Elheqd";
 protected-headers="v1"
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Message-ID: <55f38121-2cb1-9641-d837-a2facf6e9448@ozlabs.ru>
Subject: Re: [PATCH kernel v4 08/10] KVM: PPC: Separate TCE validation from
 update
References: <20170207071711.28938-1-aik@ozlabs.ru>
 <20170207071711.28938-9-aik@ozlabs.ru> <20170209035151.GA14524@umbus>
 <609bac92-9567-6250-c728-76c1f69b8271@ozlabs.ru>
 <20170210030723.GG27610@umbus.fritz.box>
In-Reply-To: <20170210030723.GG27610@umbus.fritz.box>

--5ruN2eM06VfE09bkXJ1TtoP3uW0Elheqd
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable

On 10/02/17 14:07, David Gibson wrote:
> On Thu, Feb 09, 2017 at 07:20:11PM +1100, Alexey Kardashevskiy wrote:
>> On 09/02/17 14:51, David Gibson wrote:
>>> On Tue, Feb 07, 2017 at 06:17:09PM +1100, Alexey Kardashevskiy wrote:=

>>>> For the emulated devices it does not matter much if we get a broken =
TCE
>>>> half way handling a TCE list but for VFIO it will matter as it has
>>>> more chances to fail so we try to do our best and check as much as w=
e
>>>> can before proceeding.
>>>>
>>>> This separates a guest view table update from validation. No change =
in
>>>> behavior is expected.
>>>>
>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>> ---
>>>>  arch/powerpc/kvm/book3s_64_vio.c    | 8 ++++++++
>>>>  arch/powerpc/kvm/book3s_64_vio_hv.c | 8 ++++++--
>>>>  2 files changed, 14 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/boo=
k3s_64_vio.c
>>>> index 15df8ae627d9..9a7b7fca5e84 100644
>>>> --- a/arch/powerpc/kvm/book3s_64_vio.c
>>>> +++ b/arch/powerpc/kvm/book3s_64_vio.c
>>>> @@ -282,6 +282,14 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu =
*vcpu,
>>>>  		ret =3D kvmppc_tce_validate(stt, tce);
>>>>  		if (ret !=3D H_SUCCESS)
>>>>  			goto unlock_exit;
>>>> +	}
>>>> +
>>>> +	for (i =3D 0; i < npages; ++i) {
>>>> +		if (get_user(tce, tces + i)) {
>>>> +			ret =3D H_TOO_HARD;
>>>> +			goto unlock_exit;
>>>> +		}
>>>> +		tce =3D be64_to_cpu(tce);
>>>
>>> This doesn't look safe.  The contents of user memory could change
>>> between the two get_user()s, meaning that you're no longer guaranteed=

>>> a TCE loaded into kernel has been validated at all.
>>>
>>> I think you need to either:
>>>
>>>     a) Make sure things safe against a bad TCE being loaded into a TC=
E
>>>     table and move all validation to where the TCE is used, rather
>>>     than loaded
>>>
>>> or
>>>     b) Copy the whole set of indirect entries to a temporary in-kerne=
l
>>>        buffer, then validate, then load into the actual TCE table.
>>
>>
>> Correct :( The problem is I do not know how far I want to go in revert=
ing
>> the state as it was when I started handling H_PUT_TCE_INDIRECT.
>>
>> For example, 1 container, 2 IOMMU groups with disabled shared tables, =
so -
>> 2 tables, 512 TCEs request and TCE#100 does not translate to host phys=
ical
>> address.
>>
>>
>> To do a) I'll need to remember old content of each hardware table entr=
y as
>> when I reach TCE#100, I'll need to revert to the initial state which m=
eans
>> I need to write back old TCEs to all affected hardware tables and upda=
te
>> reference counters of all affected preregistered areas. Well, the actu=
al
>> tables must not have different addresses (BUG_ON? is it worth testing =
while
>> writing to hardware tables that values I am replacing are the same in =
all
>> tables?) so I can have just a single array of old TCEs from hardware t=
ables
>> in vcpu.
>=20
> I thought you said shared tables were disabled, so the two tables
> would have different addresses?

That would be 2 physically separated tables but the content would be the
same as long as they belong to the same VFIO container.


>=20
> Hmm.  Now I'm trying to remember, will the gpa->hpa translation fail
> only if the guest/qemu does something wrong, or can it fail for other
> reasons?=20

This should always just work.

> What about in real mode vs. virtual mode?

Real mode is no different in this matter.

Real mode is different from virtual mode in 3 aspects:

1. iommu_table_ops::exchange() vs. exchange_rm() as real mode uses cache
inhibited writes to invalidate "TCE kill" cache;

2. list_for_each_entry_lockless() vs. list_for_each_entry_rct() because o=
f
lockdep does not work in real mode properly;

3. real mode uses vmalloc_to_phys() while virtual mode can access vmalloc=
'd
addresses directly. Not expected to fail.

This is a full list.


>=20
> I think the key to this approach will be to think carefully about what
> semantics you guarantee for mappings shadowed into the hardware
> tables.  For example, it might work to specify that the host mappings
> only match the GPA mappings if those GPA mapings are valid in the
> first place.  So, H_PUT_TCE etc. would succeed as long as they're able
> to update the view of the table in terms of GPA.  But when you shadow
> those into the HPA tables, any entries which can't be translated you
> just replace with a cleared entry.

Literally with zero? Silently? WARN_ON_ONCE?

> That should be enough to protect
> the host.  Obviously you can expect the device to fail when you
> actually attempt to DMA there, but that's the guest's (or qemu's) own
> fault for putting bad addresses in the TCE table.
>=20
> Obviously that might not be great for debugging, since mappings will
> appear to succeed, but then not work later on.
>=20
> This does have the nice property that it's reasonably obvious what to
> do if you have some GPA mappings for emulated devices, then hotplug a
> VFIO device and at that point hit a gpa->hpa translation error.
> There's no hcall in this case, so there's no obvious way to return an
> error to the guest.

Right. So if I do this, you would probably even ack this? :)


>=20
>> To do b) I'll need:
>>
>> 1. to have a copy of TCEs from the guest in vcpu,
>=20
> I don't quite understand this.  You need a temporary copy, yes, but I
> don't see why it needs to be attached to the vcpu.


It does not need, I just need a safe + static + lock-free place for it as=
 I
do not want to do malloc() in the TCE handlers and (in theory) multiple
CPUs can do concurrent TCE requests and I want to avoid locking especiall=
y
in realmode.


>> I populate it via
>> get_user() to make sure they won't change;
>> 2. an array of userspace addresses translated from given TCEs; and in =
order
>> to make sure these addresses won't go away, I'll need to reference eac=
h
>> preregistered memory area via mm_iommu_mapped_inc().
>>
>> When I reach TCE#100, I'll have to revert the change, i.e. call
>> mm_iommu_mapped_dec().
>=20
> Ugh.. yeah, I think to do this sanely, what you'd have to do is copy
> the updated translations into a temp buffer.  Then you'd to make more
> temp buffers to store the UA and HPA translations (although maybe you
> could overwrite/reuse the original temp buffer if you're careful).
> Then only if all of those succeed do you copy them into the real
> hardware tables.
>=20
> Which sounds like it might be kinda messy, at least in real mode.

So is it worth it?

>=20
>> So I will end up having 2 arrays in a vcpu and simpler reverting code.=

>>
>>
>> Or I can do simpler version of b) which would store guest TCEs in
>> kvm_vcpu_arch::tces[512] and use them after checking. If a malicious g=
uest
>> does something bad and I return from H_PUT_TCE_INDIRECT in a middle of=

>> request, some preregistered regions will stay referenced till the gues=
t is
>> killed or rebooted (and this will prevent memory from unregistering) -=
 but
>> this means no harm to the host;
>=20
> Hrm.. that's not really true.  It's not the worst thing that can
> happen, but allowing the guest to permanently lock extra chunks of
> memory is a form of harm to the host.


These are the same preregistered chunks which are already locked. And the=

lock is there till QEMU process is dead. What will not be possible is
memory hotunplug.


>=20
>> and with preregistered RAM, there is no
>> valid reason for H_PUT_TCE_INDIRECT to fail for a good guest.
>>
>>
>>
>> Which approach to pick?
>>
>>
>> LoPAPR says:
>> =3D=3D=3D
>> If the TCE parameter represents the logical page address of a page tha=
t is
>> not valid for the calling partition, return
>> H_Parameter.
>> =3D=3D=3D
>>
>>
>>
>>>> =20
>>>>  		kvmppc_tce_put(stt, entry + i, tce);
>>>>  	}
>>>> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/=
book3s_64_vio_hv.c
>>>> index 918af76ab2b6..f8a54b7c788e 100644
>>>> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
>>>> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
>>>> @@ -237,7 +237,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcp=
u *vcpu,
>>>>  {
>>>>  	struct kvmppc_spapr_tce_table *stt;
>>>>  	long i, ret =3D H_SUCCESS;
>>>> -	unsigned long tces, entry, ua =3D 0;
>>>> +	unsigned long tces, entry, tce, ua =3D 0;
>>>>  	unsigned long *rmap =3D NULL;
>>>> =20
>>>>  	stt =3D kvmppc_find_table(vcpu->kvm, liobn);
>>>> @@ -279,11 +279,15 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_v=
cpu *vcpu,
>>>>  	}
>>>> =20
>>>>  	for (i =3D 0; i < npages; ++i) {
>>>> -		unsigned long tce =3D be64_to_cpu(((u64 *)tces)[i]);
>>>> +		tce =3D be64_to_cpu(((u64 *)tces)[i]);
>>>> =20
>>>>  		ret =3D kvmppc_tce_validate(stt, tce);
>>>>  		if (ret !=3D H_SUCCESS)
>>>>  			goto unlock_exit;
>>>> +	}
>>>> +
>>>> +	for (i =3D 0; i < npages; ++i) {
>>>> +		tce =3D be64_to_cpu(((u64 *)tces)[i]);
>>>
>>> Same problem here.
>>>
>>>> =20
>>>>  		kvmppc_tce_put(stt, entry + i, tce);
>>>>  	}
>>>
>>
>>
>=20
>=20
>=20
>=20


--=20
Alexey


--5ruN2eM06VfE09bkXJ1TtoP3uW0Elheqd--

--XSHlLEHkiUPNnwUULADbJcsnrouUWddLc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJYnTz6DhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC56gYP/ibn
5LrygJ7u5yH8D4jBiAqXgKmBxk6/soxd1+5aTZXPjiBUJQP07W4CbFudWd3jj6wh
IcSay2Qy/+Wllo/UttxfEcEwI2d/EMR1yNgQiuMsIuB5ytzjmPXo4MeX3CrZ2FRA
2Ab7tLZPKLQrZ9+cy/E8X30d9Ch3rWMcRqDOhYTCTzvQck1lzFq63wwBGMlbxItO
fL7NzXZzcMgL4Sdj+YfIXSgthBTOCMkoynFXvjKSY6OdNlo+hzHauqfGZvnr7blt
2rmPYjQUyAckp3XJlY9Tpl+JfM+9g60+qYHIMv+BYNvIWz8avkqxOrWY5h/W58Sr
glq+sCT3ZFhQCAAyAhCNAt0lCWQmYF1WLoL0Pcml4pssVxE+MsOGnegn+/kbXspi
sQLQRPaKJOxpjGRC7qTGHlytRzweKaQTEdFWDBKCZYB1FKlbOLBnZw/TL1Y1nh4d
yNntqxK+x6qYd3ZZxoiKTJusX4Jf2zm7nHmq4nFbf1pwMJj/lTT0URHUjIKbdqv/
CslNUsiYoLGEcrqRffORr2dig9u4ypG+kENDT9RUvgoV+xP+25F8aITN0W+ptwNP
Twsmw9ixkopeXoSvFNWY57lqutdX2KaFGPYnpw7Jm20taTiSbtdQbrC2JOtHTWhj
lrH49KKMO5/mARChzUX0QgNtaL4NdioBSJox2Qpa
=4DPE
-----END PGP SIGNATURE-----

--XSHlLEHkiUPNnwUULADbJcsnrouUWddLc--
