Return-Path: <dgibson@ozlabs.org>
Date: Mon, 22 Oct 2007 10:29:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH v3] Device tree bindings for Xilinx devices
Message-ID: <20071022002900.GA17164@localhost.localdomain>
References: <20071018190555.8EE7177805F@mail76-sin.bigfish.com>
	<20071019234347.38C1111C006B@mail3-dub.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071019234347.38C1111C006B@mail3-dub.bigfish.com>
Cc: Leonid <Leonid@a-k-a.net>, Arnd Bergmann <arnd@arndb.de>,
	microblaze-uclinux@itee.uq.edu.au, linuxppc-dev@ozlabs.org,
	Wolfgang Reissnegger <wre@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 19, 2007 at 04:42:58PM -0700, Stephen Neuendorffer wrote:
> 
> Here's a full .dts generated using an updated version of
> gen_mhs_devtree.py, following the proposal.
> It happens to be a microblaze system, but you get the idea.
> 
> Grant: Is this pretty what you intend?
> 
> Steve
> 
> / {
> 	#address-cells = <1>;
> 	#size-cells = <1>;
> 	compatible = "ibm,plb4";
> 	model = "system.mhs";

Although strictly speaking the root node can represent the top-level
system bus, to match the other 4xx chips it would be beter, as Grant
says, to make a /plb node and put the devices under that.

> 	Ethernet_MAC {

Node names should be lower case, and must include a unit address
derived from the reg property.  Furthermore, the generic names
convention means this should be called just "ethernet@...".

> 		compatible =
> "xilinx,opb-ethernet-1.04.a\0xilinx,opb-ethernet";
> 		device_type = "opb_ethernet";
> 		interrupt-parent = <101>;
> 		interrupts = < 1 0 >;
> 		reg = < 40c00000 10000 >;
> 		xilinx,cam-exist = <0>;
> 		xilinx,dev-blk-id = <0>;
> 		xilinx,dev-mir-enable = <0>;
> 		xilinx,dma-present = <1>;
> 		xilinx,include-dev-pencoder = <0>;
> 		xilinx,ipif-rdfifo-depth = <4000>;
> 		xilinx,ipif-wrfifo-depth = <4000>;
> 		xilinx,jumbo-exist = <0>;
> 		xilinx,mac-fifo-depth = <10>;
> 		xilinx,mii-exist = <1>;
> 		xilinx,opb-clk-period-ps = <2710>;
> 		xilinx,reset-present = <1>;
> 		xilinx,rx-dre-type = <0>;
> 		xilinx,rx-include-csum = <0>;
> 		xilinx,tx-dre-type = <0>;
> 		xilinx,tx-include-csum = <0>;
> 	} ;
> 	IIC_EEPROM {

Apart from the fact that it should be "eeprom@..." this doesn't look
right.  Surely there must be an i2c bridge, then an eeprom device
behind it?

> 		compatible = "xilinx,opb-iic-1.02.a\0xilinx,opb-iic";
> 		device_type = "opb_iic";
> 		interrupt-parent = <101>;
> 		interrupts = < 2 0 >;
> 		reg = < 40800000 10000 >;
> 		xilinx,clk-freq = <5f5e100>;
> 		xilinx,iic-freq = <186a0>;
> 		xilinx,ten-bit-adr = <0>;
> 	} ;
> 	RS232_Uart_1 {

"serial@...."

> 		compatible =
> "xilinx,opb-uartlite-1.00.b\0xilinx,opb-uartlite";
> 		device_type = "opb_uartlite";
device_type = "serial"

> 		interrupt-parent = <101>;
> 		interrupts = < 3 0 >;
> 		reg = < 40600000 10000 >;
> 		xilinx,baudrate = <2580>;
> 		xilinx,clk-freq = <5f5e100>;
> 		xilinx,data-bits = <8>;
> 		xilinx,odd-parity = <0>;
> 		xilinx,use-parity = <0>;
> 	} ;
> 	chosen {
> 		bootargs = "root=/dev/xsysace/disc0/part2";
> 		interrupt-controller = <101>;
> 		linux,platform = <600>;
> 	} ;
> 	cpus {
> 		#address-cells = <1>;
> 		#cpus = <1>;
> 		#size-cells = <0>;
> 		microblaze_0,6.00. {

Should be "cpu@0".

> 			32-bit;
> 			clock-frequency = <5f5e1000>;
> 			d-cache-line-size = <10>;
> 			d-cache-size = <4000>;
> 			device_type = "cpu";
> 			i-cache-line-size = <10>;
> 			i-cache-size = <4000>;
> 			linux,boot-cpu;
> 			reg = <0>;
> 			timebase-frequency = <1fca055>;
> 			xilinx,cache-byte-size = <4000>;
> 			xilinx,dcache-baseaddr = <50000000>;
> 			xilinx,dcache-byte-size = <4000>;
> 			xilinx,dcache-highaddr = <5fffffff>;
> 			xilinx,debug-enabled = <1>;
> 			xilinx,div-zero-exception = <1>;
> 			xilinx,dopb-bus-exception = <1>;
> 			xilinx,fpu-exception = <1>;
> 			xilinx,icache-baseaddr = <50000000>;
> 			xilinx,icache-highaddr = <5fffffff>;
> 			xilinx,ill-opcode-exception = <1>;
> 			xilinx,iopb-bus-exception = <1>;
> 			xilinx,number-of-pc-brk = <2>;
> 			xilinx,pvr = <2>;
> 			xilinx,unaligned-exceptions = <1>;
> 			xilinx,use-barrel = <1>;
> 			xilinx,use-dcache = <1>;
> 			xilinx,use-div = <1>;
> 			xilinx,use-fpu = <1>;
> 			xilinx,use-icache = <1>;
> 			xilinx,use-msr-instr = <1>;
> 			xilinx,use-pcmp-instr = <1>;
> 		} ;
> 	} ;
> 	debug_module {
> 		compatible = "xilinx,opb-mdm-2.00.a\0xilinx,opb-mdm";
> 		device_type = "opb_mdm";

No device_type here.

> 		reg = < 41400000 10000 >;
> 		xilinx,mb-dbg-ports = <1>;
> 		xilinx,uart-width = <8>;
> 		xilinx,use-uart = <1>;
> 	} ;
> 	memory@50000000 {
> 		device_type = "memory";
> 		edk_name = "DDR2_SDRAM_32Mx32";
> 		memreg:reg = < 50000000 10000000 >;

Unless you're actually using the memreg: label, it shouldn't be there.

> 	} ;
> 	opb_hwicap_0 {
> 		compatible =
> "xilinx,opb-hwicap-1.10.a\0xilinx,opb-hwicap";
> 		device_type = "opb_hwicap";

No device_type.

> 		reg = < 41300000 10000 >;
> 	} ;
> 	opb_intc_0 {
Should be interrupt-controller@...

> 		#interrupt-cells = <2>;
> 		compatible = "xilinx,opb-intc-1.00.c\0xilinx,opb-intc";
> 		device_type = "opb_intc";

No device_type.

> 		interrupt-controller;
> 		linux,phandle = <101>;
> 		reg = < 41200000 10000 >;
> 	} ;
> 	opb_timer_1 {

Needs unit address

> 		compatible =
> "xilinx,opb-timer-1.00.b\0xilinx,opb-timer";
> 		device_type = "opb_timer";

No device_type here.

> 		interrupt-parent = <101>;
> 		interrupts = < 0 0 >;
> 		reg = < 41c00000 10000 >;
> 		xilinx,count-width = <20>;
> 		xilinx,one-timer-only = <1>;
> 	} ;
> } ; 
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
