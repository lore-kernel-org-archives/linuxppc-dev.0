From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>,
	Takashi Oe <toe@unlserve.unl.edu>, Kostas Gewrgiou <gewrgiou@imbc.gr>
Subject: Re: Sound stoppage
Date: Wed, 28 Mar 2001 15:17:34 +0200
Message-Id: <20010328131734.25918@mailhost.mipsys.com>
In-Reply-To: <20010328091553.4B07DDB9FC@atlas.valhalla.net>
References: <20010328091553.4B07DDB9FC@atlas.valhalla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>The MacOS extension patch fixes a "PCI timing problem" - specifically
>claimed to stop PCI-based-IDE/Sound interaction (which is what we are
>seeing).

I quickly disassembled the extension, what it does is to write

  0x00000858 (swapped) -> 0xf2800000
  0x12 (byte)          -> 0xf2c00000

Which is basically writing 0x12 to byte at address 0x58 of Bandit
PCI bridge config space.

Now we need to figure out how to identify this machine/bandit model to
make sure we don't scew up bandit on another box.

Can someone try to figure out in the device-tree if there's anything like
a machine ID ? (the "old" mac-os like box ID is 0x66 I think, but I don't
know if it can be found in the device tree. It may be available via mother
board straps around 0xf3000000 however).

I'd also like to know the bandit deviceID & revisionID in it's PCI config
space.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
