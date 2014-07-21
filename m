Return-Path: <mihai.caraman@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0204.outbound.protection.outlook.com [207.46.163.204])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43EB51A0004
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jul 2014 23:23:42 +1000 (EST)
From: "mihai.caraman@freescale.com" <mihai.caraman@freescale.com>
To: Alexander Graf <agraf@suse.de>, Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH 1/6 v2] KVM: PPC: Book3E: Use common defines for
 SPE/FP/AltiVec int numbers
Date: Mon, 21 Jul 2014 13:23:26 +0000
Message-ID: <767ce3456f6f40809a1488b4df90498d@BLUPR03MB503.namprd03.prod.outlook.com>
References: <1404142497-6430-1-git-send-email-mihai.caraman@freescale.com>
 <1404142497-6430-2-git-send-email-mihai.caraman@freescale.com>
 <53B54AAD.4040609@suse.de>
In-Reply-To: <53B54AAD.4040609@suse.de>
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

> -----Original Message-----
> From: Alexander Graf [mailto:agraf@suse.de]
> Sent: Thursday, July 03, 2014 3:21 PM
> To: Caraman Mihai Claudiu-B02008; kvm-ppc@vger.kernel.org
> Cc: kvm@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH 1/6 v2] KVM: PPC: Book3E: Use common defines for
> SPE/FP/AltiVec int numbers
>=20
>=20
> On 30.06.14 17:34, Mihai Caraman wrote:
> > Use common BOOKE_IRQPRIO and BOOKE_INTERRUPT defines for SPE/FP/AltiVec
> > which share the same interrupt numbers.
> >
> > Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> > ---
> > v2:
> >   - remove outdated definitions
> >
> >   arch/powerpc/include/asm/kvm_asm.h    |  8 --------
> >   arch/powerpc/kvm/booke.c              | 17 +++++++++--------
> >   arch/powerpc/kvm/booke.h              |  4 ++--
> >   arch/powerpc/kvm/booke_interrupts.S   |  9 +++++----
> >   arch/powerpc/kvm/bookehv_interrupts.S |  4 ++--
> >   arch/powerpc/kvm/e500.c               | 10 ++++++----
> >   arch/powerpc/kvm/e500_emulate.c       | 10 ++++++----
> >   7 files changed, 30 insertions(+), 32 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/kvm_asm.h
> b/arch/powerpc/include/asm/kvm_asm.h
> > index 9601741..c94fd33 100644
> > --- a/arch/powerpc/include/asm/kvm_asm.h
> > +++ b/arch/powerpc/include/asm/kvm_asm.h
> > @@ -56,14 +56,6 @@
> >   /* E500 */
> >   #define BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL 32
> >   #define BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST 33
> > -/*
> > - * TODO: Unify 32-bit and 64-bit kernel exception handlers to use same
> defines
> > - */
> > -#define BOOKE_INTERRUPT_SPE_UNAVAIL
> BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL
> > -#define BOOKE_INTERRUPT_SPE_FP_DATA
> BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST
> > -#define BOOKE_INTERRUPT_ALTIVEC_UNAVAIL
> BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL
> > -#define BOOKE_INTERRUPT_ALTIVEC_ASSIST \
> > -				BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST
>=20
> I think I'd prefer to keep them separate.
>=20
> >   #define BOOKE_INTERRUPT_SPE_FP_ROUND 34
> >   #define BOOKE_INTERRUPT_PERFORMANCE_MONITOR 35
> >   #define BOOKE_INTERRUPT_DOORBELL 36
> > diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> > index ab62109..3c86d9b 100644
> > --- a/arch/powerpc/kvm/booke.c
> > +++ b/arch/powerpc/kvm/booke.c
> > @@ -388,8 +388,8 @@ static int kvmppc_booke_irqprio_deliver(struct
> kvm_vcpu *vcpu,
> >   	case BOOKE_IRQPRIO_ITLB_MISS:
> >   	case BOOKE_IRQPRIO_SYSCALL:
> >   	case BOOKE_IRQPRIO_FP_UNAVAIL:
> > -	case BOOKE_IRQPRIO_SPE_UNAVAIL:
> > -	case BOOKE_IRQPRIO_SPE_FP_DATA:
> > +	case BOOKE_IRQPRIO_SPE_ALTIVEC_UNAVAIL:
> > +	case BOOKE_IRQPRIO_SPE_FP_DATA_ALTIVEC_ASSIST:
>=20
> #ifdef CONFIG_KVM_E500V2
>    case ...SPE:
> #else
>    case ..ALTIVEC:
> #endif
>=20
> >   	case BOOKE_IRQPRIO_SPE_FP_ROUND:
> >   	case BOOKE_IRQPRIO_AP_UNAVAIL:
> >   		allowed =3D 1;
> > @@ -977,18 +977,19 @@ int kvmppc_handle_exit(struct kvm_run *run,
> struct kvm_vcpu *vcpu,
> >   		break;
> >
> >   #ifdef CONFIG_SPE
> > -	case BOOKE_INTERRUPT_SPE_UNAVAIL: {
> > +	case BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL: {
> >   		if (vcpu->arch.shared->msr & MSR_SPE)
> >   			kvmppc_vcpu_enable_spe(vcpu);
> >   		else
> >   			kvmppc_booke_queue_irqprio(vcpu,
> > -						   BOOKE_IRQPRIO_SPE_UNAVAIL);
> > +				BOOKE_IRQPRIO_SPE_ALTIVEC_UNAVAIL);
> >   		r =3D RESUME_GUEST;
> >   		break;
> >   	}
> >
> > -	case BOOKE_INTERRUPT_SPE_FP_DATA:
> > -		kvmppc_booke_queue_irqprio(vcpu, BOOKE_IRQPRIO_SPE_FP_DATA);
> > +	case BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST:
> > +		kvmppc_booke_queue_irqprio(vcpu,
> > +			BOOKE_IRQPRIO_SPE_FP_DATA_ALTIVEC_ASSIST);
> >   		r =3D RESUME_GUEST;
> >   		break;
> >
> > @@ -997,7 +998,7 @@ int kvmppc_handle_exit(struct kvm_run *run, struct
> kvm_vcpu *vcpu,
> >   		r =3D RESUME_GUEST;
> >   		break;
> >   #else
> > -	case BOOKE_INTERRUPT_SPE_UNAVAIL:
> > +	case BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL:
> >   		/*
> >   		 * Guest wants SPE, but host kernel doesn't support it.  Send
> >   		 * an "unimplemented operation" program check to the guest.
> > @@ -1010,7 +1011,7 @@ int kvmppc_handle_exit(struct kvm_run *run,
> struct kvm_vcpu *vcpu,
> >   	 * These really should never happen without CONFIG_SPE,
> >   	 * as we should never enable the real MSR[SPE] in the guest.
> >   	 */
> > -	case BOOKE_INTERRUPT_SPE_FP_DATA:
> > +	case BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST:
> >   	case BOOKE_INTERRUPT_SPE_FP_ROUND:
> >   		printk(KERN_CRIT "%s: unexpected SPE interrupt %u at
> %08lx\n",
> >   		       __func__, exit_nr, vcpu->arch.pc);
> > diff --git a/arch/powerpc/kvm/booke.h b/arch/powerpc/kvm/booke.h
> > index b632cd3..f182b32 100644
> > --- a/arch/powerpc/kvm/booke.h
> > +++ b/arch/powerpc/kvm/booke.h
> > @@ -32,8 +32,8 @@
> >   #define BOOKE_IRQPRIO_ALIGNMENT 2
> >   #define BOOKE_IRQPRIO_PROGRAM 3
> >   #define BOOKE_IRQPRIO_FP_UNAVAIL 4
> > -#define BOOKE_IRQPRIO_SPE_UNAVAIL 5
> > -#define BOOKE_IRQPRIO_SPE_FP_DATA 6
> > +#define BOOKE_IRQPRIO_SPE_ALTIVEC_UNAVAIL 5
> > +#define BOOKE_IRQPRIO_SPE_FP_DATA_ALTIVEC_ASSIST 6
>=20
> #ifdef CONFIG_KVM_E500V2
> #define ...SPE...
> #else
> #define ...ALTIVEC...
> #endif
>=20
> That way we can be 100% sure that no SPE cruft leaks into anything.
>=20
>=20
> >   #define BOOKE_IRQPRIO_SPE_FP_ROUND 7
> >   #define BOOKE_IRQPRIO_SYSCALL 8
> >   #define BOOKE_IRQPRIO_AP_UNAVAIL 9
> > diff --git a/arch/powerpc/kvm/booke_interrupts.S
> b/arch/powerpc/kvm/booke_interrupts.S
> > index 2c6deb5ef..a275dc5 100644
> > --- a/arch/powerpc/kvm/booke_interrupts.S
> > +++ b/arch/powerpc/kvm/booke_interrupts.S
> > @@ -137,8 +137,9 @@ KVM_HANDLER BOOKE_INTERRUPT_WATCHDOG
> SPRN_SPRG_RSCRATCH_CRIT SPRN_CSRR0
> >   KVM_HANDLER BOOKE_INTERRUPT_DTLB_MISS SPRN_SPRG_RSCRATCH0 SPRN_SRR0
> >   KVM_HANDLER BOOKE_INTERRUPT_ITLB_MISS SPRN_SPRG_RSCRATCH0 SPRN_SRR0
> >   KVM_DBG_HANDLER BOOKE_INTERRUPT_DEBUG SPRN_SPRG_RSCRATCH_CRIT
> SPRN_CSRR0
> > -KVM_HANDLER BOOKE_INTERRUPT_SPE_UNAVAIL SPRN_SPRG_RSCRATCH0 SPRN_SRR0
> > -KVM_HANDLER BOOKE_INTERRUPT_SPE_FP_DATA SPRN_SPRG_RSCRATCH0 SPRN_SRR0
> > +KVM_HANDLER BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL SPRN_SPRG_RSCRATCH0
> SPRN_SRR0
> > +KVM_HANDLER BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST
> SPRN_SPRG_RSCRATCH0 \
> > +	SPRN_SRR0
>=20
> Same thing here - just only trap SPE when CONFIG_KVM_E500V2 is available
> and trap altivec otherwise (to make sure we always have a handler).

This will not even build with current kernel. 32-bit FSL kernel defines SPE
handlers for e500v2/e500mc/e5500 (see head_fsl_booke.S which is guarded by
CONFIG_FSL_BOOKE) even when CONFIG_SPE is not defined. This is simple to
verify by removing KVM's HV 32-bit BOOKE_INTERRUPT_SPE_xxx handlers from
bookehv_interrupts.S.

The kernel equivalent of your CONFIG_KVM_E500V2 suggestion looks like this:

#ifndef CONFIG_PPC_E500MC
/* e500v2 */
#define BOOKE_INTERRUPT_SPE_UNAVAIL 32
#define BOOKE_INTERRUPT_SPE_FP_DATA 33
#define BOOKE_INTERRUPT_SPE_FP_ROUND 34
#elif
/* e500mc, e5500, e6500 */
#define BOOKE_INTERRUPT_ALTIVEC_UNAVAIL 32
#define BOOKE_INTERRUPT_ALTIVEC_ASSIST BOOKE_33
#endif

but instead, the current kernel expects something like this:

#ifdef CONFIG_FSL_BOOKE
/* 32-bit targets: e500v2, e500mc, e5500 */
#define BOOKE_INTERRUPT_SPE_UNAVAIL 32
#define BOOKE_INTERRUPT_SPE_FP_DATA 33
#define BOOKE_INTERRUPT_SPE_FP_ROUND 34
#elif CONFIG_PPC_BOOK3E_64
/* 64-bit targets: e5500, e6500 */
#define BOOKE_INTERRUPT_ALTIVEC_UNAVAIL 32
#define BOOKE_INTERRUPT_ALTIVEC_ASSIST BOOKE_33
#endif

We can guard kernel SPE handlers with !CONFIG_PPC_E500MC to have
something like:

#ifdef CONFIG_FSL_BOOKE
#ifndef CONFIG_PPC_E500MC
/* e500v2 */
#define BOOKE_INTERRUPT_SPE_UNAVAIL 32
#define BOOKE_INTERRUPT_SPE_FP_DATA 33
#define BOOKE_INTERRUPT_SPE_FP_ROUND 34
#endif
#elif CONFIG_PPC_BOOK3E_64
/* e5500, e6500 */
#define BOOKE_INTERRUPT_ALTIVEC_UNAVAIL 32
#define BOOKE_INTERRUPT_ALTIVEC_ASSIST BOOKE_33
#endif

My suggestion is to go ahead with KVM AltiVec patches without waiting for
this kernel cleanup. I will do the KVM synchronization later when you will
have these kernel changes in your tree.

Scott, do you agree to guard SPE kernel handlers in head_fsl_booke.S with
!CONFIG_PPC_E500MC?

-Mike
=20
>=20
> Alex
