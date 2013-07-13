Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH RFC 5/8] dma: mpc512x: use symbolic specifiers for DMA
 channels
Date: Sat, 13 Jul 2013 09:17:08 +0200
References: <1373642781-32631-1-git-send-email-gsi@denx.de>
 <1373642781-32631-6-git-send-email-gsi@denx.de>
In-Reply-To: <1373642781-32631-6-git-send-email-gsi@denx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201307130917.08904.arnd@arndb.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vinod.koul@intel.com>,
 devicetree-discuss@lists.ozlabs.org, Alexander Popov <a13xp0p0v88@gmail.com>,
 Dan Williams <djbw@fb.com>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 12 July 2013, Gerhard Sittig wrote:
> +++ b/include/dt-bindings/dma/mpc512x-dma.h
> @@ -0,0 +1,21 @@
> +/*
> + * This header file provides symbolic specifiers for DMA channels
> + * within the MPC512x SoC's DMA controller.  Since requester lines
> + * directly map to channel numbers and no additional flexibility
> + * is involved, DMA channels can be considered directly associated
> + * with individual peripherals.
> + *
> + * This header file gets shared among DT bindings which provide
> + * hardware specs, and driver code which implements supporting logic.
> + */
> +
> +#ifndef _DT_BINDINGS_DMA_MPC512x_DMA_H
> +#define _DT_BINDINGS_DMA_MPC512x_DMA_H
> +
> +#define MPC512x_DMACHAN_SCLPC          26
> +#define MPC512x_DMACHAN_SDHC           30
> +#define MPC512x_DMACHAN_MDDRC          32
> +
> +#define MPC512x_DMACHAN_MAX            64
> +

I think these should not be in the header and should not bve part of the
binding either. They are specific to an SoC that happens to be using this
DMA controller but would be completely different for any other SoC with
the same DMA engine. These belong into the dma descriptors of the slave
drivers and don't need symbolic names.

	Arnd
