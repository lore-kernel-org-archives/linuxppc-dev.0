Date: Thu, 19 Jul 2001 11:28:53 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Bastien Nocera <hadess@hadess.net>
Cc: Iain Sandoe <iain@sandoe.co.uk>,
	"Joseph P. Garcia" <jpgarcia@execpc.com>, benh@kernel.crashing.org,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4 - buttons, temperature, ictc
In-Reply-To: <3B56A30B.2070702@hadess.net>
Message-ID: <Pine.LNX.4.10.10107191113250.29149-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > This depends - does /proc/pmu allow me to poll for 'new' data, or will it
> > always return with the same data immediately? I'd rather use /dev/pmu and
> > rely on getting one reply every second.
>
>
> It's possible to add an event so that /proc/pmu is only polled when

Fine. How would I do that, with the current /proc/pmu interface?

> needed. If you rely on pmud to give you new data every second, I think
> you're dreaming (or it would need to be async). Using pmud's socket to

No, I said /dev/pmu gives me new data once a second, right now. Read my
lips: /dev/pmu (kernel interface to the PMU), _not_ the socket pmud offers
for other apps to read from.

> Right, I'm pretty sure you can put power management, and some key event
> handling in less than a 100k of sources.
> I really don't see where the bloat is...

Show me the source.

And let me rephrase my concern: it's less about code _size_ but code
_complexity_. We need one process to monitor power status and take
appropriate action. That's enough of a task for a single process. We
appear to need another to monitor keyboard events, and take appropriate
action. Power status and key events have absolutely nothing in common.
That's why I hold that there should be separate daemons.

> > Doing many unrelated things badly is the problem I see. But the general
> > purpose event handler might even run on x86. Thanks for supporting my
> > side of this argument :-)
>
>
> Pmud is just *that*, an event handler. Read Joseph's mail.

I disagree. It's a specialized handler, and it isn't even using the
'event' mechanism employed by the future input code. Joe outlined the
design principles of the _input_ event code, nothing more, nothing less.

By extension of your argument, we'd have to put a web server and a mail
server into pmud as well. After all, network packets are just other
events coming in.

> In the end this code wouldn't be pmud anymore, so we wouldn't have the
> problem of you saying that it doesn't fit into the "power management
> unit" daemon ;P

Sure, write another daemon that handles all sorts of events in a central
place. Keep adding tasks to it. In the end, it'll look like a hybrid
between MacOS and Windows I guess.

You will have noticed that I rather prefer the design guideline of 'keep
it stupid simple' here.

Anyway, as this is linuxppc-dev and not debian-powerpc I'll stop arguing
here. The author of pmud is Stephan Leemburg, direct feature requests
there. I just happen to maintain the corresponding Debian package.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
