Date: Thu, 19 Jul 2001 18:34:15 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: "Joseph P. Garcia" <jpgarcia@execpc.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: powermac (other ppc?) events
In-Reply-To: <20010719092810.2a0d07f8.jpgarcia@execpc.com>
Message-ID: <Pine.LNX.4.33.0107191746230.15656-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > > - we *can* extend the normal keyboard to generate some if not all of these events
> [snip]
> > Pass that by me once again. If we merge any special key events with the
> [snip]
> > (ioctl) which event device a particular event is routed to?
>
> This is where a decision appears.  Any action that is handled as a
> custom event, we have every freedom to sit and watch our new device
> with a daemon.  But we decide an event is a key, it becomes part of
> the keyboard.  The stream of keyboard events IMO should pass right
> from kernel space into whatever program the user is running.  ie, we
> do not have the same freedom to sit and watch it.  Am I correct in
> this?

You tell me, please. I was wondering about this all the time. OTOH having
the whole keyboard input exposed to a zoo of daemons might be a Bad Thing
anyway.

> kinda sorta a kpmud, with the userspace pmud do nothing but sleep;
> kinda as the kernel space's bottom half to pmu events.  how long
> before pmud's socket is phased out?  (i should update gkrellm-pmu...
> if anyone uses it over apm)

pmud's socket is not related to the way pmud receives power status
information (event based or otherwise). And I don't think keeping it
around for the forseeable future is bad (2.2 kernels, anyone?).

There's not much in the way of a kpmud now, nor is there any need that I
can see. Blocking pmud in a special purpose syscall isn't any better or
worse than polling /dev/pmu.

> I'm still not a fan of a nursery of little daemons...  But with
> properly blocking io, they're sleeping most of the time, so my
> objection is more about memory space and redundancy of code.

The 'nursery of little daemons' was an extreme, much the same as the
'monolithic bloat daemon' is. With 2.2 kernels still in use for a while,
and the event interface for power or special button events still undefined
I'd rather implement the new features in a new (set of) daemon(s) and not
break pmud's backwards compatibility. The new event daemon(s) need not be
concerned about compatibility, making them cleaner to code.

> moreover, do we want to address a better sound interface now, or
> should I just get to actual coding?

We can address it now but the sound interface is unrelated to our event
processing, except for it eventually being called from some event daemon.
Let's treat them as separate issues. The sound interface need not
know any details of the event interface that's used to control it. Again,
hopefully cleaner code.

Does this make sense? Am I preaching to the choir? Without a CS degree I
fail to see the benefits of directly intermingling the various parts
involved here ...

	Michael

(trimming the CC list as all parties concerned are subscribed anyway)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
