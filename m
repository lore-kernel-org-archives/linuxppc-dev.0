Return-Path: <R65777@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1DE952C0092
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2013 12:18:24 +1100 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: BOOKE KVM calling load_up_fpu from C?
Date: Wed, 13 Feb 2013 01:18:14 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D065A3456@039-SN2MPN1-023.039d.mgd.msft.net>
References: <6A3DF150A5B70D4F9B66A25E3F7C888D0659EF89@039-SN2MPN1-023.039d.mgd.msft.net>
 (from R65777@freescale.com on Tue Feb 12 03:01:07 2013)
 <1360693988.24612.4@snotra>
In-Reply-To: <1360693988.24612.4@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>,
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
> From: Wood Scott-B07421
> Sent: Wednesday, February 13, 2013 12:03 AM
> To: Bhushan Bharat-R65777
> Cc: Michael Neuling; Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org
> Subject: Re: BOOKE KVM calling load_up_fpu from C?
>=20
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
> > > Yes, SRR1 =3D=3D the MSR of the user process, not the current MSR.
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
>=20
> I don't think it's actually a problem on 32-bit, since r9 is modified but=
 never
> actually used for anything.

Is not the epilog loads srr1 in r9 and load_up_fpu() changes r9 and then r9=
 is written back in srr1 ?


>  On 64-bit, though, there's a store to the caller's
> stack frame (yuck) which the kvm/booke.h caller is not prepared for.

So if caller is using r12 then it can lead to come corruption, right ?

>  Indeed,
> book3s's kvmppc_load_up_fpu creates an interrupt-like stack frame, but do=
es not
> load r9 or r12.
>=20
> It would be really nice if assumptions like these were put in a code comm=
ent
> above load_up_fpu...  and if we didn't have so many random differences be=
tween
> 32-bit and 64-bit. :-P

:)

Thanks
-Bharat

>=20
> -Scott
