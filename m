Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0181.outbound.protection.outlook.com [207.46.163.181])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 332211A0005
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jul 2014 08:15:34 +1000 (EST)
Message-ID: <1404425722.21434.93.camel@snotra.buserror.net>
Subject: Re: [PATCH 1/6 v2] KVM: PPC: Book3E: Use common defines for
 SPE/FP/AltiVec int numbers
From: Scott Wood <scottwood@freescale.com>
To: Caraman Mihai Claudiu-B02008 <mihai.caraman@freescale.com>
Date: Thu, 3 Jul 2014 17:15:22 -0500
In-Reply-To: <2399bd1f8fde430a945311ff27c3f5c3@BY2PR03MB508.namprd03.prod.outlook.com>
References: <1404142497-6430-1-git-send-email-mihai.caraman@freescale.com>
 <1404142497-6430-2-git-send-email-mihai.caraman@freescale.com>
 <53B54AAD.4040609@suse.de>
 <2399bd1f8fde430a945311ff27c3f5c3@BY2PR03MB508.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Alexander Graf <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-07-03 at 10:25 -0500, Caraman Mihai Claudiu-B02008 wrote:
> > -----Original Message-----
> > From: Alexander Graf [mailto:agraf@suse.de]
> > Sent: Thursday, July 03, 2014 3:21 PM
> > To: Caraman Mihai Claudiu-B02008; kvm-ppc@vger.kernel.org
> > Cc: kvm@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [PATCH 1/6 v2] KVM: PPC: Book3E: Use common defines for
> > SPE/FP/AltiVec int numbers
> > 
> > 
> > On 30.06.14 17:34, Mihai Caraman wrote:
> > > Use common BOOKE_IRQPRIO and BOOKE_INTERRUPT defines for SPE/FP/AltiVec
> > > which share the same interrupt numbers.
> > >
> > > Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> > > ---
> > > v2:
> > >   - remove outdated definitions
> > >
> > >   arch/powerpc/include/asm/kvm_asm.h    |  8 --------
> > >   arch/powerpc/kvm/booke.c              | 17 +++++++++--------
> > >   arch/powerpc/kvm/booke.h              |  4 ++--
> > >   arch/powerpc/kvm/booke_interrupts.S   |  9 +++++----
> > >   arch/powerpc/kvm/bookehv_interrupts.S |  4 ++--
> > >   arch/powerpc/kvm/e500.c               | 10 ++++++----
> > >   arch/powerpc/kvm/e500_emulate.c       | 10 ++++++----
> > >   7 files changed, 30 insertions(+), 32 deletions(-)
> > >
> > > diff --git a/arch/powerpc/include/asm/kvm_asm.h
> > b/arch/powerpc/include/asm/kvm_asm.h
> > > index 9601741..c94fd33 100644
> > > --- a/arch/powerpc/include/asm/kvm_asm.h
> > > +++ b/arch/powerpc/include/asm/kvm_asm.h
> > > @@ -56,14 +56,6 @@
> > >   /* E500 */
> > >   #define BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL 32
> > >   #define BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST 33
> > > -/*
> > > - * TODO: Unify 32-bit and 64-bit kernel exception handlers to use same
> > defines
> > > - */
> > > -#define BOOKE_INTERRUPT_SPE_UNAVAIL
> > BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL
> > > -#define BOOKE_INTERRUPT_SPE_FP_DATA
> > BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST
> > > -#define BOOKE_INTERRUPT_ALTIVEC_UNAVAIL
> > BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL
> > > -#define BOOKE_INTERRUPT_ALTIVEC_ASSIST \
> > > -				BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST
> > 
> > I think I'd prefer to keep them separate.
> 
> What is the reason from changing your mind from ver 1? Do you want to have
> different defines with same values (we specifically mapped them to the
> hardware interrupt numbers). We already upstreamed the necessary changes
> in the kernel. Scott, please share your opinion here.

I don't like hiding the fact that they're the same number, which could
lead to wrong code in the absence of ifdefs that strictly mutually
exclude SPE and Altivec code -- there was an instance of this with
MSR_VEC versus MSR_SPE in a previous patchset.
 
> > >   #define BOOKE_INTERRUPT_SPE_FP_ROUND 34
> > >   #define BOOKE_INTERRUPT_PERFORMANCE_MONITOR 35
> > >   #define BOOKE_INTERRUPT_DOORBELL 36
> > > diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> > > index ab62109..3c86d9b 100644
> > > --- a/arch/powerpc/kvm/booke.c
> > > +++ b/arch/powerpc/kvm/booke.c
> > > @@ -388,8 +388,8 @@ static int kvmppc_booke_irqprio_deliver(struct
> > kvm_vcpu *vcpu,
> > >   	case BOOKE_IRQPRIO_ITLB_MISS:
> > >   	case BOOKE_IRQPRIO_SYSCALL:
> > >   	case BOOKE_IRQPRIO_FP_UNAVAIL:
> > > -	case BOOKE_IRQPRIO_SPE_UNAVAIL:
> > > -	case BOOKE_IRQPRIO_SPE_FP_DATA:
> > > +	case BOOKE_IRQPRIO_SPE_ALTIVEC_UNAVAIL:
> > > +	case BOOKE_IRQPRIO_SPE_FP_DATA_ALTIVEC_ASSIST:
> > 
> > #ifdef CONFIG_KVM_E500V2
> >    case ...SPE:
> > #else
> >    case ..ALTIVEC:
> > #endif

I don't think that's an improvement.

-Scott
