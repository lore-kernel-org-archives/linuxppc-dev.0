Mime-Version: 1.0
Message-Id: <v04220800b64a66157aaa@[10.0.0.42]>
In-Reply-To: <p0433010ab649bafec687@[206.6.156.5]>
References: 
  <Pine.LNX.4.10.10011282036580.22745-100000@opal.biophys.uni-duesseld
 orf.de> <p0433010ab649bafec687@[206.6.156.5]>
Date: Wed, 29 Nov 2000 00:33:12 -0800
To: Stefan Jeglinski <jeglin@4pi.com>,
        Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: usb wheel mouse, XF4.0
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 2:55 PM -0500 11/28/00, Stefan Jeglinski wrote:

>I take it you're saying that PCI USB cards are not being officially
>supported, but they may work. Otherwise I don't get your comment. The
>backport into 2.2.18 (which will be defined as stable when it is no
>longer pre status) seems to include config options for many keyspan
>devices, among others. Are these not PCI cards? I could clearly be
>dead wrong here, I'm now surmising.

Keyspan does not make any PCI USB cards.  The only PCI cards they
make are serial cards.  Their USB stuff is all peripherals (such as
an IR remote widget, USB to serial adapters, etc.).  The config
options you're seeing are drivers for their USB peripherals.

>>What exactly is on the PCI USB card?
>
>It's an Orangelink USB/Firewire card, 2 usbs, 2 firewire ports.

 From one of your later emails, it looks like this card is composed of
a PCI-to-PCI bridge, a NEC FireWire host controller, and an Opti OHCI
USB controller.

There are definitely outstanding problems with initialization of
devices behind PCI bridges, so the fact that your USB controller is
behind one is quite significant.

BTW, unless Opti has been revising it, the Opti OHCI USB chip on that
card is the same one Apple used on the motherboards of early iMacs
and the Blue&White G3.  I have a SIIG USB PCI card which uses that
chip and it has always worked flawlessly under Linux for me, in an
Old World Mac (beige G3).  So I'd say that once this issue with Linux
assigning the same IRQ to the Opti chip and your 2940UW gets
resolved, there's a high probability that it will work without any
problems.

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
