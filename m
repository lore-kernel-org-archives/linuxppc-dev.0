Date: Sat, 9 Mar 2002 12:25:56 -0600
From: "Joseph P. Garcia" <jpgarcia@execpc.com>
To: joker@cymes.de
Cc: linuxppc-dev@lists.linuxppc.org,
	Tuomas Kuosmanen <tigert@ximian.com>
Subject: Re: pbbuttons, need some help
Message-Id: <20020309122556.62a281a6.jpgarcia@execpc.com>
In-Reply-To: <1015685023.2150.86.camel@quicksilver>
References: <3C852E12.3030300@cymes.de>
	<20020306090814.15511@mailhost.mipsys.com>
	<3C87B6C8.9070905@cymes.de>
	<20020307134140.56d70400.jpgarcia@execpc.com>
	<1015685023.2150.86.camel@quicksilver>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Greetings.

On 09 Mar 2002 16:43:42 +0200
Tuomas Kuosmanen <tigert@ximian.com> wrote:
> Now, I dont know if this is a problem or not but please note that the
....
> if one monitors for X keyboard stuff. Which is rather annoying.

The way I'm suggesting it work is similar to how it does currently, with
one exception.  It would still have a system service (not run as a user) to
listen to the key events and control the hardware.  This maintains that
they keys would work under any environment.  The proposal would also
maintain that the GUI part does nothing but display what happened to tell
the user and nothing more.  That lets the user know what happening or not
on their own choice, and with their own process.

The difference is that rather than the GUI feedback screen using the daemon
to find the event (which thus requires the daemon), it can be triggered off
of the X keyboard events, like Bastien's Acme.  As the button device is
just an additional set of the keyboard keys, the kernel sends an event just
as such.  All keyboard events manifest in the event interface, and, if
linux keycodes are enabled, whereever the system gets its keys as well.
(since all keyboards are also events, this is why /dev/input/event* should
not be world-readable)  This also includes that X gets the key event, and
normally does nothing with it.  X has provisions to associate those keys to
a particular process (or something.  i don't really know) and more or less
have that process sit idle until such an key is pressed.

The point?  Having X handle the event is just like using /proc/pmu/.  It
should work on any system that supports it, regardless of actual hardware.
(i'd like the volume handled generically by the gui too, as it could be...
but people seem against that.  There's always Acme for us types)

However, as Ben pointed out, O'Hare doesn't generate these events yet.  But
I suppose those should go into userspace as well, if possible.  I can help
with that.  (is that an adb mess or a pmu mess?)

Sorry about the lecture.  there just seems to be some misconception of what
I'm proposing.

--
Joseph P. Garcia    http://www.lycestra.com/    http://lidar.ssec.wisc.edu/
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
