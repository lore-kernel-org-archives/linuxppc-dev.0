To: Rolf.Fiedler@Ferrari.DE
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: debugging a PPC405GP target
References: <388C1704.5F4E270C@Ferrari.DE> <otemb7u83n.fsf@thinktwice.zoftcorp.dk> <388C220F.F3669689@Ferrari.DE>
From: Jesper Skov <jskov@cygnus.co.uk>
Date: 24 Jan 2000 11:42:00 +0100
In-Reply-To: Rolf Fiedler's message of "Mon, 24 Jan 2000 10:57:35 +0100"
Message-ID: <otya9fsqdj.fsf@thinktwice.zoftcorp.dk>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>>>>> "Rolf" == Rolf Fiedler <Rolf.Fiedler@Ferrari.DE> writes:

Rolf> this is plain wrong. I do not have to use gdbserver, gdbserver
Rolf> is just one possiblity. How can I use the hardware breakpoints
Rolf> in the debug-hardware on the target or have breakpoints in ROM
Rolf> when I use a low-tech debug approach like gdbserver?

I didn't make myself clear, sorry: when you use gdbserver you have a
"stub" which knows about the context in which the application runs
(the Linux operating system). You can (potentially) show thread
information, environment variables and the like [gdbserver doesn't
have thread support at the moment].

It's hard to get the same functionality from the wiggler (because it
only knows about the CPU state). But then it has other advantages as
you say.

>> You may be able to make the wiggler work as a regular serial
>> connection, but I don't see what you gain by that over using a
>> standard ethernet/serial connection (except if the only interface
>> on the board is the wiggler one).
Rolf> It would be not very smart to reduce the wiggler to a regular
Rolf> serial connection, since I have more features then I can address
Rolf> with the gdb remote protocol. The advantages are: - no software
Rolf> on the target (bootstrapping) - use of 4 hw address and 2 hw
Rolf> data breakpoints (try to use a watchpoint with gdbserver and
Rolf> you'll learn what performance really means :-)

There's nothing preventing you from implementing use of hardware
watchpoints and breakpoints in gdbserver. Would probably require some
kernel features to be added as well. But those debugging features are
part of the CPU, not the wiggler hardware.

As anything else OS, it's just a question of someone getting fed up
with the current state of affairs and implement the new stuff, making
the world a better place :)

Jesper

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
