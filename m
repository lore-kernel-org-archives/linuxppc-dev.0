Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3EACE2C0095
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2013 12:23:25 +1100 (EST)
Date: Tue, 12 Feb 2013 19:23:14 -0600
From: Scott Wood <scottwood@freescale.com>
Subject: Re: BOOKE KVM calling load_up_fpu from C?
To: Bhushan Bharat-R65777 <R65777@freescale.com>
References: <6A3DF150A5B70D4F9B66A25E3F7C888D0659EF89@039-SN2MPN1-023.039d.mgd.msft.net>
 <1360693988.24612.4@snotra>
 <6A3DF150A5B70D4F9B66A25E3F7C888D065A3456@039-SN2MPN1-023.039d.mgd.msft.net>
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D065A3456@039-SN2MPN1-023.039d.mgd.msft.net>
 (from R65777@freescale.com on Tue Feb 12 19:18:14 2013)
Message-ID: <1360718594.24612.21@snotra>
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

On 02/12/2013 07:18:14 PM, Bhushan Bharat-R65777 wrote:
>=20
>=20
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Wednesday, February 13, 2013 12:03 AM
> > To: Bhushan Bharat-R65777
> > Cc: Michael Neuling; Wood Scott-B07421; =20
> linuxppc-dev@lists.ozlabs.org
> > Subject: Re: BOOKE KVM calling load_up_fpu from C?
> >
> > On 02/12/2013 03:01:07 AM, Bhushan Bharat-R65777 wrote:
> > > To me this looks wrong. And this seems to works because the
> > > thread->reg->msr is not actually used to write SRR1 (and =20
> eventually
> > > the thread MSR) when doing rfi to enter guest. Infact
> > > Guest(shadow_msr) MSR is used as SRR1 and which will have proper =20
> MSR
> > > (including FP set).
> > >
> > > But Yes, Scott is right person to comment, So let us wait for him
> > > comment.
> >
> > I don't think it's actually a problem on 32-bit, since r9 is =20
> modified but never
> > actually used for anything.
>=20
> Is not the epilog loads srr1 in r9 and load_up_fpu() changes r9 and =20
> then r9 is written back in srr1 ?

What epilog?  We're talking about the case where it's called from C =20
code.

When it's called from an exception handler, then r9 is used, but in =20
that case it's also initialized before calling load_up_fpu, by the =20
prolog.

> >  On 64-bit, though, there's a store to the caller's
> > stack frame (yuck) which the kvm/booke.h caller is not prepared for.
>=20
> So if caller is using r12 then it can lead to come corruption, right ?

No, r12 is a volatile register in the ABI, as is r9.  The issue is that =20
the stack can be corrupted.

-Scott=
