Message-Id: <199906111644.SAA06210@denx.muc.de>
To: Magnus Damm <damm@kieraypc01.p.y.ki.era.ericsson.se>
cc: linuxppc-dev@lists.linuxppc.org
From: Wolfgang Denk <wd@denx.muc.de>
Subject: Re: Help booting MBX through bootd 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 11 Jun 1999 15:36:11 +0200."
             <376110CB.8CE16CAF@switchboard.ericsson.se>
Date: Fri, 11 Jun 1999 18:44:25 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

in message <376110CB.8CE16CAF@switchboard.ericsson.se>
Magnus Damm wrote:
> 
> The kernel has no problems. But glibc 2.2.1 has.
> 
> The fact that the cache magic in sysdeps/powerpc/memset.S in glibc
> will make the dynamic linker crash in it's early startup phase is
> quite a big problem... ;)
> Also sysdeps/powerpc/dl-machine.c makes an assumption about the cache
> line size, but that seems to be less fatal.

Grrrghh... I see.

But the cache line size differs even for different models of the  8xx
family!

> If compatible binaries is what you want then this has to be dealt
> with. The code in sysdeps/powerpc/dl-machine.c is easy enough to
> fix and not particularly performance critical. But the non-embedded
> people will probably not be happy if we almost half the speed of
> memory clearing, so here we'd need some sort of runtime check of the
> line size. Probably by checking /proc/cpuinfo the first time and cache
> the result.

We will have to do this, or otherwise drown in a flood  of  different
versions  of  libraries  and  binaries.

It's impossible to provide a whole  set  of  libraries  and  all  the
binaries linked against the right versions of these libraries for the
821, 823, 850, 860, 8240, 8260, ....

> > * There are multiple versions of the same functions, for instance
> >   udelay (for the kernel as assembler inline in include/asm-ppc/delay.h,
> >   for the boot code in arch/ppc/mbxboot/head.S).
> 
> Isn't that because the mbxboot runs before the real kernel has booted?
> It needs it own set of functions. 

Yes, but they could use the same source? Or am I missing something?

> > *  The  whole  file  arch/ppc/mbxboot/head.S  is  a  complex  mix  of
> >   #ifdef'ed  and  #ifndef'ed  code  -  trying to add yet another bard
...
> It sure is a mess. 
> Maybe is should be a good idea to create seperate board files?

Seems some people are doing this already, so I guess the answer is YES.

> >   console speed than the default 9600 bps? And how do  you  find  all
> >   those places? Are you sure you didn't forget a few places where the
> >   bus clock is hard coded?
> 
> Or where IMMR is hardcoded in head.S ? =)
> 
> That is a big problem.

Right.

> My opinion is that one include file should contain all neccesary
> settings.

I definitely support this idea.

> why not have a ENET_ENABLE_TENA() which is defined in your board file?
> And uart.c shouldn't mess with all pins, only pins that are used. 

Right. This could even be done for  some  board  specific  functions.
Instead  of putting m8xx_gorom() in a common source file and wrapping
it into a nightmare  iof  #ifdef's  this  should  go  to  some  board
specific source file (or header file, maybe).

> >   Another are of problems is port pin assignement  and  CPM  configu-
> >   ration  in  general. Which SCC is used for your ethernet interface?
> >   Which BRG's does it use? Is your console on a SMC or a  SCC?  Which
> >   port pins have to be used? Which clocks? Etc. etc. - right now this
> >   configuration  is  distributed  to  many  places in the code, which
> >   makes changes in the configuration difficult.
> 
> You are absolute right about that.
> I think that could be solved in the board include file.
> It would also be great with some kind of resource allocation code.
> But we don't want PlugNPray, do we? 

No, we don't.

But with a little generalization in the code many things could become
a bit simpler. For instance, in LynxOS they use a concept of "logical
devices" which allows that for instance device  consiguration  become
as simple as:

Serial driver:

	/* /dev/com1: is on  SMC1,  uses  BRG1,  speed  115200 bps */
	UART(tty_8xx_info1, DEV_SMC1, CPM_CLOCK_BRG1, B115200);

or Ethernet:

	  DEV_SCC1,
	  32,                   /* Number of BDs in the Rx BD table */
	  32,                   /* Number of BDs in the Tx BD table */
	  CPM_CLOCK_CLK1,       /* PA7 = CLK1 used for Rx Clock     */
	  CPM_CLOCK_CLK3,       /* PA5 = CLK3 used for Tx Clock     */

they  use  generalized  functions  like  `cpm_uart_install()',  which
checks  if the "logical device" is a DEV_SMCx or a DEV_SCCx, and then
access the appropriate data structures. There _is_ some logic in  the
bits used for all the CPM devices; instead of building individual bit
masks for each single device we can use a _generic_ pattern that just
needs  to  be  shifted  to the right position depending on the device
being used.

I don't want to say that I find the LynxOS code to be the best of all
possible solutions - but at least it's easier to understand than what
we have right now in Linux. And *much* simpler to port.

> >   I don't think I'm the first who  notices  this  problem.  Is  there
> >   already any work being done in this direction?
> 
> I would like a word from Dan.
> Lead us sheep in the right direction. =)

Yes, please!

> Could people out there tell the rest of us what you're doing?

I'm trying to provide some kind of "Demo CD" for a board manufacturer
to be shipped with the hardware (of course for free and with source),
allowing his customers to  start  development  with  a  free  (Linux)
environment instead of spending a lot of $$ for commercial tools.

All these boards have >32 MB of RAM so a native environment with  NFS
mounted  root  filesystem  is quite easy. But I definitely don't have
the resources to build a  complete  LinuxPPC  release  with  all  the
libraries and binaries for the whole mix of 8xx CPU's.

SO I have *great* interest in a simplified handling of board specific
configuration parameters like

- clock rate
- address mapping (RAM, FLASH, IMMR, ...)
- devices (serial/console ports, ethernet, ...): which CPM channel,
  BRG, Clock routing, number of BD's, baud rate, ...

> It doesn't feel good when you've implemented something and
> you find out that someone else has done _exactly_ the same thing.

Exactly what I'm feeling.

And of course I'm willing to provide feedback about  what  I  changed
for  my  port or where I see things that could/should be changed. But
right now it was for instance much easier  to  me  to  write  my  own
version  of mbxboot/head.S than to add yet another level of #ifdef'ed
complexity.

> Communicate.

:-)

Wolfgang

-- 
Phone: (+49)-8142-4596-87  Fax: -88  Home: -86  Email: wd@denx.muc.de
There are three things I always forget. Names, faces -  the  third  I
can't remember.                                         - Italo Svevo

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
