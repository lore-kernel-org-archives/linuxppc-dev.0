From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [patch] ignore trackpad/mouse while typing
Date: Mon, 27 Jan 2003 22:49:24 +0100
Cc: Vojtech Pavlik <vojtech@suse.cz>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Till Straumann <Till.Straumann@TU-Berlin.de>,
	linuxppc-dev@lists.linuxppc.org, George Staikos <staikos@kde.org>
References: <3DE6C428.5000403@TU-Berlin.de> <200301272016.25024@enzo.bigblue.local> <20030127202508.A23905@ucw.cz>
In-Reply-To: <20030127202508.A23905@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200301272249.24491@enzo.bigblue.local>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Monday 27 January 2003 20:25, Vojtech Pavlik wrote:
> On Mon, Jan 27, 2003 at 08:16:24PM +0100, Franz Sirl wrote:
> > Hmm, this reminds me of one feature I would need in the input core to
> > support 1-button mices in userspace (or at least in a totally
> > self-contained module), namely the ability to register "filters" that are
> > called early in input_event() and where a return value !=0 lets it return
> > immediately from input_event() without processing the event.
> >
> > Eg. something along these lines:
> >
> > 	ret = 0;
> >         list_for_each_entry(filter, &dev->f_list, d_node)
> >                 if (filter->open)
> >                         ret |= filter->handler->event(handle, type, code,
> > value);
> > 	if (ret) return;
> >
> > Comments?
>
> I don't think I want this. This *can* be solved completely in userspace,
> the only problem would be that the interface to the userspace program
> doing it wouldn't be the same as to evdev.c, and that the kernel *dev.c
> modules could not bind to do it.
>
> For mice, there is no problem - the mouse protocol can be implemented
> over a bidirectional pipe.
>
> For making another evdev device, you can use uinput.

Coding a uinput solution brought up this request. Basically there are 2
methods to support 1-button mice:

1. remap 2 keys on the keyboard to middle and right button
2. remap the left mouse button with SHIFT/CTRL/ALT/etc

Currently theres the ugly hack that does 1. in the kernel. Now, just for ease
of explanation, lets go with a "clean" kernel module. So I register the
module as a handler for keyboard and 1-button mice events and additionally
register it as mouse input device. For case 1. I remapped F11 and F12 to
middle and right mouse button, I see a F11, and submit a "middle mouse
button" event. All nice so far, but how do I prevent F11 and F12 reaching
other handlers in the list and potentially confusing the applications? If I
implement case 2. the problem is essentially the same, except that I have to
prevent the "left mouse button" event to reach other handlers.

If I do it in userspace via uinput the underlying problem remains the
same.

Do you have better ideas to solve that in a clean and generic way besides my
"filter idea"?

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
