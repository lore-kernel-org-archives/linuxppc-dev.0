Mime-Version: 1.0
Message-Id: <p04330100b62b93c4adb8@[192.168.0.1]>
In-Reply-To: <200011050936.KAA00822@piglet.grunz.lu>
References: <200011050936.KAA00822@piglet.grunz.lu>
Date: Sun, 5 Nov 2000 17:59:46 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: Re: whacked out 2.2.18pre17?
Cc: Michel Lanners <mlan@cpu.lu>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>  > Me too :-) FWIW, here they are in order from top to bottom:
>>
>>  Adaptec 2940UW
>>  Farallon ethernet 10/100
>>  OrangeLink firewire/usb combo
>>  Matrox Mystique card
>>  ixMicro TV card
>>  ixMicro Twin Turbo card
>
>OK, 6 slots, so I suppose this is a 9x00 or compatible box?

PowerTowerPro, most comparable to the 9500 AFAIK. I also have a
500/1Mb PowerLogix upgrade card in it.


>  > lspci gives (only):
>>
>>  00:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (rev 03)
>>  00:0d.0 SCSI storage controller: Adaptec AIC-7881U
>>  00:0e.0 Ethernet controller: Digital Equipment Corporation DECchip
>>  21142/43 (rev 41)
>>  00:0f.0 PCI bridge: Action Tec Electronics Inc: Unknown device 0100 (rev 11)
>>  00:10.0 Class ff00: Apple Computer Inc. Grand Central I/O (rev 02)
>>  01:0c.0 FireWire (IEEE 1394): NEC Corporation: Unknown device 00cd (rev 01)
>>  01:0d.0 USB Controller: OPTi Inc. 82C861 (rev 10)
>
>Hmm, there's one bus missing here, the one with the Matrox and the
>ixMicro cards.

Yes, I've known this for a while. But this leads to a long-standing
question of mine: how is it that the Twin Turbo card is still somehow
recognized? Because the imsttfb driver will load and appears
functional in console mode (although not in X as described on other
linuxppc lists).

>And the accompanying bandit host bridge is missing. You
>might want to try my PCI patches (see:
>http://www.cpu.lu/~mlan/linux/dev/pci.html). The relevant part is this
>here, in arch/ppc/kernel/pmac_pci.c:

Thanks I will try this.


>Stefan, a final note, if you want to turn multihead, it might be a good
>idea performance-wise to put both of your graphics boards not in the
>same PCI bus... ie one into slots 1-3, and the other in slots 4-6.

Given my list of cards, are there any other general pointers as to
which bus which cards should go? The order I have now took a long
time to create - I'm not sure if it's the unique workable one, but
several other orders cause OpenTransport crashes when I am running
the ixTV (!). But it looks like removing cards and/or changing order
is my only choice, given 2.2.18's new proclivity (for me anyway) to
not boot - bummer. I'll be back with a report when I can try it all.


Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
