Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D2D39B6ED0
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jul 2010 09:18:42 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o66NID2P022937
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Jul 2010 16:18:13 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o66NSf79008437
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Jul 2010 18:28:41 -0500 (CDT)
Date: Tue, 6 Jul 2010 18:18:11 -0500
From: Scott Wood <scottwood@freescale.com>
To: Shawn Jin <shawnxjin@gmail.com>
Subject: Re: kernel boot stuck at udbg_putc_cpm()
Message-ID: <20100706181811.4542df5a@schlenkerla.am.freescale.net>
In-Reply-To: <AANLkTikNgYy9aAUAe9wTsNKDg3cNokSTVJ_6aA6n3SI9@mail.gmail.com>
References: <AANLkTikzt4mVGdYzRF2pgficbeinNydkr9E0YQjgJT1I@mail.gmail.com>
	<20100706152110.4f25e96b@schlenkerla.am.freescale.net>
	<AANLkTikNgYy9aAUAe9wTsNKDg3cNokSTVJ_6aA6n3SI9@mail.gmail.com>
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

On Tue, 6 Jul 2010 16:08:26 -0700
Shawn Jin <shawnxjin@gmail.com> wrote:

> On Tue, Jul 6, 2010 at 1:21 PM, Scott Wood <scottwood@freescale.com>
> wrote:
> > Hmm... try 0xfa203bf8 (assuming your muram/data node has reg =3D <0
> > 0x1c00>). It looks like commit
> > 0x1c00>c2dd3529f35de9e2f51eba9bbf9969f5dc8382d4
> > changed the bootwrapper's cpm-serial driver to allocate from the
> > end of MURAM instead of the beginning, but updated
> > CONFIG_PPC_EARLY_DEBUG_CPM_ADDR to match only on CPM2, not CPM1.
>=20
> That was it. The value @0xfa203bf8 is 0x20000001. The kernel certainly
> moved forward till it stuck at the new place cpm_uart_initbd() as
> shown below.

Do you get any output from the serial port?  I'd have expected
something by the time you get to cpm_uart_initbd() -- in fact, the
early output will have been shut down by then to make room for the real
serial driver.

> (gdb) target remote bdi:2001
> Remote debugging using bdi:2001
> cpm_uart_initbd (pinfo=3D0x1032)
>     at /home/rayan/wti/code/wti-linux-2.6.33.5/arch/powerpc/include/asm/i=
o.h:161
> 161     DEF_MMIO_OUT_BE(out_be32, 32, stw);
>=20
>=20
> > Could the kernel have crashed, and is waiting the 180 seconds to
> > reboot? =A0Try doing a stack trace, and/or dumping the kernel's log
> > buffer.
>=20
> It sounds like that. gdb showed there was only one level of function
> in the stack, which was udelay(). Strange?

Might be related to it not dealing with effective addresses.

> How to dump the kernel log buffer?

Find the address of __log_buf, and dump the memory there (subtract
0xc0000000 if you're dealing with physical addresses).

-Scott
