Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJrc42w5gzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Feb 2017 19:20:20 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id e4so13323657pfg.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Feb 2017 00:20:20 -0800 (PST)
Subject: Re: [PATCH kernel v4 08/10] KVM: PPC: Separate TCE validation from
 update
To: David Gibson <david@gibson.dropbear.id.au>
References: <20170207071711.28938-1-aik@ozlabs.ru>
 <20170207071711.28938-9-aik@ozlabs.ru> <20170209035151.GA14524@umbus>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <609bac92-9567-6250-c728-76c1f69b8271@ozlabs.ru>
Date: Thu, 9 Feb 2017 19:20:11 +1100
MIME-Version: 1.0
In-Reply-To: <20170209035151.GA14524@umbus>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UlJDqwKkDw06utTXo2ClPcPNaeeFHxeeo"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UlJDqwKkDw06utTXo2ClPcPNaeeFHxeeo
Content-Type: multipart/mixed; boundary="tOm8uplWv3SwSXWIOphv1BLWWNCT0knh4";
 protected-headers="v1"
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Message-ID: <609bac92-9567-6250-c728-76c1f69b8271@ozlabs.ru>
Subject: Re: [PATCH kernel v4 08/10] KVM: PPC: Separate TCE validation from
 update
References: <20170207071711.28938-1-aik@ozlabs.ru>
 <20170207071711.28938-9-aik@ozlabs.ru> <20170209035151.GA14524@umbus>
In-Reply-To: <20170209035151.GA14524@umbus>

--tOm8uplWv3SwSXWIOphv1BLWWNCT0knh4
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable

On 09/02/17 14:51, David Gibson wrote:
> On Tue, Feb 07, 2017 at 06:17:09PM +1100, Alexey Kardashevskiy wrote:
>> For the emulated devices it does not matter much if we get a broken TC=
E
>> half way handling a TCE list but for VFIO it will matter as it has
>> more chances to fail so we try to do our best and check as much as we
>> can before proceeding.
>>
>> This separates a guest view table update from validation. No change in=

>> behavior is expected.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>  arch/powerpc/kvm/book3s_64_vio.c    | 8 ++++++++
>>  arch/powerpc/kvm/book3s_64_vio_hv.c | 8 ++++++--
>>  2 files changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3=
s_64_vio.c
>> index 15df8ae627d9..9a7b7fca5e84 100644
>> --- a/arch/powerpc/kvm/book3s_64_vio.c
>> +++ b/arch/powerpc/kvm/book3s_64_vio.c
>> @@ -282,6 +282,14 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *v=
cpu,
>>  		ret =3D kvmppc_tce_validate(stt, tce);
>>  		if (ret !=3D H_SUCCESS)
>>  			goto unlock_exit;
>> +	}
>> +
>> +	for (i =3D 0; i < npages; ++i) {
>> +		if (get_user(tce, tces + i)) {
>> +			ret =3D H_TOO_HARD;
>> +			goto unlock_exit;
>> +		}
>> +		tce =3D be64_to_cpu(tce);
>=20
> This doesn't look safe.  The contents of user memory could change
> between the two get_user()s, meaning that you're no longer guaranteed
> a TCE loaded into kernel has been validated at all.
>=20
> I think you need to either:
>=20
>     a) Make sure things safe against a bad TCE being loaded into a TCE
>     table and move all validation to where the TCE is used, rather
>     than loaded
>=20
> or
>     b) Copy the whole set of indirect entries to a temporary in-kernel
>        buffer, then validate, then load into the actual TCE table.


Correct :( The problem is I do not know how far I want to go in reverting=

the state as it was when I started handling H_PUT_TCE_INDIRECT.

For example, 1 container, 2 IOMMU groups with disabled shared tables, so =
-
2 tables, 512 TCEs request and TCE#100 does not translate to host physica=
l
address.


To do a) I'll need to remember old content of each hardware table entry a=
s
when I reach TCE#100, I'll need to revert to the initial state which mean=
s
I need to write back old TCEs to all affected hardware tables and update
reference counters of all affected preregistered areas. Well, the actual
tables must not have different addresses (BUG_ON? is it worth testing whi=
le
writing to hardware tables that values I am replacing are the same in all=

tables?) so I can have just a single array of old TCEs from hardware tabl=
es
in vcpu.


To do b) I'll need:

1. to have a copy of TCEs from the guest in vcpu, I populate it via
get_user() to make sure they won't change;
2. an array of userspace addresses translated from given TCEs; and in ord=
er
to make sure these addresses won't go away, I'll need to reference each
preregistered memory area via mm_iommu_mapped_inc().

When I reach TCE#100, I'll have to revert the change, i.e. call
mm_iommu_mapped_dec().

So I will end up having 2 arrays in a vcpu and simpler reverting code.


Or I can do simpler version of b) which would store guest TCEs in
kvm_vcpu_arch::tces[512] and use them after checking. If a malicious gues=
t
does something bad and I return from H_PUT_TCE_INDIRECT in a middle of
request, some preregistered regions will stay referenced till the guest i=
s
killed or rebooted (and this will prevent memory from unregistering) - bu=
t
this means no harm to the host; and with preregistered RAM, there is no
valid reason for H_PUT_TCE_INDIRECT to fail for a good guest.



Which approach to pick?


LoPAPR says:
=3D=3D=3D
If the TCE parameter represents the logical page address of a page that i=
s
not valid for the calling partition, return
H_Parameter.
=3D=3D=3D



>> =20
>>  		kvmppc_tce_put(stt, entry + i, tce);
>>  	}
>> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/bo=
ok3s_64_vio_hv.c
>> index 918af76ab2b6..f8a54b7c788e 100644
>> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
>> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
>> @@ -237,7 +237,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu =
*vcpu,
>>  {
>>  	struct kvmppc_spapr_tce_table *stt;
>>  	long i, ret =3D H_SUCCESS;
>> -	unsigned long tces, entry, ua =3D 0;
>> +	unsigned long tces, entry, tce, ua =3D 0;
>>  	unsigned long *rmap =3D NULL;
>> =20
>>  	stt =3D kvmppc_find_table(vcpu->kvm, liobn);
>> @@ -279,11 +279,15 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcp=
u *vcpu,
>>  	}
>> =20
>>  	for (i =3D 0; i < npages; ++i) {
>> -		unsigned long tce =3D be64_to_cpu(((u64 *)tces)[i]);
>> +		tce =3D be64_to_cpu(((u64 *)tces)[i]);
>> =20
>>  		ret =3D kvmppc_tce_validate(stt, tce);
>>  		if (ret !=3D H_SUCCESS)
>>  			goto unlock_exit;
>> +	}
>> +
>> +	for (i =3D 0; i < npages; ++i) {
>> +		tce =3D be64_to_cpu(((u64 *)tces)[i]);
>=20
> Same problem here.
>=20
>> =20
>>  		kvmppc_tce_put(stt, entry + i, tce);
>>  	}
>=20


--=20
Alexey


--tOm8uplWv3SwSXWIOphv1BLWWNCT0knh4--

--UlJDqwKkDw06utTXo2ClPcPNaeeFHxeeo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJYnCY7DhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5W3IQALpX
/HuY4XGOf+xGfDiJp4Dd1s8Q6FPjLtNyK0Yt5cCZzSDLIODDekDWLOZ57bQgO6EZ
Ihr1vFNc0yJtJpx1EYP1pVbQ4QbDzwxLY8NC0fKJqRqZ3pdeFavvNnMHm3VoWCfJ
MUJfFTPIadsh+9NJ4RD9/U6RA0vXywvEl2TBi+WBEOFReUrFEILcquYSIrbhrMhK
0wuYmlrSFO4nJ6EH1LH2PCP3fK/rYdoKUAp2PKpTMqAxFVb21JwBXGdYYRX3Al0H
TIYYAAuO1cbmh3bCViXBPTD0AvmqAJXaBFCW4Dcn9Pcm9+d9T2j749pfUdbT/gpK
47W8ckwfPs7gTWXPkas2QRpX+sF/6fSg7ZgCImfbz69xHND2vBKW8RceXJglKe3k
QqjTRxHeHoZg1k/c7GVAAvp9OkoCULwTBwelzuD0L+TlkH/S842XwTdw0kbjxwQ4
ImHv2R8P5Axl0zMgDXWY8Aie23SxX/2655TT0EEw3PBuTBUomgAgUa50Hr0FoMNA
P6IFOchp633PbQkYWuQH4zX1VB+b06v9EwMqpxrgdv/VJCO85qvAMEwd1iDj2VA3
HG7v5Iro+5y2Vo3ZRNPCocTw2s/mQ9rWW56zhpZhNBkrqChCaIAZKD8D2xdRC6t6
nWNtFAWlskcZAGmjTp9pldfFMH0yIyRdbIIL8MM1
=eYWN
-----END PGP SIGNATURE-----

--UlJDqwKkDw06utTXo2ClPcPNaeeFHxeeo--
