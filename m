Return-Path: <msm@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id F3B8D67BC4
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Sep 2006 04:59:35 +1000 (EST)
Subject: Re: How to move from /ppc/ to /powerpc/
From: Matthew McClintock <msm@freescale.com>
To: Fredrik Roubert <roubert@df.lth.se>
In-Reply-To: <20060925174101.GC21204@igloo.df.lth.se>
References: <20060912153316.GC16340@igloo.df.lth.se>
	<20060912105830.3923d537.kim.phillips@freescale.com>
	<20060913132817.GD18263@igloo.df.lth.se>
	<20060921160808.GB4828@igloo.df.lth.se>
	<1159202991.5485.0.camel@localhost>
	<20060925171754.GB21204@igloo.df.lth.se>
	<1159204851.5485.6.camel@localhost>
	<20060925174101.GC21204@igloo.df.lth.se>
Content-Type: text/plain
Date: Mon, 25 Sep 2006 13:59:23 -0500
Message-Id: <1159210763.5485.10.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 2006-09-25 at 19:41 +0200, Fredrik Roubert wrote:

> Now I'm back to the state of last Thursday (except for getting rid of
> the unnecessary chosen node and getting bootargs passed nicely), which
> means that the serial console initially works, but stops working after
> the call to console_init() in start_kernel().

Do you have all the other OF related defines in your u-boot config
file? 

#define OF_CPU                  "PowerPC,8540@0"
#define OF_SOC                  "soc8540@e0000000"
#define OF_TBCLK                (bd->bi_busfreq / 8)
#define OF_STDOUT_PATH          "/soc8540@e0000000/serial@4500"

Maybe you are not properly setting up entries in the flat device tree
passed to the kernel. So when the kernel takes over and re-initializes
the serial port the speed is all messed up.

Can you verify the flat device tree passed to the kernel is correct?
Specifically these properties:

                timebase-frequency = <0>;       // from bootloader
                bus-frequency = <0>;            // from bootloader
                clock-frequency = <0>;          // from bootloader

-Matthew
