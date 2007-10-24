Return-Path: <dgibson@ozlabs.org>
Date: Wed, 24 Oct 2007 11:43:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Subject: Re: [microblaze-uclinux] RE: [PATCH v3] Device tree bindings for
	Xilinx devices
Message-ID: <20071024014322.GJ10595@localhost.localdomain>
References: <20071018190555.8EE7177805F@mail76-sin.bigfish.com>
	<20071019234347.38C1111C006B@mail3-dub.bigfish.com>
	<20071024011525.5D8777B806D@mail165-dub.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071024011525.5D8777B806D@mail165-dub.bigfish.com>
Cc: microblaze-uclinux@itee.uq.edu.au, Michal Simek <Monstr@seznam.cz>,
	Wolfgang Reissnegger <wre@xilinx.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 23, 2007 at 06:15:22PM -0700, Stephen Neuendorffer wrote:
[snip]
> / {
> 	#address-cells = <1>;
> 	#size-cells = <1>;
> 	model = "system.mhs";
> 	chosen {
> 		bootargs = "root=/dev/xsysace/disc0/part2";
> 		interrupt-controller = <101>;

interrupt-controller in /chosen is obsolete.  Drop it.

> 	} ;
> 	cpus {
> 		#address-cells = <1>;
> 		#cpus = <1>;
> 		#size-cells = <0>;
> 		microblaze,6.00.b@0 {
> 			32-bit;

32-bit was never a specified property.  Drop.

> 			clock-frequency = <5f5e1000>;
> 			d-cache-line-size = <10>;
> 			d-cache-size = <4000>;
> 			device_type = "cpu";
> 			i-cache-line-size = <10>;
> 			i-cache-size = <4000>;
> 			linux,boot-cpu;

linux,boot-cpu is long obsolete.  Drop.

> 			reg = <0>;
> 			timebase-frequency = <1fca055>;
> 			xlnx,cache-byte-size = <4000>;
> 			xlnx,dcache-baseaddr = <50000000>;
> 			xlnx,dcache-byte-size = <4000>;
> 			xlnx,dcache-highaddr = <5fffffff>;
> 			xlnx,debug-enabled = <1>;
> 			xlnx,div-zero-exception = <1>;
> 			xlnx,dopb-bus-exception = <1>;
> 			xlnx,fpu-exception = <1>;
> 			xlnx,icache-baseaddr = <50000000>;
> 			xlnx,icache-highaddr = <5fffffff>;
> 			xlnx,ill-opcode-exception = <1>;
> 			xlnx,iopb-bus-exception = <1>;
> 			xlnx,number-of-pc-brk = <2>;
> 			xlnx,pvr = <2>;
> 			xlnx,unaligned-exceptions = <1>;
> 			xlnx,use-barrel = <1>;
> 			xlnx,use-dcache = <1>;
> 			xlnx,use-div = <1>;
> 			xlnx,use-fpu = <1>;
> 			xlnx,use-icache = <1>;
> 			xlnx,use-msr-instr = <1>;
> 			xlnx,use-pcmp-instr = <1>;
> 		} ;
> 	} ;
> 	memory {
> 		device_type = "memory";
> 		reg = < 50000000 10000000 >;
> 	} ;
> 	opb_v20 {

Any node with children must have #address-cells and #size-cells
properties.  This one almost certainly needs 'ranges' too.  If it has
any bridge control registers, it should have 'reg' also.

> 		compatible =
> "xlnx,opb-v20-1.10.c\0xlnx,opb-v20\0ibm,opb";
> 		ethernet@40c00000 {
> 			compatible =
> "xlnx,opb-ethernet-1.04.a\0xlnx,opb-ethernet";
> 			device_type = "network";
> 			interrupt-parent = <101>;

It would be kind of neat if you could get this to generate labels and
references, rather than explicit phandles for the interrupt tree.

> 			interrupts = < 1 0 >;
> 			reg = < 40c00000 10000 >;
> 			xlnx,cam-exist = <0>;
> 			xlnx,dev-blk-id = <0>;
> 			xlnx,dev-mir-enable = <0>;
> 			xlnx,dma-present = <1>;
> 			xlnx,edk-name = "Ethernet_MAC";
> 			xlnx,include-dev-pencoder = <0>;
> 			xlnx,ipif-rdfifo-depth = <4000>;
> 			xlnx,ipif-wrfifo-depth = <4000>;
> 			xlnx,jumbo-exist = <0>;
> 			xlnx,mac-fifo-depth = <10>;
> 			xlnx,mii-exist = <1>;
> 			xlnx,opb-clk-period-ps = <2710>;
> 			xlnx,reset-present = <1>;
> 			xlnx,rx-dre-type = <0>;
> 			xlnx,rx-include-csum = <0>;
> 			xlnx,tx-dre-type = <0>;
> 			xlnx,tx-include-csum = <0>;
> 		} ;
> 		interrupt-controller@41200000 {
> 			#interrupt-cells = <2>;
> 			compatible =
> "xlnx,opb-intc-1.00.c\0xlnx,opb-intc";
> 			interrupt-controller;
> 			linux,phandle = <101>;
> 			reg = < 41200000 10000 >;
> 			xlnx,edk-name = "opb_intc_0";
> 		} ;
> 		memory@50000000 {

Ok, I don't really understand why the memory node is duplicated here.
It seems to be covering the same range as the top-level /memory node.

> 			compatible =
> "xlnx,mch-opb-ddr2-1.02.a\0xlnx,mch-opb-ddr2";
> 			device_type = "memory";
> 			reg = < 50000000 10000000 >;
> 			xlnx,ddr-async-support = <1>;
> 			xlnx,ddr-awidth = <d>;
> 			xlnx,ddr-bank-awidth = <2>;
> 			xlnx,ddr-cas-lat = <3>;
> 			xlnx,ddr-col-awidth = <a>;
> 			xlnx,ddr-dwidth = <20>;
> 			xlnx,ddr-tfaw = <c350>;
> 			xlnx,ddr-tmrd = <61a8>;
> 			xlnx,ddr-tras = <15f90>;
> 			xlnx,ddr-trc = <fde8>;
> 			xlnx,ddr-trcd = <61a8>;
> 			xlnx,ddr-trefi = <7704c0>;
> 			xlnx,ddr-trfc = <1c138>;
> 			xlnx,ddr-trp = <4e20>;
> 			xlnx,ddr-trrd = <3a98>;
> 			xlnx,ddr-twr = <3a98>;
> 			xlnx,ddr-twtr = <1>;
> 			xlnx,edk-name = "DDR2_SDRAM_32Mx32";
> 			xlnx,extra-tsu = <0>;
> 			xlnx,idelayctrl-loc =
> "IDELAYCTRL_X0Y5-IDELAYCTRL_X0Y4-IDELAYCTRL_X0Y1-IDELAYCTRL_X0Y0";
> 			xlnx,include-opb-burst-support = <1>;
> 			xlnx,include-opb-ipif = <1>;
> 			xlnx,mch0-accessbuf-depth = <4>;
> 			xlnx,mch1-accessbuf-depth = <8>;
> 			xlnx,num-banks-mem = <1>;
> 			xlnx,num-channels = <2>;
> 			xlnx,num-clk-pairs = <2>;
> 			xlnx,num-idelayctrl = <4>;
> 			xlnx,reg-dimm = <0>;
> 			xlnx,xcl0-writexfer = <0>;
> 		} ;
> 		opb_hwicap@41300000 {
> 			compatible =
> "xlnx,opb-hwicap-1.10.a\0xlnx,opb-hwicap";
> 			reg = < 41300000 10000 >;
> 			xlnx,edk-name = "opb_hwicap_0";
> 		} ;
> 		opb_iic@40800000 {
> 			compatible =
> "xlnx,opb-iic-1.02.a\0xlnx,opb-iic";
> 			interrupt-parent = <101>;
> 			interrupts = < 2 0 >;
> 			reg = < 40800000 10000 >;
> 			xlnx,clk-freq = <5f5e100>;
> 			xlnx,edk-name = "IIC_EEPROM";
> 			xlnx,iic-freq = <186a0>;
> 			xlnx,ten-bit-adr = <0>;
> 		} ;
> 		opb_mdm@41400000 {
> 			compatible =
> "xlnx,opb-mdm-2.00.a\0xlnx,opb-mdm";
> 			reg = < 41400000 10000 >;
> 			xlnx,edk-name = "debug_module";
> 			xlnx,mb-dbg-ports = <1>;
> 			xlnx,uart-width = <8>;
> 			xlnx,use-uart = <1>;
> 		} ;
> 		opb_timer@41c00000 {
> 			compatible =
> "xlnx,opb-timer-1.00.b\0xlnx,opb-timer";
> 			interrupt-parent = <101>;
> 			interrupts = < 0 0 >;
> 			reg = < 41c00000 10000 >;
> 			xlnx,count-width = <20>;
> 			xlnx,edk-name = "opb_timer_1";
> 			xlnx,one-timer-only = <1>;
> 		} ;
> 		serial@40600000 {
> 			compatible =
> "xlnx,opb-uartlite-1.00.b\0xlnx,opb-uartlite";
> 			device_type = "serial";
> 			interrupt-parent = <101>;
> 			interrupts = < 3 0 >;
> 			reg = < 40600000 10000 >;
> 			xlnx,baudrate = <2580>;

Possibly this should be current-speed, in analogy with ns16550
devices.

> 			xlnx,clk-freq = <5f5e100>;
> 			xlnx,data-bits = <8>;
> 			xlnx,edk-name = "RS232_Uart_1";
> 			xlnx,odd-parity = <0>;
> 			xlnx,use-parity = <0>;
> 		} ;
> 	} ;
> } ;

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
