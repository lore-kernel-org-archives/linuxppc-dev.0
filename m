Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6635FDDEF1
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 02:57:12 +1000 (EST)
Message-Id: <9A5921B1-48D8-49B1-8D10-5DF68DEBF5D3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Becky Bruce <beckyb@kernel.crashing.org>
In-Reply-To: <1240244810-32193-7-git-send-email-beckyb@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 4/5] powerpc: Add support for swiotlb on 32-bit
Date: Mon, 20 Apr 2009 11:57:05 -0500
References: <1240244810-32193-1-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-2-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-3-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-4-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-5-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-6-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-7-git-send-email-beckyb@kernel.crashing.org>
Cc: fujita.tomonori@lab.ntt.co.jp, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 20, 2009, at 11:26 AM, Becky Bruce wrote:

> This patch includes the basic infrastructure to use swiotlb
> bounce buffering on 32-bit powerpc.  It is not yet enabled on
> any platforms.
>
> Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
> ---
> arch/powerpc/Kconfig                   |    2 +-
> arch/powerpc/include/asm/dma-mapping.h |   11 ++
> arch/powerpc/include/asm/swiotlb.h     |   24 +++++
> arch/powerpc/kernel/Makefile           |    1 +
> arch/powerpc/kernel/dma-swiotlb.c      |  161 +++++++++++++++++++++++ 
> +++++++++
> arch/powerpc/kernel/dma.c              |    2 +-
> arch/powerpc/kernel/setup_32.c         |    4 +
> 7 files changed, 203 insertions(+), 2 deletions(-)
> create mode 100644 arch/powerpc/include/asm/swiotlb.h
> create mode 100644 arch/powerpc/kernel/dma-swiotlb.c
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 5b50e1a..197f6a3 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -294,7 +294,7 @@ config IOMMU_HELPER
>
> config PPC_NEED_DMA_SYNC_OPS
> 	def_bool y
> -	depends on NOT_COHERENT_CACHE
> +	depends on (NOT_COHERENT_CACHE || SWIOTLB)

This isn't right, since you haven't introduced the SWIOTLB Kconfig.

Why don't we just put the SWIOTLB Kconfig option in here and default  
it no (and remove the dep on 86xx).

> config HOTPLUG_CPU
> 	bool "Support for enabling/disabling CPUs"


> diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/ 
> dma-swiotlb.c
> new file mode 100644
> index 0000000..29a68e6
> --- /dev/null
> +++ b/arch/powerpc/kernel/dma-swiotlb.c
> @@ -0,0 +1,161 @@
> +/*
> + * Contains routines needed to support swiotlb for ppc.
> + *
> + * Copyright (C) 2009 Becky Bruce, Freescale Semiconductor
> + *
> + * This program is free software; you can redistribute  it and/or  
> modify it
> + * under  the terms of  the GNU General  Public License as  
> published by the
> + * Free Software Foundation;  either version 2 of the  License, or  
> (at your
> + * option) any later version.
> + *
> + */

[snip]

>
> +
> +static int ppc_swiotlb_bus_notify(struct notifier_block *nb,
> +				  unsigned long action, void *data)
> +{
> +	struct device *dev = data;
> +
> +	/* We are only intereted in device addition */
> +	if (action != BUS_NOTIFY_ADD_DEVICE)
> +		return 0;
> +
> +	if (dma_get_mask(dev) < DMA_BIT_MASK(36))
> +		set_dma_ops(dev, &swiotlb_dma_ops);
> +

this isn't right.  Isn't possible for a PCI dev to have a  
DMA_BIT_MASK(64) but us still not be able to dma to it?  Also, I dont  
like the assumption of 36-bit physical here.

>
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block ppc_swiotlb_plat_bus_notifier = {
> +	.notifier_call = ppc_swiotlb_bus_notify,
> +	.priority = 0,
> +};
> +
> +static struct notifier_block ppc_swiotlb_of_bus_notifier = {
> +	.notifier_call = ppc_swiotlb_bus_notify,
> +	.priority = 0,
> +};
> +
> +static int __init setup_bus_notifier(void)
> +{
> +	bus_register_notifier(&platform_bus_type,
> +			      &ppc_swiotlb_plat_bus_notifier);
> +	bus_register_notifier(&of_platform_bus_type,
> +			      &ppc_swiotlb_of_bus_notifier);
> +
> +	return 0;
> +}
