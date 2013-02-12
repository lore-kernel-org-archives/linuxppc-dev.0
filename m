Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 04A7A2C0391
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2013 05:33:34 +1100 (EST)
Date: Tue, 12 Feb 2013 12:33:08 -0600
From: Scott Wood <scottwood@freescale.com>
Subject: Re: BOOKE KVM calling load_up_fpu from C?
To: Bhushan Bharat-R65777 <R65777@freescale.com>
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D0659EF89@039-SN2MPN1-023.039d.mgd.msft.net>
 (from R65777@freescale.com on Tue Feb 12 03:01:07 2013)
Message-ID: <1360693988.24612.4@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Michael Neuling <mikey@neuling.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/12/2013 03:01:07 AM, Bhushan Bharat-R65777 wrote:
>=20
>=20
> > -----Original Message-----
> > From: Michael Neuling [mailto:mikey@neuling.org]
> > Sent: Tuesday, February 12, 2013 9:46 AM
> > To: Bhushan Bharat-R65777
> > Cc: Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org
> > Subject: Re: BOOKE KVM calling load_up_fpu from C?
> >
> > Bhushan Bharat-R65777 <R65777@freescale.com> wrote:
> >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Michael Neuling [mailto:mikey@neuling.org]
> > > > Sent: Tuesday, February 12, 2013 9:16 AM
> > > > To: Bhushan Bharat-R65777
> > > > Cc: Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org
> > > > Subject: Re: BOOKE KVM calling load_up_fpu from C?
> > > >
> > > > Look further down...
> > > >
> > > > #ifdef CONFIG_PPC32
> > > > 	mfspr	r5,SPRN_SPRG_THREAD		/* current =20
> task's THREAD (phys) */
> > > > 	lwz	r4,THREAD_FPEXC_MODE(r5)
> > > > 	ori	r9,r9,MSR_FP		/* enable FP for =20
> current */
> > > > 	or	r9,r9,r4
> > > > #else
> > > > 	ld	r4,PACACURRENT(r13)
> > > > 	addi	r5,r4,THREAD		/* Get THREAD */
> > > > 	lwz	r4,THREAD_FPEXC_MODE(r5)
> > > > 	ori	r12,r12,MSR_FP
> > > > 	or	r12,r12,r4
> > > > 	std	r12,_MSR(r1)
> > > > #endif
> > > >
> > > > R12 is loaded with SRR1 in the exception prolog before =20
> load_up_fpu is
> > called.
> > >
> > > Yes it is SRR1 not MSR.
> >
> > Yes, SRR1 =3D=3D the MSR of the user process, not the current MSR.
> >
> > > Also on 32bit it looks like that R9 is assumed to have SRR1.
> >
> > Yep that too.
> >
> > So any idea how it's suppose to work or is it broken?
>=20
> To me this looks wrong. And this seems to works because the =20
> thread->reg->msr is not actually used to write SRR1 (and eventually =20
> the thread MSR) when doing rfi to enter guest. Infact =20
> Guest(shadow_msr) MSR is used as SRR1 and which will have proper MSR =20
> (including FP set).
>=20
> But Yes, Scott is right person to comment, So let us wait for him =20
> comment.

I don't think it's actually a problem on 32-bit, since r9 is modified =20
but never actually used for anything.  On 64-bit, though, there's a =20
store to the caller's stack frame (yuck) which the kvm/booke.h caller =20
is not prepared for.  Indeed, book3s's kvmppc_load_up_fpu creates an =20
interrupt-like stack frame, but does not load r9 or r12.

It would be really nice if assumptions like these were put in a code =20
comment above load_up_fpu...  and if we didn't have so many random =20
differences between 32-bit and 64-bit. :-P

-Scott=
