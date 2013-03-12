Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D55962C02A0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2013 08:24:27 +1100 (EST)
Date: Tue, 12 Mar 2013 16:24:12 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH V4] powerpc/85xx: Add machine check handler to fix PCIe
 erratum on mpc85xx
To: Jia Hongtao-B38951 <B38951@freescale.com>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01C15369@039-SN1MPN1-003.039d.mgd.msft.net>
 (from B38951@freescale.com on Tue Mar 12 02:40:39 2013)
Message-ID: <1363123452.17135.13@snotra>
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

On 03/12/2013 02:40:39 AM, Jia Hongtao-B38951 wrote:
>=20
>=20
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Saturday, March 09, 2013 8:49 AM
> > To: Jia Hongtao-B38951
> > Cc: Wood Scott-B07421; David Laight; linuxppc-dev@lists.ozlabs.org;
> > Stuart Yoder
> > Subject: Re: [PATCH V4] powerpc/85xx: Add machine check handler to =20
> fix
> > PCIe erratum on mpc85xx
> >
> > On 03/08/2013 02:01:46 AM, Jia Hongtao-B38951 wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Wood Scott-B07421
> > > > Sent: Friday, March 08, 2013 12:38 AM
> > > > To: Jia Hongtao-B38951
> > > > Cc: David Laight; Wood Scott-B07421; =20
> linuxppc-dev@lists.ozlabs.org;
> > > > Stuart Yoder
> > > > Subject: Re: [PATCH V4] powerpc/85xx: Add machine check handler =20
> to
> > > fix
> > > > PCIe erratum on mpc85xx
> > > >
> > > > On 03/07/2013 02:06:05 AM, Jia Hongtao-B38951 wrote:
> > > > > Here is the ideas from Scott:
> > > > > "
> > > > > > +	if (is_in_pci_mem_space(addr)) {
> > > > > > +		inst =3D *(unsigned int *)regs->nip;
> > > > >
> > > > > Be careful about taking a fault here.  A simple TLB miss =20
> should be
> > > > > safe given that we shouldn't be accessing PCIe in the middle =20
> of
> > > > > exception code, but what if the mapping has gone away (e.g. a
> > > > > userspace driver had its code munmap()ed or swapped out)?  =20
> What if
> > > > > permissions allow execute but not read (not sure if Linux will
> > > allow
> > > > > this, but the hardware does)?
> > > > >
> > > > > What if it happened in a KVM guest?  You can't access guest
> > > addresses
> > > > > directly.
> > > > > "
> > > >
> > > > That means you need to be careful about how you read the
> > > instruction, not
> > > > that you shouldn't do it at all.
> > > >
> > > > -Scott
> > >
> > > I agree.
> > >
> > > Do you have a more secure way to get the instruction?
> > > Or what should be done to avoid permission break issue?
> >
> > probe_kernel_address() should take care of userspace issues.  As for
> > KVM, if you see MSR_GS set, bail out and don't apply the workaround.
> > Let KVM/QEMU deal with it as it wishes (e.g. reflect to the guest =20
> and
> > let its machine check handler do the skipping).  On PR-mode KVM =20
> (e.g.
> > on e500v2-based chips) there is no MSR_GS and it just looks like
> > userspace code -- for now just pretend it is user mode.
> >
> > -Scott
>=20
> Hi Scott,
>=20
> Is that OK if I use the following code?
>=20
> 	u32 inst;
> 	int ret;
>=20
> 	if (is_in_pci_mem_space(addr)) {
> 		if (!user_mode(regs)) {
> 			ret =3D probe_kernel_address(regs->nip, inst);

Hmm, seems there's no probe_user_address() -- for userspace we =20
basically want the same thing minus the KERNEL_DS.  See =20
arch/powerpc/perf/callchain.c for an example.

You also need to skip this if (regs->msr & MSR_GS) as I mentioned above.

> 			if (!ret) {
> 				rd =3D get_rt(inst);
> 				regs->gpr[rd] =3D 0xffffffff;
> 			}

Check whether the instruction is a load, as David pointed out.  Also =20
check the size of the load, whether it was load with update =20
instruction, etc.

-Scott=
