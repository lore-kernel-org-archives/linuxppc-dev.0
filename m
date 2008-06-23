Return-Path: <John.Linn@xilinx.com>
Received: from IE1EHSOBE006.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16]) by ozlabs.org (Postfix) with ESMTP id 6AE2FDDEC6
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 02:29:23 +1000 (EST)
Received: from mail66-dub (localhost.localdomain [127.0.0.1])	by
	mail66-dub-R.bigfish.com (Postfix) with ESMTP id 3DC0E5C84C6	for
	<linuxppc-dev@ozlabs.org>; Mon, 23 Jun 2008 16:29:18 +0000 (UTC)
Received: from xsj-gw1 (unknown [149.199.60.83])	by mail66-dub.bigfish.com
	(Postfix) with ESMTP id D5FA41CA806C	for <linuxppc-dev@ozlabs.org>;
	Mon, 23 Jun 2008 16:28:56 +0000 (UTC)
Received: from unknown-38-66.xilinx.com ([149.199.38.66]
	helo=xsj-smtp1.xilinx.com)	by xsj-gw1 with esmtp (Exim
	4.63)	(envelope-from
	<John.Linn@xilinx.com>)	id 1KAouV-0007wS-P1	for linuxppc-dev@ozlabs.org;
	Mon, 23 Jun 2008 09:28:55 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: [PATCH] [RFC] powerpc: Xilinx: adding virtex5 powerpc 440 support
Date: Mon, 23 Jun 2008 10:28:53 -0600
From: John Linn <John.Linn@xilinx.com>
To: <linuxppc-dev@ozlabs.org>
Message-ID: <20080623162856.D5FA41CA806C@mail66-dub.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is an early patch against the mainline that I wanted to start
getting comments on.

I would appreciate any feedback.

I already see a few things that I need to look into myself.

1.    I'm not sure why we need to disable the interrupts in the
bootstrap loader?
2.    I see some SecetLab copyright in new files that might be just a
cut/paste type error.
3.    I don't see the cputable.c up to date with the Xilinx specific
440.

Thanks,
John Linn

-----Original Message-----
From: John Linn [mailto:john.linn@xilinx.com] =

Sent: Wednesday, June 18, 2008 2:58 PM
Cc: John Linn
Subject: [PATCH] powerpc: Xilinx: adding virtex5 powerpc 440 support

The following files add support for Virtex5 with Powerpc 440.

Device trees are currently handled differently than other embedded
systems as there may not be a boot loader such that the device
tree is compiled into the kernel or pulled from a BRAM.

The UART 16550 has extra initialization in the bootstrap loader
since a boot loader is not used many times.

Signed-off-by: John Linn <john.linn@xilinx.com>
---
 arch/powerpc/Kconfig                     |   75 +++
 arch/powerpc/boot/Makefile               |   24 +-
 arch/powerpc/boot/dts/ml507.dts          |  254 ++++++++
 arch/powerpc/boot/io.h                   |    7 +
 arch/powerpc/boot/virtex.c               |  246 ++++++++
 arch/powerpc/configs/44x/ml507_defconfig | 1010
++++++++++++++++++++++++++++++
 arch/powerpc/platforms/44x/Kconfig       |   62 ++
 arch/powerpc/platforms/44x/Makefile      |    1 +
 arch/powerpc/platforms/44x/virtex.c      |   58 ++
 arch/powerpc/platforms/Kconfig           |    7 +
 10 files changed, 1739 insertions(+), 5 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/ml507.dts
 create mode 100644 arch/powerpc/boot/virtex.c
 create mode 100644 arch/powerpc/configs/44x/ml507_defconfig
 create mode 100644 arch/powerpc/platforms/44x/virtex.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 3934e26..94adfe1 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -483,6 +483,81 @@ config SECCOMP
 =

 	  If unsure, say Y. Only embedded should say N here.
 =

+config WANT_DEVICE_TREE
+	bool
+	default n
+
+config BUILD_RAW_IMAGE
+	bool "Build firmware-independent image"
+	select WANT_DEVICE_TREE
+	help
+	  If this is enabled, a firmware independent "raw" image will be
+	  built, as zImage.raw.  This requires a completely filled-in
+	  device tree, with the following labels:
+
+	  mem_size_cells: on /#address-cells
+	  memsize: on the size portion of /memory/reg
+	  timebase: on the boot CPU's timebase property
+
+config DEVICE_TREE
+	string "Static device tree source file"
+	depends on WANT_DEVICE_TREE
+	help
+	  This specifies the device tree source (.dts) file to be
+	  compiled and included when building the bootwrapper.  If a
+	  relative filename is given, then it will be relative to
+	  arch/powerpc/boot/dts.  If you are not using the bootwrapper,
+	  or do not need to build a dts into the bootwrapper, this
+	  field is ignored.
+
+	  For example, this is required when building a cuImage target
+	  for an older U-Boot, which cannot pass a device tree itself.
+	  Such a kernel will not work with a newer U-Boot that tries to
+	  pass a device tree (unless you tell it not to).  If your
U-Boot
+	  does not mention a device tree in "help bootm", then use the
+	  cuImage target and specify a device tree here.  Otherwise, use
+	  the uImage target and leave this field blank.
+
+config COMPRESSED_DEVICE_TREE
+	bool "Use compressed device tree"
+	depends on XILINX_VIRTEX
+	depends on WANT_DEVICE_TREE
+	help
+	  In Xilinx FPGAs, the hardware can change quite dramatically
while
+	  still running the same kernel.  In this case and other similar
+	  ones, it is preferable to associate the device tree with a
+	  particular build of the hardware design.  This configuration
+	  option assumes that the device tree blob has been compressed
and
+	  stored in Block RAM in the FPGA design.  Typically, such a
block
+	  ram is available in order to provide a bootloop or other code
+	  close to the reset vector at the top of the address space.  By
+	  default, the parameter options associated with this
configuration
+	  assumes that exactly one block ram (2KB) of storage is
available,
+	  which should be sufficient for most designs.  If necessary in
a
+	  particular design, due to boot code requirement or a large
number
+	  of devices, this address (and the corresponding parameters in
the
+	  EDK design) must be modified.
+
+	  Note that in some highly area constrained designs, no block
rams
+	  may be available in the design, and some other mechanism may
be
+	  used to hold the processor in reset while external memory is
+	  initialized with processor code.  In such cases, that
mechanism
+	  should also be used to load the device tree at an appropriate
+	  location, and the parameters associated with this
configuration
+	  option should be modified to point to that location in
external
+	  memory.
+
+config COMPRESSED_DTB_START
+	hex "Start of compressed device tree"
+	depends on COMPRESSED_DEVICE_TREE
+	default 0xfffff800
+
+config COMPRESSED_DTB_SIZE
+	hex "Size of compressed device tree"
+	depends on COMPRESSED_DEVICE_TREE
+	default 0x800
+
+
 endmenu
 =

 config ISA_DMA_API
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 1cee2f9..9de59fb 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -66,7 +66,7 @@ src-plat :=3D of.c cuboot-52xx.c cuboot-824x.c
cuboot-83xx.c cuboot-85xx.c holly.c
 		fixed-head.S ep88xc.c ep405.c \
 		cuboot-katmai.c cuboot-rainier.c redboot-8xx.c ep8248e.c
\
 		cuboot-warp.c cuboot-85xx-cpm2.c cuboot-yosemite.c
simpleboot.c \
-		virtex405-head.S
+		virtex.c virtex405-head.S
 src-boot :=3D $(src-wlib) $(src-plat) empty.c
 =

 src-boot :=3D $(addprefix $(obj)/, $(src-boot))
@@ -197,6 +197,7 @@ image-$(CONFIG_PPC_HOLLY)		+=3D zImage.holly
 image-$(CONFIG_PPC_PRPMC2800)		+=3D dtbImage.prpmc2800
 image-$(CONFIG_PPC_ISERIES)		+=3D zImage.iseries
 image-$(CONFIG_DEFAULT_UIMAGE)		+=3D uImage
+image-$(CONFIG_XILINX_VIRTEX)		+=3D zImage.virtex
 
 #
 # Targets which embed a device tree blob
@@ -279,14 +280,24 @@ targets	+=3D $(image-y) $(initrd-y)
 =

 $(addprefix $(obj)/, $(initrd-y)): $(obj)/ramdisk.image.gz
 =

+# If CONFIG_WANT_DEVICE_TREE is set and CONFIG_DEVICE_TREE isn't an
+# empty string, define 'dts' to be path to the dts
+# CONFIG_DEVICE_TREE will have "" around it, make sure to strip them
+ifeq ($(CONFIG_WANT_DEVICE_TREE),y)
+ifneq ($(CONFIG_DEVICE_TREE),"")
+dts =3D $(if $(shell echo $(CONFIG_DEVICE_TREE) | grep '^/'),\
+	,$(srctree)/$(src)/dts/)$(CONFIG_DEVICE_TREE:"%"=3D%)
+endif
+endif
+
 # Don't put the ramdisk on the pattern rule; when its missing make will
try
 # the pattern rule with less dependencies that also matches (even with
the
 # hard dependency listed).
-$(obj)/zImage.initrd.%: vmlinux $(wrapperbits)
-	$(call if_changed,wrap,$*,,,$(obj)/ramdisk.image.gz)
+$(obj)/zImage.initrd.%: vmlinux $(wrapperbits) $(dts)
+	$(call if_changed,wrap,$*,$(dts),,$(obj)/ramdisk.image.gz)
 =

-$(obj)/zImage.%: vmlinux $(wrapperbits)
-	$(call if_changed,wrap,$*)
+$(obj)/zImage.%: vmlinux $(wrapperbits) $(dts)
+	$(call if_changed,wrap,$*,$(dts))
 =

 # dtbImage% - a dtbImage is a zImage with an embedded device tree blob
 $(obj)/dtbImage.initrd.%: vmlinux $(wrapperbits) $(obj)/%.dtb
@@ -325,6 +336,9 @@ $(obj)/treeImage.%: vmlinux $(obj)/%.dtb
$(wrapperbits)
 $(obj)/%.dtb: $(dtstree)/%.dts $(obj)/dtc
 	$(obj)/dtc -O dtb -o $(obj)/$*.dtb -b 0 $(DTS_FLAGS)
$(dtstree)/$*.dts
 =

+$(obj)/zImage.raw: vmlinux $(dts) $(wrapperbits)
+	$(call if_changed,wrap,raw,$(dts))
+
 # If there isn't a platform selected then just strip the vmlinux.
 ifeq (,$(image-y))
 image-y :=3D vmlinux.strip
diff --git a/arch/powerpc/boot/dts/ml507.dts
b/arch/powerpc/boot/dts/ml507.dts
new file mode 100644
index 0000000..43d8535
--- /dev/null
+++ b/arch/powerpc/boot/dts/ml507.dts
@@ -0,0 +1,254 @@
+/*
+ * (C) Copyright 2007-2008 Xilinx, Inc.
+ * (C) Copyright 2007 Michal Simek
+ *
+ * Michal SIMEK <monstr@monstr.eu>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
+ *
+ * CAUTION: This file is automatically generated by libgen.
+ * Version: Xilinx EDK 10.1.01 EDK_K_SP1.2
+ */
+
+/ {
+	#address-cells =3D <1>;
+	#size-cells =3D <1>;
+	compatible =3D "xlnx,virtex";
+	dcr-parent =3D <&ppc440_virtex5_0>;
+	model =3D "testing";
+	chosen {
+		bootargs =3D "console=3DttyS0 ip=3Don root=3D/dev/ram";
+		linux,stdout-path =3D "/plb@0/serial@d0000000";
+	} ;
+	cpus {
+		#address-cells =3D <1>;
+		#cpus =3D <1>;
+		#size-cells =3D <0>;
+		ppc440_virtex5_0: cpu@0 {
+			#address-cells =3D <1>;
+			#size-cells =3D <1>;
+			clock-frequency =3D <17d78400>;
+			compatible =3D "PowerPC,440", "ibm,ppc440";
+			d-cache-line-size =3D <20>;
+			d-cache-size =3D <8000>;
+			dcr-access-method =3D "native";
+			dcr-controller ;
+			device_type =3D "cpu";
+			i-cache-line-size =3D <20>;
+			i-cache-size =3D <8000>;
+			model =3D "PowerPC,440";
+			reg =3D <0>;
+			timebase-frequency =3D <17d78400>;
+			xlnx,apu-control =3D <1>;
+			xlnx,apu-udi-0 =3D <c07701>;
+			xlnx,apu-udi-1 =3D <c47701>;
+			xlnx,apu-udi-10 =3D <0>;
+			xlnx,apu-udi-11 =3D <0>;
+			xlnx,apu-udi-12 =3D <0>;
+			xlnx,apu-udi-13 =3D <0>;
+			xlnx,apu-udi-14 =3D <0>;
+			xlnx,apu-udi-15 =3D <0>;
+			xlnx,apu-udi-2 =3D <0>;
+			xlnx,apu-udi-3 =3D <0>;
+			xlnx,apu-udi-4 =3D <0>;
+			xlnx,apu-udi-5 =3D <0>;
+			xlnx,apu-udi-6 =3D <0>;
+			xlnx,apu-udi-7 =3D <0>;
+			xlnx,apu-udi-8 =3D <0>;
+			xlnx,apu-udi-9 =3D <0>;
+			xlnx,dcr-autolock-enable =3D <1>;
+			xlnx,dcu-rd-ld-cache-plb-prio =3D <0>;
+			xlnx,dcu-rd-noncache-plb-prio =3D <0>;
+			xlnx,dcu-rd-touch-plb-prio =3D <0>;
+			xlnx,dcu-rd-urgent-plb-prio =3D <0>;
+			xlnx,dcu-wr-flush-plb-prio =3D <0>;
+			xlnx,dcu-wr-store-plb-prio =3D <0>;
+			xlnx,dcu-wr-urgent-plb-prio =3D <0>;
+			xlnx,dma0-control =3D <0>;
+			xlnx,dma0-plb-prio =3D <0>;
+			xlnx,dma0-rxchannelctrl =3D <1010000>;
+			xlnx,dma0-rxirqtimer =3D <3ff>;
+			xlnx,dma0-txchannelctrl =3D <1010000>;
+			xlnx,dma0-txirqtimer =3D <3ff>;
+			xlnx,dma1-control =3D <0>;
+			xlnx,dma1-plb-prio =3D <0>;
+			xlnx,dma1-rxchannelctrl =3D <1010000>;
+			xlnx,dma1-rxirqtimer =3D <3ff>;
+			xlnx,dma1-txchannelctrl =3D <1010000>;
+			xlnx,dma1-txirqtimer =3D <3ff>;
+			xlnx,dma2-control =3D <0>;
+			xlnx,dma2-plb-prio =3D <0>;
+			xlnx,dma2-rxchannelctrl =3D <1010000>;
+			xlnx,dma2-rxirqtimer =3D <3ff>;
+			xlnx,dma2-txchannelctrl =3D <1010000>;
+			xlnx,dma2-txirqtimer =3D <3ff>;
+			xlnx,dma3-control =3D <0>;
+			xlnx,dma3-plb-prio =3D <0>;
+			xlnx,dma3-rxchannelctrl =3D <1010000>;
+			xlnx,dma3-rxirqtimer =3D <3ff>;
+			xlnx,dma3-txchannelctrl =3D <1010000>;
+			xlnx,dma3-txirqtimer =3D <3ff>;
+			xlnx,endian-reset =3D <0>;
+			xlnx,generate-plb-timespecs =3D <1>;
+			xlnx,icu-rd-fetch-plb-prio =3D <0>;
+			xlnx,icu-rd-spec-plb-prio =3D <0>;
+			xlnx,icu-rd-touch-plb-prio =3D <0>;
+			xlnx,interconnect-imask =3D <ffffffff>;
+			xlnx,mplb-allow-lock-xfer =3D <1>;
+			xlnx,mplb-arb-mode =3D <0>;
+			xlnx,mplb-awidth =3D <20>;
+			xlnx,mplb-counter =3D <500>;
+			xlnx,mplb-dwidth =3D <80>;
+			xlnx,mplb-max-burst =3D <8>;
+			xlnx,mplb-native-dwidth =3D <80>;
+			xlnx,mplb-p2p =3D <0>;
+			xlnx,mplb-prio-dcur =3D <2>;
+			xlnx,mplb-prio-dcuw =3D <3>;
+			xlnx,mplb-prio-icu =3D <4>;
+			xlnx,mplb-prio-splb0 =3D <1>;
+			xlnx,mplb-prio-splb1 =3D <0>;
+			xlnx,mplb-read-pipe-enable =3D <1>;
+			xlnx,mplb-sync-tattribute =3D <0>;
+			xlnx,mplb-wdog-enable =3D <1>;
+			xlnx,mplb-write-pipe-enable =3D <1>;
+			xlnx,mplb-write-post-enable =3D <1>;
+			xlnx,num-dma =3D <1>;
+			xlnx,pir =3D <f>;
+			xlnx,ppc440mc-addr-base =3D <0>;
+			xlnx,ppc440mc-addr-high =3D <1fffffff>;
+			xlnx,ppc440mc-arb-mode =3D <0>;
+			xlnx,ppc440mc-bank-conflict-mask =3D <c00000>;
+			xlnx,ppc440mc-control =3D <f810008f>;
+			xlnx,ppc440mc-max-burst =3D <8>;
+			xlnx,ppc440mc-prio-dcur =3D <2>;
+			xlnx,ppc440mc-prio-dcuw =3D <3>;
+			xlnx,ppc440mc-prio-icu =3D <4>;
+			xlnx,ppc440mc-prio-splb0 =3D <1>;
+			xlnx,ppc440mc-prio-splb1 =3D <0>;
+			xlnx,ppc440mc-row-conflict-mask =3D <3ffe00>;
+			xlnx,ppcdm-asyncmode =3D <0>;
+			xlnx,ppcds-asyncmode =3D <0>;
+			xlnx,user-reset =3D <0>;
+			DMA0: sdma@80 {
+				compatible =3D "xlnx,ll-dma-1.00.a";
+				dcr-reg =3D < 80 11 >;
+				interrupt-parent =3D <&opb_intc_0>;
+				interrupts =3D < 5 2 6 2 >;
+			} ;
+		} ;
+	} ;
+	plb_v46_cfb_0: plb@0 {
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+		compatible =3D "xlnx,plb-v46-1.02.a";
+		ranges ;
+		iic_bus: i2c@d0020000 {
+			compatible =3D "xlnx,xps-iic-2.00.a";
+			interrupt-parent =3D <&opb_intc_0>;
+			interrupts =3D < 7 2 >;
+			reg =3D < d0020000 200 >;
+			xlnx,clk-freq =3D <5f5e100>;
+			xlnx,family =3D "virtex5";
+			xlnx,gpo-width =3D <1>;
+			xlnx,iic-freq =3D <186a0>;
+			xlnx,scl-inertial-delay =3D <0>;
+			xlnx,sda-inertial-delay =3D <0>;
+			xlnx,ten-bit-adr =3D <0>;
+		} ;
+		leds_8bit: gpio@d0010200 {
+			compatible =3D "xlnx,xps-gpio-1.00.a";
+			interrupt-parent =3D <&opb_intc_0>;
+			interrupts =3D < 1 2 >;
+			reg =3D < d0010200 200 >;
+			xlnx,all-inputs =3D <0>;
+			xlnx,all-inputs-2 =3D <0>;
+			xlnx,dout-default =3D <0>;
+			xlnx,dout-default-2 =3D <0>;
+			xlnx,family =3D "virtex5";
+			xlnx,gpio-width =3D <8>;
+			xlnx,interrupt-present =3D <1>;
+			xlnx,is-bidir =3D <1>;
+			xlnx,is-bidir-2 =3D <1>;
+			xlnx,is-dual =3D <0>;
+			xlnx,tri-default =3D <ffffffff>;
+			xlnx,tri-default-2 =3D <ffffffff>;
+		} ;
+		ll_temac_0: xps-ll-temac@91200000 {
+			#address-cells =3D <1>;
+			#size-cells =3D <1>;
+			compatible =3D "xlnx,compound";
+			ethernet@91200000 {
+				compatible =3D "xlnx,xps-ll-temac-1.01.a";
+				device_type =3D "network";
+				interrupt-parent =3D <&opb_intc_0>;
+				interrupts =3D < 4 2 >;
+				llink-connected =3D <&DMA0>;
+				local-mac-address =3D [ 02 00 00 00 00 00
];
+				reg =3D < 91200000 40 >;
+				xlnx,bus2core-clk-ratio =3D <1>;
+				xlnx,phy-type =3D <1>;
+				xlnx,phyaddr =3D <1>;
+				xlnx,rxcsum =3D <0>;
+				xlnx,rxfifo =3D <4000>;
+				xlnx,temac-type =3D <0>;
+				xlnx,txcsum =3D <0>;
+				xlnx,txfifo =3D <4000>;
+			} ;
+		} ;
+		opb_intc_0: interrupt-controller@d0020200 {
+			#interrupt-cells =3D <2>;
+			compatible =3D "xlnx,xps-intc-1.00.a";
+			interrupt-controller ;
+			reg =3D < d0020200 20 >;
+			xlnx,num-intr-inputs =3D <8>;
+		} ;
+		plb_bram_if_cntlr_0: xps-bram-if-cntlr@ffff0000 {
+			compatible =3D "xlnx,xps-bram-if-cntlr-1.00.a";
+			reg =3D < ffff0000 10000 >;
+			xlnx,family =3D "virtex5";
+		} ;
+		plb_bram_if_cntlr_1: xps-bram-if-cntlr@eee00000 {
+			compatible =3D "xlnx,xps-bram-if-cntlr-1.00.a";
+			reg =3D < eee00000 2000 >;
+			xlnx,family =3D "virtex5";
+		} ;
+		rs232_uart_0: serial@d0000000 {
+			clock-frequency =3D <1312d00>;
+			compatible =3D "xlnx,xps-uart16550-2.00.a",
"ns16550";
+			current-speed =3D <2580>;
+			device_type =3D "serial";
+			interrupt-parent =3D <&opb_intc_0>;
+			interrupts =3D < 0 2 >;
+			reg =3D < d0000000 2000 >;
+			reg-offset =3D <3>;
+			reg-shift =3D <2>;
+			xlnx,family =3D "virtex5";
+			xlnx,has-external-rclk =3D <0>;
+			xlnx,has-external-xin =3D <1>;
+			xlnx,is-a-16550 =3D <1>;
+		} ;
+		sysace_compactflash: sysace@d0030100 {
+			compatible =3D "xlnx,xps-sysace-1.00.a";
+			reg =3D < d0030100 80 >;
+			xlnx,family =3D "virtex5";
+			xlnx,mem-width =3D <10>;
+		} ;
+	} ;
+	ppc440mc_ddr2_0: memory@0 {
+		device_type =3D "memory";
+		reg =3D < 0 20000000 >;
+	} ;
+}  ;
diff --git a/arch/powerpc/boot/io.h b/arch/powerpc/boot/io.h
index ccaedae..ec57ec9 100644
--- a/arch/powerpc/boot/io.h
+++ b/arch/powerpc/boot/io.h
@@ -99,4 +99,11 @@ static inline void barrier(void)
 	asm volatile("" : : : "memory");
 }
 =

+static inline void disable_irq(void)
+{
+	int dummy;
+	asm volatile("mfmsr %0; rlwinm %0, %0, 0, ~(1<<15); mtmsr %0" :
+	             "=3Dr" (dummy) : : "memory");
+}
+
 #endif /* _IO_H */
diff --git a/arch/powerpc/boot/virtex.c b/arch/powerpc/boot/virtex.c
new file mode 100644
index 0000000..5d807c6
--- /dev/null
+++ b/arch/powerpc/boot/virtex.c
@@ -0,0 +1,246 @@
+/*
+ * Old U-boot compatibility for Walnut
+ *
+ * Author: Josh Boyer <jwboyer@linux.vnet.ibm.com>
+ *
+ * Copyright 2007 IBM Corporation
+ *   Based on cuboot-83xx.c, which is:
+ * Copyright (c) 2007 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
it
+ * under the terms of the GNU General Public License version 2 as
published
+ * by the Free Software Foundation.
+ */
+
+#include <stddef.h>
+#include <stdio.h>
+#include "ops.h"
+#include "dcr.h"
+#include "4xx.h"
+#include "io.h"
+#include "reg.h"
+
+BSS_STACK(4096);
+
+#include "types.h"
+#include "gunzip_util.h"
+#include <libfdt.h>
+#include "../../../include/linux/autoconf.h"
+
+#define UART_DLL		0	/* Out: Divisor Latch Low */
+#define UART_DLM		1	/* Out: Divisor Latch High */
+#define UART_FCR		2	/* Out: FIFO Control Register */
+#define UART_FCR_CLEAR_RCVR 	0x02 	/* Clear the RCVR FIFO */
+#define UART_FCR_CLEAR_XMIT	0x04 	/* Clear the XMIT FIFO */
+#define UART_LCR		3	/* Out: Line Control Register */
+#define UART_MCR		4	/* Out: Modem Control Register
*/
+#define UART_MCR_RTS		0x02 	/* RTS complement */
+#define UART_MCR_DTR		0x01 	/* DTR complement */
+#define UART_LCR_DLAB		0x80 	/* Divisor latch access bit */
+#define UART_LCR_WLEN8		0x03 	/* Wordlength: 8 bits */
+
+/* This function is only needed when there is no boot loader to
+   initialize the UART
+*/
+static int virtex_ns16550_console_init(void *devp)
+{
+	int n;
+	unsigned long reg_phys;
+	unsigned char *regbase;
+	u32 regshift, clk, spd;
+	u16 divisor;
+
+	n =3D getprop(devp, "virtual-reg", &regbase, sizeof(regbase));
+	if (n !=3D sizeof(regbase)) {
+		if (!dt_xlate_reg(devp, 0, &reg_phys, NULL))
+			return -1;
+
+		regbase =3D (void *)reg_phys + 3;
+	}
+	regshift =3D 2;
+
+	n =3D getprop(devp, "current-speed", (void *)&spd, sizeof(spd));
+	if (n !=3D sizeof(spd))
+		spd =3D 9600;
+
+	/* should there be a default clock rate?*/
+	n =3D getprop(devp, "clock-frequency", (void *)&clk, sizeof(clk));
+	if (n !=3D sizeof(clk))
+		return -1;
+
+	divisor =3D clk / (16 * spd);
+
+	/* Access baud rate */
+	out_8(regbase + (UART_LCR << regshift), UART_LCR_DLAB);
+
+	/* Baud rate based on input clock */
+	out_8(regbase + (UART_DLL << regshift), divisor & 0xFF);
+	out_8(regbase + (UART_DLM << regshift), divisor >> 8);
+
+	/* 8 data, 1 stop, no parity */
+	out_8(regbase + (UART_LCR << regshift), UART_LCR_WLEN8);
+
+	/* RTS/DTR */
+	out_8(regbase + (UART_MCR << regshift), UART_MCR_RTS |
UART_MCR_DTR);
+
+	/* Clear transmitter and receiver */
+	out_8(regbase + (UART_FCR << regshift),
+				UART_FCR_CLEAR_XMIT |
UART_FCR_CLEAR_RCVR);
+	return 0;
+}
+
+/* For virtex, the kernel may be loaded without using a bootloader and
if so
+   some UARTs need more setup than is provided in the normal console
init
+*/
+static int virtex_serial_console_init(void)
+{
+	void *devp;
+	char devtype[MAX_PROP_LEN];
+	char path[MAX_PATH_LEN];
+
+	devp =3D finddevice("/chosen");
+	if (devp =3D=3D NULL)
+		return -1;
+
+	if (getprop(devp, "linux,stdout-path", path, MAX_PATH_LEN) > 0)
{
+		devp =3D finddevice(path);
+		if (devp =3D=3D NULL)
+			return -1;
+
+		if ((getprop(devp, "device_type", devtype,
sizeof(devtype)) > 0)
+				&& !strcmp(devtype, "serial")
+				&& (dt_is_compatible(devp, "ns16550")))
+				virtex_ns16550_console_init(devp);
+	}
+	return 0;
+}
+
+#ifdef CONFIG_COMPRESSED_DEVICE_TREE
+static struct gunzip_state gzstate;
+#endif
+
+void platform_init(void)
+{
+	u32 memreg[4];
+	u64 start;
+	u64 size =3D 0x2000000;
+	int naddr, nsize, i;
+	void *root, *memory;
+	static const unsigned long line_size =3D 32;
+	static const unsigned long congruence_classes =3D 256;
+	unsigned long addr;
+	unsigned long dccr;
+
+#ifdef CONFIG_COMPRESSED_DEVICE_TREE
+	void *dtbz_start;
+	u32 dtbz_size;
+	void *dtb_addr;
+	u32 dtb_size;
+	struct fdt_header dtb_header;
+	int len;
+#endif
+
+        if((mfpvr() & 0xfffff000) =3D=3D 0x20011000) {
+            /* PPC errata 213: only for Virtex-4 FX */
+            __asm__("mfccr0  0\n\t"
+                    "oris    0,0,0x50000000@h\n\t"
+                    "mtccr0  0"
+                    : : : "0");
+        }
+
+	/*
+	 * Invalidate the data cache if the data cache is turned off.
+	 * - The 405 core does not invalidate the data cache on power-up
+	 *   or reset but does turn off the data cache. We cannot assume
+	 *   that the cache contents are valid.
+	 * - If the data cache is turned on this must have been done by
+	 *   a bootloader and we assume that the cache contents are
+	 *   valid.
+	 */
+	__asm__("mfdccr %0": "=3Dr" (dccr));
+	if (dccr =3D=3D 0) {
+		for (addr =3D 0;
+		     addr < (congruence_classes * line_size);
+		     addr +=3D line_size) {
+			__asm__("dccci 0,%0": :"b"(addr));
+		}
+	}
+
+#if defined(CONFIG_XILINX_VIRTEX_5_FXT) &&
defined(CONFIG_MATH_EMULATION)
+	/* Make sure the APU is disabled when using soft FPU emulation
*/
+	mtdcr(5, 0);
+#endif
+
+	disable_irq();
+
+#ifdef CONFIG_COMPRESSED_DEVICE_TREE
+
+        /** FIXME: flatdevicetrees need the initializer allocated,
+            libfdt will fix this. */
+	dtbz_start =3D (void *)CONFIG_COMPRESSED_DTB_START;
+	dtbz_size =3D CONFIG_COMPRESSED_DTB_SIZE;
+	/** get the device tree */
+	gunzip_start(&gzstate, dtbz_start, dtbz_size);
+	gunzip_exactly(&gzstate, &dtb_header, sizeof(dtb_header));
+
+	dtb_size =3D dtb_header.totalsize;
+	// printf("Allocating 0x%lx bytes for dtb ...\n\r", dtb_size);
+
+	dtb_addr =3D _end; // Should be allocated?
+
+	gunzip_start(&gzstate, dtbz_start, dtbz_size);
+	len =3D gunzip_finish(&gzstate, dtb_addr, dtb_size);
+	if (len !=3D dtb_size)
+		fatal("ran out of data!  only got 0x%x of 0x%lx
bytes.\n\r",
+				len, dtb_size);
+	printf("done 0x%x bytes\n\r", len);
+	simple_alloc_init(0x800000, size - (unsigned long)0x800000, 32,
64);
+	fdt_init(dtb_addr);
+#else
+        /** FIXME: flatdevicetrees need the initializer allocated,
+            libfdt will fix this. */
+	simple_alloc_init(_end, size - (unsigned long)_end, 32, 64);
+	fdt_init(_dtb_start);
+#endif
+
+	root =3D finddevice("/");
+	if (getprop(root, "#address-cells", &naddr, sizeof(naddr)) < 0)
+		naddr =3D 2;
+	if (naddr < 1 || naddr > 2)
+		fatal("Can't cope with #address-cells =3D=3D %d in /\n\r",
naddr);
+
+	if (getprop(root, "#size-cells", &nsize, sizeof(nsize)) < 0)
+		nsize =3D 1;
+	if (nsize < 1 || nsize > 2)
+		fatal("Can't cope with #size-cells =3D=3D %d in /\n\r",
nsize);
+
+	memory =3D finddevice("/memory@0");
+	if (! memory) {
+		fatal("Need a memory@0 node!\n\r");
+	}
+	if (getprop(memory, "reg", memreg, sizeof(memreg)) < 0)
+		fatal("Need a memory@0 node!\n\r");
+
+	i =3D 0;
+	start =3D memreg[i++];
+	if(naddr =3D=3D 2) {
+		start =3D (start << 32) | memreg[i++];
+	}
+	size =3D memreg[i++];
+	if (nsize =3D=3D 2)
+		size =3D (size << 32) | memreg[i++];
+
+	// timebase_period_ns =3D 1000000000 / timebase;
+	virtex_serial_console_init();
+	serial_console_init();
+	if (console_ops.open)
+		console_ops.open();
+
+#ifdef CONFIG_COMPRESSED_DEVICE_TREE
+	printf("Using compressed device tree at 0x%x\n\r",
CONFIG_COMPRESSED_DTB_START);
+#else
+#endif
+        printf("booting virtex\n\r");
+        printf("memstart=3D0x%llx\n\r", start);
+        printf("memsize=3D0x%llx\n\r", size);
+}
diff --git a/arch/powerpc/configs/44x/ml507_defconfig
b/arch/powerpc/configs/44x/ml507_defconfig
new file mode 100644
index 0000000..af6a95d
--- /dev/null
+++ b/arch/powerpc/configs/44x/ml507_defconfig
@@ -0,0 +1,1010 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.24-rc8-xlnx
+# Wed Apr  9 07:12:04 2008
+#
+# CONFIG_PPC64 is not set
+
+#
+# Processor support
+#
+# CONFIG_6xx is not set
+# CONFIG_PPC_85xx is not set
+# CONFIG_PPC_8xx is not set
+# CONFIG_40x is not set
+CONFIG_44x=3Dy
+# CONFIG_E200 is not set
+CONFIG_4xx=3Dy
+CONFIG_BOOKE=3Dy
+CONFIG_PTE_64BIT=3Dy
+CONFIG_PHYS_64BIT=3Dy
+# CONFIG_PPC_MM_SLICES is not set
+CONFIG_NOT_COHERENT_CACHE=3Dy
+CONFIG_PPC32=3Dy
+CONFIG_WORD_SIZE=3D32
+CONFIG_PPC_MERGE=3Dy
+CONFIG_MMU=3Dy
+CONFIG_GENERIC_CMOS_UPDATE=3Dy
+CONFIG_GENERIC_TIME=3Dy
+CONFIG_GENERIC_TIME_VSYSCALL=3Dy
+CONFIG_GENERIC_CLOCKEVENTS=3Dy
+CONFIG_GENERIC_HARDIRQS=3Dy
+CONFIG_IRQ_PER_CPU=3Dy
+CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
+CONFIG_ARCH_HAS_ILOG2_U32=3Dy
+CONFIG_GENERIC_HWEIGHT=3Dy
+CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
+CONFIG_GENERIC_FIND_NEXT_BIT=3Dy
+# CONFIG_ARCH_NO_VIRT_TO_BUS is not set
+CONFIG_PPC=3Dy
+CONFIG_EARLY_PRINTK=3Dy
+CONFIG_GENERIC_NVRAM=3Dy
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=3Dy
+CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy
+CONFIG_PPC_OF=3Dy
+CONFIG_OF=3Dy
+CONFIG_PPC_UDBG_16550=3Dy
+# CONFIG_GENERIC_TBSYNC is not set
+CONFIG_AUDIT_ARCH=3Dy
+CONFIG_GENERIC_BUG=3Dy
+# CONFIG_DEFAULT_UIMAGE is not set
+CONFIG_PPC_DCR_NATIVE=3Dy
+# CONFIG_PPC_DCR_MMIO is not set
+CONFIG_PPC_DCR=3Dy
+CONFIG_DEFCONFIG_LIST=3D"/lib/modules/$UNAME_RELEASE/.config"
+
+#
+# General setup
+#
+CONFIG_EXPERIMENTAL=3Dy
+CONFIG_BROKEN_ON_SMP=3Dy
+CONFIG_LOCK_KERNEL=3Dy
+CONFIG_INIT_ENV_ARG_LIMIT=3D32
+CONFIG_LOCALVERSION=3D""
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_SWAP=3Dy
+CONFIG_SYSVIPC=3Dy
+CONFIG_SYSVIPC_SYSCTL=3Dy
+CONFIG_POSIX_MQUEUE=3Dy
+# CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_TASKSTATS is not set
+# CONFIG_USER_NS is not set
+# CONFIG_PID_NS is not set
+# CONFIG_AUDIT is not set
+CONFIG_IKCONFIG=3Dy
+CONFIG_IKCONFIG_PROC=3Dy
+CONFIG_LOG_BUF_SHIFT=3D14
+# CONFIG_CGROUPS is not set
+CONFIG_FAIR_GROUP_SCHED=3Dy
+CONFIG_FAIR_USER_SCHED=3Dy
+# CONFIG_FAIR_CGROUP_SCHED is not set
+CONFIG_SYSFS_DEPRECATED=3Dy
+# CONFIG_RELAY is not set
+CONFIG_BLK_DEV_INITRD=3Dy
+CONFIG_INITRAMFS_SOURCE=3D""
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SYSCTL=3Dy
+# CONFIG_EMBEDDED is not set
+CONFIG_SYSCTL_SYSCALL=3Dy
+CONFIG_KALLSYMS=3Dy
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_HOTPLUG=3Dy
+CONFIG_PRINTK=3Dy
+CONFIG_BUG=3Dy
+CONFIG_ELF_CORE=3Dy
+CONFIG_BASE_FULL=3Dy
+CONFIG_FUTEX=3Dy
+CONFIG_ANON_INODES=3Dy
+CONFIG_EPOLL=3Dy
+CONFIG_SIGNALFD=3Dy
+CONFIG_EVENTFD=3Dy
+CONFIG_SHMEM=3Dy
+CONFIG_VM_EVENT_COUNTERS=3Dy
+CONFIG_SLAB=3Dy
+# CONFIG_SLUB is not set
+# CONFIG_SLOB is not set
+CONFIG_SLABINFO=3Dy
+CONFIG_RT_MUTEXES=3Dy
+# CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=3D0
+CONFIG_MODULES=3Dy
+CONFIG_MODULE_UNLOAD=3Dy
+CONFIG_MODULE_FORCE_UNLOAD=3Dy
+CONFIG_MODVERSIONS=3Dy
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+CONFIG_KMOD=3Dy
+CONFIG_BLOCK=3Dy
+# CONFIG_LBD is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_LSF is not set
+# CONFIG_BLK_DEV_BSG is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=3Dy
+CONFIG_IOSCHED_AS=3Dy
+CONFIG_IOSCHED_DEADLINE=3Dy
+CONFIG_IOSCHED_CFQ=3Dy
+# CONFIG_DEFAULT_AS is not set
+# CONFIG_DEFAULT_DEADLINE is not set
+CONFIG_DEFAULT_CFQ=3Dy
+# CONFIG_DEFAULT_NOOP is not set
+CONFIG_DEFAULT_IOSCHED=3D"cfq"
+
+#
+# Platform support
+#
+# CONFIG_PPC_MPC52xx is not set
+# CONFIG_PPC_MPC5200 is not set
+# CONFIG_PPC_CELL is not set
+# CONFIG_PPC_CELL_NATIVE is not set
+# CONFIG_PQ2ADS is not set
+# CONFIG_BAMBOO is not set
+# CONFIG_EBONY is not set
+# CONFIG_SEQUOIA is not set
+CONFIG_XILINX_ML507=3Dy
+# CONFIG_XILINX_DISABLE_44x_CACHE is not set
+CONFIG_XILINX_ML5XX=3Dy
+CONFIG_XILINX_VIRTEX_5_FXT=3Dy
+# CONFIG_MPIC is not set
+# CONFIG_MPIC_WEIRD is not set
+# CONFIG_PPC_I8259 is not set
+# CONFIG_PPC_RTAS is not set
+# CONFIG_MMIO_NVRAM is not set
+# CONFIG_PPC_MPC106 is not set
+# CONFIG_PPC_970_NAP is not set
+# CONFIG_PPC_INDIRECT_IO is not set
+# CONFIG_GENERIC_IOMAP is not set
+# CONFIG_CPU_FREQ is not set
+# CONFIG_CPM2 is not set
+# CONFIG_FSL_ULI1575 is not set
+CONFIG_XILINX_DRIVERS=3Dy
+CONFIG_XILINX_VIRTEX=3Dy
+
+#
+# Kernel options
+#
+# CONFIG_HIGHMEM is not set
+# CONFIG_TICK_ONESHOT is not set
+# CONFIG_NO_HZ is not set
+# CONFIG_HIGH_RES_TIMERS is not set
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=3Dy
+# CONFIG_HZ_100 is not set
+CONFIG_HZ_250=3Dy
+# CONFIG_HZ_300 is not set
+# CONFIG_HZ_1000 is not set
+CONFIG_HZ=3D250
+# CONFIG_PREEMPT_NONE is not set
+# CONFIG_PREEMPT_VOLUNTARY is not set
+CONFIG_PREEMPT=3Dy
+CONFIG_PREEMPT_BKL=3Dy
+CONFIG_BINFMT_ELF=3Dy
+# CONFIG_BINFMT_MISC is not set
+CONFIG_MATH_EMULATION=3Dy
+CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=3Dy
+CONFIG_ARCH_FLATMEM_ENABLE=3Dy
+CONFIG_ARCH_POPULATES_NODE_MAP=3Dy
+CONFIG_SELECT_MEMORY_MODEL=3Dy
+CONFIG_FLATMEM_MANUAL=3Dy
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=3Dy
+CONFIG_FLAT_NODE_MEM_MAP=3Dy
+# CONFIG_SPARSEMEM_STATIC is not set
+# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
+CONFIG_SPLIT_PTLOCK_CPUS=3D4
+CONFIG_RESOURCES_64BIT=3Dy
+CONFIG_ZONE_DMA_FLAG=3D1
+CONFIG_BOUNCE=3Dy
+CONFIG_VIRT_TO_BUS=3Dy
+CONFIG_PROC_DEVICETREE=3Dy
+CONFIG_CMDLINE_BOOL=3Dy
+CONFIG_CMDLINE=3D""
+CONFIG_SECCOMP=3Dy
+CONFIG_WANT_DEVICE_TREE=3Dy
+# CONFIG_BUILD_RAW_IMAGE is not set
+CONFIG_DEVICE_TREE=3D"ml507.dts"
+# CONFIG_COMPRESSED_DEVICE_TREE is not set
+CONFIG_ISA_DMA_API=3Dy
+
+#
+# Bus options
+#
+CONFIG_ZONE_DMA=3Dy
+CONFIG_PPC_INDIRECT_PCI=3Dy
+CONFIG_PCI=3Dy
+CONFIG_PCI_DOMAINS=3Dy
+CONFIG_PCI_SYSCALL=3Dy
+# CONFIG_PCIEPORTBUS is not set
+CONFIG_ARCH_SUPPORTS_MSI=3Dy
+# CONFIG_PCI_MSI is not set
+CONFIG_PCI_LEGACY=3Dy
+# CONFIG_PCCARD is not set
+# CONFIG_HOTPLUG_PCI is not set
+
+#
+# Advanced setup
+#
+# CONFIG_ADVANCED_OPTIONS is not set
+
+#
+# Default settings for advanced configuration options are used
+#
+CONFIG_HIGHMEM_START=3D0xfe000000
+CONFIG_LOWMEM_SIZE=3D0x30000000
+CONFIG_KERNEL_START=3D0xc0000000
+CONFIG_TASK_SIZE=3D0xc0000000
+CONFIG_CONSISTENT_START=3D0xff100000
+CONFIG_CONSISTENT_SIZE=3D0x00200000
+CONFIG_BOOT_LOAD=3D0x01000000
+
+#
+# Networking
+#
+CONFIG_NET=3Dy
+
+#
+# Networking options
+#
+CONFIG_PACKET=3Dy
+# CONFIG_PACKET_MMAP is not set
+CONFIG_UNIX=3Dy
+CONFIG_XFRM=3Dy
+# CONFIG_XFRM_USER is not set
+# CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_XFRM_MIGRATE is not set
+# CONFIG_NET_KEY is not set
+CONFIG_INET=3Dy
+CONFIG_IP_MULTICAST=3Dy
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=3Dy
+CONFIG_IP_PNP=3Dy
+CONFIG_IP_PNP_DHCP=3Dy
+CONFIG_IP_PNP_BOOTP=3Dy
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_IP_MROUTE is not set
+# CONFIG_ARPD is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
+CONFIG_INET_TUNNEL=3Dm
+CONFIG_INET_XFRM_MODE_TRANSPORT=3Dy
+CONFIG_INET_XFRM_MODE_TUNNEL=3Dy
+CONFIG_INET_XFRM_MODE_BEET=3Dy
+# CONFIG_INET_LRO is not set
+CONFIG_INET_DIAG=3Dy
+CONFIG_INET_TCP_DIAG=3Dy
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_CUBIC=3Dy
+CONFIG_DEFAULT_TCP_CONG=3D"cubic"
+# CONFIG_TCP_MD5SIG is not set
+# CONFIG_IP_VS is not set
+CONFIG_IPV6=3Dm
+# CONFIG_IPV6_PRIVACY is not set
+# CONFIG_IPV6_ROUTER_PREF is not set
+# CONFIG_IPV6_OPTIMISTIC_DAD is not set
+# CONFIG_INET6_AH is not set
+# CONFIG_INET6_ESP is not set
+# CONFIG_INET6_IPCOMP is not set
+# CONFIG_IPV6_MIP6 is not set
+# CONFIG_INET6_XFRM_TUNNEL is not set
+# CONFIG_INET6_TUNNEL is not set
+CONFIG_INET6_XFRM_MODE_TRANSPORT=3Dm
+CONFIG_INET6_XFRM_MODE_TUNNEL=3Dm
+CONFIG_INET6_XFRM_MODE_BEET=3Dm
+# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
+CONFIG_IPV6_SIT=3Dm
+# CONFIG_IPV6_TUNNEL is not set
+# CONFIG_IPV6_MULTIPLE_TABLES is not set
+# CONFIG_NETWORK_SECMARK is not set
+CONFIG_NETFILTER=3Dy
+# CONFIG_NETFILTER_DEBUG is not set
+
+#
+# Core Netfilter Configuration
+#
+# CONFIG_NETFILTER_NETLINK is not set
+# CONFIG_NF_CONNTRACK_ENABLED is not set
+# CONFIG_NF_CONNTRACK is not set
+CONFIG_NETFILTER_XTABLES=3Dm
+# CONFIG_NETFILTER_XT_TARGET_CLASSIFY is not set
+# CONFIG_NETFILTER_XT_TARGET_DSCP is not set
+# CONFIG_NETFILTER_XT_TARGET_MARK is not set
+# CONFIG_NETFILTER_XT_TARGET_NFQUEUE is not set
+# CONFIG_NETFILTER_XT_TARGET_NFLOG is not set
+# CONFIG_NETFILTER_XT_TARGET_TCPMSS is not set
+# CONFIG_NETFILTER_XT_MATCH_COMMENT is not set
+# CONFIG_NETFILTER_XT_MATCH_DCCP is not set
+# CONFIG_NETFILTER_XT_MATCH_DSCP is not set
+# CONFIG_NETFILTER_XT_MATCH_ESP is not set
+# CONFIG_NETFILTER_XT_MATCH_LENGTH is not set
+# CONFIG_NETFILTER_XT_MATCH_LIMIT is not set
+# CONFIG_NETFILTER_XT_MATCH_MAC is not set
+# CONFIG_NETFILTER_XT_MATCH_MARK is not set
+# CONFIG_NETFILTER_XT_MATCH_POLICY is not set
+# CONFIG_NETFILTER_XT_MATCH_MULTIPORT is not set
+# CONFIG_NETFILTER_XT_MATCH_PKTTYPE is not set
+# CONFIG_NETFILTER_XT_MATCH_QUOTA is not set
+# CONFIG_NETFILTER_XT_MATCH_REALM is not set
+# CONFIG_NETFILTER_XT_MATCH_SCTP is not set
+# CONFIG_NETFILTER_XT_MATCH_STATISTIC is not set
+# CONFIG_NETFILTER_XT_MATCH_STRING is not set
+# CONFIG_NETFILTER_XT_MATCH_TCPMSS is not set
+# CONFIG_NETFILTER_XT_MATCH_TIME is not set
+# CONFIG_NETFILTER_XT_MATCH_U32 is not set
+# CONFIG_NETFILTER_XT_MATCH_HASHLIMIT is not set
+
+#
+# IP: Netfilter Configuration
+#
+# CONFIG_IP_NF_QUEUE is not set
+CONFIG_IP_NF_IPTABLES=3Dm
+# CONFIG_IP_NF_MATCH_IPRANGE is not set
+# CONFIG_IP_NF_MATCH_TOS is not set
+# CONFIG_IP_NF_MATCH_RECENT is not set
+# CONFIG_IP_NF_MATCH_ECN is not set
+# CONFIG_IP_NF_MATCH_AH is not set
+# CONFIG_IP_NF_MATCH_TTL is not set
+# CONFIG_IP_NF_MATCH_OWNER is not set
+# CONFIG_IP_NF_MATCH_ADDRTYPE is not set
+CONFIG_IP_NF_FILTER=3Dm
+# CONFIG_IP_NF_TARGET_REJECT is not set
+# CONFIG_IP_NF_TARGET_LOG is not set
+# CONFIG_IP_NF_TARGET_ULOG is not set
+CONFIG_IP_NF_MANGLE=3Dm
+# CONFIG_IP_NF_TARGET_TOS is not set
+# CONFIG_IP_NF_TARGET_ECN is not set
+# CONFIG_IP_NF_TARGET_TTL is not set
+# CONFIG_IP_NF_RAW is not set
+# CONFIG_IP_NF_ARPTABLES is not set
+
+#
+# IPv6: Netfilter Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP6_NF_QUEUE is not set
+# CONFIG_IP6_NF_IPTABLES is not set
+# CONFIG_IP_DCCP is not set
+# CONFIG_IP_SCTP is not set
+# CONFIG_TIPC is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+# CONFIG_NET_SCHED is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+# CONFIG_AF_RXRPC is not set
+
+#
+# Wireless
+#
+# CONFIG_CFG80211 is not set
+# CONFIG_WIRELESS_EXT is not set
+# CONFIG_MAC80211 is not set
+# CONFIG_IEEE80211 is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"
+CONFIG_STANDALONE=3Dy
+CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
+# CONFIG_FW_LOADER is not set
+# CONFIG_SYS_HYPERVISOR is not set
+# CONFIG_CONNECTOR is not set
+# CONFIG_MTD is not set
+CONFIG_OF_DEVICE=3Dy
+# CONFIG_PARPORT is not set
+CONFIG_BLK_DEV=3Dy
+# CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
+CONFIG_BLK_DEV_LOOP=3Dy
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_SX8 is not set
+CONFIG_BLK_DEV_RAM=3Dy
+CONFIG_BLK_DEV_RAM_COUNT=3D16
+CONFIG_BLK_DEV_RAM_SIZE=3D8192
+CONFIG_BLK_DEV_RAM_BLOCKSIZE=3D1024
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+# CONFIG_XILINX_SYSACE is not set
+# CONFIG_XILINX_SYSACE_OLD is not set
+CONFIG_MISC_DEVICES=3Dy
+# CONFIG_PHANTOM is not set
+# CONFIG_EEPROM_93CX6 is not set
+# CONFIG_SGI_IOC4 is not set
+# CONFIG_TIFM_CORE is not set
+CONFIG_NEED_XILINX_LLDMA=3Dy
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+# CONFIG_RAID_ATTRS is not set
+# CONFIG_SCSI is not set
+# CONFIG_SCSI_DMA is not set
+# CONFIG_SCSI_NETLINK is not set
+# CONFIG_ATA is not set
+# CONFIG_MD is not set
+# CONFIG_FUSION is not set
+
+#
+# IEEE 1394 (FireWire) support
+#
+# CONFIG_FIREWIRE is not set
+# CONFIG_IEEE1394 is not set
+# CONFIG_I2O is not set
+# CONFIG_MACINTOSH_DRIVERS is not set
+CONFIG_NETDEVICES=3Dy
+# CONFIG_NETDEVICES_MULTIQUEUE is not set
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_MACVLAN is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+# CONFIG_VETH is not set
+# CONFIG_ARCNET is not set
+# CONFIG_PHYLIB is not set
+CONFIG_NET_ETHERNET=3Dy
+CONFIG_MII=3Dy
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_CASSINI is not set
+# CONFIG_NET_VENDOR_3COM is not set
+# CONFIG_NET_TULIP is not set
+# CONFIG_HP100 is not set
+# CONFIG_IBM_NEW_EMAC is not set
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
+# CONFIG_NET_PCI is not set
+# CONFIG_B44 is not set
+# CONFIG_XILINX_EMAC is not set
+# CONFIG_XILINX_EMACLITE is not set
+CONFIG_NETDEV_1000=3Dy
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+# CONFIG_E1000 is not set
+# CONFIG_E1000E is not set
+# CONFIG_IP1000 is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_YELLOWFIN is not set
+# CONFIG_R8169 is not set
+# CONFIG_SIS190 is not set
+# CONFIG_SKGE is not set
+# CONFIG_SKY2 is not set
+# CONFIG_SK98LIN is not set
+# CONFIG_VIA_VELOCITY is not set
+# CONFIG_TIGON3 is not set
+# CONFIG_BNX2 is not set
+# CONFIG_QLA3XXX is not set
+# CONFIG_ATL1 is not set
+# CONFIG_XILINX_TEMAC is not set
+CONFIG_XILINX_LLTEMAC=3Dy
+# CONFIG_XILINX_LLTEMAC_MARVELL_88E1111_RGMII is not set
+CONFIG_XILINX_LLTEMAC_MARVELL_88E1111_GMII=3Dy
+# CONFIG_XILINX_LLTEMAC_MARVELL_88E1111_MII is not set
+# CONFIG_NETDEV_10000 is not set
+# CONFIG_TR is not set
+
+#
+# Wireless LAN
+#
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set
+# CONFIG_WAN is not set
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_ISDN is not set
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=3Dy
+# CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
+
+#
+# Userland interfaces
+#
+CONFIG_INPUT_MOUSEDEV=3Dy
+CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input Device Drivers
+#
+CONFIG_INPUT_KEYBOARD=3Dy
+CONFIG_KEYBOARD_ATKBD=3Dy
+# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_KEYBOARD_LKKBD is not set
+# CONFIG_KEYBOARD_XTKBD is not set
+# CONFIG_KEYBOARD_NEWTON is not set
+# CONFIG_KEYBOARD_STOWAWAY is not set
+CONFIG_INPUT_MOUSE=3Dy
+CONFIG_MOUSE_PS2=3Dy
+CONFIG_MOUSE_PS2_ALPS=3Dy
+CONFIG_MOUSE_PS2_LOGIPS2PP=3Dy
+CONFIG_MOUSE_PS2_SYNAPTICS=3Dy
+CONFIG_MOUSE_PS2_LIFEBOOK=3Dy
+CONFIG_MOUSE_PS2_TRACKPOINT=3Dy
+# CONFIG_MOUSE_PS2_TOUCHKIT is not set
+# CONFIG_MOUSE_SERIAL is not set
+# CONFIG_MOUSE_VSXXXAA is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Hardware I/O ports
+#
+CONFIG_SERIO=3Dy
+# CONFIG_SERIO_I8042 is not set
+CONFIG_SERIO_SERPORT=3Dy
+# CONFIG_SERIO_PCIPS2 is not set
+CONFIG_SERIO_LIBPS2=3Dy
+# CONFIG_SERIO_XILINXPS2 is not set
+# CONFIG_SERIO_RAW is not set
+# CONFIG_GAMEPORT is not set
+
+#
+# Character devices
+#
+CONFIG_VT=3Dy
+CONFIG_VT_CONSOLE=3Dy
+CONFIG_HW_CONSOLE=3Dy
+# CONFIG_VT_HW_CONSOLE_BINDING is not set
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+CONFIG_SERIAL_8250=3Dy
+CONFIG_SERIAL_8250_CONSOLE=3Dy
+CONFIG_SERIAL_8250_PCI=3Dy
+CONFIG_SERIAL_8250_NR_UARTS=3D4
+CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4
+# CONFIG_SERIAL_8250_EXTENDED is not set
+
+#
+# Non-8250 serial port support
+#
+# CONFIG_SERIAL_UARTLITE is not set
+CONFIG_SERIAL_CORE=3Dy
+CONFIG_SERIAL_CORE_CONSOLE=3Dy
+# CONFIG_SERIAL_JSM is not set
+CONFIG_SERIAL_OF_PLATFORM=3Dy
+CONFIG_UNIX98_PTYS=3Dy
+CONFIG_LEGACY_PTYS=3Dy
+CONFIG_LEGACY_PTY_COUNT=3D256
+# CONFIG_IPMI_HANDLER is not set
+CONFIG_HW_RANDOM=3Dm
+# CONFIG_NVRAM is not set
+# CONFIG_GEN_RTC is not set
+# CONFIG_XILINX_GPIO is not set
+# CONFIG_XILINX_HWICAP is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+# CONFIG_RAW_DRIVER is not set
+# CONFIG_TCG_TPM is not set
+CONFIG_DEVPORT=3Dy
+CONFIG_I2C=3Dy
+CONFIG_I2C_BOARDINFO=3Dy
+CONFIG_I2C_CHARDEV=3Dy
+
+#
+# I2C Algorithms
+#
+# CONFIG_I2C_ALGOBIT is not set
+# CONFIG_I2C_ALGOPCF is not set
+# CONFIG_I2C_ALGOPCA is not set
+CONFIG_XILINX_IIC=3Dy
+
+#
+# I2C Hardware Bus support
+#
+# CONFIG_I2C_ALI1535 is not set
+# CONFIG_I2C_ALI1563 is not set
+# CONFIG_I2C_ALI15X3 is not set
+# CONFIG_I2C_AMD756 is not set
+# CONFIG_I2C_AMD8111 is not set
+# CONFIG_I2C_I801 is not set
+# CONFIG_I2C_I810 is not set
+# CONFIG_I2C_PIIX4 is not set
+# CONFIG_I2C_MPC is not set
+# CONFIG_I2C_NFORCE2 is not set
+# CONFIG_I2C_OCORES is not set
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_PROSAVAGE is not set
+# CONFIG_I2C_SAVAGE4 is not set
+# CONFIG_I2C_SIMTEC is not set
+# CONFIG_I2C_SIS5595 is not set
+# CONFIG_I2C_SIS630 is not set
+# CONFIG_I2C_SIS96X is not set
+# CONFIG_I2C_TAOS_EVM is not set
+# CONFIG_I2C_STUB is not set
+# CONFIG_I2C_VIA is not set
+# CONFIG_I2C_VIAPRO is not set
+# CONFIG_I2C_VOODOO3 is not set
+
+#
+# Miscellaneous I2C Chip support
+#
+# CONFIG_SENSORS_DS1337 is not set
+# CONFIG_SENSORS_DS1374 is not set
+# CONFIG_DS1682 is not set
+# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_SENSORS_PCF8574 is not set
+# CONFIG_SENSORS_PCA9539 is not set
+# CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_SENSORS_M41T00 is not set
+# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_SENSORS_TSL2550 is not set
+CONFIG_I2C_DEBUG_CORE=3Dy
+CONFIG_I2C_DEBUG_ALGO=3Dy
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
+
+#
+# SPI support
+#
+# CONFIG_SPI is not set
+# CONFIG_SPI_MASTER is not set
+# CONFIG_W1 is not set
+# CONFIG_POWER_SUPPLY is not set
+# CONFIG_HWMON is not set
+# CONFIG_WATCHDOG is not set
+
+#
+# Sonics Silicon Backplane
+#
+CONFIG_SSB_POSSIBLE=3Dy
+# CONFIG_SSB is not set
+
+#
+# Multifunction device drivers
+#
+# CONFIG_MFD_SM501 is not set
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+# CONFIG_DVB_CORE is not set
+# CONFIG_DAB is not set
+
+#
+# Graphics support
+#
+# CONFIG_AGP is not set
+# CONFIG_DRM is not set
+# CONFIG_VGASTATE is not set
+# CONFIG_VIDEO_OUTPUT_CONTROL is not set
+CONFIG_FB=3Dy
+# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_FB_DDC is not set
+CONFIG_FB_CFB_FILLRECT=3Dy
+CONFIG_FB_CFB_COPYAREA=3Dy
+CONFIG_FB_CFB_IMAGEBLIT=3Dy
+# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
+# CONFIG_FB_SYS_FILLRECT is not set
+# CONFIG_FB_SYS_COPYAREA is not set
+# CONFIG_FB_SYS_IMAGEBLIT is not set
+# CONFIG_FB_SYS_FOPS is not set
+CONFIG_FB_DEFERRED_IO=3Dy
+# CONFIG_FB_SVGALIB is not set
+# CONFIG_FB_MACMODES is not set
+# CONFIG_FB_BACKLIGHT is not set
+# CONFIG_FB_MODE_HELPERS is not set
+# CONFIG_FB_TILEBLITTING is not set
+
+#
+# Frame buffer hardware drivers
+#
+# CONFIG_FB_CIRRUS is not set
+# CONFIG_FB_PM2 is not set
+# CONFIG_FB_CYBER2000 is not set
+# CONFIG_FB_OF is not set
+# CONFIG_FB_CT65550 is not set
+# CONFIG_FB_ASILIANT is not set
+# CONFIG_FB_IMSTT is not set
+# CONFIG_FB_VGA16 is not set
+# CONFIG_FB_S1D13XXX is not set
+# CONFIG_FB_NVIDIA is not set
+# CONFIG_FB_RIVA is not set
+# CONFIG_FB_MATROX is not set
+# CONFIG_FB_RADEON is not set
+# CONFIG_FB_ATY128 is not set
+# CONFIG_FB_ATY is not set
+# CONFIG_FB_S3 is not set
+# CONFIG_FB_SAVAGE is not set
+# CONFIG_FB_SIS is not set
+# CONFIG_FB_NEOMAGIC is not set
+# CONFIG_FB_KYRO is not set
+# CONFIG_FB_3DFX is not set
+# CONFIG_FB_VOODOO1 is not set
+# CONFIG_FB_VT8623 is not set
+# CONFIG_FB_TRIDENT is not set
+# CONFIG_FB_ARK is not set
+# CONFIG_FB_PM3 is not set
+# CONFIG_FB_IBM_GXT4500 is not set
+CONFIG_FB_XILINX=3Dy
+# CONFIG_FB_VIRTUAL is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Display device support
+#
+# CONFIG_DISPLAY_SUPPORT is not set
+
+#
+# Console display driver support
+#
+CONFIG_DUMMY_CONSOLE=3Dy
+CONFIG_FRAMEBUFFER_CONSOLE=3Dy
+# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
+# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
+CONFIG_FONTS=3Dy
+CONFIG_FONT_8x8=3Dy
+CONFIG_FONT_8x16=3Dy
+# CONFIG_FONT_6x11 is not set
+# CONFIG_FONT_7x14 is not set
+# CONFIG_FONT_PEARL_8x8 is not set
+# CONFIG_FONT_ACORN_8x8 is not set
+# CONFIG_FONT_MINI_4x6 is not set
+# CONFIG_FONT_SUN8x16 is not set
+# CONFIG_FONT_SUN12x22 is not set
+# CONFIG_FONT_10x18 is not set
+CONFIG_LOGO=3Dy
+CONFIG_LOGO_LINUX_MONO=3Dy
+CONFIG_LOGO_LINUX_VGA16=3Dy
+CONFIG_LOGO_LINUX_CLUT224=3Dy
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+# CONFIG_HID_SUPPORT is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_MMC is not set
+# CONFIG_NEW_LEDS is not set
+# CONFIG_INFINIBAND is not set
+# CONFIG_EDAC is not set
+# CONFIG_RTC_CLASS is not set
+CONFIG_XILINX_EDK=3Dy
+CONFIG_XILINX_LLDMA_USE_DCR=3Dy
+
+#
+# Userspace I/O
+#
+# CONFIG_UIO is not set
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=3Dy
+# CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT2_FS_XIP is not set
+# CONFIG_EXT3_FS is not set
+# CONFIG_EXT4DEV_FS is not set
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
+# CONFIG_OCFS2_FS is not set
+# CONFIG_MINIX_FS is not set
+CONFIG_ROMFS_FS=3Dy
+CONFIG_INOTIFY=3Dy
+CONFIG_INOTIFY_USER=3Dy
+# CONFIG_QUOTA is not set
+CONFIG_DNOTIFY=3Dy
+CONFIG_AUTOFS_FS=3Dy
+CONFIG_AUTOFS4_FS=3Dy
+CONFIG_FUSE_FS=3Dm
+
+#
+# CD-ROM/DVD Filesystems
+#
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+CONFIG_FAT_FS=3Dy
+CONFIG_MSDOS_FS=3Dy
+CONFIG_VFAT_FS=3Dy
+CONFIG_FAT_DEFAULT_CODEPAGE=3D437
+CONFIG_FAT_DEFAULT_IOCHARSET=3D"iso8859-1"
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=3Dy
+# CONFIG_PROC_KCORE is not set
+CONFIG_PROC_SYSCTL=3Dy
+CONFIG_SYSFS=3Dy
+CONFIG_TMPFS=3Dy
+# CONFIG_TMPFS_POSIX_ACL is not set
+# CONFIG_HUGETLB_PAGE is not set
+# CONFIG_CONFIGFS_FS is not set
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+CONFIG_CRAMFS=3Dy
+# CONFIG_VXFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+CONFIG_NETWORK_FILESYSTEMS=3Dy
+CONFIG_NFS_FS=3Dy
+CONFIG_NFS_V3=3Dy
+# CONFIG_NFS_V3_ACL is not set
+# CONFIG_NFS_V4 is not set
+# CONFIG_NFS_DIRECTIO is not set
+CONFIG_NFSD=3Dy
+CONFIG_NFSD_V3=3Dy
+# CONFIG_NFSD_V3_ACL is not set
+# CONFIG_NFSD_V4 is not set
+# CONFIG_NFSD_TCP is not set
+CONFIG_ROOT_NFS=3Dy
+CONFIG_LOCKD=3Dy
+CONFIG_LOCKD_V4=3Dy
+CONFIG_EXPORTFS=3Dy
+CONFIG_NFS_COMMON=3Dy
+CONFIG_SUNRPC=3Dy
+# CONFIG_SUNRPC_BIND34 is not set
+# CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+CONFIG_SMB_FS=3Dy
+# CONFIG_SMB_NLS_DEFAULT is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=3Dy
+CONFIG_NLS=3Dy
+CONFIG_NLS_DEFAULT=3D"iso8859-1"
+CONFIG_NLS_CODEPAGE_437=3Dy
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+# CONFIG_NLS_CODEPAGE_850 is not set
+# CONFIG_NLS_CODEPAGE_852 is not set
+# CONFIG_NLS_CODEPAGE_855 is not set
+# CONFIG_NLS_CODEPAGE_857 is not set
+# CONFIG_NLS_CODEPAGE_860 is not set
+# CONFIG_NLS_CODEPAGE_861 is not set
+# CONFIG_NLS_CODEPAGE_862 is not set
+# CONFIG_NLS_CODEPAGE_863 is not set
+# CONFIG_NLS_CODEPAGE_864 is not set
+# CONFIG_NLS_CODEPAGE_865 is not set
+# CONFIG_NLS_CODEPAGE_866 is not set
+# CONFIG_NLS_CODEPAGE_869 is not set
+# CONFIG_NLS_CODEPAGE_936 is not set
+# CONFIG_NLS_CODEPAGE_950 is not set
+# CONFIG_NLS_CODEPAGE_932 is not set
+# CONFIG_NLS_CODEPAGE_949 is not set
+# CONFIG_NLS_CODEPAGE_874 is not set
+# CONFIG_NLS_ISO8859_8 is not set
+# CONFIG_NLS_CODEPAGE_1250 is not set
+# CONFIG_NLS_CODEPAGE_1251 is not set
+CONFIG_NLS_ASCII=3Dm
+CONFIG_NLS_ISO8859_1=3Dm
+# CONFIG_NLS_ISO8859_2 is not set
+# CONFIG_NLS_ISO8859_3 is not set
+# CONFIG_NLS_ISO8859_4 is not set
+# CONFIG_NLS_ISO8859_5 is not set
+# CONFIG_NLS_ISO8859_6 is not set
+# CONFIG_NLS_ISO8859_7 is not set
+# CONFIG_NLS_ISO8859_9 is not set
+# CONFIG_NLS_ISO8859_13 is not set
+# CONFIG_NLS_ISO8859_14 is not set
+# CONFIG_NLS_ISO8859_15 is not set
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+CONFIG_NLS_UTF8=3Dm
+# CONFIG_DLM is not set
+# CONFIG_UCC_SLOW is not set
+
+#
+# Library routines
+#
+CONFIG_BITREVERSE=3Dy
+CONFIG_CRC_CCITT=3Dy
+# CONFIG_CRC16 is not set
+# CONFIG_CRC_ITU_T is not set
+CONFIG_CRC32=3Dy
+# CONFIG_CRC7 is not set
+# CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=3Dy
+CONFIG_PLIST=3Dy
+CONFIG_HAS_IOMEM=3Dy
+CONFIG_HAS_IOPORT=3Dy
+CONFIG_HAS_DMA=3Dy
+CONFIG_INSTRUMENTATION=3Dy
+# CONFIG_PROFILING is not set
+# CONFIG_KPROBES is not set
+# CONFIG_MARKERS is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_WARN_DEPRECATED=3Dy
+CONFIG_ENABLE_MUST_CHECK=3Dy
+# CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_UNUSED_SYMBOLS is not set
+# CONFIG_DEBUG_FS is not set
+# CONFIG_HEADERS_CHECK is not set
+# CONFIG_DEBUG_KERNEL is not set
+CONFIG_DEBUG_BUGVERBOSE=3Dy
+# CONFIG_SAMPLES is not set
+# CONFIG_PPC_EARLY_DEBUG is not set
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY is not set
+# CONFIG_SECURITY_FILE_CAPABILITIES is not set
+# CONFIG_CRYPTO is not set
+# CONFIG_PPC_CLOCK is not set
diff --git a/arch/powerpc/platforms/44x/Kconfig
b/arch/powerpc/platforms/44x/Kconfig
index 6abe913..b90b33d 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -102,6 +102,58 @@ config YOSEMITE
 #	help
 #	  This option enables support for the IBM PPC440GX evaluation
board.
 =

+config XILINX_ML507
+	bool "Xilinx ML507 Reference System"
+	depends on 44x
+	default n
+	select XILINX_ML5XX
+	select WANT_DEVICE_TREE
+	help
+	  This option enables support for the Xilinx ML507 board.
+
+config XILINX_DISABLE_44x_CACHE
+	bool "Disable PPC440 caches"
+	depends on XILINX_ML507
+	help
+	  This option allows to disable the caches on the PPC440. Some
early
+	  PPC440 soft-cores do not work with caches enabled. Also, some
early
+	  ML507 boards do have a non-functioning cache. If you have any
+	  problems running the ML5, try using this option.
+
+config PPC_FPU
+	depends on XILINX_VIRTEX_5_FXT
+	bool "Enable Xilinx Soft FPU"
+	help
+	  This option enables the Xilinx Soft FPU attached to the APU
+	  interface of the PPC440 (requires DP_FULL FPU pcore).
+
+config XILINX_ERRONEOUS_EXCEPTIONS_WORKAROUND
+	depends on XILINX_VIRTEX_5_FXT && PPC_FPU
+	bool "Enable Spurious Program Exceptions Workaround"
+	default y
+	help
+	  This option enables a workaround for a bug in the APU
controller of
+	  the PPC440 processor block in Virtex-5 FXT. See the answer
record
+	  at http://www.xilinx.com/support/answers/30579.htm for more
details.
+
+config XILINX_FPU_LOAD_CORRUPTION_WORKAROUND
+	depends on XILINX_VIRTEX_5_FXT && PPC_FPU
+	bool "Enable Xilinx FPU prefetch workaround"
+	default y
+	help
+	  This option enables a workaround for a bug in the APU
controller of
+	  the PPC440 processor block in Virtex-5 FXT. See the answer
record at
+	  http://www.xilinx.com/support/answers/30529.htm for more
details.
+
+config XILINX_FPU_ITLB_EXCEPTION_WORKAROUND
+	depends on XILINX_VIRTEX_5_FXT && PPC_FPU
+	bool "Enable Xilinx FPU TLB instruction miss workaround"
+	default y
+	help
+	  This option enables a workaround for a bug in the APU
controller of
+	  the PPC440 processor block in Virtex-5 FXT. See the answer
record at
+	  http://www.xilinx.com/support/answers/30570.htm for more
details.
+
 # 44x specific CPU modules, selected based on the board above.
 config 440EP
 	bool
@@ -152,3 +204,13 @@ config 460EX
 # 44x errata/workaround config symbols, selected by the CPU models
above
 config IBM440EP_ERR42
 	bool
+
+# Xilinx specific config options.
+config XILINX_ML5XX
+	bool
+	select XILINX_VIRTEX
+
+config XILINX_VIRTEX_5_FXT
+	bool
+	depends on XILINX_ML507
+	default y
diff --git a/arch/powerpc/platforms/44x/Makefile
b/arch/powerpc/platforms/44x/Makefile
index 774165f..e3a9337 100644
--- a/arch/powerpc/platforms/44x/Makefile
+++ b/arch/powerpc/platforms/44x/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_TAISHAN)	+=3D taishan.o
 obj-$(CONFIG_BAMBOO)	+=3D bamboo.o
 obj-$(CONFIG_YOSEMITE)	+=3D bamboo.o
 obj-$(CONFIG_SEQUOIA)	+=3D sequoia.o
+obj-$(CONFIG_XILINX_ML507)	+=3D virtex.o
 obj-$(CONFIG_KATMAI)	+=3D katmai.o
 obj-$(CONFIG_RAINIER)	+=3D rainier.o
 obj-$(CONFIG_WARP)	+=3D warp.o
diff --git a/arch/powerpc/platforms/44x/virtex.c
b/arch/powerpc/platforms/44x/virtex.c
new file mode 100644
index 0000000..42ca337
--- /dev/null
+++ b/arch/powerpc/platforms/44x/virtex.c
@@ -0,0 +1,58 @@
+/*
+ * Xilinx Virtex 5FXT based board support
+ *
+ * Copyright 2007 Secret Lab Technologies Ltd.
+ *
+ * This file is licensed under the terms of the GNU General Public
License
+ * version 2. This program is licensed "as is" without any warranty of
any
+ * kind, whether express or implied.
+ */
+
+#include <linux/init.h>
+#include <linux/of_platform.h>
+#include <asm/machdep.h>
+#include <asm/prom.h>
+#include <asm/time.h>
+#include <asm/xilinx_intc.h>
+#include <asm/reg.h>
+#include <asm/ppc4xx.h>
+#include "44x.h"
+
+static struct of_device_id xilinx_of_bus_ids[] __initdata =3D {
+	{ .compatible =3D "simple-bus", },
+	{ .compatible =3D "xlnx,plb-v46-1.00.a", },
+	{ .compatible =3D "xlnx,plb-v46-1.02.a", },
+	{ .compatible =3D "xlnx,plb-v34-1.01.a", },
+	{ .compatible =3D "xlnx,plb-v34-1.02.a", },
+	{ .compatible =3D "xlnx,opb-v20-1.10.c", },
+	{ .compatible =3D "xlnx,dcr-v29-1.00.a", },
+	{ .compatible =3D "xlnx,compound", },
+	{}
+};
+
+static int __init virtex_device_probe(void)
+{
+	of_platform_bus_probe(NULL, xilinx_of_bus_ids, NULL);
+
+	return 0;
+}
+machine_device_initcall(virtex, virtex_device_probe);
+
+static int __init virtex_probe(void)
+{
+	unsigned long root =3D of_get_flat_dt_root();
+
+	if (!of_flat_dt_is_compatible(root, "xlnx,virtex"))
+		return 0;
+
+	return 1;
+}
+
+define_machine(virtex) {
+	.name			=3D "Xilinx Virtex",
+	.probe			=3D virtex_probe,
+	.init_IRQ		=3D xilinx_intc_init_tree,
+	.get_irq		=3D xilinx_intc_get_irq,
+	.calibrate_decr		=3D generic_calibrate_decr,
+	.restart                =3D ppc4xx_reset_system,
+};
diff --git a/arch/powerpc/platforms/Kconfig
b/arch/powerpc/platforms/Kconfig
index 87454c5..523388b 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -313,6 +313,13 @@ config FSL_ULI1575
 config CPM
 	bool
 =

+config XILINX_VIRTEX
+	bool
+	select PPC_DCR_MMIO
+	select PPC_DCR_NATIVE
+	help
+	  Support for Xilinx Virtex platforms.
+
 config OF_RTC
 	bool
 	help
-- =

1.5.2.1


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
