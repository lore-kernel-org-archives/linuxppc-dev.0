Date: Tue, 2 Feb 1999 09:29:41 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Michael Lundkvist <ml@epact.se>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC on MVME 2306 board
In-Reply-To: <qpbtjdlx7u.fsf@erbium.epact.se>
Message-ID: <Pine.HPP.3.96.990202092146.16636H-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On 1 Feb 1999, Michael Lundkvist wrote:

> I just tried this out on one of our MVME2307 cards. No go, but I'm
> probably doing something wrong. 

That's probably my fault, perhaps the serial port is non standard or
something similar.

> Network Boot File load in progress... To abort hit <BREAK>
>  
> Bytes Received =&462440, Bytes Loaded =&462440
> Bytes/Second   =&231220, Elapsed Time =2 Second(s)
> 
> ------------END SESSION---------------------------------------
> 
> No response after that.
> 
> If I do an nbh ionstead of an nbo and step through the code with t it
> stops after the following code.
> 
> -------------BEGIN SESSION----------------------------------
> 
> PPC1-Bug>
> IP     =001F0454 MSR    =00003040 CR     =00400000 FPSCR  =00000000
> R0     =0000C082 R1     =001F0190 R2     =00000000 R3     =00000000
> R4     =00000000 R5     =49504C01 R6     =00007000 R7     =001F0000
> R8     =03FF9134 R9     =03FF8F34 R10    =03FF8F49 R11    =03FF9034
> R12    =03FF9034 R13    =00000000 R14    =00000000 R15    =00000000
> R16    =00000000 R17    =00000000 R18    =00000000 R19    =00000000
> R20    =00000000 R21    =00000000 R22    =00000000 R23    =00000000
> R24    =00000000 R25    =00000000 R26    =00000000 R27    =00000000
> R28    =00003440 R29    =00000082 R30    =00264110 R31    =00000000
> SPR0   =00000000 SPR1   =00000000 SPR8   =001F0418 SPR9   =00000000
> 001F0454 4C00012C  ISYNC       
> PPC1-Bug>
> IP     =001F0458 MSR    =00003040 CR     =00400000 FPSCR  =00000000
> R0     =0000C082 R1     =001F0190 R2     =00000000 R3     =00000000
> R4     =00000000 R5     =49504C01 R6     =00007000 R7     =001F0000
> R8     =03FF9134 R9     =03FF8F34 R10    =03FF8F49 R11    =03FF9034
> R12    =03FF9034 R13    =00000000 R14    =00000000 R15    =00000000
> R16    =00000000 R17    =00000000 R18    =00000000 R19    =00000000
> R20    =00000000 R21    =00000000 R22    =00000000 R23    =00000000
> R24    =00000000 R25    =00000000 R26    =00000000 R27    =00000000
> R28    =00003440 R29    =00000082 R30    =00264110 R31    =00000000
> SPR0   =00000000 SPR1   =00000000 SPR8   =001F0418 SPR9   =00000000
> 001F0458 7C10FBA6  MTSPR       1008,R0
> PPC1-Bug>
> 
> -------------END SESSION-----------------------------------
> 
> Any ideas?

Yes, this is normal. You can't trace through PPCBUG with the dcache
enabled, this instruction enables the caches, so you can't rely on
debugging with PPCBUG until you get the first message on the serial port.

This was perhaps the most tricky part to get the early boot working: there
is a relatively long period during which you can't rely on anything. 

Anyway if you change r0 to 0x8082 before the isync, you should be eable to
trace further. 

	Gabriel.

P.S: I just see that r3 is 0, meaning that no residual data is available,
please try again after answering yes to Network PreP boot mode enable in
the ENV command. Residual data is currently critical to early boot
operation (I'm trying to get rid of it, but it's not that easy and close
to impossible for interrupt routing).



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
