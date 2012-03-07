Return-Path: <hartleys@visionengravers.com>
Received: from mail160.messagelabs.com (mail160.messagelabs.com
 [216.82.253.99])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail160.messagelabs.com",
 Issuer "VeriSign Class 3 International Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4475EB6F62
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2012 11:50:23 +1100 (EST)
From: H Hartley Sweeten <hartleys@visionengravers.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Dan Williams
 <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>
Date: Tue, 6 Mar 2012 18:47:54 -0600
Subject: RE: [PATCH 3/9] dmaengine: add private header file
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F41FF559AA@AUSP01VMBX24.collaborationhost.net>
References: <20120306223321.GD15201@n2100.arm.linux.org.uk>
 <E1S52xe-0002Mn-Pn@rmk-PC.arm.linux.org.uk>
In-Reply-To: <E1S52xe-0002Mn-Pn@rmk-PC.arm.linux.org.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Stephen Warren <swarren@nvidia.com>,
 Linus Walleij <linus.walleij@stericsson.com>,
 Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>,
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

On Tuesday, March 06, 2012 3:34 PM, Russell King wrote:
>
> Add a local private header file to contain definitions and declarations
> which should only be used by DMA engine drivers.
>
> We also fix linux/dmaengine.h to use LINUX_DMAENGINE_H to guard against
> multiple inclusion.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---

<snip>

>  drivers/dma/dmaengine.h     |   10 ++++++++++

<snip>

>  drivers/dma/ep93xx_dma.c    |    2 ++

<snip>

>  include/linux/dmaengine.h   |    4 ++--

<snip>

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

<snip>

> diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
> index bc45787..3260198 100644
> --- a/drivers/dma/ep93xx_dma.c
> +++ b/drivers/dma/ep93xx_dma.c
> @@ -28,6 +28,8 @@
> =20
>  #include <mach/dma.h>
> =20
> +#include "dmaengine.h"
> +
>  /* M2P registers */
>  #define M2P_CONTROL			0x0000
>  #define M2P_CONTROL_STALLINT		BIT(0)

<snip>

> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 41d0f92..4b17ca8 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -18,8 +18,8 @@
>   * The full GNU General Public License is included in this distribution =
in the
>   * file called COPYING.
>   */
> -#ifndef DMAENGINE_H
> -#define DMAENGINE_H
> +#ifndef LINUX_DMAENGINE_H
> +#define LINUX_DMAENGINE_H
> =20
>  #include <linux/device.h>
>  #include <linux/uio.h>

For ep93xx:

Tested-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
