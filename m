Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8CBB42C00B8
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Jul 2013 02:22:10 +1000 (EST)
Received: from mail177-co1 (localhost [127.0.0.1])	by
 mail177-co1-R.bigfish.com (Postfix) with ESMTP id A6030B001D3	for
 <linuxppc-dev@ozlabs.org>; Tue, 23 Jul 2013 16:22:06 +0000 (UTC)
Received: from CO1EHSMHS016.bigfish.com (unknown [10.243.78.247])	by
 mail177-co1.bigfish.com (Postfix) with ESMTP id 44B49A8004A	for
 <linuxppc-dev@ozlabs.org>; Tue, 23 Jul 2013 16:22:04 +0000 (UTC)
Date: Tue, 23 Jul 2013 11:22:00 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [3/4] powerpc/85xx: Add C293PCIE board support
To: Liu Po-B43644 <B43644@freescale.com>
References: <1366854857-22791-3-git-send-email-Po.Liu@freescale.com>
 <20130722225835.GA26484@home.buserror.net>
 <D473A0D087F4EA47A30C37E4637E25E609DAD260@039-SN2MPN1-021.039d.mgd.msft.net>
In-Reply-To: <D473A0D087F4EA47A30C37E4637E25E609DAD260@039-SN2MPN1-021.039d.mgd.msft.net>
 (from B43644@freescale.com on Tue Jul 23 02:47:18 2013)
Message-ID: <1374596520.15592.26@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Hu Mingkai-B21284 <B21284@freescale.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/23/2013 02:47:18 AM, Liu Po-B43644 wrote:
> >  > +		partition@1900000 {
> >  > +			/* 7MB for User Area */
> >  > +			reg =3D <0x01900000 0x00700000>;
> >  > +			label =3D "NAND User area";
> >  > +		};
> >
> >  Above you say there's 4 GiB of NAND, but here you define =20
> partitions that
> >  only cover 32 MiB.
> Can I set one partion include all other space(4GB- 32MB) with label =20
> name "Others"?

Are you sure you don't want to leave more room for the RFS?  And what =20
is the difference between "user area" and "others"?

> >  > diff --git a/arch/powerpc/platforms/85xx/c293pcie.c
> >  > b/arch/powerpc/platforms/85xx/c293pcie.c
> >  > new file mode 100644
> >  > index 0000000..75dda12
> >  > --- /dev/null
> >  > +++ b/arch/powerpc/platforms/85xx/c293pcie.c
> >  > @@ -0,0 +1,82 @@
> >  > +/*
> >  > + * C293PCIE Board Setup
> >  > + *
> >  > + * Copyright 2013 Freescale Semiconductor Inc.
> >  > + *
> >  > + * This program is free software; you can redistribute  it =20
> and/or
> >  > +modify it
> >  > + * under  the terms of  the GNU General  Public License as =20
> published
> >  > +by the
> >  > + * Free Software Foundation;  either version 2 of the  License, =20
> or
> >  > +(at your
> >  > + * option) any later version.
> >  > + */
> >  > +
> >  > +#include <linux/stddef.h>
> >  > +#include <linux/kernel.h>
> >  > +#include <linux/pci.h>
> >  > +#include <linux/delay.h>
> >  > +#include <linux/interrupt.h>
> >  > +#include <linux/of_platform.h>
> >  > +
> >  > +#include <asm/time.h>
> >  > +#include <asm/machdep.h>
> >  > +#include <asm/pci-bridge.h>
> >  > +#include <mm/mmu_decl.h>
> >  > +#include <asm/prom.h>
> >  > +#include <asm/udbg.h>
> >  > +#include <asm/mpic.h>
> >  > +
> >  > +#include <sysdev/fsl_soc.h>
> >  > +#include <sysdev/fsl_pci.h>
> >  > +
> >  > +#include "mpc85xx.h"
> >
> >  Are you sure you need all of these?  I don't see any delays, for =20
> example.
> Thanks, I'll test and remove redundant includes.

Don't base it purely on testing -- you don't want to rely on =20
accidentally picking up a needed include from some other include (which =20
could change down the road).  Base it on whether this file uses =20
something declared by the header in question.

-Scott=
