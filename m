Return-Path: <jacmet@sunsite.dk>
Received: from kuuvir01.barco.com (kuu212123311.barco.com [212.123.3.11])
	by ozlabs.org (Postfix) with SMTP id 112A967C3C
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 19:55:13 +1000 (EST)
From: Peter Korsgaard <jacmet@sunsite.dk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Recently removed io accessors
References: <873b9twnbb.fsf@sleipner.barco.com>
	<1160697861.4792.177.camel@localhost.localdomain>
	<87iriovh3x.fsf@sleipner.barco.com>
	<1160724670.4792.195.camel@localhost.localdomain>
	<87slhstxlk.fsf@sleipner.barco.com>
	<1160731859.4792.249.camel@localhost.localdomain>
Date: Fri, 13 Oct 2006 11:55:11 +0200
In-Reply-To: <1160731859.4792.249.camel@localhost.localdomain> (Benjamin
	Herrenschmidt's message of "Fri, 13 Oct 2006 19:30:59 +1000")
Message-ID: <87ejtctu9s.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Peter Korsgaard <jacmet@sunsite.dk>,
	sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "BH" == Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

Hi,

BH> That's what bothers me... usually, if the registers are little
BH> endian and you need a byteswap to read them, then you don't need a
BH> byteswap to pump the fifo. For example, things like IDE, sound
BH> cards, wireless chips etc... have LE registers (we use byteswap to
BH> access them) and we are fine not swapping on the fifo read/writes.

Exactly. As I wrote in my previous mail: If the hw people had swapped
the 2 byte lanes I would need to byteswap on the normal register
accesses, but not on the FIFO. That would have been the preferable
setup.

Unfortunately they didn't so I need to enable big endian mode and NOT
swap on normal register access and swap on access to the FIFO.

The question is what to do about it. Adding another special case to
smc911x.h for my board is not a big deal, but I would like to get the
_insl / _outsl implementations back in misc.S instead of adding them
to my platform file.

BH> I'll read the chip spec and try to figure out what can be
BH> done. Maybe an option is to use the per-page little endian flag
BH> available on 4xx parts, I think you may have that in your xilinx,
BH> and thus have automatic byteswapping. We don't support that bit
BH> but it shouldn't be too hard to add it so that you can pass it to
BH> __ioremap. But again, I'm surprised that's necessary.

Sorry, but that sounds overkill to me. Everything works fine as long
as I don't byteswap on normal registers and use something like _insl /
_outsl for the FIFOs.

-- 
Bye, Peter Korsgaard
