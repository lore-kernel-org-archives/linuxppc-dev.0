Return-Path: <dgibson@ozlabs.org>
Date: Tue, 23 Oct 2007 14:34:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Michal Simek <Monstr@seznam.cz>
Subject: Re: [microblaze-uclinux] Re: [microblaze-uclinux] RE: [PATCH v3]
	Device tree bindings for Xilinx devices
Message-ID: <20071023043443.GM31839@localhost.localdomain>
References: <20071022180700.8B3938E0088@mail19-fra.bigfish.com>
	<1837.2996-6584-798350907-1193112476@seznam.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1837.2996-6584-798350907-1193112476@seznam.cz>
Cc: linuxppc-dev@ozlabs.org, microblaze-uclinux@itee.uq.edu.au,
	Wolfgang Reissnegger <wre@xilinx.com>,
	Arnd Bergmann <arnd@arndb.de>, Leonid <Leonid@a-k-a.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 23, 2007 at 06:07:56AM +0200, Michal Simek wrote:
> >> In my opinion will be better generate only parameters which 
> >> you want not all.
> >> That smells with unusable parameters.
> >
> >In the long term, this may be true.  In the short term:
> >1) dtb size is not the key problem
> Yes of course
> >2) making sure that everything works is a key problem.
> >3) The code that generates the dts should be as simple as possible,
> >so that we can easily document what it does.
> Yes but you must document every parameter which your generate do. The better way is 
> document only parameters which you want use.
> 
> >In the long term, I'm all for optimizing the device tree that gets
> >built,
> >assuming that it appears to be a problem in real systems.
> We can optimize now. I made new version of my generator  u-boot_v3_00_a (monstr.eu)
> where you can simply add parameter which you want to use. 
> 
> If you want use any parameter add it. 
> For microblaze cpu - line 1184. 
> And for others peripherals lines 926-980. (The last parameter of function call).
> 
> Which parameters do you want for PPC405, Grant?
> 
> Regards,
> Michal Simek
> 
> This is example of generator.
> 
> / {
> 	model = "mONStR";

> 	chosen {
> 		linux,platform = <600>;

linux,platform is long obsolete.  Kill it.

> 		bootargs = "root=/dev/xsysace/disc0/part2";
> 	} ;
> 	cpus {
> 		#size-cells = <0>;
> 		#cpus = < 0 >;
> 		#address-cells = <1>;
> 		microblaze_0,5.00.c {

Still missing an @0 here.  

> 			32-bit;
> 			linux,boot-cpu;

32-bit and linux,boot-cpu are both obsolete (the first was never
specified anywhere) and should be removed.

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
> 	opb_mdm@41400000 {
> 		compatible = "opb_mdm_2.00.a\0opb_mdm";

Please use the new "opb_mdm_2.00.a", "opb_mdm" syntax.

> 		name = "debug_module";

Don't create properties called 'name'.  In real OF the 'name' property
is a synonym for the node name without the @address part.  Although
it's possible to encode a name property in a flattened tree with a
different value, it's a bad idea since it will clash with the OF
notion of this property.  In Linux this will cause a collision when
the tree is unflattened.

We should probably fix dtc to reject this, in fact.

> 		reg = < 41400000 10000 >;
> 		device_type = "opb_mdm";

Get rid of all your device_type values, they're all bogus.  The only
devices which should have device_type at all are the ethernets and
maybe the uarts, and in these cases the values should be "network" and
"serial" respectively.

> 		xilinx,mb-dbg-ports = <1>;
> 		xilinx,uart-width = <8>;
> 		xilinx,use-uart = <1>;
> 	} ;
> 	opb_uartlite@40600000 {
> 		compatible = "opb_uartlite_1.00.b\0opb_uartlite";
> 		name = "RS232_Uart_1";
> 		interrupts = < 4 0 >;
> 		reg = < 40600000 10000 >;
> 		device_type = "opb_uartlite";
> 		xilinx,baudrate = <2580>;
> 		xilinx,data-bits = <8>;
> 		xilinx,clk-freq = <5f5e100>;
> 		xilinx,odd-parity = <0>;
> 		xilinx,use-parity = <0>;
> 	} ;
> 	opb_ethernet@40c00000 {

The generic names convention means this should be called
"ethernet@40c00000"


> 		compatible = "opb_ethernet_1.04.a\0opb_ethernet";
> 		name = "Ethernet_MAC";
> 		interrupts = < 3 0 >;
> 		reg = < 40c00000 10000 >;
> 		device_type = "opb_ethernet";
> 		xilinx,cam-exist = <0>;
> 		xilinx,dev-blk-id = <1>;
> 		xilinx,dev-mir-enable = <1>;
> 		xilinx,dma-present = <1>;
> 		xilinx,include-dev-pencoder = <1>;
> 		xilinx,ipif-rdfifo-depth = <8000>;
> 		xilinx,ipif-wrfifo-depth = <8000>;
> 		xilinx,mii-exist = <1>;
> 	} ;
> 	opb_sysace@41820000 {
> 		compatible = "opb_sysace_1.00.c\0opb_sysace";
> 		name = "SysACE_CompactFlash";
> 		reg = < 41820000 10000 >;
> 		device_type = "opb_sysace";
> 		xilinx,mem-width = <10>;
> 	} ;
> 	opb_gpio@40000000 {
> 		compatible = "opb_gpio_3.01.b\0opb_gpio";
> 		name = "LEDs_4Bit";
> 		reg = < 40000000 10000 >;
> 		device_type = "opb_gpio";
> 		xilinx,gpio-width = <4>;
> 		xilinx,is-dual = <0>;
> 	} ;
> 	memory@30000000 {
> 		edk_name = "DDR_256MB_32MX64_rank1_row13_col10_cl2_5";
> 		compatible = "opb_ddr";

The memory node shouldn't generally need a compatible property.  Note
that the RAM itself probably needs to be separate from the RAM
controller node, if such a thing exists.

> 		memreg:reg = < 30000000 10000000 >;
> 		device_type = "memory";
> 	} ;
> 	opb_ps2_dual_ref@7a400000 {
> 		compatible = "opb_ps2_dual_ref_1.00.a\0opb_ps2_dual_ref";
> 		name = "PS2_Ports";
> 		interrupts = < 2 0 >;
> 		interrupts = < 1 0 >;
> 		reg = < 7a400000 10000 >;
> 		device_type = "opb_ps2_dual_ref";
> 	} ;
> 	opb_timer@41c00000 {
> 		compatible = "opb_timer_1.00.b\0opb_timer";
> 		name = "opb_timer_1";
> 		interrupts = < 0 0 >;
> 		reg = < 41c00000 10000 >;
> 		device_type = "opb_timer";
> 		xilinx,count-width = <20>;
> 		xilinx,one-timer-only = <0>;
> 	} ;
> 	opb_intc@41200000 {
> 		compatible = "opb_intc_1.00.c\0opb_intc";
> 		name = "opb_intc_0";
> 		reg = < 41200000 10000 >;
> 		device_type = "opb_intc";
> 	} ;
> 	opb_uart16550@40400000 {

Should be named "serial@..."

> 		compatible = "opb_uart16550_1.00.d\0opb_uart16550";
> 		name = "opb_uart16550_0";
> 		reg = < 40400000 10000 >;
> 		device_type = "opb_uart16550";
> 	} ;
> 	opb_sysace@41800000 {
> 		compatible = "opb_sysace_1.00.c\0opb_sysace";
> 		name = "opb_sysace_0";
> 		reg = < 41800000 10000 >;
> 		device_type = "opb_sysace";
> 		xilinx,mem-width = <10>;
> 	} ;
> } ;

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
