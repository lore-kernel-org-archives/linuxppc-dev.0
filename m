Date: Sat, 22 May 2004 12:36:39 -0700
From: Jamie Heilman <jamie@audible.transient.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: BriQ & Linux 2.6
Message-ID: <20040522193639.GO8520@audible.transient.net>
References: <20040521074018.GD8520@audible.transient.net> <1085181034.6755.7.camel@gaston> <20040521233523.GJ8520@audible.transient.net> <1085199239.9230.4.camel@gaston> <20040522064520.GM8520@audible.transient.net> <1085209944.9234.7.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1085209944.9234.7.camel@gaston>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
> Linux console starts at 9600 while the briq firmware use a different
> speed (I don't remember which). Try adding the speed ot the kernel
> command line

Sure ... ok I see whats going on, ages ago, when my briq ran 2.2 it
was always spoken to at 38400, but the kernel seemed to think it was
actually 9600.  As long as everything (init, setserial, getty, kernel)
agreed it was 9600 but you actually connected at 38400 all was well.
Now I see that things are trying to present a truer picture.  I still
had everything set to 9600, so the kernel was running at true 9600
and was garble, but init and getty would work OK.  I just poked
at my apps, now they all agree on 38400 and everything works now.
So that explains that, misconfiguration on my part; easy fix.

> >           RX packets:118521 errors:0 dropped:0 overruns:0 frame:0
> >           TX packets:1 errors:57244 dropped:0 overruns:0 carrier:57244
> >
> > ...and yet, strangly I don't seem to be having any obvious network
> > performance problems.
>
> Interesting. I keep seeing reports of problems with pcnet32 driver,
> that's weird though.

Yeah, quite.  It doesn't do that using the 2.4.24 kernel from TI,
which has pcnet32.c version 1.27a.  There have been a lot of changes
since then though.  The only one that caught my eye was that back then
the 79C973 was flagged to activate tx error recovery, and in the newer
driver it isn't.  I might play around with that and some higher
debugging levels later.

Right now the more immediate problem is that any amount of disk IO
that approaches significant triggers an immediate reboot.  Which is
obviously not cool.  I'm doing some SMART tests on the drive, we'll
see if that has any interesting feedback.

--
Jamie Heilman                     http://audible.transient.net/~jamie/
"You came all this way, without saying squat, and now you're trying
 to tell me a '56 Chevy can beat a '47 Buick in a dead quarter mile?
 I liked you better when you weren't saying squat kid." -Buddy

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
