Return-Path: <B32579@freescale.com>
From: Kushwaha Prabhakar-B32579 <B32579@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH][v2] powerpc/85xx:Add BSC9131 RDB Support
Date: Wed, 21 Mar 2012 17:45:12 +0000
Message-ID: <071A08F2C6A57E4E94D980ECA553F8745B298F@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1331973588-29896-1-git-send-email-prabhakar@freescale.com>
 <6E492C67-B422-46B2-9A8E-C1E9B6C534E7@kernel.crashing.org>
 <071A08F2C6A57E4E94D980ECA553F8745B28E5@039-SN1MPN1-004.039d.mgd.msft.net>
 <F67F01CF-E431-42B7-BA59-EBC6A792FC69@kernel.crashing.org>
In-Reply-To: <F67F01CF-E431-42B7-BA59-EBC6A792FC69@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Srivastava Rajan-B34330 <B34330@freescale.com>,
 Mehresh Ramneek-B31383 <B31383@freescale.com>,
 Goyal Akhil-B35197 <B35197@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>,
 Jain Priyanka-B32167 <B32167@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks Kumar for clarifying my doubts.

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Wednesday, March 21, 2012 11:08 PM
> To: Kushwaha Prabhakar-B32579
> Cc: linuxppc-dev@lists.ozlabs.org; devicetree-discuss@lists.ozlabs.org;
> Jain Priyanka-B32167; Mehresh Ramneek-B31383; Srivastava Rajan-B34330;
> Goyal Akhil-B35197
> Subject: Re: [PATCH][v2] powerpc/85xx:Add BSC9131 RDB Support
>=20
>=20
> On Mar 21, 2012, at 12:29 PM, Kushwaha Prabhakar-B32579 wrote:
>=20
> >>
> >>
> >> [snip]
> >>
> >
> > ??
> > Not getting you..
>=20
> Just meant, I was removing parts of the patch in the email to reduce
> things.
>=20

Oh :)


> >
> >>> diff --git a/arch/powerpc/platforms/85xx/bsc913x_rdb.c
> >>> b/arch/powerpc/platforms/85xx/bsc913x_rdb.c
> >>> new file mode 100644
> >>> index 0000000..611c289
> >>> --- /dev/null
> >>> +++ b/arch/powerpc/platforms/85xx/bsc913x_rdb.c
> >>> @@ -0,0 +1,95 @@
> >>> +/*
> >>> + * BSC913xRDB Board Setup
> >>> + *
> >>> + * Author: Priyanka Jain <Priyanka.Jain@freescale.com>
> >>> + *
> >>> + * Copyright 2011-2012 Freescale Semiconductor Inc.
> >>> + *
> >>> + * This program is free software; you can redistribute  it and/or
> >>> +modify it
> >>> + * under  the terms of  the GNU General  Public License as
> >>> +published by the
> >>> + * Free Software Foundation;  either version 2 of the  License, or
> >>> +(at your
> >>> + * option) any later version.
> >>> + */
> >>> +
> >>> +#include <linux/of_platform.h>
> >>> +#include <linux/pci.h>
> >>> +#include <asm/mpic.h>
> >>> +#include <sysdev/fsl_soc.h>
> >>> +#include <asm/udbg.h>
> >>> +
> >>> +void __init bsc913x_rdb_pic_init(void) {
> >>> +	struct mpic *mpic;
> >>> +	struct resource r;
> >>> +	struct device_node *np;
> >>> +
> >>> +	np =3D of_find_node_by_type(NULL, "open-pic");
> >>> +	if (!np) {
> >>> +		pr_err("bsc913x: Could not find open-pic node\n");
> >>> +		return;
> >>> +	}
> >>> +
> >>> +	if (of_address_to_resource(np, 0, &r)) {
> >>> +		pr_err("bsc913x: Failed to map mpic register space\n");
> >>> +		of_node_put(np);
> >>> +		return;
> >>> +	}
> >>> +
> >>> +	mpic =3D mpic_alloc(np, r.start, MPIC_WANTS_RESET |
> >>> +	  MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS | MPIC_SINGLE_DEST_CPU,
> >>> +	  0, 256, " OpenPIC  ");
> >>> +
> >>> +	of_node_put(np);
> >>> +
> >>> +	if (!mpic)
> >>> +		pr_err("bsc913x: Failed to allocate MPIC structure\n");
> >>> +	else
> >>> +		mpic_init(mpic);
> >>> +}
> >>> +
> >>
> >> This code is still out of date w/other board ports.  Have you tried
> >> building this against upstream??
> >>
> >
> > I build with powerpc.git.
> > do you mean build with upstream code base ??
> > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> >
>=20
> I mean if you use my 'next' branch of galak/powerpc.git and apply this
> patch, and enable it.  For example MPIC_BROKEN_FRR_NIRQS doesn't exist
> anymore
>=20


I did on master branch. I will check on "next" branch and if required send =
new patch version.

--Prabhakar
