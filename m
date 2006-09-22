Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 14F1B679E1
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 23:12:37 +1000 (EST)
Date: Fri, 22 Sep 2006 17:12:53 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: Re: [PATCH 3/3] POWERPC: mpc8272ads merge: board-specific/platform
	stuff
Message-ID: <20060922171253.75dc11b6@vitb.ru.mvista.com>
In-Reply-To: <20060922024843.27185.45085.stgit@localhost.localdomain>
References: <20060922064610.0943f1fc@localhost.localdomain>
	<20060922024843.27185.45085.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

Sorry, this patch is broken - something screwed up git commit it seems...
I'll resend ASAP.

-Vitaly

On Fri, 22 Sep 2006 06:48:44 +0400
Vitaly Bordug <vbordug@ru.mvista.com> wrote:

> 
> This intruduces 82xx family in arch/powerpc/platforms,
> and has all the board-specific code to represent regression-less
> transaction from ppc. The functionality is apparently the same, including
> PCI controller.
> 
> Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
> ---
> 
>  arch/powerpc/Kconfig                 |    1 
>  arch/powerpc/boot/dts/mpc8272ads.dts |  236 ----------------------------------
>  arch/powerpc/sysdev/cpm2_pic.c       |    2 
>  arch/powerpc/sysdev/cpm2_pic.h       |    2 
>  arch/powerpc/sysdev/fsl_soc.c        |   68 +---------
>  5 files changed, 9 insertions(+), 300 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 1810216..de1ef2f 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -594,7 +594,6 @@ endmenu
>  
>  source arch/powerpc/platforms/embedded6xx/Kconfig
>  source arch/powerpc/platforms/4xx/Kconfig
> -source arch/powerpc/platforms/82xx/Kconfig
>  source arch/powerpc/platforms/83xx/Kconfig
>  source arch/powerpc/platforms/85xx/Kconfig
>  source arch/powerpc/platforms/86xx/Kconfig
> diff --git a/arch/powerpc/boot/dts/mpc8272ads.dts b/arch/powerpc/boot/dts/mpc8272ads.dts
> deleted file mode 100644
> index 6d72b7d..0000000
> --- a/arch/powerpc/boot/dts/mpc8272ads.dts
> +++ /dev/null
> @@ -1,236 +0,0 @@
> -/*
> - * MPC8272 ADS Device Tree Source
> - *
> - * Copyright 2005 Freescale Semiconductor Inc.
> - *
> - * This program is free software; you can redistribute  it and/or modify it
> - * under  the terms of  the GNU General  Public License as published by the
> - * Free Software Foundation;  either version 2 of the  License, or (at your
> - * option) any later version.
> - */
> -
> -
> -/*
> -/memreserve/   00000000 4000000;
> -*/
> -
> -/ {
> -       model = "MPC8272ADS";
> -       compatible = "MPC8260ADS";
> -       #address-cells = <1>;
> -       #size-cells = <1>;
> -       linux,phandle = <100>;
> -
> -       cpus {
> -               #cpus = <1>;
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               linux,phandle = <200>;
> -
> -               PowerPC,8272@0 {
> -                       device_type = "cpu";
> -                       reg = <0>;
> -                       d-cache-line-size = <20>;       // 32 bytes
> -                       i-cache-line-size = <20>;       // 32 bytes
> -                       d-cache-size = <4000>;          // L1, 16K
> -                       i-cache-size = <4000>;          // L1, 16K
> -                       timebase-frequency = <17d7840>;
> -                       bus-frequency = <5f5e100>;
> -                       clock-frequency = <17D78400>;
> -                       32-bit;
> -                       linux,phandle = <201>;
> -                       linux,boot-cpu;
> -               };
> -       };
> -
> -       interrupt-controller@f8200000 {
> -               linux,phandle = <f8200000>;
> -               #address-cells = <0>;
> -               #interrupt-cells = <2>;
> -               interrupt-controller;
> -               reg = <f8200000 f8200004>;
> -               built-in;
> -               device_type = "pci-pic";
> -       };
> -       memory {
> -               device_type = "memory";
> -               linux,phandle = <300>;
> -               reg = <00000000 4000000 f4500000 00000020>;
> -       };
> -
> -       chosen {
> -               name = "chosen";
> -               bootargs = "root=/dev/nfs rw ip=on";
> -               linux,stdout-path = "/dev/ttyCPM0";
> -               linux,platform = <0>;
> -               interrupt-controller = <10c00>;
> -               linux,phandle = <400>;
> -       };
> -
> -       soc8272@f0000000 {
> -               #address-cells = <1>;
> -               #size-cells = <1>;
> -               #interrupt-cells = <2>;
> -               device_type = "soc";
> -               ranges = < 0 0 2 00000000 f0000000 00053000>;
> -               reg = <f0000000 0>;
> -
> -               mdio@0 {
> -                       device_type = "mdio";
> -                       compatible = "fs_enet";
> -                       reg = <0 0>;
> -                       linux,phandle = <24520>;
> -                       #address-cells = <1>;
> -                       #size-cells = <0>;
> -                       ethernet-phy@0 {
> -                               linux,phandle = <2452000>;
> -                               interrupt-parent = <10c00>;
> -                               interrupts = <19 1>;
> -                               reg = <0>;
> -                               bitbang = [ 12 12 13 02 02 01 ];
> -                               device_type = "ethernet-phy";
> -                       };
> -                       ethernet-phy@1 {
> -                               linux,phandle = <2452001>;
> -                               interrupt-parent = <10c00>;
> -                               interrupts = <19 1>;
> -                               bitbang = [ 12 12 13 02 02 01 ];
> -                               reg = <3>;
> -                               device_type = "ethernet-phy";
> -                       };
> -               };
> -
> -               ethernet@24000 {
> -                       #address-cells = <1>;
> -                       #size-cells = <0>;
> -                       device_type = "network";
> -                       device-id = <2>;
> -                       compatible = "fs_enet";
> -                       model = "FCC";
> -                       reg = <11300 20 8400 100 11380 30>;
> -                       mac-address = [ 00 11 2F 99 43 54 ];
> -                       interrupts = <20 2>;
> -                       interrupt-parent = <10c00>;
> -                       phy-handle = <2452000>;
> -                       rx-clock = <13>;
> -                       tx-clock = <12>;
> -               };
> -
> -               ethernet@25000 {
> -                       device_type = "network";
> -                       device-id = <3>;
> -                       compatible = "fs_enet";
> -                       model = "FCC";
> -                       reg = <11320 20 8500 100 113b0 30>;
> -                       mac-address = [ 00 11 2F 99 44 54 ];
> -                       interrupts = <21 2>;
> -                       interrupt-parent = <10c00>;
> -                       phy-handle = <2452001>;
> -                       rx-clock = <17>;
> -                       tx-clock = <18>;
> -               };
> -
> -               cpm@f0000000 {
> -                       linux,phandle = <f0000000>;
> -                       #address-cells = <1>;
> -                       #size-cells = <1>;
> -                       #interrupt-cells = <2>;
> -                       device_type = "cpm";
> -                       model = "CPM2";
> -                       ranges = <00000000 00000000 3ffff>;
> -                       reg = <10d80 3280>;
> -                       command-proc = <119c0>;
> -                       brg-frequency = <17D7840>;
> -                       cpm_clk = <BEBC200>;
> -
> -                       scc@11a00 {
> -                               device_type = "serial";
> -                               compatible = "cpm_uart";
> -                               model = "SCC";
> -                               device-id = <2>;
> -                               reg = <11a00 20 8000 100>;
> -                               current-speed = <1c200>;
> -                               interrupts = <28 2>;
> -                               interrupt-parent = <10c00>;
> -                               clock-setup = <0 00ffffff>;
> -                               rx-clock = <1>;
> -                               tx-clock = <1>;
> -                       };
> -
> -                       scc@11a60 {
> -                               device_type = "serial";
> -                               compatible = "cpm_uart";
> -                               model = "SCC";
> -                               device-id = <5>;
> -                               reg = <11a60 20 8300 100>;
> -                               current-speed = <1c200>;
> -                               interrupts = <2b 2>;
> -                               interrupt-parent = <10c00>;
> -                               clock-setup = <1b ffffff00>;
> -                               rx-clock = <4>;
> -                               tx-clock = <4>;
> -                       };
> -
> -               };
> -               interrupt-controller@10c00 {
> -                       linux,phandle = <10c00>;
> -                       #address-cells = <0>;
> -                       #interrupt-cells = <2>;
> -                       interrupt-controller;
> -                       reg = <10c00 80>;
> -                       built-in;
> -                       device_type = "cpm-pic";
> -               };
> -               pci@0500 {
> -                       linux,phandle = <0500>;
> -                       #interrupt-cells = <1>;
> -                       #size-cells = <2>;
> -                       #address-cells = <3>;
> -                       compatible = "8272";
> -                       device_type = "pci";
> -                       reg = <10430 4dc>;
> -                       clock-frequency = <3f940aa>;
> -                       interrupt-map-mask = <f800 0 0 7>;
> -                       interrupt-map = <
> -
> -                                       /* IDSEL 0x16 */
> -                                        b000 0 0 1 f8200000 40 0
> -                                        b000 0 0 2 f8200000 41 0
> -                                        b000 0 0 3 f8200000 42 0
> -                                        b000 0 0 4 f8200000 43 0
> -
> -                                       /* IDSEL 0x17 */
> -                                        b800 0 0 1 f8200000 43 0
> -                                        b800 0 0 2 f8200000 40 0
> -                                        b800 0 0 3 f8200000 41 0
> -                                        b800 0 0 4 f8200000 42 0
> -
> -                                       /* IDSEL 0x18 */
> -                                        c000 0 0 1 f8200000 42 0
> -                                        c000 0 0 2 f8200000 43 0
> -                                        c000 0 0 3 f8200000 40 0
> -                                        c000 0 0 4 f8200000 41 0>;
> -                       interrupt-parent = <10c00>;
> -                       interrupts = <14 3>;
> -                       bus-range = <0 0>;
> -                       ranges = <02000000 0 80000000 80000000 0 40000000
> -                                 01000000 0 00000000 f6000000 0 02000000>;
> -               };
> -
> -/* May need to remove if on a part without crypto engine */
> -               crypto@30000 {
> -                       device_type = "crypto";
> -                       model = "SEC2";
> -                       compatible = "talitos";
> -                       reg = <30000 10000>;
> -                       interrupts = <b 0>;
> -                       interrupt-parent = <10c00>;
> -                       num-channels = <4>;
> -                       channel-fifo-len = <18>;
> -                       exec-units-mask = <0000007e>;
> -/* desc mask is for rev1.x, we need runtime fixup for >=2.x */
> -                       descriptor-types-mask = <01010ebf>;
> -               };
> -
> -       };
> -};
> diff --git a/arch/powerpc/sysdev/cpm2_pic.c b/arch/powerpc/sysdev/cpm2_pic.c
> index 28b0189..5175299 100644
> --- a/arch/powerpc/sysdev/cpm2_pic.c
> +++ b/arch/powerpc/sysdev/cpm2_pic.c
> @@ -147,7 +147,7 @@ static struct irq_chip cpm2_pic = {
>  	.end = cpm2_end_irq,
>  };
>  
> -unsigned int cpm2_get_irq(struct pt_regs *regs)
> +int cpm2_get_irq(struct pt_regs *regs)
>  {
>  	int irq;
>  	unsigned long bits;
> diff --git a/arch/powerpc/sysdev/cpm2_pic.h b/arch/powerpc/sysdev/cpm2_pic.h
> index 3c513e5..d63e45d 100644
> --- a/arch/powerpc/sysdev/cpm2_pic.h
> +++ b/arch/powerpc/sysdev/cpm2_pic.h
> @@ -3,7 +3,7 @@ #define _PPC_KERNEL_CPM2_H
>  
>  extern intctl_cpm2_t *cpm2_intctl;
>  
> -extern unsigned int cpm2_get_irq(struct pt_regs *regs);
> +extern int cpm2_get_irq(struct pt_regs *regs);
>  
>  extern void cpm2_pic_init(struct device_node*);
>  
> diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
> index 39b76f9..022ed27 100644
> --- a/arch/powerpc/sysdev/fsl_soc.c
> +++ b/arch/powerpc/sysdev/fsl_soc.c
> @@ -37,7 +37,6 @@ #include <mm/mmu_decl.h>
>  #include <asm/cpm2.h>
>  
>  extern void init_fcc_ioports(struct fs_platform_info*);
> -extern void init_scc_ioports(struct fs_uart_platform_info*);
>  static phys_addr_t immrbase = -1;
>  
>  phys_addr_t get_immrbase(void)
> @@ -567,7 +566,7 @@ static int __init fs_enet_of_init(void)
>  		struct resource r[4];
>  		struct device_node *phy, *mdio;
>  		struct fs_platform_info fs_enet_data;
> -		const unsigned int *id, *phy_addr, phy_irq;
> +		const unsigned int *id, *phy_addr;
>  		const void *mac_addr;
>  		const phandle *ph;
>  		const char *model;
> @@ -589,7 +588,6 @@ static int __init fs_enet_of_init(void)
>  		if (ret)
>  			goto err;
>  		r[2].name = fcc_regs_c;
> -		fs_enet_data.fcc_regs_c = r[2].start;
>  
>  		r[3].start = r[3].end = irq_of_parse_and_map(np, 0);
>  		r[3].flags = IORESOURCE_IRQ;
> @@ -622,8 +620,6 @@ static int __init fs_enet_of_init(void)
>  		phy_addr = get_property(phy, "reg", NULL);
>  		fs_enet_data.phy_addr = *phy_addr;
>  
> -		phy_irq = get_property(phy, "interrupts", NULL);
> -
>  		id = get_property(np, "device-id", NULL);
>  		fs_enet_data.fs_no = *id;
>  		strcpy(fs_enet_data.fs_type, model);
> @@ -641,7 +637,6 @@ static int __init fs_enet_of_init(void)
>  
>  		if (strstr(model, "FCC")) {
>  			int fcc_index = *id - 1;
> -			unsigned char* mdio_bb_prop;
>  
>  			fs_enet_data.dpram_offset = (u32)cpm_dpram_addr(0);
>  			fs_enet_data.rx_ring = 32;
> @@ -657,63 +652,14 @@ static int __init fs_enet_of_init(void)
>  							(u32)res.start, fs_enet_data.phy_addr);
>  			fs_enet_data.bus_id = (char*)&bus_id[(*id)];
>  			fs_enet_data.init_ioports = init_fcc_ioports;
> +		}
>  
> -			mdio_bb_prop = get_property(phy, "bitbang", NULL);
> -			if (mdio_bb_prop) {
> -			struct platform_device *fs_enet_mdio_bb_dev;
> -			struct fs_mii_bb_platform_info fs_enet_mdio_bb_data;
> -
> -			fs_enet_mdio_bb_dev =
> -			platform_device_register_simple("fsl-bb-mdio",
> -			i, NULL, 0);
> -			memset(&fs_enet_mdio_bb_data, 0,
> -			sizeof(struct fs_mii_bb_platform_info));
> -				fs_enet_mdio_bb_data.mdio_dat.bit =
> -					mdio_bb_prop[0];
> -				fs_enet_mdio_bb_data.mdio_dir.bit =
> -					mdio_bb_prop[1];
> -				fs_enet_mdio_bb_data.mdc_dat.bit =
> -					mdio_bb_prop[2];
> -				fs_enet_mdio_bb_data.mdio_port =
> -					mdio_bb_prop[3];
> -				fs_enet_mdio_bb_data.mdc_port =
> -					mdio_bb_prop[4];
> -				fs_enet_mdio_bb_data.delay =
> -					mdio_bb_prop[5];
> -
> -				fs_enet_mdio_bb_data.irq[0] = phy_irq[0];
> -				fs_enet_mdio_bb_data.irq[1] = -1;
> -				fs_enet_mdio_bb_data.irq[2] = -1;
> -				fs_enet_mdio_bb_data.irq[3] = phy_irq[0];
> -				fs_enet_mdio_bb_data.irq[31] = -1;
> -
> -				fs_enet_mdio_bb_data.mdio_dat.offset =
> -					(u32)&cpm2_immr->im_ioport.iop_pdatc;
> -				fs_enet_mdio_bb_data.mdio_dir.offset =
> -					(u32)&cpm2_immr->im_ioport.iop_pdirc;
> -				fs_enet_mdio_bb_data.mdc_dat.offset =
> -					(u32)&cpm2_immr->im_ioport.iop_pdatc;
> -
> -				ret = platform_device_add_data(
> -					fs_enet_mdio_bb_dev,
> -					&fs_enet_mdio_bb_data,
> -					sizeof(struct fs_mii_bb_platform_info));
> -				if (ret)
> -					goto unreg;
> -				} else {
> -					printk(KERN_ERR
> -					"mii-properties isn't found in device tree\n");
> -					ret = -ENODEV;
> -					goto unreg;
> -				}
> -			}
> -
> -			of_node_put(phy);
> -			of_node_put(mdio);
> +		of_node_put(phy);
> +		of_node_put(mdio);
>  
> -			ret = platform_device_add_data(fs_enet_dev, &fs_enet_data,
> -						     sizeof(struct
> -							    fs_platform_info));
> +		ret = platform_device_add_data(fs_enet_dev, &fs_enet_data,
> +					     sizeof(struct
> +						    fs_platform_info));
>  		if (ret)
>  			goto unreg;
>  	}
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> 


-- 
Sincerely, 
Vitaly
