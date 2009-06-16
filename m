Return-Path: <dan.j.williams@intel.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8463EB7181
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 05:01:44 +1000 (EST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by ozlabs.org (Postfix) with ESMTP id 145C0DDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 05:01:42 +1000 (EST)
Message-ID: <4A37EC14.5010005@intel.com>
Date: Tue, 16 Jun 2009 12:01:40 -0700
From: Dan Williams <dan.j.williams@intel.com>
MIME-Version: 1.0
To: Ira Snyder <iws@ovro.caltech.edu>
Subject: Re: [RFC PATCH] fsldma: Add DMA_SLAVE support
References: <20090515225659.GD858@ovro.caltech.edu>
In-Reply-To: <20090515225659.GD858@ovro.caltech.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ira,

Ira Snyder wrote:
> Use the DMA_SLAVE capability of the DMAEngine API to copy/from a
> scatterlist into an arbitrary list of hardware address/length pairs.
> 
> This allows a single DMA transaction to copy data from several different
> devices into a scatterlist at the same time.
> 
> This also adds support to enable some controller-specific features such as
> external start and external pause of a DMA transaction.
> 
> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
> ---
> 
> This is a request for comments on this patch. I hunch it is not quite
> ready for inclusion, though it is certainly ready for review. Correct
> functioning of this patch depends on the patches submitted earlier.
> 
> As suggested by Dan Williams, I implemented DMA_SLAVE support for the
> fsldma controller to allow me to use the hardware to transfer to/from a
> scatterlist to a list of hardware address/length pairs.
> 
> I implemented support for the extra features available in the DMA
> controller, such as external pause and external start. I have not tested
> the features yet. I am willing to drop the support if everything else
> looks good.
> 
> I have implemented helper functions for creating the list of hardware
> address/length pairs as static inline functions in the linux/fsldma.h
> header. Should I incorporate these into the driver itself and use
> EXPORT_SYMBOL()? I've never done this before :)

Using EXPORT_SYMBOL would defeat the purpose of conforming to the 
dmaengine api which should allow other subsystems to generically 
discover an fsldma resource.

> diff --git a/include/linux/fsldma.h b/include/linux/fsldma.h
> new file mode 100644
> index 0000000..a42dcdd
> --- /dev/null
> +++ b/include/linux/fsldma.h
> @@ -0,0 +1,105 @@
> +/*
> + * Freescale MPC83XX / MPC85XX DMA Controller
> + *
> + * Copyright (c) 2009 Ira W. Snyder <iws@ovro.caltech.edu>
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2. This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +#ifndef __LINUX_FSLDMA_H__
> +#define __LINUX_FSLDMA_H__
> +
> +#include <linux/dmaengine.h>
> +
> +/*
> + * physical hardware address / length pair for use with the
> + * DMAEngine DMA_SLAVE API
> + */
> +struct fsl_dma_hw_addr {
> +       struct list_head entry;
> +
> +       dma_addr_t address;
> +       size_t length;
> +};

Can you explain a bit more why you need the new dma address list, would 
a struct scatterlist suffice?

In general it is difficult to merge new functionality without an in-tree 
user.  Can you share the client of this new api?

I suspect you can get away without needing these new helper routines. 
Have a look at how Haavard implemented his DMA_SLAVE client in 
drivers/mmc/host/atmel-mci.c.

Haavard ended up needing to add some public structure definitions to 
include/linux, but my preference is to keep this in an 
architecture/platform specific header file location if possible.

Regards,
Dan
