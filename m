Message-ID: <37CD0CE1.9A2BC014@wanadoo.fr>
Date: Wed, 01 Sep 1999 13:24:17 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: vger-2.3.16 on pmac
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I must say, I am impressed! 

I watched a little how the semaphore code and all the pci stuff were
completely changing the last two days and thought it would take weeks to
bring the ppc port up to date. But it is working already and better than
in 2.3.15. I cannot any more produce kernel panics as before (at least
not with the same method). Greaat work, guys! 

I had, however, to apply one hack to make my ethernet card work: The new
(certainly not quite finished) pci code gives it a wrong IRQ number. And
this is something I would like to understand: 

There are 2 different IRQs for a given PCI card. If I do a 'lspci -v', I
get the one that is actually used and shows up in /proc/interrupts and
also in the boot messages, like for me

eth0: DC21041 at 0x0400 (PCI bus 0, device 14), h/w address
00:00:c5:47:6a:7c,
      and requires IRQ25 (provided by PCI BIOS).

If I do a 'lspci -v -b', I get another one, in this case IRQ160. This
one is also in the memory at /proc/bus/pci/devices, or in 'lspci -vx',
where I see a0=160.

This, at least, was the situation before 2.3.15-final. Now the unpatched
2.3.15-final or 2.3.16-final (with trivial patches to make it compile)
give me a boot message with IRQ160 and 'lspci -v' and 'lspci -v -b' both
give the same value 160. This is not a valid interrupt number, and of
course the card does not work.

My question is: At what place in the kernel is (or used to be) the
bus-centered IRQ160 translated into the cpu-centered IRQ25?

My hack was to put some 'if (irq == 160) irq=25;' somewhere in
pmac_setup.c, like in chrp_setup.c, where IRQ2 is translated into IRQ9.
This works (I am writing this using it) and it shows that there is
really not much wrong otherwise with the pci code (at least not for the
devices in my machine).

--
Martin

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
