Return-Path: <B38951@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 60C5E2C0369
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Mar 2013 19:06:41 +1100 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: David Laight <David.Laight@ACULAB.COM>, Wood Scott-B07421
 <B07421@freescale.com>
Subject: RE: [PATCH V4] powerpc/85xx: Add machine check handler to fix PCIe
 erratum on mpc85xx
Date: Thu, 7 Mar 2013 08:06:05 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01BFA1D0@039-SN1MPN1-002.039d.mgd.msft.net>
References: <CALRxmdBjb+TrqZ_XdNjH=oDcdYtVJ5=Q71dcCkKodpe7WCHDpA@mail.gmail.com>
 <1362440744.16575.6@snotra>
 <412C8208B4A0464FA894C5F0C278CD5D01BE952E@039-SN1MPN1-002.039d.mgd.msft.net>
 <1362509262.25308.0@snotra>
 <412C8208B4A0464FA894C5F0C278CD5D01BE9D9D@039-SN1MPN1-002.039d.mgd.msft.net>
 <AE90C24D6B3A694183C094C60CF0A2F6026B7179@saturn3.aculab.com>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B7179@saturn3.aculab.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
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
> From: David Laight [mailto:David.Laight@ACULAB.COM]
> Sent: Wednesday, March 06, 2013 6:24 PM
> To: Jia Hongtao-B38951; Wood Scott-B07421
> Cc: linuxppc-dev@lists.ozlabs.org; Stuart Yoder
> Subject: RE: [PATCH V4] powerpc/85xx: Add machine check handler to fix
> PCIe erratum on mpc85xx
>=20
> > > Yes, that's (one reason) why you'd want to fill in a known value.
> > > Note the "for now". :-)
> > >
> > > -Scott
> >
> > I think there is no overwhelming reason to fill the destination
> > register with 0xffffffff.
> >
> > There's a small chance that 0xffffffff is treated as regular data
> > rather than an error sign.
> >
> > Also setting this register may influence the user space under certain
> > circumstance.
> >
> > So I think just ignore the skipped instruction is an acceptable option
> > for this fix.
>=20
> The 'random' value is just as likely to affect the reader, but only for
> some values - so you'll get almost impossible to repeat bugs.
> If a fixed value (0 or ~0) has an adverse effect, at least it will have
> the same every time.
>=20
> Read errors are also likely to affect device drivers reading status bits,
> since these are very likely 'write to clear' any driver would have to be
> willing to process the 'dummy' value in a manner that won't loop forever
> (especially in an ISR).
>=20
> You don't need every access to be via a function that explicitly
> (somehow) detects that the fault happened, but knowing that a specific
> value might be caused by a dead PCIe bus, and being able to find out
> whether that is true (to avoid looping forever) is probably useful.
>=20
> This is probably similar to what a driver needs to recover from an
> external PCIe list being unplugged.
>=20
> 	David
>=20
>=20

In my understanding filling the register could warn the executing process
an error occurred in some cases. But no way to fix the wrong behavior cause=
d
by the instruction lost. So let's say that filling the register may benefit
a little.

On the other side, we should not access to the addresses of unknown process
in Linux kernel. We must get the instruction before filling the register.
If the instruction is not in the cache we have to access to the unknown
addresses to get it. For system security I think this is strictly forbidden=
.

Here is the ideas from Scott:
"
> +	if (is_in_pci_mem_space(addr)) {
> +		inst =3D *(unsigned int *)regs->nip;

Be careful about taking a fault here.  A simple TLB miss should be safe
given that we shouldn't be accessing PCIe in the middle of exception
code, but what if the mapping has gone away (e.g. a userspace driver had
its code munmap()ed or swapped out)?  What if permissions allow execute
but not read (not sure if Linux will allow this, but the hardware does)?

What if it happened in a KVM guest?  You can't access guest addresses
directly.
"

Although I think filling the register have some advantages but it's should
be forbidden for security reason.

-Hongtao.
