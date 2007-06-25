Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 670A9DDE22
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Jun 2007 22:53:22 +1000 (EST)
Message-ID: <467FBABD.9040103@anagramm.de>
Date: Mon, 25 Jun 2007 14:53:17 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: Mem-2-Mem DMA - Generalized API
References: <20070624193932.GA11797@clifford.at>	<200706242221.57507.arnd@arndb.de>
	<467FA0EA.3000607@genesi-usa.com>
In-Reply-To: <467FA0EA.3000607@genesi-usa.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello, Matt!

Matt Sealey schrieb:
> IOAT and Intel's DMA engine driver is very IOAT specific in places..
> 
> I had a peek at it as I have a little interest in the concept; at least the
> two platforms Genesi has been supporting (Pegasos and Efika) have quite
> competant DMA engines which are woefully underused (i.e. not at all).

True.

> There exists a Marvell DMA driver somewhere (I have a copy, someone on
> this list posted it about a year ago) and while the MPC5200B doesn't have
> explicit support for DMA from memory to memory (although memory to SRAM
> might work in chunks, or memory to a FIFO wired as a loopback like in
> the docs..??)
 >
> There is so much you can do with most SoC DMA controllers, and it's not
> even limited to PowerPC (most ARM/XScale SoCs have very capable devices
> inside too). I can only imagine that nobody got excited over IOAT because
> the entire programming interface stinks of "offloading gigabit ethernet"
> and not much else.

The main question remains: Is it possible to have a flexible cross platform
DMA API which handles even complex requests and does scheduling, prioritizing,
queuing, locking, (re-)building/caching of SG lists... automagically.

It could fall back to CPU's memcpy if the hardware doesn't have
the ability to use the DMA machine because all channels are already busy,
or the requested memory isn't DMAable or the request is just too small
that it doesn't make sense to setup a DMA channel.
Filling memory with zero is also a simple task for a DMA engine.
(Thinking about malloc() and memset())

The problem is IMHO similar to video acceleration. Within the
Xorg's XAA/EXA/whatever framework, the drivers accelerate certain
calls if the hardware has the capability to do so. Other calls fall back
to some default non accelerated memcpy() & friends.

Sounds like a lot of fun... replacing kernel's and libc's memcpy() with
memcpy_with_dma_if_possible(). :-)

Best regards,
-- 
Clemens Koller
__________________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Straße 45/1
Linhof Werksgelände
D-81379 München
Tel.089-741518-50
Fax 089-741518-19
http://www.anagramm-technology.com
