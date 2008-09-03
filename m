Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id AEC83DDE1A
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Sep 2008 16:36:05 +1000 (EST)
Message-ID: <48BE30BC.1030307@coritel.it>
Date: Wed, 03 Sep 2008 08:37:48 +0200
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: Laxmikant Rashinkar <lk.atwork@yahoo.com>
Subject: Re: need help with GPIO
References: <520295.39660.qm@web46316.mail.sp1.yahoo.com>
In-Reply-To: <520295.39660.qm@web46316.mail.sp1.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

try to understand why the driver doesn't find the device reading the 
gpio.c and of_get_gpio(). Maybe the device has been registered as a 
platform device and, instead, the driver calls some function for a 
specific device.

Regards.

Laxmikant Rashinkar ha scritto:
> Hi Marco,
>
> thanks for your feedback.
>
> I tried out your suggestion of  using an offset address instead of an absolute address in the dts, but that did not help.
> I am still getting the error:
>
> LK_DEBUG: gpio.c : of_get_gpio : /localbus/upm@1,0: gpio controller /soc8349@e0000000/gpio-controller@c00: is not registered
>
> thanks
> LK
>
>
>
>
> ----- Original Message ----
> From: Marco Stornelli <marco.stornelli@coritel.it>
> To: Laxmikant Rashinkar <lk.atwork@yahoo.com>
> Cc: linuxppc-embedded@ozlabs.org
> Sent: Monday, September 1, 2008 11:39:05 PM
> Subject: Re: need help with GPIO
>
> Laxmikant Rashinkar ha scritto:
>   
>> Hi,
>>
>> I have a MPC8347 based embedded PC running Linux 2.6.27.
>> I am trying to access a NAND device connected to the LBC and UPM.
>> The Ready/Busy* pin of the NAND device is connected to the built in GPIO-1 on pin 4 (input).
>>
>> When I try to access the NAND device, the function of_get_gpio() from drivers/of/gpio.c gets called, and
>> it reports that my GPIO is not registered. Here are the actual debug messages:
>>
>> LK_DEBUG: gpio.c : of_get_gpio : name=upm type=<NULL> index=0
>> LK_DEBUG: gpio.c : of_get_gpio : got property
>> LK_DEBUG: gpio.c : of_get_gpio : nr_cell=3
>> LK_DEBUG: gpio.c : of_get_gpio : gc.name=gpio-controller gc.type=<NULL> gc->Data=0x0
>> LK_DEBUG: gpio.c : of_get_gpio : /localbus/upm@1,0: gpio controller /soc8349@e0000000/gpio-controller@e0000c00: is not registered
>>
>> When I check in /proc/device-tree/soc8349@e0000000/, I find that entries are present for both GPIOs are present.
>>
>> Here are debug registration messages, indicating that gpio registered successfully:
>>
>> ##### LK_DEBUG: of_plat_dev_create : NAME=soc8349
>> ##### LK_DEBUG: of_plat_dev_create : NAME=wdt
>> ##### LK_DEBUG: of_plat_dev_create : NAME=i2c
>> ##### LK_DEBUG: of_plat_dev_create : NAME=i2c
>> ##### LK_DEBUG: of_plat_dev_create : NAME=spi
>> ##### LK_DEBUG: of_plat_dev_create : NAME=dma
>> ##### LK_DEBUG: of_plat_dev_create : NAME=usb
>> ##### LK_DEBUG: of_plat_dev_create : NAME=usb
>> ##### LK_DEBUG: of_plat_dev_create : NAME=mdio
>> ##### LK_DEBUG: of_plat_dev_create : NAME=ethernet
>> ##### LK_DEBUG: of_plat_dev_create : NAME=ethernet
>> ##### LK_DEBUG: of_plat_dev_create : NAME=serial
>> ##### LK_DEBUG: of_plat_dev_create : NAME=serial
>> ##### LK_DEBUG: of_plat_dev_create : NAME=crypto
>> ##### LK_DEBUG: of_plat_dev_create : NAME=pic
>> ##### LK_DEBUG: of_plat_dev_create : NAME=gpio-controller
>> ##### LK_DEBUG: of_plat_dev_create : NAME=gpio-controller
>> ##### LK_DEBUG: of_plat_dev_create : NAME=localbus
>> ##### LK_DEBUG: of_plat_dev_create : NAME=upm
>>
>> Most probably something is wrong in my device tree (listed below). Can someone please point me in the right direction?
>>
>> thanks a lot for your help.
>> LK
>>
>> -------------------------------------------------------------
>>
>> /*
>>  * MPC8349E MDS Device Tree Source
>>  *
>>  * Copyright 2005, 2006 Freescale Semiconductor Inc.
>>  *
>>  * This program is free software; you can redistribute  it and/or modify it
>>  * under  the terms of  the GNU General  Public License as published by the
>>  * Free Software Foundation;  either version 2 of the  License, or (at your
>>  * option) any later version.
>>  */
>>
>> /dts-v1/;
>>
>> / {
>>         model = "MPC8349EMDS";
>>         compatible = "MPC8349EMDS", "MPC834xMDS", "MPC83xxMDS";
>>         #address-cells = <1>;
>>         #size-cells = <1>;
>>
>>         aliases {
>>                 ethernet0 = &enet0;
>>                 ethernet1 = &enet1;
>>                 serial0 = &serial0;
>>                 serial1 = &serial1;
>>                 pci0 = &pci0;
>>                 pci1 = &pci1;
>>         };
>>
>>         cpus {
>>                 #address-cells = <1>;
>>                 #size-cells = <0>;
>>
>>                 PowerPC,8349@0 {
>>                         device_type = "cpu";
>>                         reg = <0x0>;
>>                         d-cache-line-size = <32>;
>>                         i-cache-line-size = <32>;
>>                         d-cache-size = <32768>;
>>                         i-cache-size = <32768>;
>>                         timebase-frequency = <0>;       // from bootloader
>>                         bus-frequency = <0>;            // from bootloader
>>                         clock-frequency = <0>;          // from bootloader
>>                 };
>>         };
>>
>>         memory {
>>                 device_type = "memory";
>>                 reg = <0x00000000 0x10000000>;  // 256MB at 0
>>         };
>>
>>         bcsr@e2400000 {
>>                 device_type = "board-control";
>>                 reg = <0xe2400000 0x8000>;
>>         };
>>
>>         soc8349@e0000000 {
>>                 #address-cells = <1>;
>>                 #size-cells = <1>;
>>                 device_type = "soc";
>>                 compatible = "simple-bus";
>>                 ranges = <0x0 0xe0000000 0x00100000>;
>>                 reg = <0xe0000000 0x00000200>;
>>                 bus-frequency = <0>;
>>
>>                 wdt@200 {
>>                         device_type = "watchdog";
>>                         compatible = "mpc83xx_wdt";
>>                         reg = <0x200 0x100>;
>>                 };
>>
>>                 i2c@3000 {
>>                         #address-cells = <1>;
>>                         #size-cells = <0>;
>>                         cell-index = <0>;
>>                         compatible = "fsl-i2c";
>>                         reg = <0x3000 0x100>;
>>                         interrupts = <14 0x8>;
>>                         interrupt-parent = <&ipic>;
>>                         dfsrr;
>>
>>                         rtc@68 {
>>                                 compatible = "dallas,ds1374";
>>                                 reg = <0x68>;
>>                         };
>>                 };
>>
>>                 i2c@3100 {
>>                         #address-cells = <1>;
>>                         #size-cells = <0>;
>>                         cell-index = <1>;
>>                         compatible = "fsl-i2c";
>>                         reg = <0x3100 0x100>;
>>                         interrupts = <15 0x8>;
>>                         interrupt-parent = <&ipic>;
>>                         dfsrr;
>>                 };
>>
>>                 spi@7000 {
>>                         cell-index = <0>;
>>                         compatible = "fsl,spi";
>>                         reg = <0x7000 0x1000>;
>>                         interrupts = <16 0x8>;
>>                         interrupt-parent = <&ipic>;
>>                         mode = "cpu";
>>                 };
>>
>>                 dma@82a8 {
>>                         #address-cells = <1>;
>>                         #size-cells = <1>;
>>                         compatible = "fsl,mpc8349-dma", "fsl,elo-dma";
>>                         reg = <0x82a8 4>;
>>                         ranges = <0 0x8100 0x1a8>;
>>                         interrupt-parent = <&ipic>;
>>                         interrupts = <71 8>;
>>                         cell-index = <0>;
>>                         dma-channel@0 {
>>                                 compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
>>                                 reg = <0 0x80>;
>>                                 interrupt-parent = <&ipic>;
>>                                 interrupts = <71 8>;
>>                         };
>>                         dma-channel@80 {
>>                                 compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
>>                                 reg = <0x80 0x80>;
>>                                 interrupt-parent = <&ipic>;
>>                                 interrupts = <71 8>;
>>                         };
>>                         dma-channel@100 {
>>                                 compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
>>                                 reg = <0x100 0x80>;
>>                                 interrupt-parent = <&ipic>;
>>                                 interrupts = <71 8>;
>>                         };
>>                         dma-channel@180 {
>>                                 compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
>>                                 reg = <0x180 0x28>;
>>                                 interrupt-parent = <&ipic>;
>>                                 interrupts = <71 8>;
>>                         };
>>                 };
>>
>>                 /* phy type (ULPI or SERIAL) are only types supported for MPH */
>>                 /* port = 0 or 1 */
>>                 usb@22000 {
>>                         compatible = "fsl-usb2-mph";
>>                         reg = <0x22000 0x1000>;
>>                         #address-cells = <1>;
>>                         #size-cells = <0>;
>>                         interrupt-parent = <&ipic>;
>>                         interrupts = <39 0x8>;
>>                         phy_type = "ulpi";
>>                         port1;
>>                 };
>>                 /* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
>>                 usb@23000 {
>>                         compatible = "fsl-usb2-dr";
>>                         reg = <0x23000 0x1000>;
>>                         #address-cells = <1>;
>>                         #size-cells = <0>;
>>                         interrupt-parent = <&ipic>;
>>                         interrupts = <38 0x8>;
>>                         dr_mode = "otg";
>>                         phy_type = "ulpi";
>>                 };
>>
>>                 mdio@24520 {
>>                         #address-cells = <1>;
>>                         #size-cells = <0>;
>>                         compatible = "fsl,gianfar-mdio";
>>                         reg = <0x24520 0x20>;
>>
>>                         phy0: ethernet-phy@0 {
>>                                 interrupt-parent = <&ipic>;
>>                                 interrupts = <17 0x8>;
>>                                 reg = <0x1>;
>>                                 device_type = "ethernet-phy";
>>                         };
>>                         phy1: ethernet-phy@1 {
>>                                 interrupt-parent = <&ipic>;
>>                                 interrupts = <18 0x8>;
>>                                 reg = <0x2>;
>>                                 device_type = "ethernet-phy";
>>                         };
>>                 };
>>
>>                 enet0: ethernet@24000 {
>>                         cell-index = <0>;
>>                         device_type = "network";
>>                         model = "TSEC";
>>                         compatible = "gianfar";
>>                         reg = <0x24000 0x1000>;
>>                         local-mac-address = [ 00 00 00 00 00 00 ];
>>                         interrupts = <32 0x8 33 0x8 34 0x8>;
>>                         interrupt-parent = <&ipic>;
>>                         phy-handle = <&phy0>;
>>                         linux,network-index = <0>;
>>                 };
>>
>>                 enet1: ethernet@25000 {
>>                         cell-index = <1>;
>>                         device_type = "network";
>>                         model = "TSEC";
>>                         compatible = "gianfar";
>>                         reg = <0x25000 0x1000>;
>>                         local-mac-address = [ 00 00 00 00 00 00 ];
>>                         interrupts = <35 0x8 36 0x8 37 0x8>;
>>                         interrupt-parent = <&ipic>;
>>                         phy-handle = <&phy1>;
>>                         linux,network-index = <1>;
>>                 };
>>
>>                 serial0: serial@4500 {
>>                         cell-index = <0>;
>>                         device_type = "serial";
>>                         compatible = "ns16550";
>>                         reg = <0x4500 0x100>;
>>                         clock-frequency = <0>;
>>                         interrupts = <9 0x8>;
>>                         interrupt-parent = <&ipic>;
>>                 };
>>
>>                 serial1: serial@4600 {
>>                         cell-index = <1>;
>>                         device_type = "serial";
>>                         compatible = "ns16550";
>>                         reg = <0x4600 0x100>;
>>                         clock-frequency = <0>;
>>                         interrupts = <10 0x8>;
>>                         interrupt-parent = <&ipic>;
>>                 };
>>
>>                 crypto@30000 {
>>                         compatible = "fsl,sec2.0";
>>                         reg = <0x30000 0x10000>;
>>                         interrupts = <11 0x8>;
>>                         interrupt-parent = <&ipic>;
>>                         fsl,num-channels = <4>;
>>                         fsl,channel-fifo-len = <24>;
>>                         fsl,exec-units-mask = <0x7e>;
>>                         fsl,descriptor-types-mask = <0x01010ebf>;
>>                 };
>>
>>                 /* IPIC
>>                  * interrupts cell = <intr #, sense>
>>                  * sense values match linux IORESOURCE_IRQ_* defines:
>>                  * sense == 8: Level, low assertion
>>                  * sense == 2: Edge, high-to-low change
>>                  */
>>                 ipic: pic@700 {
>>                         interrupt-controller;
>>                         #address-cells = <0>;
>>                         #interrupt-cells = <2>;
>>                         reg = <0x700 0x100>;
>>                         device_type = "ipic";
>>                 };
>>
>>     
>
> Here you are using absolute addresses but you should use an offset from 
> a base reg address, in your case e0000000.
>
>   
>>                 gpio1: gpio-controller@e0000c00 {
>>     
>                    gpio1: gpio-controller@c00 {
>   
>>                         #gpio-cells = <2>;
>>                         compatible = "fsl,mpc8349-gpio-bank";
>>     
>                            reg = <0xc00 0x100>;
>   
>>                         reg = <0xe0000c00 0x100>;
>>                         gpio-controller;
>>                 };
>>
>>     
>                    gpio2: gpio-controller@d00 {
>   
>>                 gpio2: gpio-controller@e0000d00 {
>>                         #gpio-cells = <2>;
>>                         compatible = "fsl,mpc8349-gpio-bank";
>>     
>                            reg = <0xd00 0x100>;
>   
>>                         reg = <0xe0000d00 0x100>;
>>                         gpio-controller;
>>                 };
>>         };
>>
>>         localbus {
>>                 compatible = "fsl,pq3-localbus", "simple-bus";
>>                 #address-cells = <2>;
>>                 #size-cells = <1>;
>>                 reg = <0xe0005000 0x100000>;       // BRx, ORx, etc.
>>
>>                 upm@1,0 {
>>                         #address-cells = <1>;
>>                         #size-cells = <1>;
>>                         compatible = "fsl,upm-nand";
>>                         reg = <3 0xa0000000 0x800>;
>>                         fsl,upm-addr-offset = <0x10>;
>>                         fsl,upm-cmd-offset = <0x08>;
>>                         gpios = <&gpio1 4 0>;
>>
>>                         nand@0 {
>>                                 #address-cells = <1>;
>>                                 #size-cells = <1>;
>>                                 compatible = "fsl,lbc-nand";
>>
>>                                 partition@0 {
>>                                         label = "EVERYTHING";
>>                                         reg = <0x00000000 0x01000000>;
>>                                 };
>>                         };
>>                 };
>>         };
>>
>>         pci0: pci@e0008500 {
>>                 cell-index = <1>;
>>                 interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
>>                 interrupt-map = <
>>
>>                                 /* IDSEL 0x11 */
>>                                  0x8800 0x0 0x0 0x1 &ipic 20 0x8
>>                                  0x8800 0x0 0x0 0x2 &ipic 21 0x8
>>                                  0x8800 0x0 0x0 0x3 &ipic 22 0x8
>>                                  0x8800 0x0 0x0 0x4 &ipic 23 0x8
>>
>>                                 /* IDSEL 0x12 */
>>                                  0x9000 0x0 0x0 0x1 &ipic 22 0x8
>>                                  0x9000 0x0 0x0 0x2 &ipic 23 0x8
>>                                  0x9000 0x0 0x0 0x3 &ipic 20 0x8
>>                                  0x9000 0x0 0x0 0x4 &ipic 21 0x8
>>
>>                                 /* IDSEL 0x13 */
>>                                  0x9800 0x0 0x0 0x1 &ipic 23 0x8
>>                                  0x9800 0x0 0x0 0x2 &ipic 20 0x8
>>                                  0x9800 0x0 0x0 0x3 &ipic 21 0x8
>>                                  0x9800 0x0 0x0 0x4 &ipic 22 0x8
>>
>>                                 /* IDSEL 0x15 */
>>                                  0xa800 0x0 0x0 0x1 &ipic 20 0x8
>>                                  0xa800 0x0 0x0 0x2 &ipic 21 0x8
>>                                  0xa800 0x0 0x0 0x3 &ipic 22 0x8
>>                                  0xa800 0x0 0x0 0x4 &ipic 23 0x8
>>
>>                                 /* IDSEL 0x16 */
>>                                  0xb000 0x0 0x0 0x1 &ipic 23 0x8
>>                                  0xb000 0x0 0x0 0x2 &ipic 20 0x8
>>                                  0xb000 0x0 0x0 0x3 &ipic 21 0x8
>>                                  0xb000 0x0 0x0 0x4 &ipic 22 0x8
>>
>>                                 /* IDSEL 0x17 */
>>                                  0xb800 0x0 0x0 0x1 &ipic 22 0x8
>>                                  0xb800 0x0 0x0 0x2 &ipic 23 0x8
>>                                  0xb800 0x0 0x0 0x3 &ipic 20 0x8
>>                                  0xb800 0x0 0x0 0x4 &ipic 21 0x8
>>
>>                                 /* IDSEL 0x18 */
>>                                  0xc000 0x0 0x0 0x1 &ipic 21 0x8
>>                                  0xc000 0x0 0x0 0x2 &ipic 22 0x8
>>                                  0xc000 0x0 0x0 0x3 &ipic 23 0x8
>>                                  0xc000 0x0 0x0 0x4 &ipic 20 0x8>;
>>                 interrupt-parent = <&ipic>;
>>                 interrupts = <66 0x8>;
>>                 bus-range = <0 0>;
>>                 ranges = <0x02000000 0x0 0x90000000 0x90000000 0x0 0x10000000
>>                           0x42000000 0x0 0x80000000 0x80000000 0x0 0x10000000
>>                           0x01000000 0x0 0x00000000 0xe2000000 0x0 0x00100000>;
>>                 clock-frequency = <66666666>;
>>                 #interrupt-cells = <1>;
>>                 #size-cells = <2>;
>>                 #address-cells = <3>;
>>                 reg = <0xe0008500 0x100>;
>>                 compatible = "fsl,mpc8349-pci";
>>                 device_type = "pci";
>>         };
>>
>>         pci1: pci@e0008600 {
>>                 cell-index = <2>;
>>                 interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
>>                 interrupt-map = <
>>
>>                                 /* IDSEL 0x11 */
>>                                  0x8800 0x0 0x0 0x1 &ipic 20 0x8
>>                                  0x8800 0x0 0x0 0x2 &ipic 21 0x8
>>                                  0x8800 0x0 0x0 0x3 &ipic 22 0x8
>>                                  0x8800 0x0 0x0 0x4 &ipic 23 0x8
>>
>>                                 /* IDSEL 0x12 */
>>                                  0x9000 0x0 0x0 0x1 &ipic 22 0x8
>>                                  0x9000 0x0 0x0 0x2 &ipic 23 0x8
>>                                  0x9000 0x0 0x0 0x3 &ipic 20 0x8
>>                                  0x9000 0x0 0x0 0x4 &ipic 21 0x8
>>
>>                                 /* IDSEL 0x13 */
>>                                  0x9800 0x0 0x0 0x1 &ipic 23 0x8
>>                                  0x9800 0x0 0x0 0x2 &ipic 20 0x8
>>                                  0x9800 0x0 0x0 0x3 &ipic 21 0x8
>>                                  0x9800 0x0 0x0 0x4 &ipic 22 0x8
>>
>>                                 /* IDSEL 0x15 */
>>                                  0xa800 0x0 0x0 0x1 &ipic 20 0x8
>>                                  0xa800 0x0 0x0 0x2 &ipic 21 0x8
>>                                  0xa800 0x0 0x0 0x3 &ipic 22 0x8
>>                                  0xa800 0x0 0x0 0x4 &ipic 23 0x8
>>
>>                                 /* IDSEL 0x16 */
>>                                  0xb000 0x0 0x0 0x1 &ipic 23 0x8
>>                                  0xb000 0x0 0x0 0x2 &ipic 20 0x8
>>                                  0xb000 0x0 0x0 0x3 &ipic 21 0x8
>>                                  0xb000 0x0 0x0 0x4 &ipic 22 0x8
>>
>>                                 /* IDSEL 0x17 */
>>                                  0xb800 0x0 0x0 0x1 &ipic 22 0x8
>>                                  0xb800 0x0 0x0 0x2 &ipic 23 0x8
>>                                  0xb800 0x0 0x0 0x3 &ipic 20 0x8
>>                                  0xb800 0x0 0x0 0x4 &ipic 21 0x8
>>
>>                                 /* IDSEL 0x18 */
>>                                  0xc000 0x0 0x0 0x1 &ipic 21 0x8
>>                                  0xc000 0x0 0x0 0x2 &ipic 22 0x8
>>                                  0xc000 0x0 0x0 0x3 &ipic 23 0x8
>>                                  0xc000 0x0 0x0 0x4 &ipic 20 0x8>;
>>                 interrupt-parent = <&ipic>;
>>                 interrupts = <67 0x8>;
>>                 bus-range = <0 0>;
>>                 ranges = <0x02000000 0x0 0xb0000000 0xb0000000 0x0 0x10000000
>>                           0x42000000 0x0 0xa0000000 0xa0000000 0x0 0x10000000
>>                           0x01000000 0x0 0x00000000 0xe2100000 0x0 0x00100000>;
>>                 clock-frequency = <66666666>;
>>                 #interrupt-cells = <1>;
>>                 #size-cells = <2>;
>>                 #address-cells = <3>;
>>                 reg = <0xe0008600 0x100>;
>>                 compatible = "fsl,mpc8349-pci";
>>                 device_type = "pci";
>>         };
>>
>>         chosen {
>>                 linux,stdout-path = &serial0;
>>         };
>> };
>>
>>
>>      
>>
>>
>> ------------------------------------------------------------------------
>>
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>     
>
>
>   
> ------------------------------------------------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

-- 
Marco Stornelli
Embedded Software Engineer
CoRiTeL - Consorzio di Ricerca sulle Telecomunicazioni
http://www.coritel.it

marco.stornelli@coritel.it
+39 06 72582838
