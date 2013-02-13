Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 82E712C0084
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2013 04:37:47 +1100 (EST)
Date: Wed, 13 Feb 2013 11:37:27 -0600
From: Scott Wood <scottwood@freescale.com>
Subject: Re: BOOKE KVM calling load_up_fpu from C?
To: Bhushan Bharat-R65777 <R65777@freescale.com>
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D065A3511@039-SN2MPN1-023.039d.mgd.msft.net>
 (from R65777@freescale.com on Tue Feb 12 22:17:00 2013)
Message-ID: <1360777047.6853.3@snotra>
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

On 02/12/2013 10:17:00 PM, Bhushan Bharat-R65777 wrote:
>=20
>=20
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Wednesday, February 13, 2013 6:53 AM
> > To: Bhushan Bharat-R65777
> > Cc: Wood Scott-B07421; Michael Neuling; =20
> linuxppc-dev@lists.ozlabs.org
> > Subject: Re: BOOKE KVM calling load_up_fpu from C?
> >
> > On 02/12/2013 07:18:14 PM, Bhushan Bharat-R65777 wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Wood Scott-B07421
> > > > Sent: Wednesday, February 13, 2013 12:03 AM
> > > > To: Bhushan Bharat-R65777
> > > > Cc: Michael Neuling; Wood Scott-B07421;
> > > linuxppc-dev@lists.ozlabs.org
> > > > Subject: Re: BOOKE KVM calling load_up_fpu from C?
> > > >
> > > >  On 64-bit, though, there's a store to the caller's stack frame
> > > > (yuck) which the kvm/booke.h caller is not prepared for.
> > >
> > > So if caller is using r12 then it can lead to come corruption, =20
> right ?
> >
> > No, r12 is a volatile register in the ABI, as is r9.  The issue is =20
> that the
> > stack can be corrupted.
>=20
> What do you mean by stack is corrupted?

load_up_fpu() makes assumptions about the caller's stack frame that =20
aren't true when called from C code.

> My understanding is that when calling the assembly function from C =20
> function then stack frame will not be pushed and assembly function =20
> uses the caller stack frame.

Huh?  Assembly functions obey the same ABI as C functions (at least, =20
asm functions meant to be callable from C do).  If the above were true, =20
how would C code know that it's calling an asm function, and how would =20
it know how much stack to create and which portions would be clobbered?

The issue with load_up_fpu() is that it was apparently not meant to be =20
called directly from C code.

-Scott=
