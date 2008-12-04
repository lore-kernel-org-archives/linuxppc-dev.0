Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [204.133.123.27])
	by ozlabs.org (Postfix) with ESMTP id 90A2CDDDEF
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2008 00:51:16 +1100 (EST)
Message-ID: <4937E048.90206@mlbassoc.com>
Date: Thu, 04 Dec 2008 06:51:04 -0700
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: MPC5200 VIRQ question
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have a MPC5200 based board which has an FPGA for external
I/O, etc.  This FPGA also funnels interrupts from the various
external devices through to the CPU.

I've defined this structure in my DTS:

	fpga@f8000000 {
		device_type = "board-control";
		#address-cells = <1>;
		#size-cells = <1>;
		// Note: includes sub-devices like CAN, A/D, etc
		reg = <0xf8000000 0x100000>;

		fpga_ic: fpga_ic@f8000000 {
			device_type = "fpga-int-ctlr";
			interrupt-controller;
			#address-cells = <0>;
			#interrupt-cells = <2>;
			interrupts = <2 26 3>; // IRQ2
			interrupt-parent = <&mpc5200_pic>;
		};
		can@f8010000 {
			compatible = "am,can";
			device_type = "can";
			interrupts = <0 0>;
			interrupt_parent = <&fpga_ic>;
			reg = <0xf8010000 0x200>;
		};
	};

Of course, there will be more devices and interrupts later on,
this is just the first of many.

Now the questions:
 * How do I choose the VIRQ range supported by my FPGA?
   I'm interested in this in particular for the MPC5200, but
   also for other chips (I have many such board configurations).
 * How do I pass this information along to my drivers?  I would
   think that the interrupts value for the can interface above
   would use a [logical] IRQ (an offset from the base VIRQ),
   so how does the driver get the actual number (VIRQ+offset)
   when probing the tree?
 * I know how to define the interrupt controller using irq_alloc_host()
   (once I have the VIRQ range) but it's not clear to me where to stick
   this initialization when bringing up my platform.

Thanks for any pointers/ideas

n.b. I've read all the arguments about not using "device_type"
and this will be resolved.  At the moment, I'm basing my
code on a slightly older kernel codebase (2.6.26), so those
entries remain.

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
