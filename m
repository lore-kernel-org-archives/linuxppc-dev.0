Message-Id: <4.3.2.20000921142722.00b8b720@falcon.si.com>
Date: Thu, 21 Sep 2000 15:05:00 -0400
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: Limon & PowerQUICC II
Cc: systemboot@linux01.hasler.ascom.ch
In-Reply-To: <0G1800HE5TPGL0@pmdf-it.hasler.ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 05:29 PM 9/21/00 +0100, Ruedi.Hofer@ascom.ch wrote:
>Hi
>
>I ordered an EST SBC8260 evaluation board and I finally got it!!!
>
>As always I try to run Linux on it. First of all, I found the bootloader
>Limon on the net, cross compiled it and tried to run it.
>
>I failed!! Why??
>
>Questions:
>
>1. Does someone know the correct value of the reset word required
>by limon?
>
>  I use  04 38 02 05 for the 8 bit flash / 66MHz
>   0c 38 02 05 for the 32 bit flash / 66MHz

I'm currently using vxWorks' boot loader, not using limon (I used limon
but never burned it into flash), but the principle is the same.  You
may need to open CNFG7 (the DIP switch MSB) to program flash if the
reset word is really screwed up.  You have to _cycle_power_ for the
8260 to pick up the reset word (asserting HRESET with the power/reset
switch is not sufficient).  Other DIP switch settings may be desirable
depending on the clock rating of your CPU.

For 66MHz, I use 0C 32 02 05:
S309FE0000000C000000EC
S309FE00000832000000BE
S309FE00001002000000E6
S309FE00001805000000DB
I set the DIP switches to xxxxxOOC for 166/133/66 (CPU/CPM/bus)

For 33MHz, I use 0C 32 02 02:
S309FE0000000C000000EC
S309FE00000832000000BE
S309FE00001002000000E6
S309FE00001802000000DE
I set the DIP switches to xxxxxCOO for 166/133/33

O = open
C = closed
The last (rightmost) three spots of DIP switch are labeled CNFG1,2,3

>2. Does limon run on the 32 bit flash or on the 8 bit flash?

Should run in either.  I boot out of 32 bit flash.  EST ships their
diagnostics monitor in 8 bit flash.  It is nice to be able to run that
occasionally when the board is AFU, just as a sanity check (switch the
CS0/CS6 fleaclip jumpers).

>3. I use the Abatron BDI to program the flash memory. Am I right
>when I load the srec-file into the bdi and overwrite the first 4 bytes
>with the reset word (then write the stuff to flash)?
>
>4. I have set IMMR to 0xF000000. Is that correct for limon?

The reset config word is what sets the IMMR.  It has to agree with the
limon's notion of where the IMMR is.  Beyond that, it is your
choice.  The EST default value is 0x0F000000 which is unfortunately
different from the linux convention.

The linux source you probably will be trying to run next wants the IMMR
at 0xF0000000.  You can change it with the reset word or by changing it
in software before starting linux.


>5. I read in the sourcecode that limon wants to run at 0xfff00100.
>Where do I have to set this address? (In the enclosed memory map
>I found a drawing sayin that the flash should be at 0xfe000000!)

The 32bit flash is mapped starting at 0xFE000000 and is duplicated four
times (4Mbytes of flash in a 16Mbyte space).  The 8260 picks up its
reset vector from 0xFFF00100 (end-of-memory less 1Mbyte + 0x100) so you
have to build limon so that its entry point is at the reset
vector.  This will be 3Mbytes into the last copy of the flash.  It is
easiest to just program it there and your JTAG programmer should Do The
Right Thing.  You do have to be careful that you don't inadvertently
erase the reset word when programming limon and vice versa (I've
inadvertently erased my monitor when erasing the reset word a time or two).


>6. Can someone provide the correct values for the BRx / ORx?
>I used the ones from limon -> reset.c!
>
>
>Thank you for any help
>
>Ruedi

You're welcome.

gvb


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
