Message-Id: <199908051808.UAA00314@piglet.cpu.lu>
Date: Thu, 5 Aug 1999 20:08:43 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: OF booting of G3-upgraded 7600?
To: Paul.Mackerras@cs.anu.edu.au
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <199908050141.LAA10285@tango.anu.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Paul,

On   5 Aug, this message from Paul Mackerras echoed through cyberspace:
>> Default Catch!, code=FFF00400
> 
> That's an instruction access exception.  What were the srr0 and srr1
> values?  Also, doing ".registers" will show the state of all of the
> registers.

Here you are:

(values are correct (5 in %CR), the layout is 'by hand')

0> boot CLAIM FAILED!, code=FFF00400
 ok
0> .registers
	Client's Fix Pt Regs:
  00 DEADBEEF DEADBEEF DEADBEEF 003F4400 00000020 FF8099B8 DEADBEEF 000000FF
  08 00000002 00000008 DEADBEEF DEADBEEF DEADBEEF DEADBEEF 003F0000 DEADBEEF
  10 DEADBEEF DEADBEEF DEADBEEF DEADBEEF DEADBEEF DEADBEEF DEADBEEF DEADBEEF
  18 DEADBEEF DEADBEEF DEADBEEF DEADBEEF DEADBEEF DEADBEEF DEADBEEF DEADBEEF

	Special Regs:
   %IV: 00000400 %SRR0: 003F4058 %SRR1: 08003070
   %CR: 5EADBEEF   %LR: DEADBEEF  %CTR: 00000000 %XER: C000BE6F
  %DAR: 00001000 %DISR: 42000000 %SDR1: 06FE0000
 ok
0> msr@ ok 
1> u. B070 ok
0>

>> - on subsequent 'boot' commands:
>> 
>> 0> boot Claim failed
> 
> The loader is trying to use memory that is already allocated, since it
> was allocated by the loader last time. :-)

Seems reasonable...

Thanks

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
