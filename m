Return-Path: <nm127@freemail.hu>
Received: from relay02.digicable.hu (relay02.digicable.hu [92.249.128.188])
	by ozlabs.org (Postfix) with ESMTP id 6431AB7D2E
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Mar 2010 17:12:01 +1100 (EST)
Message-ID: <4B9889AC.4080309@freemail.hu>
Date: Thu, 11 Mar 2010 07:11:56 +0100
From: =?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Freescale MPC5554 device tree (was: cross-compiling Linux for
	PowerPC e200 core?)
References: <4B934CCA.8030608@freemail.hu>
	<fa686aa41003080934q5d5bebabl7d582d1264da4dcd@mail.gmail.com>
	<4B95458A.4000304@freemail.hu>
	<fa686aa41003081108v31e73660pa817863e5aa73653@mail.gmail.com>
	<4B95F298.5040000@freemail.hu>
	<fa686aa41003082335t5a5d642fi13c81e4b84f7b697@mail.gmail.com>
In-Reply-To: <fa686aa41003082335t5a5d642fi13c81e4b84f7b697@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant Likely wrote:
> 2010/3/9 Németh Márton <nm127@freemail.hu>:
>> Hi,
>> Grant Likely wrote:
>>> 2010/3/8 Németh Márton <nm127@freemail.hu>:
[snip]
>>>> As far as I could find out I'll need to create a device tree as documented in
>>>> the linux/Documentation/powerpc/booting-without-of.txt file.
>>> Yes, you'll need to create a device tree file for the board.  Again,
>>> start from an existing 5200 .dts file.  You won't need very much in it
>>> to get started.  I'd be happy to help you get the structure right.
>> I tried to create a first draft of the deveice tree for MPC5554. It is
>> compilable with dtc. I based this .dts file on Figure 1-1 on page 1-3 and
>> Table 1-2 on page 1-21 of http://www.freescale.com/files/32bit/doc/ref_manual/MPC5553_MPC5554_RM.pdf .
>>
>> I'm not sure about the following points:
>> 1. Where should be the on-chip FLASH described? This memory is read-only from
>>   view of software and can be used to store read-only data or execute code directly
>>   from there.
> 
> Hang it off the xbar node.  Name it flash@<address>, and use
> 'compatible = "fsl,mpc5554-flash";'
> 
>> 2. Should the co-processor (eTPU in this case) also listed in section "cpus"
>>   or not? This co-processor is not able to run code like the e200z6.
> 
> No, this is a device.  Hang it off the peripheral bridge a node.
> 
>> 3. There are three on-chip buses on MPC5554:
>>   - Crossbar Switch (XBAR)
>>   - Peripheral Bridge A (PBRIDGE_A)
>>   - Peripheral Bridge B (PBRIDGE_B)
>>   I used PBRIDGE_A and PRIDGE_B to create two /soc<SOCname> entries. Is this possible?
> 
> the soc5200 naming was poorly chosen when the 5200 device tree was
> written.  Use something like this:
> 
> xbar@<control-regs-base-address> {
>         compatible = "fsl,mpc5554-xbar";
>         #address-cells = <1>;
>         #size-cells = <1>;
>         ranges = <[put the translation ranges in here]>;
>         reg = <address and size of xbar control registers>;
> 
>         bridge@<bridgea-base-address> {
>                 compatible = "fsl,mpc5554-pbridge-a";
>                 #address-cells = <1>;
>                 #size-cells = <1>;
>                 ranges = <[put the translation ranges in here]>;
>                 reg = <address and size of bridge control registers>;
>                 [... child device nodes ...]
>         };
>         bridge@<bridgea-base-address> {
>                 compatible = "fsl,mpc5554-pbridge-b";
>                 #address-cells = <1>;
>                 #size-cells = <1>;
>                 ranges = <[put the translation ranges in here]>;
>                 reg = <address and size of bridge control registers>;
>                 [... child device nodes ...]
>         };
> };
> 
> The idea is to use generic names for the node names, and identify
> exactly what the device is by using the "compatible" property.  Also,
> the aim is to build up a tree describing the interconnection of device
> from the perspective of the OS on the CPU.  ie.  the full physical
> address space is represented by the root node of the tree, and
> everything else hangs off that.
> 
>> 4. There are modules which have multiple instances at different base addresses. These
>>   are DSPI, SCI and FlexCAN. I used the same name for them but with different addresses.
>>   Is this correct?
> 
> yes.
[snip]

Here is the next draft version of the Freescale MPC5554 device tree.

I'm not quite sure whether the memory@40000000 should go under xbar or stay
directly under the root node.

The second problem I faced with was that XBAR covers the whole address range.
However, if I specify "ranges = <0 0x00000000 0x100000000>;" then I get an
error message because of the too big length value:

| DTC: dts->dts  on file "/usr/src/linux/arch/powerpc/boot/dts/mpc5554.dts"
| /usr/src/linux/arch/powerpc/boot/dts/mpc5554.dts:51 literal out of range
| FATAL ERROR: Syntax error parsing input tree

I tried to solve this problem by assuming that leaving out the "ranges = ..."
means the whole range. Is this correct?

Regards,

	Márton Németh
---
From: Márton Németh <nm127@freemail.hu>

Add device tree for Freescale MPC5554.

Signed-off-by: Márton Németh <nm127@freemail.hu>
---
diff -uprN linux-2.6.33.orig/arch/powerpc/boot/dts/mpc5554.dts linux/arch/powerpc/boot/dts/mpc5554.dts
--- linux-2.6.33.orig/arch/powerpc/boot/dts/mpc5554.dts	1970-01-01 01:00:00.000000000 +0100
+++ linux/arch/powerpc/boot/dts/mpc5554.dts	2010-03-11 07:01:29.000000000 +0100
@@ -0,0 +1,188 @@
+/*
+ * Freescale MPC5554 Device Tree Source
+ *
+ * Based on MPC5553/5554 Microcontroller Reference Manual, Rev. 4.0, 04/2007
+ * http://www.freescale.com/files/32bit/doc/ref_manual/MPC5553_MPC5554_RM.pdf
+ *
+ * Copyright 2010 Márton Németh
+ * Márton Németh <nm127@freemail.hu>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/dts-v1/;
+
+/ {
+	model = "MPC5554";
+	compatible = "fsl,MPC5554EVB";		// Freescale MPC5554 Evaluation Board
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,5554@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <0x8000>;	// L1, 32KiB
+			i-cache-size = <0x8000>;	// L1, 32KiB
+			timebase-frequency = <0>;	// from bootloader
+			bus-frequency = <0>;		// from bootloader
+			clock-frequency = <0>;		// from bootloader
+		};
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0x40000000 0x10000>;	// 32KiB internal SRAM
+	};
+
+	xbar@1ff04000 {		// System Bus Crossbar Switch (XBAR)
+		compatible = "fsl,mpc5554-xbar";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		// The full memory range is covered by XBAR
+//		ranges = <0 0x00000000 0x100000000>;
+		reg = <0xfff04000 0x4000>;
+
+		flash@00000000 {	// read-only FLASH
+			compatible = "fsl,mpc5554-flash";
+			reg = <0x00000000 0x200000>;	// 2MiB internal FLASH
+		};
+
+		bridge@c0000000 {
+			compatible = "fsl,mpc5554-pbridge-a";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0xc0000000 0x20000000>;
+			reg = <0xc3f00000 0x4000>;
+
+			fmpll@3f80000 {		// Frequency Modulated PLL
+				compatible = "fsl,mpc5554-fmpll";
+				reg = <0x03f80000 0x4000>;
+			};
+
+			flashconfig@3f88000 {	// Flash Configuration
+				compatible = "fsl,mpc5554-flashconfig";
+				reg = <0x03f88000 0x4000>;
+			};
+
+			siu@3f89000 {		// System Integration Unit
+				compatible = "fsl,mpc5554-siu";
+				reg = <0x03f90000 0x4000>;
+			};
+
+			emios@3fa0000 {		// Modular Timer System
+				compatible = "fsl,mpc5554-emios";
+				reg = <0x03fa0000 0x4000>;
+			};
+
+			etpu@3fc0000 {		// Enhanced Time Processing Unit
+				compatible = "fsl,mpc5554-etpu";
+				reg = <0x03fc0000 0x4000>;
+			};
+
+			etpudata@3fc8000 {	// eTPU Shared Data Memory (Parameter RAM)
+				compatible = "fsl,mpc5554-etpudata";
+				reg = <0x03fc8000 0x4000>;
+			};
+
+			etpudata@3fcc000 {	// eTPU Shared Data Memory (Parameter RAM) mirror
+				compatible = "fsl,mpc5554-etpudata";
+				reg = <0x03fcc000 0x4000>;
+			};
+
+			etpucode@3fd0000 {		// eTPU Shared Code RAM
+				compatible = "fsl,mpc5554-etpucode";
+				reg = <0x03fd0000 0x4000>;
+			};
+		};
+
+		bridge@e0000000 {
+			compatible = "fsl,mpc5554-pbridge-b";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0xe0000000 0x20000000>;
+			reg = <0xfff00000 0x4000>;
+
+			ecsm@1ff40000 {		// Error Correction Status Module (ECSM)
+				compatible = "fsl,mpc5554-ecsm";
+				reg = <0x1ff40000 0x4000>;
+			};
+
+			edma@1ff44000 {		// Enhanced DMA Controller (eDMA)
+				compatible = "fsl,mpc5554-edma";
+				reg = <0x1ff44000 0x4000>;
+			};
+
+			intc@1ff48000 {		// Interrupt Controller (INTC)
+				compatible = "fsl,mpc5554-intc";
+				reg = <0x1ff48000 0x4000>;
+			};
+
+			eqadc@1ff80000 {	// Enhanced Queued Analog-to-Digital Converter (eQADC)
+				compatible = "fsl,mpc5554-eqacd";
+				reg = <0x1ff80000 0x4000>;
+			};
+
+			dspi@1ff90000 {		// Deserial Serial Peripheral Interface (DSPI_A)
+				compatible = "fsl,mpc5554-dspi";
+				reg = <0x1ff90000 0x4000>;
+			};
+
+			dspi@1ff94000 {		// Deserial Serial Peripheral Interface (DSPI_B)
+				compatible = "fsl,mpc5554-dspi";
+				reg = <0x1ff94000 0x4000>;
+			};
+
+			dspi@1ff98000 {		// Deserial Serial Peripheral Interface (DSPI_C)
+				compatible = "fsl,mpc5554-dspi";
+				reg = <0x1ff98000 0x4000>;
+			};
+
+			dspi@1ff9c000 {		// Deserial Serial Peripheral Interface (DSPI_D)
+				compatible = "fsl,mpc5554-dspi";
+				reg = <0x1ff9c000 0x4000>;
+			};
+
+			sci@1ffb0000 {		// Serial Communications Interface (SCI_A)
+				compatible = "fsl,mpc5554-sci";
+				reg = <0x1ffb0000 0x4000>;
+			};
+
+			sci@1ffb4000 {		// Serial Communications Interface (SCI_A)
+				compatible = "fsl,mpc5554-sci";
+				reg = <0x1ffb4000 0x4000>;
+			};
+
+			can@1ffc0000 {		// Controller Area Network (FlexCAN_A)
+				compatible = "fsl,mpc5554-flexcan";
+				reg = <0x1ffc0000 0x4000>;
+			};
+
+			can@1ffc4000 {		// Controller Area Network (FlexCAN_B)
+				compatible = "fsl,mpc5554-flexcan";
+				reg = <0x1ffc4000 0x4000>;
+			};
+
+			can@1ffc8000 {		// Controller Area Network (FlexCAN_C)
+				compatible = "fsl,mpc5554-flexcan";
+				reg = <0x1ffc8000 0x4000>;
+			};
+
+			bam@1fffc000 {		// Boot Assist Module (BAM)
+				compatible = "fsl,mpc5554-bam";
+				reg = <0x1fffc000 0x4000>;
+			};
+
+		};
+
+	};
+
+};
