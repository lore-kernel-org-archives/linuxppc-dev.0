Message-Id: <200012010709.IAA00844@piglet.grunz.lu>
Date: Fri, 1 Dec 2000 08:09:21 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: usb wheel mouse, XF4.0
To: bh40@calva.net
cc: jeglin@4pi.com, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <19341024104634.3912@192.168.1.2>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

On  29 Nov, this message from Benjamin Herrenschmidt echoed through cyberspace:
>>In addition, yesterday I speculated that the dual IRQ 23 might help
>>explain why I was having 2.2.18preX boot problems with the aic7xxx.
>>This can't really be the case because one of the slot summary tests
>>was to remove the USB card (and all others). There was no difference,
>>so my boot issue remains a separate one with its odd workaround.
>
> Ok, I found the problem, I think, with the interrupt. I'm still
> investigating, but what it looks like is that the OF tree puts the
> AAPL,interrupt property in the pci-bridge node, not in the sub-nodes.

I remember seeing this documented somewhere in the kernel sources, I
think.

Also, another 'shot in the dark': might we have a bug in the PCI-bridge
code, that (erronously) rotates interrupts? On Intel machines, the 4 PCI
interrupt lines are BIOS-wired to some IRQs, and are rotated one
position while passing to the next PCI slot. They are also, IIRC,
rotated by each PCI bridge. This _could_ make the USB card be configured
for the wrong interrupt, maybe the adjacent slot: SCSI controller....

Just a thought...

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
