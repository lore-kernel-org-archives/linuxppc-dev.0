Return-Path: <jacmet@sunsite.dk>
Received: from kuuvir01.barco.com (kuu212123311.barco.com [212.123.3.11])
	by ozlabs.org (Postfix) with SMTP id C9A4967C2A
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 18:43:32 +1000 (EST)
From: Peter Korsgaard <jacmet@sunsite.dk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Recently removed io accessors
References: <873b9twnbb.fsf@sleipner.barco.com>
	<1160697861.4792.177.camel@localhost.localdomain>
	<87iriovh3x.fsf@sleipner.barco.com>
	<1160724670.4792.195.camel@localhost.localdomain>
Date: Fri, 13 Oct 2006 10:43:19 +0200
In-Reply-To: <1160724670.4792.195.camel@localhost.localdomain> (Benjamin
	Herrenschmidt's message of "Fri, 13 Oct 2006 17:31:10 +1000")
Message-ID: <87slhstxlk.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, linuxppc-dev@ozlabs.org
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

BH> Well, I still don't see it. It all depends how the HW has been
BH> wired I suppose but you should not need byteswap regardless of the
BH> 32 bits being broken in packs of 2x16 bits or whatever... If the
BH> chip has a HW byteswap for registers and not for the packet
BH> buffer, that makes it even more clear that such swapping should
BH> not be necessary.

Ok, a bit of details:

We're using the smsc9117
(http://www.smsc.com/main/datasheets/9117.pdf) connected over a 16bit
EMC bus (together with a spansion 29PL127 flash) to a Xilinx V4FX FPGA
with a 405 core in it.

LSB of the processor is connected to LSB of of the 9117 (and same for
the flash) and so on.

Reading the byte test register of the 9117 (supposed to contain
0x87654321) gives:

Endian register set to little endian (default at powerup):
RedBoot> x -b 0x8e000064 -2 -l 4
8E000064: 4321 8765
RedBoot> x -b 0x8e000064 -4 -l 4
8E000064: 43218765

And with it set to big endian:
RedBoot> x -b 0x8e000064 -2 -l 4
8E000064: 8765 4321
RedBoot> x -b 0x8e000064 -4 -l 4
8E000064: 87654321

So with this setup I need to enable the big endian mode to read
registers without byteswapping and use byteswapping for the packet
fifos.

If on the other hand the hw people had inverted the 2 byte lanes
(connected b0..b7 on the CPU to b8..b15, and b8..15 to b0..b7) I would
need to use byteswapping on the normal register accesses and no byte
swapping on the packet fifos.

They didn't unfortunately :/

BH> Unless the chip has been wired backward on the processor bus (in
BH> which case, btw, DMA will not work either unless you have one of
BH> those magically swapping dma controllers)..

True. We are not using DMA though.

BH> So I still claim that you should not need them and if you do, then
BH> the chip has probably been incorrect wired to your CPU bus. In
BH> which case, you can either grab an old copy of the functions and
BH> put them in your driver for your platform or add a cpu_to_leXX()
BH> loop to byteswap the data in/out, but it's probably not the right
BH> thing to do in the generic driver since it would be a problem
BH> specific to your board.

I could add another #ifdef CONFIG_<my board> to the smc911x.h to
select the right I/O accessors, but sticking the implementation of
_insl/_outsl in my platform file isn't that nice - Couldn't we put
them back in misc.S?

BH> Unless I'm missing something ... It would be useful to have more
BH> details about your setup.

I hope this makes it a bit more clear.

-- 
Bye, Peter Korsgaard
