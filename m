Return-Path: <B07421@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe006.messaging.microsoft.com [213.199.154.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AF8242C0332
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Mar 2013 11:49:28 +1100 (EST)
Date: Fri, 8 Mar 2013 18:49:13 -0600
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH V4] powerpc/85xx: Add machine check handler to fix PCIe
 erratum on mpc85xx
To: Jia Hongtao-B38951 <B38951@freescale.com>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01BFC620@039-SN1MPN1-002.039d.mgd.msft.net>
 (from B38951@freescale.com on Fri Mar  8 02:01:46 2013)
Message-ID: <1362790153.29198.11@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 David Laight <David.Laight@ACULAB.COM>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Stuart Yoder <b08248@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/08/2013 02:01:46 AM, Jia Hongtao-B38951 wrote:
>=20
>=20
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Friday, March 08, 2013 12:38 AM
> > To: Jia Hongtao-B38951
> > Cc: David Laight; Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org;
> > Stuart Yoder
> > Subject: Re: [PATCH V4] powerpc/85xx: Add machine check handler to =20
> fix
> > PCIe erratum on mpc85xx
> >
> > On 03/07/2013 02:06:05 AM, Jia Hongtao-B38951 wrote:
> > > Here is the ideas from Scott:
> > > "
> > > > +	if (is_in_pci_mem_space(addr)) {
> > > > +		inst =3D *(unsigned int *)regs->nip;
> > >
> > > Be careful about taking a fault here.  A simple TLB miss should be
> > > safe given that we shouldn't be accessing PCIe in the middle of
> > > exception code, but what if the mapping has gone away (e.g. a
> > > userspace driver had its code munmap()ed or swapped out)?  What if
> > > permissions allow execute but not read (not sure if Linux will =20
> allow
> > > this, but the hardware does)?
> > >
> > > What if it happened in a KVM guest?  You can't access guest =20
> addresses
> > > directly.
> > > "
> >
> > That means you need to be careful about how you read the =20
> instruction, not
> > that you shouldn't do it at all.
> >
> > -Scott
>=20
> I agree.
>=20
> Do you have a more secure way to get the instruction?
> Or what should be done to avoid permission break issue?

probe_kernel_address() should take care of userspace issues.  As for =20
KVM, if you see MSR_GS set, bail out and don't apply the workaround.  =20
Let KVM/QEMU deal with it as it wishes (e.g. reflect to the guest and =20
let its machine check handler do the skipping).  On PR-mode KVM (e.g. =20
on e500v2-based chips) there is no MSR_GS and it just looks like =20
userspace code -- for now just pretend it is user mode.

-Scott=
