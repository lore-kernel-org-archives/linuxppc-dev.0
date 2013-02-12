Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: BOOKE KVM calling load_up_fpu from C?
In-reply-to: <1360693988.24612.4@snotra>
References: <1360693988.24612.4@snotra>
Date: Wed, 13 Feb 2013 09:51:05 +1100
Message-ID: <23317.1360709465@ale.ozlabs.ibm.com>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Bhushan Bharat-R65777 <R65777@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <scottwood@freescale.com> wrote:

> On 02/12/2013 03:01:07 AM, Bhushan Bharat-R65777 wrote:
> > 
> > 
> > > -----Original Message-----
> > > From: Michael Neuling [mailto:mikey@neuling.org]
> > > Sent: Tuesday, February 12, 2013 9:46 AM
> > > To: Bhushan Bharat-R65777
> > > Cc: Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org
> > > Subject: Re: BOOKE KVM calling load_up_fpu from C?
> > >
> > > Bhushan Bharat-R65777 <R65777@freescale.com> wrote:
> > >
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Michael Neuling [mailto:mikey@neuling.org]
> > > > > Sent: Tuesday, February 12, 2013 9:16 AM
> > > > > To: Bhushan Bharat-R65777
> > > > > Cc: Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org
> > > > > Subject: Re: BOOKE KVM calling load_up_fpu from C?
> > > > >
> > > > > Look further down...
> > > > >
> > > > > #ifdef CONFIG_PPC32
> > > > > 	mfspr	r5,SPRN_SPRG_THREAD		/* current  
> > task's THREAD (phys) */
> > > > > 	lwz	r4,THREAD_FPEXC_MODE(r5)
> > > > > 	ori	r9,r9,MSR_FP		/* enable FP for  
> > current */
> > > > > 	or	r9,r9,r4
> > > > > #else
> > > > > 	ld	r4,PACACURRENT(r13)
> > > > > 	addi	r5,r4,THREAD		/* Get THREAD */
> > > > > 	lwz	r4,THREAD_FPEXC_MODE(r5)
> > > > > 	ori	r12,r12,MSR_FP
> > > > > 	or	r12,r12,r4
> > > > > 	std	r12,_MSR(r1)
> > > > > #endif
> > > > >
> > > > > R12 is loaded with SRR1 in the exception prolog before  
> > load_up_fpu is
> > > called.
> > > >
> > > > Yes it is SRR1 not MSR.
> > >
> > > Yes, SRR1 == the MSR of the user process, not the current MSR.
> > >
> > > > Also on 32bit it looks like that R9 is assumed to have SRR1.
> > >
> > > Yep that too.
> > >
> > > So any idea how it's suppose to work or is it broken?
> > 
> > To me this looks wrong. And this seems to works because the  
> > thread->reg->msr is not actually used to write SRR1 (and eventually  
> > the thread MSR) when doing rfi to enter guest. Infact  
> > Guest(shadow_msr) MSR is used as SRR1 and which will have proper MSR  
> > (including FP set).
> > 
> > But Yes, Scott is right person to comment, So let us wait for him  
> > comment.
> 
> I don't think it's actually a problem on 32-bit, since r9 is modified  
> but never actually used for anything.  On 64-bit, though, there's a  
> store to the caller's stack frame (yuck) which the kvm/booke.h caller  
> is not prepared for.  Indeed, book3s's kvmppc_load_up_fpu creates an  
> interrupt-like stack frame, but does not load r9 or r12.

Yep.

> It would be really nice if assumptions like these were put in a code  
> comment above load_up_fpu...  and if we didn't have so many random  
> differences between 32-bit and 64-bit. :-P

Yep.. I won't NACK that patch when you send it :-)

It was pretty much assumed that load_up_fpu was going to be called right
after the exception prolog.  Calling it any other way was going to be
tricky.

Mikey
