Message-Id: <200003271909.VAA01187@piglet.grunz.lu>
Date: Mon, 27 Mar 2000 21:09:49 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: pci-resources feedback
To: toa@pop.agri.ch
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <38DF96D0.9823B129@pop.agri.ch>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Andreas,

On  27 Mar, this message from Andreas Tobler echoed through cyberspace:
> Also I'm confused about the ati memory range two. Which base is the one
> I have to take?

As I understand it (which may be wrong ;-) that's the MMIO region
corresponding to the (VGA?) IO ports used for configuring the device.

Problem is by default it lies within the framebuffer region...

> ---2399-dmesg---
> PCI: Probing PCI hardware (semiautomatic)
> Scanning bus 00
> Found 00:00 [1057/0002] 000600 00
> Found 00:68 [106b/0010] 00ff00 00
> Found 00:80 [106b/0010] 00ff00 00

Hmmm... two times the same dev?? You really have two heathrows?

> Found 00:88 [1002/4c47] 000300 00
> Found 00:98 [104c/ac15] 000607 02
> Found 00:99 [104c/ac15] 000607 02
> Fixups for bus 00
> Scanning CardBus bridge 00:13.0			<------ sounds good for CardBus!!
> Scanning CardBus bridge 00:13.1

Cool ;-)

> Bus scan for 00 returning with max=09
> PCI: Fixing device 00:00.0 (1057:0002)
> PCI: Fixing device 00:0d.0 (106b:0010)
> PCI: Fixing device 00:10.0 (106b:0010)
> PCI: Fixing device 00:11.0 (1002:4c47)
> PCI: Setting IRQ 24 on device 00:11.0.
> PCI: Correcting IO address 1 on device 00:11.0, now fe000400.

Hey, it even works on grackle!

> PCI: Enabling device 00:11.0 (0086 -> 0087)
> PCI: Fixing device 00:13.0 (104c:ac15)
> PCI: Setting IRQ 22 on device 00:13.0.
> PCI: Fixing device 00:13.1 (104c:ac15)
> PCI: Setting IRQ 23 on device 00:13.1.
> PCI: Resource f4000000-f407ffff (f=200, d=0, p=0)
> PCI: Resource f3000000-f307ffff (f=200, d=0, p=0)
> PCI: Resource 82000000-82ffffff (f=200, d=0, p=0)
> PCI: Resource fe000400-fe0004ff (f=101, d=0, p=0)
> PCI: Resource 82fff000-82ffffff (f=200, d=0, p=0)
> PCI: Cannot allocate resource region 2 of device 00:11.0

Here the resource code notices the conflict on the ATI.

> PCI: Resource 81803000-81803fff (f=200, d=0, p=0)
> PCI: Resource 81802000-81802fff (f=200, d=0, p=0)
>   for root[0:ffffffff] min[80000000] size[1000]
>   got res[80000000:80000fff] for resource 2

This is the message as the conflicting (second) region of the ATI gets
remapped. It did work... as can be seen ba the lspci outtput.

So far, so good :-)

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
