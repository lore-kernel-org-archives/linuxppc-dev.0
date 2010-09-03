Return-Path: <rdunlap@xenotime.net>
Received: from xenotime.net (xenotime.net [72.52.115.56])
	by ozlabs.org (Postfix) with SMTP id 41E62B7163
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  4 Sep 2010 08:56:49 +1000 (EST)
Received: from chimera.site ([173.50.240.230]) by xenotime.net for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 3 Sep 2010 15:44:00 -0700
Date: Fri, 3 Sep 2010 15:44:00 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: [PATCH RFCv1 2/3] fpga: add CARMA DATA-FPGA Access Driver
Message-Id: <20100903154400.5f5ae7b4.rdunlap@xenotime.net>
In-Reply-To: <1283553052-23576-3-git-send-email-iws@ovro.caltech.edu>
References: <1283553052-23576-1-git-send-email-iws@ovro.caltech.edu>
	<1283553052-23576-3-git-send-email-iws@ovro.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri,  3 Sep 2010 15:30:51 -0700 Ira W. Snyder wrote:

> This driver allows userspace to access the data processing FPGAs on the
> OVRO CARMA board. It has two modes of operation:
> 
> 1) random access
> 
> This allows users to poke any DATA-FPGA registers by using mmap to map
> the address region directly into their memory map.
> 
> 2) correlation dumping
> 
> When correlating, the DATA-FPGA's have special requirements for getting
> the data out of their memory before the next correlation. This nominally
> happens at 64Hz (every 15.625ms). If the data is not dumped before the
> next correlation, data is lost.
> 
> The data dumping driver handles buffering up to 1 second worth of
> correlation data from the FPGAs. This lowers the realtime scheduling
> requirements for the userspace process reading the device.
> 
> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
> ---
>  drivers/fpga/carma/Kconfig      |    9 +
>  drivers/fpga/carma/Makefile     |    1 +
>  drivers/fpga/carma/carma-fpga.c | 1447 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1457 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/fpga/carma/carma-fpga.c
> 
> diff --git a/drivers/fpga/carma/Kconfig b/drivers/fpga/carma/Kconfig
> index 448885e..5592f73 100644
> --- a/drivers/fpga/carma/Kconfig
> +++ b/drivers/fpga/carma/Kconfig
> @@ -18,4 +18,13 @@ config CARMA
>  	  Say Y here to include basic support for the CARMA System Controller
>  	  FPGA. This option allows the other more advanced drivers to be built.
>  
> +config CARMA_FPGA
> +	tristate "CARMA DATA-FPGA Access Driver"
> +	depends on CARMA
> +	select VIDEOBUF_DMA_SG

You can't safely select VIDEOBUF_DMA_SG unless MEDIA_SUPPORT && HAS_DMA are
enabled, so I would add
	depends on MEDIA_SUPPORT && HAS_DMA
to this config symbol.


> +	default n
> +	help
> +	  Say Y here to include support for communicating with the data
> +	  processing FPGAs on the CARMA board.
> +
>  endif # FPGA_DRIVERS

> diff --git a/drivers/fpga/carma/carma-fpga.c b/drivers/fpga/carma/carma-fpga.c
> new file mode 100644
> index 0000000..ab1b536
> --- /dev/null
> +++ b/drivers/fpga/carma/carma-fpga.c
> @@ -0,0 +1,1447 @@
> +/*
> + * Free a single data buffer and all allocated pages
> + *
> + * This will free all of the pages allocated to the given data buffer, and
> + * then free the structure itself
> + *
> + * @dev: the DMA device to map for
> + * @buf: the buffer to free
> + */
> +static void data_free_buffer(struct device *dev, struct data_buf *buf)
> +{

The comments above are OK, but please don't add the (doxygen?) style comments
as below (this is just one example of multiple occurrences).
Specifically, the "@param" parts.
It would be better to use the style above (if not using kernel-doc notation).


> +/*
> + * Prepare and submit a DMA_SLAVE transaction for a correlation data buffer
> + *
> + * LOCKING: must hold dev->lock
> + * CONTEXT: hardirq only
> + *
> + * @param priv the driver's private data structure
> + * @param buf the data buffer to DMA into
> + * @return 0 on success, -ERRNO otherwise
> + */
> +static int data_submit_dma(struct fpga_device *priv, struct data_buf *buf)
> +{


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
