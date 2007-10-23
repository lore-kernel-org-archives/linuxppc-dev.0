Return-Path: <Monstr@seznam.cz>
Received: from mxh.seznam.cz (mxh.seznam.cz [77.75.72.26])
	by ozlabs.org (Postfix) with SMTP id E0D0EDDE30
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 14:07:59 +1000 (EST)
In-Reply-To: <20071022180700.8B3938E0088@mail19-fra.bigfish.com>
Date: Tue, 23 Oct 2007 06:07:56 +0200 (CEST)
To: microblaze-uclinux@itee.uq.edu.au
From: =?us-ascii?Q?Michal=20Simek?= <Monstr@seznam.cz>
Subject: =?us-ascii?Q?RE=3A=20=5Bmicroblaze=2Duclinux=5D=20Re=3A=20=5Bmicroblaze=2Duclinux=5D=20RE=3A=20=5BPATCH=20v3=5D=20Device=20tree=20bindings=20for=20Xilinx=20devices?=
Mime-Version: 1.0
Message-Id: <1837.2996-6584-798350907-1193112476@seznam.cz>
Content-Type: text/plain;
	charset="us-ascii"
Cc: Leonid <Leonid@a-k-a.net>,
	=?us-ascii?Q?Wolfgang=20Reissnegger?= <wre@xilinx.com>,
	=?us-ascii?Q?Arnd=20Bergmann?= <arnd@arndb.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> In my opinion will be better generate only parameters which 
>> you want not all.
>> That smells with unusable parameters.
>
>In the long term, this may be true.  In the short term:
>1) dtb size is not the key problem
Yes of course
>2) making sure that everything works is a key problem.
>3) The code that generates the dts should be as simple as possible,
>so that we can easily document what it does.
Yes but you must document every parameter which your generate do. The better way is 
document only parameters which you want use.

>In the long term, I'm all for optimizing the device tree that gets
>built,
>assuming that it appears to be a problem in real systems.
We can optimize now. I made new version of my generator  u-boot_v3_00_a (monstr.eu)
where you can simply add parameter which you want to use. 

If you want use any parameter add it. 
For microblaze cpu - line 1184. 
And for others peripherals lines 926-980. (The last parameter of function call).

Which parameters do you want for PPC405, Grant?

Regards,
Michal Simek

This is example of generator.

/ {
	model = "mONStR";
	chosen {
		linux,platform = <600>;
		bootargs = "root=/dev/xsysace/disc0/part2";
	} ;
	cpus {
		#size-cells = <0>;
		#cpus = < 0 >;
		#address-cells = <1>;
		microblaze_0,5.00.c {
			32-bit;
			linux,boot-cpu;
			device_type = "cpu";
			reg = <0>;
			clock-frequency = <5f5e1000>;
			timebase-frequency = <1FCA055>;
			i-cache-line-size = <2000>;
			i-cache-size = <10>;
			d-cache-line-size = <2000>;
			d-cache-size = <10>;
			xilinx,pvr = <0>;
			xilinx,debug-enabled = <1>;
			xilinx,fsl-links = <0>;
		} ;
	} ;

	opb_mdm@41400000 {
		compatible = "opb_mdm_2.00.a\0opb_mdm";
		name = "debug_module";
		reg = < 41400000 10000 >;
		device_type = "opb_mdm";
		xilinx,mb-dbg-ports = <1>;
		xilinx,uart-width = <8>;
		xilinx,use-uart = <1>;
	} ;
	opb_uartlite@40600000 {
		compatible = "opb_uartlite_1.00.b\0opb_uartlite";
		name = "RS232_Uart_1";
		interrupts = < 4 0 >;
		reg = < 40600000 10000 >;
		device_type = "opb_uartlite";
		xilinx,baudrate = <2580>;
		xilinx,data-bits = <8>;
		xilinx,clk-freq = <5f5e100>;
		xilinx,odd-parity = <0>;
		xilinx,use-parity = <0>;
	} ;
	opb_ethernet@40c00000 {
		compatible = "opb_ethernet_1.04.a\0opb_ethernet";
		name = "Ethernet_MAC";
		interrupts = < 3 0 >;
		reg = < 40c00000 10000 >;
		device_type = "opb_ethernet";
		xilinx,cam-exist = <0>;
		xilinx,dev-blk-id = <1>;
		xilinx,dev-mir-enable = <1>;
		xilinx,dma-present = <1>;
		xilinx,include-dev-pencoder = <1>;
		xilinx,ipif-rdfifo-depth = <8000>;
		xilinx,ipif-wrfifo-depth = <8000>;
		xilinx,mii-exist = <1>;
	} ;
	opb_sysace@41820000 {
		compatible = "opb_sysace_1.00.c\0opb_sysace";
		name = "SysACE_CompactFlash";
		reg = < 41820000 10000 >;
		device_type = "opb_sysace";
		xilinx,mem-width = <10>;
	} ;
	opb_gpio@40000000 {
		compatible = "opb_gpio_3.01.b\0opb_gpio";
		name = "LEDs_4Bit";
		reg = < 40000000 10000 >;
		device_type = "opb_gpio";
		xilinx,gpio-width = <4>;
		xilinx,is-dual = <0>;
	} ;
	memory@30000000 {
		edk_name = "DDR_256MB_32MX64_rank1_row13_col10_cl2_5";
		compatible = "opb_ddr";
		memreg:reg = < 30000000 10000000 >;
		device_type = "memory";
	} ;
	opb_ps2_dual_ref@7a400000 {
		compatible = "opb_ps2_dual_ref_1.00.a\0opb_ps2_dual_ref";
		name = "PS2_Ports";
		interrupts = < 2 0 >;
		interrupts = < 1 0 >;
		reg = < 7a400000 10000 >;
		device_type = "opb_ps2_dual_ref";
	} ;
	opb_timer@41c00000 {
		compatible = "opb_timer_1.00.b\0opb_timer";
		name = "opb_timer_1";
		interrupts = < 0 0 >;
		reg = < 41c00000 10000 >;
		device_type = "opb_timer";
		xilinx,count-width = <20>;
		xilinx,one-timer-only = <0>;
	} ;
	opb_intc@41200000 {
		compatible = "opb_intc_1.00.c\0opb_intc";
		name = "opb_intc_0";
		reg = < 41200000 10000 >;
		device_type = "opb_intc";
	} ;
	opb_uart16550@40400000 {
		compatible = "opb_uart16550_1.00.d\0opb_uart16550";
		name = "opb_uart16550_0";
		reg = < 40400000 10000 >;
		device_type = "opb_uart16550";
	} ;
	opb_sysace@41800000 {
		compatible = "opb_sysace_1.00.c\0opb_sysace";
		name = "opb_sysace_0";
		reg = < 41800000 10000 >;
		device_type = "opb_sysace";
		xilinx,mem-width = <10>;
	} ;
} ;
