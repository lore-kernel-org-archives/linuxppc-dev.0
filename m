Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 5EC5A2C0079
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 04:42:16 +1000 (EST)
Subject: Re: [PATCH 2/6] KVM: PPC: Book3E: Refactor SPE/FP exit handling
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1372876139.8183.135@snotra>
Date: Wed, 3 Jul 2013 20:42:12 +0200
Message-Id: <5BA99D8C-1B46-472C-97F7-4A174A39A6D7@suse.de>
References: <1372876139.8183.135@snotra>
To: Scott Wood <scottwood@freescale.com>
Cc: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
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


On 03.07.2013, at 20:28, Scott Wood wrote:

> On 07/03/2013 10:13:57 AM, Alexander Graf wrote:
>> On 03.07.2013, at 15:53, Caraman Mihai Claudiu-B02008 wrote:
>> >>> -#ifdef CONFIG_SPE
>> >>> 	case BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL: {
>> >>> -		if (vcpu->arch.shared->msr & MSR_SPE)
>> >>> -			kvmppc_vcpu_enable_spe(vcpu);
>> >>> -		else
>> >>> -			kvmppc_booke_queue_irqprio(vcpu,
>> >>> -
>> >> BOOKE_IRQPRIO_SPE_ALTIVEC_UNAVAIL);
>> >>> +		if (kvmppc_supports_spe()) {
>> >>> +			bool enabled =3D false;
>> >>> +
>> >>> +#ifndef CONFIG_KVM_BOOKE_HV
>> >>> +			if (vcpu->arch.shared->msr & MSR_SPE) {
>> >>> +				kvmppc_vcpu_enable_spe(vcpu);
>> >>> +				enabled =3D true;
>> >>> +			}
>> >>> +#endif
>> >>
>> >> Why the #ifdef? On HV capable systems kvmppc_supports_spe() will =
just
>> >> always return false.
>> >
>> > AltiVec and SPE unavailable exceptions follows the same path. While
>> > kvmppc_supports_spe() will always return false =
kvmppc_supports_altivec()
>> > may not.
>> There is no chip that supports SPE and HV at the same time. So we'll =
never hit this anyway, since kvmppc_supports_spe() always returns false =
on HV capable systems.
>> Just add a comment saying so and remove the ifdef :).
>=20
> kvmppc_vcpu_enable_spe isn't defined unless CONFIG_SPE is defined.  =
More seriously, MSR_SPE is the same as MSR_VEC, so we shouldn't =
interpret it as SPE unless CONFIG_SPE is defined.  And we can't rely on =
the "if (kvmppc_supports_spe())" here because a later patch changes it =
to "if (kvmppc_supports_altivec() || kvmppc_supports_spe())".  So I =
think we still need the ifdef CONFIG_SPE here.
>=20
> As for the HV ifndef, we should try not to confuse HV/PR with =
e500mc/e500v2, even if we happen to only run HV on e500mc and PR on =
e500v2.  We would not want to call kvmppc_vcpu_enable_spe() here on a =
hypothetical HV target with SPE.  And we *would* want to call =
kvmppc_vcpu_enable_fp() here on a hypothetical PR target with normal FP. =
 It's one thing to leave out the latter, since it would involve writing =
actual code that we have no way to test at this point, but quite another =
to leave out the proper conditions for when we want to run code that we =
do have.

So we should make this an #ifdef CONFIG_SPE rather than #ifndef =
CONFIG_KVM_BOOKE_HV?


Alex
