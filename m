Return-Path: <dgibson@ozlabs.org>
Date: Wed, 24 Oct 2007 10:05:23 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Michal Simek <Monstr@seznam.cz>
Subject: Re: [microblaze-uclinux] Re: [microblaze-uclinux] RE: [PATCH v3]
	Device tree bindings for Xilinx devices
Message-ID: <20071024000523.GF10595@localhost.localdomain>
References: <20071023043443.GM31839@localhost.localdomain>
	<1815.2979-14673-964852328-1193124877@seznam.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1815.2979-14673-964852328-1193124877@seznam.cz>
Cc: microblaze-uclinux@itee.uq.edu.au, Wolfgang Reissnegger <wre@xilinx.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 23, 2007 at 09:34:37AM +0200, Michal Simek wrote:
> Hi David,
> I remove some labels from my generator. I created fake system with some peripherals. 
> There are 3 buses and 3 bridges. 
> Can you check it and tell me what is wrong?

Grant's comments all seem reasonable, apologies if I've duplicated
some of them below.

> 
> Thanks,
> Michal Simek
> 
> / {
> 	model = "mONStR";

You should have #address-cells and #size-cells properties.

> 	chosen {
> 		bootargs = "root=/dev/xsysace/disc0/part2";
> 	} ;
> 	cpus {
> 		#size-cells = <0>;
> 		#cpus = < 0 >;
> 		#address-cells = <1>;
> 		microblaze_0,5.00.c@0 {

That name is acceptable, but I think just cpu@0 would be better.  The
generic names convention seems to be frequently ignored for cpus, but
I don't see a good reason to.

> 			device_type = "cpu";
> 			reg = <0>;
> 			clock-frequency = <5f5e1000>;
> 			timebase-frequency = <1FCA055>;
> 			i-cache-line-size = <2000>;
> 			i-cache-size = <10>;
> 			d-cache-line-size = <2000>;
> 			d-cache-size = <10>;
> 			xilinx,pvr = <0>;
> 			xilinx,debug-enabled = <1>;
> 			xilinx,fsl-links = <0>;
> 		} ;
> 	} ;
> 
> 	ethernet@10060000 {
> 		compatible = "opb_ethernet_1.04.a","opb_ethernet";
> 		interrupts = < 3 0 >;
> 		reg = < 10060000 10000 >;
> 		device_type = "network";
> 		xilinx,cam-exist = <0>;
> 		xilinx,dev-blk-id = <1>;
> 		xilinx,dev-mir-enable = <1>;
> 		xilinx,dma-present = <1>;
> 		xilinx,include-dev-pencoder = <1>;
> 		xilinx,ipif-rdfifo-depth = <8000>;
> 		xilinx,ipif-wrfifo-depth = <8000>;
> 		xilinx,mii-exist = <1>;
> 	} ;
> 	memory@20000000 {
> 		memreg:reg = < 20000000 10000000 >;
> 		device_type = "memory";
> 	} ;
> 	serial@10030000 {
> 		compatible = "opb_uart16550_1.00.d","opb_uart16550";

Is this serial port actually 16550 compatible?  If so it should have
"ns16550" in the compatible list.

> 		reg = < 10030000 10000 >;
> 		device_type = "serial";
> 	} ;
> 	opb_timer@10020000 {
> 		compatible = "opb_timer_1.00.b","opb_timer";
> 		interrupts = < 0 0 >;
> 		reg = < 10020000 10000 >;
> 		xilinx,count-width = <20>;
> 		xilinx,one-timer-only = <0>;
> 	} ;
> 	opb_opb_lite@30000000 {

This is a bus bridge, and so needs #address-cells and #size-cells
properties.  It should also have a compatible property to describe the
type of bridge.


> 		ranges = < 0 30000000 10000000 >;
> 		opb_gpio@30020000 {
> 			compatible = "opb_gpio_3.01.b","opb_gpio";
> 			reg = < 30020000 10000 >;

This doesn't look quite right.  The reg property is translated by the
parent's ranges property.  So shouldn't this be just reg = <20000
10000>, with the 30000000 added by the parent?

> 			xilinx,gpio-width = <4>;
> 			xilinx,is-dual = <0>;
> 		} ;
> 		i2c@30030000 {
> 			compatible = "opb_iic_1.02.a","opb_iic";
> 			reg = < 30030000 10000 >;
> 			device_type = "i2c";

There was talk of an i2c device_type, but I don't think it ever
actually happened.  I think we should drop this.

> 		} ;
> 
> 		opb_gpio@30010000 {
> 			compatible = "opb_gpio_3.01.b","opb_gpio";
> 			reg = < 30010000 10000 >;
> 			xilinx,gpio-width = <20>;
> 			xilinx,is-dual = <0>;
> 		} ;
> 		ethernet@30040000 {
> 			compatible = "opb_ethernetlite_1.01.b","opb_ethernetlite";
> 			reg = < 30040000 10000 >;
> 			device_type = "network";
> 			xilinx,duplex = <1>;
> 			xilinx,rx-ping-pong = <0>;
> 			xilinx,tx-ping-pong = <0>;
> 		} ;
> 		opb_sysace@30050000 {
> 			compatible = "opb_sysace_1.00.c","opb_sysace";
> 			reg = < 30050000 10000 >;
> 			xilinx,mem-width = <10>;
> 		} ;
> 		opb_ps2_dual_ref@30060000 {
> 			compatible = "opb_ps2_dual_ref_1.00.a","opb_ps2_dual_ref";
> 			interrupts = < 2 0 >;
> 			interrupts = < 1 0 >;

Uh... duplicate property names here.  Should be
	interrupts = <2 0 1 0>;

Also you need an interrupt-parent property somewhere.  Either here, or
in one of the ancestor bridges.

> 			reg = < 30060000 10000 >;
> 		} ;
> 	};
> 	opb_intc@10010000 {
> 		compatible = "opb_intc_1.00.c","opb_intc";
> 		reg = < 10010000 10000 >;

Is this an interrupt controller?  If so it should have the
interrupt-controller and #interrupt-cells properties.

> 	} ;
> 	opb_mdm@10050000 {
> 		compatible = "opb_mdm_2.00.a","opb_mdm";
> 		reg = < 10050000 10000 >;
> 		xilinx,mb-dbg-ports = <1>;
> 		xilinx,uart-width = <8>;
> 		xilinx,use-uart = <1>;
> 	} ;
> 	serial@10040000 {
> 		compatible = "opb_uartlite_1.00.b","opb_uartlite";
> 		interrupts = < 4 0 >;
> 		reg = < 10040000 10000 >;
> 		device_type = "serial";
> 		xilinx,baudrate = <2580>;
> 		xilinx,data-bits = <8>;
> 		xilinx,clk-freq = <5f5e100>;
> 		xilinx,odd-parity = <0>;
> 		xilinx,use-parity = <0>;
> 	} ;
> 	opb2plb_bridge@80000000 {
> 		ranges = < 0 80000000 80000000 >;

Missing #address-cells and #size-cells again.

> 		serial@a0020000 {
> 			compatible = "plb_uart16550_1.00.c","plb_uart16550";
> 			reg = < a0020000 10000 >;
> 			device_type = "serial";
> 		} ;
> 		plb_gpio@a0010000 {
> 			compatible = "plb_gpio_1.00.b","plb_gpio";
> 			reg = < a0010000 10000 >;
> 			xilinx,gpio-width = <20>;
> 			xilinx,is-dual = <0>;
> 		} ;
> 		ethernet@a0000000 {
> 			compatible = "plb_ethernet_1.01.a","plb_ethernet";
> 			reg = < a0000000 10000 >;
> 			device_type = "network";
> 		} ;
> 		plb2opb_bridge@10000000 {
> 			ranges = < 0 10000000 10000000 >;
> 			ranges = < 1 20000000 10000000 >;

Duplicate properties again.

> 		};
> 		cpus {

This really doesn't look right.  I don't think it's technically
forbidden, but almost nothing is going to look for cpus anywhere other
than /cpus.  If this dt is for some sort of daughter card, and these
entries represent the cpu of the containing system, we'll need to work
out a different representation (that won't have device_type="cpu").
Although it may be a cpu, it's not *the* cpu from the prespective of
something running on the microblaze.

> 			#size-cells = <0>;
> 			#cpus = < 1 >;
> 			#address-cells = <1>;
> 			ppc405_0,405@1 {
> 				device_type = "cpu";
> 				reg = <0>;
> 				clock-frequency = <5f5e1000>;
> 				timebase-frequency = <1FCA055>;
> 			} ;
> 		} ;
> 	};
> } ;
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
