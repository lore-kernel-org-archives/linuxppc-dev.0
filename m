Message-ID: <3676C2B9.65A89CD4@jlc.net>
Date: Tue, 15 Dec 1998 15:12:42 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Cort Dougan <cort@ladron.cs.nmt.edu>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: PReP RTC vs Decrementer accuracy...
References: <Pine.HPP.3.96.981213172728.17076D-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




This timebase thing isn't working out so well.  I hope
I am just not being stupid, but I need some conversation
about this.

It appears all processors have the timebase register,
or at least something similar as on the 601.  However,
only the embedded processors have a timebase _compare_
register set.  What I implemented was a simulated interval
timer using the TB and the TB compare registers.  Can't
do that on other processors.

>From the various processor manuals, it appears the
timebase registers were intented to be used as the
time of day keeper.  It would be set by the OS once
(or whenever time changed) and then used to determine
time of day and date.  It has a high enough frequency to
give sub-second resolution, can easily be read by user
applications for the time/date purpose or even time stamping.
Other than the embedded processors, it doesn't appear
there is any generic capability to interrupt the processor
when the timebase attains one particular value.

Hence, the decrementer.  It generates an interrupt (exception
actually) when it counts to zero and rolls over.  It is
likely this could be used as a periodic interrrupt, but
not guaranteed since there is no atomic update capability.

IMHO, I think the decrementer serves our needs well
enough.  It may require a little more tuning to be more
accurate, but if you are running in a network of servers
you should be running a time daemon anyway to keep
everyone in sync.  If you are not, just set the date
once in a while when it starts to drift too far away
from your wrist watch.

In the embedded world where timing is sometimes
more critical, I have now implemented three different
choices....the decrementer, the timebase compare, and
the programmable interval timer.  There are even more
to choose from :-).

The generic solution would be an implementation as
many of the processor documents suggest.  Use the
decrementer to give you a "close enough" scheduling
interrupt, and the timebase registers to keep an accurate
time of day and date reference.


    -- Dan



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
