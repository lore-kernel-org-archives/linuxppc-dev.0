Return-Path: <Monstr@seznam.cz>
Received: from mxh.seznam.cz (mxh.seznam.cz [77.75.72.26])
	by ozlabs.org (Postfix) with SMTP id 02907DDF23
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 17:34:42 +1000 (EST)
In-Reply-To: <20071023043443.GM31839@localhost.localdomain>
Date: Tue, 23 Oct 2007 09:34:37 +0200 (CEST)
To: =?us-ascii?Q?David=20Gibson?= <david@gibson.dropbear.id.au>
From: =?us-ascii?Q?Michal=20Simek?= <Monstr@seznam.cz>
Subject: =?us-ascii?Q?Re=3A=20=5Bmicroblaze=2Duclinux=5D=20Re=3A=20=5Bmicroblaze=2Duclinux=5D=20RE=3A=20=5BPATCH=20v3=5D=20Device=20tree=20bindings=20for=20Xilinx=20devices?=
Mime-Version: 1.0
Message-Id: <1815.2979-14673-964852328-1193124877@seznam.cz>
Content-Type: text/plain;
	charset="us-ascii"
Cc: microblaze-uclinux@itee.uq.edu.au,
	=?us-ascii?Q?Wolfgang=20Reissnegger?= <wre@xilinx.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi David,
I remove some labels from my generator. I created fake system with some peripherals. 
There are 3 buses and 3 bridges. 
Can you check it and tell me what is wrong?

Thanks,
Michal Simek

/ {
	model = "mONStR";
	chosen {
		bootargs = "root=/dev/xsysace/disc0/part2";
	} ;
	cpus {
		#size-cells = <0>;
		#cpus = < 0 >;
		#address-cells = <1>;
		microblaze_0,5.00.c@0 {
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

	ethernet@10060000 {
		compatible = "opb_ethernet_1.04.a","opb_ethernet";
		interrupts = < 3 0 >;
		reg = < 10060000 10000 >;
		device_type = "network";
		xilinx,cam-exist = <0>;
		xilinx,dev-blk-id = <1>;
		xilinx,dev-mir-enable = <1>;
		xilinx,dma-present = <1>;
		xilinx,include-dev-pencoder = <1>;
		xilinx,ipif-rdfifo-depth = <8000>;
		xilinx,ipif-wrfifo-depth = <8000>;
		xilinx,mii-exist = <1>;
	} ;
	memory@20000000 {
		memreg:reg = < 20000000 10000000 >;
		device_type = "memory";
	} ;
	serial@10030000 {
		compatible = "opb_uart16550_1.00.d","opb_uart16550";
		reg = < 10030000 10000 >;
		device_type = "serial";
	} ;
	opb_timer@10020000 {
		compatible = "opb_timer_1.00.b","opb_timer";
		interrupts = < 0 0 >;
		reg = < 10020000 10000 >;
		xilinx,count-width = <20>;
		xilinx,one-timer-only = <0>;
	} ;
	opb_opb_lite@30000000 {
		ranges = < 0 30000000 10000000 >;
		opb_gpio@30020000 {
			compatible = "opb_gpio_3.01.b","opb_gpio";
			reg = < 30020000 10000 >;
			xilinx,gpio-width = <4>;
			xilinx,is-dual = <0>;
		} ;
		i2c@30030000 {
			compatible = "opb_iic_1.02.a","opb_iic";
			reg = < 30030000 10000 >;
			device_type = "i2c";
		} ;

		opb_gpio@30010000 {
			compatible = "opb_gpio_3.01.b","opb_gpio";
			reg = < 30010000 10000 >;
			xilinx,gpio-width = <20>;
			xilinx,is-dual = <0>;
		} ;
		ethernet@30040000 {
			compatible = "opb_ethernetlite_1.01.b","opb_ethernetlite";
			reg = < 30040000 10000 >;
			device_type = "network";
			xilinx,duplex = <1>;
			xilinx,rx-ping-pong = <0>;
			xilinx,tx-ping-pong = <0>;
		} ;
		opb_sysace@30050000 {
			compatible = "opb_sysace_1.00.c","opb_sysace";
			reg = < 30050000 10000 >;
			xilinx,mem-width = <10>;
		} ;
		opb_ps2_dual_ref@30060000 {
			compatible = "opb_ps2_dual_ref_1.00.a","opb_ps2_dual_ref";
			interrupts = < 2 0 >;
			interrupts = < 1 0 >;
			reg = < 30060000 10000 >;
		} ;
	};
	opb_intc@10010000 {
		compatible = "opb_intc_1.00.c","opb_intc";
		reg = < 10010000 10000 >;
	} ;
	opb_mdm@10050000 {
		compatible = "opb_mdm_2.00.a","opb_mdm";
		reg = < 10050000 10000 >;
		xilinx,mb-dbg-ports = <1>;
		xilinx,uart-width = <8>;
		xilinx,use-uart = <1>;
	} ;
	serial@10040000 {
		compatible = "opb_uartlite_1.00.b","opb_uartlite";
		interrupts = < 4 0 >;
		reg = < 10040000 10000 >;
		device_type = "serial";
		xilinx,baudrate = <2580>;
		xilinx,data-bits = <8>;
		xilinx,clk-freq = <5f5e100>;
		xilinx,odd-parity = <0>;
		xilinx,use-parity = <0>;
	} ;
	opb2plb_bridge@80000000 {
		ranges = < 0 80000000 80000000 >;
		serial@a0020000 {
			compatible = "plb_uart16550_1.00.c","plb_uart16550";
			reg = < a0020000 10000 >;
			device_type = "serial";
		} ;
		plb_gpio@a0010000 {
			compatible = "plb_gpio_1.00.b","plb_gpio";
			reg = < a0010000 10000 >;
			xilinx,gpio-width = <20>;
			xilinx,is-dual = <0>;
		} ;
		ethernet@a0000000 {
			compatible = "plb_ethernet_1.01.a","plb_ethernet";
			reg = < a0000000 10000 >;
			device_type = "network";
		} ;
		plb2opb_bridge@10000000 {
			ranges = < 0 10000000 10000000 >;
			ranges = < 1 20000000 10000000 >;
		};
		cpus {
			#size-cells = <0>;
			#cpus = < 1 >;
			#address-cells = <1>;
			ppc405_0,405@1 {
				device_type = "cpu";
				reg = <0>;
				clock-frequency = <5f5e1000>;
				timebase-frequency = <1FCA055>;
			} ;
		} ;
	};
} ;
