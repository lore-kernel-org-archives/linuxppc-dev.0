Date: Tue, 3 Aug 1999 12:57:52 -0400
From: Daniel Jacobowitz <drow@false.org>
To: David Edelsohn <dje@watson.ibm.com>
Cc: Wulf Hofbauer <wh@echo.chem.tu-berlin.de>, linuxppc-dev@lists.linuxppc.org
Subject: Re: yet another bug in atyfb.c
Message-ID: <19990803125752.A20729@them.org>
References: <wh@echo.chem.tu-berlin.de> <9908031526.AA40146@marc.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9908031526.AA40146@marc.watson.ibm.com>; from David Edelsohn on Tue, Aug 03, 1999 at 11:26:39AM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Aug 03, 1999 at 11:26:39AM -0400, David Edelsohn wrote:
> 
> >>>>> Wulf Hofbauer writes:
> 
> Wulf> EXPLANATION: atyfb.c - as of Kernel 2.2.10 - uses the following constructs
> Wulf> for accessing little-endian words in Mach32 controller space:
> 
> Wulf> asm("lwbrx %0,%1,%2" : "=r"(val) : "r" (regindex), "r" (temp));
> 
> Wulf> and
> 
> Wulf> asm("stwbrx %0,%1,%2" : : "r" (val), "r" (regindex), "r" (temp) :
> Wulf> "memory");
> 
> Wulf> This is meant to access a word at address regindex+temp. If regindex
> Wulf> happens to be held in register r0, the address calculation is off as
> Wulf> r0 is defined as a null operand. This problem shows up with gcc-2.95 which
> Wulf> seems to use better register allocation code and _does_ keep regindex in
> Wulf> r0 at times.
> 
> 	The problem is that you are using the wrong register constraints.
> The inlined assembly should look like:
> 
> asm("lwbrx %0,%1,%2" : "=r"(val) : "b" (regindex), "r" (temp));
> 
> because %1 must be a BASE register (any GPR other than r0) for this use.
> If you use the correct register constraints, GCC register allocation will
> arrange to place the values in the correct class of register.  If you use
> the right register constraints, you do not need to make any other
> modifications. 

And congratulations to the both of you, you analyzed that one much more
easily than I did :)  It's been fixed in vger for a while:

revision 1.106.2.1
date: 1999/06/22 06:28:23;  author: paulus;  state: Exp;  lines: +42 -23
Geert's crystal frequency estimation stuff from the 2.3 branch;
fix the constraints on the inline assembly.

However, could someone please move this fix onto the mainline also?


Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
