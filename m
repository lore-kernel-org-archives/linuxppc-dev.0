Return-Path: <B02008@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B3A482C008F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 23:53:59 +1000 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: Alexander Graf <agraf@suse.de>
Subject: RE: [PATCH 2/6] KVM: PPC: Book3E: Refactor SPE/FP exit handling
Date: Wed, 3 Jul 2013 13:53:49 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF0A2A3893@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1372855359-13452-1-git-send-email-mihai.caraman@freescale.com>
 <1372855359-13452-3-git-send-email-mihai.caraman@freescale.com>
 <97D96A79-E1E8-47FE-82DB-378AD7869C61@suse.de>
In-Reply-To: <97D96A79-E1E8-47FE-82DB-378AD7869C61@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
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

> > -#ifdef CONFIG_SPE
> > 	case BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL: {
> > -		if (vcpu->arch.shared->msr & MSR_SPE)
> > -			kvmppc_vcpu_enable_spe(vcpu);
> > -		else
> > -			kvmppc_booke_queue_irqprio(vcpu,
> > -
> BOOKE_IRQPRIO_SPE_ALTIVEC_UNAVAIL);
> > +		if (kvmppc_supports_spe()) {
> > +			bool enabled =3D false;
> > +
> > +#ifndef CONFIG_KVM_BOOKE_HV
> > +			if (vcpu->arch.shared->msr & MSR_SPE) {
> > +				kvmppc_vcpu_enable_spe(vcpu);
> > +				enabled =3D true;
> > +			}
> > +#endif
>=20
> Why the #ifdef? On HV capable systems kvmppc_supports_spe() will just
> always return false.=20

AltiVec and SPE unavailable exceptions follows the same path. While=20
kvmppc_supports_spe() will always return false kvmppc_supports_altivec()
may not.

> And I don't really understand why HV would be special in the first place
> here. Is it because we're accessing shared->msr?

You are right on HV case MSP[SPV] should be always zero when an unavailabe
exception take place. The distrinction was made because on non HV the guest
doesn't have direct access to MSR[SPE]. The name of the bit (not the positi=
on)
was changed on HV cores.

>=20
> > +			if (!enabled)
> > +				kvmppc_booke_queue_irqprio(vcpu,
> > +					BOOKE_IRQPRIO_SPE_ALTIVEC_UNAVAIL);
> > +		} else {
> > +			/*
> > +			 * Guest wants SPE, but host kernel doesn't support it.
>=20
> host kernel or hardware

Ok.

-Mike
