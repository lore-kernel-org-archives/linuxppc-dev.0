From: "David L" <idht4n@hotmail.com>
To: phil-list@redhat.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Thread starvation with mutex
Date: Thu, 11 Mar 2004 15:01:03 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY2-F32QZlCouqqa7B00038c9c@hotmail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sorry to beat a dead horse, but there seems to be a huge amount
of confusion about NPTL and its relationship to real-time
scheduling.  This may not true for the experts on phil-list, but
I know I'm not the only Linux user confused about this topic.  There
has been discussion on the linuxppc-embedded mailing list that
seems to make incorrect conclusions about NPTL (see the bottom
of this email for an excerpt from one such post).

I can't speak for others, but here's how I came to be confused.
First, I have to say, I'm far from an expert in pthreads.  I've read
enough to make a few simple multithreaded programs work.  When
I upgraded from redhat6 to redhat9, I was excited to see how the
much-touted NPTL would improve the performance of my multi-
threaded program.  The performance sucked.  It acted like it was
ignoring the priorities I assigned to the threads.  Was it NPTL's
fault?  Almost certainly not.  I was probably doing something
wrong that happened to work in redhat6 but not redhat9.  But
when I started googling to learn about NPTL, I found a several
year old paper that was over my head and said real-time
features were on the to-do list.  Most of the rest of the stuff google
turned up was arguments between experts on this list that were
over my head.  At one point, I concluded that SCHED_FIFO and
NPTL somehow didn't play well together.  I think a lot of other
people have come to the same incorrect? conclusion.

Somebody (Dr. Drepper maybe) should try to clear up this confusion by
posting to this list and linuxppc-embedded@lists.linuxppc.org a
summary of the differences between linuxthreads and NPTL
with respect to "real-time" scheduling.  Also, if there is a
migration guide from linuxthreads to NPTL please let us know
where it can be found.

Thanks -

                                David

excerpt from linuxppc list:
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

  >>RH9 introduces 'nptl', (locally known as 'non-portable threads
  >>library'), which is strictly SCHED_OTHER.  Any
  >>RTOS code which relies on prioritized scheduling to work reliably
  >>(including some of the v2pthreads emulation layer) will be broken with
  >>'nptl'....
  >>
  >Isn't 'nptl' also 'standard' in the new 2.6 kernel? Is it strictly
  >SCHED_OTHER in 2.6 also? Isn't that a severe blow to 'real-time'
  >embedded Linux? I don't understand...
  >
  Both statements are regrettably true. The developer(s) of 'nptl'
  regard regard real-time scheduling as 'nonsense' (that's what Ulrich
  Drepper called it!) and have no intentions of supporting it.
  Furthermore, their development priority is on scheduling efficiency
  rather than priority, and they believe it's okay to 'water down' the
  expectations of the applications programmer in order to boost
  performance.  Consequently I intend to personally take a look at their
  code to see what can be done to make it more desirable for the real-time
  applications community.  Drepper and crew don't see the shortcomings in
  their approach, so we in the real-time community will have to make any
  corrections ourselves.

So there we have it. The new 'nptl' threading library does not support
real-time scheduling. Comments?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^6

_________________________________________________________________
Store more e-mails with MSN Hotmail Extra Storage – 4 plans to choose from!
http://click.atdmt.com/AVE/go/onm00200362ave/direct/01/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
