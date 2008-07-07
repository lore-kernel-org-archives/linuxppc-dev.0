Return-Path: <linnj@wolfgang-pc.public.xilinx.com>
Received: from IE1EHSOBE005.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16]) by ozlabs.org (Postfix) with ESMTP id 3D497DDF54
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 04:05:19 +1000 (EST)
From: John Linn <john.linn@xilinx.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [V2] powerpc: Xilinx: add dts file for ML507 board
Date: Mon, 7 Jul 2008 11:04:59 -0700
Message-ID: <20080707180508.4E2CBE8081@mail72-dub.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This new file adds support for the ML507 board which
has a Virtex 5 FXT FPGA with a 440.

Signed-off-by: John Linn <john.linn@xilinx.com>
---
V2
	Converted to dts-v1 format.
	Changed to match a newer reference design.

 arch/powerpc/boot/dts/virtex440-ml507.dts |  296 +++++++++++++++++++++++++++++
 1 files changed, 296 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/virtex440-ml507.dts

diff --git a/arch/powerpc/boot/dts/virtex440-ml507.dts b/arch/powerpc/boot/dts/virtex440-ml507.dts
new file mode 100644
index 0000000..d10a993
--- /dev/null
+++ b/arch/powerpc/boot/dts/virtex440-ml507.dts
@@ -0,0 +1,296 @@
+/*
+ * This file supports the Xilinx ML507 board with the 440 processor.
+ * A reference design for the FPGA is provided at http://git.xilinx.com.
+ *
+ * (C) Copyright 2008 Xilinx, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "xlnx,virtex440";
+	dcr-parent = <&ppc440_0>;
+	model = "testing";
+	DDR2_SDRAM: memory@0 {
+		device_type = "memory";
+		reg = < 0 0x10000000 >;
+	} ;
+	chosen {
+		bootargs = "console=ttyS0 ip=on root=/dev/ram";
+		linux,stdout-path = "/plb@0/serial@83e00000";
+	} ;
+	cpus {
+		#address-cells = <1>;
+		#cpus = <1>;
+		#size-cells = <0>;
+		ppc440_0: cpu@0 {
+			clock-frequency = "";
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
+			timebase-frequency = <0x17d78400>;
+			xlnx,apu-control = <1>;
+			xlnx,apu-udi-0 = <0>;
+			xlnx,apu-udi-1 = <0>;
+			xlnx,apu-udi-10 = <0>;
+			xlnx,apu-udi-11 = <0>;
+			xlnx,apu-udi-12 = <0>;
+			xlnx,apu-udi-13 = <0>;
+			xlnx,apu-udi-14 = <0>;
+			xlnx,apu-udi-15 = <0>;
+			xlnx,apu-udi-2 = <0>;
+			xlnx,apu-udi-3 = <0>;
+			xlnx,apu-udi-4 = <0>;
+			xlnx,apu-udi-5 = <0>;
+			xlnx,apu-udi-6 = <0>;
+			xlnx,apu-udi-7 = <0>;
+			xlnx,apu-udi-8 = <0>;
+			xlnx,apu-udi-9 = <0>;
+			xlnx,dcr-autolock-enable = <1>;
+			xlnx,dcu-rd-ld-cache-plb-prio = <0>;
+			xlnx,dcu-rd-noncache-plb-prio = <0>;
+			xlnx,dcu-rd-touch-plb-prio = <0>;
+			xlnx,dcu-rd-urgent-plb-prio = <0>;
+			xlnx,dcu-wr-flush-plb-prio = <0>;
+			xlnx,dcu-wr-store-plb-prio = <0>;
+			xlnx,dcu-wr-urgent-plb-prio = <0>;
+			xlnx,dma0-control = <0>;
+			xlnx,dma0-plb-prio = <0>;
+			xlnx,dma0-rxchannelctrl = <0x1010000>;
+			xlnx,dma0-rxirqtimer = <0x3ff>;
+			xlnx,dma0-txchannelctrl = <0x1010000>;
+			xlnx,dma0-txirqtimer = <0x3ff>;
+			xlnx,dma1-control = <0>;
+			xlnx,dma1-plb-prio = <0>;
+			xlnx,dma1-rxchannelctrl = <0x1010000>;
+			xlnx,dma1-rxirqtimer = <0x3ff>;
+			xlnx,dma1-txchannelctrl = <0x1010000>;
+			xlnx,dma1-txirqtimer = <0x3ff>;
+			xlnx,dma2-control = <0>;
+			xlnx,dma2-plb-prio = <0>;
+			xlnx,dma2-rxchannelctrl = <0x1010000>;
+			xlnx,dma2-rxirqtimer = <0x3ff>;
+			xlnx,dma2-txchannelctrl = <0x1010000>;
+			xlnx,dma2-txirqtimer = <0x3ff>;
+			xlnx,dma3-control = <0>;
+			xlnx,dma3-plb-prio = <0>;
+			xlnx,dma3-rxchannelctrl = <0x1010000>;
+			xlnx,dma3-rxirqtimer = <0x3ff>;
+			xlnx,dma3-txchannelctrl = <0x1010000>;
+			xlnx,dma3-txirqtimer = <0x3ff>;
+			xlnx,endian-reset = <0>;
+			xlnx,generate-plb-timespecs = <1>;
+			xlnx,icu-rd-fetch-plb-prio = <0>;
+			xlnx,icu-rd-spec-plb-prio = <0>;
+			xlnx,icu-rd-touch-plb-prio = <0>;
+			xlnx,interconnect-imask = <0xffffffff>;
+			xlnx,mplb-allow-lock-xfer = <1>;
+			xlnx,mplb-arb-mode = <0>;
+			xlnx,mplb-awidth = <0x20>;
+			xlnx,mplb-counter = <0x500>;
+			xlnx,mplb-dwidth = <0x80>;
+			xlnx,mplb-max-burst = <8>;
+			xlnx,mplb-native-dwidth = <0x80>;
+			xlnx,mplb-p2p = <0>;
+			xlnx,mplb-prio-dcur = <2>;
+			xlnx,mplb-prio-dcuw = <3>;
+			xlnx,mplb-prio-icu = <4>;
+			xlnx,mplb-prio-splb0 = <1>;
+			xlnx,mplb-prio-splb1 = <0>;
+			xlnx,mplb-read-pipe-enable = <1>;
+			xlnx,mplb-sync-tattribute = <0>;
+			xlnx,mplb-wdog-enable = <1>;
+			xlnx,mplb-write-pipe-enable = <1>;
+			xlnx,mplb-write-post-enable = <1>;
+			xlnx,num-dma = <1>;
+			xlnx,pir = <0xf>;
+			xlnx,ppc440mc-addr-base = <0>;
+			xlnx,ppc440mc-addr-high = <0xfffffff>;
+			xlnx,ppc440mc-arb-mode = <0>;
+			xlnx,ppc440mc-bank-conflict-mask = <0xc00000>;
+			xlnx,ppc440mc-control = <0xf810008f>;
+			xlnx,ppc440mc-max-burst = <8>;
+			xlnx,ppc440mc-prio-dcur = <2>;
+			xlnx,ppc440mc-prio-dcuw = <3>;
+			xlnx,ppc440mc-prio-icu = <4>;
+			xlnx,ppc440mc-prio-splb0 = <1>;
+			xlnx,ppc440mc-prio-splb1 = <0>;
+			xlnx,ppc440mc-row-conflict-mask = <0x3ffe00>;
+			xlnx,ppcdm-asyncmode = <0>;
+			xlnx,ppcds-asyncmode = <0>;
+			xlnx,user-reset = <0>;
+			DMA0: sdma@80 {
+				compatible = "xlnx,ll-dma-1.00.a";
+				dcr-reg = < 0x80 0x11 >;
+				interrupt-parent = <&xps_intc_0>;
+				interrupts = < 9 2 0xa 2 >;
+			} ;
+		} ;
+	} ;
+	plb_v46_0: plb@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "xlnx,plb-v46-1.02.a", "simple-bus";
+		ranges ;
+		DIP_Switches_8Bit: gpio@81460000 {
+			compatible = "xlnx,xps-gpio-1.00.a";
+			interrupt-parent = <&xps_intc_0>;
+			interrupts = < 6 2 >;
+			reg = < 0x81460000 0x10000 >;
+			xlnx,all-inputs = <1>;
+			xlnx,all-inputs-2 = <0>;
+			xlnx,dout-default = <0>;
+			xlnx,dout-default-2 = <0>;
+			xlnx,family = "virtex5";
+			xlnx,gpio-width = <8>;
+			xlnx,interrupt-present = <1>;
+			xlnx,is-bidir = <1>;
+			xlnx,is-bidir-2 = <1>;
+			xlnx,is-dual = <0>;
+			xlnx,tri-default = <0xffffffff>;
+			xlnx,tri-default-2 = <0xffffffff>;
+		} ;
+		Hard_Ethernet_MAC: xps-ll-temac@81c00000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "xlnx,compound";
+			ethernet@81c00000 {
+				compatible = "xlnx,xps-ll-temac-1.01.b";
+				device_type = "network";
+				interrupt-parent = <&xps_intc_0>;
+				interrupts = < 5 2 >;
+				llink-connected = <&DMA0>;
+				local-mac-address = [ 02 00 00 00 00 00 ];
+				reg = < 0x81c00000 0x40 >;
+				xlnx,bus2core-clk-ratio = <1>;
+				xlnx,phy-type = <1>;
+				xlnx,phyaddr = <1>;
+				xlnx,rxcsum = <1>;
+				xlnx,rxfifo = <0x1000>;
+				xlnx,temac-type = <0>;
+				xlnx,txcsum = <1>;
+				xlnx,txfifo = <0x1000>;
+			} ;
+		} ;
+		LEDs_8Bit: gpio@81400000 {
+			compatible = "xlnx,xps-gpio-1.00.a";
+			reg = < 0x81400000 0x10000 >;
+			xlnx,all-inputs = <0>;
+			xlnx,all-inputs-2 = <0>;
+			xlnx,dout-default = <0>;
+			xlnx,dout-default-2 = <0>;
+			xlnx,family = "virtex5";
+			xlnx,gpio-width = <8>;
+			xlnx,interrupt-present = <0>;
+			xlnx,is-bidir = <1>;
+			xlnx,is-bidir-2 = <1>;
+			xlnx,is-dual = <0>;
+			xlnx,tri-default = <0xffffffff>;
+			xlnx,tri-default-2 = <0xffffffff>;
+		} ;
+		LEDs_Positions: gpio@81420000 {
+			compatible = "xlnx,xps-gpio-1.00.a";
+			reg = < 0x81420000 0x10000 >;
+			xlnx,all-inputs = <0>;
+			xlnx,all-inputs-2 = <0>;
+			xlnx,dout-default = <0>;
+			xlnx,dout-default-2 = <0>;
+			xlnx,family = "virtex5";
+			xlnx,gpio-width = <5>;
+			xlnx,interrupt-present = <0>;
+			xlnx,is-bidir = <1>;
+			xlnx,is-bidir-2 = <1>;
+			xlnx,is-dual = <0>;
+			xlnx,tri-default = <0xffffffff>;
+			xlnx,tri-default-2 = <0xffffffff>;
+		} ;
+		Push_Buttons_5Bit: gpio@81440000 {
+			compatible = "xlnx,xps-gpio-1.00.a";
+			interrupt-parent = <&xps_intc_0>;
+			interrupts = < 7 2 >;
+			reg = < 0x81440000 0x10000 >;
+			xlnx,all-inputs = <1>;
+			xlnx,all-inputs-2 = <0>;
+			xlnx,dout-default = <0>;
+			xlnx,dout-default-2 = <0>;
+			xlnx,family = "virtex5";
+			xlnx,gpio-width = <5>;
+			xlnx,interrupt-present = <1>;
+			xlnx,is-bidir = <1>;
+			xlnx,is-bidir-2 = <1>;
+			xlnx,is-dual = <0>;
+			xlnx,tri-default = <0xffffffff>;
+			xlnx,tri-default-2 = <0xffffffff>;
+		} ;
+		RS232_Uart_1: serial@83e00000 {
+			clock-frequency = <0x5f5e100>;
+			compatible = "xlnx,xps-uart16550-2.00.a", "ns16550";
+			current-speed = <0x2580>;
+			device_type = "serial";
+			interrupt-parent = <&xps_intc_0>;
+			interrupts = < 8 2 >;
+			reg = < 0x83e00000 0x10000 >;
+			reg-offset = <3>;
+			reg-shift = <2>;
+			xlnx,family = "virtex5";
+			xlnx,has-external-rclk = <0>;
+			xlnx,has-external-xin = <0>;
+			xlnx,is-a-16550 = <1>;
+		} ;
+		SysACE_CompactFlash: sysace@83600000 {
+			compatible = "xlnx,xps-sysace-1.00.a";
+			interrupt-parent = <&xps_intc_0>;
+			interrupts = < 4 2 >;
+			reg = < 0x83600000 0x10000 >;
+			xlnx,family = "virtex5";
+			xlnx,mem-width = <0x10>;
+		} ;
+		xps_bram_if_cntlr_1: xps-bram-if-cntlr@ffff0000 {
+			compatible = "xlnx,xps-bram-if-cntlr-1.00.a";
+			reg = < 0xffff0000 0x10000 >;
+			xlnx,family = "virtex5";
+		} ;
+		xps_intc_0: interrupt-controller@81800000 {
+			#interrupt-cells = <2>;
+			compatible = "xlnx,xps-intc-1.00.a";
+			interrupt-controller ;
+			reg = < 0x81800000 0x10000 >;
+			xlnx,num-intr-inputs = <0xb>;
+		} ;
+		xps_timebase_wdt_1: xps-timebase-wdt@83a00000 {
+			compatible = "xlnx,xps-timebase-wdt-1.00.b";
+			interrupt-parent = <&xps_intc_0>;
+			interrupts = < 2 0 1 2 >;
+			reg = < 0x83a00000 0x10000 >;
+			xlnx,family = "virtex5";
+			xlnx,wdt-enable-once = <0>;
+			xlnx,wdt-interval = <0x1e>;
+		} ;
+		xps_timer_1: timer@83c00000 {
+			compatible = "xlnx,xps-timer-1.00.a";
+			interrupt-parent = <&xps_intc_0>;
+			interrupts = < 3 2 >;
+			reg = < 0x83c00000 0x10000 >;
+			xlnx,count-width = <0x20>;
+			xlnx,family = "virtex5";
+			xlnx,gen0-assert = <1>;
+			xlnx,gen1-assert = <1>;
+			xlnx,one-timer-only = <1>;
+			xlnx,trig0-assert = <1>;
+			xlnx,trig1-assert = <1>;
+		} ;
+	} ;
+}  ;
-- 
1.5.2.1



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
