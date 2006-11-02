Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id F141B67C05
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Nov 2006 06:01:43 +1100 (EST)
Message-ID: <454A408D.1020503@ru.mvista.com>
Date: Thu, 02 Nov 2006 22:01:33 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: [PATCH] adding ROM chips to device tree
References: <20061102145539.f0b8657f.vwool@ru.mvista.com>
In-Reply-To: <20061102145539.f0b8657f.vwool@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello.

Vitaly Wool wrote:
> Hello folks,

> inlined below is the patch which adds support for flash device descriptions to the OF device tree. It's inspired by and partially borrowed from Sergei's patch which can be found at http://patchwork.ozlabs.org/linuxppc/patch?id=6526 but arranges things in a different way.
> It should be used together with the corresponding MTD layer extension the current version of which was recently posted to linux-mtd list for discussion and can be found at http://lists.infradead.org/pipermail/linux-mtd/2006-November/016700.html.
> In fact, currently this description can handle only flash devices mapped into memory in a linear way. For NAND flashes we'll need a whole lot different description but let's solve problems as they arise since I'm not aware of any ppc board w/ NAND chip yet :)

    The set of device properties may vary from driver to driver, anway...

>  Documentation/powerpc/booting-without-of.txt |   37 +++++++++++++++++++++++++++
>  arch/powerpc/sysdev/Makefile                 |    1
>  arch/powerpc/sysdev/flash.c                  |   27 +++++++++++++++++++

    Maybe worth renaming into mtd.c...

>  3 files changed, 65 insertions(+)

> Signed-off-by: Vitaly Wool <vwool@ru.mvista.com>

> Index: powerpc/Documentation/powerpc/booting-without-of.txt
> ===================================================================
> --- powerpc.orig/Documentation/powerpc/booting-without-of.txt
> +++ powerpc/Documentation/powerpc/booting-without-of.txt
> @@ -6,6 +6,8 @@
>      IBM Corp.
>  (c) 2005 Becky Bruce <becky.bruce at freescale.com>,
>      Freescale Semiconductor, FSL SOC and 32-bit additions
> +(c) 2006 MontaVista Software, Inc.
> +    Flash chip node definition
>  
>     May 18, 2005: Rev 0.1 - Initial draft, no chapter III yet.
>  
> @@ -1693,6 +1696,41 @@ platforms are moved over to use the flat
>  		};
>  	};
>  
> +    viii) Flash chip nodes

    Ha, it shoulf be h). The stupid roman numbering was introduced for QUICC 
engine devices. I wodner whose idea it was to have *two* i) items in a row... :-)

> +
> +    Flash chips (Memory Technology Devices) are often used for solid state
> +    file systems on embedded devices.
> +
> +    Required properties:
> +
> +     - device_type : has to be "rom"
> +     - compatible : Should be the name of the MTD driver. Currently, this is
> +       most likely to be "physmap".
> +     - reg : Offset and length of the register set for the device.
> +
> +    Recommended properties :
> +
> +     - bank-width : Width of the flash data bus in bytes. Must be specified
> +       for the NOR flashes.
> +     - partitions : Several pairs of 32-bit values where the first value is
> +       partition's offset from the start of the MTD device and the second
> +       one is partition size in bytes with LSB used to signify a read only
> +       partititon (so, the parition size should always be an even number).
> +     - partition-names : The list of concatenated zero terminated strings
> +       representing the partition names.
> +
> +   Example:
> +
> + 	flash@ff000000 {
> + 		device_type = "rom";
> + 		compatible = "physmap";
> + 		reg = <ff000000 01000000>;
> + 		bank-width = <4>;
> + 		partitions = <00000000 00f80000
> + 			      00f80000 00080001>;
> + 		partition-names = "fs\0firmware";
> + 	};
> +
>     More devices will be defined as this spec matures.
>  
>  
> Index: powerpc/arch/powerpc/sysdev/Makefile
> ===================================================================
> --- powerpc.orig/arch/powerpc/sysdev/Makefile
> +++ powerpc/arch/powerpc/sysdev/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_MMIO_NVRAM)	+= mmio_nvram.o
>  obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
>  obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
>  obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
> +obj-$(CONFIG_MTD)		+= flash.o
>  
>  ifeq ($(CONFIG_PPC_MERGE),y)
>  obj-$(CONFIG_PPC_I8259)		+= i8259.o
> Index: powerpc/arch/powerpc/sysdev/flash.c
> ===================================================================
> --- /dev/null
> +++ powerpc/arch/powerpc/sysdev/flash.c
> @@ -0,0 +1,27 @@
> +/*
> + * arch/powerpc/sysdev/flash.c
> + *
> + * Flash memory registration
> + *
> + * (C) 2006 MontaVista Software, Inc. This file is licensed under
> + * the terms of the GNU General Public License version 2. This program
> + * is licensed "as is" without any warranty of any kind, whether express
> + * or implied.
> + */
> +
> +#include <asm/of_device.h>
> +
> +static int __init powerpc_flash_init(void)
> +{
> +	struct device_node *node = NULL;
> +	int num = 0;

    There's no need to count anymore...

> +	while ((node = of_find_compatible_node(node, "mtd", "physmap"))

    Hey, you just changed device_type from "mtd" to "rom", do you expect this 
to still work? :-)
    And, this actually should be registering *all* devices, not only "physmap" 
ones. The of_device probing code should figure out which drivers will get 
which devices.

> +			!= NULL) {
> +		of_platform_device_create(node, "physmap-flash", NULL);
> +		++num;
> +	}
> +	return 0;
> +}
> +
> +arch_initcall(powerpc_flash_init);

WBR, Sergei
