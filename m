Date: Sun, 26 Jan 2003 10:59:46 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Till Straumann <till.straumann@tu-berlin.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Vojtech Pavlik <vojtech@suse.cz>, linuxppc-dev@lists.linuxppc.org,
	George Staikos <staikos@kde.org>
Subject: Re: [patch] ignore trackpad/mouse while typing
Message-ID: <20030126105946.A20546@ucw.cz>
References: <1043529955.3683.41.camel@zion.wanadoo.fr> <71575D98-308F-11D7-9BDB-0003934F7CE4@tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <71575D98-308F-11D7-9BDB-0003934F7CE4@tu-berlin.de>; from till.straumann@tu-berlin.de on Sat, Jan 25, 2003 at 07:04:27PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Jan 25, 2003 at 07:04:27PM +0100, Till Straumann wrote:
> Hi.
>
> Thanks for your feedback. Please let me work on this a little more.
> The first version of the patch has 2 flaws:
>
>    - emulated mouse buttons are treated as normal key events and
>      are hence suppressed (that's already fixed but introduces a very
>      ugly dependency on the mac-hid driver).
>   - the same applies to modifier keys. Unfortunately, we need a list
>     of these keys (and there is obviously no way to know what keys
>     are 'modifiers' for a specific application program (such as X)).
>
> Unfortunately, I still see the kernel as the proper place to handle this
> (feature shared by all applications; 'semi-real time' nature of the
> feature.
> 'input' is the place where mouse and key events come together.)

You convinced me that this probably needs to be in the kernel - though
the real-time nature of it is not a good argument - we have timestamps
in the events, and thus we could sort it out in the userspace quite as
well.

But still for ease of use, so that applications see the already
processed events, it makes sense to have it in kernel.

But still I think the proper place for it (and the emulated mouse
buttons from mac-hid) is mousedev.c. At this moment it doesn't receive
keyboard events, but it trivially could. Then you'll have all the info
you need there.

Then you won't need to filter emulated/real keystrokes, since you'd
generate the emulated ones in the same source file.

/dev/input/evdev devices will still offer unprocessed events, though.

This means:

	1) For existing applications we get the needed functionality.
	   (Emulated buttons, ignoring events from mouse when keyboard
	    is in use, ...)

	2) For applications that will be ported to use the event
	   interface, they'll need to implement the emulated buttons
	   and filtering themselves. This also makes sense. X already
	   emulates the middle button for 2-button mice anyway.

> Then, there is one more problem: I had a disk-crash and I have to wait
> for my new disk before I can continue working (or even look at the code).

Aww, poor you. Hope you'll recover your computer soon.

> :-(
>
> Regards
> -- Till
>
> PS: I added a few comments to the discussion below
>
> On Saturday, January 25, 2003, at 10:25 , Benjamin Herrenschmidt wrote:
>
> > On Sat, 2003-01-25 at 22:04, Vojtech Pavlik wrote:
> >
> >>>> Well... the problem happpens in console as well, and with other
> >>>> non-X apps like MacOnLinux. Some Apple PowerBooks have over-sensitive
> >>>> trackpad. Apple themselves implement a similar mecanism in the kernel
> >>>> driver of OS X.
>
> I agree.
>
> >>>
> >>>   Mine is one of those machines.  I have to turn off gpm for sure,
> >>> and X is
> >>> quite oversensitive too (tuned it in KDE, but still this
> >>> functionality would
> >>> be very nice).
> >>
> >> How about implementing it in mousedev.c?
> >
> > Right, though it would need hooks in kbddev or something to know
> > about keystrokes.
>
> Yeah - that's why I put it into 'input' - that's the only piece of code
> who knows about both, key and mouse events. BTW: I put the control
> file into /proc/sys../input and not mac-hid because the feature is not
> limited to macs.
>
> > Also, I don't like the sysctl's as those need
> > allocating sysctl numbers,
>
> Unfortunately, the list of 'modifier' keys needs to be configurable as
> well.
> How can we do that without sysctl?
>
> > which are always a problem. In 2.5,
> > we could have these in sysfs, though for 2.4 I'm not sure what
> > to do.
> >
> > Ben.
> >
> >

--
Vojtech Pavlik
SuSE Labs

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
