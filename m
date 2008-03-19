Return-Path: <jblack547@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by ozlabs.org (Postfix) with ESMTP id BB8BDDE07F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Mar 2008 04:06:04 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so123193anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Mar 2008 10:06:02 -0700 (PDT)
Message-ID: <b77025b40803191006m60dc3145la368ac227df43b17@mail.gmail.com>
Date: Wed, 19 Mar 2008 11:06:02 -0600
From: "James Black" <jblack547@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: muram in device tree for mpc8250 in arch/powerpc
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am porting a proprietary mpc8250 board to 2.6.24. I have the 2.6.19
kernel from denx working. I have ported to u-boot 1.3.2 and have the
platform setup within the 2.6.24 kernel and used pq2fads.dts as an
example of the device tree.

Everything in u-boot is working. u-boot doesn't complain about the
device tree and fills in the clocks and memory using the "fdt
boardsetup" command. In fact, u-boot 1.3.2 can boot the 2.6.29 kernel,
no problem.

I turned on early kernel debugging in 2.6.24 and it looks like all the
device tree parsing is working. The boot hangs and or crashes while
trying to setup the paging. I drilled down the code from init/main.c
and found that it seems the muram device node is killing the
allocator.

I tried to fully describe the segments in muram node and it seems to
mess things up even worse. Can anyone give some pointers to help me
work out this issue?

I wanted to start with as simple a description as possible. The
following tree describes the flash, SDRAM, SCC1, SCC3 and FCC1.


/*
* Device Tree for the CTA5000S board with an MPC8250 chip.
* Device Tree for the PQ2FADS-ZU board with an MPC8280 chip.
*
* Copyright 2007 Freescale Semiconductor Inc.
*
* This program is free software; you can redistribute it and/or modify it
* under the terms of the GNU General Public License as published by the
* Free Software Foundation; either version 2 of the License, or (at your
* option) any later version.
*/

/ {

model = "cta5000s";
compatible = "fsl,cta5000s";
#address-cells = <1>;
#size-cells = <1>;
cpus {
#address-cells = <1>;
#size-cells = <0>;
PowerPC,8250@0 {
device_type = "cpu";
reg = <0>;
d-cache-line-size = <20>;
i-cache-line-size = <20>;
d-cache-size = <4000>;
i-cache-size = <4000>;
timebase-frequency = <0>;
clock-frequency = <0>;
};

};

memory {
device_type = "memory";
reg = <0 0>;
};

localbus@f0010100 {
compatible = "fsl,mpc8250-localbus",
"fsl,pq2-localbus";
#address-cells = <2>;
#size-cells = <1>;
reg = <f0010100 60>;
ranges = <0 0 fe000000 00200000>;
flash@fe000000,0 {
compatible = "amd", "cfi-flash";
reg = <0 fe000000 00200000>;
bank-width = <2>;
device-width = <1>;
};

};

soc@f0000000 {
#address-cells = <1>;
#size-cells = <1>;
device_type = "soc";
compatible = "fsl,mpc8250", "fsl,pq2-soc";
ranges = <00000000 f0000000 00014000>;
// Temporary -- will go away once kernel uses ranges for get_immrbase().
reg = <f0000000 00014000>;
cpm@119c0 {
#address-cells = <1>;
#size-cells = <1>;
#interrupt-cells = <2>;
compatible = "fsl,mpc8250-cpm", "fsl,cpm2";
reg = <119c0 30>;
ranges;

muram@0 {
#address-cells = <1>;
#size-cells = <1>;
ranges = <0 0 10000>;

data@0 {
compatible = "fsl,cpm-muram-data";
reg = <0 4000 8000 4000>;
};

};

brg@119f0 {
compatible = "fsl,mpc8250-brg",
"fsl,cpm2-brg",
"fsl,cpm-brg";
reg = <119f0 10 115f0 10>;
};

serial@11a00 {
device_type = "serial";
compatible = "fsl,mpc8250-scc-uart",
"fsl,cpm2-scc-uart";
reg = <11a00 20 8000 100>;
interrupts = <28 8>;
interrupt-parent = <&PIC>;
fsl,cpm-brg = <1>;
fsl,cpm-command = <00800000>;
};

serial@11a40 {
device_type = "serial";
compatible = "fsl,mpc8250-scc-uart",
"fsl,cpm2-scc-uart";
reg = <11a40 20 8200 100>;
interrupts = <2a 8>;
interrupt-parent = <&PIC>;
fsl,cpm-brg = <5>;
fsl,cpm-command = <11800000>;
};


ethernet@11300 {
device_type = "network";
compatible = "fsl,mpc8250-fcc-enet",
"fsl,cpm2-fcc-enet";
reg = <11300 20 8400 100>;
interrupts = <20 8>;
interrupt-parent = <&PIC>;
linux,network-index = <0>;
fsl,cpm-command = <14000300>;
};

};

PIC: interrupt-controller@10c00 {
#interrupt-cells = <2>;
interrupt-controller;
reg = <10c00 80>;
compatible = "fsl,mpc8250-pic", "fsl,cpm2-pic";
};

};

chosen {
linux,stdout-path = "/soc/cpm/serial@11a00";
};

};
