Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D4F4ADDE0A
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 04:52:32 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n0LHqRJH012497
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 10:52:28 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n0LHqQNc012924
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 11:52:26 -0600 (CST)
Date: Wed, 21 Jan 2009 11:52:25 -0600
From: Scott Wood <scottwood@freescale.com>
To: Daniel Ng <daniel.ng1234@gmail.com>
Subject: Re: Device Tree setup for 8272-based board
Message-ID: <20090121175225.GB31266@ld0162-tx32.am.freescale.net>
References: <547eba1b0901151722p4a6afce4nc769fcb8cff82ea6@mail.gmail.com>
	<547eba1b0901151940x588ead2bk52342ea1cecc6db0@mail.gmail.com>
	<20090116181405.GB722@ld0162-tx32.am.freescale.net>
	<547eba1b0901181758q27d09f1fx7d07d7385f028312@mail.gmail.com>
	<547eba1b0901192323i2a505dcg841d42092dc5dd5d@mail.gmail.com>
	<20090120164124.GC8978@ld0162-tx32.am.freescale.net>
	<547eba1b0901202337g624f79b2uaa7f7f2f61990ad1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <547eba1b0901202337g624f79b2uaa7f7f2f61990ad1@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 21, 2009 at 06:37:32PM +1100, Daniel Ng wrote:
> I think the of_get_gpio() error messages are a result of the following
> code in cpm_uart_init_port()-
> 
>   for (i = 0; i < NUM_GPIOS; i++)
>     pinfo->gpios[i] = of_get_gpio(np, i);
> 
> -why is this code here? Is it for processing modem control lines?

Yes.

> I know our board doesn't make use of the modem control lines for
> ttyCPM0. Therefore, have I misconfigured something in the Device Tree?

No, those are just not-found errors from the code that is checking the
device tree to see if the control lines are there or not.  It's harmless.

>       brg@119f0 {
>         compatible = "fsl,mpc8272-brg",
>                      "fsl,cpm2-brg",
>                      "fsl,cpm-brg";
>         reg = <0x119f0 0x10 0x115f0 0x10>;
>       };

Is clock-frequency getting filled in?

Note that there's another thread about this exact issue;
see "[MPC8272ADS]Cannot start my Linux Kernel".

> Would you please explain what the following lines mean, so I can use
> some more appropriate values for my particular board?-
> 
> 1) In the serial@11a00 node-
> 
> a) reg = <0x11a00 0x20 0x8000 0x100>;

IMMR offset and length of the SCC1 registers, followed by offset and
length of the parameter RAM registers.

> b) interrupts = <40 8>;

Interrupt number, followed by level/sense information (see
dts-bindings/fsl/cpm_qe/cpm/pic.txt).

> c) fsl,cpm-brg = <1>;

BRG number that this serial port uses.

> d) fsl,cpm-command = <0x800000>;

Value to put in the CPM command register for SCC1.

> 2) In the brg@119f0 node-
> reg = <0x119f0 0x10 0x115f0 0x10>;

Offset and length of two blocks of BRG registers.

> 3) In the PIC: interrupt-controller@10c00 node-
> reg = <0x10c00 0x80>;

Offset and length of PIC registers.

> I have read the relevant documentation under Documentation/powerpc and
> Documentation/powerpc/dts-bindings, but these do not seem to go into
> enough detail eg.
> Documentation/powerpc/dts-bindings/fsl/cpm_qe/cpm/brg.txt says the
> following about the reg property-
> 
> - reg : There may be an arbitrary number of reg resources; BRG
>   numbers are assigned to these in order.
> 
> -> does this mean that each number represents a BRG register? So there
> can be a maximum of 1+8=9 reg values, since there are 8 BRG registers?

No, there can be multiple BRGs per register block.

> As for Documentation/powerpc/dts-bindings/fsl/cpm_qe/serial.txt, there
> is no explanation at all for what the 'reg', 'interrupts', 'brg' and
> 'command' values mean... Am I missing something obvious?

brg and command are defined in dts-bindings/fsl/cpm_qe/cpm.txt.  reg and
interrupts are standard properties that are defined in
Documentation/powerpc/booting-without-of.txt, as well as in the ePAPR
document.

The device-specific bindings are only meant to explain things that are
specific to that device, not things that are common to all device trees.

> Similarly for Documentation/powerpc/dts-bindings/fsl/cpm_qe/pic.txt,
> there is no explanation of the 'reg' value. Also, it mentions a
> 'second interrupt cell' but I only see one in the example it gives.
> Here is what it says-

The example is of the interrupt controller node, not of an interrupt
underneath it.  There are no interrupt cells in that node, but
#interrupt-cells *is* 2.

> Does the level/sense refer to ALL interrupts?

I don't follow.  Interrupt specifiers have the second cell if, and only
if, the interrupt controller has #interrupt-cells = <2>.  For PQ2, that
is the case.

-Scott
