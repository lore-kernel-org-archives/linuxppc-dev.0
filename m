Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0136.outbound.protection.outlook.com [65.55.169.136])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8F4DD1A06A8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 09:21:52 +1100 (AEDT)
Message-ID: <1417040495.15957.176.camel@freescale.com>
Subject: Re: [RFC PATCH v1 1/1] powerpc/85xx: Add support for
 Emerson/Artesyn MVME2500.
From: Scott Wood <scottwood@freescale.com>
To: Alessio Igor Bogani <alessio.bogani@elettra.eu>
Date: Wed, 26 Nov 2014 16:21:35 -0600
In-Reply-To: <1417011468-13485-1-git-send-email-alessio.bogani@elettra.eu>
References: <1417011468-13485-1-git-send-email-alessio.bogani@elettra.eu>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-11-26 at 15:17 +0100, Alessio Igor Bogani wrote:
> +	board_soc: soc: soc@ffe00000 {

There's no need for two labels on the same node.

> +		ranges = <0x0 0 0xffe00000 0x100000>;
> +
> +		i2c@3000 {
> +			hwmon@4c {
> +				compatible = "adi,adt7461";
> +				reg = <0x4c>;
> +			};
> +
> +			rtc@68 {
> +				compatible = "dallas,ds1337";
> +				reg = <0x68>;
> +				interrupts = <8 1 0 0>;
> +			};
> +
> +			eeprom-vpd@54 {
> +				compatible = "atmel,24c64";
> +				reg = <0x54>;
> +			};

eeprom-vpd?

Node name isn't the right place to put the intended usage of the
contents of the EEPROM.

> +
> +			eeprom@52 {
> +				compatible = "atmel,24c512";
> +				reg = <0x52>;
> +			};
> +
> +			eeprom@53 {
> +				compatible = "atmel,24c512";
> +				reg = <0x53>;
> +			};
> +
> +			spd@50 {
> +				compatible = "atmel,24c02";
> +				reg = <0x50>;
> +			};

Likewise, I suspect this is also an eeprom.

> +		};
> +
> +		spi0: spi@7000 {
> +			fsl,espi-num-chipselects = <2>;
> +
> +			flash@0 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				compatible = "atmel,at25df641";
> +				reg = <0>;
> +				spi-max-frequency = <10000000>;
> +				partition@u-boot {
> +					label = "u-boot";
> +					reg = <0x00000000 0x000A0000>;
> +					read-only;
> +				};
> +				partition@dtb {
> +					label = "dtb";
> +					reg = <0x000A0000 0x00020000>;
> +				};

Unfortunately you seem to have copied a bad example here...  After the @
should be a number that matches reg.

Better yet, don't put partition information in the dts at all -- it's
not hardware description.  Use the mtdparts command line.

> +	lbc: localbus@ffe05000 {
> +		reg = <0 0xffe05000 0 0x1000>;
> +
> +		ranges = <0x0 0x0 0x0 0xfff00000 0x00080000
> +			  0x1 0x0 0x0 0xffc40000 0x00010000
> +			  0x2 0x0 0x0 0xffc50000 0x00010000
> +			  0x3 0x0 0x0 0xffc60000 0x00010000
> +			  0x4 0x0 0x0 0xffc70000 0x00010000
> +			  0x6 0x0 0x0 0xffc80000 0x00010000
> +			  0x5 0x0 0x0 0xffdf0000 0x00001000>;

It's not possible to program the LBC with a window of only 0x1000 bytes.

> +
> +		serial2: serial@1,0 {
> +			#cell-index = <2>;
> +			device_type = "serial";
> +			compatible = "ns16550";
> +			reg = <0x1 0x0 0x100>;
> +			clock-frequency = <1843200>;
> +			interrupts = <11 2 0 0>;
> +		};
> +
> +		serial3: serial@2,0 {
> +			#cell-index = <3>;
> +			device_type = "serial";
> +			compatible = "ns16550";
> +			reg = <0x2 0x0 0x100>;
> +			clock-frequency = <1843200>;
> +			interrupts = <1 2 0 0>;
> +		};

Why do you need cell-index, what connection do these values have to
actual hardware (e.g. values written to a register, rather than numbers
in a manual), and why did the name change to #cell-index?

> +			interrupts = <9 1 0 0 >;

Whitespace

> +/include/ "mvme2500.dtsi"

Are you going to have more than one .dts using this .dtsi?  If not, why
separate this part?


> diff --git a/arch/powerpc/boot/dts/mvme2500.dtsi b/arch/powerpc/boot/dts/mvme2500.dtsi
> new file mode 100644
> index 0000000..6966f13
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/mvme2500.dtsi
[snip]
> +/include/ "fsl/pq3-mpic-message-B.dtsi"
> +};

Why is this being included from a board file rather than from the SoC
file?

> diff --git a/arch/powerpc/configs/85xx/mvme2500_defconfig b/arch/powerpc/configs/85xx/mvme2500_defconfig
> new file mode 100644
> index 0000000..06fe629
> --- /dev/null
> +++ b/arch/powerpc/configs/85xx/mvme2500_defconfig

Why does this board need its own defconfig?

If it's just for the address space stuff, maybe it could be a more
general mpc85xx_2g_1g_1g_defconfig.  xes_mpc85xx_defconfig uses the same
layout (though it's SMP).  Maybe other boards could share it in the
future, or users of existing boards might prefer it...

Better still would be if we could have address map tweaks be kconfig
fragments that get mixed in by the user, with merge_config.sh.

> +CONFIG_MATH_EMULATION=y
> +CONFIG_MATH_EMULATION_HW_UNIMPLEMENTED=y

CONFIG_MATH_EMULATION_HW_UNIMPLEMENTED is not appropriate for e500v2
which does not implement any part of the classic PPC FPU.  You want
either full emulation or no emulation at all.

> +CONFIG_ADVANCED_OPTIONS=y
> +CONFIG_LOWMEM_SIZE_BOOL=y
> +CONFIG_LOWMEM_SIZE=0x40000000
> +CONFIG_PAGE_OFFSET_BOOL=y
> +CONFIG_PAGE_OFFSET=0x80000000
> +CONFIG_KERNEL_START_BOOL=y
> +CONFIG_TASK_SIZE_BOOL=y
> +CONFIG_TASK_SIZE=0x80000000

I gues the point here is to avoid using highmem just for the last 256
MiB?

> +CONFIG_STAGING=y

What do you need from staging?

> diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
> index f22635a..b92674a 100644
> --- a/arch/powerpc/platforms/85xx/Kconfig
> +++ b/arch/powerpc/platforms/85xx/Kconfig
> @@ -241,6 +241,14 @@ config SGY_CTS1000
>  	help
>  	  Enable this to support functionality in Servergy's CTS-1000 systems.
>  
> +config MVME2500
> +	bool "Artesyn MVME2500"
> +	select DEFAULT_UIMAGE
> +	select SWIOTLB

Why do you need SWIOTLB with only 1 GiB RAM?

> +#include <linux/stddef.h>
> +#include <linux/kernel.h>
> +#include <linux/pci.h>
> +#include <linux/kdev_t.h>
> +#include <linux/delay.h>
> +#include <linux/seq_file.h>
> +#include <linux/interrupt.h>
> +#include <linux/of_platform.h>
> +
> +#include <asm/time.h>
> +#include <asm/machdep.h>
> +#include <asm/pci-bridge.h>
> +#include <mm/mmu_decl.h>
> +#include <asm/prom.h>
> +#include <asm/udbg.h>
> +#include <asm/mpic.h>
> +#include <asm/swiotlb.h>
> +#include <asm/nvram.h>
> +
> +#include <sysdev/fsl_soc.h>
> +#include <sysdev/fsl_pci.h>
> +
> +#include "mpc85xx.h"

I don't think you need all of these.

> +#if defined(CONFIG_MMIO_NVRAM)
> +	mmio_nvram_init();
> +#endif

You select it in kconfig, so why do you need the ifdef?

> +	printk(KERN_INFO "MVME2500 board from Artesyn\n");

pr_info()


> +}
> +
> +machine_arch_initcall(mvme2500, mpc85xx_common_publish_devices);
> +machine_arch_initcall(mvme2500, swiotlb_setup_bus_notifier);
> +
> +/*
> + * Called very early, device-tree isn't unflattened
> + */
> +static int __init mvme2500_probe(void)
> +{
> +	unsigned long root = of_get_flat_dt_root();
> +
> +	return of_flat_dt_is_compatible(root, "Artesyn,MVME2500");

The compatible in the dts uses "artesyn", not "Artesyn".  Don't rely on
the fact that Linux (on some arches) uses case-insensitive comparisons
to deal with broken old firmware.  Nothing in ePAPR says that compatible
should be case-insensitive.

-Scott
