Return-Path: <thunderbird2k@gmail.com>
Received: from mail-ew0-f167.google.com (mail-ew0-f167.google.com
	[209.85.219.167]) by ozlabs.org (Postfix) with ESMTP id 860D6DE1C8
	for <linuxppc-dev@ozlabs.org>; Fri, 22 May 2009 06:31:01 +1000 (EST)
Received: by ewy11 with SMTP id 11so1498275ewy.9
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 13:31:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090521165008.A020D710053@mail54-sin.bigfish.com>
References: <20090521162202.10880.34056.stgit@localhost.localdomain>
	<20090521162434.10880.62883.stgit@localhost.localdomain>
	<20090521165008.A020D710053@mail54-sin.bigfish.com>
Date: Thu, 21 May 2009 22:31:00 +0200
Message-ID: <c8485d470905211331p3fb2e8bq85fcb7cc8ff981f1@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] powerpc/virtex: Add Xilinx ML510 reference
	designsupport
From: Roderick Colenbrander <thunderbird2k@gmail.com>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Stephen,

Grant forgot to attach the dts file (but a next patch will add it).
The dts file contains some lines for the pci bus mapping. The lines
are attached below. For pci support I'm using the reference bsb with
pci 'ML510 BSB1 Pcores Design' for PowerPC at:
http://www.xilinx.com/products/boards/ml510/ml510_10.1_3_1/bsb.htm.
The patch also contains a tutorial on how to add pci yourself.

As I mention in the comment of the plbv46_pci stuff C_IPIFBAR2PCIBAR_0
is not set correctly. Benjamin Herrenschmidt told me that inbound and
outbound pci transactions shouldn't overlap. With the value at ipif
plb 0xa0000000 maps to 0 on the pci side while the pci soft-core also
thinks that 0 maps to address 0 of the system memory. Setting
C_IPIFBAR2PCIBAR_0 to e.g. 0xa0000000 like I'm doing maps ipif plb
0xa0000000 to 0xa0000000 on the pci side and prevents this confusion.
The same is also wrong in the guides for the ml410.

Could you forward it to the right people so that this can get fixed?
No other changes are needed except for this one.

Roderick


+               plbv46_pci_0: plbv46-pci@85e00000 {
+                       #size-cells = <2>;
+                       #address-cells = <3>;
+                       compatible = "xlnx,plbv46-pci-1.03.a";
+                       device_type = "pci";
+                       reg = < 0x85e00000 0x10000 >;
+                       /* The default ML510 BSB has
C_IPIFBAR2PCIBAR_0 set to 0 which means that a read/write to
+                        * the memory mapped i/o region (which starts
at 0xa0000000) for pci bar 0 on the plb side
+                        * translates to 0.
+                        * It is important to this value to
0xa0000000, so that inbound and outbound pci transactions
+                        * work properly including DMA.
+                        */
+                       ranges = <0x02000000 0x00000000 0xa0000000
0xa0000000 0x00000000 0x20000000
+                                 0x01000000 0x00000000 0x00000000
0xf0000000 0x00000000 0x00010000>;
+
+                       #interrupt-cells = <1>;
+                       interrupt-parent = <&xps_intc_0>;
+                       interrupt-map-mask = <0xff00 0x0 0x0 0x7>;
+                       interrupt-map = <
+                               /* IRQ mapping for pci slots and ALI
M1533 periperhals. In total there are
+                                * 5 interrupt lines connected to a
xps_intc controller. Four of them are PCI
+                                * IRQ A, B, C, D and which correspond
to respectively xpx_intc 5, 4, 3 and 2.
+                                * The fifth interrupt line is
connected to the south bridge and this one
+                                * uses irq 1 and is active high
instead of active low.
+                                *
+                                * The M1533 contains various
peripherals including AC97 audio, a modem, USB,
+                                * IDE and some power management
stuff. The modem isn't connected on the ML510
+                                * and the power management core also
isn't used.
+                                */
+
+                               /* IDSEL 0x16 / dev=6, bus=0 / PCI slot 3 */
+                               0x3000 0 0 1 &xps_intc_0 3 2
+                               0x3000 0 0 2 &xps_intc_0 2 2
+                               0x3000 0 0 3 &xps_intc_0 5 2
+                               0x3000 0 0 4 &xps_intc_0 4 2
+
+                               /* IDSEL 0x13 / dev=3, bus=1 / PCI slot 4 */
+                               /*
+                               0x11800 0 0 1 &xps_intc_0 5 0 2
+                               0x11800 0 0 2 &xps_intc_0 4 0 2
+                               0x11800 0 0 3 &xps_intc_0 3 0 2
+                               0x11800 0 0 4 &xps_intc_0 2 0 2
+                               */
+
+                               /* According to the datasheet +
schematic ABCD [FPGA] of slot 5 is mapped to DABC.
+                                * Testing showed that at least A maps
to B, the mapping of the other pins is a guess
+                                * and for that reason the lines have
been commented.
+                                */
+                               /* IDSEL 0x15 / dev=5, bus=0 / PCI slot 5 */
+                               0x2800 0 0 1 &xps_intc_0 4 2
+                               /*
+                               0x2800 0 0 2 &xps_intc_0 3 2
+                               0x2800 0 0 3 &xps_intc_0 2 2
+                               0x2800 0 0 4 &xps_intc_0 5 2
+                               */
+
+                               /* IDSEL 0x12 / dev=2, bus=1 / PCI slot 6 */
+                               /*
+                               0x11000 0 0 1 &xps_intc_0 4 0 2
+                               0x11000 0 0 2 &xps_intc_0 3 0 2
+                               0x11000 0 0 3 &xps_intc_0 2 0 2
+                               0x11000 0 0 4 &xps_intc_0 5 0 2
+                               */
+
+                               /* IDSEL 0x11 / dev=1, bus=0 / AC97 audio */
+                               0x0800 0 0 1 &i8259 7 2
+
+                               /* IDSEL 0x1b / dev=11, bus=0 / IDE */
+                               0x5800 0 0 1 &i8259 14 2
+
+                               /* IDSEL 0x1f / dev 15, bus=0 / 2x USB 1.1 */
+                               0x7800 0 0 1 &i8259 7 2
+                       >;
+                       ali_m1533 {
+                               #size-cells = <1>;
+                               #address-cells = <2>;
+                               i8259: interrupt-controller@20 {
+                                       reg = <1 0x20 2
+                                                       1 0xa0 2
+                                                       1 0x4d0 2>;
+                                       interrupt-controller;
+                                       device_type = "interrupt-controller";
+                                       #address-cells = <0>;
+                                       #interrupt-cells = <2>;
+                                       compatible = "chrp,iic";
+
+                                       /* The south bridge connection
is active high */
+                                       interrupts = <1 3>;
+                                       interrupt-parent = <&xps_intc_0>;
+                               };
+                       };
+               } ;
