From: Josh Huber <huberj@WPI.EDU>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14185.17960.445210.34449@cpu.WPI.EDU>
Date: Thu, 17 Jun 1999 15:02:00 -0400 (EDT)
To: linuxppc-dev@lists.linuxppc.org
Subject: Sleeping the powerbook G3 (small progress)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've got a PowerBook G3 with an incredible need to be able to put it to sleep, so I (on the suggestion of BenH) went looking in the macos rom code.

Below are some of the notes I've been taking, take a look, and please, disassemble fff03000 and see for yourself...

I'm new to this kind of thing, and I'm hoping that someone else here will see something that I'm missing.

Josh
-----

Random information about the powerbook G3 hardware
PowerBook G3 Series (Aug 1998 model, white apple on top)/233mhz

these values were all taken from within xmon (kernel 2.3.6-vger)

This might be the magic sleep word:
4C617273 = 76, 97, 114, 115 = L, a, r, s

This string is located in memory at the following location
(I'm searching memory while I'm in Linux, btw)
c01a4d24

from what it looks like, the following happens (pseudocode):
The problem is that AFAIK, r0 is 0, and the data in memory just doesn't
reflect that. (after a sleep, *(0x4) != 0, as it looks like it should)

Here is a complete block of pseudocode from wakeup (equiv to a hard-reset)
starts executing code @ 0xFFF00100
lis r0, 0 // what's in the lower 2 bytes??? who knows?
	     from what it looks like in the MPC750 docs the GPRs are all
	     undefined.
if(MSR[NHR] != 1) continue to boot // soft reset...
				      it appears that waking up from sleep
				      is like a hard reset because the CPU
				      was off.
else // hard reset, this is the code path we want
jumps to hard_reset (0xFFF03000)

1. check bit 19 of grackle register MCR1 // note: doesn't use this value
					 as far as I can tell...just saves
					 it in cr2_eq.
(bit 19 of of MCR1 is MEMG0, which is supposed to be set by the OS when
the memory controller is finised being initialized.)

2. check PIC1 (processor interface configuration 1) register
   of grackle.

if(grackle[PIC1] == 0xFF100010) return; // This appears to be the unconfigured
					   state of the memory controller

Finally, we come to this area of the code when it looks like:
1) the machine thinks there was a hard reset
2) the memory controller is already configured
...

long *addr = r0; // register 0 is used as the offset.
long magic_word = {'L', 'a', 'r', 's'};

if(*(addr+4) != magic_word) return;
*(addr+4) = 0;
branch to **addr;

other stuff..


Registers
Name  Hex	  Binary    1         2         3
------------------01234567890123456789012345678901
PVR   0x00080202  00000000000010000000001000000010
MSR   0x00001032  00000000000000000001000000110010




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
