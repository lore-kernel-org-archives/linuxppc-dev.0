Return-Path: <B04825@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5ADCF2C0089
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2012 04:10:04 +1000 (EST)
Message-ID: <500EE4C3.40707@freescale.com>
Date: Tue, 24 Jul 2012 13:09:07 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/p5040ds: Add support for P5040DS board
References: <1343148122-4584-1-git-send-email-timur@freescale.com>
 <500EE1BB.6060104@freescale.com>
In-Reply-To: <500EE1BB.6060104@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood wrote:
> On 07/24/2012 11:42 AM, Timur Tabi wrote:
>> +/* controller at 0x200000 */
>> +&pci0 {
>> +	compatible = "fsl,p5040-pcie", "fsl,qoriq-pcie-v2.2";
> 
> p5040 has PCIe v2.4.

Then it's broken on the SDK as well.

> Note that there is a version register, so perhaps we should drop the
> version number from the compatible (and mention the version register in
> the binding).
> 
> Might want to double check the other version numbers in this file too.
> 
>> +	bus-range = <0x0 0xff>;
> 
> Do we really need this?
> 
>> +	clock-frequency = <33333333>;
> 
> I doubt this is accurate.

Almost all of this is copy-paste from the P5020, so if it's broken here,
it's either broken on the P5020 or also broken on the SDK.

>> +	iommu@20000 {
>> +		compatible = "fsl,pamu-v1.0", "fsl,pamu";
>> +		reg = <0x20000 0x5000>;
>> +		interrupts = <
>> +			24 2 0 0
>> +			16 2 1 30>;
>> +	};
> 
> It's PAMU v1.1, and there's a version register.

Also broken in the SDK. :-(

>> +/include/ "qoriq-mpic.dtsi"
>> +
>> +	guts: global-utilities@e0000 {
>> +		compatible = "fsl,qoriq-device-config-1.0";
>> +		reg = <0xe0000 0xe00>;
>> +		fsl,has-rstcr;
>> +		#sleep-cells = <1>;
>> +		fsl,liodn-bits = <12>;
>> +	};
>> +
>> +	pins: global-utilities@e0e00 {
>> +		compatible = "fsl,qoriq-pin-control-1.0";
>> +		reg = <0xe0e00 0x200>;
>> +		#sleep-cells = <2>;
>> +	};
> 
> Please add fsl,p5040-device-config and fsl,p5040-pin-control.  If you
> want to leave the "1.0" thing in (which was a mistake since this stuff
> doesn't seem to be versioned in any public way), double check that it's
> 100% backwards compatible with p4080.

Ok.

>> +	rcpm: global-utilities@e2000 {
>> +		compatible = "fsl,qoriq-rcpm-1.0";
>> +		reg = <0xe2000 0x1000>;
>> +		#sleep-cells = <1>;
>> +	};
> 
> Likewise.
> 
>> +/dts-v1/;
>> +/ {
>> +	compatible = "fsl,P5040";
> 
> When would we not override this?

I don't understand.

>> +		spi@110000 {
>> +			flash@0 {
>> +				#address-cells = <1>;
>> +				#size-cells = <1>;
>> +				compatible = "spansion,s25sl12801";
>> +				reg = <0>;
>> +				spi-max-frequency = <40000000>; /* input clock */
>> +				partition@u-boot {
>> +					label = "u-boot";
>> +					reg = <0x00000000 0x00100000>;
>> +					read-only;
>> +				};
>> +				partition@kernel {
>> +					label = "kernel";
>> +					reg = <0x00100000 0x00500000>;
>> +					read-only;
>> +				};
>> +				partition@dtb {
>> +					label = "dtb";
>> +					reg = <0x00600000 0x00100000>;
>> +					read-only;
>> +				};
>> +				partition@fs {
>> +					label = "file system";
>> +					reg = <0x00700000 0x00900000>;
>> +				};
> 
> Why are kernel/dtb read only?

Because that's how it is on the P5020!

I'm surprised the P5020 DTS files are so broken.

>> +		flash@0,0 {
>> +			compatible = "cfi-flash";
>> +			reg = <0 0 0x08000000>;
>> +			bank-width = <2>;
>> +			device-width = <2>;
>> +		};
> 
> No partitions on NOR flash?

I'll check.

>> +			partition@2000000 {
>> +				label = "NAND Root File System";
>> +				reg = <0x02000000 0x10000000>;
>> +			};
>> +
>> +			partition@12000000 {
>> +				label = "NAND Compressed RFS Image";
>> +				reg = <0x12000000 0x08000000>;
>> +			};
> 
> Why do we need both of these?  Why not one big partition for whichever
> type of RFS you have?

Beats me.  Like I said, I just copied them over.  I know that's bad, but
the source files have been around for quite some time, so I'm surprised
they're still all broken.

>> diff --git a/arch/powerpc/platforms/85xx/p5040_ds.c b/arch/powerpc/platforms/85xx/p5040_ds.c
>> new file mode 100644
>> index 0000000..ca3358f
>> --- /dev/null
>> +++ b/arch/powerpc/platforms/85xx/p5040_ds.c
>> @@ -0,0 +1,96 @@
>> +/*
>> + * P5040 DS Setup
>> + *
>> + * Copyright 2009-2010 Freescale Semiconductor Inc.
>> + *
>> + * This program is free software; you can redistribute  it and/or modify it
>> + * under  the terms of  the GNU General  Public License as published by the
>> + * Free Software Foundation;  either version 2 of the  License, or (at your
>> + * option) any later version.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/pci.h>
>> +#include <linux/kdev_t.h>
>> +#include <linux/delay.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/phy.h>
>> +
>> +#include <asm/time.h>
>> +#include <asm/machdep.h>
>> +#include <asm/pci-bridge.h>
>> +#include <mm/mmu_decl.h>
>> +#include <asm/prom.h>
>> +#include <asm/udbg.h>
>> +#include <asm/mpic.h>
>> +
>> +#include <linux/of_platform.h>
>> +#include <sysdev/fsl_soc.h>
>> +#include <sysdev/fsl_pci.h>
>> +#include <asm/ehv_pic.h>
>> +
>> +#include "corenet_ds.h"
> 
> Do you really need all these?  kdev_t?  phy?

Probably not.

>> +
>> +/*
>> + * Called very early, device-tree isn't unflattened
>> + */
>> +static int __init p5040_ds_probe(void)
>> +{
>> +	unsigned long root = of_get_flat_dt_root();
>> +#ifdef CONFIG_SMP
>> +	extern struct smp_ops_t smp_85xx_ops;
>> +#endif
>> +
>> +	if (of_flat_dt_is_compatible(root, "fsl,P5040DS"))
>> +		return 1;
>> +
>> +	/* Check if we're running under the Freescale hypervisor */
>> +	if (of_flat_dt_is_compatible(root, "fsl,P5040DS-hv")) {
>> +		ppc_md.init_IRQ = ehv_pic_init;
>> +		ppc_md.get_irq = ehv_pic_get_irq;
>> +		ppc_md.restart = fsl_hv_restart;
>> +		ppc_md.power_off = fsl_hv_halt;
>> +		ppc_md.halt = fsl_hv_halt;
>> +#ifdef CONFIG_SMP
>> +		/*
>> +		 * Disable the timebase sync operations because we can't write
>> +		 * to the timebase registers under the hypervisor.
>> +		  */
>> +		smp_85xx_ops.give_timebase = NULL;
>> +		smp_85xx_ops.take_timebase = NULL;
>> +#endif
> 
> Why are they getting set in the first place?

This is how the structure is defined in smp.c:

struct smp_ops_t smp_85xx_ops = {
	.kick_cpu = smp_85xx_kick_cpu,
#ifdef CONFIG_KEXEC
	.give_timebase	= smp_generic_give_timebase,
	.take_timebase	= smp_generic_take_timebase,
#endif
};

This code has not changed in years.  I'm not sure what you think is wrong
with it.

> While you're at it, you might want to look into converting corenet_ds to
> the new PCI init code.

Well, I just want to get this out the door.

> 
> -Scott
> 


-- 
Timur Tabi
Linux kernel developer at Freescale
