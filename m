Return-Path: <B07421@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe002.messaging.microsoft.com [213.199.154.140])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2B1032C0094
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Feb 2013 11:47:23 +1100 (EST)
Date: Fri, 1 Feb 2013 18:31:03 -0600
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/1] powerpc/85xx: Board support for ppa8548
To: Stef van Os <stef.van.os@prodrive.nl>
In-Reply-To: <1359733013-722-1-git-send-email-stef.van.os@prodrive.nl> (from
 stef.van.os@prodrive.nl on Fri Feb  1 09:36:53 2013)
Message-ID: <1359765063.23561.14@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Stef van Os <stef.van.os@prodrive.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/01/2013 09:36:53 AM, Stef van Os wrote:
> +	memory {
> +		device_type =3D "memory";
> +		reg =3D <0 0 0x0 0x40000000>;
> +	};

You have a "filled in by U-Boot" comment elsewhere in the file, but you =20
aren't letting U-Boot fill in the memory size?

> +	board_lbc: lbc: localbus@fe0005000 {
> +		reg =3D <0xf 0xe0005000 0 0x1000>;
> +		ranges =3D <0x0 0x0 0xf 0xff800000 0x00800000>;
> +	};
> +
> +	board_soc: soc: soc8548@fe0000000 {
> +		ranges =3D <0 0xf 0xe0000000 0x100000>;
> +	};

I know some existing dts files do this, but there's no need for two =20
labels one one node.

> +	rio: rapidio@fe00c0000 {
> +		reg =3D <0xf 0xe00c0000 0x0 0x11000>;
> +		port1 {
> +			ranges =3D <0x0 0x0 0x0 0x80000000 0x0 =20
> 0x40000000>;
> +		};
> +	};
> +};
> +
> +&lbc {
> +	#address-cells =3D <2>;
> +	#size-cells =3D <1>;
> +	compatible =3D "fsl,mpc8548-lbc", "fsl,pq3-localbus", =20
> "simple-bus";
> +	interrupts =3D <19 2 0 0>;
> +};
> +
> +&rio {
> +	compatible =3D "fsl,srio";
> +	interrupts =3D <48 2 0 0>;
> +	#address-cells =3D <2>;
> +	#size-cells =3D <2>;
> +	fsl,srio-rmu-handle =3D <&rmu>;
> +	ranges;
> +
> +	port1 {
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		cell-index =3D <1>;
> +	};
> +};
> +
> +&soc {
> +	#address-cells =3D <1>;
> +	#size-cells =3D <1>;
> +	device_type =3D "soc";
> +	compatible =3D "fsl,mpc8548-immr", "simple-bus";
> +	bus-frequency =3D <0>;		// Filled out by uboot.
> +
> +	ecm-law@0 {
> +		compatible =3D "fsl,ecm-law";
> +		reg =3D <0x0 0x1000>;
> +		fsl,num-laws =3D <10>;
> +	};
> +
> +	ecm@1000 {
> +		compatible =3D "fsl,mpc8548-ecm", "fsl,ecm";
> +		reg =3D <0x1000 0x1000>;
> +		interrupts =3D <17 2 0 0>;
> +	};
> +
> +	memory-controller@2000 {
> +		compatible =3D "fsl,mpc8548-memory-controller";
> +		reg =3D <0x2000 0x1000>;
> +		interrupts =3D <18 2 0 0>;
> +	};
> +
> +/include/ "fsl/pq3-i2c-0.dtsi"
> +/include/ "fsl/pq3-i2c-1.dtsi"
> +/include/ "fsl/pq3-duart-0.dtsi"
> +
> +	L2: l2-cache-controller@20000 {
> +		compatible =3D "fsl,mpc8548-l2-cache-controller";
> +		reg =3D <0x20000 0x1000>;
> +		cache-line-size =3D <32>;	// 32 bytes
> +		cache-size =3D <0x80000>; // L2, 512K
> +		interrupts =3D <16 2 0 0>;
> +	};
> +
> +/include/ "fsl/pq3-dma-0.dtsi"
> +/include/ "fsl/pq3-etsec1-0.dtsi"
> +/include/ "fsl/pq3-etsec1-1.dtsi"
> +/include/ "fsl/pq3-etsec1-2.dtsi"
> +/include/ "fsl/pq3-etsec1-3.dtsi"
> +
> +/include/ "fsl/pq3-sec2.1-0.dtsi"
> +/include/ "fsl/pq3-mpic.dtsi"
> +/include/ "fsl/pq3-rmu-0.dtsi"
> +
> +	global-utilities@e0000 {
> +		compatible =3D "fsl,mpc8548-guts";
> +		reg =3D <0xe0000 0x1000>;
> +		fsl,has-rstcr;
> +	};
> +};

I guess the reason you're not using fsl/mpc8548si-post.dtsi is that you =20
don't want PCI.  Maybe PCI and srio should be moved out of that file, =20
or ifdeffed if 85xx ever ends up using the preprocessor for its device =20
trees.

> diff --git a/arch/powerpc/platforms/85xx/ppa8548.c =20
> b/arch/powerpc/platforms/85xx/ppa8548.c
> new file mode 100644
> index 0000000..80a9307
> --- /dev/null
> +++ b/arch/powerpc/platforms/85xx/ppa8548.c
> @@ -0,0 +1,119 @@
> +/*
> + * ppa8548 setup and early boot code.
> + *
> + * Copyright 2009 Prodrive B.V..
> + *
> + * By Stef van Os (see MAINTAINERS for contact information)
> + *
> + * Based on the SBC8548 support - Copyright 2007 Wind River Systems =20
> Inc.
> + * Based on the MPC8548CDS support - Copyright 2005 Freescale Inc.
> + *
> + * This program is free software; you can redistribute  it and/or =20
> modify it
> + * under  the terms of  the GNU General  Public License as published =20
> by the
> + * Free Software Foundation;  either version 2 of the  License, or =20
> (at your
> + * option) any later version.
> + */
> +
> +#include <linux/stddef.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/errno.h>
> +#include <linux/reboot.h>
> +#include <linux/kdev_t.h>
> +#include <linux/major.h>
> +#include <linux/console.h>
> +#include <linux/delay.h>
> +#include <linux/seq_file.h>
> +#include <linux/initrd.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/fsl_devices.h>
> +#include <linux/of_platform.h>
> +
> +#include <asm/pgtable.h>
> +#include <asm/page.h>
> +#include <asm/atomic.h>
> +#include <asm/time.h>
> +#include <asm/io.h>
> +#include <asm/machdep.h>
> +#include <asm/ipic.h>
> +#include <asm/irq.h>
> +#include <mm/mmu_decl.h>
> +#include <asm/prom.h>
> +#include <asm/udbg.h>
> +#include <asm/mpic.h>
> +
> +#include <sysdev/fsl_soc.h>

I doubt you need all of these.

E.g. asm/ipic.h is for 83xx and 512x chips.  Some others are for things =20
that haven't been done by board files for years (e.g. kdev_t.h).

> +static void ppa8548_show_cpuinfo(struct seq_file *m)
> +{
> +	uint pvid, svid, phid1;
> +
> +	pvid =3D mfspr(SPRN_PVR);
> +	svid =3D mfspr(SPRN_SVR);
> +
> +	seq_printf(m, "Vendor\t\t: Prodrive B.V.\n");
> +	seq_printf(m, "Machine\t\t: ppa8548\n");
> +	seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
> +	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
> +
> +	/* Display cpu Pll setting */
> +	phid1 =3D mfspr(SPRN_HID1);
> +	seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
> +}

PVR and ppc_md.name are already shown by the generic /proc/cpuinfo code.

-Scott=
