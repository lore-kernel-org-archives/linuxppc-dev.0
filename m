Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 54EB5DDDF9
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 00:25:28 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lA8DPM1U025638
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Nov 2007 08:25:22 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	lA8DPMbo139158
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Nov 2007 08:25:22 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lA8DPMWe006410
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Nov 2007 08:25:22 -0500
Date: Thu, 8 Nov 2007 07:20:54 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Register AC97 Controller Reference with the platform bus
Message-ID: <20071108072054.57a1f95c@zod.rchland.ibm.com>
In-Reply-To: <20071107161142.7901.51817.stgit@trillian.cg.shawcable.net>
References: <20071107161142.7901.51817.stgit@trillian.cg.shawcable.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, JOFT@gmx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 07 Nov 2007 09:14:15 -0700
Grant Likely <grant.likely@secretlab.ca> wrote:

> From: Joachim Foerster <mls.JOFT@gmx.de>
> 
> Add AC97 platform bus registration for Xilinx Virtex platforms.
> 
> Signed-off-by: Joachim Foerster <JOFT@gmx.de>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> 
> Josh, can you please pick up this patch into your .24 queue.  I know it's
> arch/ppc, but it is harmless and it is required to get the AC97 device
> driver working on Virtex boards.  It's pretty much a bug fix in that regard.

Will do shortly.  I have a couple other bug fix patches I need to get
out as well.

josh

> 
> Cheers,
> g.
> 
>  arch/ppc/syslib/virtex_devices.c |   31 +++++++++++++++++++++++++++++++
>  1 files changed, 31 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/ppc/syslib/virtex_devices.c b/arch/ppc/syslib/virtex_devices.c
> index 96188f8..95ee313 100644
> --- a/arch/ppc/syslib/virtex_devices.c
> +++ b/arch/ppc/syslib/virtex_devices.c
> @@ -169,6 +169,29 @@
>  	}, \
>  }
> 
> +#define XPAR_AC97_CONTROLLER_REFERENCE(num) { \
> +	.name = "ml403_ac97cr", \
> +	.id = num, \
> +	.num_resources = 3, \
> +	.resource = (struct resource[]) { \
> +		{ \
> +			.start = XPAR_OPB_AC97_CONTROLLER_REF_##num##_BASEADDR, \
> +			.end = XPAR_OPB_AC97_CONTROLLER_REF_##num##_HIGHADDR, \
> +			.flags = IORESOURCE_MEM, \
> +		}, \
> +		{ \
> +			.start = XPAR_OPB_INTC_0_OPB_AC97_CONTROLLER_REF_##num##_PLAYBACK_INTERRUPT_INTR, \
> +			.end = XPAR_OPB_INTC_0_OPB_AC97_CONTROLLER_REF_##num##_PLAYBACK_INTERRUPT_INTR, \
> +			.flags = IORESOURCE_IRQ, \
> +		}, \
> +		{ \
> +			.start = XPAR_OPB_INTC_0_OPB_AC97_CONTROLLER_REF_##num##_RECORD_INTERRUPT_INTR, \
> +			.end = XPAR_OPB_INTC_0_OPB_AC97_CONTROLLER_REF_##num##_RECORD_INTERRUPT_INTR, \
> +			.flags = IORESOURCE_IRQ, \
> +		}, \
> +	}, \
> +}
> +
>  /* UART 8250 driver platform data table */
>  struct plat_serial8250_port virtex_serial_platform_data[] = {
>  #if defined(XPAR_UARTNS550_0_BASEADDR)
> @@ -303,6 +326,14 @@ struct platform_device virtex_platform_devices[] = {
>  #if defined(XPAR_TFT_3_BASEADDR)
>  	XPAR_TFT(3),
>  #endif
> +
> +	/* AC97 Controller Reference instances */
> +#if defined(XPAR_OPB_AC97_CONTROLLER_REF_0_BASEADDR)
> +	XPAR_AC97_CONTROLLER_REFERENCE(0),
> +#endif
> +#if defined(XPAR_OPB_AC97_CONTROLLER_REF_1_BASEADDR)
> +	XPAR_AC97_CONTROLLER_REFERENCE(1),
> +#endif
>  };
> 
>  /* Early serial support functions */
> 
