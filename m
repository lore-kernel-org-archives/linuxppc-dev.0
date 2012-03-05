Return-Path: <hartleys@visionengravers.com>
Received: from mail127.messagelabs.com (mail127.messagelabs.com
 [216.82.250.115])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail127.messagelabs.com",
 Issuer "VeriSign Class 3 International Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 012B9B6FA4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 10:31:34 +1100 (EST)
From: H Hartley Sweeten <hartleys@visionengravers.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Dan Williams
 <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>
Date: Mon, 5 Mar 2012 17:28:50 -0600
Subject: RE: [PATCH 3/9] dmaengine: add private header file
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F41FF555A9@AUSP01VMBX24.collaborationhost.net>
References: <20120305201411.GA17791@n2100.arm.linux.org.uk>
 <E1S4eK0-0000sv-87@rmk-PC.arm.linux.org.uk>
In-Reply-To: <E1S4eK0-0000sv-87@rmk-PC.arm.linux.org.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Viresh Kumar <viresh.kumar@st.com>, Stephen Warren <swarren@nvidia.com>,
 Linus Walleij <linus.walleij@stericsson.com>,
 Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>,
 Zhang Wei <zw@zh-kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday, March 05, 2012 1:16 PM, Russell King wrote:
>
> Add a local private header file to contain definitions and declarations
> which should only be used by DMA engine drivers.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/dma/amba-pl08x.c    |    2 ++
>  drivers/dma/at_hdmac.c      |    1 +
>  drivers/dma/coh901318.c     |    1 +
>  drivers/dma/dmaengine.h     |   10 ++++++++++
>  drivers/dma/dw_dmac.c       |    1 +
>  drivers/dma/ep93xx_dma.c    |    2 ++
>  drivers/dma/fsldma.c        |    1 +
>  drivers/dma/imx-dma.c       |    2 ++
>  drivers/dma/imx-sdma.c      |    2 ++
>  drivers/dma/intel_mid_dma.c |    2 ++
>  drivers/dma/ioat/dma.c      |    2 ++
>  drivers/dma/ioat/dma_v2.c   |    2 ++
>  drivers/dma/iop-adma.c      |    2 ++
>  drivers/dma/ipu/ipu_idmac.c |    1 +
>  drivers/dma/mpc512x_dma.c   |    2 ++
>  drivers/dma/mv_xor.c        |    2 ++
>  drivers/dma/mxs-dma.c       |    2 ++
>  drivers/dma/pch_dma.c       |    2 ++
>  drivers/dma/pl330.c         |    2 ++
>  drivers/dma/ppc4xx/adma.c   |    1 +
>  drivers/dma/shdma.c         |    2 ++
>  drivers/dma/ste_dma40.c     |    1 +
>  drivers/dma/timb_dma.c      |    2 ++
>  drivers/dma/txx9dmac.c      |    2 ++
>  24 files changed, 49 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/dma/dmaengine.h
>
> diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
> index 2b5121f..87475cb 100644
> --- a/drivers/dma/amba-pl08x.c
> +++ b/drivers/dma/amba-pl08x.c
> @@ -85,6 +85,8 @@
>  #include <linux/slab.h>
>  #include <asm/hardware/pl080.h>
> =20
> +#include "dmaengine.h"
> +
>  #define DRIVER_NAME	"pl08xdmac"
> =20
>  static struct amba_driver pl08x_amba_driver;
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index 6baf5d7..ce26ba3 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -27,6 +27,7 @@
>  #include <linux/of_device.h>
> =20
>  #include "at_hdmac_regs.h"
> +#include "dmaengine.h"
> =20
>  /*
>   * Glossary
> diff --git a/drivers/dma/coh901318.c b/drivers/dma/coh901318.c
> index 521434b..fb0d124 100644
> --- a/drivers/dma/coh901318.c
> +++ b/drivers/dma/coh901318.c
> @@ -24,6 +24,7 @@
>  #include <mach/coh901318.h>
> =20
>  #include "coh901318_lli.h"
> +#include "dmaengine.h"
> =20
>  #define COHC_2_DEV(cohc) (&cohc->chan.dev->device)
> =20
> diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
> new file mode 100644
> index 0000000..968570d
> --- /dev/null
> +++ b/drivers/dma/dmaengine.h
> @@ -0,0 +1,10 @@
> +/*
> + * The contents of this file are private to DMA engine drivers, and is n=
ot
> + * part of the API to be used by DMA engine users.
> + */
> +#ifndef DMAENGINE_H
> +#define DMAENGINE_H
> +
> +#include <linux/dmaengine.h>
> +
> +#endif

Russell,

You have an include issue here.

All the dmaengine drivers have:

#include <linux/dmaengine.h>

Which is guarded with

#ifndef DMAENGINE_H
#define DMAENGINE_H

...

#endif

This is the same guard you are using in the private "dmaengine.h". And it
also includes <linux/dmaengine.h> again...

This doesn't compile as-is because the "dmaengine.h" file is not used due
to the #ifndef...

Regards,
Hartley
