Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3917167D5B
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Dec 2006 10:34:25 +1100 (EST)
Subject: Re: shared config registers and locking
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Galassi <mgalassi@c-cor.com>
In-Reply-To: <200612062314.kB6NE8iQ083398@penguin.ncube.com>
References: <1165381847.5469.70.camel@localhost.localdomain>
	<200612062257.45153.roger.larsson@norran.net>
	<1165445865.5469.130.camel@localhost.localdomain>
	<200612062314.kB6NE8iQ083398@penguin.ncube.com>
Content-Type: text/plain
Date: Thu, 07 Dec 2006 10:34:13 +1100
Message-Id: <1165448053.5469.145.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> GACK!  Many better engineers than any of us have spent countless hours
> breaking down locks.  A lock takes nearly no space at all, you're not
> proposing to lock any less often, so multiple locks take no less time,
> the only thing you stand to gain by protecting multiple data structures
> with one lock is the possibility of lock contention.  Please reconsider.

Wait wait wait.... I'm perfectly aware of lock contention issues and I'm
not proposing to have a giant lock for everything in the system.

I was proposing something very clearly aimed at configuration type
things that are generally accessed a bit at boot time and then every
time the phase of the moon changes, in which case, it's just a pain to
have to use fine grained locking and one shared lock is plenty enough.

The specific example that made me think about it was some clock control
registers on 4xx that the EMAC driver is whacking every now and then (on
link state change, no lock contention to be worried about here), though
they could be used by other drivers too (or platform code). Since those
registers are a bit different from one 4xx to the next too, and since I
now have a non-4xx platform that needs to use EMAC and has similar clock
control bits I might have to toggle there too, I'm basically ending up
with a global spinlock that I can't precisely define better than "global
clock control lock" ....

Now, what is best there ? To have 4xx expose such a lock and define
precisely what set of registers it covers and require any non-4xx
platform that uses the EMAC driver to provide a similar lock ?
 
Now, you have the right to disagree with me, I was mostly asking what
the mood was about it, I don't have any firm opinion on wether it's a
good or a bad idea just yet... so I count your vote as a "no" :-)

Another approach would be to remove the code from EMAC and have it
instead use the "feature call" thingy to call into platform code to do
the magic clock tweaking (with appropriate locking) but I don't like
much that idea as all 4xx platforms pretty much would have to duplicate
that code, and I prefer keeping some of that magic in the EMAC driver
itself. 

Now, regarding exposing a function or just a spinlock, well, you might
well be right that exposing a spinlock is better, I have no very firm
preference there neither... just a slight bias toward exporting
functions rather than variables.

Ben.
