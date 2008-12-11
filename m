Return-Path: <gregkh@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5F88ADDE26
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2008 07:54:45 +1100 (EST)
Date: Thu, 11 Dec 2008 12:50:33 -0800
From: Greg KH <gregkh@suse.de>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [RESEND][PATCH] uio: Add of_platform_driver to uio_pdrv_genirq
Message-ID: <20081211205033.GA7080@suse.de>
References: <1229007937-5501-1-git-send-email-w.sang@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1229007937-5501-1-git-send-email-w.sang@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, hjk@linutronix.de, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 11, 2008 at 04:05:37PM +0100, Wolfram Sang wrote:
> Make the generic uio-driver also accessible for of devices. It utilizes the
> standard 'reg' and 'interrupt' properties. A typical usage would look like
> this:
> 
> 	fpga-io@00003000 {
> 		compatible = "generic-uio";
> 		reg = <0x00003000 0x20>;
> 		interrupts = <0xa>;
> 		interrupt-parent = <&fpga_irq_mux>;
> 	};
> 
> To achieve this, the probe function has been refactored, so it can be used by
> platform and of code. Then, the of driver has been added.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
>  drivers/uio/uio_pdrv_genirq.c |  178 ++++++++++++++++++++++++++++++++++++------
>  1 file changed, 154 insertions(+), 24 deletions(-)
> 
> Index: playground/drivers/uio/uio_pdrv_genirq.c
> ===================================================================
> --- playground.orig/drivers/uio/uio_pdrv_genirq.c
> +++ playground/drivers/uio/uio_pdrv_genirq.c
> @@ -1,13 +1,15 @@
>  /*
>   * drivers/uio/uio_pdrv_genirq.c
>   *
> - * Userspace I/O platform driver with generic IRQ handling code.
> + * Userspace I/O platform & of driver with generic IRQ handling code.
>   *
>   * Copyright (C) 2008 Magnus Damm
> + * Copyright (C) 2008 Wolfram Sang, Pengutronix e.K.
>   *
>   * Based on uio_pdrv.c by Uwe Kleine-Koenig,
>   * Copyright (C) 2008 by Digi International Inc.
>   * All rights reserved.
> + * Adding of_platform_driver based on xilinxfb.c by Grant Likely.
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License version 2 as published by
> @@ -20,6 +22,10 @@
>  #include <linux/bitops.h>
>  #include <linux/interrupt.h>
>  #include <linux/stringify.h>
> +#if defined(CONFIG_OF)
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +#endif

You should never need to test a config variable in order to know to
include a header file or not.

> +/* ---------------------------------------------------------------------
> + * OF bus binding
> + */
> +
> +#if defined(CONFIG_OF)

Same goes here, don't put #if in .c files please.

thanks,

greg k-h
