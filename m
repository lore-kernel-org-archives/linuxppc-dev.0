Date: Wed, 27 Sep 2000 22:50:23 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Jon Erick Ween <jween@som.llu.edu>, linuxppc-dev@lists.linuxppc.org,
        linux-fbdev@vuser.vu.union.edu
Subject: Re: Xfree86-4.0.1, Lombard, Mach64 driver, X-server Crash
In-Reply-To: <19340822140700.24207@192.168.1.10>
Message-ID: <Pine.LNX.3.96LJ1.1b7.1000927214454.666I-100000@ofey.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 27 Sep 2000, Benjamin Herrenschmidt wrote:

> >Here's a copy of my XF86Config file.
> >
> >Two other minor nuisances:
> >
> >Since using yaboot, my console cursor has disappeared. Is this an OF or a
> >yaboot problem? It's very hard to navigate in vi to edit anything (.config
> >files for one thing) without a cursor!
>
> Completely ? Or does it appear with different colors depending on the VC
> you are on ? I've seen such bug appear here or there but never took the
> time to track it down...
>
> I suspect an atyfb problem ;)

I think this is more of a generic fb device layer problem or a combination
of driver bug and upper layer bug.  Or I totally don't understand how
fbcon works.

My understanding is this:
Video console uses 16 colors, and it only initializes the cmap
corresponding to those 16 colors.  The other entries in cmap are up to
each individual fb driver or undefined as far as console is concerned.
For software cursor, driver specific (struct display_switch *)ops->revc()
is used to make the cursor blink.  For the generic fbcon_cfb{16,32}_revc,
it xors each pixel with masks 0xffff (depth 16) or 0xffffffff (depth 32).
For controlfb which I am very familiar with, the "correct" masks are
0x3def for 555 and 0x0f0f0f0f for 8888.  That is, only 4 LSBs or low 16
for each red, green, and blue are xor'ed since cmap entries corresponding
to higher bits are undefined as far as fbcon support is concerned.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
