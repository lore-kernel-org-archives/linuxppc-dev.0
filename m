Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-nj2ut-11.online-age.net (ext-nj2ut-11.online-age.net
	[64.14.54.241])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-nj2ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 09146DE3E7
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 21:12:53 +1000 (EST)
Received: from int-nj2ut-7.online-age.net (int-nj2ut-7.online-age.net
	[3.159.237.76])
	by ext-nj2ut-11.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id m7MBCoHa029567
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 07:12:50 -0400
Received: from cinmlip01.e2k.ad.ge.com (int-nj2ut-7.online-age.net
	[3.159.237.76])
	by int-nj2ut-7.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id m7MBChCF008047
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 07:12:49 -0400
Date: Fri, 22 Aug 2008 12:11:52 +0100
From: Martyn Welch <martyn.welch@gefanuc.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2 1/2] powerpc: Board support for GE Fanuc SBC610
Message-Id: <20080822121152.70f01597.martyn.welch@gefanuc.com>
In-Reply-To: <72120CFB-62D9-44B0-AD4F-26332C90F3C9@kernel.crashing.org>
References: <20080822104615.11984.93838.stgit@ubuntu8041.localdomain>
	<20080822104620.11984.30369.stgit@ubuntu8041.localdomain>
	<72120CFB-62D9-44B0-AD4F-26332C90F3C9@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 22 Aug 2008 05:56:53 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> >
> > +		PowerPC,8641@0 {
> > +			device_type = "cpu";
> > +			reg = <0x00000000>;
> > +			d-cache-line-size = <32>;	// 32 bytes
> > +			i-cache-line-size = <32>;	// 32 bytes
> > +			d-cache-size = <32768>;		// L1, 32K
> > +			i-cache-size = <32768>;		// L1, 32K
> > +			timebase-frequency = <0>;	// From uboot
> > +			bus-frequency = <0>;		// From uboot
> > +			clock-frequency = <0>;		// From uboot
> > +			l2cr = <0x80000000>;		// Enable L2
> 
> do you expect the 'l2cr' prop to do anything?  Not sure if this is  
> something apple invented or you did?
> 

TBH, it was in the dts file that I based this on - I thought it was in the others as well - my mistake, I shall remove it.

> 
> >
> > +		i2c1: i2c@3000 {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			device_type = "i2c";
> 
> drop device_type.
> 

Ah - _all_ device_type!

<snip>

> >
> > +			};
> > +		};
> > +
> > +		enet0: ethernet@24000 {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> 
> there is no need for #add/size cells here.
> 

Will remove.

> >
> > +			device_type = "network";
> > +			model = "eTSEC";
> > +			compatible = "gianfar";
> > +			reg = <0x00024000 0x00001000>;
> > +			mac-address = [ 00 00 00 00 00 00 ]; // set by u-boot
> > +			interrupts = <0x1d 0x2 0x1e 0x2 0x22 0x2>;
> > +			interrupt-parent = <&mpic>;
> > +			phy-handle = <&phy0>;
> > +			phy-connection-type = "gmii";
> > +		};
> > +
> > +		enet1: ethernet@26000 {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> 
> there is no need for #add/size cells here.
> 

ditto.

> >
> > +			device_type = "network";
> > +			model = "eTSEC";
> > +			compatible = "gianfar";
> > +			reg = <0x00026000 0x00001000>;
> > +			mac-address = [ 00 00 00 00 00 00 ]; // set by u-boot
> > +			interrupts = <0x1f 0x2 0x20 0x2 0x21 0x2>;
> > +			interrupt-parent = <&mpic>;
> > +			phy-handle = <&phy2>;
> > +			phy-connection-type = "gmii";
> > +		};
> > +
> 
> You may want to add in msi interrupts for PCIe support (see  
> mpc8572ds.dtb)
> 

Interrupts are routed on this board - just via a custom interrupt controller.

I have a patch to add this, but I was getting the basics right first...

> > +
> > +		mpic: pic@40000 {
> > +			clock-frequency = <0>;
> > +			interrupt-controller;
> > +			#address-cells = <0>;
> > +			#interrupt-cells = <2>;
> > +			reg = <0x00040000 0x00040000>;
> > +			compatible = "chrp,open-pic";
> > +			device_type = "open-pic";
> > +		};
> > +
> > +		global-utilities@e0000 {
> > +			compatible = "fsl,mpc8641-guts";
> > +			reg = <0x000e0000 0x00001000>;
> > +			fsl,has-rstcr;
> > +		};
> > +	};
> > +
> > +	pci0: pcie@fef08000 {
> > +		compatible = "fsl,mpc8641-pcie";
> > +		device_type = "pci";
> > +		#interrupt-cells = <1>;
> > +		#size-cells = <2>;
> > +		#address-cells = <3>;
> > +		reg = <0xfef08000 0x00001000>;
> > +		bus-range = <0x0 0xff>;
> > +		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x40000000
> > +			  0x01000000 0x0 0x00000000 0xfe000000 0x0 0x00400000>;
> > +		clock-frequency = <33333333>;
> > +		interrupt-parent = <&mpic>;
> > +		interrupts = <0x18 0x2>;
> > +		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
> > +		interrupt-map = <
> > +			0x0000 0x0 0x0 0x1 &mpic 0x0 0x1
> > +			0x0000 0x0 0x0 0x2 &mpic 0x1 0x1
> > +			0x0000 0x0 0x0 0x3 &mpic 0x2 0x1
> > +			0x0000 0x0 0x0 0x4 &mpic 0x3 0x1
> > +		>;
> > +
> > +		pcie@0 {
> > +			reg = <0 0 0 0 0>;
> > +			#size-cells = <2>;
> > +			#address-cells = <3>;
> > +			device_type = "pci";
> > +			ranges = <0x02000000 0x0 0x80000000
> > +				  0x02000000 0x0 0x80000000
> > +				  0x0 0x40000000
> > +
> > +				  0x01000000 0x0 0x00000000
> > +				  0x01000000 0x0 0x00000000
> > +				  0x0 0x00400000>;
> > +		};
> > +	};
> > +};
> 
> 
> >
> > diff --git a/arch/powerpc/platforms/86xx/Makefile b/arch/powerpc/ 
> > platforms/86xx/Makefile
> > index 8fee37d..cb9fc8f 100644
> > --- a/arch/powerpc/platforms/86xx/Makefile
> > +++ b/arch/powerpc/platforms/86xx/Makefile
> > @@ -7,3 +7,4 @@ obj-$(CONFIG_SMP)		+= mpc86xx_smp.o
> > obj-$(CONFIG_MPC8641_HPCN)	+= mpc86xx_hpcn.o
> > obj-$(CONFIG_SBC8641D)		+= sbc8641d.o
> > obj-$(CONFIG_MPC8610_HPCD)	+= mpc8610_hpcd.o
> > +obj-$(CONFIG_GEF_SBC610)	+= gef_sbc610.o
> > diff --git a/arch/powerpc/platforms/86xx/gef_sbc610.c b/arch/powerpc/ 
> > platforms/86xx/gef_sbc610.c
> > new file mode 100644
> > index 0000000..a1382da
> > --- /dev/null
> > +++ b/arch/powerpc/platforms/86xx/gef_sbc610.c
> > @@ -0,0 +1,177 @@
> > +/*
> > + * GE Fanuc SBC610 board support
> > + *
> > + * Author: Martyn Welch <martyn.welch@gefanuc.com>
> > + *
> > + * Copyright 2008 GE Fanuc Intelligent Platforms Embedded Systems,  
> > Inc.
> > + *
> > + * This program is free software; you can redistribute  it and/or  
> > modify it
> > + * under  the terms of  the GNU General  Public License as  
> > published by the
> > + * Free Software Foundation;  either version 2 of the  License, or  
> > (at your
> > + * option) any later version.
> > + *
> > + * Based on: mpc86xx_hpcn.c (MPC86xx HPCN board specific routines)
> > + * Copyright 2006 Freescale Semiconductor Inc.
> > + */
> > +
> > +#include <linux/stddef.h>
> > +#include <linux/kernel.h>
> > +#include <linux/pci.h>
> > +#include <linux/kdev_t.h>
> > +#include <linux/delay.h>
> > +#include <linux/seq_file.h>
> > +#include <linux/of_platform.h>
> > +
> > +#include <asm/system.h>
> > +#include <asm/time.h>
> > +#include <asm/machdep.h>
> > +#include <asm/pci-bridge.h>
> > +#include <asm/mpc86xx.h>
> > +#include <asm/prom.h>
> > +#include <mm/mmu_decl.h>
> > +#include <asm/udbg.h>
> > +
> > +#include <asm/mpic.h>
> > +
> > +#include <sysdev/fsl_pci.h>
> > +#include <sysdev/fsl_soc.h>
> > +
> > +#include "mpc86xx.h"
> > +
> > +#undef DEBUG
> > +
> > +#ifdef DEBUG
> > +#define DBG (fmt...) do { printk(KERN_ERR "SBC610: " fmt); } while  
> > (0)
> > +#else
> > +#define DBG (fmt...) do { } while (0)
> > +#endif
> > +
> > +static void __init
> > +gef_sbc610_init_irq(void)
> > +{
> > +	struct mpic *mpic1;
> > +	struct device_node *np;
> > +	struct resource res;
> > +
> > +	/* Determine PIC address. */
> > +	np = of_find_node_by_type(NULL, "open-pic");
> > +	if (np == NULL)
> > +		return;
> > +	of_address_to_resource(np, 0, &res);
> > +
> > +	mpic1 = mpic_alloc(np, res.start,
> > +			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
> > +			0, 256, "mpic");
> > +	of_node_put(np);
> > +	BUG_ON(mpic1 == NULL);
> > +
> > +	mpic_init(mpic1);
> > +}
> 
> any reason not to use mpc86xx_init_irq() in pic.c?
> 

Yes, the afore-mentioned chained interrupt controller that is rather specific to our boards that I will/have added to this function in a patch that I shall post soon.

Martyn

-- 
Martyn Welch MEng MPhil MIET (Principal Software Engineer)   T:+44(0)1327322748
GE Fanuc Intelligent Platforms Ltd,        |Registered in England and Wales
Tove Valley Business Park, Towcester,      |(3828642) at 100 Barbirolli Square,
Northants, NN12 6PF, UK T:+44(0)1327359444 |Manchester,M2 3AB  VAT:GB 729849476
