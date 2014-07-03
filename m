Return-Path: <mihai.caraman@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0212.outbound.protection.outlook.com [207.46.163.212])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2E62F1A0003
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jul 2014 01:53:22 +1000 (EST)
From: "mihai.caraman@freescale.com" <mihai.caraman@freescale.com>
To: Alexander Graf <agraf@suse.de>, Scott Wood <scottwood@freescale.com>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
Subject: RE: [PATCH 1/6 v2] KVM: PPC: Book3E: Use common defines for
 SPE/FP/AltiVec int numbers
Date: Thu, 3 Jul 2014 15:53:08 +0000
Message-ID: <48f85dbd75f54a06a56d18681fc521fc@BY2PR03MB508.namprd03.prod.outlook.com>
References: <1404142497-6430-1-git-send-email-mihai.caraman@freescale.com>
 <1404142497-6430-2-git-send-email-mihai.caraman@freescale.com>
 <53B54AAD.4040609@suse.de>
 <2399bd1f8fde430a945311ff27c3f5c3@BY2PR03MB508.namprd03.prod.outlook.com>
 <53B57722.9020205@suse.de>
In-Reply-To: <53B57722.9020205@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
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
> Sent: Thursday, July 03, 2014 6:31 PM
> To: Caraman Mihai Claudiu-B02008; Wood Scott-B07421; kvm-
> ppc@vger.kernel.org
> Cc: kvm@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH 1/6 v2] KVM: PPC: Book3E: Use common defines for
> SPE/FP/AltiVec int numbers
>=20
>=20
> On 03.07.14 17:25, mihai.caraman@freescale.com wrote:
> >> -----Original Message-----
> >> From: Alexander Graf [mailto:agraf@suse.de]
> >> Sent: Thursday, July 03, 2014 3:21 PM
> >> To: Caraman Mihai Claudiu-B02008; kvm-ppc@vger.kernel.org
> >> Cc: kvm@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> >> Subject: Re: [PATCH 1/6 v2] KVM: PPC: Book3E: Use common defines for
> >> SPE/FP/AltiVec int numbers
> >>
> >>
> >> On 30.06.14 17:34, Mihai Caraman wrote:
> >>> Use common BOOKE_IRQPRIO and BOOKE_INTERRUPT defines for
> SPE/FP/AltiVec
> >>> which share the same interrupt numbers.
> >>>
> >>> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> >>> ---
> >>> v2:
> >>>    - remove outdated definitions
> >>>
> >>>    arch/powerpc/include/asm/kvm_asm.h    |  8 --------
> >>>    arch/powerpc/kvm/booke.c              | 17 +++++++++--------
> >>>    arch/powerpc/kvm/booke.h              |  4 ++--
> >>>    arch/powerpc/kvm/booke_interrupts.S   |  9 +++++----
> >>>    arch/powerpc/kvm/bookehv_interrupts.S |  4 ++--
> >>>    arch/powerpc/kvm/e500.c               | 10 ++++++----
> >>>    arch/powerpc/kvm/e500_emulate.c       | 10 ++++++----
> >>>    7 files changed, 30 insertions(+), 32 deletions(-)
> >>>
> >>> diff --git a/arch/powerpc/include/asm/kvm_asm.h
> >> b/arch/powerpc/include/asm/kvm_asm.h
> >>> index 9601741..c94fd33 100644
> >>> --- a/arch/powerpc/include/asm/kvm_asm.h
> >>> +++ b/arch/powerpc/include/asm/kvm_asm.h
> >>> @@ -56,14 +56,6 @@
> >>>    /* E500 */
> >>>    #define BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL 32
> >>>    #define BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST 33
> >>> -/*
> >>> - * TODO: Unify 32-bit and 64-bit kernel exception handlers to use
> same
> >> defines
> >>> - */
> >>> -#define BOOKE_INTERRUPT_SPE_UNAVAIL
> >> BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL
> >>> -#define BOOKE_INTERRUPT_SPE_FP_DATA
> >> BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST
> >>> -#define BOOKE_INTERRUPT_ALTIVEC_UNAVAIL
> >> BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL
> >>> -#define BOOKE_INTERRUPT_ALTIVEC_ASSIST \
> >>> -				BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST
> >> I think I'd prefer to keep them separate.
> > What is the reason from changing your mind from ver 1? Do you want to
> have
>=20
> Uh, mind to point me to an email where I said I like the approach? :)

You tacitly approved it in this thread ... I did not say you like it :)

https://lists.ozlabs.org/pipermail/linuxppc-dev/2013-July/108501.html

-Mike
