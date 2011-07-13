Return-Path: <alexander.lyasin@gmail.com>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BCF57B6F54
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Jul 2011 07:02:44 +1000 (EST)
Received: by iwg8 with SMTP id 8so6340086iwg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Jul 2011 14:02:40 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 14 Jul 2011 03:02:40 +0600
Message-ID: <CA+tvTZsMwAYswu=1+0FHLxMAF2354mFnvbxmRVjw3Z=Mp+gFYw@mail.gmail.com>
Subject: Can't request irq
From: =?KOI8-R?B?4czFy9PBzsTSIOzR08nO?= <alexander.lyasin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all!
I have a problem with getting interrupt on the MPC8308erdb processor
in Linux 2.6.29 from Freescale edition. I work in LTIB toolchain.
I have a SoC board with the MPC8308 processor. There are a few SPI devices on
the SPI Bus. The devices are the conclusions to the interrupts IPIC.
The dts (device tree source) file below:


/*
 * MPC8308-bc150 Device Tree Source
 *
 * Copyright 2009 Freescale Semiconductor Inc.
 *
 * This program is free software; you can redistribute  it and/or modify it
 * under  the terms of  the GNU General  Public License as published by the
 * Free Software Foundation;  either version 2 of the  License, or (at your
 * option) any later version.
 */


/dts-v1/;


/ {
       compatible = "fsl,mpc8308erdb";
       #address-cells = <1>;
       #size-cells = <1>;


       aliases {
               serial0 = &serial0;
               /* pcie0 = &pcie0;*/
       };


       cpus {
               #address-cells = <1>;
               #size-cells = <0>;

               PowerPC,8308@0 {
                       device_type = "cpu";
                       reg = <0x0>;
                       d-cache-line-size = <32>;
                       i-cache-line-size = <32>;
                       d-cache-size = <16384>;
                       i-cache-size = <16384>;
                       timebase-frequency = <0>;       // from
bootloader
                       bus-frequency = <0>;            // from
bootloader
                       clock-frequency = <0>;          // from
bootloader
               };
       };

       memory {
               device_type = "memory";
               reg = <0x00000000 0x04000000>;  // 64MB at 0
       };


       localbus@e0005000 {
               #address-cells = <2>;
               #size-cells = <1>;
               compatible = "fsl,mpc8315-elbc", "fsl,elbc", "simple-bus";
               reg = <0xe0005000 0x1000>;
               interrupts = <77 0x8>;
               interrupt-parent = <&ipic>;


               // CS0 and CS1 are swapped when
               // booting from nand, but the
               // addresses are the same.
               ranges = <0x0 0x0 0xfe000000 0x00800000
                         0x1 0x0 0xe0600000 0x00002000
                         0x2 0x0 0xf0000000 0x00020000
                         0x3 0x0 0xfa000000 0x00008000>;


               nand@1,0 {
                       #address-cells = <1>;
                       #size-cells = <1>;
                       compatible = "fsl,mpc8315-fcm-nand",
                                    "fsl,elbc-fcm-nand";
                       reg = <0x1 0x0 0x2000>;


                       u-boot@0 {
                               reg = <0x0 0x100000>;
                               read-only;
                               label = "U-Boot-NAND";
                       };
                       jffs2@100000 {
                               reg = <0x100000 0x800000>;
                               label = "JFFS2-NAND";
                       };
                       ramdisk@900000 {
                               reg = <0x900000 0x400000>;
                               label = "Ramdisk-NAND";
                       };
                       reserved@d00000 {
                               reg = <0xd00000 0x1000000>;
                               label = "Reserved-NAND";
                       };
                       kernel@1d00000 {
                               reg = <0x1d00000 0x200000>;
                               read-only;
                               label = "Kernel-NAND";
                       };
                       dtb@1f00000 {
                               reg = <0x1f00000 0x100000>;
                               read-only;
                               label = "DTB-NAND";
                       };
               };
       };


       immr@e0000000 {
               #address-cells = <1>;
               #size-cells = <1>;
               device_type = "soc";
               compatible = "fsl,mpc8308-immr", "simple-bus";
               ranges = <0 0xe0000000 0x00100000>;
               reg = <0xe0000000 0x00000200>;
               bus-frequency = <0>;


               wdt@200 {
                       device_type = "watchdog";
                       compatible = "mpc83xx_wdt";
                       reg = <0x200 0x100>;
               };


               i2c@3000 {
                       #address-cells = <1>;
                       #size-cells = <0>;
                       cell-index = <0>;
                       compatible = "fsl-i2c";
                       reg = <0x3000 0x100>;
                       interrupts = <14 0x8>;
                       interrupt-parent = <&ipic>;
                       dfsrr;
                       rtc@68 {
                               compatible = "dallas,ds1339";
                               reg = <0x68>;
                       };


                       mcu_pio: mcu@a {
                               #gpio-cells = <2>;
                               compatible = "fsl,mc9s08qg8-mpc8315erdb",
                                            "fsl,mcu-mpc8349emitx";
                               reg = <0x0a>;
                               gpio-controller;
                       };
               };


               dma@82a8 {
                       #address-cells = <1>;
                       #size-cells = <1>;
                       compatible = "fsl,mpc8315-dma", "fsl,elo-dma";
                       reg = <0x82a8 4>;
                       ranges = <0 0x8100 0x1a8>;
                       interrupt-parent = <&ipic>;
                       interrupts = <71 8>;
                       cell-index = <0>;
                       dma-channel@0 {
                               compatible =
"fsl,mpc8315-dma-channel", "fsl,elo-dma-channel";
                               reg = <0 0x80>;
                               cell-index = <0>;
                               interrupt-parent = <&ipic>;
                               interrupts = <71 8>;
                       };
                       dma-channel@80 {
                               compatible =
"fsl,mpc8315-dma-channel", "fsl,elo-dma-channel";
                               reg = <0x80 0x80>;
                               cell-index = <1>;
                               interrupt-parent = <&ipic>;
                               interrupts = <71 8>;
                       };
                       dma-channel@100 {
                               compatible =
"fsl,mpc8315-dma-channel", "fsl,elo-dma-channel";
                               reg = <0x100 0x80>;
                               cell-index = <2>;
                               interrupt-parent = <&ipic>;
                               interrupts = <71 8>;
                       };
                       dma-channel@180 {
                               compatible =
"fsl,mpc8315-dma-channel", "fsl,elo-dma-channel";
                               reg = <0x180 0x28>;
                               cell-index = <3>;
                               interrupt-parent = <&ipic>;
                               interrupts = <71 8>;
                       };
               };


               ptp_timer: ptimer@24e00 {
                       compatible = "fsl,gianfar-ptp-timer";
                       reg = <0x24e00 0xb0>;
               };


               serial0: serial@4500 {
                       cell-index = <0>;
                       device_type = "serial";
                       compatible = "ns16550";
                       reg = <0x4500 0x100>;
                       clock-frequency = <133333333>;
                       interrupts = <9 0x8>;
                       interrupt-parent = <&ipic>;
               };


               gpio@c00 {
                       device_type = "gpio";
                       compatible = "fsl,mpc8315-gpio";
                       reg = <0xc00 0x18>;
                       interrupt-parent = < &ipic >;
               };


               /* IPIC
                * interrupts cell = <intr #, sense>
                * sense values match linux IORESOURCE_IRQ_* defines:
                * sense == 8: Level, low assertion
                * sense == 2: Edge, high-to-low change
                */
               ipic: interrupt-controller@700 {
                       compatible = "fsl,ipic";
                       interrupt-controller;
                       #address-cells = <0>;
                       #interrupt-cells = <2>;
                       reg = <0x700 0x100>;
                       device_type = "ipic";
               };


               ipic-msi@7c0 {
                       compatible = "fsl,ipic-msi";
                       reg = <0x7c0 0x40>;
                       msi-available-ranges = <0x0 0x100>;
                       interrupts = < 0x43 0x8
                                       0x4  0x8
                                       0x51 0x8
                                       0x52 0x8
                                       0x56 0x8
                                       0x57 0x8
                                       0x58 0x8
                                       0x59 0x8 >;
                       interrupt-parent = < &ipic >;
               };


/*              pmc: power@b00 {
                       compatible = "fsl,mpc8313-pmc", "fsl,mpc8349-pmc";
                       reg = <0xb00 0x100 0xa00 0x100>;
                       interrupts = <80 8>;
                       interrupt-parent = <&ipic>;
                       fsl,mpc8313-wakeup-timer = <&gtm1>;
               };
*/
/*              gtm1: timer@500 {
                       compatible = "fsl,mpc8313-gtm", "fsl,gtm";
                       reg = <0x500 0x100>;
                       clock-frequency = <133000000>;
                       interrupts = <90 8 78 8 84 8 72 8>;
                       interrupt-parent = <&ipic>;
               };
*/
   spi@7000 {
                       cell-index = <0>;
                       compatible = "fsl,spi";
                       reg = <0x7000 0x1000>;
                       interrupts = <16 0x8>;
                       interrupt-parent = <&ipic>;
                       mode = "cpu";


                       falc@0 {
                               compatible = "falc";
                               spi-max-frequency = <5000000>;
                               reg = <0>;
                               interrupts = <48 0x8>;
                               interrupt-parent = <&ipic>;
                       };


                       pld@0 {
                               compatible = "pld";
                               spi-max-frequency = <5000000>;
                               reg = <1>;
                               interrupts = <18 0x8>;
                               interrupt-parent = <&ipic>;
                       };


               };


       };


};


As can be seen from the file are 2 devices ("falc" and "pld") on the
SPI bus. The part of the setup file present below (mpc8308_erdb.c):


static struct spi_board_info mpc830x_spi_boardinfo[2] = {
   {
       .bus_num = 0x7000,
       .chip_select = 0,
       .max_speed_hz = 5000000,
       .modalias = "falc",
   },
   {
       .bus_num = 0x7000,
       .chip_select = 1,
       .max_speed_hz = 5000000,
       .modalias = "spidev",
   },
};


I'm writing module for "falc" device.
During loading of the module the probe function is called.
But request_irq(48, falc_irq_handler, IRQF_DISABLED, "falc",
falc_staff) function return -38. I see, interrupt 48 (irq_chip) absent
in system.
-ENOSYS returned from __setup_irq function from manage.c:


if (desc->chip == &no_irq_chip)
       return -ENOSYS;


Help me please, how can I to create it in system?




Best regards.


Alexander V. Lyasin <alexander.lyasin@gmail.com>
Linux system developer
TAKT Inc
