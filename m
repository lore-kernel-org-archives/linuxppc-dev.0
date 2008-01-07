Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C2970DDED1
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 07:43:01 +1100 (EST)
Message-ID: <47828ECA.9000507@freescale.com>
Date: Mon, 07 Jan 2008 14:42:50 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [RFC PATCH 2/3] Add initial iomega StorCenter board port.
References: <E1JBwBn-0006JC-Nn@jdl.com>
In-Reply-To: <E1JBwBn-0006JC-Nn@jdl.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Loeliger wrote:
> Use cuImage bootwrapper until U-Boot port is completed.
> Derived heavily from Linkstation port.
> 
> Signed-off-by: Andy Wilcox <andy@protium.com>
> Signed-off-by: Jon Loeliger <jdl@jdl.com>
> ---
> 
> Nope, I have NOT verified that the bd_t file that
> is used here byte-identical to U-Boot's layout yet.
> [ There is _always_ something more to do... ]
> 
>  arch/powerpc/boot/Makefile                      |    3 +-
>  arch/powerpc/boot/cuboot-824x.c                 |   52 ++++++++
>  arch/powerpc/platforms/embedded6xx/Kconfig      |   15 ++-
>  arch/powerpc/platforms/embedded6xx/Makefile     |    2 +
>  arch/powerpc/platforms/embedded6xx/storcenter.c |  158 +++++++++++++++++++++++
>  5 files changed, 227 insertions(+), 3 deletions(-)
>  create mode 100644 arch/powerpc/boot/cuboot-824x.c
>  create mode 100644 arch/powerpc/platforms/embedded6xx/storcenter.c
> 
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index d1e625c..a59b176 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -57,7 +57,7 @@ src-wlib := string.S crt0.S stdio.c main.c \
>  		4xx.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c cuboot.c bamboo.c \
>  		cpm-serial.c stdlib.c mpc52xx-psc.c planetcore.c uartlite.c \
>  		fsl-soc.c mpc8xx.c pq2.c
> -src-plat := of.c cuboot-52xx.c cuboot-83xx.c cuboot-85xx.c holly.c \
> +src-plat := of.c cuboot-52xx.c cuboot-824x.c cuboot-83xx.c cuboot-85xx.c holly.c \
>  		cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
>  		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c cuboot-8xx.c \
>  		cuboot-pq2.c cuboot-sequoia.c treeboot-walnut.c cuboot-bamboo.c \
> @@ -196,6 +196,7 @@ image-$(CONFIG_PPC_EP88XC)		+= zImage.ep88xc
>  image-$(CONFIG_EP405)			+= zImage.ep405
>  image-$(CONFIG_8260)			+= cuImage.pq2
>  image-$(CONFIG_PPC_MPC52xx)		+= cuImage.52xx
> +image-$(CONFIG_STORCENTER)		+= cuImage.824x
>  image-$(CONFIG_PPC_83xx)		+= cuImage.83xx
>  image-$(CONFIG_PPC_85xx)		+= cuImage.85xx
>  image-$(CONFIG_MPC7448HPC2)		+= cuImage.hpc2
> diff --git a/arch/powerpc/boot/cuboot-824x.c b/arch/powerpc/boot/cuboot-824x.c
> new file mode 100644
> index 0000000..4aa3eee
> --- /dev/null
> +++ b/arch/powerpc/boot/cuboot-824x.c
> @@ -0,0 +1,52 @@
> +/*
> + * Old U-boot compatibility for 824x
> + *
> + * Copyright (c) 2007 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation.
> + */
> +
> +#include "ops.h"
> +#include "stdio.h"
> +#include "cuboot.h"
> +
> +#define TARGET_824x
> +#include "ppcboot.h"
> +
> +static bd_t bd;
> +
> +static void platform_fixups(void)
> +{
> +	void *soc;
> +
> +	dt_fixup_memory(bd.bi_memstart, bd.bi_memsize);
> +	dt_fixup_mac_addresses(bd.bi_enetaddr);
> +	dt_fixup_cpu_clocks(bd.bi_intfreq, bd.bi_busfreq / 4, bd.bi_busfreq);
> +
> +	soc = find_node_by_devtype(NULL, "soc");
> +	if (soc) {
> +		void *serial = NULL;
> +
> +		setprop(soc, "bus-frequency", &bd.bi_busfreq,
> +		        sizeof(bd.bi_busfreq));
> +
> +		while ((serial = find_node_by_devtype(serial, "serial"))) {
> +			if (get_parent(serial) != soc)
> +				continue;
> +
> +			setprop(serial, "clock-frequency", &bd.bi_busfreq,
> +			        sizeof(bd.bi_busfreq));
> +		}
> +	}
> +}
> +
> +void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
> +                   unsigned long r6, unsigned long r7)
> +{
> +	CUBOOT_INIT();
> +	fdt_init(_dtb_start);
> +	serial_console_init();
> +	platform_ops.fixups = platform_fixups;
> +}
> diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/platforms/embedded6xx/Kconfig
> index 8924095..be5cdd2 100644
> --- a/arch/powerpc/platforms/embedded6xx/Kconfig
> +++ b/arch/powerpc/platforms/embedded6xx/Kconfig
> @@ -16,6 +16,17 @@ config LINKSTATION
>  	  Linkstation-I HD-HLAN and HD-HGLAN versions, and PPC-based
>  	  Terastation systems should be supported too.
>  
> +config STORCENTER
> +	bool "IOMEGA StorCenter"
> +	depends on EMBEDDED6xx
> +	select MPIC
> +	select FSL_SOC
> +	select PPC_UDBG_16550 if SERIAL_8250
> +	select WANT_DEVICE_TREE
> +	help
> +	  Select STORCENTER if configuring for the iomega StorCenter
> +	  with an 8241 CPU in it.
> +
>  config MPC7448HPC2
>  	bool "Freescale MPC7448HPC2(Taiga)"
>  	depends on EMBEDDED6xx
> @@ -56,7 +67,7 @@ config TSI108_BRIDGE
>  
>  config MPC10X_BRIDGE
>  	bool
> -	depends on LINKSTATION
> +	depends on LINKSTATION || STORCENTER
>  	select PPC_INDIRECT_PCI
>  	default y
>  
> @@ -67,7 +78,7 @@ config MV64X60
>  
>  config MPC10X_OPENPIC
>  	bool
> -	depends on LINKSTATION
> +	depends on LINKSTATION || STORCENTER
>  	default y

There are many boards out there with mpc10x chips; we really don't want 
to maintain a huge list of them in the dependency list of these options.

Can we take out the dependencies and the default y, and just select them 
in the individual board configs?

> +#ifdef CONFIG_PCI
> +	int len;
> +	struct pci_controller *hose;
> +	const int *bus_range;
> +
> +	printk("Adding PCI host bridge %s\n", dev->full_name);
> +
> +	bus_range = of_get_property(dev, "bus-range", &len);
> +	if (bus_range == NULL || len < 2 * sizeof(int))
> +		printk(KERN_WARNING "Can't get bus-range for %s, assume"
> +				" bus 0\n", dev->full_name);

This warning should probably go away.  Does this board even have 
multiple PCI host buses?  Why is this done from board-specific code, anyway?

> +static void storcenter_restart(char *cmd)
> +{
> +	/* Insert restart-stuff */
> +}
> +
> +static void storcenter_power_off(void)
> +{
> +	/* Insert powerdown-stuff */
> +}

Shouldn't these be omitted until they actually do something, so that the 
generic infinite loop implementations can be used?

> +static void storcenter_show_cpuinfo(struct seq_file *m)
> +{
> +	seq_printf(m, "vendor\t\t: IOMEGA\n");
> +	seq_printf(m, "machine\t\t: StorCenter\n");
> +}

ppc_md.name is printed by the generic cpuinfo handler; this is redundant.

-Scott
