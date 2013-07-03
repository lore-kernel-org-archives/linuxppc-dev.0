Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 66C482C0312
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 01:14:01 +1000 (EST)
Subject: Re: [PATCH 2/6] KVM: PPC: Book3E: Refactor SPE/FP exit handling
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <300B73AA675FCE4A93EB4FC1D42459FF0A2A3893@039-SN2MPN1-013.039d.mgd.msft.net>
Date: Wed, 3 Jul 2013 17:13:57 +0200
Message-Id: <4C6EF5E2-013B-4EA7-8DDC-586BF8FBE741@suse.de>
References: <1372855359-13452-1-git-send-email-mihai.caraman@freescale.com>
 <1372855359-13452-3-git-send-email-mihai.caraman@freescale.com>
 <97D96A79-E1E8-47FE-82DB-378AD7869C61@suse.de>
 <300B73AA675FCE4A93EB4FC1D42459FF0A2A3893@039-SN2MPN1-013.039d.mgd.msft.net>
To: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 03.07.2013, at 15:53, Caraman Mihai Claudiu-B02008 wrote:

>>> -#ifdef CONFIG_SPE
>>> 	case BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL: {
>>> -		if (vcpu->arch.shared->msr & MSR_SPE)
>>> -			kvmppc_vcpu_enable_spe(vcpu);
>>> -		else
>>> -			kvmppc_booke_queue_irqprio(vcpu,
>>> -
>> BOOKE_IRQPRIO_SPE_ALTIVEC_UNAVAIL);
>>> +		if (kvmppc_supports_spe()) {
>>> +			bool enabled =3D false;
>>> +
>>> +#ifndef CONFIG_KVM_BOOKE_HV
>>> +			if (vcpu->arch.shared->msr & MSR_SPE) {
>>> +				kvmppc_vcpu_enable_spe(vcpu);
>>> +				enabled =3D true;
>>> +			}
>>> +#endif
>>=20
>> Why the #ifdef? On HV capable systems kvmppc_supports_spe() will just
>> always return false.=20
>=20
> AltiVec and SPE unavailable exceptions follows the same path. While=20
> kvmppc_supports_spe() will always return false =
kvmppc_supports_altivec()
> may not.

There is no chip that supports SPE and HV at the same time. So we'll =
never hit this anyway, since kvmppc_supports_spe() always returns false =
on HV capable systems.

Just add a comment saying so and remove the ifdef :).


Alex

>=20
>> And I don't really understand why HV would be special in the first =
place
>> here. Is it because we're accessing shared->msr?
>=20
> You are right on HV case MSP[SPV] should be always zero when an =
unavailabe
> exception take place. The distrinction was made because on non HV the =
guest
> doesn't have direct access to MSR[SPE]. The name of the bit (not the =
position)
> was changed on HV cores.
>=20
>>=20
>>> +			if (!enabled)
>>> +				kvmppc_booke_queue_irqprio(vcpu,
>>> +					=
BOOKE_IRQPRIO_SPE_ALTIVEC_UNAVAIL);
>>> +		} else {
>>> +			/*
>>> +			 * Guest wants SPE, but host kernel doesn't =
support it.
>>=20
>> host kernel or hardware
>=20
> Ok.
>=20
> -Mike
>=20
