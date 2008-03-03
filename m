Return-Path: <phdm@macqel.be>
Received: from mail.macqel.be (mail.macqel.be [194.78.208.39])
	by ozlabs.org (Postfix) with ESMTP id 84CDEDDEE7
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 01:47:31 +1100 (EST)
Date: Mon, 3 Mar 2008 15:47:27 +0100
From: Philippe De Muyter <phdm@macqel.be>
To: linuxppc-dev@ozlabs.org
Subject: ARCH=ppc -> ARCH=powerpc : help needed for dts file
Message-ID: <20080303144727.GA27949@ingate.macqel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

I have a currently almost working ARCH=ppc linux-2.6.24 configuration for a
new mpc8540 board (except for a RTC chip connected to an i2c bus).

Knowing that ARCH=ppc will be removed, I try to make the ARCH=powerpc version
work, but that's not easy.

I have copied the mpc8540ads.dts file to a new dts file, and added the
following :

			i2c@3000 {
	+                       #address-cells = <1>;
	+                       #size-cells = <0>;
				device_type = "i2c";
				compatible = "fsl-i2c";
				reg = <3000 100>;
				interrupts = <2b 2>;
				interrupt-parent = <&mpic>;
				dfsrr;
	+
	+                       rtc@68 {
	+                               compatible = "stm,m41t81";
	+                               reg = <68>;
	+                       };
			};

and I see in the boot log that my RTC chip is now working.


My root device is on a compact-flash connected to a PCI yenta chip from TI,
and this one is not working, altough it seems to be discovered :

	Yenta: CardBus bridge found at 0000:00:12.0 [0000:0000]
	Yenta: Using CSCINT to route CSC interrupts to PCI
	Yenta: Routing CardBus interrupts to PCI
	Yenta TI: socket 0000:00:12.0, mfunc 0x00001b22, devctl 0x64
	irq 18: nobody cared (try booting with the "irqpoll" option)
	Call Trace:
	[cf813af0] [c00066c8] show_stack+0x3c/0x1bc (unreliable)
	[cf813b30] [c003c1ac] __report_bad_irq+0x38/0xcc
	[cf813b50] [c003c4c8] note_interrupt+0x288/0x2cc
	[cf813b80] [c003cc34] handle_fasteoi_irq+0x94/0xf8

but my boot finally fails with :

	VFS: Cannot open root device "hda1" or unknown-block(0,0)
	Please append a correct "root=" boot option; here are the
	available partitions:
	1f00       8192 mtdblock0 (driver?)
	Kernel panic - not syncing: VFS: Unable to mount root fs
	on unknown-block(0,0)

Is there an easy way to use values found in /proc or even in the sources
in my working ppc setup to put them in the dts file to make my new powerpc
configuration work ?

Thanks for listening

Philippe
