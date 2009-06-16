Return-Path: <dwh@ovro.caltech.edu>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 721ACB70A5
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 02:30:10 +1000 (EST)
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id B1796DDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 02:30:09 +1000 (EST)
Message-ID: <4A37C88F.8040701@ovro.caltech.edu>
Date: Tue, 16 Jun 2009 09:30:07 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Leon Woestenberg <leon.woestenberg@gmail.com>
Subject: Re: MPC83xx watchdog reset board dead lock
References: <c384c5ea0906160852l4845760cp8594463a866683dc@mail.gmail.com>
In-Reply-To: <c384c5ea0906160852l4845760cp8594463a866683dc@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linux PPC <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Leon,

> Most MPC8xxx board designs I have seen suffer from this possible dead lock:
> - NOR Flash is put in erase mode or write mode
> - Hardware watchdog triggers
> - HRESET# is asserted by the processor, during which the configuration
> words are read from NOR Flash.
> 
> Either
> HRESET# is not attached to NOR, NOR stays in erase/write mode and
> invalid words will be read -> dead lock
> 
> or either:
> HRESET# is attached to NOR reset, NOR is reset, but stays in reset as
> HRESET# stays asserted.
> 
> We have been looking at several solutions hardware wise that reset the
> NOR flash on HRESET# going low, but the processors are stubborn,
> read the config words only once, than dead lock.
> 
> I wonder if there are known-working designs for this.

What do you do in the case of blank flash on a board?

I'm not sure that this will work for you, but it might ...
on my boards, the PowerPC connects to an FPGA on the local
bus, and the flash is connected to that FPGA (it made
routing easier to go through the FPGA). When the board
powers up, a small FSM in the FPGA reads from the first
word in Flash, and checks it is not blank. If it is
blank, the configuration pins are asserted such that
the processor uses a hard-coded reset configuration word,
and the processor reset is deasserted. If the flash is
not blank, the processor is allowed to boot from Flash.

An alternative method for firmware updates would be
to use the boot from high-mem versus low-mem flag
in the RCWs. On a number of the Freescale EVMs, you
can have two images in the Flash; one at low mem,
and one at high mem. Toggling a dip switch selects
the value of the BMS bit in the RCWs, and lets you boot
from one image or the other. This is a good trick that
avoids having to have a debugger to recover back
to a sane image - note that a CPLD delivers the RCWs,
not the flash.

So in either of these examples, the RCWs source is
sometimes not the Flash image ... which requires
that feature designed into the original hardware.

Those two ideas should get you thinking :)

Cheers,
Dave
