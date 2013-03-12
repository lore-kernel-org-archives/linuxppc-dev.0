Return-Path: <B38951@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0184.outbound.messaging.microsoft.com [213.199.154.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 92DE82C03DC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2013 18:40:51 +1100 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH V4] powerpc/85xx: Add machine check handler to fix PCIe
 erratum on mpc85xx
Date: Tue, 12 Mar 2013 07:40:39 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01C15369@039-SN1MPN1-003.039d.mgd.msft.net>
References: <412C8208B4A0464FA894C5F0C278CD5D01BFC620@039-SN1MPN1-002.039d.mgd.msft.net>
 (from B38951@freescale.com on Fri Mar  8 02:01:46 2013)
 <1362790153.29198.11@snotra>
In-Reply-To: <1362790153.29198.11@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: David Laight <David.Laight@ACULAB.COM>,
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



> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Saturday, March 09, 2013 8:49 AM
> To: Jia Hongtao-B38951
> Cc: Wood Scott-B07421; David Laight; linuxppc-dev@lists.ozlabs.org;
> Stuart Yoder
> Subject: Re: [PATCH V4] powerpc/85xx: Add machine check handler to fix
> PCIe erratum on mpc85xx
>=20
> On 03/08/2013 02:01:46 AM, Jia Hongtao-B38951 wrote:
> >
> >
> > > -----Original Message-----
> > > From: Wood Scott-B07421
> > > Sent: Friday, March 08, 2013 12:38 AM
> > > To: Jia Hongtao-B38951
> > > Cc: David Laight; Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org;
> > > Stuart Yoder
> > > Subject: Re: [PATCH V4] powerpc/85xx: Add machine check handler to
> > fix
> > > PCIe erratum on mpc85xx
> > >
> > > On 03/07/2013 02:06:05 AM, Jia Hongtao-B38951 wrote:
> > > > Here is the ideas from Scott:
> > > > "
> > > > > +	if (is_in_pci_mem_space(addr)) {
> > > > > +		inst =3D *(unsigned int *)regs->nip;
> > > >
> > > > Be careful about taking a fault here.  A simple TLB miss should be
> > > > safe given that we shouldn't be accessing PCIe in the middle of
> > > > exception code, but what if the mapping has gone away (e.g. a
> > > > userspace driver had its code munmap()ed or swapped out)?  What if
> > > > permissions allow execute but not read (not sure if Linux will
> > allow
> > > > this, but the hardware does)?
> > > >
> > > > What if it happened in a KVM guest?  You can't access guest
> > addresses
> > > > directly.
> > > > "
> > >
> > > That means you need to be careful about how you read the
> > instruction, not
> > > that you shouldn't do it at all.
> > >
> > > -Scott
> >
> > I agree.
> >
> > Do you have a more secure way to get the instruction?
> > Or what should be done to avoid permission break issue?
>=20
> probe_kernel_address() should take care of userspace issues.  As for
> KVM, if you see MSR_GS set, bail out and don't apply the workaround.
> Let KVM/QEMU deal with it as it wishes (e.g. reflect to the guest and
> let its machine check handler do the skipping).  On PR-mode KVM (e.g.
> on e500v2-based chips) there is no MSR_GS and it just looks like
> userspace code -- for now just pretend it is user mode.
>=20
> -Scott

Hi Scott,

Is that OK if I use the following code?

	u32 inst;
	int ret;

	if (is_in_pci_mem_space(addr)) {
		if (!user_mode(regs)) {
			ret =3D probe_kernel_address(regs->nip, inst);

			if (!ret) {
				rd =3D get_rt(inst);
				regs->gpr[rd] =3D 0xffffffff;
			}
		}

		regs->nip +=3D 4;
		return 1;
	}


Thanks.
-Hongtao.
