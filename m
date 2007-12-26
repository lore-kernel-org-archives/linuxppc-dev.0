Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id B1C96DE01F
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Dec 2007 03:28:25 +1100 (EST)
Date: Wed, 26 Dec 2007 19:29:44 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] [POWERPC] MPC8360E-RDK: Device tree and board file
Message-ID: <20071226162943.GB11230@localhost.localdomain>
References: <20071221202309.GA4557@localhost.localdomain>
	<476DD544.2050807@freescale.com>
	<20071224121546.GA7903@localhost.localdomain>
	<47716BBE.5090000@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <47716BBE.5090000@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 25, 2007 at 02:44:46PM -0600, Timur Tabi wrote:
> Anton Vorontsov wrote:
> 
> >Yup. I've seen it, thanks. I'm going to test it as well. ;-)
> 
> If they work for you, please let Kumar know.

Unfortunately they don't.

root@mpc8360erdk:~# echo abc > /dev/ttyQE0

And hang. No interrupts.

After ^C:
ucc_uart e0102400.ucc: shutdown timeout

The same for ttyQE1 (just for testing I set it up to not use
Soft-UART).

The same for loopback mode.

I wonder what are the symptoms if microcode is at fault? According
to errata description, hang isn't something I should get on the
transmit attempt.

> >MPC8360E, Rev: 21. Are you aware of any known issues on this chip
> >regarding UCC serials?
> 
> Yep.  You need a microcode upload.  My patches describe everything.

Well. All I've found is: QERAMPTCH.zip ("RAM Microcode Patches for
PowerQUICC II Pro Family QE Errata"), which should fix QE_UART5 errata
for MPC8323 Rev 1.1. Can I assume it works for MPC8360 too? I've tried
it. No luck.

Here are dts entries I use:

		firmware {
			id = "Soft-UART";
			extended_modes = <0 0>;
			virtual_traps = <0 0 0 0 0 0 0 0>;
		};

		ucc@2400 {
			device_type = "serial";
			compatible = "ucc_uart";
			reg = <0x2400 0x200>;
			device-id = <5>;
			port-number = <0>;
			rx-clock-name = "brg7";
			tx-clock-name = "brg8";
			interrupts = <40>;
			interrupt-parent = <&qeic>;
			soft-uart;
		};

		ucc@3400 {
			device_type = "serial";
			compatible = "ucc_uart";
			reg = <0x3400 0x200>;
			device-id = <6>;
			port-number = <1>;
			rx-clock-name = "brg14";
			tx-clock-name = "brg14";
			interrupts = <41>;
			interrupt-parent = <&qeic>;
		};

Any ideas?

Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
