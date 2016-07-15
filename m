Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrpcr4X95zDr13
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jul 2016 09:27:07 +1000 (AEST)
Date: Fri, 15 Jul 2016 18:39:33 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Scott Wood <oss@buserror.net>
CC: Yangbo Lu <yangbo.lu@nxp.com>, <linux-mmc@vger.kernel.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <linux-i2c@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
 netdev <netdev@vger.kernel.org>, <ulf.hansson@linaro.org>,
 Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Russell King <linux@arm.linux.org.uk>, Jochen Friedrich
 <jochen@scram.de>, Joerg Roedel <joro@8bytes.org>, Claudiu Manoil
 <claudiu.manoil@freescale.com>, Bhupesh Sharma
 <bhupesh.sharma@freescale.com>, Qiang Zhao <qiang.zhao@nxp.com>, Kumar Gala
 <galak@codeaurora.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, <leoyang.li@nxp.com>,
 <xiaobo.xie@nxp.com>
Subject: Re: [v10, 3/7] soc: fsl: add GUTS driver for QorIQ platforms
Message-ID: <20160715223932.GC10758@windriver.com>
References: <1462417950-46796-1-git-send-email-yangbo.lu@nxp.com>
 <1462417950-46796-4-git-send-email-yangbo.lu@nxp.com>
 <CAP=VYLqsV_M=8CM47k4kzdULCp_y0yP9t8Sq9=jFp6W593QJgw@mail.gmail.com>
 <1468609977.25630.5.camel@buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <1468609977.25630.5.camel@buserror.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[Re: [v10, 3/7] soc: fsl: add GUTS driver for QorIQ platforms] On 15/07/2016 (Fri 14:12) Scott Wood wrote:

> On Fri, 2016-07-15 at 12:43 -0400, Paul Gortmaker wrote:
> > > +source "drivers/soc/fsl/qe/Kconfig"

[...]

> > > +
> > > +config FSL_GUTS
> > > +       bool
> > > diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
> > > index 203307f..02afb7f 100644
> > > --- a/drivers/soc/fsl/Makefile
> > > +++ b/drivers/soc/fsl/Makefile
> > > @@ -4,3 +4,4 @@
> > > 
> > >  obj-$(CONFIG_QUICC_ENGINE)             += qe/
> > >  obj-$(CONFIG_CPM)                      += qe/
> > > +obj-$(CONFIG_FSL_GUTS)                 += guts.o
> > > diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
> > > new file mode 100644
> > > index 0000000..fa155e6
> > > --- /dev/null
> > > +++ b/drivers/soc/fsl/guts.c
> > > @@ -0,0 +1,119 @@
> > > +/*
> > > + * Freescale QorIQ Platforms GUTS Driver
> > > + *
> > > + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> > > + *
> > > + * This program is free software; you can redistribute it and/or modify
> > > + * it under the terms of the GNU General Public License as published by
> > > + * the Free Software Foundation; either version 2 of the License, or
> > > + * (at your option) any later version.
> > > + */
> > > +
> > > +#include <linux/io.h>
> > > +#include <linux/module.h>
> > Seems there was lots of discussion on this.  If it does end up being
> > resent, it would be nice to get the module.h and other modular stuff
> > gone since it is a bool Kconfig.
> 
> I plan to resend just the GUTS driver portion and send it through the PPC
> tree.
> 
> I don't see any modular stuff in there besides the linux/module.h include.

Great.  Normally I'm seeing the MODULE_DEVICE_TABLE and MODULE_AUTHOR
and MODULE_LICENSE etc, so it has (unfortunately) become a knee jerk
reaction to assume the latter follows a module.h presence...  thanks for
removing the extraneous include.

Paul.
--

> 
> -Scott
> 
> 
