Date: Wed, 28 Mar 2001 15:28:10 +0100
Subject: Re: Sound stoppage
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>,
	Takashi Oe <toe@unlserve.unl.edu>, Kostas Gewrgiou <gewrgiou@imbc.gr>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010328142808.E1756DB9E8@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ben,

>>The MacOS extension patch fixes a "PCI timing problem" - specifically
>>claimed to stop PCI-based-IDE/Sound interaction (which is what we are
>>seeing).
>
> I quickly disassembled the extension, what it does is to write
>
>   0x00000858 (swapped) -> 0xf2800000
>   0x12 (byte)          -> 0xf2c00000
>
> Which is basically writing 0x12 to byte at address 0x58 of Bandit
> PCI bridge config space.

Is there any doc. (these days) on what the bandit does?

> Now we need to figure out how to identify this machine/bandit model to
> make sure we don't scew up bandit on another box.
>
> Can someone try to figure out in the device-tree if there's anything like
> a machine ID ? (the "old" mac-os like box ID is 0x66 I think, but I don't
> know if it can be found in the device tree. It may be available via mother
> board straps around 0xf3000000 however).

I can't help on the PowerComputing - but checking the Apple model to find
out how we tell the difference...

- I've just looked at the "standard" 7200 tree (html-converted from the one
at  suse) and there is a "compatible" entry.  "AAPL,7300 MacRISC"

> I'd also like to know the bandit deviceID & revisionID in it's PCI config
> space.

there's a "model" property (AAPL,343S1126) in the Apple OF - perhaps this is
different from the PowerComputing variant.

Also, if booted from BootX, it might be possible to get at the Gestalt
settings - I'm sure that's at the tail end of the Apple OF tree (although it
doesn't make it through to the Linux side).  This would give you the model
ID without poking the ROM or straps.

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
