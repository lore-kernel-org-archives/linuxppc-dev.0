Message-Id: <199906102024.WAA25083@denx.muc.de>
To: linuxppc-dev@lists.linuxppc.org
Cc: Magnus Damm <damm@kieraypc01.p.y.ki.era.ericsson.se>
From: Wolfgang Denk <wd@denx.muc.de>
Subject: Re: Help booting MBX through bootd 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 10 Jun 1999 14:38:23 +0200."
             <375FB1BE.1789E049@switchboard.ericsson.se>
Date: Thu, 10 Jun 1999 22:24:11 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

in message <375FB1BE.1789E049@switchboard.ericsson.se> Magnus Damm
wrote:
> 
> There are a few problems today with 8xx linux.
> People out there: Correct me if I'm wrong.

Ok, I'll comment on this; I intended to summarize my experience  with
my  firsrt  port of 2.2p7 and 2.2.5 to a custom board anyway, so here
it comes:

> I blame some of the strange problems on silicon bugs 
> in the mpc860 chip. Read the chip errata.

This is indeed a problem. Many (old) MBX boards have old revisions of
the 860, which have some severe problems. Especially the  data  cache
corruption  bug hits hard. Make sure that you have a silicon revision
C1 at least.

> My MBX board has a XPC860ENZPA.

Maybe it's a A. The mask revision is encoded in the low 8 bits of the
IMMR. Check there!

> I think I have a C1 chip on a other board which works better.

Yes, definitely.

> The memory management is a bit strange.
> On some boards is it neccesary to reserve a few tlb entries.

I haven't seen this so far. But all my CPU's were mask revision C1.

> One other problem is that the 8xx series don't have a fpu.
> That is not a kernel problem, more a libc problem.

No, this *is* a kernel problem. When running  some  applications  you
will  find  quite  a lot that will produce "Bad emulation" / "Illegal
Instruction" exceptions. So far the suggested solution is to  compile
the  relevant  code  with  `-mcpu=860'.  But  this  solves  only some
problems...

Linux on the 860 makes only sense for a certain  class  of  projects:
embedded  systems,  especially  in  telecomminucations. While it *is*
easy to compile the target application so that it does not  need  the
FP  emulation, we also must provide a *development* environment, both
for application and driver code. In many cases the  easiest  solution
is  native  development  on the target, running with a complete Linux
environment using a NFS mounted root  filesystem.  And  this  implies
that  *every*  application must run on the 860, may it be perl or awk
or date or anything else. 

Either we can use any standard PPC distribution for that, or we would
have to recompile *everything*, from the standard  libraries  to  the
last  tool anybody might ever use. Is there anybody who volunteers to
provide up-to-date MPC8xx  Linux  releases?  No,  this  doesn't  make
sense.

The FP emulation should be fixed so that it allows to run  *any*  PPC
Linux binary on the 8xx, too.

Leif Lindholm <Leif.Lindholm@uab.ericsson.se> volunteers to implement
the missing instructions, starting a couple of weeks from now.


> The last problem I know is that the 8xx has a smaller 
> (4 words) cahce line length compared to 60x.

Is this really a problem?


I noticed some other problems in the (2.2.5) MBX8xx code:

* There are multiple versions of the same functions, for instance
  udelay (for the kernel as assembler inline in include/asm-ppc/delay.h,
  for the boot code in arch/ppc/mbxboot/head.S).

* I don't think the udelay in arch/ppc/mbxboot/head.S provides really
  the timing it's supposed to give; not even on 66 MHz systems.

*  The  whole  file  arch/ppc/mbxboot/head.S  is  a  complex  mix  of
  #ifdef'ed  and  #ifndef'ed  code  -  trying to add yet another bard
  architecture is a nightmare. It was much easier to me  to  _remove_
  all  the  unneeded  cases  and write a new version for my own board
  only.

* We should keep in mind that we  will  have  to  support  a  growing
  number  of  custom  boards.  IMHO  we *must* find a way to separate
  hardware dependend code into asmalls et of  configuration  files  -
  something  like  the  BSP's  (board  support  packages) you get for
  commercial RTOS. Just to give an example: how  many  files  do  you
  have  to change when you want to run your MBX860 board with another
  console speed than the default 9600 bps? And how do  you  find  all
  those places? Are you sure you didn't forget a few places where the
  bus clock is hard coded?

  There is  already  provision  for  the  board  information  data  -
  something like that should be used for all hardware versions. [This
  is what I did for my ports; once done, it saved me a lot of work.]

  Another are of problems is port pin assignement  and  CPM  configu-
  ration  in  general. Which SCC is used for your ethernet interface?
  Which BRG's does it use? Is your console on a SMC or a  SCC?  Which
  port pins have to be used? Which clocks? Etc. etc. - right now this
  configuration  is  distributed  to  many  places in the code, which
  makes changes in the configuration difficult.

  I don't think I'm the first who  notices  this  problem.  Is  there
  already any work being done in this direction?

* Does the reset code in m8xx_gorom()  [arch/ppc/kernel/head.S]  work
  for  somebody? I could not get it working on the MBX board, nor did
  it work on the custom 860 boards I've seen so far. In all cases the
  system just hangs, I have to manually reset them. Any ideas why?

Wolfgang

-- 
Phone: (+49)-8142-4596-87  Fax: -88  Home: -86  Email: wd@denx.muc.de
The only person who always got his work done by Friday
                                                 was Robinson Crusoe.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
