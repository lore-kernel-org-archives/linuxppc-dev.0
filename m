Message-ID: <369F72E8.3C25AC87@jlc.net>
Date: Fri, 15 Jan 1999 11:55:04 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Helmut Buchsbaum <helmut.buchsbaum@siemens.at>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: FADS823 - the neverending story
References: <369F2600.4525430D@siemens.at>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Helmut Buchsbaum wrote:

> I tried using initrd (with Dan's root file system mbxroot.tar.gz) and
> rootnfs, but none of these configurations started up an initial shell.

What sort of errors do you get?  Anything printed on the console?
If not, dump the memory associated with 'log_buf'.


> The kernel itself is idle and obviously reschedules process 1 again and
> again, but this seems kind of stuck after executing SET_PAGE_DIR :-(

How do you know this?  If you are trying to use mpc8bug or something over
the BDM, you better stop it.  The kernel changes all of the processor
state mpc8bug thinks isn't changing.  You go back in with mpc8bug and
it can't find anything.  You could be doing more damage with it than finding
useful information.


> Since there is an increasing number of success stories for embedded 8xx
> boards, I more and more suspect the FADS itself....

The FADS has always been a disaster for me.  The only way I have ever
booted it is with my own flash rom code and a kernel from a PCMCIA flash card.


> Now I wonder which CPU revision Dan used in his successful port for the
> 823-based Bright Star Engineering ip-Engine board.

The silicon mask is 5F98S.  I don't know how this maps to "Rev" numbers.
I'll print out the revision register next time I have a chance.


> BTW, one of the major problems I had, is adapting the CPU's internal
> register structure...

The biggest problem should have been the "uart" driver.  Several people have
complained about this.  Of the few (or one :-) that actually suggested a change,
it just moved configuration complexity from one place to another.


> ........ So why don't we use seperate typdefs
> (e.g. immap860_t, immap823_t,..) and #define'ing them properly (#define
> immap_t immap860_t)?

I am currently working on both USB and video for the 823.  I am changing
the immap to accomodate this.  There are more similarities than differences
among the processors and my programming preference is unions of structures
in this case rather than separate data types.


> Another question is, why can't we use mpc860.h,
> mpc823.h by Motorola? Are there any copyright problems?

Because I did the original Linux port before Motorola posted any of that
to the public.  I tried to keep the names consistent with programming
manuals.  When there are inconsistencies, remember that the names
came from NDA copies of manuals that have subsequently changed
in official released documents.


> What I liked in Dan' tarball, is distinguishing the 8xx CPUs..

Thanks.  It's always nice to hear when someone actually likes something :-).

There are many more of these configuration changes coming.  When I
started the original port almost two years ago, there was only CONFIG_MBX860.
I now have seven different MPC8xx and board combinations sitting around me.
It is now more evident what is different among the boards and processor
types.

As I have posted many times, the flexibility of the 8xx family and the variety
of embedded board configurations are a real challenge.  It is now trivial to
make a few hacks here and there to support a new board.  I would prefer
not to make a career out of writing the configuration scripts :-).

One of my original goals, and one I would like to maintain, is minimal kernel
size.  Oh, it would be so nice to add all of the run time board and processor
configuration detection so we could have one 8xx kernel.  However, in this
embedded environment every processor cycle and memory byte is precious.
For LinuxPPC to be successful in this environment we must keep this goal,
and none of us want the alternative to LinuxPPC in this environment :-).



    -- Dan



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
