Message-Id: <199906102051.WAA00299@piglet.cpu.lu>
Date: Thu, 10 Jun 1999 22:51:08 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Q: control is a C&T 65550?
To: drow@false.org
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <19990608095844.A5496@drow.res.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   8 Jun, this message from Daniel Jacobowitz echoed through cyberspace:
>> Is it correct that the /chaos/control chip is essentially a Chips &
>> Technologies 65550?
> 
> It's my understanding that it's not.

I think so too. The little documentation available about control tells
us it has fundamental differences with c&t 65550. Plus, the 65550 is
designed specifically for an LCD panel in portable applications.

> No one has any documentation on
> it to my knowledge... 

Not really specific documentation; but some things can be learned by
looking at Apple's Spec library, in the PDF datasheet about the
original 7500/8500 series computers.

> I'd love to add hardware cursor support, which
> I'm fairly sure it has, to controlfb.  But I can't do it without some
> sort of reference.

For the interested, here is a little writeup of what I have learned over
the years ;-) about control:

- The system consists of two or three pieces, not of a monolithic chip
like most grafic chips today (c&t 65550 would be an example of that
monolithic class, integrating bus interface, VRAM interface, control
logic, and sometimes RAMDAC).

- The video subsystem resides on its own PCI-like bus, which is a
64-bit bus, clocked the same as the CPU bus (40-50 MHz), attached to the
CPU bus by a bridge (named chaos).

- control is the interface chip that attaches the VRAM to this PCI-like
bus. Although it probably has other control functions, those are little
known. One of those functions is defining video signal timing
parameters.

- The VRAM is a dual-port DRAM (relatively slow), unlike most modern
video adaptors, that use some kind of standard (single-port) modern RAM
(SDRAM, SGRAM, etc...). The bus towards control (i.e. towards the CPU)
is 64 bits wide; towards the RAMDAC it is 128 bits wide (at least in
max VRAM configurations).

- The RAMDAC is an Apple ASIC as well, named RaDaCal, integrating the
RAMDAC, CLUT and a hardware cursor device. Use and programming of the
hardware cursor are yet undocumented. The known details are that the
cursor needs to be drawn by the OS as some kind of sprite, in an
offscreen VRAM portion reserved at the end of each scanline. The
vertical position needs to be drawn at the right offset, whereas the
horizontal position of the cursor is taken care of by RaDaCal, probably
by setting the horizontal position info in a register. Vertical
movements therefore need a redraw by the OS.

- There is probably a third chip in the system, which generates the
clock signals. This can be deduced from the fact that clock parameters
are set via an I2C bus off cuda, and not through either RaDaCal or
control.

Obviously, all of the above information can be totally wrong ;-). If
there is any Apple engineer in the audience who knows better, please do
speak up!

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
