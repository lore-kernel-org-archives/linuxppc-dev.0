Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1D60167B83
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 22:18:50 +1000 (EST)
Subject: Re: Recently removed io accessors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Korsgaard <jacmet@sunsite.dk>
In-Reply-To: <87ejtctu9s.fsf@sleipner.barco.com>
References: <873b9twnbb.fsf@sleipner.barco.com>
	<1160697861.4792.177.camel@localhost.localdomain>
	<87iriovh3x.fsf@sleipner.barco.com>
	<1160724670.4792.195.camel@localhost.localdomain>
	<87slhstxlk.fsf@sleipner.barco.com>
	<1160731859.4792.249.camel@localhost.localdomain>
	<87ejtctu9s.fsf@sleipner.barco.com>
Content-Type: text/plain
Date: Fri, 13 Oct 2006 22:18:20 +1000
Message-Id: <1160741900.4792.255.camel@localhost.localdomain>
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

> Exactly. As I wrote in my previous mail: If the hw people had swapped
> the 2 byte lanes I would need to byteswap on the normal register
> accesses, but not on the FIFO. That would have been the preferable
> setup.
> 
> Unfortunately they didn't so I need to enable big endian mode and NOT
> swap on normal register access and swap on access to the FIFO.

That's where it bothers me... you need to enable BE register mode...

On normal HW, you don't do that... you get LE registers and everybody is
happy with that and the fifo just works. Unless what you really do is
enable BE register mode (and it looks like BE) or something around those
lines.

Have you actually verified that it works if you endian swap the whole
buffer ? Maybe it's just some headers added by the chip that need
swapping in which case it's all fine, just add the proper leXX_to_cpu()
to the driver when reading those...

> The question is what to do about it. Adding another special case to
> smc911x.h for my board is not a big deal, but I would like to get the
> _insl / _outsl implementations back in misc.S instead of adding them
> to my platform file.

Maybe with a different name but that's possible. I just wnat to be 150%
sure that this is what you need and the problem isn't lurking somewhere
else ;)

> BH> I'll read the chip spec and try to figure out what can be
> BH> done. Maybe an option is to use the per-page little endian flag
> BH> available on 4xx parts, I think you may have that in your xilinx,
> BH> and thus have automatic byteswapping. We don't support that bit
> BH> but it shouldn't be too hard to add it so that you can pass it to
> BH> __ioremap. But again, I'm surprised that's necessary.
> 
> Sorry, but that sounds overkill to me. Everything works fine as long
> as I don't byteswap on normal registers and use something like _insl /
> _outsl for the FIFOs.

Overkill ? well, not that much.. you get free byteswap from the hardware
with just a bit set in the PTEs :) Just a matter of making sure the TLB
miss handlers does proerly forward that bit from the linux PTE to the
TLB.

Ben.
