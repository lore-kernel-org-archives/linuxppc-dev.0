Date: Thu, 19 Jul 2001 13:20:28 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: "Joseph P. Garcia" <jpgarcia@execpc.com>
Cc: Bastien Nocera <hadess@hadess.net>, <iain@sandoe.co.uk>,
	<benh@kernel.crashing.org>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: powermac (other ppc?) events
In-Reply-To: <20010718165448.4d7a879b.jpgarcia@execpc.com>
Message-ID: <Pine.LNX.4.33.0107191242330.2295-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> - we also have other events we may consider to add, such as headphone insert, lid close(polled?), power key, and pmu-change (interrupt on nw)

These are not currently handled by the input driver, and not being inputs
(in the sense 'the user just pressed a key, moved a pointing device or
thought real hard about something and our telekinetic sensor picked it
up' per se I'd suggest to leave them out.

> - we *can* extend the normal keyboard to generate some if not all of these events

We need to, in order to have additional keys feed their events into the
input stream.

> - those handled as an actual key should be handled by user programs.  prehandling the keyboard in userspace is messy (extending shells, window managers, etc.  redundant code)
> - those handled as an event device of our creation will need a userspace daemon.

Pass that by me once again. If we merge any special key events with the
regular keys we'd need to read the whole key event stream and wait for a
particular one to show up, or can we specifically wait for a particular
key event?

If we decide on separate event devices, can we configure at run time
(ioctl) which event device a particular event is routed to?

> Once those are clarified, we should choose which events should be keys
> and which should be a powermac-daemon (i dont know if that's a PC

No, it's a PPC name :-) More Power to us.

Reiterating my previous position: we have a working solution for power
management, leave it out of such a powermac-daemon. In what way pmud picks
up power related 'events' is another issue (I'd opt for a dedicated event
device here). Currently these events aren't, there's a constant stream of
power status messages from /dev/pmu. Older Powerbooks don't even support
generation of events on power status changes, you'd have to run a state
machine in the PMU driver that keeps track of past state. At least that's
how I understand the current (hardware) situation.

For other events caused by the special keys on a Powerbook keyboard: it
doesn't matter much (to me) whether we pick a powerbook event daemon, or
have a sound event daemon plus a backlight control daemon plus some more
key gizmo daemons instead (if that's indeed possible, i.e. if all these
gizmo daemons can share a single event stream). They all live off keyboard
events some way or other anyway.

In order to keep the daemons simple they should be separate, maybe
(especially if you want code plugged in that would pop up a little on
screen display for brightness or sound). Start only those you feel you
need.

> name) handled event.  I hate to start a debate, but it should also be
> decided what in this daemon should be static, and what should be
> user-configurable.  It might be nice to keep unique concepts to

Brightness and volume I'd say hardwired, additional feature keys user
configurable.

> Consider the fact that there are probably other archetectures which
> could use this, and it is highly likely that this implementation will
> be expanded as hardware gets even weirder.

On these architectures, sound and brightness control keys would need to be
user configurable. Taken together with above, defaults for volume and
brightness on PowerPC but leaving these open for configuration.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
