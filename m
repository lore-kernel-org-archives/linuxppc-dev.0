Return-Path: <clifford@clifford.at>
Received: from phoenix.clifford.at (phoenix.clifford.at [88.198.7.52])
	by ozlabs.org (Postfix) with ESMTP id 3CB98DDE03
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Jun 2007 17:59:54 +1000 (EST)
Date: Mon, 25 Jun 2007 10:03:16 +0200
From: Clifford Wolf <clifford@clifford.at>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Mem-2-Mem DMA - Generalized API
Message-ID: <20070625080316.GB20463@clifford.at>
References: <20070624193932.GA11797@clifford.at>
	<200706242221.57507.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200706242221.57507.arnd@arndb.de>
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

Hi,

On Sun, Jun 24, 2007 at 10:21:57PM +0200, Arnd Bergmann wrote:
> On Sunday 24 June 2007, Clifford Wolf wrote:
> > I'm working on an MPC8349E based project and as some of you might know this
> > chip has a four channel (bus-) memory-to-memory DMA controller.
> > 
> > Unfortunately the linux kernel is atm lacking a generic interface for such
> > DMA controllers.
> 
> So what's wrong with the include/linux/dmaengine.h API? I thought it was
> designed to cover this sort of DMA controller?

nothing. I was just to blind to find it..  ;-)

though there are some points:

on the first glimpse it seams like this api does not support scatter/gather
and fifo mode, right? in fact that's no problem at all for my project but
it would be a pity to lose that hardware functionality because of the api..

i have also had a quick look at the ioatdma driver and it apears to me that
it can only operate on address regions which are visible on the pci bus.
The MPC8349E dma can operate on everything which is visible on the coherent
local bus, i.e. everything that is also visible to the cpu. there seams to
be no way to specify the bus a dma channel is needed for when requesting a
channel thru this interface.

It also appears to me that the dmaengine.h API is not capable of
overcommiting. I.e. assigning a small pool of dma channels to a big pool of
drivers in the hope that not all of the drivers are doing dma transfers at
the same time (and schedule transfers if this assumtion turns out to be
wrong).

Wouldn't it be better to let the backend handle stuff like binding dma
channels to specific cpus and let the user just commit dma requests which
are then scheduled to the dma channel which fits the needs best (or done in
cpu if no dma channel exists which would be capable of doing this kind of
transfer)?

yours,
 - clifford

-- 
"The generation of random numbers is too important to be left to chance."
 - Robert R. Coveyou, Oak Ridge National Laboratory.
