Return-Path: <jacmet@sunsite.dk>
Received: from kuuvir01.barco.com (kuu212123311.barco.com [212.123.3.11])
	by ozlabs.org (Postfix) with SMTP id E978367C02
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 22:38:15 +1000 (EST)
From: Peter Korsgaard <jacmet@sunsite.dk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Recently removed io accessors
References: <873b9twnbb.fsf@sleipner.barco.com>
	<1160697861.4792.177.camel@localhost.localdomain>
	<87iriovh3x.fsf@sleipner.barco.com>
	<1160724670.4792.195.camel@localhost.localdomain>
	<87slhstxlk.fsf@sleipner.barco.com>
	<1160731859.4792.249.camel@localhost.localdomain>
	<87ejtctu9s.fsf@sleipner.barco.com>
	<1160741900.4792.255.camel@localhost.localdomain>
Date: Fri, 13 Oct 2006 14:38:12 +0200
In-Reply-To: <1160741900.4792.255.camel@localhost.localdomain> (Benjamin
	Herrenschmidt's message of "Fri, 13 Oct 2006 22:18:20 +1000")
Message-ID: <87wt74s85n.fsf@sleipner.barco.com>
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

>> Unfortunately they didn't so I need to enable big endian mode and
>> NOT swap on normal register access and swap on access to the FIFO.

BH> That's where it bothers me... you need to enable BE register
BH> mode...

Yes, because the hw people didn't swap the byte lanes. To go back to
my previous mail:

Endian register set to little endian (default at powerup):
RedBoot> x -b 0x8e000064 -2 -l 4
8E000064: 4321 8765
RedBoot> x -b 0x8e000064 -4 -l 4
8E000064: 43218765

With the bytelanes swapped the 32bit read would return 21436587 which
is simply the little endian form of what we need.

But because they didn't swap the lanes I need to enable the BE mode
and not do bswap.

BH> On normal HW, you don't do that... you get LE registers and
BH> everybody is happy with that and the fifo just works. Unless what
BH> you really do is enable BE register mode (and it looks like BE) or
BH> something around those lines.

Sorry, I cannot parse that. I AM enabling BE mode.

Again:
- Bytelanes directly connected (as on our boards): You have to enable BE
  mode in the chip, NOT swap normal register accesses and SWAP accesses
  to/from the FIFOs.

- Bytelanes swapped: You should NOT enable BE mode, SWAP normal
  register accesses and NOT swap accesses from/to the FIFOs.

BH> Have you actually verified that it works if you endian swap the
BH> whole buffer ? Maybe it's just some headers added by the chip that
BH> need swapping in which case it's all fine, just add the proper
BH> leXX_to_cpu() to the driver when reading those...

Yes, we've be using it since January (I worked together with Dustin
before smc911x.c got submitted to mainline) - We need to swap all data
to/from the FIFOs.

>> The question is what to do about it. Adding another special case to
>> smc911x.h for my board is not a big deal, but I would like to get
>> the _insl / _outsl implementations back in misc.S instead of adding
>> them to my platform file.

BH> Maybe with a different name but that's possible. I just wnat to be
BH> 150% sure that this is what you need and the problem isn't lurking
BH> somewhere else ;)

Not as far as I can see.

BH> Overkill ? well, not that much.. you get free byteswap from the
BH> hardware with just a bit set in the PTEs :) Just a matter of
BH> making sure the TLB miss handlers does proerly forward that bit
BH> from the linux PTE to the TLB.

It's still a lot more work than simply doing a s/_outsl_ns/_outsl/.
Isn't the stwbrx as fast as a regular stw?

-- 
Bye, Peter Korsgaard
