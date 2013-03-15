Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A73732C00BE
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Mar 2013 03:35:02 +1100 (EST)
Date: Fri, 15 Mar 2013 11:34:52 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH V4] powerpc/85xx: Add machine check handler to fix PCIe
 erratum on mpc85xx
To: Jia Hongtao-B38951 <B38951@freescale.com>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01C18FD6@039-SN1MPN1-003.039d.mgd.msft.net>
 (from B38951@freescale.com on Thu Mar 14 21:47:58 2013)
Message-ID: <1363365292.10440.0@snotra>
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

On 03/14/2013 09:47:58 PM, Jia Hongtao-B38951 wrote:
>=20
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Thursday, March 14, 2013 12:38 AM
> > To: David Laight
> > Cc: Jia Hongtao-B38951; Wood Scott-B07421; =20
> linuxppc-dev@lists.ozlabs.org;
> > Stuart Yoder
> > Subject: Re: [PATCH V4] powerpc/85xx: Add machine check handler to =20
> fix
> > PCIe erratum on mpc85xx
> >
> > On 03/13/2013 04:40:40 AM, David Laight wrote:
> > > > Hmm, seems there's no probe_user_address() -- for userspace we
> > > > basically want the same thing minus the KERNEL_DS.  See
> > > > arch/powerpc/perf/callchain.c for an example.
> > >
> > > Isn't that just copy_from_user() ?
> >
> > Plus pagefault_disable/enable().
> >
> > -Scott
>=20
> pagefault_disable() is identical to preempt_disable(). So I think this
> could not avoid other cpu to swap out the instruction we want to read =20
> back.
> probe_kernel_address() also have the same issue.

That's not the point -- the point is to let the page fault handler know =20
that it should go directly to bad_page_fault().  Do not pass =20
handle_mm_fault().  Do not collect a page from disk.

Granted, we're already in atomic context which will have that effect =20
due to being in the machine check handler, but it's better to be =20
explicit about it and not depend on how pagefault_diasble() is =20
implemented.

-Scott=
