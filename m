Return-Path: <felix@embedded-sol.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9DF36B6F31
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Aug 2009 16:29:20 +1000 (EST)
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D625BDDD0B
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2009 16:29:18 +1000 (EST)
Message-ID: <4A7A776D.7080400@embedded-sol.com>
Date: Thu, 06 Aug 2009 09:25:49 +0300
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Poonam Aggrwal <poonam.aggrwal@freescale.com>
Subject: Re: [PATCH][powerpc/85xx] P2020RDB Platform Support Added
References: <1249532639-20070-1-git-send-email-poonam.aggrwal@freescale.com>
In-Reply-To: <1249532639-20070-1-git-send-email-poonam.aggrwal@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linuxppc-release@webnode01-prod1.am.freescale.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Poonam

Poonam Aggrwal wrote:
> Adds P2020RDB basic support in linux.
> Overview of P2020RDB platform
> 	- DDR
> 	  DDR2 1G
> 	- NOR Flash
> 	  16MByte
> 	- NAND Flash
> 	  32MByte
> 	- 3 Ethernet interfaces
> 	  1) etSEC1
> 		- RGMII
> 		- connected to a 5 port Vitesse Switch(VSC7385)
> 		- Switch is memory mapped through eLBC interface(CS#2)
> 		- IRQ1
> 	  2) etSEC2
> 		- SGMII
> 		- connected to VSC8221
> 		- IRQ2
> 	  3) etSEC3
> 		- RGMII
> 		- connected to VSC8641
> 		- IRQ3
> 	- 2 1X PCIe interfaces
> 	- SD/MMC ,USB
> 	- SPI EEPROM
> 	- Serial I2C EEPROM
>
> Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
> ---
> based on http://www.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git
>  arch/powerpc/boot/dts/p2020rdb.dts        |  586 +++++++++++++++++++++++++++++
>  arch/powerpc/configs/mpc85xx_defconfig    |    1 +
>  arch/powerpc/platforms/85xx/Kconfig       |    9 +
>  arch/powerpc/platforms/85xx/Makefile      |    3 +-
>  arch/powerpc/platforms/85xx/mpc85xx_rdb.c |  141 +++++++
>  5 files changed, 739 insertions(+), 1 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/p2020rdb.dts
>  create mode 100644 arch/powerpc/platforms/85xx/mpc85xx_rdb.c
>
> diff --git a/arch/powerpc/boot/dts/p2020rdb.dts b/arch/powerpc/boot/dts/p2020rdb.dts
> new file mode 100644
> index 0000000..d6d8131
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/p2020rdb.dts
> @@ -0,0 +1,586 @@
> +/*
> + * P2020 RDB Device Tree Source
> + *
> + * Copyright 2009 Freescale Semiconductor Inc.
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +/dts-v1/;
> +/ {
> +	model = "fsl,P2020";
> +	compatible = "fsl,P2020RDB";
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	aliases {
> +		ethernet0 = &enet0;
> +		ethernet1 = &enet1;
> +		ethernet2 = &enet2;
> +		serial0 = &serial0;
> +		serial1 = &serial1;
> +		pci0 = &pci0;
> +		pci1 = &pci1;
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		PowerPC,P2020@0 {
> +			device_type = "cpu";
> +			reg = <0x0>;
> +			next-level-cache = <&L2>;
> +		};
> +
> +		PowerPC,P2020@1 {
> +			device_type = "cpu";
> +			reg = <0x1>;
> +			next-level-cache = <&L2>;
> +		};
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +	};
> +
> +	localbus@ffe05000 {
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		compatible = "fsl,p2020-elbc", "fsl,elbc", "simple-bus";
> +		reg = <0 0xffe05000 0 0x1000>;
> +		interrupts = <19 2>;
> +		interrupt-parent = <&mpic>;
> +
> +		/* NOR and NAND Flashes */
> +		ranges = <0x0 0x0 0x0 0xef000000 0x01000000
> +			  0x1 0x0 0x0 0xffa00000 0x00040000
> +			  0x2 0x0 0x0 0xffb00000 0x08000000>;
>   

The comment is a bit misleading, CS2 is L2 switch. Also, are you sure
the CS2 range shouldn't look like
      
0x2 0x0 0x0 0xffb00000 0x00020000

That's what L2switch reg property suggests.            
> +
> +		nor@0,0 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "cfi-flash";
> +			reg = <0x0 0x0 0x1000000>;
> +			bank-width = <2>;
> +			device-width = <1>;
> +
> +			vitesse-7385-fw@0 {
> +				/* This location must not be altered  */
> +				/* 256KB for Vitesse 7385 Switch firmware */
> +				reg = <0x0 0x00040000>;
> +				label = "NOR (RO) Vitesse-7385 Firmware";
> +				read-only;
> +			};
>   
Partitions should be declared as

       partition@0 {
                   reg = ...
                   label = ...
                   ...
        } 

Felix.
