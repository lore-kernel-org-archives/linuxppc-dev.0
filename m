Message-Id: <9908031526.AA40146@marc.watson.ibm.com>
To: Wulf Hofbauer <wh@echo.chem.tu-berlin.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: yet another bug in atyfb.c 
In-Reply-To: Message from Wulf Hofbauer <wh@echo.chem.tu-berlin.de>
   of "Tue, 03 Aug 1999 12:21:54 +0600." <E11BbjL-0004vi-00@mail.zrz.tu-berlin.de>
Date: Tue, 03 Aug 1999 11:26:39 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Wulf Hofbauer writes:

Wulf> EXPLANATION: atyfb.c - as of Kernel 2.2.10 - uses the following constructs
Wulf> for accessing little-endian words in Mach32 controller space:

Wulf> asm("lwbrx %0,%1,%2" : "=r"(val) : "r" (regindex), "r" (temp));

Wulf> and

Wulf> asm("stwbrx %0,%1,%2" : : "r" (val), "r" (regindex), "r" (temp) :
Wulf> "memory");

Wulf> This is meant to access a word at address regindex+temp. If regindex
Wulf> happens to be held in register r0, the address calculation is off as
Wulf> r0 is defined as a null operand. This problem shows up with gcc-2.95 which
Wulf> seems to use better register allocation code and _does_ keep regindex in
Wulf> r0 at times.

	The problem is that you are using the wrong register constraints.
The inlined assembly should look like:

asm("lwbrx %0,%1,%2" : "=r"(val) : "b" (regindex), "r" (temp));

because %1 must be a BASE register (any GPR other than r0) for this use.
If you use the correct register constraints, GCC register allocation will
arrange to place the values in the correct class of register.  If you use
the right register constraints, you do not need to make any other
modifications. 

David

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
