Date: Tue, 28 Nov 2000 21:23:44 +0100 (CET)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Stefan Jeglinski <jeglin@4pi.com>
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: usb wheel mouse, XF4.0
In-Reply-To: <p0433010ab649bafec687@[206.6.156.5]>
Message-ID: <Pine.LNX.4.10.10011282109440.2086-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >Wrong: support for USB PCI cards not being built into the stable kernel.
> >Support for recent Mac builtin USB controllers (OHCI) is just fine.
> >Support for anything above the controller (protocols) apparently works
> >fine with OHCI (PPC) and UHCI (Intel).
>
> I take it you're saying that PCI USB cards are not being officially
> supported, but they may work. Otherwise I don't get your comment. The

PCI USB cards may be officially supported on i386 but the drivers might
have endianness issues. Your post seemed to imply there's something wrong
with USB support in Linux/PPC in general, and my experience so far
indicates that is not the case.

> >What exactly is on the PCI USB card?
>
> It's an Orangelink USB/Firewire card, 2 usbs, 2 firewire ports.
> Otherwise I'm not sure what your question means. Do you ask for chip
> brands/numbers, etc?

Just what sort of controller is being used (UHCI or OHCI). From your post
I cannot figure out whether the controller is recognized by the kernel or
not, what you've done about it on the kernel driver level, or where else
the problem might be.

> I -think- the card is seen fine, as per my recent dmesg posted on
> linuxppc-user. AFAICT, I've done everything as I should with the
> input layer. I can't absolutely prove the mouse works (Logitech
> 2-button + wheel), but I -think- it is there. The problem is that in

If the kernel reports something about 'new device connect' and assigning
an event / mouse device, the kernel recognized the USB controller, and can
see devices on the USB bus.

> console, I get no mouse action (I can see and move a cursor around
> the screen with the ADB mouse), and in X, it's as if only every
> 10000th mouse event is being registered (every once in a while, when
> there is disk activity, the USB mouse will jump in the general
> direction I've moved it, the ADB mouse continues to work fine).

Sounds like the PCI card doesn't generate interrupts, and disk activity
might result in the kernel looking at the card's interrupt status
register and go 'hey, seems like there's an interrupt pending, let's
service it'. Also sounds like the USB card and the disk (IDE?) share the
same interrupt. But I'm relying heavily on my crystal ball here, which
isn't always working as it should :-)

> As I implied in my e-mail but could have been clearer about, I'm not
> at all certain that the issue really is with the usb or the mouse or
> the usb card, etc. It's just that for me, on an old-world Mac, the
> usb experience as a whole has a flaw somewhere that I've been unable
> to figure out.

I'd guess the problem is with the driver for your particular card. I don't
read -user so I missed your dmesg log there (you can send it by PM), the
log perhaps contains enough information to tell what sort of USB card
you are using and which Linux driver is handling the card.

In order to check the interrupt situation, the output of lspci -vv and cat
/proc/interrupts would help tremendously as well.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
