Message-ID: <19990815103344.L145@albireo.ucw.cz>
Date: Sun, 15 Aug 1999 10:33:44 +0200
From: Martin Mares <mj@ucw.cz>
To: mlan@cpu.lu, paulus@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org
Cc: hedrick@Astro.Dyer.Vanderbilt.Edu
Subject: Re: Various PMac PCI patches
References: <199908082034.WAA02973@piglet.cpu.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <199908082034.WAA02973@piglet.cpu.lu>; from Michel Lanners on Sun, Aug 08, 1999 at 10:34:15PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> Here are some PMac PCI patches and fixes:
> 
> 1. On the PowerMac, OpenBugware explicitly ignores PCI_INTERRUPT_LINE.
> However, a quick grep shows that numerous drivers rely on its value for
> driver initialization. Therefore, I've added a config_write to the
> existing IRQ fixup code, so that the IRQ gets written back into
> the PCI config register. By the way, the fixup function (fix_intr) is
> in a general file (pci.c), but only called from PMac-specific code. 

   No driver should touch PCI_INTERRUPT_LINE at all. If it does,
it's buggy and should be fixed instead of working around it in generic
PCI code. The only correct way how to get the interrupt number is to
look at pci_dev->irq (on some architectures, the interrupt numbers
are too large to fit in the interrupt line configuration register).

> 2. I've hacked pmac_pcibios_fixup with a few changes:
> 
> - It now checks for PCI buses other than the first one, on all bridges.
> This should help on the 7x00/8x00 machines (bandit and chaos host
> bridges) as well as on the 9x00 (two bandit bridges; second bus would
> be invisible up to now). If anyone has a 9x00, can  you test if this
> works? For me it only detects one of two devices on bus 1....

   Isn't it possible to search for the bridges directly instead
of scanning the PCI config space?  I see a lot of similarities between
this and the peer host bridge problems on the PC.

> - The IRQ fixup code already checks for the presence of interrupts, so
> I'v changed Martin's comment. Also, I'm not sure if PMac PCI boards can
> ever use more than one interrupt, as all PCI interrupt lines are OR'ed
> together on the bridge....

   If they really are, just kill the whole comment, it's bogus.

> - I've added IO and memory space enable code from i386's fixup code,
> minus some port address checks.This should be safe on all concerned
> machines.

   I'm not sure whether the logic for not enabling VGA and IDE devices
applies to PMAC as well, I think you can just remove it. Also, it would
be better to update the PC-centric comment from my code :)

   The rest looks OK to me.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"Anything is good and useful if it's made of chocolate."

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
