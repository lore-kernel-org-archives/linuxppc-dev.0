Return-Path: <nm127@freemail.hu>
Received: from relay02.digicable.hu (relay02.digicable.hu [92.249.128.188])
	by ozlabs.org (Postfix) with ESMTP id EEEFEB7D0E
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Mar 2010 05:12:18 +1100 (EST)
Message-ID: <4BA11B7B.1080807@freemail.hu>
Date: Wed, 17 Mar 2010 19:12:11 +0100
From: =?UTF-8?B?TsOpbWV0aCBNw6FydG9u?= <nm127@freemail.hu>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>,
	David Gibson <david@gibson.dropbear.id.au>,
	Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Freescale MPC5554 device tree (was: cross-compiling Linux for
	PowerPC e200 core?)
References: <4B934CCA.8030608@freemail.hu>
	<fa686aa41003080934q5d5bebabl7d582d1264da4dcd@mail.gmail.com>
	<4B95458A.4000304@freemail.hu>
	<fa686aa41003081108v31e73660pa817863e5aa73653@mail.gmail.com>
	<4B95F298.5040000@freemail.hu>
	<fa686aa41003082335t5a5d642fi13c81e4b84f7b697@mail.gmail.com>
	<4B9889AC.4080309@freemail.hu> <20100311062331.GI11655@yookeroo>
	<4B99DE95.8010304@freemail.hu>
	<fa686aa41003120414j48825e7cr952336703fe03b04@mail.gmail.com>
	<4B9B7E0A.8090703@freemail.hu>
In-Reply-To: <4B9B7E0A.8090703@freemail.hu>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Grant, David and Segher,

is there any comments or suggestions about this MPC5554 device tree?

Regards,

	Márton Németh

Németh Márton wrote:
> Hi,
> 
> here is a version with modified cpu node, xbar ranges and added interrupt sources.
> Please send comments.
> 
> Regards,
> 
> 	Márton Németh
> 
> ---
> From: Márton Németh <nm127@freemail.hu>
> 
> Add device tree for Freescale MPC5554.
> 
> Signed-off-by: Márton Németh <nm127@freemail.hu>
> ---
> diff -uprN linux-2.6.33.orig/arch/powerpc/boot/dts/mpc5554.dts linux/arch/powerpc/boot/dts/mpc5554.dts
> --- linux-2.6.33.orig/arch/powerpc/boot/dts/mpc5554.dts	1970-01-01 01:00:00.000000000 +0100
> +++ linux/arch/powerpc/boot/dts/mpc5554.dts	2010-03-13 12:52:32.000000000 +0100
> @@ -0,0 +1,473 @@
> +/*
> + * Freescale MPC5554 Device Tree Source
> + *
> + * Based on MPC5553/5554 Microcontroller Reference Manual, Rev. 4.0, 04/2007
> + * http://www.freescale.com/files/32bit/doc/ref_manual/MPC5553_MPC5554_RM.pdf
> + *  - Block Diagram: page 1-3, Figure 1-1
> + *  - Memory Map: page 1-21, Table 1-2
> + *  - Interrupt Request Sources: page 10-16, Table 10-9
> + *
> + * Copyright 2010 Márton Németh
> + * Márton Németh <nm127@freemail.hu>
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +/dts-v1/;
> +
> +/ {
> +	model = "MPC5554";
> +	compatible = "fsl,MPC5554EVB";		// Freescale MPC5554 Evaluation Board
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	interrupt-parent = <&intc>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu@0 {
> +			device_type = "cpu";
> +			compatible = "PowerPC,5554", "fsl,mpc5554-e200z6", "fsl,powerpc-e200z6";
> +			reg = <0>;
> +			d-cache-line-size = <32>;
> +			i-cache-line-size = <32>;
> +			d-cache-size = <0x8000>;	// L1, 32KiB
> +			i-cache-size = <0x8000>;	// L1, 32KiB
> +			timebase-frequency = <0>;	// from bootloader
> +			bus-frequency = <0>;		// from bootloader
> +			clock-frequency = <0>;		// from bootloader
> +		};
> +	};
> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0x40000000 0x10000>;	// 32KiB internal SRAM
> +	};
> +
> +	xbar@fff04000 {		// System Bus Crossbar Switch (XBAR)
> +		compatible = "fsl,mpc5554-xbar";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		// The full memory range is covered by XBAR
> +		ranges;
> +		reg = <0xfff04000 0x4000>;
> +
> +		flash@0 {	// read-only FLASH
> +			compatible = "fsl,mpc5554-flash";
> +			reg = <0x00000000 0x200000>;	// 2MiB internal FLASH
> +		};
> +
> +		bridge@c3f00000 {
> +			compatible = "fsl,mpc5554-pbridge-a";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0xc0000000 0x20000000>;
> +			reg = <0xc3f00000 0x4000>;
> +
> +			fmpll@3f80000 {		// Frequency Modulated PLL
> +				compatible = "fsl,mpc5554-fmpll";
> +				reg = <0x03f80000 0x4000>;
> +				interrupts = <43 1	// Loss of Clock
> +					      44 1>;	// Loss of Lock
> +			};
> +
> +			flashconfig@3f88000 {	// Flash Configuration
> +				compatible = "fsl,mpc5554-flashconfig";
> +				reg = <0x03f88000 0x4000>;
> +			};
> +
> +			siu@3f89000 {		// System Integration Unit
> +				compatible = "fsl,mpc5554-siu";
> +				reg = <0x03f90000 0x4000>;
> +				interrupts = <45 1	// External Interrupt Overrun 0-15
> +					      46 1	// External Interrupt 0
> +					      47 1	// External Interrupt 1
> +					      48 1	// External Interrupt 2
> +					      49 1	// External Interrupt 3
> +					      50 1>;	// External Interrupt 4-15
> +			};
> +
> +			emios@3fa0000 {		// Modular Timer System
> +				compatible = "fsl,mpc5554-emios";
> +				reg = <0x03fa0000 0x4000>;
> +				interrupts = <51 1	// Channel 0
> +					      52 1	// Channel 1
> +					      53 1	// Channel 2
> +					      54 1	// Channel 3
> +					      55 1	// Channel 4
> +					      56 1	// Channel 5
> +					      57 1	// Channel 6
> +					      58 1	// Channel 7
> +					      59 1	// Channel 8
> +					      60 1	// Channel 9
> +					      61 1	// Channel 10
> +					      62 1	// Channel 11
> +					      63 1	// Channel 12
> +					      64 1	// Channel 13
> +					      65 1	// Channel 14
> +					      66 1	// Channel 15
> +					      202 1	// Channel 16
> +					      203 1	// Channel 17
> +					      204 1	// Channel 18
> +					      205 1	// Channel 19
> +					      206 1	// Channel 20
> +					      207 1	// Channel 21
> +					      208 1	// Channel 22
> +					      209 1>;	// Channel 23
> +			};
> +
> +			etpu@3fc0000 {		// Enhanced Time Processing Unit
> +				compatible = "fsl,mpc5554-etpu";
> +				reg = <0x03fc0000 0x4000>;
> +				interrupts = <67 1	// Global Exception
> +					      68 1	// A Channel 0
> +					      69 1	// A Channel 1
> +					      70 1	// A Channel 2
> +					      71 1	// A Channel 3
> +					      72 1	// A Channel 4
> +					      73 1	// A Channel 5
> +					      74 1	// A Channel 6
> +					      75 1	// A Channel 7
> +					      76 1	// A Channel 8
> +					      77 1	// A Channel 9
> +					      78 1	// A Channel 10
> +					      79 1	// A Channel 11
> +					      80 1	// A Channel 12
> +					      81 1	// A Channel 13
> +					      82 1	// A Channel 14
> +					      83 1	// A Channel 15
> +					      84 1	// A Channel 16
> +					      85 1	// A Channel 17
> +					      86 1	// A Channel 18
> +					      87 1	// A Channel 19
> +					      88 1	// A Channel 20
> +					      89 1	// A Channel 21
> +					      90 1	// A Channel 22
> +					      91 1	// A Channel 23
> +					      92 1	// A Channel 24
> +					      93 1	// A Channel 25
> +					      94 1	// A Channel 26
> +					      95 1	// A Channel 27
> +					      96 1	// A Channel 28
> +					      97 1	// A Channel 29
> +					      98 1	// A Channel 30
> +					      99 1	// A Channel 31
> +					      243 1	// B Channel 0
> +					      244 1	// B Channel 1
> +					      245 1	// B Channel 2
> +					      246 1	// B Channel 3
> +					      247 1	// B Channel 4
> +					      248 1	// B Channel 5
> +					      249 1	// B Channel 6
> +					      250 1	// B Channel 7
> +					      251 1	// B Channel 8
> +					      252 1	// B Channel 9
> +					      253 1	// B Channel 10
> +					      254 1	// B Channel 11
> +					      255 1	// B Channel 12
> +					      256 1	// B Channel 13
> +					      257 1	// B Channel 14
> +					      258 1	// B Channel 15
> +					      259 1	// B Channel 16
> +					      260 1	// B Channel 17
> +					      261 1	// B Channel 18
> +					      262 1	// B Channel 19
> +					      263 1	// B Channel 20
> +					      264 1	// B Channel 21
> +					      265 1	// B Channel 22
> +					      266 1	// B Channel 23
> +					      267 1	// B Channel 24
> +					      268 1	// B Channel 25
> +					      269 1	// B Channel 26
> +					      270 1	// B Channel 27
> +					      271 1	// B Channel 28
> +					      272 1	// B Channel 29
> +					      273 1	// B Channel 30
> +					      274 1>;	// B Channel 31
> +			};
> +
> +			etpudata@3fc8000 {	// eTPU Shared Data Memory (Parameter RAM)
> +				compatible = "fsl,mpc5554-etpudata";
> +				reg = <0x03fc8000 0x4000>;
> +			};
> +
> +			etpudata@3fcc000 {	// eTPU Shared Data Memory (Parameter RAM) mirror
> +				compatible = "fsl,mpc5554-etpudata";
> +				reg = <0x03fcc000 0x4000>;
> +			};
> +
> +			etpucode@3fd0000 {		// eTPU Shared Code RAM
> +				compatible = "fsl,mpc5554-etpucode";
> +				reg = <0x03fd0000 0x4000>;
> +			};
> +		};
> +
> +		bridge@fff00000 {
> +			compatible = "fsl,mpc5554-pbridge-b";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0xe0000000 0x20000000>;
> +			reg = <0xfff00000 0x4000>;
> +
> +			ecsm@fff40000 {		// Error Correction Status Module (ECSM)
> +				compatible = "fsl,mpc5554-ecsm";
> +				reg = <0xfff40000 0x4000>;
> +				interrupts = <8 1	// Software Watchdog Interrupt
> +					      9 1>;	// Combined: Internal SRAM Non-Correctable Error, Flash Non-Correctable Error
> +			};
> +
> +			edma@fff44000 {		// Enhanced DMA Controller (eDMA)
> +				compatible = "fsl,mpc5554-edma";
> +				reg = <0xfff44000 0x4000>;
> +				interrupts = <10 1	// Channel Error 0-31
> +					      11 1	// Channel 0
> +					      12 1	// Channel 1
> +					      13 1	// Channel 2
> +					      14 1	// Channel 3
> +					      15 1	// Channel 4
> +					      16 1	// Channel 5
> +					      17 1	// Channel 6
> +					      18 1	// Channel 7
> +					      19 1	// Channel 8
> +					      20 1	// Channel 9
> +					      21 1	// Channel 10
> +					      22 1	// Channel 11
> +					      23 1	// Channel 12
> +					      24 1	// Channel 13
> +					      25 1	// Channel 14
> +					      26 1	// Channel 15
> +					      27 1	// Channel 16
> +					      28 1	// Channel 17
> +					      29 1	// Channel 18
> +					      30 1	// Channel 19
> +					      31 1	// Channel 20
> +					      32 1	// Channel 21
> +					      33 1	// Channel 22
> +					      34 1	// Channel 23
> +					      35 1	// Channel 24
> +					      36 1	// Channel 25
> +					      37 1	// Channel 26
> +					      38 1	// Channel 27
> +					      39 1	// Channel 28
> +					      40 1	// Channel 29
> +					      41 1	// Channel 30
> +					      42 1	// Channel 31
> +					      210 1	// Channel Error 32-63
> +					      211 1	// Channel 32
> +					      212 1	// Channel 33
> +					      213 1	// Channel 34
> +					      214 1	// Channel 35
> +					      215 1	// Channel 36
> +					      216 1	// Channel 37
> +					      217 1	// Channel 38
> +					      218 1	// Channel 39
> +					      219 1	// Channel 40
> +					      220 1	// Channel 41
> +					      221 1	// Channel 42
> +					      222 1	// Channel 43
> +					      223 1	// Channel 44
> +					      224 1	// Channel 45
> +					      225 1	// Channel 46
> +					      226 1	// Channel 47
> +					      227 1	// Channel 48
> +					      228 1	// Channel 49
> +					      229 1	// Channel 50
> +					      230 1	// Channel 51
> +					      231 1	// Channel 52
> +					      232 1	// Channel 53
> +					      233 1	// Channel 54
> +					      234 1	// Channel 55
> +					      235 1	// Channel 56
> +					      236 1	// Channel 57
> +					      237 1	// Channel 58
> +					      238 1	// Channel 59
> +					      239 1	// Channel 60
> +					      240 1	// Channel 61
> +					      241 1	// Channel 62
> +					      242 1>;	// Channel 63
> +			};
> +
> +			intc: intc@fff48000 {		// Interrupt Controller (INTC)
> +				compatible = "fsl,mpc5554-intc";
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				reg = <0xfff48000 0x4000>;
> +			};
> +
> +			eqadc@fff80000 {	// Enhanced Queued Analog-to-Digital Converter (eQADC)
> +				compatible = "fsl,mpc5554-eqacd";
> +				reg = <0xfff80000 0x4000>;
> +				interrupts = <100 1	// Combined: Trigger Overrun, Receive FIFO Overflow, Command FIFO Underflow
> +					      101 1	// Command FIFO 0 Non-Coherency
> +					      102 1	// Command FIFO 0 Pause
> +					      103 1	// Command FIFO 0 End of Queue
> +					      104 1	// Command FIFO 0 Fill
> +					      105 1	// Command FIFO 0 Drain
> +					      106 1	// Command FIFO 1 Non-Coherency
> +					      107 1	// Command FIFO 1 Pause
> +					      108 1	// Command FIFO 1 End of Queue
> +					      109 1	// Command FIFO 1 Fill
> +					      111 1	// Command FIFO 1 Drain
> +					      111 1	// Command FIFO 2 Non-Coherency
> +					      112 1	// Command FIFO 2 Pause
> +					      113 1	// Command FIFO 2 End of Queue
> +					      114 1	// Command FIFO 2 Fill
> +					      115 1	// Command FIFO 2 Drain
> +					      116 1	// Command FIFO 3 Non-Coherency
> +					      117 1	// Command FIFO 3 Pause
> +					      118 1	// Command FIFO 3 End of Queue
> +					      119 1	// Command FIFO 3 Fill
> +					      120 1	// Command FIFO 3 Drain
> +					      121 1	// Command FIFO 4 Non-Coherency
> +					      122 1	// Command FIFO 4 Pause
> +					      123 1	// Command FIFO 4 End of Queue
> +					      124 1	// Command FIFO 4 Fill
> +					      125 1	// Command FIFO 4 Drain
> +					      126 1	// Command FIFO 5 Non-Coherency
> +					      127 1	// Command FIFO 5 Pause
> +					      128 1	// Command FIFO 5 End of Queue
> +					      129 1	// Command FIFO 5 Fill
> +					      130 1>;	// Command FIFO 5 Drain
> +			};
> +
> +			dspi@fff90000 {		// Deserial Serial Peripheral Interface (DSPI_A)
> +				compatible = "fsl,mpc5554-dspi";
> +				reg = <0xfff90000 0x4000>;
> +				interrupts = <275 1	// Combined: Transmit FIFO Underflow, Receive FIFO Overflow
> +					      276 1	// Transmit FIFO End of Queue
> +					      277 1	// Transmit FIFO Fill Flag
> +					      278 1	// Transfer Complete
> +					      279 1>;	// Receive FIFO Drain
> +			};
> +
> +			dspi@fff94000 {		// Deserial Serial Peripheral Interface (DSPI_B)
> +				compatible = "fsl,mpc5554-dspi";
> +				reg = <0xfff94000 0x4000>;
> +				interrupts = <131 1	// Combined: Transmit FIFO Underflow, Receive FIFO Overflow
> +					      132 1	// Transmit FIFO End of Queue
> +					      133 1	// Transmit FIFO Fill Flag
> +					      134 1	// Transfer Complete
> +					      135 1>;	// Receive FIFO Drain
> +			};
> +
> +			dspi@fff98000 {		// Deserial Serial Peripheral Interface (DSPI_C)
> +				compatible = "fsl,mpc5554-dspi";
> +				reg = <0xfff98000 0x4000>;
> +				interrupts = <136 1	// Combined: Transmit FIFO Underflow, Receive FIFO Overflow
> +					      137 1	// Transmit FIFO End of Queue
> +					      138 1	// Transmit FIFO Fill Flag
> +					      139 1	// Transfer Complete
> +					      140 1>;	// Receive FIFO Drain
> +			};
> +
> +			dspi@fff9c000 {		// Deserial Serial Peripheral Interface (DSPI_D)
> +				compatible = "fsl,mpc5554-dspi";
> +				reg = <0xfff9c000 0x4000>;
> +				interrupts = <141 1	// Combined: Transmit FIFO Underflow, Receive FIFO Overflow
> +					      142 1	// Transmit FIFO End of Queue
> +					      143 1	// Transmit FIFO Fill Flag
> +					      144 1	// Transfer Complete
> +					      145 1>;	// Receive FIFO Drain
> +			};
> +
> +			esci@fffb0000 {		// Serial Communications Interface (SCI_A)
> +				compatible = "fsl,mpc5554-esci";
> +				reg = <0xfffb0000 0x4000>;
> +				interrupts = <146 1>;	// Combined request for all SCI_A interrupts
> +			};
> +
> +			esci@fffb4000 {		// Serial Communications Interface (SCI_B)
> +				compatible = "fsl,mpc5554-esci";
> +				reg = <0xfffb4000 0x4000>;
> +				interrupts = <149 1>;	// Combined request for all SCI_A interrupts
> +			};
> +
> +			can@fffc0000 {		// Controller Area Network (FlexCAN_A)
> +				compatible = "fsl,mpc5554-flexcan";
> +				reg = <0xfffc0000 0x4000>;
> +				interrupts = <152 1	// Bus off
> +					      153 1	// Error
> +					      155 1	// Buffer 0
> +					      156 1	// Buffer 1
> +					      157 1	// Buffer 2
> +					      158 1	// Buffer 3
> +					      159 1	// Buffer 4
> +					      160 1	// Buffer 5
> +					      161 1	// Buffer 6
> +					      162 1	// Buffer 7
> +					      163 1	// Buffer 8
> +					      164 1	// Buffer 9
> +					      165 1	// Buffer 10
> +					      166 1	// Buffer 11
> +					      167 1	// Buffer 12
> +					      168 1	// Buffer 13
> +					      169 1	// Buffer 14
> +					      170 1	// Buffer 15
> +					      171 1	// Buffers 16-31
> +					      172 1>;	// Buffers 32-63
> +			};
> +
> +			can@fffc4000 {		// Controller Area Network (FlexCAN_B)
> +				compatible = "fsl,mpc5554-flexcan";
> +				reg = <0xfffc4000 0x4000>;
> +				interrupts = <280 1	// Bus off
> +					      281 1	// Error
> +					      283 1	// Buffer 0
> +					      284 1	// Buffer 1
> +					      285 1	// Buffer 2
> +					      286 1	// Buffer 3
> +					      287 1	// Buffer 4
> +					      288 1	// Buffer 5
> +					      289 1	// Buffer 6
> +					      290 1	// Buffer 7
> +					      291 1	// Buffer 8
> +					      292 1	// Buffer 9
> +					      293 1	// Buffer 10
> +					      294 1	// Buffer 11
> +					      295 1	// Buffer 12
> +					      296 1	// Buffer 13
> +					      297 1	// Buffer 14
> +					      298 1	// Buffer 15
> +					      299 1	// Buffers 16-31
> +					      300 1>;	// Buffers 32-63
> +			};
> +
> +			can@fffc8000 {		// Controller Area Network (FlexCAN_C)
> +				compatible = "fsl,mpc5554-flexcan";
> +				reg = <0xfffc8000 0x4000>;
> +				interrupts = <173 1	// Bus off
> +					      174 1	// Error
> +					      176 1	// Buffer 0
> +					      177 1	// Buffer 1
> +					      178 1	// Buffer 2
> +					      179 1	// Buffer 3
> +					      180 1	// Buffer 4
> +					      181 1	// Buffer 5
> +					      182 1	// Buffer 6
> +					      183 1	// Buffer 7
> +					      184 1	// Buffer 8
> +					      185 1	// Buffer 9
> +					      186 1	// Buffer 10
> +					      187 1	// Buffer 11
> +					      188 1	// Buffer 12
> +					      189 1	// Buffer 13
> +					      190 1	// Buffer 14
> +					      191 1	// Buffer 15
> +					      192 1	// Buffers 16-31
> +					      193 1>;	// Buffers 32-63
> +			};
> +
> +			bam@ffffc000 {		// Boot Assist Module (BAM)
> +				compatible = "fsl,mpc5554-bam";
> +				reg = <0xffffc000 0x4000>;
> +			};
> +
> +		};
> +
> +	};
> +
> +};
> 
