Message-Id: <200011060712.IAA00775@piglet.grunz.lu>
Date: Mon, 6 Nov 2000 08:12:03 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: whacked out 2.2.18pre17?
To: jeglin@4pi.com
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <p04330100b62b93c4adb8@[192.168.0.1]>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   5 Nov, this message from Stefan Jeglinski echoed through cyberspace:
>>  > Me too :-) FWIW, here they are in order from top to bottom:
>>>
>>>  Adaptec 2940UW
>>>  Farallon ethernet 10/100
>>>  OrangeLink firewire/usb combo
>>>  Matrox Mystique card
>>>  ixMicro TV card
>>>  ixMicro Twin Turbo card
>>
>>OK, 6 slots, so I suppose this is a 9x00 or compatible box?
>
> PowerTowerPro, most comparable to the 9500 AFAIK. I also have a
> 500/1Mb PowerLogix upgrade card in it.

Mine is a 7600 (first generation PCI as well), and I have a G3 upgrade
as well... but 2.2 kernels have always booted for me. I have no luck
with 2.4 kernels... no way to reliably boot those.

>>  > lspci gives (only):
>>>
>>>  00:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (rev 03)
>>>  00:0d.0 SCSI storage controller: Adaptec AIC-7881U
>>>  00:0e.0 Ethernet controller: Digital Equipment Corporation DECchip
>>>  21142/43 (rev 41)
>>>  00:0f.0 PCI bridge: Action Tec Electronics Inc: Unknown device 0100 (rev 11)
>>>  00:10.0 Class ff00: Apple Computer Inc. Grand Central I/O (rev 02)
>>>  01:0c.0 FireWire (IEEE 1394): NEC Corporation: Unknown device 00cd (rev 01)
>>>  01:0d.0 USB Controller: OPTi Inc. 82C861 (rev 10)
>>
>>Hmm, there's one bus missing here, the one with the Matrox and the
>>ixMicro cards.
>
> Yes, I've known this for a while. But this leads to a long-standing
> question of mine: how is it that the Twin Turbo card is still somehow
> recognized? Because the imsttfb driver will load and appears
> functional in console mode (although not in X as described on other
> linuxppc lists).

That's probably because imsttfb looks for the device in the OpenFirmware
device tree, not in PCI device tree. And, since OpenFirmware uses tat
display, it is available anyway to offb. Keep in mind that it's absence
on the lspci listing doesn't mean it's unavailable. It's just invisible
to drivers searching the PCI device chain.

> Given my list of cards, are there any other general pointers as to
> which bus which cards should go?

Well, only that you should know all your 'internal' devices are on PCI
bus 0 (that is, top slots, AFAIR). Internal and external SCSI count
here, as well as built-in ethernet and the serial ports. So, if you use
your internal SCSI as well, you might want to exchange the Matrox with
either the SCSI or the ethernet card. But it depends on your usage as
well...

> The order I have now took a long
> time to create - I'm not sure if it's the unique workable one, but
> several other orders cause OpenTransport crashes when I am running
> the ixTV (!).

In that case, there might not be too much gain in swapping your cards
around... If you do graphics-intensive thngs on dual monitors, maybe
swap the matrox as said above; but other than that, it's probably ok.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
