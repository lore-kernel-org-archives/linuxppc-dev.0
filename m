Return-Path: <B02008@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 08F342C0080
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2012 19:28:32 +1000 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: Alexander Graf <agraf@suse.de>
Subject: RE: [Qemu-ppc] [RFC PATCH 04/17] KVM: PPC64: booke: Add guest
 computation mode for irq delivery
Date: Thu, 5 Jul 2012 09:28:23 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF15AF3B@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
 <1340627195-11544-5-git-send-email-mihai.caraman@freescale.com>
 <E29E8A28-9993-4E6C-B41A-7C0AA51945F3@suse.de>
In-Reply-To: <E29E8A28-9993-4E6C-B41A-7C0AA51945F3@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
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

> -----Original Message-----
> From: Alexander Graf [mailto:agraf@suse.de]
> Sent: Wednesday, July 04, 2012 4:41 PM
> To: Caraman Mihai Claudiu-B02008
> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; qemu-ppc@nongnu.org
> Subject: Re: [Qemu-ppc] [RFC PATCH 04/17] KVM: PPC64: booke: Add guest
> computation mode for irq delivery
>=20
>=20
> On 25.06.2012, at 14:26, Mihai Caraman wrote:
>
> > Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> > ---
> > arch/powerpc/kvm/booke.c |    8 +++++++-
> > 1 files changed, 7 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> > index d15c4b5..93b48e0 100644
> > --- a/arch/powerpc/kvm/booke.c
> > +++ b/arch/powerpc/kvm/booke.c
> > @@ -287,6 +287,7 @@ static int kvmppc_booke_irqprio_deliver(struct
> kvm_vcpu *vcpu,
> > 	bool crit;
> > 	bool keep_irq =3D false;
> > 	enum int_class int_class;
> > +	ulong msr_cm =3D 0;
> >
> > 	/* Truncate crit indicators in 32 bit mode */
> > 	if (!(vcpu->arch.shared->msr & MSR_SF)) {
> > @@ -299,6 +300,10 @@ static int kvmppc_booke_irqprio_deliver(struct
> kvm_vcpu *vcpu,
> > 	/* ... and we're in supervisor mode */
> > 	crit =3D crit && !(vcpu->arch.shared->msr & MSR_PR);
> >
> > +#ifdef CONFIG_64BIT
> > +	msr_cm =3D vcpu->arch.epcr & SPRN_EPCR_ICM ? MSR_CM : 0;
> > +#endif
>=20
> No need for the ifdef, no?. Just mask EPCR_ICM out in the 32-bit host
> case, then this check is always false on 32-bit hosts.

It will break e500v2. epcr field is declared only for CONFIG_KVM_BOOKE_HV,
we can limit to this instead of CONFIG_64BIT.

-Mike
