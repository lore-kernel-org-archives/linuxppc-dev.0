Mime-Version: 1.0
Message-Id: <p0433010cb649dbb174cc@[206.6.156.5]>
In-Reply-To: 
 <Pine.LNX.4.10.10011282109440.2086-100000@zirkon.biophys.uni-duessel
 dorf.de>
References: 
 <Pine.LNX.4.10.10011282109440.2086-100000@zirkon.biophys.uni-duessel
 dorf.de>
Date: Tue, 28 Nov 2000 17:32:52 -0500
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: Re: usb wheel mouse, XF4.0
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>PCI USB cards may be officially supported on i386 but the drivers might
>have endianness issues. Your post seemed to imply there's something wrong
>with USB support in Linux/PPC in general

Well, I wrote and read it more as a footnote to observe that there
might be some unanswered questions. In particular, for people like me
with old-world machines who have to rely on things like USB cards.
IMHO, I never came even close to saying there was a USB problem in
general, as I readily acknowledged that I might have unknown issues.
But I could have been clearer, so I thank you for your clarification.
'Nuff said.

>  > >What exactly is on the PCI USB card?
>>
>>  It's an Orangelink USB/Firewire card, 2 usbs, 2 firewire ports.
>>  Otherwise I'm not sure what your question means. Do you ask for chip
>>  brands/numbers, etc?
>
>Just what sort of controller is being used (UHCI or OHCI). From your post
>I cannot figure out whether the controller is recognized by the kernel or
>not, what you've done about it on the kernel driver level, or where else
>the problem might be.

What I know is that the only way I can even compile the kernel
successfully is to turn on OHCI support alone (the UHCI options
wouldn't compile for me the last time I tried them - I assumed they
were an i386 thing).


>  > I -think- the card is seen fine, as per my recent dmesg posted on
>>  linuxppc-user. AFAICT, I've done everything as I should with the
>>  input layer. I can't absolutely prove the mouse works (Logitech
>>  2-button + wheel), but I -think- it is there. The problem is that in
>
>If the kernel reports something about 'new device connect' and assigning
>an event / mouse device, the kernel recognized the USB controller, and can
>see devices on the USB bus.

Yep. See
<http://lists.linuxppc.org/listarcs/linuxppc-user/200011/msg00609.html>.

Also, since that post I compiled in USB event support (INPUT_EVDEV),
and I know that my newer boot messages contain "event" references.
Same result.


>  > console, I get no mouse action (I can see and move a cursor around
>>  the screen with the ADB mouse), and in X, it's as if only every
>>  10000th mouse event is being registered (every once in a while, when
>>  there is disk activity, the USB mouse will jump in the general
>>  direction I've moved it, the ADB mouse continues to work fine).
>
>Sounds like the PCI card doesn't generate interrupts, and disk activity
>might result in the kernel looking at the card's interrupt status
>register and go 'hey, seems like there's an interrupt pending, let's
>service it'. Also sounds like the USB card and the disk (IDE?) share the
>same interrupt. But I'm relying heavily on my crystal ball here, which
>isn't always working as it should :-)

FWIW, I like the sound of the theory a lot. BTW, it's dual SCSI
drives, with a 2940UW card in it. My other recent -dev posts refer to
my inability to even boot a 2.2.18preX kernel with the aic7xxx
driver, but for now I've figured out a bizarre trick to get it to
boot, and I feel that it is not a issue at the moment.

>I'd guess the problem is with the driver for your particular card. I don't
>read -user so I missed your dmesg log there (you can send it by PM), the
>log perhaps contains enough information to tell what sort of USB card
>you are using and which Linux driver is handling the card.
>
>In order to check the interrupt situation, the output of lspci -vv and cat
>/proc/interrupts would help tremendously as well.


 From a -dev post of mine a while ago regarding the fact that I have 6
cards in the box and that half of my PCI bus is not even seen (2nd
bus?), my list of cards (in order from top to bottom), and lspci, is:

Adaptec 2940UW
Farallon ethernet 10/100
OrangeLink firewire/usb combo
Matrox Mystique card
ixMicro TV card
ixMicro Twin Turbo card

00:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (rev 03)
00:0d.0 SCSI storage controller: Adaptec AIC-7881U
00:0e.0 Ethernet controller: Digital Equipment Corporation DECchip
21142/43 (rev 41)
00:0f.0 PCI bridge: Action Tec Electronics Inc: Unknown device 0100 (rev 11)
00:10.0 Class ff00: Apple Computer Inc. Grand Central I/O (rev 02)
01:0c.0 FireWire (IEEE 1394): NEC Corporation: Unknown device 00cd (rev 01)
01:0d.0 USB Controller: OPTi Inc. 82C861 (rev 10)

That was done with a 2.2.17 kernel. Tonight I will do it again and
also report the result of cat/proc/interrupts.


Thanks for your help.


Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
