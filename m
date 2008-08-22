Return-Path: <glikely@secretlab.ca>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by ozlabs.org (Postfix) with ESMTP id 8FEB6DF6B0
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Aug 2008 06:04:40 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so402185pyi.27
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Aug 2008 13:04:39 -0700 (PDT)
Message-ID: <fa686aa40808221304j12c8bf47t17522a8251ef64b5@mail.gmail.com>
Date: Fri, 22 Aug 2008 14:04:38 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Laxmikant Rashinkar" <lk.atwork@yahoo.com>
Subject: Re: porting linux 2.6.27 to embedded powerpc board
In-Reply-To: <922373.86130.qm@web46308.mail.sp1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <922373.86130.qm@web46308.mail.sp1.yahoo.com>
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

Add the following to the end of your dts file and see what happens:

chosen {
        linux,stdout-path = &serial0;
};

On Fri, Aug 22, 2008 at 1:57 PM, Laxmikant Rashinkar
<lk.atwork@yahoo.com> wrote:
> Hi,
>
> my .dts file is called mpc834x_mds.dts. (My processor is MPC8347)
> Here are its contents.
>
> /*
>  * MPC8349E MDS Device Tree Source
>  *
>  * Copyright 2005, 2006 Freescale Semiconductor Inc.
>  *
>  * This program is free software; you can redistribute  it and/or modify it
>  * under  the terms of  the GNU General  Public License as published by the
>  * Free Software Foundation;  either version 2 of the  License, or (at your
>  * option) any later version.
>  */
>
> /dts-v1/;
>
> / {
>         model = "MPC8349EMDS";
>         compatible = "MPC8349EMDS", "MPC834xMDS", "MPC83xxMDS";
>         #address-cells = <1>;
>         #size-cells = <1>;
>
>         aliases {
>                 ethernet0 = &enet0;
>                 ethernet1 = &enet1;
>                 serial0 = &serial0;
>                 serial1 = &serial1;
>                 pci0 = &pci0;
>                 pci1 = &pci1;
>         };
>
>         cpus {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
>                 PowerPC,8349@0 {
>                         device_type = "cpu";
>                         reg = <0x0>;
>                         d-cache-line-size = <32>;
>                         i-cache-line-size = <32>;
>                         d-cache-size = <32768>;
>                         i-cache-size = <32768>;
>                         timebase-frequency = <0>;       // from bootloader
>                         bus-frequency = <0>;            // from bootloader
>                         clock-frequency = <0>;          // from bootloader
>                 };
>         };
>
>         memory {
>                 device_type = "memory";
>                 reg = <0x00000000 0x10000000>;  // 256MB at 0
>         };
>
>         bcsr@e2400000 {
>                 device_type = "board-control";
>                 reg = <0xe2400000 0x8000>;
>         };
>
>         soc8349@e0000000 {
>                 #address-cells = <1>;
>                 #size-cells = <1>;
>                 device_type = "soc";
>                 compatible = "simple-bus";
>                 ranges = <0x0 0xe0000000 0x00100000>;
>                 reg = <0xe0000000 0x00000200>;
>                 bus-frequency = <0>;
>
>                 wdt@200 {
>                         device_type = "watchdog";
>                         compatible = "mpc83xx_wdt";
>                         reg = <0x200 0x100>;
>                 };
>
>                 i2c@3000 {
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>                         cell-index = <0>;
>                         compatible = "fsl-i2c";
>                         reg = <0x3000 0x100>;
>                         interrupts = <14 0x8>;
>                         interrupt-parent = <&ipic>;
>                         dfsrr;
>
>                         rtc@68 {
>                                 compatible = "dallas,ds1374";
>                                 reg = <0x68>;
>                         };
>                 };
>
>                 i2c@3100 {
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>                         cell-index = <1>;
>                         compatible = "fsl-i2c";
>                         reg = <0x3100 0x100>;
>                         interrupts = <15 0x8>;
>                         interrupt-parent = <&ipic>;
>                         dfsrr;
>                 };
>
>                 spi@7000 {
>                         cell-index = <0>;
>                         compatible = "fsl,spi";
>                         reg = <0x7000 0x1000>;
>                         interrupts = <16 0x8>;
>                         interrupt-parent = <&ipic>;
>                         mode = "cpu";
>                 };
>
>                 dma@82a8 {
>                         #address-cells = <1>;
>                         #size-cells = <1>;
>                         compatible = "fsl,mpc8349-dma", "fsl,elo-dma";
>                         reg = <0x82a8 4>;
>                         ranges = <0 0x8100 0x1a8>;
>                         interrupt-parent = <&ipic>;
>                         interrupts = <71 8>;
>                         cell-index = <0>;
>                         dma-channel@0 {
>                                 compatible = "fsl,mpc8349-dma-channel",
> "fsl,elo-dma-channel";
>                                 reg = <0 0x80>;
>                                 interrupt-parent = <&ipic>;
>                                 interrupts = <71 8>;
>                         };
>                         dma-channel@80 {
>                                 compatible = "fsl,mpc8349-dma-channel",
> "fsl,elo-dma-channel";
>                                 reg = <0x80 0x80>;
>                                 interrupt-parent = <&ipic>;
>                                 interrupts = <71 8>;
>                         };
>                         dma-channel@100 {
>                                 compatible = "fsl,mpc8349-dma-channel",
> "fsl,elo-dma-channel";
>                                 reg = <0x100 0x80>;
>                                 interrupt-parent = <&ipic>;
>                                 interrupts = <71 8>;
>                         };
>                         dma-channel@180 {
>                                 compatible = "fsl,mpc8349-dma-channel",
> "fsl,elo-dma-channel";
>                                 reg = <0x180 0x28>;
>                                 interrupt-parent = <&ipic>;
>                                 interrupts = <71 8>;
>                         };
>                 };
>
>                 /* phy type (ULPI or SERIAL) are only types supported for
> MPH */
>                 /* port = 0 or 1 */
>                 usb@22000 {
>                         compatible = "fsl-usb2-mph";
>                         reg = <0x22000 0x1000>;
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>                         interrupt-parent = <&ipic>;
>                         interrupts = <39 0x8>;
>                         phy_type = "ulpi";
>                         port1;
>                 };
>                 /* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
>                 usb@23000 {
>                         compatible = "fsl-usb2-dr";
>                         reg = <0x23000 0x1000>;
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>                         interrupt-parent = <&ipic>;
>                         interrupts = <38 0x8>;
>                         dr_mode = "otg";
>                         phy_type = "ulpi";
>                 };
>
>                 mdio@24520 {
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>                         compatible = "fsl,gianfar-mdio";
>                         reg = <0x24520 0x20>;
>
>                         phy0: ethernet-phy@0 {
>                                 interrupt-parent = <&ipic>;
>                                 interrupts = <17 0x8>;
>                                 reg = <0x0>;
>                                 device_type = "ethernet-phy";
>                         };
>                         phy1: ethernet-phy@1 {
>                                 interrupt-parent = <&ipic>;
>                                 interrupts = <18 0x8>;
>                                 reg = <0x1>;
>                                 device_type = "ethernet-phy";
>                         };
>                 };
>
>                 enet0: ethernet@24000 {
>                         cell-index = <0>;
>                         device_type = "network";
>                         model = "TSEC";
>                         compatible = "gianfar";
>                         reg = <0x24000 0x1000>;
>                         local-mac-address = [ 00 00 00 00 00 00 ];
>                         interrupts = <32 0x8 33 0x8 34 0x8>;
>                         interrupt-parent = <&ipic>;
>                         phy-handle = <&phy0>;
>                         linux,network-index = <0>;
>                 };
>
>                 enet1: ethernet@25000 {
>                         cell-index = <1>;
>                         device_type = "network";
>                         model = "TSEC";
>                         compatible = "gianfar";
>                         reg = <0x25000 0x1000>;
>                         local-mac-address = [ 00 00 00 00 00 00 ];
>                         interrupts = <35 0x8 36 0x8 37 0x8>;
>                         interrupt-parent = <&ipic>;
>                         phy-handle = <&phy1>;
>                         linux,network-index = <1>;
>                 };
>
>                 serial0: serial@4500 {
>                         cell-index = <0>;
>                         device_type = "serial";
>                         compatible = "ns16550";
>                         reg = <0x4500 0x100>;
>                         clock-frequency = <0>;
>                         interrupts = <9 0x8>;
>                         interrupt-parent = <&ipic>;
>                 };
>
>                 serial1: serial@4600 {
>                         cell-index = <1>;
>                         device_type = "serial";
>                         compatible = "ns16550";
>                         reg = <0x4600 0x100>;
>                         clock-frequency = <0>;
>                         interrupts = <10 0x8>;
>                         interrupt-parent = <&ipic>;
>                 };
>
>                 crypto@30000 {
>                         compatible = "fsl,sec2.0";
>                         reg = <0x30000 0x10000>;
>                         interrupts = <11 0x8>;
>                         interrupt-parent = <&ipic>;
>                         fsl,num-channels = <4>;
>                         fsl,channel-fifo-len = <24>;
>                         fsl,exec-units-mask = <0x7e>;
>                         fsl,descriptor-types-mask = <0x01010ebf>;
>                 };
>
>                 /* IPIC
>                  * interrupts cell = <intr #, sense>
>                  * sense values match linux IORESOURCE_IRQ_* defines:
>                  * sense == 8: Level, low assertion
>                  * sense == 2: Edge, high-to-low change
>                  */
>                 ipic: pic@700 {
>                         interrupt-controller;
>                         #address-cells = <0>;
>                         #interrupt-cells = <2>;
>                         reg = <0x700 0x100>;
>                         device_type = "ipic";
>                 };
>         };
>
>         pci0: pci@e0008500 {
>                 cell-index = <1>;
>                 interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
>                 interrupt-map = <
>
>                                 /* IDSEL 0x11 */
>                                  0x8800 0x0 0x0 0x1 &ipic 20 0x8
>                                  0x8800 0x0 0x0 0x2 &ipic 21 0x8
>                                  0x8800 0x0 0x0 0x3 &ipic 22 0x8
>                                  0x8800 0x0 0x0 0x4 &ipic 23 0x8
>
>                                 /* IDSEL 0x12 */
>                                  0x9000 0x0 0x0 0x1 &ipic 22 0x8
>                                  0x9000 0x0 0x0 0x2 &ipic 23 0x8
>                                  0x9000 0x0 0x0 0x3 &ipic 20 0x8
>                                  0x9000 0x0 0x0 0x4 &ipic 21 0x8
>
>                                 /* IDSEL 0x13 */
>                                  0x9800 0x0 0x0 0x1 &ipic 23 0x8
>                                  0x9800 0x0 0x0 0x2 &ipic 20 0x8
>                                  0x9800 0x0 0x0 0x3 &ipic 21 0x8
>                                  0x9800 0x0 0x0 0x4 &ipic 22 0x8
>
>                                 /* IDSEL 0x15 */
>                                  0xa800 0x0 0x0 0x1 &ipic 20 0x8
>                                  0xa800 0x0 0x0 0x2 &ipic 21 0x8
>                                  0xa800 0x0 0x0 0x3 &ipic 22 0x8
>                                  0xa800 0x0 0x0 0x4 &ipic 23 0x8
>
>                                 /* IDSEL 0x16 */
>                                  0xb000 0x0 0x0 0x1 &ipic 23 0x8
>                                  0xb000 0x0 0x0 0x2 &ipic 20 0x8
>                                  0xb000 0x0 0x0 0x3 &ipic 21 0x8
>                                  0xb000 0x0 0x0 0x4 &ipic 22 0x8
>
>                                 /* IDSEL 0x17 */
>                                  0xb800 0x0 0x0 0x1 &ipic 22 0x8
>                                  0xb800 0x0 0x0 0x2 &ipic 23 0x8
>                                  0xb800 0x0 0x0 0x3 &ipic 20 0x8
>                                  0xb800 0x0 0x0 0x4 &ipic 21 0x8
>
>                                 /* IDSEL 0x18 */
>                                  0xc000 0x0 0x0 0x1 &ipic 21 0x8
>                                  0xc000 0x0 0x0 0x2 &ipic 22 0x8
>                                  0xc000 0x0 0x0 0x3 &ipic 23 0x8
>                                  0xc000 0x0 0x0 0x4 &ipic 20 0x8>;
>                 interrupt-parent = <&ipic>;
>                 interrupts = <66 0x8>;
>                 bus-range = <0 0>;
>                 ranges = <0x02000000 0x0 0x90000000 0x90000000 0x0
> 0x10000000
>                           0x42000000 0x0 0x80000000 0x80000000 0x0
> 0x10000000
>                           0x01000000 0x0 0x00000000 0xe2000000 0x0
> 0x00100000>;
>                 clock-frequency = <66666666>;
>                 #interrupt-cells = <1>;
>                 #size-cells = <2>;
>                 #address-cells = <3>;
>                 reg = <0xe0008500 0x100>;
>                 compatible = "fsl,mpc8349-pci";
>                 device_type = "pci";
>         };
>
>         pci1: pci@e0008600 {
>                 cell-index = <2>;
>                 interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
>                 interrupt-map = <
>
>                                 /* IDSEL 0x11 */
>                                  0x8800 0x0 0x0 0x1 &ipic 20 0x8
>                                  0x8800 0x0 0x0 0x2 &ipic 21 0x8
>                                  0x8800 0x0 0x0 0x3 &ipic 22 0x8
>                                  0x8800 0x0 0x0 0x4 &ipic 23 0x8
>
>                                 /* IDSEL 0x12 */
>                                  0x9000 0x0 0x0 0x1 &ipic 22 0x8
>                                  0x9000 0x0 0x0 0x2 &ipic 23 0x8
>                                  0x9000 0x0 0x0 0x3 &ipic 20 0x8
>                                  0x9000 0x0 0x0 0x4 &ipic 21 0x8
>
>                                 /* IDSEL 0x13 */
>                                  0x9800 0x0 0x0 0x1 &ipic 23 0x8
>                                  0x9800 0x0 0x0 0x2 &ipic 20 0x8
>                                  0x9800 0x0 0x0 0x3 &ipic 21 0x8
>                                  0x9800 0x0 0x0 0x4 &ipic 22 0x8
>
>                                 /* IDSEL 0x15 */
>                                  0xa800 0x0 0x0 0x1 &ipic 20 0x8
>                                  0xa800 0x0 0x0 0x2 &ipic 21 0x8
>                                  0xa800 0x0 0x0 0x3 &ipic 22 0x8
>                                  0xa800 0x0 0x0 0x4 &ipic 23 0x8
>
>                                 /* IDSEL 0x16 */
>                                  0xb000 0x0 0x0 0x1 &ipic 23 0x8
>                                  0xb000 0x0 0x0 0x2 &ipic 20 0x8
>                                  0xb000 0x0 0x0 0x3 &ipic 21 0x8
>                                  0xb000 0x0 0x0 0x4 &ipic 22 0x8
>
>                                 /* IDSEL 0x17 */
>                                  0xb800 0x0 0x0 0x1 &ipic 22 0x8
>                                  0xb800 0x0 0x0 0x2 &ipic 23 0x8
>                                  0xb800 0x0 0x0 0x3 &ipic 20 0x8
>                                  0xb800 0x0 0x0 0x4 &ipic 21 0x8
>
>                                 /* IDSEL 0x18 */
>                                  0xc000 0x0 0x0 0x1 &ipic 21 0x8
>                                  0xc000 0x0 0x0 0x2 &ipic 22 0x8
>                                  0xc000 0x0 0x0 0x3 &ipic 23 0x8
>                                  0xc000 0x0 0x0 0x4 &ipic 20 0x8>;
>                 interrupt-parent = <&ipic>;
>                 interrupts = <67 0x8>;
>                 bus-range = <0 0>;
>                 ranges = <0x02000000 0x0 0xb0000000 0xb0000000 0x0
> 0x10000000
>                           0x42000000 0x0 0xa0000000 0xa0000000 0x0
> 0x10000000
>                           0x01000000 0x0 0x00000000 0xe2100000 0x0
> 0x00100000>;
>                 clock-frequency = <66666666>;
>                 #interrupt-cells = <1>;
>                 #size-cells = <2>;
>                 #address-cells = <3>;
>                 reg = <0xe0008600 0x100>;
>                 compatible = "fsl,mpc8349-pci";
>                 device_type = "pci";
>         };
> };
>
>
> thanks
> LK
>
>
> ----- Original Message ----
> From: Grant Likely <grant.likely@secretlab.ca>
> To: Laxmikant Rashinkar <lk.atwork@yahoo.com>
> Cc: linuxppc-embedded@ozlabs.org
> Sent: Friday, August 22, 2008 12:45:54 PM
> Subject: Re: porting linux 2.6.27 to embedded powerpc board
>
> On Fri, Aug 22, 2008 at 12:26 PM, Laxmikant Rashinkar
> <lk.atwork@yahoo.com> wrote:
>> Hi,
>>
>> I still haven't gotten anything to work :-(
>>
>> I'm using Uboot 1.1.4 and Linux 2.6.27 but instead of using uImage, I'm
>> using cuImage.<myboard>
>> The args to dtc are as listed by David Jander
>
> Please post you .dts file and the filename you are using for it.
>
> g.
>
>>
>> My cmd line args are:
>> setenv bootargs root=/dev/ram0 init=/rescue rw console=ttyS0,9600
>> ramdisk_size=65536
>>
>> When I attempt to boot my image it just hangs w/o any output. I dearly
>> wish
>> I could get some console output.
>> Here is the actual display from uboot:
>>
>> ## Booting image at 00800000 ...
>>    Image Name:  Linux-2.6.27-rc2
>>    Image Type:  PowerPC Linux Kernel Image (gzip compressed)
>>    Data Size:    1640425 Bytes =  1.6 MB
>>    Load Address: 00400000
>>    Entry Point:  0040055c
>>    Verifying Checksum ... OK
>>    Uncompressing Kernel Image ... OK
>> ## Loading RAMDisk Image at 01000000 ...
>>    Image Name:  flash_root.ext3.gz
>>    Image Type:  PowerPC Linux RAMDisk Image (gzip compressed)
>>    Data Size:    13450106 Bytes = 12.8 MB
>>    Load Address: 00000000
>>    Entry Point:  00000000
>>    Verifying Checksum ... OK
>>    Loading Ramdisk to 0f29d000, end 0ff70b7a ... OK
>>
>> Two questions:
>>
>> 1) the load address and entry point for the kernel (see above) are
>> non-zero.
>> When we load via uImage, they are always zero. Is this normal? dtc has not
>> options to set the load address and entry point.
>>
>> 2) When I build my kernel, I get two warnings. Could these be causing a
>> problem?
>>
>> WARNING: mm/built-in.o(.data+0x8ec): Section mismatch in reference from
>> the
>> variable contig_page_data to the variable .init.data:bootmem_node_data
>> The variable contig_page_data references
>> the variable __initdata bootmem_node_data
>> If the reference is valid then annotate the
>> variable with __init* (see linux/init.h) or name the variable:
>> *driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one,
>> *_console,
>>
>>
>>  MODPOST vmlinux.o
>> WARNING: vmlinux.o(.data+0xfe74): Section mismatch in reference from the
>> variable contig_page_data to the variable .init.data:bootmem_node_data
>> The variable contig_page_data references
>> the variable __initdata bootmem_node_data
>> If the reference is valid then annotate the
>> variable with __init* (see linux/init.h) or name the variable:
>> *driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one,
>> *_console,
>>
>> thanks so much for your help.
>>
>> LK
>>
>> ----- Original Message ----
>> From: David Jander <david.jander@protonic.nl>
>> To: linuxppc-embedded@ozlabs.org
>> Cc: Laxmikant Rashinkar <lk.atwork@yahoo.com>
>> Sent: Thursday, August 21, 2008 2:43:45 AM
>> Subject: Re: porting linux 2.6.27 to embedded powerpc board
>>
>> On Thursday 21 August 2008 01:24:46 Laxmikant Rashinkar wrote:
>>> Hi,
>>>
>>> I have an embedded PowerPC (MPC8347) board that works fine with uboot and
>>> Linux 2.6.15.
>>>
>>> I am trying to upgrade the kernel so that it runs on the latest release -
>>> Linux 2.6.27. So far, I have gotten the kernel to compile on my platform,
>>> but of course it does not boot.
>>
>> Well, honestly I don't know where to look for information either (other
>> than
>> the source-code and examples from others), but here is a list with points
>> to
>> look out for (I have just done the same thing as you for a MPC5200B-based
>> board):
>>
>> 1. Upgrade to latest u-boot first (recent git seems to be fine). There
>> have
>> been a lot of changes in u-boot lately about OF and device-tree related
>> things. I suspect you need a fairly recent version of u-boot to go well
>> with
>> the latest kernel. It's also generally a good idea IMHO.
>>
>> 2. I assume you are porting to arch/powerpc (the old arch/ppc you used
>> back
>> in
>> 2.6.15 is obsolete and broken now).
>>
>> 3. Look at other platforms that use the same processor, and pick a simple
>> one
>> as starting point. Look out for the dts (device-tree-source file in
>> arch/powerpc/boot/dts), copy and modify one to reflect your hardware.
>> Recently a lot of changes happend in the kernel, changing device names,
>> obsoleting "device-type" tags, etc..., so some of the current DTS sources
>> included in the kernel might not even work (wrong device name, missing
>> information, wrong use of "device-type", etc...), so watch out for these
>> kind
>> of issues too.
>>
>> 4. Be sure that the device(s) necessary to produce output on your console
>> are
>> correctly placed in the DT. Also make sure that u-boot knows about it
>> (#define OF_STDOUT_PATH... in your u-boot board config file)
>>
>> 5. When compiling the device tree, it may be necessary to add some extra
>> reserved entries to the compiled tree (I am using dtc -p 10240 -R 20,
>> which
>> might be slightly exaggerated), because u-boot may add something to it,
>> and
>> if it can't, linux won't boot.
>>
>> 6. Remember to always specify the "rootfstype=" option on the commandline
>> if
>> booting from anything other than NFS. This was not necessary back in the
>> 2.6.15-times AFAICR.
>>
>> 7. Boot with a device-tree (in u-boot: "bootm $addrofkernel - $addrofdtb",
>> don't forget the dash if you are not using an initrd). If you don't do
>> this,
>> u-boot can't fix your DT, and the kernel probably won't find it either.
>>
>> 8. Be sure to use the correct version of the DTC (DT compiler) for your
>> kernel
>> (the sources are included nowadays, somewhere in arch/powerpc/boot IIRC).
>> The
>> command used to compile, should probably be something like this:
>>
>> $ ./dtc -p 10240 -R 20 -I dts -o myplatform.dtb -O dtb -b 0
>> dts/myplatform.dts
>>
>> Load the resulting .dtb file directly with u-boot (don't make an u-image
>> out
>> of it).
>>
>> That's all I remember right now... hope it helps.
>>
>> Regards,
>>
>> --
>> David Jander
>>
>>
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>
>
>
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
