From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hollis <hollis-lists@austin.rr.com>
Cc: <linuxppc-dev@lists.linuxppc.org>,
	Matt Porter <mporter@mvista.com>
Subject: Re: PReP and generic PCI resource assignment
Date: Thu, 9 Aug 2001 12:18:33 +0200
Message-Id: <20010809101833.16835@smtp.adsl.oleane.com>
In-Reply-To: <01080820343003.00492@silence.internal>
References: <01080820343003.00492@silence.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>At any rate, relocating PCI resource 1 on this controller from 0x0 to
>0x01000000 causes my VGA console to go backwards endian. I don't know why
>this would be the case... Re-moving it back to 0x0 fixes the symptom. Any
>ideas on why this could happen? I think VGA is all IO, no memory at all?

VGA is both IO and memory. It's possible that your VGA card is so broken
that it only use the low-order bits of addresses and use the high addresses
as flags, for example to access a "bug endian" aperture :) That would suck
as it would mean you actually have address aliasing going on on the bus,
possiby causing weird conflicts.

>I'm curious about PCIBIOS_MIN_MEM... Why does that exist, and why was it
>given that value?

Note sure, I don't really like the way it's used and hard coded....

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
