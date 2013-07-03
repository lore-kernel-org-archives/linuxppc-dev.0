Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0188.outbound.messaging.microsoft.com [213.199.154.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A660B2C0085
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 04:29:12 +1000 (EST)
Date: Wed, 3 Jul 2013 13:28:59 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/6] KVM: PPC: Book3E: Refactor SPE/FP exit handling
To: Alexander Graf <agraf@suse.de>
In-Reply-To: <4C6EF5E2-013B-4EA7-8DDC-586BF8FBE741@suse.de> (from
 agraf@suse.de on Wed Jul  3 10:13:57 2013)
Message-ID: <1372876139.8183.135@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
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

  On 07/03/2013 10:13:57 AM, Alexander Graf wrote:
>=20
> On 03.07.2013, at 15:53, Caraman Mihai Claudiu-B02008 wrote:
>=20
> >>> -#ifdef CONFIG_SPE
> >>> 	case BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL: {
> >>> -		if (vcpu->arch.shared->msr & MSR_SPE)
> >>> -			kvmppc_vcpu_enable_spe(vcpu);
> >>> -		else
> >>> -			kvmppc_booke_queue_irqprio(vcpu,
> >>> -
> >> BOOKE_IRQPRIO_SPE_ALTIVEC_UNAVAIL);
> >>> +		if (kvmppc_supports_spe()) {
> >>> +			bool enabled =3D false;
> >>> +
> >>> +#ifndef CONFIG_KVM_BOOKE_HV
> >>> +			if (vcpu->arch.shared->msr & MSR_SPE) {
> >>> +				kvmppc_vcpu_enable_spe(vcpu);
> >>> +				enabled =3D true;
> >>> +			}
> >>> +#endif
> >>
> >> Why the #ifdef? On HV capable systems kvmppc_supports_spe() will =20
> just
> >> always return false.
> >
> > AltiVec and SPE unavailable exceptions follows the same path. While
> > kvmppc_supports_spe() will always return false =20
> kvmppc_supports_altivec()
> > may not.
>=20
> There is no chip that supports SPE and HV at the same time. So we'll =20
> never hit this anyway, since kvmppc_supports_spe() always returns =20
> false on HV capable systems.
>=20
> Just add a comment saying so and remove the ifdef :).

kvmppc_vcpu_enable_spe isn't defined unless CONFIG_SPE is defined.  =20
More seriously, MSR_SPE is the same as MSR_VEC, so we shouldn't =20
interpret it as SPE unless CONFIG_SPE is defined.  And we can't rely on =20
the "if (kvmppc_supports_spe())" here because a later patch changes it =20
to "if (kvmppc_supports_altivec() || kvmppc_supports_spe())".  So I =20
think we still need the ifdef CONFIG_SPE here.

As for the HV ifndef, we should try not to confuse HV/PR with =20
e500mc/e500v2, even if we happen to only run HV on e500mc and PR on =20
e500v2.  We would not want to call kvmppc_vcpu_enable_spe() here on a =20
hypothetical HV target with SPE.  And we *would* want to call =20
kvmppc_vcpu_enable_fp() here on a hypothetical PR target with normal =20
FP.  It's one thing to leave out the latter, since it would involve =20
writing actual code that we have no way to test at this point, but =20
quite another to leave out the proper conditions for when we want to =20
run code that we do have.

-Scott=
