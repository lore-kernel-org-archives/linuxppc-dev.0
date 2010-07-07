Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1DE46B6F0C
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jul 2010 01:42:47 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o67Fgi0a002510
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jul 2010 08:42:44 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o67FsZtZ029030
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jul 2010 10:54:36 -0500 (CDT)
Date: Wed, 7 Jul 2010 10:42:42 -0500
From: Scott Wood <scottwood@freescale.com>
To: Shawn Jin <shawnxjin@gmail.com>
Subject: Re: kernel boot stuck at udbg_putc_cpm()
Message-ID: <20100707104242.6bd48994@schlenkerla.am.freescale.net>
In-Reply-To: <AANLkTimUxcsTMXNPOFfJxybp8u7Wv7Mt_nhW1EE01RqG@mail.gmail.com>
References: <AANLkTikzt4mVGdYzRF2pgficbeinNydkr9E0YQjgJT1I@mail.gmail.com>
	<20100706152110.4f25e96b@schlenkerla.am.freescale.net>
	<AANLkTikNgYy9aAUAe9wTsNKDg3cNokSTVJ_6aA6n3SI9@mail.gmail.com>
	<20100706181811.4542df5a@schlenkerla.am.freescale.net>
	<AANLkTimUxcsTMXNPOFfJxybp8u7Wv7Mt_nhW1EE01RqG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 6 Jul 2010 17:17:16 -0700
Shawn Jin <shawnxjin@gmail.com> wrote:

> >> That was it. The value @0xfa203bf8 is 0x20000001. The kernel
> >> certainly moved forward till it stuck at the new place
> >> cpm_uart_initbd() as shown below.
> >
> > Do you get any output from the serial port? =A0I'd have expected
> > something by the time you get to cpm_uart_initbd() -- in fact, the
> > early output will have been shut down by then to make room for the
> > real serial driver.
>=20
> Nothing new on the serial port. :-( Is the interrupt enabled during
> the early debug stage? I'm not sure if the interrupt controller is set
> properly in DTS. The same MPC875 settings are copied from the
> adder875-uboot.dts.

Interrupts are not used for the early serial output.

>=20
>     Memory <- <0x0 0x8000000> (128MB)
>     ENET0: local-mac-address <- 00:09:9b:01:58:64
>     CPU clock-frequency <- 0x7270e00 (120MHz)
>     CPU timebase-frequency <- 0x393870 (4MHz)
>     CPU bus-frequency <- 0x3938700 (60MHz)
>=20
>     zImage starting: loaded at 0x00400000 (sp: 0x07d1ccd0)
>     Allocating 0x186bdd bytes for kernel ...
>     gunzipping (0x00000000 <- 0x0040c000:0x00591c30)...done 0x173b18
> bytes
>=20
>     Linux/PowerPC load: root=3D/dev/ram
>     Finalizing device tree... flat tree at 0x59e300
>=20
> Here is the kernel log buf dump. Anything suspicious?

Nope, looks normal.

-Scott
