Return-Path: <clifford@clifford.at>
Received: from phoenix.clifford.at (phoenix.clifford.at [88.198.7.52])
	by ozlabs.org (Postfix) with ESMTP id EE2F8DDE49
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Jun 2007 03:57:47 +1000 (EST)
Date: Mon, 25 Jun 2007 20:01:10 +0200
From: Clifford Wolf <clifford@clifford.at>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: Mem-2-Mem DMA - Generalized API
Message-ID: <20070625180110.GH20463@clifford.at>
References: <20070624193932.GA11797@clifford.at>
	<200706242221.57507.arnd@arndb.de>
	<467FA0EA.3000607@genesi-usa.com> <467FBABD.9040103@anagramm.de>
	<467FD1DF.4000602@genesi-usa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <467FD1DF.4000602@genesi-usa.com>
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

Hi,

On Mon, Jun 25, 2007 at 03:31:59PM +0100, Matt Sealey wrote:
> > The main question remains: Is it possible to have a flexible cross platform
> > DMA API which handles even complex requests and does scheduling,
> > prioritizing, queuing, locking, (re-)building/caching of SG lists... automagically.
> 
> I would think so. I think there is a fairly generic example in many parts
> of the Linux kernel. Dare I say the Via Unichrome AGP subsystem? And a
> bunch of the ARM/OMAP platforms..? A lot of the code is even identical,
> I wonder why it isn't some library rather than platform drivers.

I've put a 'draft header file' of an api as I would have expected it
online:

	http://www.clifford.at/priv/dmatransfer.h

I'd love to hear your feedback on it.

One issue I'm absolutely not sure about atm are the different busses and
their address spaces. The design in the header file is working directly on
'bus addresses' (the thing accessable thru /dev/mem). Does anyone know a
case where this may be insufficient?

> > Filling memory with zero is also a simple task for a DMA engine.
> > (Thinking about malloc() and memset())
> 
> Also xor and logical operations, byte swapping huge chunks of data, that
> kind of thing. Most DMA engines in SoCs have cute features like that. I
> think BestComm can even calculate CRCs for IP packets.

I havent added it yet but such things could be encoded using the
DMATRANSFER_CHUNK_* and DMATRANSFER_* flags.

However, i don't think that implementing stuff like memset() in a dma
controller is any good because that would just flood the memory bus which
would then block in 99% of all cases the cpu until the dma is finished.

It would however cost less power than doing that in the CPU. ;-)

> Indeed. I wonder if we could pull apart the IOAT/DMA stuff and genericise
> it (it should be possible) or simply add to it, or if making a powerpc
> specific dma engine abstraction would be an easier idea.

I don't think that this would actually be powerpc specific in any way. But
since such general purpose dma controllers are more common in embedded
hardware this still seams to be the right place to discuss the issue.

yours,
 - clifford

-- 
Relax, its only ONES and ZEROS!
