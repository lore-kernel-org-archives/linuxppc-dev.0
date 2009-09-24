Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8509CB70B3
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Sep 2009 04:11:56 +1000 (EST)
Subject: Re: [PATCH][powerpc/85xx] P2020RDB Platform Support Added
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4A7A776D.7080400@embedded-sol.com>
Date: Thu, 24 Sep 2009 11:11:38 -0700
Message-Id: <87B3AA50-1B12-43D6-9F92-37AA9E5BC142@kernel.crashing.org>
References: <1249532639-20070-1-git-send-email-poonam.aggrwal@freescale.com>
	<4A7A776D.7080400@embedded-sol.com>
To: Poonam Aggrwal <poonam.aggrwal@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Felix Radensky <felix@embedded-sol.com>,
	linuxppc-release@webnode01-prod1.am.freescale.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 5, 2009, at 11:25 PM, Felix Radensky wrote:

> Hi, Poonam
>
> Poonam Aggrwal wrote:
>> Adds P2020RDB basic support in linux.
>> Overview of P2020RDB platform
>> 	- DDR
>> 	  DDR2 1G
>> 	- NOR Flash
>> 	  16MByte
>> 	- NAND Flash
>> 	  32MByte
>> 	- 3 Ethernet interfaces
>> 	  1) etSEC1
>> 		- RGMII
>> 		- connected to a 5 port Vitesse Switch(VSC7385)
>> 		- Switch is memory mapped through eLBC interface(CS#2)
>> 		- IRQ1
>> 	  2) etSEC2
>> 		- SGMII
>> 		- connected to VSC8221
>> 		- IRQ2
>> 	  3) etSEC3
>> 		- RGMII
>> 		- connected to VSC8641
>> 		- IRQ3
>> 	- 2 1X PCIe interfaces
>> 	- SD/MMC ,USB
>> 	- SPI EEPROM
>> 	- Serial I2C EEPROM
>>
>> Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
>> ---
>> based on http://www.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git
>> arch/powerpc/boot/dts/p2020rdb.dts        |  586 +++++++++++++++++++ 
>> ++++++++++
>> arch/powerpc/configs/mpc85xx_defconfig    |    1 +
>> arch/powerpc/platforms/85xx/Kconfig       |    9 +
>> arch/powerpc/platforms/85xx/Makefile      |    3 +-
>> arch/powerpc/platforms/85xx/mpc85xx_rdb.c |  141 +++++++
>> 5 files changed, 739 insertions(+), 1 deletions(-)
>> create mode 100644 arch/powerpc/boot/dts/p2020rdb.dts
>> create mode 100644 arch/powerpc/platforms/85xx/mpc85xx_rdb.c
>>
>> diff --git a/arch/powerpc/boot/dts/p2020rdb.dts b/arch/powerpc/boot/ 
>> dts/p2020rdb.dts
>> new file mode 100644
>> index 0000000..d6d8131
>> --- /dev/null
>> +++ b/arch/powerpc/boot/dts/p2020rdb.dts
>> @@ -0,0 +1,586 @@
>> +/*
>> + * P2020 RDB Device Tree Source
>> + *
>> + * Copyright 2009 Freescale Semiconductor Inc.
>> + *
>> + * This program is free software; you can redistribute  it and/or  
>> modify it
>> + * under  the terms of  the GNU General  Public License as  
>> published by the
>> + * Free Software Foundation;  either version 2 of the  License, or  
>> (at your
>> + * option) any later version.
>> + */
>> +
>> +/dts-v1/;
>> +/ {
>> +	model = "fsl,P2020";
>> +	compatible = "fsl,P2020RDB";
>> +	#address-cells = <2>;
>> +	#size-cells = <2>;
>> +
>> +	aliases {
>> +		ethernet0 = &enet0;
>> +		ethernet1 = &enet1;
>> +		ethernet2 = &enet2;
>> +		serial0 = &serial0;
>> +		serial1 = &serial1;
>> +		pci0 = &pci0;
>> +		pci1 = &pci1;
>> +	};
>> +
>> +	cpus {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		PowerPC,P2020@0 {
>> +			device_type = "cpu";
>> +			reg = <0x0>;
>> +			next-level-cache = <&L2>;
>> +		};
>> +
>> +		PowerPC,P2020@1 {
>> +			device_type = "cpu";
>> +			reg = <0x1>;
>> +			next-level-cache = <&L2>;
>> +		};
>> +	};
>> +
>> +	memory {
>> +		device_type = "memory";
>> +	};
>> +
>> +	localbus@ffe05000 {
>> +		#address-cells = <2>;
>> +		#size-cells = <1>;
>> +		compatible = "fsl,p2020-elbc", "fsl,elbc", "simple-bus";
>> +		reg = <0 0xffe05000 0 0x1000>;
>> +		interrupts = <19 2>;
>> +		interrupt-parent = <&mpic>;
>> +
>> +		/* NOR and NAND Flashes */
>> +		ranges = <0x0 0x0 0x0 0xef000000 0x01000000
>> +			  0x1 0x0 0x0 0xffa00000 0x00040000
>> +			  0x2 0x0 0x0 0xffb00000 0x08000000>;
>>
>
> The comment is a bit misleading, CS2 is L2 switch. Also, are you sure
> the CS2 range shouldn't look like
>     0x2 0x0 0x0 0xffb00000 0x00020000
>
> That's what L2switch reg property suggests.

Did you plan on making this change?

>> +		nor@0,0 {
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			compatible = "cfi-flash";
>> +			reg = <0x0 0x0 0x1000000>;
>> +			bank-width = <2>;
>> +			device-width = <1>;
>> +
>> +			vitesse-7385-fw@0 {
>> +				/* This location must not be altered  */
>> +				/* 256KB for Vitesse 7385 Switch firmware */
>> +				reg = <0x0 0x00040000>;
>> +				label = "NOR (RO) Vitesse-7385 Firmware";
>> +				read-only;
>> +			};
>>
> Partitions should be declared as
>
>      partition@0 {
>                  reg = ...
>                  label = ...
>                  ...
>       }
> Felix.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
