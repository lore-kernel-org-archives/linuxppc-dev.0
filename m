Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 71D6BDDF57
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 04:51:17 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n0KHp6D2004491
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jan 2009 10:51:07 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n0KHp60N019194
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jan 2009 11:51:06 -0600 (CST)
Date: Tue, 20 Jan 2009 11:51:05 -0600
From: Scott Wood <scottwood@freescale.com>
To: Jean-Michel Hautbois <jhautbois@gmail.com>
Subject: Re: [MPC8272ADS]Cannot start my Linux Kernel
Message-ID: <20090120175105.GA9844@ld0162-tx32.am.freescale.net>
References: <8cad0aa0901150510o7a8146f1m2045e252c5e1cf24@mail.gmail.com>
	<496F4760.1010007@denx.de>
	<8cad0aa0901150706u72538941rbc22655d5a8905ea@mail.gmail.com>
	<8cad0aa0901160406l3db9c025ubdcac40b4b464d23@mail.gmail.com>
	<20090116172903.GA722@ld0162-tx32.am.freescale.net>
	<8cad0aa0901160944l48bd0e99wa13f23907838376d@mail.gmail.com>
	<8cad0aa0901160953te6c7d1cg3a4df7de7da7d182@mail.gmail.com>
	<4970CBA9.60809@freescale.com>
	<8cad0aa0901200256n6122d17eh90f56e9cb8cae775@mail.gmail.com>
	<8cad0aa0901200827o5f225ac9rfe2a13984e83d4d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <8cad0aa0901200827o5f225ac9rfe2a13984e83d4d3@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 20, 2009 at 05:27:09PM +0100, Jean-Michel Hautbois wrote:
> 2009/1/20 Jean-Michel Hautbois <jhautbois@gmail.com>:
> > OK, I just tried a cuImage and a ramdisk without a FDT. I am starting
> > to boot, but it freezes.
> [...]
> > Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256
> > Kernel command line: root=/dev/ram rw
> > PID hash table entries: 256 (order: 8, 1024 bytes)
> > time_init: decrementer frequency = 25.000000 MHz
> > time_init: processor frequency   = 400.000000 MHz
> > clocksource: timebase mult[a000000] shift[22] registered
> > clockevent: decrementer mult[666] sh�
> >
> 
> Having a look at the arch/powerpc/kernel/time.c file, where I am
> getting halted, it seems that the kernel reads the CPU frequency. Here
> is my question: My board has an OSC that is 100MHz (and not 400MHz !).
> I think this could be my explanation, but I can't see how I could
> solve this problem...

A multiplier is applied to the crystal to get the CPU's internal
frequency.  Try printing out what the kernel thinks the BRG frequency is.

-Scott
