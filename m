Message-Id: <200008041525.LAA30014@mal-ach.watson.ibm.com>
To: Gabriel Paubert <paubert@iram.es>
cc: Takashi Oe <toe@unlserve.unl.edu>, Benjamin Herrenschmidt <bh40@calva.net>,
        Martin Costabel <costabel@wanadoo.fr>, linuxppc-dev@lists.linuxppc.org,
        Iain Sandoe <iain@sandoe.co.uk>
Subject: Re: rtc again... 
In-Reply-To: Message from Gabriel Paubert <paubert@iram.es>
   of "Fri, 04 Aug 2000 10:55:36 +0200." <Pine.HPX.4.10.10008041038130.9070-100000@gra-ux1.iram.es>
Date: Fri, 04 Aug 2000 11:25:06 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Gabriel Paubert writes:

Gabriel> What I need to know from people with an SMP machine:

Gabriel> - are the timebases synchronized ? Or is there a way to synchronize them ?

	On RS/6000 CHRP (RS/6000 Platform Architecture), RTAS provides
freeze-time-base and thaw-time-base calls which signal all of the
processors inan SMP complex to stop and start the TB.  I do not know of
any functionality within the PowerPC architecture which would allow
processors to coordinate their TBs without some external intervention.

	Normally AIX boot freezes the TB, zeroes the TB on each processor,
and then starts the timebase synchronized.  Because the functionality is
part of RTAS, this can be done at any time.  I do not know what PreP SMP
systems do and I know that Apple discourages use of RTAS because it is not
intended to work.

David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
