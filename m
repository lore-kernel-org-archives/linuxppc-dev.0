Return-Path: <stef.van.os@Prodrive.nl>
Received: from mail.prodrive.nl (mail.prodrive.nl [212.61.153.67])
 by ozlabs.org (Postfix) with ESMTP id 957F42C0095
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Feb 2013 06:25:20 +1100 (EST)
Message-ID: <510D6819.7050002@prodrive.nl>
Date: Sat, 2 Feb 2013 20:25:13 +0100
From: Stef van Os <stef.van.os@prodrive.nl>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/1] powerpc/85xx: Board support for ppa8548
References: <1359765063.23561.14@snotra>
In-Reply-To: <1359765063.23561.14@snotra>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 timur.tabi@calxeda.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks for the comment!

On 02/02/2013 01:31 AM, Scott Wood wrote:
> On 02/01/2013 09:36:53 AM, Stef van Os wrote:
>> +    memory {
>> +        device_type = "memory";
>> +        reg = <0 0 0x0 0x40000000>;
>> +    };
>
> You have a "filled in by U-Boot" comment elsewhere in the file, but 
> you aren't letting U-Boot fill in the memory size?
>
The U-Boot used in this board currently does not call the 
fdt_fixup_memory function. Would have been better, but changing it now 
requires production image changes and requalification.
>> +    board_lbc: lbc: localbus@fe0005000 {
>> +        reg = <0xf 0xe0005000 0 0x1000>;
>> +        ranges = <0x0 0x0 0xf 0xff800000 0x00800000>;
>> +    };
>> +
>> +    board_soc: soc: soc8548@fe0000000 {
>> +        ranges = <0 0xf 0xe0000000 0x100000>;
>> +    };
>
> I know some existing dts files do this, but there's no need for two 
> labels one one node.
True, fixed in v2 of patch.
>
>> +    rio: rapidio@fe00c0000 {
>> +        reg = <0xf 0xe00c0000 0x0 0x11000>;
>> +        port1 {
>> +            ranges = <0x0 0x0 0x0 0x80000000 0x0 0x40000000>;
>> +        };
>> +    };
>> +};
>> +
>> +&lbc {
>> +    #address-cells = <2>;
>> +    #size-cells = <1>;
>> +    compatible = "fsl,mpc8548-lbc", "fsl,pq3-localbus", "simple-bus";
>> +    interrupts = <19 2 0 0>;
>> +};
>> +
>> +&rio {
>> +    compatible = "fsl,srio";
>> +    interrupts = <48 2 0 0>;
>> +    #address-cells = <2>;
>> +    #size-cells = <2>;
>> +    fsl,srio-rmu-handle = <&rmu>;
>> +    ranges;
>> +
>> +    port1 {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +        cell-index = <1>;
>> +    };
>> +};
>> +
>> +&soc {
>> +    #address-cells = <1>;
>> +    #size-cells = <1>;
>> +    device_type = "soc";
>> +    compatible = "fsl,mpc8548-immr", "simple-bus";
>> +    bus-frequency = <0>;        // Filled out by uboot.
>> +
>> +    ecm-law@0 {
>> +        compatible = "fsl,ecm-law";
>> +        reg = <0x0 0x1000>;
>> +        fsl,num-laws = <10>;
>> +    };
>> +
>> +    ecm@1000 {
>> +        compatible = "fsl,mpc8548-ecm", "fsl,ecm";
>> +        reg = <0x1000 0x1000>;
>> +        interrupts = <17 2 0 0>;
>> +    };
>> +
>> +    memory-controller@2000 {
>> +        compatible = "fsl,mpc8548-memory-controller";
>> +        reg = <0x2000 0x1000>;
>> +        interrupts = <18 2 0 0>;
>> +    };
>> +
>> +/include/ "fsl/pq3-i2c-0.dtsi"
>> +/include/ "fsl/pq3-i2c-1.dtsi"
>> +/include/ "fsl/pq3-duart-0.dtsi"
>> +
>> +    L2: l2-cache-controller@20000 {
>> +        compatible = "fsl,mpc8548-l2-cache-controller";
>> +        reg = <0x20000 0x1000>;
>> +        cache-line-size = <32>;    // 32 bytes
>> +        cache-size = <0x80000>; // L2, 512K
>> +        interrupts = <16 2 0 0>;
>> +    };
>> +
>> +/include/ "fsl/pq3-dma-0.dtsi"
>> +/include/ "fsl/pq3-etsec1-0.dtsi"
>> +/include/ "fsl/pq3-etsec1-1.dtsi"
>> +/include/ "fsl/pq3-etsec1-2.dtsi"
>> +/include/ "fsl/pq3-etsec1-3.dtsi"
>> +
>> +/include/ "fsl/pq3-sec2.1-0.dtsi"
>> +/include/ "fsl/pq3-mpic.dtsi"
>> +/include/ "fsl/pq3-rmu-0.dtsi"
>> +
>> +    global-utilities@e0000 {
>> +        compatible = "fsl,mpc8548-guts";
>> +        reg = <0xe0000 0x1000>;
>> +        fsl,has-rstcr;
>> +    };
>> +};
>
> I guess the reason you're not using fsl/mpc8548si-post.dtsi is that 
> you don't want PCI.  Maybe PCI and srio should be moved out of that 
> file, or ifdeffed if 85xx ever ends up using the preprocessor for its 
> device trees.
>
I went with timur's solution, patch v2 uses mpc8548si-post.dtsi and 
mpc8548si-pre.dtsi again, disabling everything that is not on the board.
>> diff --git a/arch/powerpc/platforms/85xx/ppa8548.c 
>> b/arch/powerpc/platforms/85xx/ppa8548.c
>> new file mode 100644
>> index 0000000..80a9307
>> --- /dev/null
>> +++ b/arch/powerpc/platforms/85xx/ppa8548.c
>> @@ -0,0 +1,119 @@
>> +/*
>> + * ppa8548 setup and early boot code.
>> + *
>> + * Copyright 2009 Prodrive B.V..
>> + *
>> + * By Stef van Os (see MAINTAINERS for contact information)
>> + *
>> + * Based on the SBC8548 support - Copyright 2007 Wind River Systems 
>> Inc.
>> + * Based on the MPC8548CDS support - Copyright 2005 Freescale Inc.
>> + *
>> + * This program is free software; you can redistribute  it and/or 
>> modify it
>> + * under  the terms of  the GNU General  Public License as published 
>> by the
>> + * Free Software Foundation;  either version 2 of the  License, or 
>> (at your
>> + * option) any later version.
>> + */
>> +
>> +#include <linux/stddef.h>
>> +#include <linux/kernel.h>
>> +#include <linux/init.h>
>> +#include <linux/errno.h>
>> +#include <linux/reboot.h>
>> +#include <linux/kdev_t.h>
>> +#include <linux/major.h>
>> +#include <linux/console.h>
>> +#include <linux/delay.h>
>> +#include <linux/seq_file.h>
>> +#include <linux/initrd.h>
>> +#include <linux/module.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/fsl_devices.h>
>> +#include <linux/of_platform.h>
>> +
>> +#include <asm/pgtable.h>
>> +#include <asm/page.h>
>> +#include <asm/atomic.h>
>> +#include <asm/time.h>
>> +#include <asm/io.h>
>> +#include <asm/machdep.h>
>> +#include <asm/ipic.h>
>> +#include <asm/irq.h>
>> +#include <mm/mmu_decl.h>
>> +#include <asm/prom.h>
>> +#include <asm/udbg.h>
>> +#include <asm/mpic.h>
>> +
>> +#include <sysdev/fsl_soc.h>
>
> I doubt you need all of these.
>
> E.g. asm/ipic.h is for 83xx and 512x chips.  Some others are for 
> things that haven't been done by board files for years (e.g. kdev_t.h).
Fixed in v2, 10 includes left, instead of 25+...
>
>> +static void ppa8548_show_cpuinfo(struct seq_file *m)
>> +{
>> +    uint pvid, svid, phid1;
>> +
>> +    pvid = mfspr(SPRN_PVR);
>> +    svid = mfspr(SPRN_SVR);
>> +
>> +    seq_printf(m, "Vendor\t\t: Prodrive B.V.\n");
>> +    seq_printf(m, "Machine\t\t: ppa8548\n");
>> +    seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
>> +    seq_printf(m, "SVR\t\t: 0x%x\n", svid);
>> +
>> +    /* Display cpu Pll setting */
>> +    phid1 = mfspr(SPRN_HID1);
>> +    seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
>> +}
>
> PVR and ppc_md.name are already shown by the generic /proc/cpuinfo code.
>
> -Scott
Fixed, removed PVR and Machine. SVR is still shown, because it is not in 
generic cpuinfo code.

Will do a test run of the changes and send out v2 later this weekend.

Regards,
Stef
