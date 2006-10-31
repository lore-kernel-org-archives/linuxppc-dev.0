Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 5EA3067D0D
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Oct 2006 16:33:20 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k9V6sMh6025866
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Oct 2006 23:54:22 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k9V5XGgW004742
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Oct 2006 23:33:18 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] qe_lib: Remove immrbar_virt_to_phys() function
Date: Tue, 31 Oct 2006 13:34:03 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D26331A@zch01exm20.fsl.freescale.net>
In-Reply-To: <58EAF2FD-1812-45C8-A042-9009EC7BFF49@kernel.crashing.org>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Tuesday, October 31, 2006 1:30 PM
> To: Li Yang-r58472
> Cc: Paul Mackerras; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] qe_lib: Remove immrbar_virt_to_phys() function
>=20
>=20
> On Oct 30, 2006, at 11:25 PM, Li Yang-r58472 wrote:
>=20
> >> -----Original Message-----
> >> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> >> Sent: Tuesday, October 31, 2006 1:06 PM
> >> To: Li Yang-r58472
> >> Cc: Paul Mackerras; linuxppc-dev@ozlabs.org
> >> Subject: Re: [PATCH] qe_lib: Remove immrbar_virt_to_phys() function
> >>
> >>
> >> On Oct 30, 2006, at 8:56 PM, Li Yang-r58472 wrote:
> >>
> >>>>>> I'm confused, if there are other users of immrbar_virt_to_phy()
> > how
> >>>>>> can you get ride of it completely?
> >>>>>
> >>>>> Other users will change to use iopa() instead.  There was some
bug
> >>> to
> >>>>> use iopa() with io_block_mapping area, but it is ok to use it
now.
> >>>>
> >>>> Hmm, what are the other users doing?  I think we should avoid
using
> >>>> iopa.
> >>>
> >>> Get physical address from virtual address.  I have considered to
use
> >>> virt_to_phys(), but it is not consistent between ppc and powerpc
> > arch.
> >>
> >> Why does that matter, qe support only exists in powerpc.
> >
> > Well, it does use include/asm-ppc/io.h instead of
> > include/asm-powerpc/io.h for now.  If the hack is removed, the
driver
> > will not work.
>=20
> What uses asm-ppc/io.h instead of asm-powerpc/io.h?

You can look into the asm-powerpc/io.h.  We have hack like this

#ifndef CONFIG_PPC64
#include <asm-ppc/io.h>
#else
........
{whole bunch of defines}
.........
#endif

- Leo
