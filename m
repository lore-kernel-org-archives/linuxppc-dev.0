Mime-Version: 1.0
Message-Id: <v04220801b5e06500119d@[10.0.0.42]>
In-Reply-To: <200009091757.NAA35435@borg.cmf.nrl.navy.mil>
References: <200009091757.NAA35435@borg.cmf.nrl.navy.mil>
Date: Sat, 9 Sep 2000 15:22:47 -0700
To: Chas Williams <chas@cmf.nrl.navy.mil>, linuxppc-dev@lists.linuxppc.org
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: 64-bit pci bus on a powermac g4
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 1:57 PM -0400 9/9/00, Chas Williams wrote:
>i am writing a driver for an atm adapter and i am seeing some strange
>problems.  the card is 32/64 bit.  it works fine in my 32-bit pci bus
>on my umax s900, but in the g4 it oops' with a trap 300 during operation.
>i understand this to be 'data access exception' or 'data storage exception'.
>
>a couple questions:
>
>. is the 64bit pci bus capability functional in the g4?  (i gather it
>   must be since my 64bit ati rage pro for the second monitor is working fine)

The Rage 128 (Pro) is a 32-bit PCI card, not 64 (or at least all of
them I've seen are).

If you didn't already know, the 64-bit bus in PowerMacs is actually
behind a  PCI to PCI bridge chip.  The main PCI bus is 32-bit 66 MHz,
and Apple uses a DEC/Intel bridge to connect it to the 64-bit 33 MHz
bus.

I have a 64-bit PCI card (Adaptec 39160) installed in a 64-bit slot
on my Blue&White G3.  The aic7xxx driver in the most current 2.2.x
trees mostly works OK with it.  There are some initialization
problems but they seem to be unrelated to PCI.  Once the card is
initialized it works fine, though there seems to be a problem with
achieving more than 40 MB/s write throughput.  This happens under
both MacOS and Linux though, so either it's a common problem in the
way the drivers are performing writes or the hardware is poorly
designed.

>. anyone else written a driver for a 64bit pci card in the g4's?
>
>. do i need to align my dma regions to 64bits?  shouldnt the card be
>   able transfer non-dma until it gets to a dma region?  i suppose this
>   depends on the bridge/card controller.  the driver documentation
>   is a bit lacking on this detail.  it claims that tx buffers dont
>   require special alignment but if you dont use dma, of course it doesnt.

Aligning DMA buffers might be worth a shot, maybe the card is
inflexible in this regard.


   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
