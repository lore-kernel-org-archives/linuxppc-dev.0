Return-Path: <jeff@theptrgroup.com>
Received: from mail.theptrgroup.com (mail.theptrgroup.com [71.246.247.9])
	by ozlabs.org (Postfix) with ESMTP id 76947DDE28
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 02:42:14 +1100 (EST)
Subject: Re: [MPC8272ADS]Cannot start my Linux Kernel
From: jeff angielski <jeff@theptrgroup.com>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20090120163155.GA8978@ld0162-tx32.am.freescale.net>
References: <496F318D.6010302@denx.de>
	<8cad0aa0901150510o7a8146f1m2045e252c5e1cf24@mail.gmail.com>
	<496F4760.1010007@denx.de>
	<8cad0aa0901150706u72538941rbc22655d5a8905ea@mail.gmail.com>
	<8cad0aa0901160406l3db9c025ubdcac40b4b464d23@mail.gmail.com>
	<20090116172903.GA722@ld0162-tx32.am.freescale.net>
	<8cad0aa0901160944l48bd0e99wa13f23907838376d@mail.gmail.com>
	<8cad0aa0901160953te6c7d1cg3a4df7de7da7d182@mail.gmail.com>
	<4970CBA9.60809@freescale.com>
	<8cad0aa0901200256n6122d17eh90f56e9cb8cae775@mail.gmail.com>
	<20090120163155.GA8978@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 21 Jan 2009 10:42:10 -0500
Message-Id: <1232552530.7186.5.camel@penguin>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Jean-Michel Hautbois <jhautbois@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2009-01-20 at 10:31 -0600, Scott Wood wrote:
> On Tue, Jan 20, 2009 at 11:56:58AM +0100, Jean-Michel Hautbois wrote:
> > Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256
> > Kernel command line: root=/dev/ram rw
> > PID hash table entries: 256 (order: 8, 1024 bytes)
> > time_init: decrementer frequency = 25.000000 MHz
> > time_init: processor frequency   = 400.000000 MHz
> > clocksource: timebase mult[a000000] shift[22] registered
> > clockevent: decrementer mult[666] sh�
> 
> That looks like something is failing when the real (as opposed to early
> debug) serial driver starts.  Try commenting out the call to cpm_setbrg
> in drivers/serial/cpm_uart/cpm_uart_cpm2.h; if that makes a difference,
> there's something wrong with the brg node in the device tree.

I used the mpc8272ads as the basis for my mpc8265 port to 2.6 and found
that to get the serial ports to clock correctly, I needed to add
"clock-frequency" to the brg node in the DTS file.  

Here is mine:

brg@119f0 {
	compatible = "mpc8265-brg",
             "fsl,cpm2-brg",
             "fsl,cpm-brg";
	reg = <0x119f0 0x10 0x115f0 0x10>;
	clock-frequency = <0>;
};

Of course, you also need to update your ft_blob_update() in u-boot to
fill in the correct value.

The default values in the cpm2 code did not work for my system clock
configuration.


-- 
Jeff Angielski
The PTR Group
www.theptrgroup.com
