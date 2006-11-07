Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 5C0E767C8B
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Nov 2006 02:27:43 +1100 (EST)
Message-ID: <4550A5E6.50409@ru.mvista.com>
Date: Tue, 07 Nov 2006 18:27:34 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: [PATCH] adding ROM chips to device tree: respin
References: <20061107141923.16b2d2f1.vwool@ru.mvista.com>
In-Reply-To: <20061107141923.16b2d2f1.vwool@ru.mvista.com>
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

> inlined below is the patch which adds support for flash device descriptions to the OF device tree. It's inspired by and partially borrowed from Sergei's patch which can be found at http://patchwork.ozlabs.org/linuxppc/patch?id=6526 but arranges things in a different way.
> It should be used together with the corresponding MTD layer extension the current version of which was recently posted to linux-mtd list for discussion and can be found at http://lists.infradead.org/pipermail/linux-mtd/2006-November/016700.html.
> In fact, currently this description can handle only flash devices mapped into memory in a linear way.
> This patch is a respin of the patch which can be found at http://ozlabs.org/pipermail/linuxppc-embedded/2006-November/025013.html with comments from Sergei and Josh taken into account.
> 
>  Documentation/powerpc/booting-without-of.txt |   37 +++++++++++++++++++++++++++
>  arch/powerpc/sysdev/Makefile                 |    1 
>  arch/powerpc/sysdev/rom.c                    |   31 ++++++++++++++++++++++
>  3 files changed, 69 insertions(+)
>  
> Signed-off-by: Vitaly Wool <vwool@ru.mvista.com>
> 
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
> @@ -1693,6 +1695,41 @@ platforms are moved over to use the flat
>  		};
>  	};
>  
> +    g) Flash chip nodes
> +
> +    Flash chips (Memory Technology Devices) are often used for solid state
> +    file systems on embedded devices.
> +
> +    Required properties:
> +
> +     - device_type : has to be "rom"
> +     - compatible : Should be the name of the MTD driver. Currently, this is
> +       most likely to be "physmap".
> +     - memory_space : Offset and length of the register set for the device.

    NAK. There's no need to define an extra property where "reg" should be used.

> +     - bank-width : Width of the flash data bus in bytes. Required
> +       for the NOR flashes (compatible == "physmap" and others) ONLY.

    Then it can not be called a *required* property I think.

> +
> +    Recommended properties :
> +
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
> + 		memory_space = <ff000000 01000000>;
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
> +obj-$(CONFIG_MTD)		+= rom.o
>  
>  ifeq ($(CONFIG_PPC_MERGE),y)
>  obj-$(CONFIG_PPC_I8259)		+= i8259.o
> Index: powerpc/arch/powerpc/sysdev/rom.c
> ===================================================================
> --- /dev/null
> +++ powerpc/arch/powerpc/sysdev/rom.c
> @@ -0,0 +1,31 @@
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
> +
> +	/*
> +	 * We care only about physmap devices now as there's no
> +	 * description defined for other ROM types yet
> +	 */

    Not true. The description only says that it's *most probably* compatible 
with "physmap", that's all. I don't see why we have to limit ourselves here.

> +	while ((node = of_find_compatible_node(node, "rom", "physmap"))
> +			!= NULL) {
> +		of_platform_device_create(node, "physmap-flash", NULL);
> +		++num;

    Why are you counting them, can you say?

> +	}
> +	return 0;
> +}
> +
> +arch_initcall(powerpc_flash_init);

WBR, Sergei
