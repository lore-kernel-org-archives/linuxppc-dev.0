Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EDBBB2C0394
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2013 03:38:02 +1100 (EST)
Date: Thu, 7 Mar 2013 10:37:47 -0600
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH V4] powerpc/85xx: Add machine check handler to fix PCIe
 erratum on mpc85xx
To: Jia Hongtao-B38951 <B38951@freescale.com>
References: <CALRxmdBjb+TrqZ_XdNjH=oDcdYtVJ5=Q71dcCkKodpe7WCHDpA@mail.gmail.com>
 <1362440744.16575.6@snotra>
 <412C8208B4A0464FA894C5F0C278CD5D01BE952E@039-SN1MPN1-002.039d.mgd.msft.net>
 <1362509262.25308.0@snotra>
 <412C8208B4A0464FA894C5F0C278CD5D01BE9D9D@039-SN1MPN1-002.039d.mgd.msft.net>
 <AE90C24D6B3A694183C094C60CF0A2F6026B7179@saturn3.aculab.com>
 <412C8208B4A0464FA894C5F0C278CD5D01BFA1D0@039-SN1MPN1-002.039d.mgd.msft.net>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01BFA1D0@039-SN1MPN1-002.039d.mgd.msft.net>
 (from B38951@freescale.com on Thu Mar  7 02:06:05 2013)
Message-ID: <1362674267.23227.1@snotra>
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

On 03/07/2013 02:06:05 AM, Jia Hongtao-B38951 wrote:
> Here is the ideas from Scott:
> "
> > +	if (is_in_pci_mem_space(addr)) {
> > +		inst =3D *(unsigned int *)regs->nip;
>=20
> Be careful about taking a fault here.  A simple TLB miss should be =20
> safe
> given that we shouldn't be accessing PCIe in the middle of exception
> code, but what if the mapping has gone away (e.g. a userspace driver =20
> had
> its code munmap()ed or swapped out)?  What if permissions allow =20
> execute
> but not read (not sure if Linux will allow this, but the hardware =20
> does)?
>=20
> What if it happened in a KVM guest?  You can't access guest addresses
> directly.
> "

That means you need to be careful about how you read the instruction, =20
not that you shouldn't do it at all.

-Scott=
