Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3368B1A003C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 03:10:19 +1100 (AEDT)
Message-ID: <1455207007.2463.23.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Denis Kirjanov <kda@linux-powerpc.org>, Alessio Igor Bogani
 <alessio.bogani@elettra.eu>
Cc: Kumar Gala <galak@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Thu, 11 Feb 2016 10:10:07 -0600
In-Reply-To: <CAOJe8K2TFtppS4ni=ZCL=p853jO=ewjp3i+wOAQpVeSb7BFkUw@mail.gmail.com>
References: <1455177651-6686-1-git-send-email-alessio.bogani@elettra.eu>
 <CAOJe8K2TFtppS4ni=ZCL=p853jO=ewjp3i+wOAQpVeSb7BFkUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH v2 1/1] powerpc/86xx: Consolidate common platform code
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-02-11 at 12:21 +0300, Denis Kirjanov wrote:
> On 2/11/16, Alessio Igor Bogani <alessio.bogani@elettra.eu> wrote:
> > Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
> > ---
> > v1 -> v2
> > 	Use appropriate [PATCH] prefix
> > 
> >  arch/powerpc/platforms/86xx/Makefile       |  2 +-
> >  arch/powerpc/platforms/86xx/common.c       | 42
> > ++++++++++++++++++++++++++++++
> >  arch/powerpc/platforms/86xx/gef_ppc9a.c    | 32 +----------------------
> >  arch/powerpc/platforms/86xx/gef_sbc310.c   | 32 +----------------------
> >  arch/powerpc/platforms/86xx/gef_sbc610.c   | 32 +----------------------
> >  arch/powerpc/platforms/86xx/mpc8610_hpcd.c | 20 ++------------
> >  arch/powerpc/platforms/86xx/mpc86xx.h      |  2 ++
> >  arch/powerpc/platforms/86xx/mpc86xx_hpcn.c | 21 +--------------
> >  arch/powerpc/platforms/86xx/sbc8641d.c     | 32 +----------------------
> >  9 files changed, 52 insertions(+), 163 deletions(-)
> >  create mode 100644 arch/powerpc/platforms/86xx/common.c
> > 
> > diff --git a/arch/powerpc/platforms/86xx/Makefile
> > b/arch/powerpc/platforms/86xx/Makefile
> > index ede815d..2d889ad 100644
> > --- a/arch/powerpc/platforms/86xx/Makefile
> > +++ b/arch/powerpc/platforms/86xx/Makefile
> > @@ -2,7 +2,7 @@
> >  # Makefile for the PowerPC 86xx linux kernel.
> >  #
> > 
> > -obj-y				:= pic.o
> > +obj-y				:= pic.o common.o
> >  obj-$(CONFIG_SMP)		+= mpc86xx_smp.o
> >  obj-$(CONFIG_MPC8641_HPCN)	+= mpc86xx_hpcn.o
> >  obj-$(CONFIG_SBC8641D)		+= sbc8641d.o
> > diff --git a/arch/powerpc/platforms/86xx/common.c
> > b/arch/powerpc/platforms/86xx/common.c
> > new file mode 100644
> > index 0000000..bee3177
> > --- /dev/null
> > +++ b/arch/powerpc/platforms/86xx/common.c
> > @@ -0,0 +1,42 @@
> > +/*
> > + * Routines common to most mpc86xx-based boards.
> > + *
> > + * This is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/of_platform.h>
> > +
> > +#include "mpc86xx.h"
> > +
> > +static const struct of_device_id mpc86xx_common_ids[] __initconst = {
> > +	{ .type = "soc", },
> > +	{ .compatible = "soc", },
> > +	{ .compatible = "simple-bus", },
> > +	{ .name = "localbus", },
> > +	{ .compatible = "gianfar", },
> > +	{ .compatible = "fsl,mpc8641-pcie", },
> > +	{},
> > +};
> > +
> > +int __init mpc86xx_common_publish_devices(void)
> > +{
> > +	return of_platform_bus_probe(NULL, mpc86xx_common_ids, NULL);
> > +}
> > +
> > +long __init mpc86xx_time_init(void)
> > +{
> > +	unsigned int temp;
> > +
> > +	/* Set the time base to zero */
> > +	mtspr(SPRN_TBWL, 0);
> > +	mtspr(SPRN_TBWU, 0);
> > +
> > +	temp = mfspr(SPRN_HID0);
> > +	temp |= HID0_TBEN;
> > +	mtspr(SPRN_HID0, temp);
> > +	asm volatile("isync");
> While we're here you could just use isync()
> 

Could you please trim the part of the mail you're not replying to?  It takes a
while to scan to find where the reply actually is.

-Scott
