Date: Tue, 1 Aug 2000 17:07:42 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: Thomas Graichen <graichen@innominate.de>, thomas.graichen@innominate.de
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: keyboard problems
In-Reply-To: <news2mail-8m5oaq$6tj$3@mate.bln.innominate.de>
Message-ID: <Pine.LNX.3.96.1000801165653.10095O-100000@deepspace.mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 1 Aug 2000, Thomas Graichen wrote:

> i have a little keyboard problem on my blueberry imac with the
> standard usb keyboard: whenever i type something very quickly
> followed by space the typed in will be repeated before the
> space (best example: i want to type "cd " and get "cdcd ")
> - this gets a bit annoying - does anybody have the same
> problem (or even a fix for it) ? - is it more a soft-
> wareproblem (i hope :-) or maybe a hardwareproblem ?
> (i had it on all kernels from 2.2.x to 2.4.0-testx)

I believe I've experienced this as well.  As I recall, it occurs when two
non-modifier keys are pressed nearly simultaneously.  I suspect the issue
is that the driver is seeing a key up event and passing it on, and then at
a higher level, the kernel is getting confused because it gets two key
downs followed by two key ups, and proceeds to turn them all into bytes at
the tty level or something similar, instead of ignoring the key up events.

Probably the easiest fix would be to modify the driver to send a key up
event when a second key is pressed, even if the first key hasn't been
pressed, then to ignore the very next key up event for that first key....
Just a thought.  Of course, it's critical that such a change exclude the
modifier keys, so....  Not sure how easy that would end up being.

I'm not sure how to implement that sort of change beyond a conceptual
view, though, as I haven't really looked at Linux's USB drivers much.


Later,
David

---------------------------------------------------------------------
A brief Haiku:

Microsoft is bad.
It seems secure at first glance.
Then you read your mail.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
