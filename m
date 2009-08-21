Return-Path: <st@iss.tu-darmstadt.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5B240B70BA
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 22 Aug 2009 07:58:02 +1000 (EST)
Received: from lnx141.hrz.tu-darmstadt.de (lnx141.hrz.tu-darmstadt.de
	[130.83.156.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 86E67DDD04
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Aug 2009 07:58:01 +1000 (EST)
Received: from lnx503.hrz.tu-darmstadt.de (lnx503.hrz.tu-darmstadt.de
	[130.83.156.232])
	by lnx141.hrz.tu-darmstadt.de (8.14.2/8.13.8) with ESMTP id
	n7LLrBwi032597
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2009 23:53:11 +0200
	(envelope-from st@iss.tu-darmstadt.de)
Received: from mailserver3.hrz.tu-darmstadt.de (lnx505.hrz.tu-darmstadt.de
	[130.83.156.234])
	by lnx503.hrz.tu-darmstadt.de (8.14.2/8.14.2/HRZ/PMX) with ESMTP id
	n7LLqqBY013076
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2009 23:52:52 +0200
	(envelope-from st@iss.tu-darmstadt.de)
Received: from [213.157.9.24] (helo=IP-213157009024.dialin.heagmedianet.de)
	by mailserver3.hrz.tu-darmstadt.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69) (envelope-from <st@iss.tu-darmstadt.de>)
	id 1Mec2W-0003hP-Eh
	for linuxppc-dev@ozlabs.org; Fri, 21 Aug 2009 23:52:52 +0200
From: ST <st@iss.tu-darmstadt.de>
To: linuxppc-dev@ozlabs.org
Subject: I2C_GPIO defined in device tree?
Date: Fri, 21 Aug 2009 23:53:25 +0200
MIME-Version: 1.0
Message-Id: <200908212353.25951.st@iss.tu-darmstadt.de>
Content-Type: text/plain;
  charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi 

Beeing new to the ppc platform (on xilinx xup fpga) i have a hard time finding 
out the syntax
of the dts file. First i was tring to use the xilinx iic driver but the system 
was always locking 
up when using it. So i thought i am just simply switching to the i2c_gpio 
driver. So i defined 
another 2 port gpio and then got stuck in defining the pins to be used. So i 
would be really glad 
if someone could help me, telling me the proper format to define the GPIO pins 
used by the i2c_gpio 
driver.

Thanks
ST

PS: This is my current xilinx.dts file. "xps_gpio_iic" should provide the sda 
sdl lines for the i2c_gpio driver:


/dts-v1/;
/ {
        #address-cells = <1>;
        #size-cells = <1>;
        compatible = "xlnx,virtex405", "xlnx,virtex";
        model = "testing";
        DDR_SDRAM: memory@0 {
                device_type = "memory";
                reg = < 0x0 0x10000000 >;
        } ;
        alias {
                ethernet0 = &Ethernet_MAC;
                serial0 = &RS232_Uart_1;
        } ;
        chosen {
                bootargs = "console=ttyUL0 root=/dev/xsa2";
                linux,stdout-path = "/plb@0/serial@84000000";
        } ;
        cpus {
                #address-cells = <1>;
                #cpus = <0x1>;
                #size-cells = <0>;
                ppc405_0: cpu@0 {
                        clock-frequency = <200000000>;
                        compatible = "PowerPC,405", "ibm,ppc405";
                        d-cache-line-size = <0x20>;
                        d-cache-size = <0x4000>;
                        dcr-access-method = "native";
                        dcr-controller ;
                        device_type = "cpu";
                        i-cache-line-size = <0x20>;
                        i-cache-size = <0x4000>;
                        model = "PowerPC,405";
                        reg = <0>;
                        timebase-frequency = <200000000>;
                        xlnx,dcr-resync = <0x0>;
                        xlnx,deterministic-mult = <0x0>;
                        xlnx,disable-operand-forwarding = <0x1>;
                        xlnx,fastest-plb-clock = "DPLB0";
                        xlnx,generate-plb-timespecs = <0x1>;
                        xlnx,mmu-enable = <0x1>;
                } ;
        } ;
        plb0: plb@0 {
                #address-cells = <1>;
                #size-cells = <1>;
                compatible = "xlnx,plb-v46-1.03.a", "simple-bus";
                ranges ;
                DDR_SDRAM: mpmc@84800000 {
                        #address-cells = <1>;
                        #size-cells = <1>;
                        compatible = "xlnx,mpmc-4.03.a";
                        reg = < 0x84800000 0x10000 >;
                } ;
                DIPSWs_4Bit: gpio@81480000 {
                        compatible = "xlnx,xps-gpio-1.00.a";
                        reg = < 0x81480000 0x10000 >;
                        xlnx,all-inputs = <0x1>;
                        xlnx,all-inputs-2 = <0x0>;
                        xlnx,dout-default = <0x0>;
                        xlnx,dout-default-2 = <0x0>;
                        xlnx,family = "virtex2p";
                        xlnx,gpio-width = <0x4>;
                        xlnx,interrupt-present = <0x0>;
                        xlnx,is-bidir = <0x1>;
                        xlnx,is-bidir-2 = <0x1>;
                        xlnx,is-dual = <0x0>;
                        xlnx,tri-default = <0xffffffff>;
                        xlnx,tri-default-2 = <0xffffffff>;
                } ;
                Ethernet_MAC: ethernet@81000000 {
                        compatible 
= "xlnx,xps-ethernetlite-2.00.b", "xlnx,xps-ethernetlite-1.00.a";
                        device_type = "network";
                        interrupt-parent = <&xps_intc_0>;
                        interrupts = < 1 0 >;
                        local-mac-address = [ 02 00 00 00 00 00 ];
                        reg = < 0x81000000 0x10000 >;
                        xlnx,duplex = <0x1>;
                        xlnx,family = "virtex2p";
                        xlnx,rx-ping-pong = <0x1>;
                        xlnx,tx-ping-pong = <0x1>;
                } ;
                LEDs_4Bit: gpio@81460000 {
                        compatible = "xlnx,xps-gpio-1.00.a";
                        reg = < 0x81460000 0x10000 >;
                        xlnx,all-inputs = <0x0>;
                        xlnx,all-inputs-2 = <0x0>;
                        xlnx,dout-default = <0x0>;
                        xlnx,dout-default-2 = <0x0>;
                        xlnx,family = "virtex2p";
                        xlnx,gpio-width = <0x4>;
                        xlnx,interrupt-present = <0x0>;
                        xlnx,is-bidir = <0x0>;
                        xlnx,is-bidir-2 = <0x1>;
                        xlnx,is-dual = <0x0>;
                        xlnx,tri-default = <0xffffffff>;
                        xlnx,tri-default-2 = <0xffffffff>;
                } ;
                PushButtons_5Bit: gpio@81440000 {
                        compatible = "xlnx,xps-gpio-1.00.a";
                        reg = < 0x81440000 0x10000 >;
                        xlnx,all-inputs = <0x1>;
                        xlnx,all-inputs-2 = <0x0>;
                        xlnx,dout-default = <0x0>;
                        xlnx,dout-default-2 = <0x0>;
                        xlnx,family = "virtex2p";
                        xlnx,gpio-width = <0x5>;
                        xlnx,interrupt-present = <0x0>;
                        xlnx,is-bidir = <0x1>;
                        xlnx,is-bidir-2 = <0x1>;
                        xlnx,is-dual = <0x0>;
                        xlnx,tri-default = <0xffffffff>;
                        xlnx,tri-default-2 = <0xffffffff>;
                } ;
                RS232_Uart_1: serial@84000000 {
                        clock-frequency = <100000000>;
                        compatible = "xlnx,xps-uartlite-1.00.a";
                        current-speed = <115200>;
                        device_type = "serial";
                        interrupt-parent = <&xps_intc_0>;
                        interrupts = < 2 0 >;
                        port-number = <0>;
                        reg = < 0x84000000 0x10000 >;
                        xlnx,baudrate = <0x1c200>;
                        xlnx,data-bits = <0x8>;
                        xlnx,family = "virtex2p";
                        xlnx,odd-parity = <0x0>;
                        xlnx,use-parity = <0x0>;
                } ;
                SysACE_CompactFlash: sysace@83600000 {
                        compatible = "xlnx,xps-sysace-1.00.a";
                        interrupt-parent = <&xps_intc_0>;
                        interrupts = < 0 2 >;
                        reg = < 0x83600000 0x10000 >;
                        xlnx,family = "virtex2p";
                        xlnx,mem-width = <0x10>;
                } ;
                left_lowspeed: gpio@81420000 {
                        compatible = "xlnx,xps-gpio-1.00.a";
                        reg = < 0x81420000 0x10000 >;
                        xlnx,all-inputs = <0x0>;
                        xlnx,all-inputs-2 = <0x0>;
                        xlnx,dout-default = <0x0>;
                        xlnx,dout-default-2 = <0x0>;
                        xlnx,family = "virtex2p";
                        xlnx,gpio-width = <0x20>;
                        xlnx,interrupt-present = <0x0>;
                        xlnx,is-bidir = <0x1>;
                        xlnx,is-bidir-2 = <0x1>;
                        xlnx,is-dual = <0x0>;
                        xlnx,tri-default = <0xffffffff>;
                        xlnx,tri-default-2 = <0xffffffff>;
                } ;
                xps_bram_if_cntlr_1: xps-bram-if-cntlr@ffffc000 {
                        compatible = "xlnx,xps-bram-if-cntlr-1.00.a";
                        reg = < 0xffffc000 0x4000 >;
                        xlnx,family = "virtex2p";
                } ;
                xps_gpio_iic: gpio@81400000 {
                        compatible = "xlnx,xps-gpio-1.00.a";
                        reg = < 0x81400000 0x10000 >;
                        xlnx,all-inputs = <0x0>;
                        xlnx,all-inputs-2 = <0x0>;
                        xlnx,dout-default = <0x0>;
                        xlnx,dout-default-2 = <0x0>;
                        xlnx,family = "virtex2p";
                        xlnx,gpio-width = <0x2>;
                        xlnx,interrupt-present = <0x0>;
                        xlnx,is-bidir = <0x1>;
                        xlnx,is-bidir-2 = <0x1>;
                        xlnx,is-dual = <0x0>;
                        xlnx,tri-default = <0xffffffff>;
                        xlnx,tri-default-2 = <0xffffffff>;
                } ;
                xps_intc_0: interrupt-controller@81800000 {
                        #interrupt-cells = <0x2>;
                        compatible = "xlnx,xps-intc-1.00.a";
                        interrupt-controller ;
                        reg = < 0x81800000 0x10000 >;
                        xlnx,num-intr-inputs = <0x3>;
                } ;
        } ;
        ppc405_0_dplb1: plb@1 {
                #address-cells = <1>;
                #size-cells = <1>;
                compatible = "xlnx,plb-v46-1.03.a", "simple-bus";
                ranges ;
        } ;
}  ;
