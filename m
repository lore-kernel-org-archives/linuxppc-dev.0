Return-Path: <alan@akb.net>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.231])
	by ozlabs.org (Postfix) with ESMTP id CD629DDF51
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 07:38:10 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 71so328826wri
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 14:38:09 -0700 (PDT)
Message-ID: <bfa0697f0709201438y7a74d1c8u85b9a2edfc825e32@mail.gmail.com>
Date: Thu, 20 Sep 2007 15:38:08 -0600
From: "Alan Bennett" <embedded@akb.net>
Sender: alan@akb.net
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: device tree question
In-Reply-To: <46F2BC7D.3070908@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <bfa0697f0709181343m1fc9f9b9u8acd429663d1adae@mail.gmail.com>
	<46F052EE.1040004@freescale.com>
	<bfa0697f0709181604i5758824foad67a86455f45d8e@mail.gmail.com>
	<46F05BF7.6020906@freescale.com>
	<bfa0697f0709190638r6894fab6gd31a5672a997e97@mail.gmail.com>
	<46F16BD4.2000207@freescale.com>
	<bfa0697f0709191420x5a6aed9dx499fe4a8cf6b1b2d@mail.gmail.com>
	<46F19326.7050507@freescale.com>
	<bfa0697f0709201053s3643523eid42ea60dae53af84@mail.gmail.com>
	<46F2BC7D.3070908@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Device Tree and BRG?
  The SMC1 uses BRG7 and the SCC1 uses BRG1, should we have both BRGs
configured in the .dts?  ( BRG1 is configured).

Device Tree and Chosen?
  Adding a chosen block and I end up off in the weeds.  removing the
chosen block and I die within cpm_uart_console_write
        chosen {
                linux,stdout-path = "/soc/cpm/serial@11a80";
        };
  In arch/boot/ep8248e, there is a call to:
planetcore_set_stdout_path(table) is this why there is no
chosen/stdout-path element in the device tree?

  Off to back out / replace the ep8248e + planetCore code to something
more u-boot friendly.

-Alan

__log_buf when hung with ~ cpm_uart_console_write

Using Embedded Planet EP8248E machine description.
Linux version 2.6.23-rc6-g943401ab-dirty (root@fremont)
   (gcc version 3.4.5) #8 Thu Sep 20 15:03:37 MDT 2007.
Entering add_active_range(0, 0, 32768) 0 entries of 256 used.
Top of RAM: 0x8000000, Total RAM: 0x8000000.
Memory hole size: 0MB.
Zone PFN ranges:.
  DMA             0 ->    32768.
  Normal      32768 ->    32768.
Movable zone start PFN for each node.
early_node_map[1] active PFN ranges.
    0:        0 ->    32768.
On node 0 totalpages: 32768.
  DMA zone: 256 pages used for memmap.
  DMA zone: 0 pages reserved.
  DMA zone: 32512 pages, LIFO batch:7.
  Normal zone: 0 pages used for memmap.
  Movable zone: 0 pages used for memmap.
Built 1 zonelists in Zone order.  Total pages: 32512.
Kernel command line: root=/dev/nfs ip=192.168.10.45:::255.255.255.0::
  eth1 nfsroot=192.168.10.5:/fh/rfs rw .
PID hash table entries: 512 (order: 9, 2048 bytes).
time_init: decrementer frequency = 16.500000 MHz.
time_init: processor frequency   = 231.000000 MHz.
console [ttyCPM0] enabled.....


====

/*
 * Device Tree for the Embedded Planet EP8248E board.
 *
 * Copyright 2007 Freescale Semiconductor Inc.
 *
 * This program is free software; you can redistribute  it and/or modify it
 * under  the terms of  the GNU General  Public License as published by the
 * Free Software Foundation;  either version 2 of the  License, or (at your
 * option) any later version.
 */

/ {
        model = "EP8248E";
        compatible = "fsl,ep8248e";
        #address-cells = <1>;
        #size-cells = <1>;

        cpus {
                #address-cells = <1>;
                #size-cells = <0>;

                PowerPC,8248@0 {
                        device_type = "cpu";
                        reg = <0>;
                        d-cache-line-size = <d#32>;
                        i-cache-line-size = <d#32>;
                        d-cache-size = <d#16384>;
                        i-cache-size = <d#16384>;
                        timebase-frequency = <0>;
                        clock-frequency = <0>;
                };
        };

        memory {
                device_type = "memory";
                reg = <0 0>;
        };

        localbus@f0010100 {
                compatible = "fsl,mpc8248-localbus",
                             "fsl,pq2-localbus";
                #address-cells = <2>;
                #size-cells = <1>;
                reg = <f0010100 40>;

                ranges = <0 0 f8000000 08000000
                          2 0 e4000000 00008000
                          4 0 d0000000 08000000>;

                /* CS0 F800_0000 -> FFFF_FFFF */
                flash@0,0 {  				
                        compatible = "cfi-flash";
                        reg = <0 0 08000000>;
                        bank-width = <4>;
                        device-width = <2>;
                };
                /* CS2 E400_0000 -> E400_8000 */
                board-control@2,0 {
                        compatible = "fsl,ep8248e-bcsr";
                        reg = <2 0 10>;
                        #address-cells = <2>;
                        #size-cells = <1>;
                        ranges;

                        mdio {
                                device_type = "mdio";
                                compatible = "fsl,ep8248e-mdio-bitbang";
                                #address-cells = <1>;
                                #size-cells = <0>;
                                reg = <2 8 1>;

                                PHY0: ethernet-phy@0 {
                                        interrupt-parent = <&PIC>;
                                        reg = <0>;
                                        device_type = "ethernet-phy";
                                };

                                PHY1: ethernet-phy@1 {
                                        interrupt-parent = <&PIC>;
                                        reg = <1>;
                                        device_type = "ethernet-phy";
                                };
                        };
                };
                /* CS4 D000_0000 -> D7FF_FFFF */
                flash@4,0 {
                        compatible = "cfi-flash";
                        reg = <4 0 08000000>;
                        bank-width = <4>;
                        device-width = <2>;
                };
        };

        soc@f0000000 {
                #address-cells = <1>;
                #size-cells = <1>;
                device_type = "soc";
                compatible = "fsl,mpc8248", "fsl,pq2-soc";
                ranges = <00000000 f0000000 00053000>;

                // Temporary -- will go away once kernel
                // uses ranges for get_immrbase().
                reg = <f0000000 00053000>;
                /*CPCR*/
                cpm@119c0 {
                        #address-cells = <1>;
                        #size-cells = <1>;
                        compatible = "fsl,mpc8248-cpm", "fsl,cpm2";
                        reg = <119c0 30 0 1100>;
                        ranges;

                        brg@119f0 {
                                compatible = "fsl,mpc8272-brg",
                                             "fsl,cpm2-brg",
                                             "fsl,cpm-brg";
                                reg = <119f0 10 115f0 10>;
                        };
                        /* Monitor port/SMC1 */
                        serial@11a80 {
                                device_type = "serial";
                                compatible = "fsl,mpc8248-smc-uart",
                                             "fsl,cpm2-smc-uart";
                                reg = <119c0 30 80 1f80>;      /*u-boot*/
                                interrupts = <4 8>;
                                interrupt-parent = <&PIC>;
                                fsl,cpm-brg = <7>;  /* 115F8  */
                                fsl,cpm-command = <1d000000>;
				linux,planetcore-label = "SMC1";
                        };
                        /* "Serial" port/SCC1 */
                        serial@11a00 {
                                device_type = "serial";
                                compatible = "fsl,mpc8248-scc-uart",
                                             "fsl,cpm2-scc-uart";
                                reg = <11a00 20 8000 100>;
                                interrupts = <28 8>;
                                interrupt-parent = <&PIC>;
                                fsl,cpm-brg = <1>;
                                fsl,cpm-command = <00800000>;
				linux,planetcore-label = "SCC1";
                        };

                        ethernet@11300 {
                                device_type = "network";
                                compatible = "fsl,mpc8248-fcc-enet",
                                             "fsl,cpm2-fcc-enet";
                                reg = <11300 20 8400 100 11390 1>;
                                local-mac-address = [ 00 00 00 00 00 00 ];
                                interrupts = <20 8>;
                                interrupt-parent = <&PIC>;
                                phy-handle = <&PHY0>;
                                linux,network-index = <0>;
                                fsl,cpm-command = <12000300>;
                        };

                        ethernet@11320 {
                                device_type = "network";
                                compatible = "fsl,mpc8248-fcc-enet",
                                             "fsl,cpm2-fcc-enet";
                                reg = <11320 20 8500 100 113b0 1>;
                                local-mac-address = [ 00 00 00 00 00 00 ];
                                interrupts = <21 8>;
                                interrupt-parent = <&PIC>;
                                phy-handle = <&PHY1>;
                                linux,network-index = <1>;
                                fsl,cpm-command = <16200300>;
                        };

                        usb@11b60 {
                                #address-cells = <1>;
                                #size-cells = <0>;
                                compatible = "fsl,mpc8248-usb",
                                             "fsl,cpm2-usb";
                                reg = <11b60 18 8b00 100>;
                                interrupt-parent = <&PIC>;
                                interrupts = <b 8>;
                                fsl,cpm-command = <2e600000>;
                        };
                };

                PIC: interrupt-controller@10c00 {
                        #interrupt-cells = <2>;
                        interrupt-controller;
                        reg = <10c00 80>;
                        compatible = "fsl,mpc8248-pic", "fsl,pq2-pic";
                };
        };

};
