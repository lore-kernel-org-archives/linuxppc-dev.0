Return-Path: <B38951@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 91B2F2C0344
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2013 19:01:54 +1100 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH V4] powerpc/85xx: Add machine check handler to fix PCIe
 erratum on mpc85xx
Date: Fri, 8 Mar 2013 08:01:46 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01BFC620@039-SN1MPN1-002.039d.mgd.msft.net>
References: <CALRxmdBjb+TrqZ_XdNjH=oDcdYtVJ5=Q71dcCkKodpe7WCHDpA@mail.gmail.com>
 <1362440744.16575.6@snotra>
 <412C8208B4A0464FA894C5F0C278CD5D01BE952E@039-SN1MPN1-002.039d.mgd.msft.net>
 <1362509262.25308.0@snotra>
 <412C8208B4A0464FA894C5F0C278CD5D01BE9D9D@039-SN1MPN1-002.039d.mgd.msft.net>
 <AE90C24D6B3A694183C094C60CF0A2F6026B7179@saturn3.aculab.com>
 <412C8208B4A0464FA894C5F0C278CD5D01BFA1D0@039-SN1MPN1-002.039d.mgd.msft.net>
 <1362674267.23227.1@snotra>
In-Reply-To: <1362674267.23227.1@snotra>
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
> Sent: Friday, March 08, 2013 12:38 AM
> To: Jia Hongtao-B38951
> Cc: David Laight; Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org;
> Stuart Yoder
> Subject: Re: [PATCH V4] powerpc/85xx: Add machine check handler to fix
> PCIe erratum on mpc85xx
>=20
> On 03/07/2013 02:06:05 AM, Jia Hongtao-B38951 wrote:
> > Here is the ideas from Scott:
> > "
> > > +	if (is_in_pci_mem_space(addr)) {
> > > +		inst =3D *(unsigned int *)regs->nip;
> >
> > Be careful about taking a fault here.  A simple TLB miss should be
> > safe given that we shouldn't be accessing PCIe in the middle of
> > exception code, but what if the mapping has gone away (e.g. a
> > userspace driver had its code munmap()ed or swapped out)?  What if
> > permissions allow execute but not read (not sure if Linux will allow
> > this, but the hardware does)?
> >
> > What if it happened in a KVM guest?  You can't access guest addresses
> > directly.
> > "
>=20
> That means you need to be careful about how you read the instruction, not
> that you shouldn't do it at all.
>=20
> -Scott

I agree.

Do you have a more secure way to get the instruction?
Or what should be done to avoid permission break issue?

Thanks.
-Hongtao
