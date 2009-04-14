Return-Path: <thunderbird2k@gmail.com>
Received: from mx.utwente.nl (mx2.utsp.utwente.nl [130.89.2.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 77231DE0CE
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 00:59:37 +1000 (EST)
Subject: Patch 2/2: Add Xilinx ML510 reference design support
From: Roderick Colenbrander <thunderbird2k@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Tue, 14 Apr 2009 16:59:10 +0200
Message-Id: <1239721150.27976.2.camel@CE202>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>From f46fa90e4d066767cc4fc1c5b8dc2f9ee013ea0a Mon Sep 17 00:00:00 2001
From: Roderick Colenbrander <thunderbird2k@gmail.com>
Date: Tue, 14 Apr 2009 15:49:32 +0200
Subject: [PATCH] Add Xilinx ML510 reference design support.

---
 arch/powerpc/boot/dts/virtex440-ml510.dts |  453 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/44x/Kconfig        |   10 +
 arch/powerpc/platforms/44x/Makefile       |    1 +
 arch/powerpc/platforms/44x/ml510.c        |  161 ++++++++++
 4 files changed, 625 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/virtex440-ml510.dts
 create mode 100644 arch/powerpc/platforms/44x/ml510.c

diff --git a/arch/powerpc/boot/dts/virtex440-ml510.dts b/arch/powerpc/boot/dts/virtex440-ml510.dts
new file mode 100644
index 0000000..7ded73c
--- /dev/null
+++ b/arch/powerpc/boot/dts/virtex440-ml510.dts
@@ -0,0 +1,453 @@
+/*
+ * Xilinx ML510 Reference Design support
+ * This DTS file was created for the ml510_bsb1_pcores_ppc440 reference design.
+ * The reference design contains a bug which prevent PCI DMA from working properly.
+ * A description of the bug is given in the plbv46_pci section. It needs to be fixed
+ * by the user until Xilinx updates their reference design.
+ *
+ * Copyright 2009, Roderick Colenbrander
+ */
+
+/dts-v1/;
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "xlnx,ml510-ref-design";
+	dcr-parent = <&ppc440_0>;
+	model = "testing";
+	DDR2_SDRAM_DIMM0: memory@0 {
+		device_type = "memory";
+		reg = < 0x0 0x20000000 >;
+	} ;
+	alias {
+		ethernet0 = &Hard_Ethernet_MAC;
+		serial0 = &RS232_Uart_1;
+	} ;
+	chosen {
+                bootargs = "console=ttyS0 root=/dev/xsa2 init=/etc/preinit";
+//                bootargs = "console=ttyS0 root=/dev/ram";
+                linux,stdout-path = "/plb@0/serial@83e00000";
+	} ;
+	cpus {
+		#address-cells = <1>;
+		#cpus = <0x1>;
+		#size-cells = <0>;
+		ppc440_0: cpu@0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clock-frequency = <300000000>;
+			compatible = "PowerPC,440", "ibm,ppc440";
+			d-cache-line-size = <0x20>;
+			d-cache-size = <0x8000>;
+			dcr-access-method = "native";
+			dcr-controller ;
+			device_type = "cpu";
+			i-cache-line-size = <0x20>;
+			i-cache-size = <0x8000>;
+			model = "PowerPC,440";
+			reg = <0>;
+			timebase-frequency = <300000000>;
+			xlnx,apu-control = <0x2000>;
+			xlnx,apu-udi-0 = <0x0>;
+			xlnx,apu-udi-1 = <0x0>;
+			xlnx,apu-udi-10 = <0x0>;
+			xlnx,apu-udi-11 = <0x0>;
+			xlnx,apu-udi-12 = <0x0>;
+			xlnx,apu-udi-13 = <0x0>;
+			xlnx,apu-udi-14 = <0x0>;
+			xlnx,apu-udi-15 = <0x0>;
+			xlnx,apu-udi-2 = <0x0>;
+			xlnx,apu-udi-3 = <0x0>;
+			xlnx,apu-udi-4 = <0x0>;
+			xlnx,apu-udi-5 = <0x0>;
+			xlnx,apu-udi-6 = <0x0>;
+			xlnx,apu-udi-7 = <0x0>;
+			xlnx,apu-udi-8 = <0x0>;
+			xlnx,apu-udi-9 = <0x0>;
+			xlnx,dcr-autolock-enable = <0x1>;
+			xlnx,dcu-rd-ld-cache-plb-prio = <0x0>;
+			xlnx,dcu-rd-noncache-plb-prio = <0x0>;
+			xlnx,dcu-rd-touch-plb-prio = <0x0>;
+			xlnx,dcu-rd-urgent-plb-prio = <0x0>;
+			xlnx,dcu-wr-flush-plb-prio = <0x0>;
+			xlnx,dcu-wr-store-plb-prio = <0x0>;
+			xlnx,dcu-wr-urgent-plb-prio = <0x0>;
+			xlnx,dma0-control = <0x0>;
+			xlnx,dma0-plb-prio = <0x0>;
+			xlnx,dma0-rxchannelctrl = <0x1010000>;
+			xlnx,dma0-rxirqtimer = <0x3ff>;
+			xlnx,dma0-txchannelctrl = <0x1010000>;
+			xlnx,dma0-txirqtimer = <0x3ff>;
+			xlnx,dma1-control = <0x0>;
+			xlnx,dma1-plb-prio = <0x0>;
+			xlnx,dma1-rxchannelctrl = <0x1010000>;
+			xlnx,dma1-rxirqtimer = <0x3ff>;
+			xlnx,dma1-txchannelctrl = <0x1010000>;
+			xlnx,dma1-txirqtimer = <0x3ff>;
+			xlnx,dma2-control = <0x0>;
+			xlnx,dma2-plb-prio = <0x0>;
+			xlnx,dma2-rxchannelctrl = <0x1010000>;
+			xlnx,dma2-rxirqtimer = <0x3ff>;
+			xlnx,dma2-txchannelctrl = <0x1010000>;
+			xlnx,dma2-txirqtimer = <0x3ff>;
+			xlnx,dma3-control = <0x0>;
+			xlnx,dma3-plb-prio = <0x0>;
+			xlnx,dma3-rxchannelctrl = <0x1010000>;
+			xlnx,dma3-rxirqtimer = <0x3ff>;
+			xlnx,dma3-txchannelctrl = <0x1010000>;
+			xlnx,dma3-txirqtimer = <0x3ff>;
+			xlnx,endian-reset = <0x0>;
+			xlnx,generate-plb-timespecs = <0x1>;
+			xlnx,icu-rd-fetch-plb-prio = <0x0>;
+			xlnx,icu-rd-spec-plb-prio = <0x0>;
+			xlnx,icu-rd-touch-plb-prio = <0x0>;
+			xlnx,interconnect-imask = <0xffffffff>;
+			xlnx,mplb-allow-lock-xfer = <0x1>;
+			xlnx,mplb-arb-mode = <0x0>;
+			xlnx,mplb-awidth = <0x20>;
+			xlnx,mplb-counter = <0x500>;
+			xlnx,mplb-dwidth = <0x80>;
+			xlnx,mplb-max-burst = <0x8>;
+			xlnx,mplb-native-dwidth = <0x80>;
+			xlnx,mplb-p2p = <0x0>;
+			xlnx,mplb-prio-dcur = <0x2>;
+			xlnx,mplb-prio-dcuw = <0x3>;
+			xlnx,mplb-prio-icu = <0x4>;
+			xlnx,mplb-prio-splb0 = <0x1>;
+			xlnx,mplb-prio-splb1 = <0x0>;
+			xlnx,mplb-read-pipe-enable = <0x1>;
+			xlnx,mplb-sync-tattribute = <0x0>;
+			xlnx,mplb-wdog-enable = <0x1>;
+			xlnx,mplb-write-pipe-enable = <0x1>;
+			xlnx,mplb-write-post-enable = <0x1>;
+			xlnx,num-dma = <0x0>;
+			xlnx,pir = <0xf>;
+			xlnx,ppc440mc-addr-base = <0x0>;
+			xlnx,ppc440mc-addr-high = <0x1fffffff>;
+			xlnx,ppc440mc-arb-mode = <0x0>;
+			xlnx,ppc440mc-bank-conflict-mask = <0x1800000>;
+			xlnx,ppc440mc-control = <0xf810008f>;
+			xlnx,ppc440mc-max-burst = <0x8>;
+			xlnx,ppc440mc-prio-dcur = <0x2>;
+			xlnx,ppc440mc-prio-dcuw = <0x3>;
+			xlnx,ppc440mc-prio-icu = <0x4>;
+			xlnx,ppc440mc-prio-splb0 = <0x1>;
+			xlnx,ppc440mc-prio-splb1 = <0x0>;
+			xlnx,ppc440mc-row-conflict-mask = <0x7ffe00>;
+			xlnx,ppcdm-asyncmode = <0x0>;
+			xlnx,ppcds-asyncmode = <0x0>;
+			xlnx,user-reset = <0x0>;
+		} ;
+	} ;
+	plb_v46_0: plb@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "xlnx,plb-v46-1.03.a", "simple-bus";
+		ranges ;
+		FLASH: flash@fc000000 {
+			bank-width = <2>;
+			compatible = "xlnx,xps-mch-emc-2.00.a", "cfi-flash";
+			reg = < 0xfc000000 0x2000000 >;
+			xlnx,family = "virtex5";
+			xlnx,include-datawidth-matching-0 = <0x1>;
+			xlnx,include-datawidth-matching-1 = <0x0>;
+			xlnx,include-datawidth-matching-2 = <0x0>;
+			xlnx,include-datawidth-matching-3 = <0x0>;
+			xlnx,include-negedge-ioregs = <0x0>;
+			xlnx,include-plb-ipif = <0x1>;
+			xlnx,include-wrbuf = <0x1>;
+			xlnx,max-mem-width = <0x10>;
+			xlnx,mch-native-dwidth = <0x20>;
+			xlnx,mch-plb-clk-period-ps = <0x2710>;
+			xlnx,mch-splb-awidth = <0x20>;
+			xlnx,mch0-accessbuf-depth = <0x10>;
+			xlnx,mch0-protocol = <0x0>;
+			xlnx,mch0-rddatabuf-depth = <0x10>;
+			xlnx,mch1-accessbuf-depth = <0x10>;
+			xlnx,mch1-protocol = <0x0>;
+			xlnx,mch1-rddatabuf-depth = <0x10>;
+			xlnx,mch2-accessbuf-depth = <0x10>;
+			xlnx,mch2-protocol = <0x0>;
+			xlnx,mch2-rddatabuf-depth = <0x10>;
+			xlnx,mch3-accessbuf-depth = <0x10>;
+			xlnx,mch3-protocol = <0x0>;
+			xlnx,mch3-rddatabuf-depth = <0x10>;
+			xlnx,mem0-width = <0x10>;
+			xlnx,mem1-width = <0x20>;
+			xlnx,mem2-width = <0x20>;
+			xlnx,mem3-width = <0x20>;
+			xlnx,num-banks-mem = <0x1>;
+			xlnx,num-channels = <0x2>;
+			xlnx,priority-mode = <0x0>;
+			xlnx,synch-mem-0 = <0x0>;
+			xlnx,synch-mem-1 = <0x0>;
+			xlnx,synch-mem-2 = <0x0>;
+			xlnx,synch-mem-3 = <0x0>;
+			xlnx,synch-pipedelay-0 = <0x2>;
+			xlnx,synch-pipedelay-1 = <0x2>;
+			xlnx,synch-pipedelay-2 = <0x2>;
+			xlnx,synch-pipedelay-3 = <0x2>;
+			xlnx,tavdv-ps-mem-0 = <0x1adb0>;
+			xlnx,tavdv-ps-mem-1 = <0x3a98>;
+			xlnx,tavdv-ps-mem-2 = <0x3a98>;
+			xlnx,tavdv-ps-mem-3 = <0x3a98>;
+			xlnx,tcedv-ps-mem-0 = <0x1adb0>;
+			xlnx,tcedv-ps-mem-1 = <0x3a98>;
+			xlnx,tcedv-ps-mem-2 = <0x3a98>;
+			xlnx,tcedv-ps-mem-3 = <0x3a98>;
+			xlnx,thzce-ps-mem-0 = <0x88b8>;
+			xlnx,thzce-ps-mem-1 = <0x1b58>;
+			xlnx,thzce-ps-mem-2 = <0x1b58>;
+			xlnx,thzce-ps-mem-3 = <0x1b58>;
+			xlnx,thzoe-ps-mem-0 = <0x1b58>;
+			xlnx,thzoe-ps-mem-1 = <0x1b58>;
+			xlnx,thzoe-ps-mem-2 = <0x1b58>;
+			xlnx,thzoe-ps-mem-3 = <0x1b58>;
+			xlnx,tlzwe-ps-mem-0 = <0x88b8>;
+			xlnx,tlzwe-ps-mem-1 = <0x0>;
+			xlnx,tlzwe-ps-mem-2 = <0x0>;
+			xlnx,tlzwe-ps-mem-3 = <0x0>;
+			xlnx,twc-ps-mem-0 = <0x1adb0>;
+			xlnx,twc-ps-mem-1 = <0x3a98>;
+			xlnx,twc-ps-mem-2 = <0x3a98>;
+			xlnx,twc-ps-mem-3 = <0x3a98>;
+			xlnx,twp-ps-mem-0 = <0x11170>;
+			xlnx,twp-ps-mem-1 = <0x2ee0>;
+			xlnx,twp-ps-mem-2 = <0x2ee0>;
+			xlnx,twp-ps-mem-3 = <0x2ee0>;
+			xlnx,xcl0-linesize = <0x4>;
+			xlnx,xcl0-writexfer = <0x1>;
+			xlnx,xcl1-linesize = <0x4>;
+			xlnx,xcl1-writexfer = <0x1>;
+			xlnx,xcl2-linesize = <0x4>;
+			xlnx,xcl2-writexfer = <0x1>;
+			xlnx,xcl3-linesize = <0x4>;
+			xlnx,xcl3-writexfer = <0x1>;
+		} ;
+		Hard_Ethernet_MAC: xps-ll-temac@81c00000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "xlnx,compound";
+			ethernet@81c00000 {
+				compatible = "xlnx,xps-ll-temac-1.01.b";
+				device_type = "network";
+				interrupt-parent = <&xps_intc_0>;
+				interrupts = < 8 2 >;
+				llink-connected = <&Hard_Ethernet_MAC_fifo>;
+				local-mac-address = [ 02 00 00 00 00 00 ];
+				reg = < 0x81c00000 0x40 >;
+				xlnx,bus2core-clk-ratio = <0x1>;
+				xlnx,phy-type = <0x3>;
+				xlnx,phyaddr = <0x1>;
+				xlnx,rxcsum = <0x0>;
+				xlnx,rxfifo = <0x8000>;
+				xlnx,temac-type = <0x0>;
+				xlnx,txcsum = <0x0>;
+				xlnx,txfifo = <0x8000>;
+			} ;
+		} ;
+		Hard_Ethernet_MAC_fifo: xps-ll-fifo@81a00000 {
+			compatible = "xlnx,xps-ll-fifo-1.01.a";
+			interrupt-parent = <&xps_intc_0>;
+			interrupts = < 6 2 >;
+			reg = < 0x81a00000 0x10000 >;
+			xlnx,family = "virtex5";
+		} ;
+		IIC_EEPROM: i2c@81600000 {
+			compatible = "xlnx,xps-iic-2.00.a";
+			interrupt-parent = <&xps_intc_0>;
+			interrupts = < 9 2 >;
+			reg = < 0x81600000 0x10000 >;
+			xlnx,clk-freq = <0x5f5e100>;
+			xlnx,family = "virtex5";
+			xlnx,gpo-width = <0x1>;
+			xlnx,iic-freq = <0x186a0>;
+			xlnx,scl-inertial-delay = <0x5>;
+			xlnx,sda-inertial-delay = <0x5>;
+			xlnx,ten-bit-adr = <0x0>;
+		} ;
+		LCD_OPTIONAL: gpio@81420000 {
+			compatible = "xlnx,xps-gpio-1.00.a";
+			reg = < 0x81420000 0x10000 >;
+			xlnx,all-inputs = <0x0>;
+			xlnx,all-inputs-2 = <0x0>;
+			xlnx,dout-default = <0x0>;
+			xlnx,dout-default-2 = <0x0>;
+			xlnx,family = "virtex5";
+			xlnx,gpio-width = <0xb>;
+			xlnx,interrupt-present = <0x0>;
+			xlnx,is-bidir = <0x1>;
+			xlnx,is-bidir-2 = <0x1>;
+			xlnx,is-dual = <0x0>;
+			xlnx,tri-default = <0xffffffff>;
+			xlnx,tri-default-2 = <0xffffffff>;
+		} ;
+		LEDs_4Bit: gpio@81400000 {
+			compatible = "xlnx,xps-gpio-1.00.a";
+			reg = < 0x81400000 0x10000 >;
+			xlnx,all-inputs = <0x0>;
+			xlnx,all-inputs-2 = <0x0>;
+			xlnx,dout-default = <0x0>;
+			xlnx,dout-default-2 = <0x0>;
+			xlnx,family = "virtex5";
+			xlnx,gpio-width = <0x4>;
+			xlnx,interrupt-present = <0x0>;
+			xlnx,is-bidir = <0x1>;
+			xlnx,is-bidir-2 = <0x1>;
+			xlnx,is-dual = <0x0>;
+			xlnx,tri-default = <0xffffffff>;
+			xlnx,tri-default-2 = <0xffffffff>;
+		} ;
+		RS232_Uart_1: serial@83e00000 {
+			clock-frequency = <100000000>;
+			compatible = "xlnx,xps-uart16550-2.00.b", "ns16550";
+			current-speed = <9600>;
+			device_type = "serial";
+			interrupt-parent = <&xps_intc_0>;
+			interrupts = < 11 2 >;
+			reg = < 0x83e00000 0x10000 >;
+			reg-offset = <0x1003>;
+			reg-shift = <2>;
+			xlnx,family = "virtex5";
+			xlnx,has-external-rclk = <0x0>;
+			xlnx,has-external-xin = <0x0>;
+			xlnx,is-a-16550 = <0x1>;
+		} ;
+		SPI_EEPROM: xps-spi@feff8000 {
+			compatible = "xlnx,xps-spi-2.00.b";
+			interrupt-parent = <&xps_intc_0>;
+			interrupts = < 10 2 >;
+			reg = < 0xfeff8000 0x80 >;
+			xlnx,family = "virtex5";
+			xlnx,fifo-exist = <0x1>;
+			xlnx,num-ss-bits = <0x1>;
+			xlnx,num-transfer-bits = <0x8>;
+			xlnx,sck-ratio = <0x80>;
+		} ;
+		SysACE_CompactFlash: sysace@83600000 {
+			compatible = "xlnx,xps-sysace-1.00.a";
+			interrupt-parent = <&xps_intc_0>;
+			interrupts = < 7 2 >;
+			reg = < 0x83600000 0x10000 >;
+			xlnx,family = "virtex5";
+			xlnx,mem-width = <0x10>;
+		} ;
+		plbv46_pci_0: plbv46-pci@85e00000 {
+			#size-cells = <2>;
+			#address-cells = <3>;
+			compatible = "xlnx,plbv46-pci-1.03.a";
+			device_type = "pci";
+			reg = < 0x85e00000 0x10000 >;
+			/* The default ML510 BSB has C_IPIFBAR2PCIBAR_0 set to 0 which means that a read/write to
+			 * the memory mapped i/o region (which starts at 0xa0000000) for pci bar 0 on the plb side
+			 * translates to 0.
+			 * It is important to this value to 0xa0000000, so that inbound and outbound pci transactions
+			 * work properly including DMA.
+			 */
+			ranges = <0x02000000 0x00000000 0xa0000000 0xa0000000 0x00000000 0x20000000
+				  0x01000000 0x00000000 0x00000000 0xf0000000 0x00000000 0x00010000>;
+
+			#interrupt-cells = <1>;
+			interrupt-parent = <&xps_intc_0>;
+			interrupt-map-mask = <0xff00 0x0 0x0 0x7>;
+			interrupt-map = <
+				/* IRQ mapping for pci slots and ALI M1533 periperhals. In total there are
+				 * 5 interrupt lines connected to a xps_intc controller. Four of them are PCI
+				 * IRQ A, B, C, D and which correspond to respectively xpx_intc 5, 4, 3 and 2.
+				 * The fifth interrupt line is connected to the south bridge and this one
+				 * uses irq 1 and is active high instead of active low.
+				 *
+				 * The M1533 contains various peripherals including AC97 audio, a modem, USB,
+				 * IDE and some power management stuff. The modem isn't connected on the ML510
+				 * and the power management core also isn't used.
+				 */
+
+				/* IDSEL 0x16 / dev=6, bus=0 / PCI slot 3 */
+				0x3000 0 0 1 &xps_intc_0 3 2
+				0x3000 0 0 2 &xps_intc_0 2 2
+				0x3000 0 0 3 &xps_intc_0 5 2
+				0x3000 0 0 4 &xps_intc_0 4 2
+
+				/* IDSEL 0x13 / dev=3, bus=1 / PCI slot 4 */
+				/*
+				0x11800 0 0 1 &xps_intc_0 5 0 2
+				0x11800 0 0 2 &xps_intc_0 4 0 2
+				0x11800 0 0 3 &xps_intc_0 3 0 2
+				0x11800 0 0 4 &xps_intc_0 2 0 2
+				*/
+
+				/* According to the datasheet + schematic ABCD [FPGA] of slot 5 is mapped to DABC.
+				 * Testing showed that at least A maps to B, the mapping of the other pins is a guess
+				 * and for that reason the lines have been commented.
+				 */
+				/* IDSEL 0x15 / dev=5, bus=0 / PCI slot 5 */
+				0x2800 0 0 1 &xps_intc_0 4 2
+				/*
+				0x2800 0 0 2 &xps_intc_0 3 2
+				0x2800 0 0 3 &xps_intc_0 2 2
+				0x2800 0 0 4 &xps_intc_0 5 2
+				*/
+
+				/* IDSEL 0x12 / dev=2, bus=1 / PCI slot 6 */
+				/*
+				0x11000 0 0 1 &xps_intc_0 4 0 2
+				0x11000 0 0 2 &xps_intc_0 3 0 2
+				0x11000 0 0 3 &xps_intc_0 2 0 2
+				0x11000 0 0 4 &xps_intc_0 5 0 2
+				*/
+
+				/* IDSEL 0x11 / dev=1, bus=0 / AC97 audio */
+				0x0800 0 0 1 &i8259 7 2
+
+				/* IDSEL 0x1b / dev=11, bus=0 / IDE */
+				0x5800 0 0 1 &i8259 14 2
+
+				/* IDSEL 0x1f / dev 15, bus=0 / 2x USB 1.1 */
+				0x7800 0 0 1 &i8259 7 2
+			>;
+			ali_m1533 {
+				#size-cells = <1>;
+				#address-cells = <2>;
+				i8259: interrupt-controller@20 {
+					reg = <1 0x20 2
+							1 0xa0 2
+							1 0x4d0 2>;
+					interrupt-controller;
+					device_type = "interrupt-controller";
+					#address-cells = <0>;
+					#interrupt-cells = <2>;
+					compatible = "chrp,iic";
+
+					/* The south bridge connection is active high */
+					interrupts = <1 3>;
+					interrupt-parent = <&xps_intc_0>;
+				};
+			};
+		} ;
+		xps_bram_if_cntlr_1: xps-bram-if-cntlr@ffff0000 {
+			compatible = "xlnx,xps-bram-if-cntlr-1.00.a";
+			reg = < 0xffff0000 0x10000 >;
+			xlnx,family = "virtex5";
+		} ;
+		xps_intc_0: interrupt-controller@81800000 {
+			#interrupt-cells = <0x2>;
+			compatible = "xlnx,xps-intc-1.00.a";
+			interrupt-controller ;
+			reg = < 0x81800000 0x10000 >;
+			xlnx,num-intr-inputs = <0xc>;
+		} ;
+		xps_tft_0: tft@86e00000 {
+			compatible = "xlnx,xps-tft-1.00.a";
+			reg = < 0x86e00000 0x10000 >;
+			xlnx,dcr-splb-slave-if = <0x1>;
+			xlnx,default-tft-base-addr = <0x0>;
+			xlnx,family = "virtex5";
+			xlnx,i2c-slave-addr = <0x76>;
+			xlnx,mplb-awidth = <0x20>;
+			xlnx,mplb-dwidth = <0x80>;
+			xlnx,mplb-native-dwidth = <0x40>;
+			xlnx,mplb-smallest-slave = <0x20>;
+			xlnx,tft-interface = <0x1>;
+		} ;
+	} ;
+}  ;
diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index bf5c7ff..cf706a7 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -171,6 +171,16 @@ config XILINX_VIRTEX440_GENERIC_BOARD
 	  Most Virtex 5 designs should use this unless it needs to do some
 	  special configuration at board probe time.
 
+config XILINX_ML510
+	bool "Xilinx ML510 Reference Design support"
+	depends on 44x
+	default n
+	select XILINX_VIRTEX_5_FXT
+	select PPC_PCI_CHOICE
+	select XILINX_VIRTEX_PCI if PCI
+	select PPC_INDIRECT_PCI if PCI
+	select PPC_I8259 if PCI
+
 config PPC44x_SIMPLE
 	bool "Simple PowerPC 44x board support"
 	depends on 44x
diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platforms/44x/Makefile
index 01f51da..6793f4e 100644
--- a/arch/powerpc/platforms/44x/Makefile
+++ b/arch/powerpc/platforms/44x/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_EBONY)	+= ebony.o
 obj-$(CONFIG_SAM440EP) 	+= sam440ep.o
 obj-$(CONFIG_WARP)	+= warp.o
 obj-$(CONFIG_XILINX_VIRTEX_5_FXT) += virtex.o
+obj-$(CONFIG_XILINX_ML510) += ml510.o
diff --git a/arch/powerpc/platforms/44x/ml510.c b/arch/powerpc/platforms/44x/ml510.c
new file mode 100644
index 0000000..c64d792
--- /dev/null
+++ b/arch/powerpc/platforms/44x/ml510.c
@@ -0,0 +1,161 @@
+/*
+ * Xilinx ML510 Reference Design support, derived from
+ * the generic Xilinx Virtex 5 board support
+ *
+ * Copyright 2007 Secret Lab Technologies Ltd.
+ * Copyright 2008 Xilinx, Inc.
+ * Copyright 2009 Roderick Colenbrander
+ *
+ * The i8259 cascade code was derived from 86xx/pic.c which is copyrighted by Freescale Semiconductor, Inc.
+ * Xilinx ML510 PCI initialization code, derived from the Xilinx ML300/ML410 based board support.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
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
+#ifdef CONFIG_PPC_I8259
+#include <asm/i8259.h>
+#endif
+#ifdef CONFIG_PCI
+#include <linux/pci.h>
+#endif
+#include "44x.h"
+
+static struct of_device_id xilinx_of_bus_ids[] __initdata = {
+	{ .compatible = "simple-bus", },
+	{ .compatible = "xlnx,plb-v46-1.00.a", },
+	{ .compatible = "xlnx,plb-v46-1.02.a", },
+	{ .compatible = "xlnx,plb-v34-1.01.a", },
+	{ .compatible = "xlnx,plb-v34-1.02.a", },
+	{ .compatible = "xlnx,opb-v20-1.10.c", },
+	{ .compatible = "xlnx,dcr-v29-1.00.a", },
+	{ .compatible = "xlnx,compound", },
+	{}
+};
+
+#ifdef CONFIG_PPC_I8259
+static void ml510_8259_cascade(unsigned int irq, struct irq_desc *desc)
+{
+	unsigned int cascade_irq = i8259_irq();
+	if (cascade_irq != NO_IRQ)
+		generic_handle_irq(cascade_irq);
+
+	/* Let xilinx_intc end the interrupt */
+	desc->chip->ack(irq);
+	desc->chip->unmask(irq);
+}
+
+static void __init ml510_setup_i8259_cascade(void)
+{
+	struct device_node *np, *cascade_node = NULL;
+	int cascade_irq;
+
+	/* Initialize i8259 controller */
+	for_each_node_by_type(np, "interrupt-controller")
+			if (of_device_is_compatible(np, "chrp,iic")) {
+					cascade_node = np;
+					break;
+			}
+
+	if (cascade_node == NULL) {
+			printk(KERN_DEBUG "Could not find i8259 PIC\n");
+			return;
+	}
+
+	cascade_irq = irq_of_parse_and_map(cascade_node, 0);
+	if (cascade_irq == NO_IRQ) {
+			printk(KERN_ERR "Failed to map cascade interrupt\n");
+			return;
+	}
+
+	i8259_init(cascade_node, 0);
+                
+	of_node_put(cascade_node);
+	set_irq_chained_handler(cascade_irq, ml510_8259_cascade);
+}
+#endif /* CONFIG_PPC_I8259 */
+
+#ifdef CONFIG_PCI
+static int ml510_pci_exclude_device(struct pci_controller *hose, u_char bus, u8 devfn)
+{
+	if (bus != 0)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	else
+		return PCIBIOS_SUCCESSFUL;
+}
+
+static void __devinit ali_quirk(struct pci_dev *dev)
+{
+	/* Enable the IDE controller */
+	pci_write_config_byte(dev, 0x58, 0x4c);
+	/* Assign irq 14 to the primary ide channel */
+	pci_write_config_byte(dev, 0x44, 0x0d);
+	/* Assign irq 15 to the secondary ide channel */
+	pci_write_config_byte(dev, 0x75, 0x0f);
+	/* Set the ide controller in native mode */
+	pci_write_config_byte(dev, 0x09, 0xff);
+
+	pci_write_config_byte(dev, 0x48, 0x00); // INTB = disabled, INTA = disabled
+	pci_write_config_byte(dev, 0x4a, 0x00); // INTD = disabled, INTC = disabled
+	pci_write_config_byte(dev, 0x4b, 0x00); // Audio = INT7, Modem = disabled.
+	pci_write_config_byte(dev, 0x74, 0x06); // USB = INT7
+}
+DECLARE_PCI_FIXUP_EARLY(0x10b9, 0x1533, ali_quirk);
+#endif /* CONFIG_PCI */
+
+static int __init ml510_device_probe(void)
+{
+	of_platform_bus_probe(NULL, xilinx_of_bus_ids, NULL);
+
+	return 0;
+}
+machine_device_initcall(ml510, ml510_device_probe);
+
+static int __init ml510_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	return of_flat_dt_is_compatible(root, "xlnx,ml510-ref-design");
+}
+
+void virtex_pci_init(void);
+static void __init ml510_setup_arch(void)
+{
+#ifdef CONFIG_PCI
+	/* Register the host bridge */
+	virtex_pci_init();
+#endif /* CONFIG_PCI */
+}
+
+static void ml510_init_IRQ(void)
+{
+	xilinx_intc_init_tree();
+
+#ifdef CONFIG_PPC_I8259
+	/* The devices on the ALI M1553 south bridge are connected to an internal i8259 */
+	ml510_setup_i8259_cascade();
+	/* Program irq 7 (usb/audio), 14/15 (ide) to level sensitive */
+	outb(0xc0, 0x4d0);
+	outb(0xc0, 0x4d1);
+#endif /* CONFIG_PPC_I8259 */
+}
+
+define_machine(ml510) {
+	.name					= "Xilinx ML510 Reference Design support",
+	.probe					= ml510_probe,
+	.setup_arch				= ml510_setup_arch,
+	.pci_exclude_device		= ml510_pci_exclude_device,
+	.init_IRQ				= ml510_init_IRQ,
+	.get_irq				= xilinx_intc_get_irq,
+	.calibrate_decr			= generic_calibrate_decr,
+	.restart				= ppc4xx_reset_system,
+};
-- 
1.5.6.3
