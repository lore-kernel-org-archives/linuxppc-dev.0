Date: Wed, 15 Mar 2000 12:13:25 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: michdaen@iiic.ethz.ch
cc: Alan Hourihane <alanh@fairlite.demon.co.uk>,
        Kostas Gewrgiou <gewrgiou@imbc.gr>,
        "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to workonppcwithr128
In-Reply-To: <20000315094454.921.qmail@web106.yahoomail.com>
Message-ID: <Pine.LNX.4.10.10003151054180.24581-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > > Doesn't hurt for probing, but maybe for the ioctl?
> >
> > The ioctl has been disabled long time ago.
>
> I meant when you hadn't disabled it. It hung there at the time, right? Now a
> hang in an ioctl is a kernel bug, or am I missing something?

No, you're right :-)

> > I'll get back to poking around in there as soon as I can figure out how to
> > see the kernel messages (i.e. how to switch back to the text console fast
> > enough, or never let the X server switch to VT 7 in the first place).
>
> A remote machine might be handy...

That's what I'm using already. But the kernel messages that otherwise
appear on the text screen won't get redirected to a remote machine.
Nothing ever ends up in the syslog, anyway. I guess the klogd/syslogd
combo is too slow in this case.

> > Now I can't get beyond xf86HandleColormaps(). Another ioctl that barfs on
> > me, perhaps.
>
> Well possible, FBIOPUTCMAP in fbdevHWLoadPalette.

Probably. I'll have to trace all these ioctls as soon as I can keep the X
server from switching consoles.

> I don't understand the code there...

The cmap only passes the pointers to the color values. fb_set_cmap does
get_user on those so it should be OK. Don't ask me why X sets each entry
separately though (on some braindead Mac video cards this means you have
to start setting the cmap from entry 0 until you hit the right one, each
time).

> BTW I've just discovered that the fbdev driver sets the weight explicitly to
> {0,0,0}... now I'm (really ;) confused.

So was I.

> > I guess it all boils down to PCI messups.
>
> How do you come to this conclusion? Why should it influence ioctls?

Because these ioctls will, ultimately, write to the card again? If the X
server actually messes with the PCI bridges, the card might no longer be
mapped?
I admit that I understand next to nothing about PCI, or how the X server
uses PCI. Makes it a bit harder to spot the flaky code :-)

Anyway, the X server appears to complete screen init OK but I never
actually get to see the cross hatch pattern.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
