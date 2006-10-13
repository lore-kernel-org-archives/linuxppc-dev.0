Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 795E067C20
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 17:31:45 +1000 (EST)
Subject: Re: Recently removed io accessors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Korsgaard <jacmet@sunsite.dk>
In-Reply-To: <87iriovh3x.fsf@sleipner.barco.com>
References: <873b9twnbb.fsf@sleipner.barco.com>
	<1160697861.4792.177.camel@localhost.localdomain>
	<87iriovh3x.fsf@sleipner.barco.com>
Content-Type: text/plain
Date: Fri, 13 Oct 2006 17:31:10 +1000
Message-Id: <1160724670.4792.195.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: sfr@canb.auug.org.au, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-10-13 at 08:56 +0200, Peter Korsgaard wrote:
> >>>>> "BH" == Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> Hi,
> 
> >> Any chance of getting them back or should I implement a (slower)
> >> loop myself before submitting the patch?
> 
> BH> Well, a "packet buffer" should have no endian. When streaming in
> BH> our out a fifo, you basically stream bytes that happen to come out
> BH> 2 at a time.  So unless somebody wired the hardware backward, you
> BH> should do no swapping when using the fifo.
> 
> I agree in principle, but the issue gets complicated by the fact that
> the chip works in chunks of 32bit, but the 911{5..7} chips only have a
> 16bit interface to lower costs, and that the chip has a builtin endian
> swap feature (which works for all direct registers, but apparently not
> for the packet buffers).
> 
> The memory controller automatically translates a 32bit access to two
> 16 bit accesses.

Well, that is not necessarily broken :)

> You could be right that the hw people screwed something up, but that
> doesn't help much once there's units in the field :/

Well, I still don't see it. It all depends how the HW has been wired I
suppose but you should not need byteswap regardless of the 32 bits being
broken in packs of 2x16 bits or whatever... If the chip has a HW
byteswap for registers and not for the packet buffer, that makes it even
more clear that such swapping should not be necessary.

Unless the chip has been wired backward on the processor bus (in which
case, btw, DMA will not work either unless you have one of those
magically swapping dma controllers)..

So I still claim that you should not need them and if you do, then the
chip has probably been incorrect wired to your CPU bus. In which case,
you can either grab an old copy of the functions and put them in your
driver for your platform or add a cpu_to_leXX() loop to byteswap the
data in/out, but it's probably not the right thing to do in the generic
driver since it would be a problem specific to your board.

Unless I'm missing something ... It would be useful to have more details
about your setup.

Cheers.
Ben.
