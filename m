Message-ID: <19990815113909.B366@albireo.ucw.cz>
Date: Sun, 15 Aug 1999 11:39:09 +0200
From: Martin Mares <mj@ucw.cz>
To: mlan@cpu.lu
Cc: Paul.Mackerras@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org,
        Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
Subject: Re: Trying a Promise Ultra/66 on powerpc
References: <199908092022.WAA00327@piglet.cpu.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <199908092022.WAA00327@piglet.cpu.lu>; from Michel Lanners on Mon, Aug 09, 1999 at 10:22:10PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> How about fixing this in the kernel's PCI bus structures, by adding any
> required offsets in the pci_fixup() routines? This would make for clean
> inb()/outb() definitions (no offset), and also accomodates multiple I/O
> spaces behind more than one bridge. For instance, on the 7x00, both
> bandit and chaos have I/O space; the one for the PCI cards, the other
> for control (yes, control has an I/O port range! Not sure it serves,
> though...).
> 
> Any fixed-offset approach would break with multiple I/O ranges.... Not
> to mention the 9x00 machines (two separate host bridges, each three
> slots), where you can't work around the problem by using hardcoded
> addresses for the known motherboard chips.
> 
> I guess this approach could be made to work across the PPC
> architecture, not only on the PMac, as the PPC in general lacks anything
> special about I/O space... after all, those are just small memory
> spaces ;-)

   Looks okay to me.  I think it's what Sparc people are already doing
on Ultra/AX.

   If you can, please wait a few days for me to merge my new PCI stuff
with Linus, it should make these fixups easy as I my current code leaves
control of the resource allocation fully to the arch-dependent code.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"...take my advice, I don't use it anyway."

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
