Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3F0F1DDEF1
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Jun 2007 21:36:23 +1000 (EST)
Message-ID: <467FA0EA.3000607@genesi-usa.com>
Date: Mon, 25 Jun 2007 12:03:06 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Mem-2-Mem DMA - Generalized API
References: <20070624193932.GA11797@clifford.at>
	<200706242221.57507.arnd@arndb.de>
In-Reply-To: <200706242221.57507.arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
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

IOAT and Intel's DMA engine driver is very IOAT specific in places..

I had a peek at it as I have a little interest in the concept; at least the
two platforms Genesi has been supporting (Pegasos and Efika) have quite
competant DMA engines which are woefully underused (i.e. not at all).

There exists a Marvell DMA driver somewhere (I have a copy, someone on
this list posted it about a year ago) and while the MPC5200B doesn't have
explicit support for DMA from memory to memory (although memory to SRAM
might work in chunks, or memory to a FIFO wired as a loopback like in
the docs..??)

There is so much you can do with most SoC DMA controllers, and it's not
even limited to PowerPC (most ARM/XScale SoCs have very capable devices
inside too). I can only imagine that nobody got excited over IOAT because
the entire programming interface stinks of "offloading gigabit ethernet"
and not much else.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Arnd Bergmann wrote:
> On Sunday 24 June 2007, Clifford Wolf wrote:
>> I'm working on an MPC8349E based project and as some of you might know this
>> chip has a four channel (bus-) memory-to-memory DMA controller.
>>
>> Unfortunately the linux kernel is atm lacking a generic interface for such
>> DMA controllers.
> 
> So what's wrong with the include/linux/dmaengine.h API? I thought it was
> designed to cover this sort of DMA controller?
> 
> 	Arnd <><
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
