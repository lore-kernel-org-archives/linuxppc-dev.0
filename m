Date: Wed, 29 Sep 1999 09:39:01 +0200 (MET DST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Lou Langholtz <ldl@chpc.utah.edu>
cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [Fwd: Bug: 2.2.12 still hangs PPC after some PPP activity]
In-Reply-To: <37F1C0A3.B9F25580@chpc.utah.edu>
Message-ID: <Pine.GSO.4.10.9909290937380.328-100000@begonia.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Hi Lou,
	
> > > What might happen if a driver does:
> >
> > point A
> >
> > > save_flags(old_flags);
> > > cli();
> > > restore_flags(old_flags);
> 
> point A2?
> 
> > > save_flags(new_flags);
> > > cli();
> > > restore_flags(new_flags);
> >
> > point B
> >
> > > /* can't we be interupted here? Assume yes, if so */
> > > restore_flags(old_flags);
> >
> > point C

point A == point A2 == point B == point C

> > > . . .Opinions??? Please clue me in anyway... this stuff's a kick! :-)
> >
> > The interrupt mask register has the same contents at points A, B and C. Hence,
> > if we could be interrupt a point A, we can be interrupt at points B and C. . . .
> 
> Looking in macserial.c's rs_write() function it can call transmit_chars(info) at
> point B which would seem to me to be able to be a point at which the interupt mask
> register could change. No? I have to admit I'm only now reading the various docs
> on kernel locks. So I just email'd you hoping you'd give me another hint ;-)

I don't know how the serial port hardware has to be programmed. But if
transmit_chars() must be called with interrupts disabled, it's indeed a bug.

Greetings,

						Geert

--
Geert Uytterhoeven ----------------- Sony Suprastructure Center Europe (SUPC-E)
Geert.Uytterhoeven@sonycom.com ------------------- Sint Stevens Woluwestraat 55
Phone +32-2-7248648 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
