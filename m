Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8594ADDEED
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Jun 2007 00:31:28 +1000 (EST)
Message-ID: <467FD1DF.4000602@genesi-usa.com>
Date: Mon, 25 Jun 2007 15:31:59 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Clemens Koller <clemens.koller@anagramm.de>
Subject: Re: Mem-2-Mem DMA - Generalized API
References: <20070624193932.GA11797@clifford.at>	<200706242221.57507.arnd@arndb.de>
	<467FA0EA.3000607@genesi-usa.com> <467FBABD.9040103@anagramm.de>
In-Reply-To: <467FBABD.9040103@anagramm.de>
Content-Type: text/plain; charset=UTF-8
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


Clemens Koller wrote:
> Hello, Matt!
> 
>> There is so much you can do with most SoC DMA controllers, and it's not
>> even limited to PowerPC (most ARM/XScale SoCs have very capable devices
>> inside too). I can only imagine that nobody got excited over IOAT because
>> the entire programming interface stinks of "offloading gigabit ethernet"
>> and not much else.
> 
> The main question remains: Is it possible to have a flexible cross platform
> DMA API which handles even complex requests and does scheduling,
> prioritizing, queuing, locking, (re-)building/caching of SG lists... automagically.

I would think so. I think there is a fairly generic example in many parts
of the Linux kernel. Dare I say the Via Unichrome AGP subsystem? And a
bunch of the ARM/OMAP platforms..? A lot of the code is even identical,
I wonder why it isn't some library rather than platform drivers.

> Filling memory with zero is also a simple task for a DMA engine.
> (Thinking about malloc() and memset())

Also xor and logical operations, byte swapping huge chunks of data, that
kind of thing. Most DMA engines in SoCs have cute features like that. I
think BestComm can even calculate CRCs for IP packets.

> The problem is IMHO similar to video acceleration. Within the
> Xorg's XAA/EXA/whatever framework, the drivers accelerate certain
> calls if the hardware has the capability to do so. Other calls fall back
> to some default non accelerated memcpy() & friends.
> 
> Sounds like a lot of fun... replacing kernel's and libc's memcpy() with
> memcpy_with_dma_if_possible(). :-)

Indeed. I wonder if we could pull apart the IOAT/DMA stuff and genericise
it (it should be possible) or simply add to it, or if making a powerpc
specific dma engine abstraction would be an easier idea.

Probably the latter to be merged with the former at a later date would
be easier to manage. Take inspiration but don't be bound by Intel's
weird "new" (i.e. 15 year old) concept?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
