From: Michel Lanners <mlan@mcp.cpu.lu>
Message-Id: <199909011613.SAA02982@mcp.cpu.lu>
Subject: Re: vger-2.3.16 on pmac
To: costabel@wanadoo.fr (Martin Costabel)
Date: Wed, 01 Sep 1999 18:13:16 METDST
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <37CD0CE1.9A2BC014@wanadoo.fr>; from "Martin Costabel" at Sep 01, 99 1:24 pm
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi martin,

> I had, however, to apply one hack to make my ethernet card work: The new
> (certainly not quite finished) pci code gives it a wrong IRQ number. And
> this is something I would like to understand: 
> 
> There are 2 different IRQs for a given PCI card. If I do a 'lspci -v', I
> get the one that is actually used and shows up in /proc/interrupts and
> also in the boot messages, like for me

The one is the interrupt number in the PCI config register on the device,
which is plain bogus (as I understand it). The other IRQ, in your case 25,
is assigned by OpenBugware upon system boot, and reported in the device tree's
properties (can't remenber which one right now; have a look at
/proc/device-tree).

> If I do a 'lspci -v -b', I get another one, in this case IRQ160. This
> one is also in the memory at /proc/bus/pci/devices, or in 'lspci -vx',
> where I see a0=160.

i.e. in PCI config space. That's the (unchanged) bogus value.

> This, at least, was the situation before 2.3.15-final. Now the unpatched
> 2.3.15-final or 2.3.16-final (with trivial patches to make it compile)
> give me a boot message with IRQ160 and 'lspci -v' and 'lspci -v -b' both
> give the same value 160. This is not a valid interrupt number, and of
> course the card does not work.

That means that the patch I made for the PCI fixup code isn't in those
versions. I'm not at my machine right now; once at home, I'll see if I
get a chance to put it on my web page.

> My question is: At what place in the kernel is (or used to be) the
> bus-centered IRQ160 translated into the cpu-centered IRQ25?

There's no translation per se; it's done in the pci_bios_fixup() routine
in arch/ppc/kernel/pmac_pci.c.

> My hack was to put some 'if (irq == 160) irq=25;' somewhere in
> pmac_setup.c, like in chrp_setup.c, where IRQ2 is translated into IRQ9.
> This works (I am writing this using it) and it shows that there is
> really not much wrong otherwise with the pci code (at least not for the
> devices in my machine).

That's not the best place for the fix, but the effect is the same ;-).

Michel

-----------------------------------
.signature left at home

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
