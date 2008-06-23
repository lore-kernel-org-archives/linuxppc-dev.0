Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 76C97DE47F
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 05:12:08 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5NJC5u8017929
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jun 2008 15:12:05 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5NJC4mc232638
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jun 2008 15:12:04 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5NJC4eb014660
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jun 2008 15:12:04 -0400
Date: Mon, 23 Jun 2008 15:08:46 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: John Linn <John.Linn@xilinx.com>
Subject: Re: [PATCH] [RFC] powerpc: Xilinx: adding virtex5 powerpc 440 support
Message-ID: <20080623150846.40d65f08@zod.rchland.ibm.com>
In-Reply-To: <20080623162856.D5FA41CA806C@mail66-dub.bigfish.com>
References: <20080623162856.D5FA41CA806C@mail66-dub.bigfish.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 23 Jun 2008 10:28:53 -0600
John Linn <John.Linn@xilinx.com> wrote:

> This is an early patch against the mainline that I wanted to start
> getting comments on.
> 
> I would appreciate any feedback.
> 
> I already see a few things that I need to look into myself.
> 
> 1.    I'm not sure why we need to disable the interrupts in the
> bootstrap loader?
> 2.    I see some SecetLab copyright in new files that might be just a
> cut/paste type error.
> 3.    I don't see the cputable.c up to date with the Xilinx specific
> 440.

Your patch got pretty word-wrapped because of the forward.  I'll give
it a go though.

> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 3934e26..94adfe1 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -483,6 +483,81 @@ config SECCOMP
> 
>  	  If unsure, say Y. Only embedded should say N here.
> 
> +config WANT_DEVICE_TREE
> +	bool
> +	default n

Not sure why you added this back.  We removed it entirely recently.

> +config BUILD_RAW_IMAGE
> +	bool "Build firmware-independent image"
> +	select WANT_DEVICE_TREE
> +	help
> +	  If this is enabled, a firmware independent "raw" image will be
> +	  built, as zImage.raw.  This requires a completely filled-in
> +	  device tree, with the following labels:
> +
> +	  mem_size_cells: on /#address-cells
> +	  memsize: on the size portion of /memory/reg
> +	  timebase: on the boot CPU's timebase property
> +
> +config DEVICE_TREE
> +	string "Static device tree source file"
> +	depends on WANT_DEVICE_TREE
> +	help
> +	  This specifies the device tree source (.dts) file to be
> +	  compiled and included when building the bootwrapper.  If a
> +	  relative filename is given, then it will be relative to
> +	  arch/powerpc/boot/dts.  If you are not using the bootwrapper,
> +	  or do not need to build a dts into the bootwrapper, this
> +	  field is ignored.
> +
> +	  For example, this is required when building a cuImage target
> +	  for an older U-Boot, which cannot pass a device tree itself.
> +	  Such a kernel will not work with a newer U-Boot that tries to
> +	  pass a device tree (unless you tell it not to).  If your
> U-Boot
> +	  does not mention a device tree in "help bootm", then use the
> +	  cuImage target and specify a device tree here.  Otherwise, use
> +	  the uImage target and leave this field blank.

This doesn't seem like it's needed any longer either.  I'm confused why
these changes were added back in (and similar the Makefile changes.)

> +config COMPRESSED_DEVICE_TREE
> +	bool "Use compressed device tree"
> +	depends on XILINX_VIRTEX
> +	depends on WANT_DEVICE_TREE
> +	help
> +	  In Xilinx FPGAs, the hardware can change quite dramatically
> while
> +	  still running the same kernel.  In this case and other similar
> +	  ones, it is preferable to associate the device tree with a
> +	  particular build of the hardware design.  This configuration
> +	  option assumes that the device tree blob has been compressed
> and
> +	  stored in Block RAM in the FPGA design.  Typically, such a
> block
> +	  ram is available in order to provide a bootloop or other code
> +	  close to the reset vector at the top of the address space.  By
> +	  default, the parameter options associated with this
> configuration
> +	  assumes that exactly one block ram (2KB) of storage is
> available,
> +	  which should be sufficient for most designs.  If necessary in
> a
> +	  particular design, due to boot code requirement or a large
> number
> +	  of devices, this address (and the corresponding parameters in
> the
> +	  EDK design) must be modified.
> +
> +	  Note that in some highly area constrained designs, no block
> rams
> +	  may be available in the design, and some other mechanism may
> be
> +	  used to hold the processor in reset while external memory is
> +	  initialized with processor code.  In such cases, that
> mechanism
> +	  should also be used to load the device tree at an appropriate
> +	  location, and the parameters associated with this
> configuration
> +	  option should be modified to point to that location in
> external
> +	  memory.
> +
> +config COMPRESSED_DTB_START
> +	hex "Start of compressed device tree"
> +	depends on COMPRESSED_DEVICE_TREE
> +	default 0xfffff800
> +
> +config COMPRESSED_DTB_SIZE
> +	hex "Size of compressed device tree"
> +	depends on COMPRESSED_DEVICE_TREE
> +	default 0x800
> +
> +
>  endmenu
> 
>  config ISA_DMA_API

<snip>

> diff --git a/arch/powerpc/boot/dts/ml507.dts
> b/arch/powerpc/boot/dts/ml507.dts
> new file mode 100644
> index 0000000..43d8535
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/ml507.dts
> @@ -0,0 +1,254 @@
> +/*
> + * (C) Copyright 2007-2008 Xilinx, Inc.
> + * (C) Copyright 2007 Michal Simek
> + *
> + * Michal SIMEK <monstr@monstr.eu>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
> + * MA 02111-1307 USA
> + *
> + * CAUTION: This file is automatically generated by libgen.
> + * Version: Xilinx EDK 10.1.01 EDK_K_SP1.2
> + */

Probably want to convert this to a dts-v1 style DTS file before
submitting.

> +
> +/ {
> +	#address-cells = <1>;

This doesn't look right.  440 has 36-bit physical addresses, so
#address-cells should be <2>.

> +	#size-cells = <1>;
> +	compatible = "xlnx,virtex";
> +	dcr-parent = <&ppc440_virtex5_0>;
> +	model = "testing";
> +	chosen {
> +		bootargs = "console=ttyS0 ip=on root=/dev/ram";
> +		linux,stdout-path = "/plb@0/serial@d0000000";
> +	} ;
> +	cpus {
> +		#address-cells = <1>;
> +		#cpus = <1>;
> +		#size-cells = <0>;
> +		ppc440_virtex5_0: cpu@0 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;

You don't need those in the cpu node itself.

> +			clock-frequency = <17d78400>;
> +			compatible = "PowerPC,440", "ibm,ppc440";
> +			d-cache-line-size = <20>;
> +			d-cache-size = <8000>;
> +			dcr-access-method = "native";
> +			dcr-controller ;
> +			device_type = "cpu";
> +			i-cache-line-size = <20>;
> +			i-cache-size = <8000>;
> +			model = "PowerPC,440";
> +			reg = <0>;
> +			timebase-frequency = <17d78400>;
> +			xlnx,apu-control = <1>;
> +			xlnx,apu-udi-0 = <c07701>;
> +			xlnx,apu-udi-1 = <c47701>;
> +			xlnx,apu-udi-10 = <0>;
> +			xlnx,apu-udi-11 = <0>;
> +			xlnx,apu-udi-12 = <0>;
> +			xlnx,apu-udi-13 = <0>;
> +			xlnx,apu-udi-14 = <0>;
> +			xlnx,apu-udi-15 = <0>;
> +			xlnx,apu-udi-2 = <0>;
> +			xlnx,apu-udi-3 = <0>;
> +			xlnx,apu-udi-4 = <0>;
> +			xlnx,apu-udi-5 = <0>;
> +			xlnx,apu-udi-6 = <0>;
> +			xlnx,apu-udi-7 = <0>;
> +			xlnx,apu-udi-8 = <0>;
> +			xlnx,apu-udi-9 = <0>;
> +			xlnx,dcr-autolock-enable = <1>;
> +			xlnx,dcu-rd-ld-cache-plb-prio = <0>;
> +			xlnx,dcu-rd-noncache-plb-prio = <0>;
> +			xlnx,dcu-rd-touch-plb-prio = <0>;
> +			xlnx,dcu-rd-urgent-plb-prio = <0>;
> +			xlnx,dcu-wr-flush-plb-prio = <0>;
> +			xlnx,dcu-wr-store-plb-prio = <0>;
> +			xlnx,dcu-wr-urgent-plb-prio = <0>;
> +			xlnx,dma0-control = <0>;
> +			xlnx,dma0-plb-prio = <0>;
> +			xlnx,dma0-rxchannelctrl = <1010000>;
> +			xlnx,dma0-rxirqtimer = <3ff>;
> +			xlnx,dma0-txchannelctrl = <1010000>;
> +			xlnx,dma0-txirqtimer = <3ff>;
> +			xlnx,dma1-control = <0>;
> +			xlnx,dma1-plb-prio = <0>;
> +			xlnx,dma1-rxchannelctrl = <1010000>;
> +			xlnx,dma1-rxirqtimer = <3ff>;
> +			xlnx,dma1-txchannelctrl = <1010000>;
> +			xlnx,dma1-txirqtimer = <3ff>;
> +			xlnx,dma2-control = <0>;
> +			xlnx,dma2-plb-prio = <0>;
> +			xlnx,dma2-rxchannelctrl = <1010000>;
> +			xlnx,dma2-rxirqtimer = <3ff>;
> +			xlnx,dma2-txchannelctrl = <1010000>;
> +			xlnx,dma2-txirqtimer = <3ff>;
> +			xlnx,dma3-control = <0>;
> +			xlnx,dma3-plb-prio = <0>;
> +			xlnx,dma3-rxchannelctrl = <1010000>;
> +			xlnx,dma3-rxirqtimer = <3ff>;
> +			xlnx,dma3-txchannelctrl = <1010000>;
> +			xlnx,dma3-txirqtimer = <3ff>;
> +			xlnx,endian-reset = <0>;
> +			xlnx,generate-plb-timespecs = <1>;
> +			xlnx,icu-rd-fetch-plb-prio = <0>;
> +			xlnx,icu-rd-spec-plb-prio = <0>;
> +			xlnx,icu-rd-touch-plb-prio = <0>;
> +			xlnx,interconnect-imask = <ffffffff>;
> +			xlnx,mplb-allow-lock-xfer = <1>;
> +			xlnx,mplb-arb-mode = <0>;
> +			xlnx,mplb-awidth = <20>;
> +			xlnx,mplb-counter = <500>;
> +			xlnx,mplb-dwidth = <80>;
> +			xlnx,mplb-max-burst = <8>;
> +			xlnx,mplb-native-dwidth = <80>;
> +			xlnx,mplb-p2p = <0>;
> +			xlnx,mplb-prio-dcur = <2>;
> +			xlnx,mplb-prio-dcuw = <3>;
> +			xlnx,mplb-prio-icu = <4>;
> +			xlnx,mplb-prio-splb0 = <1>;
> +			xlnx,mplb-prio-splb1 = <0>;
> +			xlnx,mplb-read-pipe-enable = <1>;
> +			xlnx,mplb-sync-tattribute = <0>;
> +			xlnx,mplb-wdog-enable = <1>;
> +			xlnx,mplb-write-pipe-enable = <1>;
> +			xlnx,mplb-write-post-enable = <1>;
> +			xlnx,num-dma = <1>;
> +			xlnx,pir = <f>;
> +			xlnx,ppc440mc-addr-base = <0>;
> +			xlnx,ppc440mc-addr-high = <1fffffff>;
> +			xlnx,ppc440mc-arb-mode = <0>;
> +			xlnx,ppc440mc-bank-conflict-mask = <c00000>;
> +			xlnx,ppc440mc-control = <f810008f>;
> +			xlnx,ppc440mc-max-burst = <8>;
> +			xlnx,ppc440mc-prio-dcur = <2>;
> +			xlnx,ppc440mc-prio-dcuw = <3>;
> +			xlnx,ppc440mc-prio-icu = <4>;
> +			xlnx,ppc440mc-prio-splb0 = <1>;
> +			xlnx,ppc440mc-prio-splb1 = <0>;
> +			xlnx,ppc440mc-row-conflict-mask = <3ffe00>;
> +			xlnx,ppcdm-asyncmode = <0>;
> +			xlnx,ppcds-asyncmode = <0>;
> +			xlnx,user-reset = <0>;

All of those seem very odd for being in the cpu node.  Why aren't they
with the individual nodes in the tree?

> +			DMA0: sdma@80 {
> +				compatible = "xlnx,ll-dma-1.00.a";
> +				dcr-reg = < 80 11 >;
> +				interrupt-parent = <&opb_intc_0>;
> +				interrupts = < 5 2 6 2 >;
> +			} ;

This definitely shouldn't be in the cpu node.

> +		} ;
> +	} ;
> +	plb_v46_cfb_0: plb@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "xlnx,plb-v46-1.02.a";
> +		ranges ;
> +		iic_bus: i2c@d0020000 {
> +			compatible = "xlnx,xps-iic-2.00.a";
> +			interrupt-parent = <&opb_intc_0>;
> +			interrupts = < 7 2 >;
> +			reg = < d0020000 200 >;
> +			xlnx,clk-freq = <5f5e100>;
> +			xlnx,family = "virtex5";
> +			xlnx,gpo-width = <1>;
> +			xlnx,iic-freq = <186a0>;
> +			xlnx,scl-inertial-delay = <0>;
> +			xlnx,sda-inertial-delay = <0>;
> +			xlnx,ten-bit-adr = <0>;
> +		} ;
> +		leds_8bit: gpio@d0010200 {
> +			compatible = "xlnx,xps-gpio-1.00.a";
> +			interrupt-parent = <&opb_intc_0>;
> +			interrupts = < 1 2 >;
> +			reg = < d0010200 200 >;
> +			xlnx,all-inputs = <0>;
> +			xlnx,all-inputs-2 = <0>;
> +			xlnx,dout-default = <0>;
> +			xlnx,dout-default-2 = <0>;
> +			xlnx,family = "virtex5";
> +			xlnx,gpio-width = <8>;
> +			xlnx,interrupt-present = <1>;
> +			xlnx,is-bidir = <1>;
> +			xlnx,is-bidir-2 = <1>;
> +			xlnx,is-dual = <0>;
> +			xlnx,tri-default = <ffffffff>;
> +			xlnx,tri-default-2 = <ffffffff>;
> +		} ;
> +		ll_temac_0: xps-ll-temac@91200000 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "xlnx,compound";
> +			ethernet@91200000 {
> +				compatible = "xlnx,xps-ll-temac-1.01.a";
> +				device_type = "network";
> +				interrupt-parent = <&opb_intc_0>;
> +				interrupts = < 4 2 >;
> +				llink-connected = <&DMA0>;
> +				local-mac-address = [ 02 00 00 00 00 00
> ];
> +				reg = < 91200000 40 >;
> +				xlnx,bus2core-clk-ratio = <1>;
> +				xlnx,phy-type = <1>;
> +				xlnx,phyaddr = <1>;
> +				xlnx,rxcsum = <0>;
> +				xlnx,rxfifo = <4000>;
> +				xlnx,temac-type = <0>;
> +				xlnx,txcsum = <0>;
> +				xlnx,txfifo = <4000>;
> +			} ;
> +		} ;
> +		opb_intc_0: interrupt-controller@d0020200 {
> +			#interrupt-cells = <2>;
> +			compatible = "xlnx,xps-intc-1.00.a";
> +			interrupt-controller ;
> +			reg = < d0020200 20 >;
> +			xlnx,num-intr-inputs = <8>;
> +		} ;
> +		plb_bram_if_cntlr_0: xps-bram-if-cntlr@ffff0000 {
> +			compatible = "xlnx,xps-bram-if-cntlr-1.00.a";
> +			reg = < ffff0000 10000 >;
> +			xlnx,family = "virtex5";
> +		} ;
> +		plb_bram_if_cntlr_1: xps-bram-if-cntlr@eee00000 {
> +			compatible = "xlnx,xps-bram-if-cntlr-1.00.a";
> +			reg = < eee00000 2000 >;
> +			xlnx,family = "virtex5";
> +		} ;
> +		rs232_uart_0: serial@d0000000 {
> +			clock-frequency = <1312d00>;
> +			compatible = "xlnx,xps-uart16550-2.00.a",
> "ns16550";
> +			current-speed = <2580>;
> +			device_type = "serial";
> +			interrupt-parent = <&opb_intc_0>;
> +			interrupts = < 0 2 >;
> +			reg = < d0000000 2000 >;
> +			reg-offset = <3>;
> +			reg-shift = <2>;
> +			xlnx,family = "virtex5";
> +			xlnx,has-external-rclk = <0>;
> +			xlnx,has-external-xin = <1>;
> +			xlnx,is-a-16550 = <1>;
> +		} ;
> +		sysace_compactflash: sysace@d0030100 {
> +			compatible = "xlnx,xps-sysace-1.00.a";
> +			reg = < d0030100 80 >;
> +			xlnx,family = "virtex5";
> +			xlnx,mem-width = <10>;
> +		} ;
> +	} ;
> +	ppc440mc_ddr2_0: memory@0 {
> +		device_type = "memory";
> +		reg = < 0 20000000 >;
> +	} ;
> +}  ;
> diff --git a/arch/powerpc/boot/io.h b/arch/powerpc/boot/io.h
> index ccaedae..ec57ec9 100644
> --- a/arch/powerpc/boot/io.h
> +++ b/arch/powerpc/boot/io.h
> @@ -99,4 +99,11 @@ static inline void barrier(void)
>  	asm volatile("" : : : "memory");
>  }
> 
> +static inline void disable_irq(void)
> +{
> +	int dummy;
> +	asm volatile("mfmsr %0; rlwinm %0, %0, 0, ~(1<<15); mtmsr %0" :
> +	             "=r" (dummy) : : "memory");
> +}

As you said, figuring out why this is here and at least adding a
comment would be good.

>  #endif /* _IO_H */
> diff --git a/arch/powerpc/boot/virtex.c b/arch/powerpc/boot/virtex.c
> new file mode 100644
> index 0000000..5d807c6
> --- /dev/null
> +++ b/arch/powerpc/boot/virtex.c
> @@ -0,0 +1,246 @@
> +/*
> + * Old U-boot compatibility for Walnut
> + *
> + * Author: Josh Boyer <jwboyer@linux.vnet.ibm.com>

You can remove this.  I'm pretty sure I didn't write this file :)

> + *
> + * Copyright 2007 IBM Corporation
> + *   Based on cuboot-83xx.c, which is:
> + * Copyright (c) 2007 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> it
> + * under the terms of the GNU General Public License version 2 as
> published
> + * by the Free Software Foundation.
> + */
> +
> +#include <stddef.h>
> +#include <stdio.h>
> +#include "ops.h"
> +#include "dcr.h"
> +#include "4xx.h"
> +#include "io.h"
> +#include "reg.h"
> +
> +BSS_STACK(4096);
> +
> +#include "types.h"
> +#include "gunzip_util.h"
> +#include <libfdt.h>
> +#include "../../../include/linux/autoconf.h"

Ew.  We've never included the CONFIG_ variables from Kconfig in the
bootwrapper.  It's supposed to be independent of the kernel.

> +#define UART_DLL		0	/* Out: Divisor Latch Low */
> +#define UART_DLM		1	/* Out: Divisor Latch High */
> +#define UART_FCR		2	/* Out: FIFO Control Register */
> +#define UART_FCR_CLEAR_RCVR 	0x02 	/* Clear the RCVR FIFO */
> +#define UART_FCR_CLEAR_XMIT	0x04 	/* Clear the XMIT FIFO */
> +#define UART_LCR		3	/* Out: Line Control Register */
> +#define UART_MCR		4	/* Out: Modem Control Register
> */
> +#define UART_MCR_RTS		0x02 	/* RTS complement */
> +#define UART_MCR_DTR		0x01 	/* DTR complement */
> +#define UART_LCR_DLAB		0x80 	/* Divisor latch access bit */
> +#define UART_LCR_WLEN8		0x03 	/* Wordlength: 8 bits */
> +
> +/* This function is only needed when there is no boot loader to
> +   initialize the UART
> +*/
> +static int virtex_ns16550_console_init(void *devp)
> +{
> +	int n;
> +	unsigned long reg_phys;
> +	unsigned char *regbase;
> +	u32 regshift, clk, spd;
> +	u16 divisor;
> +
> +	n = getprop(devp, "virtual-reg", &regbase, sizeof(regbase));
> +	if (n != sizeof(regbase)) {
> +		if (!dt_xlate_reg(devp, 0, &reg_phys, NULL))
> +			return -1;
> +
> +		regbase = (void *)reg_phys + 3;
> +	}
> +	regshift = 2;
> +
> +	n = getprop(devp, "current-speed", (void *)&spd, sizeof(spd));
> +	if (n != sizeof(spd))
> +		spd = 9600;
> +
> +	/* should there be a default clock rate?*/
> +	n = getprop(devp, "clock-frequency", (void *)&clk, sizeof(clk));
> +	if (n != sizeof(clk))
> +		return -1;
> +
> +	divisor = clk / (16 * spd);
> +
> +	/* Access baud rate */
> +	out_8(regbase + (UART_LCR << regshift), UART_LCR_DLAB);
> +
> +	/* Baud rate based on input clock */
> +	out_8(regbase + (UART_DLL << regshift), divisor & 0xFF);
> +	out_8(regbase + (UART_DLM << regshift), divisor >> 8);
> +
> +	/* 8 data, 1 stop, no parity */
> +	out_8(regbase + (UART_LCR << regshift), UART_LCR_WLEN8);
> +
> +	/* RTS/DTR */
> +	out_8(regbase + (UART_MCR << regshift), UART_MCR_RTS |
> UART_MCR_DTR);
> +
> +	/* Clear transmitter and receiver */
> +	out_8(regbase + (UART_FCR << regshift),
> +				UART_FCR_CLEAR_XMIT |
> UART_FCR_CLEAR_RCVR);
> +	return 0;
> +}
> +
> +/* For virtex, the kernel may be loaded without using a bootloader and
> if so
> +   some UARTs need more setup than is provided in the normal console
> init
> +*/
> +static int virtex_serial_console_init(void)
> +{
> +	void *devp;
> +	char devtype[MAX_PROP_LEN];
> +	char path[MAX_PATH_LEN];
> +
> +	devp = finddevice("/chosen");
> +	if (devp == NULL)
> +		return -1;
> +
> +	if (getprop(devp, "linux,stdout-path", path, MAX_PATH_LEN) > 0)
> {
> +		devp = finddevice(path);
> +		if (devp == NULL)
> +			return -1;
> +
> +		if ((getprop(devp, "device_type", devtype,
> sizeof(devtype)) > 0)
> +				&& !strcmp(devtype, "serial")
> +				&& (dt_is_compatible(devp, "ns16550")))
> +				virtex_ns16550_console_init(devp);
> +	}
> +	return 0;
> +}
> +
> +#ifdef CONFIG_COMPRESSED_DEVICE_TREE
> +static struct gunzip_state gzstate;
> +#endif
> +
> +void platform_init(void)
> +{
> +	u32 memreg[4];
> +	u64 start;
> +	u64 size = 0x2000000;
> +	int naddr, nsize, i;
> +	void *root, *memory;
> +	static const unsigned long line_size = 32;
> +	static const unsigned long congruence_classes = 256;
> +	unsigned long addr;
> +	unsigned long dccr;
> +
> +#ifdef CONFIG_COMPRESSED_DEVICE_TREE
> +	void *dtbz_start;
> +	u32 dtbz_size;
> +	void *dtb_addr;
> +	u32 dtb_size;
> +	struct fdt_header dtb_header;
> +	int len;
> +#endif
> +
> +        if((mfpvr() & 0xfffff000) == 0x20011000) {
> +            /* PPC errata 213: only for Virtex-4 FX */
> +            __asm__("mfccr0  0\n\t"
> +                    "oris    0,0,0x50000000@h\n\t"
> +                    "mtccr0  0"
> +                    : : : "0");
> +        }
> +
> +	/*
> +	 * Invalidate the data cache if the data cache is turned off.
> +	 * - The 405 core does not invalidate the data cache on power-up
> +	 *   or reset but does turn off the data cache. We cannot assume
> +	 *   that the cache contents are valid.
> +	 * - If the data cache is turned on this must have been done by
> +	 *   a bootloader and we assume that the cache contents are
> +	 *   valid.
> +	 */
> +	__asm__("mfdccr %0": "=r" (dccr));
> +	if (dccr == 0) {
> +		for (addr = 0;
> +		     addr < (congruence_classes * line_size);
> +		     addr += line_size) {
> +			__asm__("dccci 0,%0": :"b"(addr));
> +		}
> +	}
> +
> +#if defined(CONFIG_XILINX_VIRTEX_5_FXT) &&
> defined(CONFIG_MATH_EMULATION)
> +	/* Make sure the APU is disabled when using soft FPU emulation
> */
> +	mtdcr(5, 0);
> +#endif
> +
> +	disable_irq();
> +
> +#ifdef CONFIG_COMPRESSED_DEVICE_TREE
> +
> +        /** FIXME: flatdevicetrees need the initializer allocated,
> +            libfdt will fix this. */
> +	dtbz_start = (void *)CONFIG_COMPRESSED_DTB_START;
> +	dtbz_size = CONFIG_COMPRESSED_DTB_SIZE;
> +	/** get the device tree */
> +	gunzip_start(&gzstate, dtbz_start, dtbz_size);
> +	gunzip_exactly(&gzstate, &dtb_header, sizeof(dtb_header));
> +
> +	dtb_size = dtb_header.totalsize;
> +	// printf("Allocating 0x%lx bytes for dtb ...\n\r", dtb_size);
> +
> +	dtb_addr = _end; // Should be allocated?
> +
> +	gunzip_start(&gzstate, dtbz_start, dtbz_size);
> +	len = gunzip_finish(&gzstate, dtb_addr, dtb_size);
> +	if (len != dtb_size)
> +		fatal("ran out of data!  only got 0x%x of 0x%lx
> bytes.\n\r",
> +				len, dtb_size);
> +	printf("done 0x%x bytes\n\r", len);
> +	simple_alloc_init(0x800000, size - (unsigned long)0x800000, 32,
> 64);
> +	fdt_init(dtb_addr);
> +#else
> +        /** FIXME: flatdevicetrees need the initializer allocated,
> +            libfdt will fix this. */
> +	simple_alloc_init(_end, size - (unsigned long)_end, 32, 64);
> +	fdt_init(_dtb_start);
> +#endif
> +
> +	root = finddevice("/");
> +	if (getprop(root, "#address-cells", &naddr, sizeof(naddr)) < 0)
> +		naddr = 2;
> +	if (naddr < 1 || naddr > 2)
> +		fatal("Can't cope with #address-cells == %d in /\n\r",
> naddr);
> +
> +	if (getprop(root, "#size-cells", &nsize, sizeof(nsize)) < 0)
> +		nsize = 1;
> +	if (nsize < 1 || nsize > 2)
> +		fatal("Can't cope with #size-cells == %d in /\n\r",
> nsize);
> +
> +	memory = finddevice("/memory@0");
> +	if (! memory) {
> +		fatal("Need a memory@0 node!\n\r");
> +	}
> +	if (getprop(memory, "reg", memreg, sizeof(memreg)) < 0)
> +		fatal("Need a memory@0 node!\n\r");
> +
> +	i = 0;
> +	start = memreg[i++];
> +	if(naddr == 2) {
> +		start = (start << 32) | memreg[i++];
> +	}
> +	size = memreg[i++];
> +	if (nsize == 2)
> +		size = (size << 32) | memreg[i++];
> +
> +	// timebase_period_ns = 1000000000 / timebase;
> +	virtex_serial_console_init();
> +	serial_console_init();
> +	if (console_ops.open)
> +		console_ops.open();
> +
> +#ifdef CONFIG_COMPRESSED_DEVICE_TREE
> +	printf("Using compressed device tree at 0x%x\n\r",
> CONFIG_COMPRESSED_DTB_START);
> +#else
> +#endif
> +        printf("booting virtex\n\r");
> +        printf("memstart=0x%llx\n\r", start);
> +        printf("memsize=0x%llx\n\r", size);
> +}

Shouldn't you be able to detect a compressed device tree based on the
gzip header?  Or something similar?


> diff --git a/arch/powerpc/platforms/44x/Kconfig
> b/arch/powerpc/platforms/44x/Kconfig
> index 6abe913..b90b33d 100644
> --- a/arch/powerpc/platforms/44x/Kconfig
> +++ b/arch/powerpc/platforms/44x/Kconfig
> @@ -102,6 +102,58 @@ config YOSEMITE
>  #	help
>  #	  This option enables support for the IBM PPC440GX evaluation
> board.
> 
> +config XILINX_ML507
> +	bool "Xilinx ML507 Reference System"
> +	depends on 44x
> +	default n
> +	select XILINX_ML5XX
> +	select WANT_DEVICE_TREE
> +	help
> +	  This option enables support for the Xilinx ML507 board.
> +
> +config XILINX_DISABLE_44x_CACHE
> +	bool "Disable PPC440 caches"
> +	depends on XILINX_ML507
> +	help
> +	  This option allows to disable the caches on the PPC440. Some
> early
> +	  PPC440 soft-cores do not work with caches enabled. Also, some
> early
> +	  ML507 boards do have a non-functioning cache. If you have any
> +	  problems running the ML5, try using this option.
> +
> +config PPC_FPU
> +	depends on XILINX_VIRTEX_5_FXT
> +	bool "Enable Xilinx Soft FPU"
> +	help
> +	  This option enables the Xilinx Soft FPU attached to the APU
> +	  interface of the PPC440 (requires DP_FULL FPU pcore).

There is already a PPC_FPU option in platforms/Kconfig.cputype

josh
