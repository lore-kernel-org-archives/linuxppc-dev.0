Date: Mon, 7 Aug 2000 23:16:07 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: David Edelsohn <dje@watson.ibm.com>
cc: Takashi Oe <toe@unlserve.unl.edu>, Benjamin Herrenschmidt <bh40@calva.net>,
        Martin Costabel <costabel@wanadoo.fr>, linuxppc-dev@lists.linuxppc.org,
        Iain Sandoe <iain@sandoe.co.uk>
Subject: Re: rtc again... 
In-Reply-To: <200008071514.LAA23286@mal-ach.watson.ibm.com>
Message-ID: <Pine.HPX.4.10.10008072252360.9070-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 7 Aug 2000, David Edelsohn wrote:

> 	Not all processors of an SMP complex are started at power-up and
> the call to start secodary processors may perform a reset, so I don't
> think that one can guarantee that the TB's are synchronized.  Maybe it all
> just works, but it does not seem like a requirement of any SMP system
> design.

Yes, you may perform a reset. But at least on the chipsets I have seen the
reset pin you have access to is the soft reset input which does not clear
the TB (nor set the MSR IP bit for example). If the HRESET inputs are
wired together (from a power supply monitoring circuit or something
similar) and the timebase is never written to, than they should be
synchronized. Then the only remaining problems are the power saving modes
that may stop the timebase...

Disclaimer: this is how it works on 6xx/7xx processors as they are
implemented in most systems. I don't know anything about IBM specific
CPUs like Power3/Power4...

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
