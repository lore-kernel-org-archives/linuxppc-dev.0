Return-Path: <thunderbird2k@gmail.com>
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.26])
	by ozlabs.org (Postfix) with ESMTP id EC18BDE212
	for <linuxppc-dev@ozlabs.org>; Sat, 16 May 2009 08:28:42 +1000 (EST)
Received: by ey-out-2122.google.com with SMTP id 9so536790eyd.15
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 15:28:40 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 16 May 2009 00:20:24 +0200
Message-ID: <c8485d470905151520q210f1f06qc18705ee7a2d93db@mail.gmail.com>
Subject: Fwd: Patch 2/2: Add Xilinx ML510 reference design support [attempt2]
From: Roderick Colenbrander <thunderbird2k@gmail.com>
To: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

As requested here the same patch but now with a signed-off line which I for=
got.

Regards,
Roderick Colenbrander

Signed-off-by: Roderick Colenbrander <thunderbird2k@gmail.com>


>From f46fa90e4d066767cc4fc1c5b8dc2f9ee013ea0a Mon Sep 17 00:00:00 2001
From: Roderick Colenbrander <thunderbird2k@gmail.com>
Date: Tue, 14 Apr 2009 15:49:32 +0200
Subject: [PATCH] Add Xilinx ML510 reference design support.

---
=A0arch/powerpc/boot/dts/virtex440-ml510.dts | =A0453 +++++++++++++++++++++=
++++++++
=A0arch/powerpc/platforms/44x/Kconfig =A0 =A0 =A0 =A0| =A0 10 +
=A0arch/powerpc/platforms/44x/Makefile =A0 =A0 =A0 | =A0 =A01 +
=A0arch/powerpc/platforms/44x/ml510.c =A0 =A0 =A0 =A0| =A0161 ++++++++++
=A04 files changed, 625 insertions(+), 0 deletions(-)
=A0create mode 100644 arch/powerpc/boot/dts/virtex440-ml510.dts
=A0create mode 100644 arch/powerpc/platforms/44x/ml510.c

diff --git a/arch/powerpc/boot/dts/virtex440-ml510.dts
b/arch/powerpc/boot/dts/virtex440-ml510.dts
new file mode 100644
index 0000000..7ded73c
--- /dev/null
+++ b/arch/powerpc/boot/dts/virtex440-ml510.dts
@@ -0,0 +1,453 @@
+/*
+ * Xilinx ML510 Reference Design support
+ * This DTS file was created for the ml510_bsb1_pcores_ppc440 reference de=
sign.
+ * The reference design contains a bug which prevent PCI DMA from
working properly.
+ * A description of the bug is given in the plbv46_pci section. It
needs to be fixed
+ * by the user until Xilinx updates their reference design.
+ *
+ * Copyright 2009, Roderick Colenbrander
+ */
+
+/dts-v1/;
+/ {
+ =A0 =A0 =A0 #address-cells =3D <1>;
+ =A0 =A0 =A0 #size-cells =3D <1>;
+ =A0 =A0 =A0 compatible =3D "xlnx,ml510-ref-design";
+ =A0 =A0 =A0 dcr-parent =3D <&ppc440_0>;
+ =A0 =A0 =A0 model =3D "testing";
+ =A0 =A0 =A0 DDR2_SDRAM_DIMM0: memory@0 {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "memory";
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D < 0x0 0x20000000 >;
+ =A0 =A0 =A0 } ;
+ =A0 =A0 =A0 alias {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ethernet0 =3D &Hard_Ethernet_MAC;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial0 =3D &RS232_Uart_1;
+ =A0 =A0 =A0 } ;
+ =A0 =A0 =A0 chosen {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bootargs =3D "console=3DttyS0 root=3D/dev/=
xsa2 init=3D/etc/preinit";
+// =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bootargs =3D "console=3DttyS0 root=3D/de=
v/ram";
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0linux,stdout-path =3D "/plb@0/serial@83e00=
000";
+ =A0 =A0 =A0 } ;
+ =A0 =A0 =A0 cpus {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 #cpus =3D <0x1>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ppc440_0: cpu@0 {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock-frequency =3D <30000000=
0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "PowerPC,440",=
 "ibm,ppc440";
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d-cache-line-size =3D <0x20>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d-cache-size =3D <0x8000>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dcr-access-method =3D "native=
";
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dcr-controller ;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "cpu";
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i-cache-line-size =3D <0x20>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i-cache-size =3D <0x8000>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 model =3D "PowerPC,440";
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timebase-frequency =3D <30000=
0000>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,apu-control =3D <0x2000>=
;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,apu-udi-0 =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,apu-udi-1 =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,apu-udi-10 =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,apu-udi-11 =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,apu-udi-12 =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,apu-udi-13 =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,apu-udi-14 =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,apu-udi-15 =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,apu-udi-2 =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,apu-udi-3 =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,apu-udi-4 =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,apu-udi-5 =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,apu-udi-6 =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,apu-udi-7 =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,apu-udi-8 =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,apu-udi-9 =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,dcr-autolock-enable =3D =
<0x1>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,dcu-rd-ld-cache-plb-prio=
 =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,dcu-rd-noncache-plb-prio=
 =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,dcu-rd-touch-plb-prio =
=3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,dcu-rd-urgent-plb-prio =
=3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,dcu-wr-flush-plb-prio =
=3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,dcu-wr-store-plb-prio =
=3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,dcu-wr-urgent-plb-prio =
=3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,dma0-control =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,dma0-plb-prio =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,dma0-rxchannelctrl =3D <=
0x1010000>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,dma0-rxirqtimer =3D <0x3=
ff>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,dma0-txchannelctrl =3D <=
0x1010000>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,dma0-txirqtimer =3D <0x3=
ff>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,dma1-control =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,dma1-plb-prio =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,dma1-rxchannelctrl =3D <=
0x1010000>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,dma1-rxirqtimer =3D <0x3=
ff>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,dma1-txchannelctrl =3D <=
0x1010000>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,dma1-txirqtimer =3D <0x3=
ff>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,dma2-control =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,dma2-plb-prio =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,dma2-rxchannelctrl =3D <=
0x1010000>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,dma2-rxirqtimer =3D <0x3=
ff>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,dma2-txchannelctrl =3D <=
0x1010000>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,dma2-txirqtimer =3D <0x3=
ff>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,dma3-control =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,dma3-plb-prio =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,dma3-rxchannelctrl =3D <=
0x1010000>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,dma3-rxirqtimer =3D <0x3=
ff>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,dma3-txchannelctrl =3D <=
0x1010000>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,dma3-txirqtimer =3D <0x3=
ff>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,endian-reset =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,generate-plb-timespecs =
=3D <0x1>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,icu-rd-fetch-plb-prio =
=3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,icu-rd-spec-plb-prio =3D=
 <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,icu-rd-touch-plb-prio =
=3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,interconnect-imask =3D <=
0xffffffff>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,mplb-allow-lock-xfer =3D=
 <0x1>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,mplb-arb-mode =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,mplb-awidth =3D <0x20>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,mplb-counter =3D <0x500>=
;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,mplb-dwidth =3D <0x80>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,mplb-max-burst =3D <0x8>=
;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,mplb-native-dwidth =3D <=
0x80>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,mplb-p2p =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,mplb-prio-dcur =3D <0x2>=
;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,mplb-prio-dcuw =3D <0x3>=
;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,mplb-prio-icu =3D <0x4>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,mplb-prio-splb0 =3D <0x1=
>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,mplb-prio-splb1 =3D <0x0=
>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,mplb-read-pipe-enable =
=3D <0x1>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,mplb-sync-tattribute =3D=
 <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,mplb-wdog-enable =3D <0x=
1>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,mplb-write-pipe-enable =
=3D <0x1>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,mplb-write-post-enable =
=3D <0x1>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,num-dma =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,pir =3D <0xf>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,ppc440mc-addr-base =3D <=
0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,ppc440mc-addr-high =3D <=
0x1fffffff>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,ppc440mc-arb-mode =3D <0=
x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,ppc440mc-bank-conflict-m=
ask =3D <0x1800000>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,ppc440mc-control =3D <0x=
f810008f>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,ppc440mc-max-burst =3D <=
0x8>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,ppc440mc-prio-dcur =3D <=
0x2>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,ppc440mc-prio-dcuw =3D <=
0x3>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,ppc440mc-prio-icu =3D <0=
x4>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,ppc440mc-prio-splb0 =3D =
<0x1>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,ppc440mc-prio-splb1 =3D =
<0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,ppc440mc-row-conflict-ma=
sk =3D <0x7ffe00>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,ppcdm-asyncmode =3D <0x0=
>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,ppcds-asyncmode =3D <0x0=
>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,user-reset =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 } ;
+ =A0 =A0 =A0 } ;
+ =A0 =A0 =A0 plb_v46_0: plb@0 {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "xlnx,plb-v46-1.03.a", "simple=
-bus";
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ranges ;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 FLASH: flash@fc000000 {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank-width =3D <2>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "xlnx,xps-mch-=
emc-2.00.a", "cfi-flash";
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D < 0xfc000000 0x200000=
0 >;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,family =3D "virtex5";
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,include-datawidth-matchi=
ng-0 =3D <0x1>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,include-datawidth-matchi=
ng-1 =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,include-datawidth-matchi=
ng-2 =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,include-datawidth-matchi=
ng-3 =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,include-negedge-ioregs =
=3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,include-plb-ipif =3D <0x=
1>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,include-wrbuf =3D <0x1>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,max-mem-width =3D <0x10>=
;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,mch-native-dwidth =3D <0=
x20>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,mch-plb-clk-period-ps =
=3D <0x2710>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,mch-splb-awidth =3D <0x2=
0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,mch0-accessbuf-depth =3D=
 <0x10>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,mch0-protocol =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,mch0-rddatabuf-depth =3D=
 <0x10>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,mch1-accessbuf-depth =3D=
 <0x10>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,mch1-protocol =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,mch1-rddatabuf-depth =3D=
 <0x10>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,mch2-accessbuf-depth =3D=
 <0x10>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,mch2-protocol =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,mch2-rddatabuf-depth =3D=
 <0x10>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,mch3-accessbuf-depth =3D=
 <0x10>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,mch3-protocol =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,mch3-rddatabuf-depth =3D=
 <0x10>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,mem0-width =3D <0x10>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,mem1-width =3D <0x20>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,mem2-width =3D <0x20>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,mem3-width =3D <0x20>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,num-banks-mem =3D <0x1>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,num-channels =3D <0x2>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,priority-mode =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,synch-mem-0 =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,synch-mem-1 =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,synch-mem-2 =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,synch-mem-3 =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,synch-pipedelay-0 =3D <0=
x2>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,synch-pipedelay-1 =3D <0=
x2>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,synch-pipedelay-2 =3D <0=
x2>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,synch-pipedelay-3 =3D <0=
x2>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,tavdv-ps-mem-0 =3D <0x1a=
db0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,tavdv-ps-mem-1 =3D <0x3a=
98>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,tavdv-ps-mem-2 =3D <0x3a=
98>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,tavdv-ps-mem-3 =3D <0x3a=
98>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,tcedv-ps-mem-0 =3D <0x1a=
db0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,tcedv-ps-mem-1 =3D <0x3a=
98>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,tcedv-ps-mem-2 =3D <0x3a=
98>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,tcedv-ps-mem-3 =3D <0x3a=
98>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,thzce-ps-mem-0 =3D <0x88=
b8>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,thzce-ps-mem-1 =3D <0x1b=
58>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,thzce-ps-mem-2 =3D <0x1b=
58>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,thzce-ps-mem-3 =3D <0x1b=
58>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,thzoe-ps-mem-0 =3D <0x1b=
58>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,thzoe-ps-mem-1 =3D <0x1b=
58>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,thzoe-ps-mem-2 =3D <0x1b=
58>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,thzoe-ps-mem-3 =3D <0x1b=
58>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,tlzwe-ps-mem-0 =3D <0x88=
b8>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,tlzwe-ps-mem-1 =3D <0x0>=
;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,tlzwe-ps-mem-2 =3D <0x0>=
;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,tlzwe-ps-mem-3 =3D <0x0>=
;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,twc-ps-mem-0 =3D <0x1adb=
0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,twc-ps-mem-1 =3D <0x3a98=
>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,twc-ps-mem-2 =3D <0x3a98=
>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,twc-ps-mem-3 =3D <0x3a98=
>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,twp-ps-mem-0 =3D <0x1117=
0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,twp-ps-mem-1 =3D <0x2ee0=
>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,twp-ps-mem-2 =3D <0x2ee0=
>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,twp-ps-mem-3 =3D <0x2ee0=
>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,xcl0-linesize =3D <0x4>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,xcl0-writexfer =3D <0x1>=
;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,xcl1-linesize =3D <0x4>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,xcl1-writexfer =3D <0x1>=
;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,xcl2-linesize =3D <0x4>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,xcl2-writexfer =3D <0x1>=
;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,xcl3-linesize =3D <0x4>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,xcl3-writexfer =3D <0x1>=
;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 } ;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 Hard_Ethernet_MAC: xps-ll-temac@81c00000 {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "xlnx,compound=
";
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ethernet@81c00000 {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =
=3D "xlnx,xps-ll-temac-1.01.b";
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =
=3D "network";
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-par=
ent =3D <&xps_intc_0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =
=3D < 8 2 >;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 llink-connect=
ed =3D <&Hard_Ethernet_MAC_fifo>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 local-mac-add=
ress =3D [ 02 00 00 00 00 00 ];
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D < 0x8=
1c00000 0x40 >;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,bus2core=
-clk-ratio =3D <0x1>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,phy-type=
 =3D <0x3>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,phyaddr =
=3D <0x1>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,rxcsum =
=3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,rxfifo =
=3D <0x8000>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,temac-ty=
pe =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,txcsum =
=3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,txfifo =
=3D <0x8000>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } ;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 } ;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 Hard_Ethernet_MAC_fifo: xps-ll-fifo@81a00000 =
{
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "xlnx,xps-ll-f=
ifo-1.01.a";
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&xps_in=
tc_0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D < 6 2 >;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D < 0x81a00000 0x10000 =
>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,family =3D "virtex5";
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 } ;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 IIC_EEPROM: i2c@81600000 {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "xlnx,xps-iic-=
2.00.a";
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&xps_in=
tc_0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D < 9 2 >;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D < 0x81600000 0x10000 =
>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,clk-freq =3D <0x5f5e100>=
;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,family =3D "virtex5";
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,gpo-width =3D <0x1>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,iic-freq =3D <0x186a0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,scl-inertial-delay =3D <=
0x5>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,sda-inertial-delay =3D <=
0x5>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,ten-bit-adr =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 } ;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 LCD_OPTIONAL: gpio@81420000 {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "xlnx,xps-gpio=
-1.00.a";
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D < 0x81420000 0x10000 =
>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,all-inputs =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,all-inputs-2 =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,dout-default =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,dout-default-2 =3D <0x0>=
;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,family =3D "virtex5";
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,gpio-width =3D <0xb>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,interrupt-present =3D <0=
x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,is-bidir =3D <0x1>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,is-bidir-2 =3D <0x1>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,is-dual =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,tri-default =3D <0xfffff=
fff>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,tri-default-2 =3D <0xfff=
fffff>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 } ;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 LEDs_4Bit: gpio@81400000 {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "xlnx,xps-gpio=
-1.00.a";
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D < 0x81400000 0x10000 =
>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,all-inputs =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,all-inputs-2 =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,dout-default =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,dout-default-2 =3D <0x0>=
;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,family =3D "virtex5";
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,gpio-width =3D <0x4>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,interrupt-present =3D <0=
x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,is-bidir =3D <0x1>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,is-bidir-2 =3D <0x1>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,is-dual =3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,tri-default =3D <0xfffff=
fff>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,tri-default-2 =3D <0xfff=
fffff>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 } ;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 RS232_Uart_1: serial@83e00000 {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock-frequency =3D <10000000=
0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "xlnx,xps-uart=
16550-2.00.b", "ns16550";
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 current-speed =3D <9600>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "serial";
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&xps_in=
tc_0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D < 11 2 >;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D < 0x83e00000 0x10000 =
>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg-offset =3D <0x1003>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg-shift =3D <2>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,family =3D "virtex5";
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,has-external-rclk =3D <0=
x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,has-external-xin =3D <0x=
0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,is-a-16550 =3D <0x1>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 } ;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 SPI_EEPROM: xps-spi@feff8000 {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "xlnx,xps-spi-=
2.00.b";
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&xps_in=
tc_0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D < 10 2 >;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D < 0xfeff8000 0x80 >;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,family =3D "virtex5";
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,fifo-exist =3D <0x1>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,num-ss-bits =3D <0x1>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,num-transfer-bits =3D <0=
x8>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,sck-ratio =3D <0x80>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 } ;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 SysACE_CompactFlash: sysace@83600000 {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "xlnx,xps-sysa=
ce-1.00.a";
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&xps_in=
tc_0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D < 7 2 >;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D < 0x83600000 0x10000 =
>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,family =3D "virtex5";
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,mem-width =3D <0x10>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 } ;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 plbv46_pci_0: plbv46-pci@85e00000 {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <2>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <3>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "xlnx,plbv46-p=
ci-1.03.a";
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "pci";
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D < 0x85e00000 0x10000 =
>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* The default ML510 BSB has
C_IPIFBAR2PCIBAR_0 set to 0 which means that a read/write to
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the memory mapped i/o re=
gion (which starts
at 0xa0000000) for pci bar 0 on the plb side
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* translates to 0.
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* It is important to this =
value to
0xa0000000, so that inbound and outbound pci transactions
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* work properly including =
DMA.
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ranges =3D <0x02000000 0x0000=
0000 0xa0000000
0xa0000000 0x00000000 0x20000000
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0100000=
0 0x00000000 0x00000000
0xf0000000 0x00000000 0x00010000>;
+
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #interrupt-cells =3D <1>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&xps_in=
tc_0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-map-mask =3D <0xff0=
0 0x0 0x0 0x7>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-map =3D <
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* IRQ mappin=
g for pci slots and ALI
M1533 periperhals. In total there are
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* 5 interr=
upt lines connected to a
xps_intc controller. Four of them are PCI
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* IRQ A, B=
, C, D and which correspond
to respectively xpx_intc 5, 4, 3 and 2.
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* The fift=
h interrupt line is
connected to the south bridge and this one
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* uses irq=
 1 and is active high
instead of active low.
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* The M153=
3 contains various
peripherals including AC97 audio, a modem, USB,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* IDE and =
some power management
stuff. The modem isn't connected on the ML510
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* and the =
power management core also
isn't used.
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
+
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* IDSEL 0x16=
 / dev=3D6, bus=3D0 / PCI slot 3 */
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x3000 0 0 1 =
&xps_intc_0 3 2
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x3000 0 0 2 =
&xps_intc_0 2 2
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x3000 0 0 3 =
&xps_intc_0 5 2
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x3000 0 0 4 =
&xps_intc_0 4 2
+
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* IDSEL 0x13=
 / dev=3D3, bus=3D1 / PCI slot 4 */
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x11800 0 0 1=
 &xps_intc_0 5 0 2
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x11800 0 0 2=
 &xps_intc_0 4 0 2
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x11800 0 0 3=
 &xps_intc_0 3 0 2
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x11800 0 0 4=
 &xps_intc_0 2 0 2
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
+
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* According =
to the datasheet +
schematic ABCD [FPGA] of slot 5 is mapped to DABC.
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Testing =
showed that at least A maps
to B, the mapping of the other pins is a guess
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* and for =
that reason the lines have
been commented.
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* IDSEL 0x15=
 / dev=3D5, bus=3D0 / PCI slot 5 */
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x2800 0 0 1 =
&xps_intc_0 4 2
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x2800 0 0 2 =
&xps_intc_0 3 2
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x2800 0 0 3 =
&xps_intc_0 2 2
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x2800 0 0 4 =
&xps_intc_0 5 2
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
+
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* IDSEL 0x12=
 / dev=3D2, bus=3D1 / PCI slot 6 */
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x11000 0 0 1=
 &xps_intc_0 4 0 2
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x11000 0 0 2=
 &xps_intc_0 3 0 2
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x11000 0 0 3=
 &xps_intc_0 2 0 2
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x11000 0 0 4=
 &xps_intc_0 5 0 2
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
+
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* IDSEL 0x11=
 / dev=3D1, bus=3D0 / AC97 audio */
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0800 0 0 1 =
&i8259 7 2
+
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* IDSEL 0x1b=
 / dev=3D11, bus=3D0 / IDE */
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x5800 0 0 1 =
&i8259 14 2
+
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* IDSEL 0x1f=
 / dev 15, bus=3D0 / 2x USB 1.1 */
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x7800 0 0 1 =
&i8259 7 2
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 >;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ali_m1533 {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =
=3D <1>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cell=
s =3D <2>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i8259: interr=
upt-controller@20 {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 reg =3D <1 0x20 2
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1 0xa0 2
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1 0x4d0 2>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 interrupt-controller;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 device_type =3D "interrupt-controller";
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 #address-cells =3D <0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 #interrupt-cells =3D <2>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 compatible =3D "chrp,iic";
+
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 /* The south bridge connection
is active high */
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 interrupts =3D <1 3>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 interrupt-parent =3D <&xps_intc_0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 } ;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 xps_bram_if_cntlr_1: xps-bram-if-cntlr@ffff00=
00 {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "xlnx,xps-bram=
-if-cntlr-1.00.a";
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D < 0xffff0000 0x10000 =
>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,family =3D "virtex5";
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 } ;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 xps_intc_0: interrupt-controller@81800000 {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #interrupt-cells =3D <0x2>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "xlnx,xps-intc=
-1.00.a";
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-controller ;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D < 0x81800000 0x10000 =
>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,num-intr-inputs =3D <0xc=
>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 } ;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 xps_tft_0: tft@86e00000 {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "xlnx,xps-tft-=
1.00.a";
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D < 0x86e00000 0x10000 =
>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,dcr-splb-slave-if =3D <0=
x1>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,default-tft-base-addr =
=3D <0x0>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,family =3D "virtex5";
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,i2c-slave-addr =3D <0x76=
>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,mplb-awidth =3D <0x20>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,mplb-dwidth =3D <0x80>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,mplb-native-dwidth =3D <=
0x40>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,mplb-smallest-slave =3D =
<0x20>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlnx,tft-interface =3D <0x1>;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 } ;
+ =A0 =A0 =A0 } ;
+} =A0;
diff --git a/arch/powerpc/platforms/44x/Kconfig
b/arch/powerpc/platforms/44x/Kconfig
index bf5c7ff..cf706a7 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -171,6 +171,16 @@ config XILINX_VIRTEX440_GENERIC_BOARD
=A0 =A0 =A0 =A0 =A0Most Virtex 5 designs should use this unless it needs to=
 do some
=A0 =A0 =A0 =A0 =A0special configuration at board probe time.

+config XILINX_ML510
+ =A0 =A0 =A0 bool "Xilinx ML510 Reference Design support"
+ =A0 =A0 =A0 depends on 44x
+ =A0 =A0 =A0 default n
+ =A0 =A0 =A0 select XILINX_VIRTEX_5_FXT
+ =A0 =A0 =A0 select PPC_PCI_CHOICE
+ =A0 =A0 =A0 select XILINX_VIRTEX_PCI if PCI
+ =A0 =A0 =A0 select PPC_INDIRECT_PCI if PCI
+ =A0 =A0 =A0 select PPC_I8259 if PCI
+
=A0config PPC44x_SIMPLE
=A0 =A0 =A0 =A0bool "Simple PowerPC 44x board support"
=A0 =A0 =A0 =A0depends on 44x
diff --git a/arch/powerpc/platforms/44x/Makefile
b/arch/powerpc/platforms/44x/Makefile
index 01f51da..6793f4e 100644
--- a/arch/powerpc/platforms/44x/Makefile
+++ b/arch/powerpc/platforms/44x/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_EBONY) =A0 =A0 +=3D ebony.o
=A0obj-$(CONFIG_SAM440EP) =A0 =A0 =A0 =A0 +=3D sam440ep.o
=A0obj-$(CONFIG_WARP) =A0 =A0 +=3D warp.o
=A0obj-$(CONFIG_XILINX_VIRTEX_5_FXT) +=3D virtex.o
+obj-$(CONFIG_XILINX_ML510) +=3D ml510.o
diff --git a/arch/powerpc/platforms/44x/ml510.c
b/arch/powerpc/platforms/44x/ml510.c
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
+ * The i8259 cascade code was derived from 86xx/pic.c which is
copyrighted by Freescale Semiconductor, Inc.
+ * Xilinx ML510 PCI initialization code, derived from the Xilinx
ML300/ML410 based board support.
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
+static struct of_device_id xilinx_of_bus_ids[] __initdata =3D {
+ =A0 =A0 =A0 { .compatible =3D "simple-bus", },
+ =A0 =A0 =A0 { .compatible =3D "xlnx,plb-v46-1.00.a", },
+ =A0 =A0 =A0 { .compatible =3D "xlnx,plb-v46-1.02.a", },
+ =A0 =A0 =A0 { .compatible =3D "xlnx,plb-v34-1.01.a", },
+ =A0 =A0 =A0 { .compatible =3D "xlnx,plb-v34-1.02.a", },
+ =A0 =A0 =A0 { .compatible =3D "xlnx,opb-v20-1.10.c", },
+ =A0 =A0 =A0 { .compatible =3D "xlnx,dcr-v29-1.00.a", },
+ =A0 =A0 =A0 { .compatible =3D "xlnx,compound", },
+ =A0 =A0 =A0 {}
+};
+
+#ifdef CONFIG_PPC_I8259
+static void ml510_8259_cascade(unsigned int irq, struct irq_desc *desc)
+{
+ =A0 =A0 =A0 unsigned int cascade_irq =3D i8259_irq();
+ =A0 =A0 =A0 if (cascade_irq !=3D NO_IRQ)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 generic_handle_irq(cascade_irq);
+
+ =A0 =A0 =A0 /* Let xilinx_intc end the interrupt */
+ =A0 =A0 =A0 desc->chip->ack(irq);
+ =A0 =A0 =A0 desc->chip->unmask(irq);
+}
+
+static void __init ml510_setup_i8259_cascade(void)
+{
+ =A0 =A0 =A0 struct device_node *np, *cascade_node =3D NULL;
+ =A0 =A0 =A0 int cascade_irq;
+
+ =A0 =A0 =A0 /* Initialize i8259 controller */
+ =A0 =A0 =A0 for_each_node_by_type(np, "interrupt-controller")
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (of_device_is_compatible(n=
p, "chrp,iic")) {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 cascade_node =3D np;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 break;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
+
+ =A0 =A0 =A0 if (cascade_node =3D=3D NULL) {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_DEBUG "Could not =
find i8259 PIC\n");
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
+ =A0 =A0 =A0 }
+
+ =A0 =A0 =A0 cascade_irq =3D irq_of_parse_and_map(cascade_node, 0);
+ =A0 =A0 =A0 if (cascade_irq =3D=3D NO_IRQ) {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Failed to ma=
p cascade interrupt\n");
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
+ =A0 =A0 =A0 }
+
+ =A0 =A0 =A0 i8259_init(cascade_node, 0);
+
+ =A0 =A0 =A0 of_node_put(cascade_node);
+ =A0 =A0 =A0 set_irq_chained_handler(cascade_irq, ml510_8259_cascade);
+}
+#endif /* CONFIG_PPC_I8259 */
+
+#ifdef CONFIG_PCI
+static int ml510_pci_exclude_device(struct pci_controller *hose,
u_char bus, u8 devfn)
+{
+ =A0 =A0 =A0 if (bus !=3D 0)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PCIBIOS_DEVICE_NOT_FOUND;
+ =A0 =A0 =A0 else
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PCIBIOS_SUCCESSFUL;
+}
+
+static void __devinit ali_quirk(struct pci_dev *dev)
+{
+ =A0 =A0 =A0 /* Enable the IDE controller */
+ =A0 =A0 =A0 pci_write_config_byte(dev, 0x58, 0x4c);
+ =A0 =A0 =A0 /* Assign irq 14 to the primary ide channel */
+ =A0 =A0 =A0 pci_write_config_byte(dev, 0x44, 0x0d);
+ =A0 =A0 =A0 /* Assign irq 15 to the secondary ide channel */
+ =A0 =A0 =A0 pci_write_config_byte(dev, 0x75, 0x0f);
+ =A0 =A0 =A0 /* Set the ide controller in native mode */
+ =A0 =A0 =A0 pci_write_config_byte(dev, 0x09, 0xff);
+
+ =A0 =A0 =A0 pci_write_config_byte(dev, 0x48, 0x00); // INTB =3D disabled,
INTA =3D disabled
+ =A0 =A0 =A0 pci_write_config_byte(dev, 0x4a, 0x00); // INTD =3D disabled,
INTC =3D disabled
+ =A0 =A0 =A0 pci_write_config_byte(dev, 0x4b, 0x00); // Audio =3D INT7, Mo=
dem
=3D disabled.
+ =A0 =A0 =A0 pci_write_config_byte(dev, 0x74, 0x06); // USB =3D INT7
+}
+DECLARE_PCI_FIXUP_EARLY(0x10b9, 0x1533, ali_quirk);
+#endif /* CONFIG_PCI */
+
+static int __init ml510_device_probe(void)
+{
+ =A0 =A0 =A0 of_platform_bus_probe(NULL, xilinx_of_bus_ids, NULL);
+
+ =A0 =A0 =A0 return 0;
+}
+machine_device_initcall(ml510, ml510_device_probe);
+
+static int __init ml510_probe(void)
+{
+ =A0 =A0 =A0 unsigned long root =3D of_get_flat_dt_root();
+
+ =A0 =A0 =A0 return of_flat_dt_is_compatible(root, "xlnx,ml510-ref-design"=
);
+}
+
+void virtex_pci_init(void);
+static void __init ml510_setup_arch(void)
+{
+#ifdef CONFIG_PCI
+ =A0 =A0 =A0 /* Register the host bridge */
+ =A0 =A0 =A0 virtex_pci_init();
+#endif /* CONFIG_PCI */
+}
+
+static void ml510_init_IRQ(void)
+{
+ =A0 =A0 =A0 xilinx_intc_init_tree();
+
+#ifdef CONFIG_PPC_I8259
+ =A0 =A0 =A0 /* The devices on the ALI M1553 south bridge are connected to
an internal i8259 */
+ =A0 =A0 =A0 ml510_setup_i8259_cascade();
+ =A0 =A0 =A0 /* Program irq 7 (usb/audio), 14/15 (ide) to level sensitive =
*/
+ =A0 =A0 =A0 outb(0xc0, 0x4d0);
+ =A0 =A0 =A0 outb(0xc0, 0x4d1);
+#endif /* CONFIG_PPC_I8259 */
+}
+
+define_machine(ml510) {
+ =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =3D "Xilinx ML510
Reference Design support",
+ =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0=3D ml510_probe,
+ =A0 =A0 =A0 .setup_arch =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =3D ml510_setup_arch,
+ =A0 =A0 =A0 .pci_exclude_device =A0 =A0 =A0 =A0 =A0 =A0 =3D ml510_pci_exc=
lude_device,
+ =A0 =A0 =A0 .init_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =3D ml510_init_IRQ,
+ =A0 =A0 =A0 .get_irq =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0=3D xilinx_intc_get_irq,
+ =A0 =A0 =A0 .calibrate_decr =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D generic_c=
alibrate_decr,
+ =A0 =A0 =A0 .restart =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0=3D ppc4xx_reset_system,
+};
--
1.5.6.3



_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
