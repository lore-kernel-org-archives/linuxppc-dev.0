Date: Wed, 18 Jul 2001 16:54:48 -0500
From: "Joseph P. Garcia" <jpgarcia@execpc.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: schmitz@opal.biophys.uni-duesseldorf.de, iain@sandoe.co.uk,
	benh@kernel.crashing.org, linuxppc-dev@lists.linuxppc.org
Subject: powermac (other ppc?) events
Message-Id: <20010718165448.4d7a879b.jpgarcia@execpc.com>
In-Reply-To: <3B55FB76.8080909@hadess.net>
References: <Pine.LNX.4.33.0107182204380.2441-100000@opal.biophys.uni-duesseldorf.de>
	<3B55FB76.8080909@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ok.  here's what I gather:

- Buttons exist for brightness, volume, and now eject on the normal powermac keyboard.
- we also have other events we may consider to add, such as headphone insert, lid close(polled?), power key, and pmu-change (interrupt on nw)
- popular opinion is that to reduce kernel bloat, assocated reactions should be handled outside of kernel space.
- to get them out of kernel space, we should use events. (polling sucks)
- we *can* extend the normal keyboard to generate some if not all of these events
- we can also create a new event device using the very same interface (afaik)
   - this route is only appealing if we dont want/like the preconceptions of using keyboard events.
- those handled as an actual key should be handled by user programs.  prehandling the keyboard in userspace is messy (extending shells, window managers, etc.  redundant code)
- those handled as an event device of our creation will need a userspace daemon.

These are what I percieve as the facts.  Corrections welcome.

Once those are clarified, we should choose which events should be keys and which should be a powermac-daemon (i dont know if that's a PC name) handled event.  I hate to start a debate, but it should also be decided what in this daemon should be static, and what should be user-configurable.  It might be nice to keep unique concepts to different daemons, but maybe it would be better to have our new event device have a set of feature bits, and the daemon can be kept clean so the unused features only makes things a little bigger, but not slower.  Open to some debate, but which is more bloated, many interfaces with many daemons, or one daemon with no redundant code?  if its a fast/clean ship...

Consider the fact that there are probably other archetectures which could use this, and it is highly likely that this implementation will be expanded as hardware gets even weirder.

I figured we need a plan at this, since as programmers, interfaces tend not to be our strong suit IMHO.

I'm willing to help with coding, since I kinda started this thread.  The occational punching bag if need be.

--
Joseph P. Garcia
http://www.execpc.com/~jpgarcia

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
