Date: Mon, 26 Mar 2001 12:51:09 +0100
Subject: Re: Sound skips
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Giuliano Pochini <pochini@shiny.it>
Cc: linuxppc-dev@lists.linuxppc.org,
	Geert Uytterhoeven <geert@linux-m68k.org>, cort@fsmlabs.com
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010326115110.7587C2EFE4@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


[Geert, Cort - the question for you guys is "has the Console IRQ block been
solved?" - I was under the impression it had from some traffic on
Linux-audio-dev]

Mon, Mar 26, 2001,  Giuliano Pochini wrote:
>>> Ok, I'll try, but this problem regards interrupt latency,
>>> not user-spacelatency.
>> can you be sure it is IRQ and not scheduling latency?
> No, but it's likely to be. The audio buffer is 32 fragments (2KB),
> that is 1.48s. I don't think an app can remain blocked so long

an FB scroll would block my G3/beige for 1.9 sec! (but YMMV).

>and it
> doesn't explain why libtool blocks the sound since it executes in much
> less time than one second.

no it doesn't... hmmm interesting... but see below:

--

for dmasound: regardless of how many fragments are buffered only two (max)
will be queued for dbdma - so IRQs blocked for longer than 23-ish ms will
skip with that setup.

[the IRQ routine deals with queuing fragments written by the app but not yet
 queued for dbdma]

In addition - unless the app can write all 32 fragments ahead - if *it* is
blocked (by scheduling latency) this will also cause the same effects.

>> If so, can you
>> identify what driver or function is holding off IRQs for this length of
>> time? [a few hundred ms is a 'monstrous' time to hold IRQs off].
> Console scrolling does it IFAIK, but this is not the case.

Yes, console is/was a bad offender - but I thought that the IRQ block in
that had been solved...

Cort? Geert?

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
