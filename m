Date: Thu, 9 Aug 2001 09:14:02 -0700
From: Matt Porter <mporter@mvista.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Hollis <hollis-lists@austin.rr.com>,
	linuxppc-dev@lists.linuxppc.org, Matt Porter <mporter@mvista.com>
Subject: Re: PReP and generic PCI resource assignment
Message-ID: <20010809091402.A11768@beef.az.mvista.com>
References: <01080820343003.00492@silence.internal> <20010809101833.16835@smtp.adsl.oleane.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010809101833.16835@smtp.adsl.oleane.com>; from benh@kernel.crashing.org on Thu, Aug 09, 2001 at 12:18:33PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Aug 09, 2001 at 12:18:33PM +0200, Benjamin Herrenschmidt wrote:
> >At any rate, relocating PCI resource 1 on this controller from 0x0 to
> >0x01000000 causes my VGA console to go backwards endian. I don't know why
> >this would be the case... Re-moving it back to 0x0 fixes the symptom. Any
> >ideas on why this could happen? I think VGA is all IO, no memory at all?
>
> VGA is both IO and memory. It's possible that your VGA card is so broken
> that it only use the low-order bits of addresses and use the high addresses
> as flags, for example to access a "bug endian" aperture :) That would suck
> as it would mean you actually have address aliasing going on on the bus,
> possiby causing weird conflicts.
>
> >I'm curious about PCIBIOS_MIN_MEM... Why does that exist, and why was it
> >given that value?
>
> Note sure, I don't really like the way it's used and hard coded....

That "generic" code has caused me a number of problem on many PCI
equipped embedded platforms (not just PPC ones).  The algorithm
used to pick PCI Mem space addresses ignores the fact that there are
specific areas in CPU address space captured to generate mem cycles.
>From my read of the code, it simply picks any old address that's
not claimed by another resource starting at PCIBIOS_MIN_MEM.  That's
braindead and probably just another x86ism that'll work on those
platforms.

This is why I always use the pci_auto.c code to properly place base
addresses so the PCI resource system won't try to use it's braindead
algorithm to move them around.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
