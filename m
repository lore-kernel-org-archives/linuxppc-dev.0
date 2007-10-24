Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from mail165-dub-R.bigfish.com (mail-dub.bigfish.com
	[213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 77DB4DDFD0
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 11:15:31 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [microblaze-uclinux] RE: [PATCH v3] Device tree bindings for
	Xilinx devices
Date: Tue, 23 Oct 2007 18:15:22 -0700
In-Reply-To: <20071019234347.38C1111C006B@mail3-dub.bigfish.com>
References: <20071018172259.14948.74736.stgit@trillian.cg.shawcable.net><20071018174956.05D7A1AA008D@mail197-blu.bigfish.com><fa686aa40710181112pbe37a18xb21b7c5bcbe973b6@mail.gmail.com>
	<20071018190555.8EE7177805F@mail76-sin.bigfish.com>
	<20071019234347.38C1111C006B@mail3-dub.bigfish.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: <microblaze-uclinux@itee.uq.edu.au>,
	"Grant Likely" <grant.likely@secretlab.ca>
Message-Id: <20071024011525.5D8777B806D@mail165-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, Michal Simek <Monstr@seznam.cz>,
	Wolfgang Reissnegger <wre@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I've incorporated a good portion of the combined feedback and pushed the
gen_mhs_devtree patches back to Grant.
The few things I haven't done are relatively cosmetic (like getting rid
of linux,phandle references, decimal vs. hex, and the 'embedded \0')
,=20
The one significant problem that I'm not sure how to deal with pertains
to multiple memory nodes, which often happens.  Should they all be
exported at the toplevel (which dtc seems to require), or only the main
memory which is used by Linux?

Some specific responses below:

>>
>> Steve
>>
>> / {
>>         #address-cells =3D <1>;
>>         #size-cells =3D <1>;
>>         compatible =3D "ibm,plb4";

>Not quite; the bus itself needs to be one level deeper.  Compatible
>here is refering to the platform itself, not the bus and so should be
>the actual board name or something similar.  Maybe something like:
>"xlnx,ml403","xlnx,generic-virtex4";

perhaps the toplevel compatible node should contain a SHA1 hash of
system.mhs?

>>         Ethernet_MAC {
>>                 compatible =3D
>> "xilinx,opb-ethernet-1.04.a\0xilinx,opb-ethernet";
>
>Yes; this is the idea; but I don't like "xilinx,opb-ethernet".  I
>think we should always specify specific versions and not try to guess
>what the 'generic' device compatible interface is.

I've left this in, until we can come up with canonical compatible
versions.
(perhaps just truncating the minor version?)

I've attached one more generated test tree, in the hopes that
gen-mhs-devtree can be put to bed and used to validate Michel's BSP
oriented version.  Again, the goal is not to make it perfect, but to
make it good enough that it can be a temporary bridge between the
EDK-integrated generator and those writing device drivers.

Steve

/ {
	#address-cells =3D <1>;
	#size-cells =3D <1>;
	model =3D "system.mhs";
	chosen {
		bootargs =3D "root=3D/dev/xsysace/disc0/part2";
		interrupt-controller =3D <101>;
	} ;
	cpus {
		#address-cells =3D <1>;
		#cpus =3D <1>;
		#size-cells =3D <0>;
		microblaze,6.00.b@0 {
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
			xlnx,cache-byte-size =3D <4000>;
			xlnx,dcache-baseaddr =3D <50000000>;
			xlnx,dcache-byte-size =3D <4000>;
			xlnx,dcache-highaddr =3D <5fffffff>;
			xlnx,debug-enabled =3D <1>;
			xlnx,div-zero-exception =3D <1>;
			xlnx,dopb-bus-exception =3D <1>;
			xlnx,fpu-exception =3D <1>;
			xlnx,icache-baseaddr =3D <50000000>;
			xlnx,icache-highaddr =3D <5fffffff>;
			xlnx,ill-opcode-exception =3D <1>;
			xlnx,iopb-bus-exception =3D <1>;
			xlnx,number-of-pc-brk =3D <2>;
			xlnx,pvr =3D <2>;
			xlnx,unaligned-exceptions =3D <1>;
			xlnx,use-barrel =3D <1>;
			xlnx,use-dcache =3D <1>;
			xlnx,use-div =3D <1>;
			xlnx,use-fpu =3D <1>;
			xlnx,use-icache =3D <1>;
			xlnx,use-msr-instr =3D <1>;
			xlnx,use-pcmp-instr =3D <1>;
		} ;
	} ;
	memory {
		device_type =3D "memory";
		reg =3D < 50000000 10000000 >;
	} ;
	opb_v20 {
		compatible =3D
"xlnx,opb-v20-1.10.c\0xlnx,opb-v20\0ibm,opb";
		ethernet@40c00000 {
			compatible =3D
"xlnx,opb-ethernet-1.04.a\0xlnx,opb-ethernet";
			device_type =3D "network";
			interrupt-parent =3D <101>;
			interrupts =3D < 1 0 >;
			reg =3D < 40c00000 10000 >;
			xlnx,cam-exist =3D <0>;
			xlnx,dev-blk-id =3D <0>;
			xlnx,dev-mir-enable =3D <0>;
			xlnx,dma-present =3D <1>;
			xlnx,edk-name =3D "Ethernet_MAC";
			xlnx,include-dev-pencoder =3D <0>;
			xlnx,ipif-rdfifo-depth =3D <4000>;
			xlnx,ipif-wrfifo-depth =3D <4000>;
			xlnx,jumbo-exist =3D <0>;
			xlnx,mac-fifo-depth =3D <10>;
			xlnx,mii-exist =3D <1>;
			xlnx,opb-clk-period-ps =3D <2710>;
			xlnx,reset-present =3D <1>;
			xlnx,rx-dre-type =3D <0>;
			xlnx,rx-include-csum =3D <0>;
			xlnx,tx-dre-type =3D <0>;
			xlnx,tx-include-csum =3D <0>;
		} ;
		interrupt-controller@41200000 {
			#interrupt-cells =3D <2>;
			compatible =3D
"xlnx,opb-intc-1.00.c\0xlnx,opb-intc";
			interrupt-controller;
			linux,phandle =3D <101>;
			reg =3D < 41200000 10000 >;
			xlnx,edk-name =3D "opb_intc_0";
		} ;
		memory@50000000 {
			compatible =3D
"xlnx,mch-opb-ddr2-1.02.a\0xlnx,mch-opb-ddr2";
			device_type =3D "memory";
			reg =3D < 50000000 10000000 >;
			xlnx,ddr-async-support =3D <1>;
			xlnx,ddr-awidth =3D <d>;
			xlnx,ddr-bank-awidth =3D <2>;
			xlnx,ddr-cas-lat =3D <3>;
			xlnx,ddr-col-awidth =3D <a>;
			xlnx,ddr-dwidth =3D <20>;
			xlnx,ddr-tfaw =3D <c350>;
			xlnx,ddr-tmrd =3D <61a8>;
			xlnx,ddr-tras =3D <15f90>;
			xlnx,ddr-trc =3D <fde8>;
			xlnx,ddr-trcd =3D <61a8>;
			xlnx,ddr-trefi =3D <7704c0>;
			xlnx,ddr-trfc =3D <1c138>;
			xlnx,ddr-trp =3D <4e20>;
			xlnx,ddr-trrd =3D <3a98>;
			xlnx,ddr-twr =3D <3a98>;
			xlnx,ddr-twtr =3D <1>;
			xlnx,edk-name =3D "DDR2_SDRAM_32Mx32";
			xlnx,extra-tsu =3D <0>;
			xlnx,idelayctrl-loc =3D
"IDELAYCTRL_X0Y5-IDELAYCTRL_X0Y4-IDELAYCTRL_X0Y1-IDELAYCTRL_X0Y0";
			xlnx,include-opb-burst-support =3D <1>;
			xlnx,include-opb-ipif =3D <1>;
			xlnx,mch0-accessbuf-depth =3D <4>;
			xlnx,mch1-accessbuf-depth =3D <8>;
			xlnx,num-banks-mem =3D <1>;
			xlnx,num-channels =3D <2>;
			xlnx,num-clk-pairs =3D <2>;
			xlnx,num-idelayctrl =3D <4>;
			xlnx,reg-dimm =3D <0>;
			xlnx,xcl0-writexfer =3D <0>;
		} ;
		opb_hwicap@41300000 {
			compatible =3D
"xlnx,opb-hwicap-1.10.a\0xlnx,opb-hwicap";
			reg =3D < 41300000 10000 >;
			xlnx,edk-name =3D "opb_hwicap_0";
		} ;
		opb_iic@40800000 {
			compatible =3D
"xlnx,opb-iic-1.02.a\0xlnx,opb-iic";
			interrupt-parent =3D <101>;
			interrupts =3D < 2 0 >;
			reg =3D < 40800000 10000 >;
			xlnx,clk-freq =3D <5f5e100>;
			xlnx,edk-name =3D "IIC_EEPROM";
			xlnx,iic-freq =3D <186a0>;
			xlnx,ten-bit-adr =3D <0>;
		} ;
		opb_mdm@41400000 {
			compatible =3D
"xlnx,opb-mdm-2.00.a\0xlnx,opb-mdm";
			reg =3D < 41400000 10000 >;
			xlnx,edk-name =3D "debug_module";
			xlnx,mb-dbg-ports =3D <1>;
			xlnx,uart-width =3D <8>;
			xlnx,use-uart =3D <1>;
		} ;
		opb_timer@41c00000 {
			compatible =3D
"xlnx,opb-timer-1.00.b\0xlnx,opb-timer";
			interrupt-parent =3D <101>;
			interrupts =3D < 0 0 >;
			reg =3D < 41c00000 10000 >;
			xlnx,count-width =3D <20>;
			xlnx,edk-name =3D "opb_timer_1";
			xlnx,one-timer-only =3D <1>;
		} ;
		serial@40600000 {
			compatible =3D
"xlnx,opb-uartlite-1.00.b\0xlnx,opb-uartlite";
			device_type =3D "serial";
			interrupt-parent =3D <101>;
			interrupts =3D < 3 0 >;
			reg =3D < 40600000 10000 >;
			xlnx,baudrate =3D <2580>;
			xlnx,clk-freq =3D <5f5e100>;
			xlnx,data-bits =3D <8>;
			xlnx,edk-name =3D "RS232_Uart_1";
			xlnx,odd-parity =3D <0>;
			xlnx,use-parity =3D <0>;
		} ;
	} ;
} ;

> -----Original Message-----
> From: owner-microblaze-uclinux@itee.uq.edu.au=20
> [mailto:owner-microblaze-uclinux@itee.uq.edu.au] On Behalf Of=20
> Stephen Neuendorffer
> Sent: Friday, October 19, 2007 4:43 PM
> To: Stephen Neuendorffer; Grant Likely
> Cc: Leonid; Arnd Bergmann; microblaze-uclinux@itee.uq.edu.au;=20
> linuxppc-dev@ozlabs.org; Wolfgang Reissnegger
> Subject: [microblaze-uclinux] RE: [PATCH v3] Device tree=20
> bindings for Xilinx devices
>=20
>=20
> Here's a full .dts generated using an updated version of
> gen_mhs_devtree.py, following the proposal.
> It happens to be a microblaze system, but you get the idea.
>=20
> Grant: Is this pretty what you intend?
>=20
> Steve
>=20
> / {
> 	#address-cells =3D <1>;
> 	#size-cells =3D <1>;
> 	compatible =3D "ibm,plb4";
> 	model =3D "system.mhs";
> 	Ethernet_MAC {
> 		compatible =3D
> "xilinx,opb-ethernet-1.04.a\0xilinx,opb-ethernet";
> 		device_type =3D "opb_ethernet";
> 		interrupt-parent =3D <101>;
> 		interrupts =3D < 1 0 >;
> 		reg =3D < 40c00000 10000 >;
> 		xilinx,cam-exist =3D <0>;
> 		xilinx,dev-blk-id =3D <0>;
> 		xilinx,dev-mir-enable =3D <0>;
> 		xilinx,dma-present =3D <1>;
> 		xilinx,include-dev-pencoder =3D <0>;
> 		xilinx,ipif-rdfifo-depth =3D <4000>;
> 		xilinx,ipif-wrfifo-depth =3D <4000>;
> 		xilinx,jumbo-exist =3D <0>;
> 		xilinx,mac-fifo-depth =3D <10>;
> 		xilinx,mii-exist =3D <1>;
> 		xilinx,opb-clk-period-ps =3D <2710>;
> 		xilinx,reset-present =3D <1>;
> 		xilinx,rx-dre-type =3D <0>;
> 		xilinx,rx-include-csum =3D <0>;
> 		xilinx,tx-dre-type =3D <0>;
> 		xilinx,tx-include-csum =3D <0>;
> 	} ;
> 	IIC_EEPROM {
> 		compatible =3D "xilinx,opb-iic-1.02.a\0xilinx,opb-iic";
> 		device_type =3D "opb_iic";
> 		interrupt-parent =3D <101>;
> 		interrupts =3D < 2 0 >;
> 		reg =3D < 40800000 10000 >;
> 		xilinx,clk-freq =3D <5f5e100>;
> 		xilinx,iic-freq =3D <186a0>;
> 		xilinx,ten-bit-adr =3D <0>;
> 	} ;
> 	RS232_Uart_1 {
> 		compatible =3D
> "xilinx,opb-uartlite-1.00.b\0xilinx,opb-uartlite";
> 		device_type =3D "opb_uartlite";
> 		interrupt-parent =3D <101>;
> 		interrupts =3D < 3 0 >;
> 		reg =3D < 40600000 10000 >;
> 		xilinx,baudrate =3D <2580>;
> 		xilinx,clk-freq =3D <5f5e100>;
> 		xilinx,data-bits =3D <8>;
> 		xilinx,odd-parity =3D <0>;
> 		xilinx,use-parity =3D <0>;
> 	} ;
> 	chosen {
> 		bootargs =3D "root=3D/dev/xsysace/disc0/part2";
> 		interrupt-controller =3D <101>;
> 		linux,platform =3D <600>;
> 	} ;
> 	cpus {
> 		#address-cells =3D <1>;
> 		#cpus =3D <1>;
> 		#size-cells =3D <0>;
> 		microblaze_0,6.00. {
> 			32-bit;
> 			clock-frequency =3D <5f5e1000>;
> 			d-cache-line-size =3D <10>;
> 			d-cache-size =3D <4000>;
> 			device_type =3D "cpu";
> 			i-cache-line-size =3D <10>;
> 			i-cache-size =3D <4000>;
> 			linux,boot-cpu;
> 			reg =3D <0>;
> 			timebase-frequency =3D <1fca055>;
> 			xilinx,cache-byte-size =3D <4000>;
> 			xilinx,dcache-baseaddr =3D <50000000>;
> 			xilinx,dcache-byte-size =3D <4000>;
> 			xilinx,dcache-highaddr =3D <5fffffff>;
> 			xilinx,debug-enabled =3D <1>;
> 			xilinx,div-zero-exception =3D <1>;
> 			xilinx,dopb-bus-exception =3D <1>;
> 			xilinx,fpu-exception =3D <1>;
> 			xilinx,icache-baseaddr =3D <50000000>;
> 			xilinx,icache-highaddr =3D <5fffffff>;
> 			xilinx,ill-opcode-exception =3D <1>;
> 			xilinx,iopb-bus-exception =3D <1>;
> 			xilinx,number-of-pc-brk =3D <2>;
> 			xilinx,pvr =3D <2>;
> 			xilinx,unaligned-exceptions =3D <1>;
> 			xilinx,use-barrel =3D <1>;
> 			xilinx,use-dcache =3D <1>;
> 			xilinx,use-div =3D <1>;
> 			xilinx,use-fpu =3D <1>;
> 			xilinx,use-icache =3D <1>;
> 			xilinx,use-msr-instr =3D <1>;
> 			xilinx,use-pcmp-instr =3D <1>;
> 		} ;
> 	} ;
> 	debug_module {
> 		compatible =3D "xilinx,opb-mdm-2.00.a\0xilinx,opb-mdm";
> 		device_type =3D "opb_mdm";
> 		reg =3D < 41400000 10000 >;
> 		xilinx,mb-dbg-ports =3D <1>;
> 		xilinx,uart-width =3D <8>;
> 		xilinx,use-uart =3D <1>;
> 	} ;
> 	memory@50000000 {
> 		device_type =3D "memory";
> 		edk_name =3D "DDR2_SDRAM_32Mx32";
> 		memreg:reg =3D < 50000000 10000000 >;
> 	} ;
> 	opb_hwicap_0 {
> 		compatible =3D
> "xilinx,opb-hwicap-1.10.a\0xilinx,opb-hwicap";
> 		device_type =3D "opb_hwicap";
> 		reg =3D < 41300000 10000 >;
> 	} ;
> 	opb_intc_0 {
> 		#interrupt-cells =3D <2>;
> 		compatible =3D "xilinx,opb-intc-1.00.c\0xilinx,opb-intc";
> 		device_type =3D "opb_intc";
> 		interrupt-controller;
> 		linux,phandle =3D <101>;
> 		reg =3D < 41200000 10000 >;
> 	} ;
> 	opb_timer_1 {
> 		compatible =3D
> "xilinx,opb-timer-1.00.b\0xilinx,opb-timer";
> 		device_type =3D "opb_timer";
> 		interrupt-parent =3D <101>;
> 		interrupts =3D < 0 0 >;
> 		reg =3D < 41c00000 10000 >;
> 		xilinx,count-width =3D <20>;
> 		xilinx,one-timer-only =3D <1>;
> 	} ;
> } ;=20
>=20
>=20
>=20
> ___________________________
> microblaze-uclinux mailing list
> microblaze-uclinux@itee.uq.edu.au
> Project Home Page :=20
> http://www.itee.uq.edu.au/~jwilliams/mblaze-uclinux
> Mailing List Archive :=20
> http://www.itee.uq.edu.au/~listarch/microblaze-uclinux/
>=20
>=20
>=20
