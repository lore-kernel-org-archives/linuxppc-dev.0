Date: Sat, 21 Apr 2001 20:16:02 +0200
From: Samuel Rydh <samuel@ibrium.se>
To: linuxppc-dev@lists.linuxppc.org
Cc: Gabriel Paubert <paubert@iram.es>
Subject: Re: [PATCH] gettimeofday stability
Message-ID: <20010421201602.B1115@ibrium.se>
References: <20010419224332.A1021@ibrium.se> <Pine.HPX.4.10.10104211630120.2724-100000@gra-ux1.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.HPX.4.10.10104211630120.2724-100000@gra-ux1.iram.es>; from paubert@iram.es on Sat, Apr 21, 2001 at 05:21:51PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Apr 21, 2001 at 05:21:51PM +0200, Gabriel Paubert wrote:
> > > BTW: how do you handle multiple MOL sessions ?
> >
> > Mutli-session support was actually added a few days ago -
> > a matter of making sure the MOL kernel module keeps session
> > specific data in a single struct, passed as a parameter.
>
> Hmm, I'm not satisfied by the answer: consider the case of an SMP system
> in which you have two processors running two instances of MOL which want a
> different timebase. Now an interrupt comes in one processor, and this
> handler needs a timestamp with do_gettimeofday(), how do you guarantee
> that the time stamp does not depend on the processor on which the
> interrupt arrives ?
>
> Don't tell me that you fix the TB on each interrupt, please.

The MOL user process runs in two modes, mac-mode and normal mode.
In mac-mode, the MOL module is in full control of the CPU (including
the MMU, DEC and the TB). When an interrupt occurs (or in general,
a non-MOL exception), everything is restored to what linux expects
before the exception is taken.

That is, TB is restored whenever an interrupt occurs in mac-mode.
The TB will estimately loose 0-2 ticks at each switch
(depending on the exact moment the clock happens to tick).

Currently, MOL does not run on SMP due to certain MMU related
complications. Much has been done here though, and only minor
fixes should be needed in order to get MOL running on
SMP.

In any case, MOL won't touch TB on SMP since that would
desynchronize the timebases which is clearly unacceptable.
Currently this means that the save-session feature will
not be available. But as I said, I'll investigate if it is
possible to locate and patch out all mftb instructions
in MacOS.

Cheers,

/Samuel


----------------------------------------------------------
 E-mail <samuel@ibrium.se>  WWW: <http://www.ibrium.se>
  Phone/fax: (home) +46 8 4418431, (work) +46 8 7908470
----------------------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
