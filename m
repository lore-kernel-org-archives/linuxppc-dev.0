Date: Tue, 27 Jul 2004 16:23:28 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: more questions about 8xx microcode patches
Message-ID: <Pine.LNX.4.60.0407271546570.7005@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


   after poring over the header and source files, and the MOT docs, a
few questions about possible microcode patches, based on the following
layout of the parameter RAM memory map of the MCP850 family,
reproduced from the user's manual (and, just remember, i'm not
*trying* to be pedantic or annoying, i am merely succeeding :-):

   the DPRAM memory map:

     Offset from DPRAM base   Controller

 	0x1C00-0x1C7F		USB
 	0x1C80-0x1CAF		I2C
 	0x1CB0-0x1CBF		Misc.
 	0x1CC0-0x1CCF		IDMA1 (whatever that is)
 	0x1D00-0x1D7F		SCC2
 	0x1D80-0x1DAF		SPI
 	0x1DB0-0x1DBF		RISC timer table
 	0x1DC0-0x1DFF		IDMA2
 	0x1E00-0x1E7F		SCC3
 	0x1E80-0x1EBF		SMC1
 	0x1EC0-0x1EFF		(Reserved)
 	0x1F00-0x1F7F		(Reserved)
 	0x1F80-0x1FBF		SMC2
 	0x1FC0-0x1FFF		(Reserved)

so, barring any typoes in the above ...


1)
   i recall that, while the manual lists the first controller above as
USB, SCC1 is also a possibility for other 8xx processors, yes?  (i'm
sure i saw this somewhere; it's not an issue for us, i just wanted to
be complete.)


2)
   given the size of the scc_enet structure in commproc.h, the whole
reason to relocate SMC1 is to let ethernet on SCC3 spill over into the
normally-reserved SMC1 memory.  i would assume the same situation
would hold if you were trying to use SCC2 for ethernet -- you'd need
to relocate SPI, right?


3)
   speaking of I2C and SPI, what's the rationale for pretty much every
single piece of information insisting that these two controllers are
relocated as a pair?  micropatch.c provides a patch which relocates
them both, a motorola doc i have has a table entitled "I2C/SPI
Parameter RAM" as if these things are absolutely inseparable.  but
they clearly initially live in different locations, and commproc.h has
two distinct structs -- "iic" and "spi".  so why historically are
these two so inextricably linked, especially in terms of a relocation
patch?  can't you relocate one and leave the other where it is?
certainly, if i wanted to put ethernet on SCC2, SPI would have to move
but not I2C.  rationale?

(if address 0x1C00 was in fact being used for SCC1, then ethernet on
SCC1 would require I2C to move.  you get the idea.)


4)
   the current micropatch.c file appears to limit one to applying a
single patch.  the first patch (written to DPRAM address 0) appears to
relocate both I2C/SPI (there's that linkage again).

further down, there's a test for USE_SMC_PATCH (*clearly* not
compatible with the first patch since they both write to DPRAM address
0) which represents the SMC/I2C/SPI patch.  (actually, it reads
"SMC2", which i assume is a typo.)  i'm assuming that this patch
relocates *all* of SMC1, I2C and SPI.  this suggests that there's
currently no patch for just relocating SMC1, which seems somewhat
restrictive.  is there no reason why someone might want to relocate
just SMC1?  or does that patch just not exist?

5)
   in general, what patches should exist?  taking into account that
applying some patches may make others impossible to use, what should
be in the list of possible microcode patches in the MPC8xx CPM
submenu?  right now, it seems that that list could contain two
entries:

   I2C/SPI
   SMC1/I2C/SPI

which would be mutually exclusive.  should there be others?  SMC1 by
itself?  SMC2?

6)
   should the USB SOF patch listed in micropatch.c be an option?
despite the fact that, as some have pointed out, USB is kind of borked
in the 850 Rev B board?


   it seems that creating a menu of 8xx microcode patches would be
fairly easy:

   1) collect the current patches, assign them symbolic names [*]
   2) decide which are mutually exclusive and code that into Kconfig
   3) using the denx 2.4.25 tree as a model, put each patch into a
 	separate source file and just include the appropriate file,
 	making the appropriate changes to source files like
 	cpm_uart_cpm1.c where necessary

thoughts?

rday

[*] definitely need some decent Kconfig names for possible ucode
patches if there's going to be a list.  the current "UCODE_PATCH"
would clearly have to go. :-)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
