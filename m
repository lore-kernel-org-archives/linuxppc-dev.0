Date: Thu, 19 Jul 2001 09:28:10 -0500
From: "Joseph P. Garcia" <jpgarcia@execpc.com>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: hadess@hadess.net, iain@sandoe.co.uk, benh@kernel.crashing.org,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: powermac (other ppc?) events
Message-Id: <20010719092810.2a0d07f8.jpgarcia@execpc.com>
In-Reply-To: <Pine.LNX.4.33.0107191242330.2295-100000@opal.biophys.uni-duesseldorf.de>
References: <20010718165448.4d7a879b.jpgarcia@execpc.com>
	<Pine.LNX.4.33.0107191242330.2295-100000@opal.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 19 Jul 2001 13:20:28 +0200 (CEST)
Michael Schmitz <schmitz@mail.biophys.uni-duesseldorf.de> wrote:

> > - we *can* extend the normal keyboard to generate some if not all of these events
[snip]
> Pass that by me once again. If we merge any special key events with the
[snip]
> (ioctl) which event device a particular event is routed to?

This is where a decision appears.  Any action that is handled as a custom event, we have every freedom to sit and watch our new device with a daemon.  But we decide an event is a key, it becomes part of the keyboard.  The stream of keyboard events IMO should pass right from kernel space into whatever program the user is running.  ie, we do not have the same freedom to sit and watch it.  Am I correct in this?

This is less a problem if the keyboard's events can be filtered. (tell the kernel we are only waiting for a specific keys)  I can't remember if NIL supports that on a per-client basis.  If it can, then i guess its fine to doggy-watch the keyboard...

Looking at this now, it would seem my preconception of keyboard preconceptions are less of a problem if that one feature exists on the keyboard...

> Reiterating my previous position: we have a working solution for power
[snip]
> how I understand the current (hardware) situation.

kinda sorta a kpmud, with the userspace pmud do nothing but sleep; kinda as the kernel space's bottom half to pmu events.  how long before pmud's socket is phased out?  (i should update gkrellm-pmu... if anyone uses it over apm)

> For other events caused by the special keys on a Powerbook keyboard: it
[snip]
> screen display for brightness or sound). Start only those you feel you
> need.

I'm still not a fan of a nursery of little daemons...  But with properly blocking io, they're sleeping most of the time, so my objection is more about memory space and redundancy of code.

> Brightness and volume I'd say hardwired, additional feature keys user
> configurable.
[snip]
> On these architectures, sound and brightness control keys would need to be
> user configurable. Taken together with above, defaults for volume and
> brightness on PowerPC but leaving these open for configuration.

Ok.  sounds good.  Now, with the dual-out volume on most systems, the sound-out plug event would be nice to have here...  But that's in dmasound, isn't it.. ergh.  Since we dont want to force a linkage there, does this mean macos-like handling in kernelspace that can be disabled, thus appending a SPKR mixer control?  Would this work, Iain?

moreover, do we want to address a better sound interface now, or should I just get to actual coding?

--
Joseph P. Garcia
http://www.execpc.com/~jpgarcia

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
