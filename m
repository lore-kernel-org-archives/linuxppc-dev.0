Return-Path: <R65777@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 761502C0314
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2013 14:58:44 +1100 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Michael Neuling <mikey@neuling.org>
Subject: RE: BOOKE KVM calling load_up_fpu from C?
Date: Tue, 12 Feb 2013 03:58:36 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D0659EC82@039-SN2MPN1-023.039d.mgd.msft.net>
References: <14306.1360639760@ale.ozlabs.ibm.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0659EC4A@039-SN2MPN1-023.039d.mgd.msft.net>
 <16381.1360640767@ale.ozlabs.ibm.com>
In-Reply-To: <16381.1360640767@ale.ozlabs.ibm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Michael Neuling [mailto:mikey@neuling.org]
> Sent: Tuesday, February 12, 2013 9:16 AM
> To: Bhushan Bharat-R65777
> Cc: Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org
> Subject: Re: BOOKE KVM calling load_up_fpu from C?
>=20
> Bhushan Bharat-R65777 <R65777@freescale.com> wrote:
>=20
> >
> >
> > > -----Original Message-----
> > > From: Linuxppc-dev [mailto:linuxppc-dev-
> > > bounces+bharat.bhushan=3Dfreescale.com@lists.ozlabs.org] On Behalf Of
> > > bounces+Michael
> > > Neuling
> > > Sent: Tuesday, February 12, 2013 8:59 AM
> > > To: Wood Scott-B07421
> > > Cc: linuxppc-dev@lists.ozlabs.org
> > > Subject: BOOKE KVM calling load_up_fpu from C?
> > >
> > > Scott,
> > >
> > > I was looking at changing how load_up_fpu works and I found this in
> > > arch/powerpc/kvm/booke.h:
> > >
> > > static inline void kvmppc_load_guest_fp(struct kvm_vcpu *vcpu) {
> > > #ifdef CONFIG_PPC_FPU
> > > 	if (vcpu->fpu_active && !(current->thread.regs->msr & MSR_FP)) {
> > > 		load_up_fpu();
> > > 		current->thread.regs->msr |=3D MSR_FP;
> > > 	}
> > > #endif
> > > }
> > >
> > > I'm wondering how this is suppose to work since load_up_fpu is
> > > suppose to have MSR in R12?
> >
> > Is not the load_up_fpu() does mfmsr:
> >
> > _GLOBAL(load_up_fpu)
> >         mfmsr   r5
> >         ori     r5,r5,MSR_FP
> > #ifdef CONFIG_VSX
> > BEGIN_FTR_SECTION
> >         oris    r5,r5,MSR_VSX@h
> > END_FTR_SECTION_IFSET(CPU_FTR_VSX)
> > #endif
> >         SYNC
> >         MTMSRD(r5)                      /* enable use of fpu now */
> >         isync
> > <snip>
>=20
> Look further down...
>=20
> #ifdef CONFIG_PPC32
> 	mfspr	r5,SPRN_SPRG_THREAD		/* current task's THREAD (phys) */
> 	lwz	r4,THREAD_FPEXC_MODE(r5)
> 	ori	r9,r9,MSR_FP		/* enable FP for current */
> 	or	r9,r9,r4
> #else
> 	ld	r4,PACACURRENT(r13)
> 	addi	r5,r4,THREAD		/* Get THREAD */
> 	lwz	r4,THREAD_FPEXC_MODE(r5)
> 	ori	r12,r12,MSR_FP
> 	or	r12,r12,r4
> 	std	r12,_MSR(r1)
> #endif
>=20
> R12 is loaded with SRR1 in the exception prolog before load_up_fpu is cal=
led.

Yes it is SRR1 not MSR.
Also on 32bit it looks like that R9 is assumed to have SRR1.

-Bharat

> It's the MSR of the user process, not the current MSR.
>=20
> Mikey
