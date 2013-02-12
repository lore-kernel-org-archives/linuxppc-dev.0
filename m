Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Bhushan Bharat-R65777 <R65777@freescale.com>
Subject: Re: BOOKE KVM calling load_up_fpu from C?
In-reply-to: <6A3DF150A5B70D4F9B66A25E3F7C888D0659EC4A@039-SN2MPN1-023.039d.mgd.msft.net>
References: <14306.1360639760@ale.ozlabs.ibm.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0659EC4A@039-SN2MPN1-023.039d.mgd.msft.net>
Date: Tue, 12 Feb 2013 14:46:07 +1100
Message-ID: <16381.1360640767@ale.ozlabs.ibm.com>
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

Bhushan Bharat-R65777 <R65777@freescale.com> wrote:

> 
> 
> > -----Original Message-----
> > From: Linuxppc-dev [mailto:linuxppc-dev-
> > bounces+bharat.bhushan=freescale.com@lists.ozlabs.org] On Behalf Of Michael
> > Neuling
> > Sent: Tuesday, February 12, 2013 8:59 AM
> > To: Wood Scott-B07421
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Subject: BOOKE KVM calling load_up_fpu from C?
> > 
> > Scott,
> > 
> > I was looking at changing how load_up_fpu works and I found this in
> > arch/powerpc/kvm/booke.h:
> > 
> > static inline void kvmppc_load_guest_fp(struct kvm_vcpu *vcpu) { #ifdef
> > CONFIG_PPC_FPU
> > 	if (vcpu->fpu_active && !(current->thread.regs->msr & MSR_FP)) {
> > 		load_up_fpu();
> > 		current->thread.regs->msr |= MSR_FP;
> > 	}
> > #endif
> > }
> > 
> > I'm wondering how this is suppose to work since load_up_fpu is suppose to have
> > MSR in R12?
> 
> Is not the load_up_fpu() does mfmsr:
> 
> _GLOBAL(load_up_fpu)
>         mfmsr   r5
>         ori     r5,r5,MSR_FP
> #ifdef CONFIG_VSX
> BEGIN_FTR_SECTION
>         oris    r5,r5,MSR_VSX@h
> END_FTR_SECTION_IFSET(CPU_FTR_VSX)
> #endif
>         SYNC
>         MTMSRD(r5)                      /* enable use of fpu now */
>         isync
> <snip>

Look further down...

#ifdef CONFIG_PPC32
	mfspr	r5,SPRN_SPRG_THREAD		/* current task's THREAD (phys) */
	lwz	r4,THREAD_FPEXC_MODE(r5)
	ori	r9,r9,MSR_FP		/* enable FP for current */
	or	r9,r9,r4
#else
	ld	r4,PACACURRENT(r13)
	addi	r5,r4,THREAD		/* Get THREAD */
	lwz	r4,THREAD_FPEXC_MODE(r5)
	ori	r12,r12,MSR_FP
	or	r12,r12,r4
	std	r12,_MSR(r1)
#endif

R12 is loaded with SRR1 in the exception prolog before load_up_fpu is
called.  It's the MSR of the user process, not the current MSR.

Mikey
