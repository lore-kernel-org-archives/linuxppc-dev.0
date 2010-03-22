Return-Path: <nm127@freemail.hu>
Received: from relay02.digicable.hu (relay02.digicable.hu [92.249.128.188])
	by ozlabs.org (Postfix) with ESMTP id 88223B7CFB
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Mar 2010 17:29:06 +1100 (EST)
Message-ID: <4BA70E28.9080007@freemail.hu>
Date: Mon, 22 Mar 2010 07:28:56 +0100
From: =?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Freescale MPC5554 device tree (was: cross-compiling Linux for
	PowerPC e200 core?)
References: <4B934CCA.8030608@freemail.hu> <4B95458A.4000304@freemail.hu>
	<fa686aa41003081108v31e73660pa817863e5aa73653@mail.gmail.com>
	<4B95F298.5040000@freemail.hu>
	<fa686aa41003082335t5a5d642fi13c81e4b84f7b697@mail.gmail.com>
	<4B9889AC.4080309@freemail.hu> <20100311062331.GI11655@yookeroo>
	<4B99DE95.8010304@freemail.hu>
	<fa686aa41003120414j48825e7cr952336703fe03b04@mail.gmail.com>
	<4B9B7E0A.8090703@freemail.hu>
	<fa686aa41003171202p677bc14g25a6ac38f879ddf1@mail.gmail.com>
In-Reply-To: <fa686aa41003171202p677bc14g25a6ac38f879ddf1@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Grant,

thanks for the comments, I solved some of the points you mentioned. I need some
more time to work on the others. In the meantime I send the intermediate version.

Grant Likely wrote:
> 2010/3/13 Németh Márton <nm127@freemail.hu>:
[...]
>> +       memory@40000000 {
>> +               device_type = "memory";
>> +               reg = <0x40000000 0x10000>;     // 32KiB internal SRAM
>> +       };
> 
> Oh.... this is the small SRAM.  yeah, you should move this under the
> appropriate bridge node, remove the device_type property, and add a
> compatible property.  Memory nodes at the root like this are used to
> describe what is basically main memory (what Linux will execute out
> of).  You'll want a new memory node for the external ram hooked up to
> the 5554.

Yes, it is the small one (actually 64KiB, I corrected the comment also).
I added the external memory of the MPC5554DEMO evaluation board which has
a size of 512KiB.

Would it be possible to program the uncompressed kernel to the FLASH so
it can run directly from there? I guess for the code and the constant sections
the FLASH could be a good place. Then cstart has to initialize the initialized
variables by copying data from FLASH to RAM and fill the BSS area with zero.

[...]
>> +                       siu@3f89000 {           // System Integration Unit
>> +                               compatible = "fsl,mpc5554-siu";
>> +                               reg = <0x03f90000 0x4000>;
>> +                               interrupts = <45 1      // External Interrupt Overrun 0-15
>> +                                             46 1      // External Interrupt 0
>> +                                             47 1      // External Interrupt 1
>> +                                             48 1      // External Interrupt 2
>> +                                             49 1      // External Interrupt 3
>> +                                             50 1>;    // External Interrupt 4-15
>> +                       };
> 
> This doesn't look quite right.... /me goes to look at the 5554
> reference manual....
> 
> Okay, so all the external IRQs go through the SIU then, even though
> the first 4 get passed straight through to the intc?  And I see that
> all the level/edge sensing and masking/acknowledging is done at the
> SIU level, not the intc level, correct?  So, what you effectively have
> is the SIU is *another* interrupt controller that is cascaded to the
> intc.  Therefore you need to add the following to this node:
> 
> #interrupt-cells = <2>;   // cell1:extirq#, cell2:level/edge flags
> interrupt-controller;
> 
> Also give the node a label so that nodes for external devices can
> reference it for hooking up external irqs by overriding the top-level
> interrupt-parent property.
> 
> Also, it would appear that intc interrupts don't have any level/edge
> configuration associated with them.  They are either asserted, or they
> are not, correct?  At the moment you're specifying every intc
> interrupt with 2 cells, and the 2nd cell is always '1'.  I think you
> can change #interrupt-cells to <1> in the intc node and drop the '1'
> everywhere.
> 
> When you write your intc driver, you'll also need to write the
> cascaded driver for the external IRQs.

I tried to solve this point but I'm not quite sure whether the SIU interrupt
numbers shall be kept on the siu@3f89000 node or not.

>> +                       emios@3fa0000 {         // Modular Timer System
>> +                               compatible = "fsl,mpc5554-emios";
>> +                               reg = <0x03fa0000 0x4000>;
>> +                               interrupts = <51 1      // Channel 0
>> +                                             52 1      // Channel 1
>> +                                             53 1      // Channel 2
>> +                                             54 1      // Channel 3
>> +                                             55 1      // Channel 4
>> +                                             56 1      // Channel 5
>> +                                             57 1      // Channel 6
>> +                                             58 1      // Channel 7
>> +                                             59 1      // Channel 8
>> +                                             60 1      // Channel 9
>> +                                             61 1      // Channel 10
>> +                                             62 1      // Channel 11
>> +                                             63 1      // Channel 12
>> +                                             64 1      // Channel 13
>> +                                             65 1      // Channel 14
>> +                                             66 1      // Channel 15
>> +                                             202 1     // Channel 16
>> +                                             203 1     // Channel 17
>> +                                             204 1     // Channel 18
>> +                                             205 1     // Channel 19
>> +                                             206 1     // Channel 20
>> +                                             207 1     // Channel 21
>> +                                             208 1     // Channel 22
>> +                                             209 1>;   // Channel 23
> 
> These long lists bother me, but looking at the manual they seem to
> describe the actual hardware architecture, so I think they are
> probably fine.  But you may want to compact your formatting somewhat.
> You can probably list more than one channel per
> source line in the file.
>
> Ditto through the rest of the file.

I would keep the list like this because in this case it is easy to find
which comment belongs to which interrupt number. Otherwise one would need
to count the interrupt numbers and the comment to find out which number match
which comment.

>> +                       etpu@3fc0000 {          // Enhanced Time Processing Unit
>> +                               compatible = "fsl,mpc5554-etpu";
>> +                               reg = <0x03fc0000 0x4000>;
>> +                               interrupts = <67 1      // Global Exception
>> +                                             68 1      // A Channel 0
>> +                                             69 1      // A Channel 1
>> +                                             70 1      // A Channel 2
>> +                                             71 1      // A Channel 3
>> +                                             72 1      // A Channel 4
>> +                                             73 1      // A Channel 5
>> +                                             74 1      // A Channel 6
>> +                                             75 1      // A Channel 7
>> +                                             76 1      // A Channel 8
>> +                                             77 1      // A Channel 9
>> +                                             78 1      // A Channel 10
>> +                                             79 1      // A Channel 11
>> +                                             80 1      // A Channel 12
>> +                                             81 1      // A Channel 13
>> +                                             82 1      // A Channel 14
>> +                                             83 1      // A Channel 15
>> +                                             84 1      // A Channel 16
>> +                                             85 1      // A Channel 17
>> +                                             86 1      // A Channel 18
>> +                                             87 1      // A Channel 19
>> +                                             88 1      // A Channel 20
>> +                                             89 1      // A Channel 21
>> +                                             90 1      // A Channel 22
>> +                                             91 1      // A Channel 23
>> +                                             92 1      // A Channel 24
>> +                                             93 1      // A Channel 25
>> +                                             94 1      // A Channel 26
>> +                                             95 1      // A Channel 27
>> +                                             96 1      // A Channel 28
>> +                                             97 1      // A Channel 29
>> +                                             98 1      // A Channel 30
>> +                                             99 1      // A Channel 31
>> +                                             243 1     // B Channel 0
>> +                                             244 1     // B Channel 1
>> +                                             245 1     // B Channel 2
>> +                                             246 1     // B Channel 3
>> +                                             247 1     // B Channel 4
>> +                                             248 1     // B Channel 5
>> +                                             249 1     // B Channel 6
>> +                                             250 1     // B Channel 7
>> +                                             251 1     // B Channel 8
>> +                                             252 1     // B Channel 9
>> +                                             253 1     // B Channel 10
>> +                                             254 1     // B Channel 11
>> +                                             255 1     // B Channel 12
>> +                                             256 1     // B Channel 13
>> +                                             257 1     // B Channel 14
>> +                                             258 1     // B Channel 15
>> +                                             259 1     // B Channel 16
>> +                                             260 1     // B Channel 17
>> +                                             261 1     // B Channel 18
>> +                                             262 1     // B Channel 19
>> +                                             263 1     // B Channel 20
>> +                                             264 1     // B Channel 21
>> +                                             265 1     // B Channel 22
>> +                                             266 1     // B Channel 23
>> +                                             267 1     // B Channel 24
>> +                                             268 1     // B Channel 25
>> +                                             269 1     // B Channel 26
>> +                                             270 1     // B Channel 27
>> +                                             271 1     // B Channel 28
>> +                                             272 1     // B Channel 29
>> +                                             273 1     // B Channel 30
>> +                                             274 1>;   // B Channel 31
> 
> Are A and B two instances of the same hardware block?  Consider having
> a subnode for each instance to give some logical separation to this
> list and associate register ranges with instances.  Doing it that way
> also makes it easier for external device nodes to describe an
> attachment to a particular channel.

I'll try to do this later, I need some more time to do this.

> 
>> +                       };
>> +
>> +                       etpudata@3fc8000 {      // eTPU Shared Data Memory (Parameter RAM)
>> +                               compatible = "fsl,mpc5554-etpudata";
>> +                               reg = <0x03fc8000 0x4000>;
>> +                       };
>> +
>> +                       etpudata@3fcc000 {      // eTPU Shared Data Memory (Parameter RAM) mirror
>> +                               compatible = "fsl,mpc5554-etpudata";
>> +                               reg = <0x03fcc000 0x4000>;
>> +                       };
>> +
>> +                       etpucode@3fd0000 {              // eTPU Shared Code RAM
>> +                               compatible = "fsl,mpc5554-etpucode";
>> +                               reg = <0x03fd0000 0x4000>;
>> +                       };
> 
> Should all this etpu stuff be part of the etpu node?
> 
> This looks like it is getting close.  Once you've got a version that
> looks good to everyone, you also need to document what the new
> bindings mean.  Essentially this task involves writing down all the
> new compatible property values that you've defined, what device each
> one describes, and what properties/subnodes are expected for each new
> compatible value.  Documentation currently goes in the
> Documentation/powerpc/dts-bindings directory, and you can see lots of
> examples there.  (However, I'm hoping to moving it to
> http://devicetree.org in the near future so it can be shared by other
> OSes.  I've currently got a test site up at http://fdt.secretlab.ca).
> 
> The rule is that we will not merge drivers using new OF bindings until
> those bindings have been documented and reviewed.

The documentation is still missing from this version.

Regards,

	Márton Németh

---
From: Márton Németh <nm127@freemail.hu>

Add device tree for Freescale MPC5554.

Signed-off-by: Márton Németh <nm127@freemail.hu>
---
diff -uprN linux-2.6.33.orig/arch/powerpc/boot/dts/mpc5554.dts linux-2.6.33/arch/powerpc/boot/dts/mpc5554.dts
--- linux-2.6.33.orig/arch/powerpc/boot/dts/mpc5554.dts	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.33/arch/powerpc/boot/dts/mpc5554.dts	2010-03-22 07:09:02.000000000 +0100
@@ -0,0 +1,488 @@
+/*
+ * Freescale MPC5554 Device Tree Source
+ *
+ * Based on MPC5553/5554 Microcontroller Reference Manual, Rev. 4.0, 04/2007
+ * http://www.freescale.com/files/32bit/doc/ref_manual/MPC5553_MPC5554_RM.pdf
+ *  - Block Diagram: page 1-3, Figure 1-1
+ *  - Memory Map: page 1-21, Table 1-2
+ *  - Interrupt Request Sources: page 10-16, Table 10-9
+ *
+ * This device tree also contains external components found on MPC5554DEMO
+ * http://www.axman.com/files/MPC5554DEMO_man_G.pdf
+ * http://www.axman.com/files/MPC5554DEMO_SCH_G.pdf
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
+	interrupt-parent = <&intc>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "PowerPC,5554", "fsl,mpc5554-e200z6", "fsl,powerpc-e200z6";
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
+	memory@20000000 {
+		device_type = "memory";
+		reg = <0x20000000 0x80000>;	// 512KiB external SRAM: ISSI IS61SF12832
+		// CS0 or CS1 selectable by the SRAM_SEL jumper
+	};
+
+	xbar@fff04000 {		// System Bus Crossbar Switch (XBAR)
+		compatible = "fsl,mpc5554-xbar";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		// The full memory range is covered by XBAR
+		ranges;
+		reg = <0xfff04000 0x4000>;
+
+		flash@0 {	// read-only FLASH
+			compatible = "fsl,mpc5554-flash";
+			reg = <0x00000000 0x200000>;	// 2MiB internal FLASH
+		};
+
+		memory@40000000 {
+			compatible = "fsl,mpc5554-sram";
+			reg = <0x40000000 0x10000>;	// 64KiB internal SRAM
+		};
+
+		bridge@c3f00000 {
+			compatible = "fsl,mpc5554-pbridge-a";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0xc0000000 0x20000000>;
+			reg = <0xc3f00000 0x4000>;
+
+			fmpll@3f80000 {		// Frequency Modulated PLL
+				compatible = "fsl,mpc5554-fmpll";
+				reg = <0x03f80000 0x4000>;
+				interrupts = <43	// Loss of Clock
+					      44>;	// Loss of Lock
+			};
+
+			flashconfig@3f88000 {	// Flash Configuration
+				compatible = "fsl,mpc5554-flashconfig";
+				reg = <0x03f88000 0x4000>;
+			};
+
+			siuintc: siu@3f89000 {		// System Integration Unit
+				compatible = "fsl,mpc5554-siu";
+				reg = <0x03f90000 0x4000>;
+
+				// SIU is an interrupt controller by means that it handles
+				// the external interrupts
+				#interrupt-cells = <2>;   // cell 1: extirq#, cell 2: level/edge flags
+				interrupt-controller;
+				interrupts = <45 1	// External Interrupt Overrun 0-15
+					      46 1	// External Interrupt 0
+					      47 1	// External Interrupt 1
+					      48 1	// External Interrupt 2
+					      49 1	// External Interrupt 3
+					      50 1>;	// External Interrupt 4-15
+			};
+
+			emios@3fa0000 {		// Modular Timer System
+				compatible = "fsl,mpc5554-emios";
+				reg = <0x03fa0000 0x4000>;
+				interrupts = <51	// Channel 0
+					      52	// Channel 1
+					      53	// Channel 2
+					      54	// Channel 3
+					      55	// Channel 4
+					      56	// Channel 5
+					      57	// Channel 6
+					      58	// Channel 7
+					      59	// Channel 8
+					      60	// Channel 9
+					      61	// Channel 10
+					      62	// Channel 11
+					      63	// Channel 12
+					      64	// Channel 13
+					      65	// Channel 14
+					      66	// Channel 15
+					      202	// Channel 16
+					      203	// Channel 17
+					      204	// Channel 18
+					      205	// Channel 19
+					      206	// Channel 20
+					      207	// Channel 21
+					      208	// Channel 22
+					      209>;	// Channel 23
+			};
+
+			etpu@3fc0000 {		// Enhanced Time Processing Unit
+				compatible = "fsl,mpc5554-etpu";
+				reg = <0x03fc0000 0x4000>;
+				interrupts = <67	// Global Exception
+					      68	// A Channel 0
+					      69	// A Channel 1
+					      70	// A Channel 2
+					      71	// A Channel 3
+					      72	// A Channel 4
+					      73	// A Channel 5
+					      74	// A Channel 6
+					      75	// A Channel 7
+					      76	// A Channel 8
+					      77	// A Channel 9
+					      78	// A Channel 10
+					      79	// A Channel 11
+					      80	// A Channel 12
+					      81	// A Channel 13
+					      82	// A Channel 14
+					      83	// A Channel 15
+					      84	// A Channel 16
+					      85	// A Channel 17
+					      86	// A Channel 18
+					      87	// A Channel 19
+					      88	// A Channel 20
+					      89	// A Channel 21
+					      90	// A Channel 22
+					      91	// A Channel 23
+					      92	// A Channel 24
+					      93	// A Channel 25
+					      94	// A Channel 26
+					      95	// A Channel 27
+					      96	// A Channel 28
+					      97	// A Channel 29
+					      98	// A Channel 30
+					      99	// A Channel 31
+					      243	// B Channel 0
+					      244	// B Channel 1
+					      245	// B Channel 2
+					      246	// B Channel 3
+					      247	// B Channel 4
+					      248	// B Channel 5
+					      249	// B Channel 6
+					      250	// B Channel 7
+					      251	// B Channel 8
+					      252	// B Channel 9
+					      253	// B Channel 10
+					      254	// B Channel 11
+					      255	// B Channel 12
+					      256	// B Channel 13
+					      257	// B Channel 14
+					      258	// B Channel 15
+					      259	// B Channel 16
+					      260	// B Channel 17
+					      261	// B Channel 18
+					      262	// B Channel 19
+					      263	// B Channel 20
+					      264	// B Channel 21
+					      265	// B Channel 22
+					      266	// B Channel 23
+					      267	// B Channel 24
+					      268	// B Channel 25
+					      269	// B Channel 26
+					      270	// B Channel 27
+					      271	// B Channel 28
+					      272	// B Channel 29
+					      273	// B Channel 30
+					      274>;	// B Channel 31
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
+		bridge@fff00000 {
+			compatible = "fsl,mpc5554-pbridge-b";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0xe0000000 0x20000000>;
+			reg = <0xfff00000 0x4000>;
+
+			ecsm@fff40000 {		// Error Correction Status Module (ECSM)
+				compatible = "fsl,mpc5554-ecsm";
+				reg = <0xfff40000 0x4000>;
+				interrupts = <8	// Software Watchdog Interrupt
+					      9>;	// Combined: Internal SRAM Non-Correctable Error, Flash Non-Correctable Error
+			};
+
+			edma@fff44000 {		// Enhanced DMA Controller (eDMA)
+				compatible = "fsl,mpc5554-edma";
+				reg = <0xfff44000 0x4000>;
+				interrupts = <10	// Channel Error 0-31
+					      11	// Channel 0
+					      12	// Channel 1
+					      13	// Channel 2
+					      14	// Channel 3
+					      15	// Channel 4
+					      16	// Channel 5
+					      17	// Channel 6
+					      18	// Channel 7
+					      19	// Channel 8
+					      20	// Channel 9
+					      21	// Channel 10
+					      22	// Channel 11
+					      23	// Channel 12
+					      24	// Channel 13
+					      25	// Channel 14
+					      26	// Channel 15
+					      27	// Channel 16
+					      28	// Channel 17
+					      29	// Channel 18
+					      30	// Channel 19
+					      31	// Channel 20
+					      32	// Channel 21
+					      33	// Channel 22
+					      34	// Channel 23
+					      35	// Channel 24
+					      36	// Channel 25
+					      37	// Channel 26
+					      38	// Channel 27
+					      39	// Channel 28
+					      40	// Channel 29
+					      41	// Channel 30
+					      42	// Channel 31
+					      210	// Channel Error 32-63
+					      211	// Channel 32
+					      212	// Channel 33
+					      213	// Channel 34
+					      214	// Channel 35
+					      215	// Channel 36
+					      216	// Channel 37
+					      217	// Channel 38
+					      218	// Channel 39
+					      219	// Channel 40
+					      220	// Channel 41
+					      221	// Channel 42
+					      222	// Channel 43
+					      223	// Channel 44
+					      224	// Channel 45
+					      225	// Channel 46
+					      226	// Channel 47
+					      227	// Channel 48
+					      228	// Channel 49
+					      229	// Channel 50
+					      230	// Channel 51
+					      231	// Channel 52
+					      232	// Channel 53
+					      233	// Channel 54
+					      234	// Channel 55
+					      235	// Channel 56
+					      236	// Channel 57
+					      237	// Channel 58
+					      238	// Channel 59
+					      239	// Channel 60
+					      240	// Channel 61
+					      241	// Channel 62
+					      242>;	// Channel 63
+			};
+
+			intc: intc@fff48000 {		// Interrupt Controller (INTC)
+				compatible = "fsl,mpc5554-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				reg = <0xfff48000 0x4000>;
+			};
+
+			eqadc@fff80000 {	// Enhanced Queued Analog-to-Digital Converter (eQADC)
+				compatible = "fsl,mpc5554-eqacd";
+				reg = <0xfff80000 0x4000>;
+				interrupts = <100	// Combined: Trigger Overrun, Receive FIFO Overflow, Command FIFO Underflow
+					      101	// Command FIFO 0 Non-Coherency
+					      102	// Command FIFO 0 Pause
+					      103	// Command FIFO 0 End of Queue
+					      104	// Command FIFO 0 Fill
+					      105	// Command FIFO 0 Drain
+					      106	// Command FIFO 1 Non-Coherency
+					      107	// Command FIFO 1 Pause
+					      108	// Command FIFO 1 End of Queue
+					      109	// Command FIFO 1 Fill
+					      111	// Command FIFO 1 Drain
+					      111	// Command FIFO 2 Non-Coherency
+					      112	// Command FIFO 2 Pause
+					      113	// Command FIFO 2 End of Queue
+					      114	// Command FIFO 2 Fill
+					      115	// Command FIFO 2 Drain
+					      116	// Command FIFO 3 Non-Coherency
+					      117	// Command FIFO 3 Pause
+					      118	// Command FIFO 3 End of Queue
+					      119	// Command FIFO 3 Fill
+					      120	// Command FIFO 3 Drain
+					      121	// Command FIFO 4 Non-Coherency
+					      122	// Command FIFO 4 Pause
+					      123	// Command FIFO 4 End of Queue
+					      124	// Command FIFO 4 Fill
+					      125	// Command FIFO 4 Drain
+					      126	// Command FIFO 5 Non-Coherency
+					      127	// Command FIFO 5 Pause
+					      128	// Command FIFO 5 End of Queue
+					      129	// Command FIFO 5 Fill
+					      130>;	// Command FIFO 5 Drain
+			};
+
+			dspi@fff90000 {		// Deserial Serial Peripheral Interface (DSPI_A)
+				compatible = "fsl,mpc5554-dspi";
+				reg = <0xfff90000 0x4000>;
+				interrupts = <275	// Combined: Transmit FIFO Underflow, Receive FIFO Overflow
+					      276	// Transmit FIFO End of Queue
+					      277	// Transmit FIFO Fill Flag
+					      278	// Transfer Complete
+					      279>;	// Receive FIFO Drain
+			};
+
+			dspi@fff94000 {		// Deserial Serial Peripheral Interface (DSPI_B)
+				compatible = "fsl,mpc5554-dspi";
+				reg = <0xfff94000 0x4000>;
+				interrupts = <131	// Combined: Transmit FIFO Underflow, Receive FIFO Overflow
+					      132	// Transmit FIFO End of Queue
+					      133	// Transmit FIFO Fill Flag
+					      134	// Transfer Complete
+					      135>;	// Receive FIFO Drain
+			};
+
+			dspi@fff98000 {		// Deserial Serial Peripheral Interface (DSPI_C)
+				compatible = "fsl,mpc5554-dspi";
+				reg = <0xfff98000 0x4000>;
+				interrupts = <136	// Combined: Transmit FIFO Underflow, Receive FIFO Overflow
+					      137	// Transmit FIFO End of Queue
+					      138	// Transmit FIFO Fill Flag
+					      139	// Transfer Complete
+					      140>;	// Receive FIFO Drain
+			};
+
+			dspi@fff9c000 {		// Deserial Serial Peripheral Interface (DSPI_D)
+				compatible = "fsl,mpc5554-dspi";
+				reg = <0xfff9c000 0x4000>;
+				interrupts = <141	// Combined: Transmit FIFO Underflow, Receive FIFO Overflow
+					      142	// Transmit FIFO End of Queue
+					      143	// Transmit FIFO Fill Flag
+					      144	// Transfer Complete
+					      145>;	// Receive FIFO Drain
+			};
+
+			esci@fffb0000 {		// Serial Communications Interface (SCI_A)
+				compatible = "fsl,mpc5554-esci";
+				reg = <0xfffb0000 0x4000>;
+				interrupts = <146>;	// Combined request for all SCI_A interrupts
+			};
+
+			esci@fffb4000 {		// Serial Communications Interface (SCI_B)
+				compatible = "fsl,mpc5554-esci";
+				reg = <0xfffb4000 0x4000>;
+				interrupts = <149>;	// Combined request for all SCI_A interrupts
+			};
+
+			can@fffc0000 {		// Controller Area Network (FlexCAN_A)
+				compatible = "fsl,mpc5554-flexcan";
+				reg = <0xfffc0000 0x4000>;
+				interrupts = <152	// Bus off
+					      153	// Error
+					      155	// Buffer 0
+					      156	// Buffer 1
+					      157	// Buffer 2
+					      158	// Buffer 3
+					      159	// Buffer 4
+					      160	// Buffer 5
+					      161	// Buffer 6
+					      162	// Buffer 7
+					      163	// Buffer 8
+					      164	// Buffer 9
+					      165	// Buffer 10
+					      166	// Buffer 11
+					      167	// Buffer 12
+					      168	// Buffer 13
+					      169	// Buffer 14
+					      170	// Buffer 15
+					      171	// Buffers 16-31
+					      172>;	// Buffers 32-63
+			};
+
+			can@fffc4000 {		// Controller Area Network (FlexCAN_B)
+				compatible = "fsl,mpc5554-flexcan";
+				reg = <0xfffc4000 0x4000>;
+				interrupts = <280	// Bus off
+					      281	// Error
+					      283	// Buffer 0
+					      284	// Buffer 1
+					      285	// Buffer 2
+					      286	// Buffer 3
+					      287	// Buffer 4
+					      288	// Buffer 5
+					      289	// Buffer 6
+					      290	// Buffer 7
+					      291	// Buffer 8
+					      292	// Buffer 9
+					      293	// Buffer 10
+					      294	// Buffer 11
+					      295	// Buffer 12
+					      296	// Buffer 13
+					      297	// Buffer 14
+					      298	// Buffer 15
+					      299	// Buffers 16-31
+					      300>;	// Buffers 32-63
+			};
+
+			can@fffc8000 {		// Controller Area Network (FlexCAN_C)
+				compatible = "fsl,mpc5554-flexcan";
+				reg = <0xfffc8000 0x4000>;
+				interrupts = <173	// Bus off
+					      174	// Error
+					      176	// Buffer 0
+					      177	// Buffer 1
+					      178	// Buffer 2
+					      179	// Buffer 3
+					      180	// Buffer 4
+					      181	// Buffer 5
+					      182	// Buffer 6
+					      183	// Buffer 7
+					      184	// Buffer 8
+					      185	// Buffer 9
+					      186	// Buffer 10
+					      187	// Buffer 11
+					      188	// Buffer 12
+					      189	// Buffer 13
+					      190	// Buffer 14
+					      191	// Buffer 15
+					      192	// Buffers 16-31
+					      193>;	// Buffers 32-63
+			};
+
+			bam@ffffc000 {		// Boot Assist Module (BAM)
+				compatible = "fsl,mpc5554-bam";
+				reg = <0xffffc000 0x4000>;
+			};
+
+		};
+
+	};
+
+};
