Mime-Version: 1.0
Message-Id: <v04220801b4d57606031d@[10.0.0.42]>
In-Reply-To: <20000220081542.2794.qmail@web1006.mail.yahoo.com>
References: <20000220081542.2794.qmail@web1006.mail.yahoo.com>
Date: Sun, 20 Feb 2000 02:59:57 -0800
To: Dan Bethe <dan_bethe@yahoo.com>, linuxppc-dev@lists.linuxppc.org
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: Powerbook USB adapters
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 12:15 AM -0800 2/20/00, Dan Bethe wrote:
>	Greetings, my friends.  As you may have memorized by now, I have a
>Powerbook G3 Wallstreet series, which comes with no USB.  My local SF
>Bay Area Macintosh dealer, www.computerware.com, has two USB adapters
>for me.
>	One is at http://www.macally.com/new/usb/newuh276.html.  The second
>one is from Orange Micro, to which I can't find a URL so far.
>	Do you guys have any idea how feasible it would be to support either
>one under LinuxPPC?

Very feasible.

>	I realize that there is a lot of unstable work right now integrating
>pcmcia support into the standard kernel tree.  Hopefully Linus's laptop
>usage will propel that as it did with USB  ;)  But I don't know how
>well the two peripheral protocols have converged, considering that I'm
>hearing from people on this list whose machines halt when they simply
>insert a card of an arbitrary type.

PCMCIA USB adapters are CardBus devices.  CardBus is repackaged
hot-swap PCI.  So what's actually in the card is a standard PCI USB
OHCI controller.

The USB drivers already support OHCI PCI USB controllers.  There are
only two types anyways, UHCI and OHCI (these are standards for how
the registers work so that the same drivers work across multiple
vendor's USB chips).  For various reasons Apple supports only OHCI
under MacOS, so all USB interfaces sold for Macs are OHCI by
definition.  This has trickled down to Linux, as last I heard nobody
had even bothered making the Linux UHCI driver work on PPC.  (You
wouldn't want it anyways -- it's my belief, based on reading the USB
development list, that UHCI is inferior.  They're having a lot more
problems getting UHCI to work right, and there is this evil thing
called "bandwidth reclamation" which they have to do to get good
performance, at the cost of undesirable PCI bus hogging.)

Anyways, the only conceivable difficulty is that when you plug in the
card, the OHCI driver won't get a crack at owning it.  This is
probably what would happen on 2.2.x + PCMCIA-CS 3.0.x, because in the
old scheme of things the PCMCIA package has its own drivers for
CardBus and PC Cards.

In 2.3.x, Linus has moved a lot of the PCMCIA stuff into the kernel,
and CardBus cards are now treated as a class of hot swap PCI devices
handled by the standard kernel PCI code.  This means that under 2.3.x
it should "just work", barring bugs, of which there are many.

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
