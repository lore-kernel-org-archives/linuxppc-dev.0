Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from mail3-dub-R.bigfish.com (mail-dub.bigfish.com [213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B2901DDE3F
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 09:43:52 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v3] Device tree bindings for Xilinx devices
Date: Fri, 19 Oct 2007 16:42:58 -0700
In-Reply-To: <20071018190555.8EE7177805F@mail76-sin.bigfish.com>
References: <20071018172259.14948.74736.stgit@trillian.cg.shawcable.net><20071018174956.05D7A1AA008D@mail197-blu.bigfish.com><fa686aa40710181112pbe37a18xb21b7c5bcbe973b6@mail.gmail.com>
	<20071018190555.8EE7177805F@mail76-sin.bigfish.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>,
	"Grant Likely" <grant.likely@secretlab.ca>
Message-Id: <20071019234347.38C1111C006B@mail3-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, Leonid <Leonid@a-k-a.net>,
	Wolfgang Reissnegger <wre@xilinx.com>,
	Arnd Bergmann <arnd@arndb.de>, microblaze-uclinux@itee.uq.edu.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Here's a full .dts generated using an updated version of
gen_mhs_devtree.py, following the proposal.
It happens to be a microblaze system, but you get the idea.

Grant: Is this pretty what you intend?

Steve

/ {
	#address-cells =3D <1>;
	#size-cells =3D <1>;
	compatible =3D "ibm,plb4";
	model =3D "system.mhs";
	Ethernet_MAC {
		compatible =3D
"xilinx,opb-ethernet-1.04.a\0xilinx,opb-ethernet";
		device_type =3D "opb_ethernet";
		interrupt-parent =3D <101>;
		interrupts =3D < 1 0 >;
		reg =3D < 40c00000 10000 >;
		xilinx,cam-exist =3D <0>;
		xilinx,dev-blk-id =3D <0>;
		xilinx,dev-mir-enable =3D <0>;
		xilinx,dma-present =3D <1>;
		xilinx,include-dev-pencoder =3D <0>;
		xilinx,ipif-rdfifo-depth =3D <4000>;
		xilinx,ipif-wrfifo-depth =3D <4000>;
		xilinx,jumbo-exist =3D <0>;
		xilinx,mac-fifo-depth =3D <10>;
		xilinx,mii-exist =3D <1>;
		xilinx,opb-clk-period-ps =3D <2710>;
		xilinx,reset-present =3D <1>;
		xilinx,rx-dre-type =3D <0>;
		xilinx,rx-include-csum =3D <0>;
		xilinx,tx-dre-type =3D <0>;
		xilinx,tx-include-csum =3D <0>;
	} ;
	IIC_EEPROM {
		compatible =3D "xilinx,opb-iic-1.02.a\0xilinx,opb-iic";
		device_type =3D "opb_iic";
		interrupt-parent =3D <101>;
		interrupts =3D < 2 0 >;
		reg =3D < 40800000 10000 >;
		xilinx,clk-freq =3D <5f5e100>;
		xilinx,iic-freq =3D <186a0>;
		xilinx,ten-bit-adr =3D <0>;
	} ;
	RS232_Uart_1 {
		compatible =3D
"xilinx,opb-uartlite-1.00.b\0xilinx,opb-uartlite";
		device_type =3D "opb_uartlite";
		interrupt-parent =3D <101>;
		interrupts =3D < 3 0 >;
		reg =3D < 40600000 10000 >;
		xilinx,baudrate =3D <2580>;
		xilinx,clk-freq =3D <5f5e100>;
		xilinx,data-bits =3D <8>;
		xilinx,odd-parity =3D <0>;
		xilinx,use-parity =3D <0>;
	} ;
	chosen {
		bootargs =3D "root=3D/dev/xsysace/disc0/part2";
		interrupt-controller =3D <101>;
		linux,platform =3D <600>;
	} ;
	cpus {
		#address-cells =3D <1>;
		#cpus =3D <1>;
		#size-cells =3D <0>;
		microblaze_0,6.00. {
			32-bit;
			clock-frequency =3D <5f5e1000>;
			d-cache-line-size =3D <10>;
			d-cache-size =3D <4000>;
			device_type =3D "cpu";
			i-cache-line-size =3D <10>;
			i-cache-size =3D <4000>;
			linux,boot-cpu;
			reg =3D <0>;
			timebase-frequency =3D <1fca055>;
			xilinx,cache-byte-size =3D <4000>;
			xilinx,dcache-baseaddr =3D <50000000>;
			xilinx,dcache-byte-size =3D <4000>;
			xilinx,dcache-highaddr =3D <5fffffff>;
			xilinx,debug-enabled =3D <1>;
			xilinx,div-zero-exception =3D <1>;
			xilinx,dopb-bus-exception =3D <1>;
			xilinx,fpu-exception =3D <1>;
			xilinx,icache-baseaddr =3D <50000000>;
			xilinx,icache-highaddr =3D <5fffffff>;
			xilinx,ill-opcode-exception =3D <1>;
			xilinx,iopb-bus-exception =3D <1>;
			xilinx,number-of-pc-brk =3D <2>;
			xilinx,pvr =3D <2>;
			xilinx,unaligned-exceptions =3D <1>;
			xilinx,use-barrel =3D <1>;
			xilinx,use-dcache =3D <1>;
			xilinx,use-div =3D <1>;
			xilinx,use-fpu =3D <1>;
			xilinx,use-icache =3D <1>;
			xilinx,use-msr-instr =3D <1>;
			xilinx,use-pcmp-instr =3D <1>;
		} ;
	} ;
	debug_module {
		compatible =3D "xilinx,opb-mdm-2.00.a\0xilinx,opb-mdm";
		device_type =3D "opb_mdm";
		reg =3D < 41400000 10000 >;
		xilinx,mb-dbg-ports =3D <1>;
		xilinx,uart-width =3D <8>;
		xilinx,use-uart =3D <1>;
	} ;
	memory@50000000 {
		device_type =3D "memory";
		edk_name =3D "DDR2_SDRAM_32Mx32";
		memreg:reg =3D < 50000000 10000000 >;
	} ;
	opb_hwicap_0 {
		compatible =3D
"xilinx,opb-hwicap-1.10.a\0xilinx,opb-hwicap";
		device_type =3D "opb_hwicap";
		reg =3D < 41300000 10000 >;
	} ;
	opb_intc_0 {
		#interrupt-cells =3D <2>;
		compatible =3D "xilinx,opb-intc-1.00.c\0xilinx,opb-intc";
		device_type =3D "opb_intc";
		interrupt-controller;
		linux,phandle =3D <101>;
		reg =3D < 41200000 10000 >;
	} ;
	opb_timer_1 {
		compatible =3D
"xilinx,opb-timer-1.00.b\0xilinx,opb-timer";
		device_type =3D "opb_timer";
		interrupt-parent =3D <101>;
		interrupts =3D < 0 0 >;
		reg =3D < 41c00000 10000 >;
		xilinx,count-width =3D <20>;
		xilinx,one-timer-only =3D <1>;
	} ;
} ;=20
