Message-ID: <36A3045A.8DC883DD@siemens.at>
Date: Mon, 18 Jan 1999 10:52:26 +0100
From: Helmut Buchsbaum <helmut.buchsbaum@siemens.at>
MIME-Version: 1.0
To: Dan Malek <dmalek@jlc.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: FADS823 - the neverending story
References: <369F2600.4525430D@siemens.at> <369F72E8.3C25AC87@jlc.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek wrote:
> 
> Helmut Buchsbaum wrote:
> 
> > I tried using initrd (with Dan's root file system mbxroot.tar.gz) and
> > rootnfs, but none of these configurations started up an initial shell.
> 
> What sort of errors do you get?  Anything printed on the console?
> If not, dump the memory associated with 'log_buf'.


Unfortunately no errors on console or in log_buf, just the standard
printouts when the kernel boots.

> 
> > The kernel itself is idle and obviously reschedules process 1 again and
> > again, but this seems kind of stuck after executing SET_PAGE_DIR :-(
> 
> How do you know this?  If you are trying to use mpc8bug or something over
> the BDM, you better stop it.  The kernel changes all of the processor
> state mpc8bug thinks isn't changing.  You go back in with mpc8bug and
> it can't find anything.  You could be doing more damage with it than finding
> useful information.



I just added a number of printk's to get an idea what's going on: the
one I added in SET_PAGE_DIR right before setting the M_TWB register is
the last I ever saw (on console and in log_buf!). I certainly use
mpc8bug to download and debug but the only weird behaviour I get is that
the CPU never stops when I set a breakpoint after having set M_TWB in
SET_PAGE_DIR, although single stepping works!
What processor state is changed by the kernel you think mpc8bug doesn't
expect to? I have a small script to load and setup the board for
starting the kernel:

Hardreset the board:                       rh
Load the boot loader:                      load
arch/ppc/boot/zImage.initrd
Load the symbols of the kernel itself:     load vmlinux :js
Hands off any int's handled by the kernel: rms der fc9b83ff

Starting with 'go' decompresses the kernel, starts it (network, uart,
RAM disk driver, etc.. is started and RARP request and mounting root
succeed) and then the kernel execve's /sbin/init (or (/bin/sh)) and then
I tracked the whole process down (loading the binary and ld.so.1) to
SET_PAGE_DIR where I loose control due to not being able to set
brekpoints any more! When I stop the CPU by pressing Ctrl-C there are
two possibilities:
1. it can't be stopped (only via NMI): it seems as if I stopped the
kernel right in a moment when it loops around in TLB interrupt (which I
suspect due to the register settings). Of course I can't continue in
this case.
2. it's just doing the idle loop or rescheduling!

To summarize: I can' get across that M_TWB setting in SET_PAGE_DIR to
get any useful information.

So I commented out that M_TWB setting, just to see where we go: it just
proceeds like we would expect until the wrong M_TWB setting strikes! But
there are no debugging problems any more!

Since I discovered that my CPU revision handles data and instruction
cache incorrectly (which I turned off, of course) I suspect additional
difficulties in the memory controller (e.g. MMU translation without
cache) and that's why I'm still waiting for my CPU's!!


> 
> > Since there is an increasing number of success stories for embedded 8xx
> > boards, I more and more suspect the FADS itself....
> 
> The FADS has always been a disaster for me.  The only way I have ever
> booted it is with my own flash rom code and a kernel from a PCMCIA flash card.
>

Probably I adapt the flash prom code for my FADS823 as soon as I have
access to a PCMCIA flash card ;-)

 
> > Now I wonder which CPU revision Dan used in his successful port for the
> > 823-based Bright Star Engineering ip-Engine board.
> 
> The silicon mask is 5F98S.  I don't know how this maps to "Rev" numbers.
> I'll print out the revision register next time I have a chance.
> 


So there is hope for me, since my revsion 0 chip has silicon mask 1F98S
!!


> > BTW, one of the major problems I had, is adapting the CPU's internal
> > register structure...
> 
> The biggest problem should have been the "uart" driver.  Several people have
> complained about this.  Of the few (or one :-) that actually suggested a change,
> it just moved configuration complexity from one place to another.
> 
> > ........ So why don't we use seperate typdefs
> > (e.g. immap860_t, immap823_t,..) and #define'ing them properly (#define
> > immap_t immap860_t)?
> 
> I am currently working on both USB and video for the 823.  I am changing
> the immap to accomodate this.  There are more similarities than differences
> among the processors and my programming preference is unions of structures
> in this case rather than separate data types.
> 

I'd appriciate unions, too. There's just no time for me to rewrite your
drivers to use unions and besides, I only have an 860 and an 823 manual!
I just try to get the kernel up and running within the few hours that
are left to do 'off-project' work, since I'd like to prove that Linux at
one of our embedded systems makes sense!

Video for the 823 is on my list, too. As soon as I have a running
embedded environment (probably I can manage to get an alternative to the
FADS!) I'd be really interested in your work!

> ...
> One of my original goals, and one I would like to maintain, is minimal kernel
> size.  Oh, it would be so nice to add all of the run time board and processor
> configuration detection so we could have one 8xx kernel.  However, in this
> embedded environment every processor cycle and memory byte is precious.
> For LinuxPPC to be successful in this environment we must keep this goal,
> and none of us want the alternative to LinuxPPC in this environment :-).
> 

I'd prefer a configurable kernel, too. In an embedded environment you
usually know what hardware your software is running on, so stick to
compile time configuration ;-). 


--  Helmut

*********************************************************
* Helmut Buchsbaum               * Siemens AG Austria   *
* Tel:   ++43-1-1707-36686       * EZE PN 5             *
* Fax:   ++43-1-1707-55169       * Erdberger Laende 26  *
*                                * A-1030 Vienna/Europe *
*********************************************************
* mailto:Helmut.Buchsbaum@siemens.at                    *
*        buc@eze22.siemens.co.at                        *
*********************************************************

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
