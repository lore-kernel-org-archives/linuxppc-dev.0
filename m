Date: Wed, 29 Nov 2000 00:15:07 +0100 (CET)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Stefan Jeglinski <jeglin@4pi.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: usb wheel mouse, XF4.0
In-Reply-To: <p0433010cb649dbb174cc@[206.6.156.5]>
Message-ID: <Pine.LNX.4.10.10011290008410.2592-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >Just what sort of controller is being used (UHCI or OHCI). From your post
> >I cannot figure out whether the controller is recognized by the kernel or
> >not, what you've done about it on the kernel driver level, or where else
> >the problem might be.
>
> What I know is that the only way I can even compile the kernel
> successfully is to turn on OHCI support alone (the UHCI options
> wouldn't compile for me the last time I tried them - I assumed they
> were an i386 thing).

UHCI is used on Intel, and apparently can't be compiled for PPC.

> >If the kernel reports something about 'new device connect' and assigning
> >an event / mouse device, the kernel recognized the USB controller, and can
> >see devices on the USB bus.
>
> Yep. See
> <http://lists.linuxppc.org/listarcs/linuxppc-user/200011/msg00609.html>.

Looks perfectly normal to me.

> >I'd guess the problem is with the driver for your particular card. I don't

Seems the hardware on the card is recognized as OHCI allright (and works
OK as far as device detection goes, at least).

> >read -user so I missed your dmesg log there (you can send it by PM), the
> >log perhaps contains enough information to tell what sort of USB card
> >you are using and which Linux driver is handling the card.
> >
> >In order to check the interrupt situation, the output of lspci -vv and cat
> >/proc/interrupts would help tremendously as well.
>
>
>  From a -dev post of mine a while ago regarding the fact that I have 6
> cards in the box and that half of my PCI bus is not even seen (2nd
> bus?), my list of cards (in order from top to bottom), and lspci, is:
>
> Adaptec 2940UW
> Farallon ethernet 10/100
> OrangeLink firewire/usb combo
> Matrox Mystique card
> ixMicro TV card
> ixMicro Twin Turbo card
>
> 00:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (rev 03)
> 00:0d.0 SCSI storage controller: Adaptec AIC-7881U
> 00:0e.0 Ethernet controller: Digital Equipment Corporation DECchip
> 21142/43 (rev 41)
> 00:0f.0 PCI bridge: Action Tec Electronics Inc: Unknown device 0100 (rev 11)
> 00:10.0 Class ff00: Apple Computer Inc. Grand Central I/O (rev 02)
> 01:0c.0 FireWire (IEEE 1394): NEC Corporation: Unknown device 00cd (rev 01)
> 01:0d.0 USB Controller: OPTi Inc. 82C861 (rev 10)
>
> That was done with a 2.2.17 kernel. Tonight I will do it again and
> also report the result of cat/proc/interrupts.

Please make lspci log as much information as possible (-vv will do that),
though

	usb-ohci.c: USB OHCI at membase 0xd0184000, IRQ 23

already gives a clue. Question is, what else is at IRQ 23?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
