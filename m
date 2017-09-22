Return-Path: <pbonzini@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xz8tt17qRzDsMk
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 20:32:38 +1000 (AEST)
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Check for updated HDSISR on P9 HDSI
 exception
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Michael Neuling <mikey@neuling.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 benh@kernel.crashing.org
References: <20170915052614.8231-1-mikey@neuling.org>
 <db59a8c7-30e7-08a1-ad57-45b9a631920e@redhat.com>
 <20170922103040.GK4998@umbus.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4220ec45-248b-3561-8740-0b794b51e194@redhat.com>
Date: Fri, 22 Sep 2017 12:32:26 +0200
MIME-Version: 1.0
In-Reply-To: <20170922103040.GK4998@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="A2U6Fx8qMOHAbDlcjHcuW6LwadlvhUGXc"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--A2U6Fx8qMOHAbDlcjHcuW6LwadlvhUGXc
Content-Type: multipart/mixed; boundary="V0hGH4V6gJdV6J8jaBa8u94nFHqvd2eEQ";
 protected-headers="v1"
From: Paolo Bonzini <pbonzini@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Michael Neuling <mikey@neuling.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 benh@kernel.crashing.org
Message-ID: <4220ec45-248b-3561-8740-0b794b51e194@redhat.com>
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Check for updated HDSISR on P9 HDSI
 exception
References: <20170915052614.8231-1-mikey@neuling.org>
 <db59a8c7-30e7-08a1-ad57-45b9a631920e@redhat.com>
 <20170922103040.GK4998@umbus.fritz.box>
In-Reply-To: <20170922103040.GK4998@umbus.fritz.box>

--V0hGH4V6gJdV6J8jaBa8u94nFHqvd2eEQ
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22/09/2017 12:30, David Gibson wrote:
> On Fri, Sep 22, 2017 at 10:46:36AM +0200, Paolo Bonzini wrote:
>> On 15/09/2017 07:26, Michael Neuling wrote:
>>> On POWER9 DD2.1 and below, sometimes on a Hypervisor Data Storage
>>> Interrupt (HDSI) the HDSISR is not be updated at all.
>>>
>>> To work around this we put a canary value into the HDSISR before
>>> returning to a guest and then check for this canary when we take a
>>> HDSI. If we find the canary on a HDSI, we know the hardware didn't
>>> update the HDSISR. In this case we return to the guest to retake the
>>> HDSI which should correctly update the HDSISR the second time HDSI
>>> entry.
>>>
>>> After talking to Paulus we've applied this workaround to all POWER9
>>> CPUs. The workaround of returning to the guest shouldn't ever be
>>> triggered on well behaving CPU. The extra instructions should have
>>> negligible performance impact.
>>>
>>> Signed-off-by: Michael Neuling <mikey@neuling.org>
>>> ---
>>>  arch/powerpc/kvm/book3s_hv_rmhandlers.S | 14 +++++++++++++-
>>>  1 file changed, 13 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/k=
vm/book3s_hv_rmhandlers.S
>>> index 663a4a861e..70dca60569 100644
>>> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
>>> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
>>> @@ -1118,6 +1118,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
>>>  BEGIN_FTR_SECTION
>>>  	mtspr	SPRN_PPR, r0
>>>  END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
>>> +
>>> +/* Move canary into DSISR to check for later */
>>> +BEGIN_FTR_SECTION
>>> +	li	r0, 0x7fff
>>> +	mtspr	SPRN_HDSISR, r0
>>> +END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
>>> +
>>>  	ld	r0, VCPU_GPR(R0)(r4)
>>>  	ld	r4, VCPU_GPR(R4)(r4)
>>> =20
>>> @@ -1947,9 +1954,14 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_RADIX)
>>>  kvmppc_hdsi:
>>>  	ld	r3, VCPU_KVM(r9)
>>>  	lbz	r0, KVM_RADIX(r3)
>>> -	cmpwi	r0, 0
>>>  	mfspr	r4, SPRN_HDAR
>>>  	mfspr	r6, SPRN_HDSISR
>>> +BEGIN_FTR_SECTION
>>> +	/* Look for DSISR canary. If we find it, retry instruction */
>>> +	cmpdi	r6, 0x7fff
>>> +	beq	6f
>>> +END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
>>> +	cmpwi	r0, 0
>>>  	bne	.Lradix_hdsi		/* on radix, just save DAR/DSISR/ASDR */
>>>  	/* HPTE not found fault or protection fault? */
>>>  	andis.	r0, r6, (DSISR_NOHPTE | DSISR_PROTFAULT)@h
>>>
>>
>> Applied to kvm/master, thanks.
>=20
> I'm not seeing it; have you pushed out the tree?

No, not yet (doing some tests).

Paolo



--V0hGH4V6gJdV6J8jaBa8u94nFHqvd2eEQ--

--A2U6Fx8qMOHAbDlcjHcuW6LwadlvhUGXc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlnE5rsACgkQv/vSX3jH
roOo4wf9HSe3+Oj5I/cIRKJ4YTaLQMhZNkPG3KurOxKW10ZkhXiwATuSgQW2jRe+
mWLvJRB+ph4eyIwL4tXMnVTm+3t1ILw529F3vRPKLbKD/4rAeknCwqnn33RXWU0Z
ei+s+7eAjlyeoy9/99gbyyEt+ssC4RmlLie4nqbvPlDFZ6wsOVVZfNpgS4GZoGJ6
Y+IRvk1gi/Z1gum6BXGAUyhNEyNnFwVmTKV1DVxtJopPjxSVyclLTCJngEjQpVQL
gHY2nAzvt/hY+WeSfKIwVjwsQAg/eT9vNTMfxOXnFszamyeXlqKYtwzxaUhnHIW4
20agzsUvmZIf+D96DPzfYUl5zCVq0g==
=a/X2
-----END PGP SIGNATURE-----

--A2U6Fx8qMOHAbDlcjHcuW6LwadlvhUGXc--
