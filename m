Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B8F5DDDEE1
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Apr 2009 02:03:08 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n3OG2mVs001415
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 09:03:00 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n3OG2lcr028010
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 11:02:48 -0500 (CDT)
Date: Fri, 24 Apr 2009 11:02:47 -0500
From: Scott Wood <scottwood@freescale.com>
To: Andres F Marquez <amarquez@edgeaccess.net>
Subject: Re: Enable Serial Management Controller (SMC) in MPC8265
Message-ID: <20090424160247.GA27627@ld0162-tx32.am.freescale.net>
References: <1240530625.31311.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1240530625.31311.20.camel@localhost.localdomain>
Cc: Nirmala Kakkuppi <nkakkuppi@edgeaccess.net>, linuxppc-dev@ozlabs.org,
	Haysam Rachid <hrachid@edgeaccess.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 23, 2009 at 07:50:25PM -0400, Andres F Marquez wrote:
>      I am working with a MPC8265 processor for which I am compiling a
> Kernel using LTIB.

Please contact Freescale support for issues with BSPs.  Around here
you'll be told to upgrade to the latest upstream kernel. :-)

>       I enabled SCC1 (for the console) and SMC2 through the Kernel
> (2.6.25) configuration tool using LTIB. I am able to run my system and
> execute minicom to try to configure the needed serial port. I have not
> been able to find the tty port that refers to either one of the two SMC
> ports.

All CPM serial ports (whether SCC or SMC) will be /dev/ttyCPMn.

> I have tried all the tty's that I get when I do ls /dev/tty* but
> none of them seem to work. Below, I provide the list of tty's that I am
> getting. ttyCPM0 is being used for the console. ttyCPM1 is the only one
> that I am allowed to configure through minicom (for the rest it says
> device not found).

Not allowed?  Don't you have root access to your board?

>      After doing some research online, I added an entry in my
> mpc8272ads.dts file for the smc serial controller. Below, I provide the
> entries for the serial ports (one SCC1 and one SMC2):
> 
>                         serial@11a00 {
>                                 device_type = "serial";
>                                 compatible = "fsl,mpc8280-scc-uart",
>                                              "fsl,cpm2-scc-uart";
>                                 reg = <11a00 20 8000 100>;
>                                 interrupts = <28 8>;
>                                 interrupt-parent = <&PIC>;
>                                 fsl,cpm-brg = <2>;
>                                 fsl,cpm-command = <00800000>;
>                         };
> 
>                         serial@11a92 {
>                                 device_type = "serial";
>                                 compatible = "fsl,mpc8280-smc-uart",
>                                                 "fsl,cpm2-smc-uart";
>                                 reg = <11a92 20 88fc 2>;
>                                 interrupts = <5 8>;
>                                 interrupt-parent = <&PIC>;
>                                 fsl,cpm-brg = <2>;
>                                 fsl,cpm-command = <21200000>;
>                         };

Do you really have both ports on the same BRG?

Change 11a92 to 11a90 -- it's the address of the register block, not the
first register within the block.

You should also change 8280 to 8265, though nothing currently cares.

Finally, I think 2.6.25 is too old to support automatic allocation of SMC
parameter RAM.  Unless they've backported something in the BSP, you'll
have to manually allocate some space, remove that chunk from the muram
node, program SMC2_BASE yourself, and put the address of the actual
parameter RAM in the device tree.  Or, upgrade to the latest upstream
kernel, or complain to Freescale sales and/or support that the BSP kernel
is too old for your desired use.

> For some reason in uboot, it seems like the configurations for SCC1 and
> SMC2 are exclusive. They depend on where the console is configured
> (SCC1 or SMC2). Either one can be configured, but not both at the same
> time (at least based on uboot configuration definitions. They are
> within if's and elif's...). As I said before, both of them are able to
> run the console.

I don't see any obvious pin conflict between SCC1 and SMC2.  It's
probably just a u-boot limitation -- but make sure that the pins get set
up for SMC2 even if u-boot doesn't use it.

-Scott
