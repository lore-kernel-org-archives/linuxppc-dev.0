Return-Path: <randy.dunlap@oracle.com>
Received: from rgminet01.oracle.com (rgminet01.oracle.com [148.87.113.118])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 64E5EDDEE8
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Sep 2007 01:59:29 +1000 (EST)
Date: Fri, 7 Sep 2007 08:58:45 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Zhang Wei <wei.zhang@freescale.com>
Subject: Re: [PATCH 5/5] Add DMA engine driver for Freescale MPC85xx
	processors.
Message-Id: <20070907085845.54dc88f8.randy.dunlap@oracle.com>
In-Reply-To: <11891624582950-git-send-email-wei.zhang@freescale.com>
References: <11891624582950-git-send-email-wei.zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: shannon.nelson@intel.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri,  7 Sep 2007 18:54:18 +0800 Zhang Wei wrote:

> Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
> Signed-off-by: Ebony Zhu <ebony.zhu@freescale.com>
> ---
>  drivers/dma/Kconfig  |    8 +
>  drivers/dma/Makefile |    1 +
>  drivers/dma/fsldma.c |  995 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/dma/fsldma.h |  188 ++++++++++
>  4 files changed, 1192 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/dma/fsldma.c
>  create mode 100644 drivers/dma/fsldma.h
> 
> --- /dev/null
> +++ b/drivers/dma/fsldma.c
> @@ -0,0 +1,995 @@

Thanks for using kernel-doc notation.  However, ...

> +/**
> + * fsl_dma_alloc_descriptor - Allocate descriptor from channel's DMA pool.

Function parameters need to be listed & described here.
See Documentation/kernel-doc-nano-HOWTO.txt or other source files
for examples.

(Applies to all documented function interfaces here.)

> + *
> + * Return - The descriptor allocated. NULL for failed.
> + */
> +static struct fsl_desc_sw *fsl_dma_alloc_descriptor(
> +					struct fsl_dma_chan *fsl_chan,
> +					gfp_t flags)
> +{
...
> +}

> +/**
> + * fsl_chan_xfer_ld_queue -- Transfer the link descriptors in channel
> + *                           ld_queue.

The function's "short description" (unfortunately) must be on only one
line.  E.g.:

 * fsl_chan_xfer_ld_queue - Transfer link descriptors in channel ld_queue.

> + */
> +static void fsl_chan_xfer_ld_queue(struct fsl_dma_chan *fsl_chan)
> +{
...
> +}

> diff --git a/drivers/dma/fsldma.h b/drivers/dma/fsldma.h
> new file mode 100644
> index 0000000..05be9ed
> --- /dev/null
> +++ b/drivers/dma/fsldma.h
> @@ -0,0 +1,188 @@
> +struct fsl_dma_chan_regs {
> +	__mix32	mr;		/* 0x00 - Mode Register */
> +	__mix32	sr;		/* 0x04 - Status Register */
> +	__mix64	cdar;		/* 0x08 - Cureent descriptor address register */

                                          Current

> +	__mix64	sar;		/* 0x10 - Source Address Register */
> +	__mix64	dar;		/* 0x18 - Destination Address Register */
> +	__mix32	bcr;		/* 0x20 - Byte Count Register */
> +	__mix64	ndar;		/* 0x24 - Next Descriptor Address Register */
> +};

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
