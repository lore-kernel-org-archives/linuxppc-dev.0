Return-Path: <B38951@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 634432C00CC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 13:48:58 +1100 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>, David Laight
 <David.Laight@ACULAB.COM>
Subject: RE: [PATCH V4] powerpc/85xx: Add machine check handler to fix PCIe
 erratum on mpc85xx
Date: Fri, 15 Mar 2013 02:47:58 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01C18FD6@039-SN1MPN1-003.039d.mgd.msft.net>
References: <412C8208B4A0464FA894C5F0C278CD5D01C15369@039-SN1MPN1-003.039d.mgd.msft.net>
 <1363123452.17135.13@snotra>
 <AE90C24D6B3A694183C094C60CF0A2F6026B7186@saturn3.aculab.com>
 <1363192659.8945.1@snotra>
In-Reply-To: <1363192659.8945.1@snotra>
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
> From: Wood Scott-B07421
> Sent: Thursday, March 14, 2013 12:38 AM
> To: David Laight
> Cc: Jia Hongtao-B38951; Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org;
> Stuart Yoder
> Subject: Re: [PATCH V4] powerpc/85xx: Add machine check handler to fix
> PCIe erratum on mpc85xx
>=20
> On 03/13/2013 04:40:40 AM, David Laight wrote:
> > > Hmm, seems there's no probe_user_address() -- for userspace we
> > > basically want the same thing minus the KERNEL_DS.  See
> > > arch/powerpc/perf/callchain.c for an example.
> >
> > Isn't that just copy_from_user() ?
>=20
> Plus pagefault_disable/enable().
>=20
> -Scott

pagefault_disable() is identical to preempt_disable(). So I think this
could not avoid other cpu to swap out the instruction we want to read back.
probe_kernel_address() also have the same issue.

Does this mean we can't just use pagefault_disable() to prevent from gettin=
g
the wrong instruction?

-Hongtao.
