Message-Id: <5.0.0.13.2.20000828125632.028fd630@mail.munich.netsurf.de>
Date: Mon, 28 Aug 2000 13:51:05 +0200
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: Patches for 2.4.0-test7
Cc: Benjamin Herrenschmidt <bh40@calva.net>,
        Martin Costabel <costabel@wanadoo.fr>, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.10.10008281239570.28749-100000@opal.biophys.uni
 -duesseldorf.de>
References: <20000828093449.32188@192.168.1.10>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 12:43 28.08.00, Michael Schmitz wrote:

> > >When I go back to a kernel without new input layer, I have to change all
> > >this back. This wouldn't be necessary if drivers for both /dev/adbmouse
> > >and /dev/input/mice could coexist..
> >
> > Well, that's the reason why I originally wanted this compatibility code.
> > However, after more thinking, I figured out that if we do that, all it
> > will result is yet another configuration mess with users and more support
> > emails ;)
>
>We'll have the configuration mess either way. And few things are as
>frustrating as answering the question 'why does the screen just keep
>flashing on me when I boot this new 2.4 kernel, and how do I fix it' a
>hundred times.

But if you have a clean cut you can actually tell people what to do if they
use 2.4. And with people I mean the mass of users that nearly never switch
kernels, not developers like us :-). And if they switch they usually don't
ever switch back after a trial phase.

For 2.2 backwards compatibility is a must, but 2.4 is a major kernel
release and the right time to drop some backwards compatibility. And this
change doesn't even require updated user tools, it just requires slight
config changes.

> > Note that you can have the new input layer with 2.2 using my kernels. I
>
>Which has working adbmouse if you remove all #ifndef INPUT_MOUSEDEV and
>corresponding #endif in adbmouse.c.

In 2.2 adbmouse compatibility is there anyways, the only problem we are
still investigating is with Xpmac+adbmouse (well, Xpmac doesn't actually
use adbmouse right now), but this should be solved with the pending Xpmac
rev 11.

> > still have to verify what's up with Vojtech, but I beleive the input
> > layer is part of the USB backport, meaning that future "kernel.org"
> > 2.2s+backport will provide the same functionality as 2.4.
>
>Meaning that functionality will be lost ... thanks for the warning.

In 2.2 we will include backwards compatibility with adbmouse, only in 2.4
you will only have the either/or choice. We want to encourage people to use
the input layer in 2.4, so /dev/adbmouse can be dropped completely during 2.5.
And no functionality is lost (the mouse still works), just backwards
compatibility. And I completely agree with Linus on dropping backwards
compatibility as soon as possible. Maybe we would have functional and fast
XF3/4 display drivers by now for all of our (few) chips, if we would have
dropped Xpmac compatibility in 2.3.1?

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
