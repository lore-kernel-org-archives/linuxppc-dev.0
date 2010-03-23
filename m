Return-Path: <nm127@freemail.hu>
Received: from relay01.digicable.hu (relay01.digicable.hu [92.249.128.189])
	by ozlabs.org (Postfix) with ESMTP id D7896B7CEE
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Mar 2010 16:45:47 +1100 (EST)
Message-ID: <4BA85584.2000906@freemail.hu>
Date: Tue, 23 Mar 2010 06:45:40 +0100
From: =?windows-1252?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Freescale MPC5554 device tree (was: cross-compiling Linux for
	PowerPC e200 core?)
References: <4B934CCA.8030608@freemail.hu> <4B95F298.5040000@freemail.hu>
	<fa686aa41003082335t5a5d642fi13c81e4b84f7b697@mail.gmail.com>
	<4B9889AC.4080309@freemail.hu> <20100311062331.GI11655@yookeroo>
	<4B99DE95.8010304@freemail.hu>
	<fa686aa41003120414j48825e7cr952336703fe03b04@mail.gmail.com>
	<4B9B7E0A.8090703@freemail.hu>
	<fa686aa41003171202p677bc14g25a6ac38f879ddf1@mail.gmail.com>
	<4BA70E28.9080007@freemail.hu>
	<fa686aa41003220759m438472efra2b889e54c73aef1@mail.gmail.com>
In-Reply-To: <fa686aa41003220759m438472efra2b889e54c73aef1@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
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

Grant Likely wrote:
> 2010/3/22 Németh Márton <nm127@freemail.hu>:
>> Hi Grant,
>>
>> thanks for the comments, I solved some of the points you mentioned. I need some
>> more time to work on the others. In the meantime I send the intermediate version.
>>
>> Grant Likely wrote:
>>> 2010/3/13 Németh Márton <nm127@freemail.hu>:
>> [...]
>>>> +       memory@40000000 {
>>>> +               device_type = "memory";
>>>> +               reg = <0x40000000 0x10000>;     // 32KiB internal SRAM
>>>> +       };
>>> Oh.... this is the small SRAM.  yeah, you should move this under the
>>> appropriate bridge node, remove the device_type property, and add a
>>> compatible property.  Memory nodes at the root like this are used to
>>> describe what is basically main memory (what Linux will execute out
>>> of).  You'll want a new memory node for the external ram hooked up to
>>> the 5554.
>> Yes, it is the small one (actually 64KiB, I corrected the comment also).
>> I added the external memory of the MPC5554DEMO evaluation board which has
>> a size of 512KiB.
> 
> Yikes.  Half a meg is tiny for running Linux.
> 
>> Would it be possible to program the uncompressed kernel to the FLASH so
>> it can run directly from there? I guess for the code and the constant sections
>> the FLASH could be a good place. Then cstart has to initialize the initialized
>> variables by copying data from FLASH to RAM and fill the BSS area with zero.
> 
> Hmmm.  I don't know if anyone has kernel execute in place (XIP)
> working on PowerPC.

I found some promising links for XIP on PowerPC:
 - XIP for PowerQUICC™I 8xx: http://www.denx.de/wiki/bin/view/DULG/ConfigureLinuxForXIP
 - XIP on Arctic III PowerPC board: http://simplemachines.it/xip/KernelXIP.html#head-3d70ff3a6d5599f6f98f1d4b4becc9271310967d

>> [...]
>>>> +                       siu@3f89000 {           // System Integration Unit
>>>> +                               compatible = "fsl,mpc5554-siu";
>>>> +                               reg = <0x03f90000 0x4000>;
>>>> +                               interrupts = <45 1      // External Interrupt Overrun 0-15
>>>> +                                             46 1      // External Interrupt 0
>>>> +                                             47 1      // External Interrupt 1
>>>> +                                             48 1      // External Interrupt 2
>>>> +                                             49 1      // External Interrupt 3
>>>> +                                             50 1>;    // External Interrupt 4-15
>>>> +                       };
>>> This doesn't look quite right.... /me goes to look at the 5554
>>> reference manual....
>>>
>>> Okay, so all the external IRQs go through the SIU then, even though
>>> the first 4 get passed straight through to the intc?  And I see that
>>> all the level/edge sensing and masking/acknowledging is done at the
>>> SIU level, not the intc level, correct?  So, what you effectively have
>>> is the SIU is *another* interrupt controller that is cascaded to the
>>> intc.  Therefore you need to add the following to this node:
>>>
>>> #interrupt-cells = <2>;   // cell1:extirq#, cell2:level/edge flags
>>> interrupt-controller;
>>>
>>> Also give the node a label so that nodes for external devices can
>>> reference it for hooking up external irqs by overriding the top-level
>>> interrupt-parent property.
>>>
>>> Also, it would appear that intc interrupts don't have any level/edge
>>> configuration associated with them.  They are either asserted, or they
>>> are not, correct?  At the moment you're specifying every intc
>>> interrupt with 2 cells, and the 2nd cell is always '1'.  I think you
>>> can change #interrupt-cells to <1> in the intc node and drop the '1'
>>> everywhere.
>>>
>>> When you write your intc driver, you'll also need to write the
>>> cascaded driver for the external IRQs.
>> I tried to solve this point but I'm not quite sure whether the SIU interrupt
>> numbers shall be kept on the siu@3f89000 node or not.
> 
> Yes, you'll want the irq numbers to remain in the siu node because
> those are the 'cascade' irqs that the siu raises when the external
> irqs are asserted.
> 
>>>> +                       emios@3fa0000 {         // Modular Timer System
>>>> +                               compatible = "fsl,mpc5554-emios";
>>>> +                               reg = <0x03fa0000 0x4000>;
>>>> +                               interrupts = <51 1      // Channel 0
>>>> +                                             52 1      // Channel 1
>>>> +                                             53 1      // Channel 2
>>>> +                                             54 1      // Channel 3
>>>> +                                             55 1      // Channel 4
>>>> +                                             56 1      // Channel 5
>>>> +                                             57 1      // Channel 6
>>>> +                                             58 1      // Channel 7
>>>> +                                             59 1      // Channel 8
>>>> +                                             60 1      // Channel 9
>>>> +                                             61 1      // Channel 10
>>>> +                                             62 1      // Channel 11
>>>> +                                             63 1      // Channel 12
>>>> +                                             64 1      // Channel 13
>>>> +                                             65 1      // Channel 14
>>>> +                                             66 1      // Channel 15
>>>> +                                             202 1     // Channel 16
>>>> +                                             203 1     // Channel 17
>>>> +                                             204 1     // Channel 18
>>>> +                                             205 1     // Channel 19
>>>> +                                             206 1     // Channel 20
>>>> +                                             207 1     // Channel 21
>>>> +                                             208 1     // Channel 22
>>>> +                                             209 1>;   // Channel 23
>>> These long lists bother me, but looking at the manual they seem to
>>> describe the actual hardware architecture, so I think they are
>>> probably fine.  But you may want to compact your formatting somewhat.
>>> You can probably list more than one channel per
>>> source line in the file.
>>>
>>> Ditto through the rest of the file.
>> I would keep the list like this because in this case it is easy to find
>> which comment belongs to which interrupt number. Otherwise one would need
>> to count the interrupt numbers and the comment to find out which number match
>> which comment.
> 
> You could do it in this style to keep the verbosity down:
> 
>       interrupts = <51 52 53 54 55 56 57 58  // Channels 0-7
>                     59 60 61 62 63 64 65 66  // Channels 8-15
>                     202 203 204 205 206 207 208 209>;  // Channel 16-23
> 

I compacted the different channel interrupt lists as you proposed.

The eTPU related nodes still needs improvement.

Regards,

	Márton Németh
---
From: Márton Németh <nm127@freemail.hu>

Add device tree for Freescale MPC5554.

Signed-off-by: Márton Németh <nm127@freemail.hu>
---
diff -uprN linux-2.6.33.orig/arch/powerpc/boot/dts/mpc5554.dts linux-2.6.33/arch/powerpc/boot/dts/mpc5554.dts
--- linux-2.6.33.orig/arch/powerpc/boot/dts/mpc5554.dts	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.33/arch/powerpc/boot/dts/mpc5554.dts	2010-03-23 06:39:37.000000000 +0100
@@ -0,0 +1,313 @@
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
+				interrupts = < 51  52  53  54  55  56  57  58	// Channels 0-7
+					       59  60  61  62  63  64  65  66	// Channels 8-15
+					      202 203 204 205 206 207 208 209>;	// Channel 16-23
+			};
+
+			etpu@3fc0000 {		// Enhanced Time Processing Unit
+				compatible = "fsl,mpc5554-etpu";
+				reg = <0x03fc0000 0x4000>;
+				interrupts = <67	// Global Exception
+					      68 69 70 71 72 73 74 75	// A Channels 0-7
+					      76 77 78 79 80 81 82 83	// A Channels 8-15
+					      84 85 86 87 88 89 90 91	// A Channels 16-23
+					      92 93 94 95 96 97 98 99	// A Channels 24-31
+					      243 244 245 256 247 248 249 250	// B Channels 0-7
+					      251 252 253 254 255 256 257 248	// B Channels 8-15
+					      259 260 261 262 263 264 265 266	// B Channels 16-23
+					      267 268 269 270 271 272 273 274>;	// B Channels 24-31
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
+				interrupts = <10				// Channel Error 0-31
+					      11 12 13 14 15 16 17 18		// Channels 0-7
+					      19 20 21 22 23 24 25 26		// Channels 8-15
+					      27 28 29 30 31 32 33 34		// Channels 16-23
+					      35 36 37 38 39 40 41 42		// Channels 24-31
+					      210				// Channel Error 32-63
+					      211 212 213 214 215 216 217 218	// Channels 32-39
+					      219 220 221 222 223 224 225 226	// Channels 40-47
+					      227 228 229 230 231 232 233 234	// Channels 48-55
+					      235 236 237 238 239 240 241 242>;	// Channels 56-63
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
+				interrupts = <152				// Bus off
+					      153				// Error
+					      155 156 157 158 159 160 161 162	// Buffers 0-7
+					      163 164 165 166 167 168 169 170	// Buffers 8-15
+					      171				// Buffers 16-31
+					      172>;				// Buffers 32-63
+			};
+
+			can@fffc4000 {		// Controller Area Network (FlexCAN_B)
+				compatible = "fsl,mpc5554-flexcan";
+				reg = <0xfffc4000 0x4000>;
+				interrupts = <280				// Bus off
+					      281				// Error
+					      283 284 285 186 287 288 289 290	// Buffers 0-7
+					      291 292 293 294 295 296 297 298	// Buffers 8-15
+					      299				// Buffers 16-31
+					      300>;				// Buffers 32-63
+			};
+
+			can@fffc8000 {		// Controller Area Network (FlexCAN_C)
+				compatible = "fsl,mpc5554-flexcan";
+				reg = <0xfffc8000 0x4000>;
+				interrupts = <173				// Bus off
+					      174				// Error
+					      176 177 178 179 180 181 182 183	// Buffers 0-7
+					      184 185 186 187 188 189 190 191	// Buffers 8-15
+					      192				// Buffers 16-31
+					      193>;				// Buffers 32-63
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
