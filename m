Return-Path: <simon.kagstrom@ericsson.com>
Received: from mailgw3.ericsson.se (mailgw3.ericsson.se [193.180.251.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DEFDEDDF2A
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2009 20:23:54 +1100 (EST)
Received: from mailgw3.ericsson.se (unknown [127.0.0.1])
	by mailgw3.ericsson.se (Symantec Mail Security) with ESMTP id
	9A5152074C
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2009 09:50:10 +0100 (CET)
Received: from esealmw128.eemea.ericsson.se (unknown [153.88.253.124])
	by mailgw3.ericsson.se (Symantec Mail Security) with ESMTP id
	EAA79205EC
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2009 09:50:08 +0100 (CET)
Date: Tue, 24 Mar 2009 09:49:59 +0100
From: Simon Kagstrom <simon.kagstrom@ericsson.com>
To: linuxppc-dev@ozlabs.org <linuxppc-dev@ozlabs.org>
Subject: of_serial and device trees
Message-ID: <20090324094959.447a3a31@seasc0532.dyn.rnd.as.sw.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi!

I'm working on a custom Freescale 8544-based board and having some
trouble with getting the device tree right. In particular, we have a
setup which looks like this:

* We have an FPGA which contains a few serial ports, an interrupt
  controller and some other devices

* The serial ports are "normal" 16550s and interrupt the FPGA interrupt
  controller

* The interrupt controller is in turn cascaded to the 8544 OpenPIC
  (mpic).

My problem is that I can't figure out how to express this correctly in
the device tree for the board. My device tree looks like this ("isf" is
the name of the FPGA):

	isf@c0020000 {
		#address-cells = <1>;
		#size-cells = <1>;
		reg = <c0020000 00020000>;

                isf_pic: isf_pic@4000 {
                        device_type = "isf-pic";
                        compatible = "isf-pic";
                        interrupt-controller;
                        clock-frequency = <0>;
                        #address-cells = <0>;
                        #interrupt-cells = <2>;
                        reg = <4000 100>;
                        built-in;
                        interrupts = <4 1>;
                        interrupt-parent = <&mpic>;
                };

                serial2: isf-serial@4200 {
                        device_type = "serial";
                        compatible = "ns16550";
                        reg = <4200 100>;
                        clock-frequency = <13ab6680>; /* 330Mhz */
                        interrupts = <0 1>;
                        interrupt-parent = <&isf_pic>;
                };
                <... and a few more serial ports which look the same >

Following the example set in mpc85xx_ds.c, I lookup the interrupt
controller manually in the platform setup code (init_IRQ). Basically

        np = of_find_compatible_node(NULL, "isf-pic", "isf-pic");
        if (np == NULL) {
                printk(KERN_ERR "Could not find ISF PIC\n");
                return;
        }

and thereafter calling a custom setup function for the FPGA interrupt
controller. That appears to work fine, but I'm wondering how to get the
serial ports detected properly by of_serial.

I suppose I can do something similar in code to what is done in
arch/powerpc/kernel/legacy_serial.c:find_legacy_serial_ports, but I
thought I could do without that with the device trees. Is it so, or do
I have to add code to walk through and setup the rest of the serial
ports?

Thanks in advance,
// Simon
