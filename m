Message-ID: <388C8CEE.F652AFAD@Ferrari.DE>
Date: Mon, 24 Jan 2000 18:33:34 +0100
From: Rolf Fiedler <Rolf.Fiedler@Ferrari.DE>
Reply-To: Rolf.Fiedler@Ferrari.DE
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: debugging a PPC405GP target
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



Jesper,

> I didn't make myself clear, sorry: when you use gdbserver you have a
> "stub" which knows about the context in which the application runs
> (the Linux operating system). You can (potentially) show thread
> information, environment variables and the like [gdbserver doesn't
> have thread support at the moment].
>
> It's hard to get the same functionality from the wiggler (because it
> only knows about the CPU state). But then it has other advantages as
> you say.
Since it is getting complicated, I start drawing pictures...

<require fixed width font>
1. traditional approach using monitor or gdb server


    +-------------------+             +----------------+
    |    host CPU       | serial or   |  Target running|
    | running cross-gdb |-------------|  gdb-server    |
    +-------------------+ thernet     +----------------+

gdbserver can store some [env, thread etc.] information, since it
runs on the target

2. simple CPU control debugging


    +--------------------+               +----------------+
    |      host CPU      | bdm, ice or   | target running |
    | running gdb and    |---------------|    nothing     |
    | device driver for  | jtag          |                |
    | wiggler            |               |                |
    +--------------------+               +----------------+

if the gdb remote stub implementing the ICE interface is implemented
smart enough, gdb has access to environement, thread etc. since it
can read any memory location in the target-system. This is not
possible, if the target runs an OS an has MMU protection for
processes, since it is hard for the debugger to figure out which
physical addresses contain the information required.

Theorem: Since the ICE link provides total control of the target CPU,
it allows to read any state in the target.
The wiggler does only toggle bits on the JTAG port, but the pen
(software) is mightier than the sword (soldering iron).

3. gdbserver on ICE

    +--------------------+               +----------------+
    |      host CPU      | bdm, ice or   | target running |
    | running gdb and    |---------------|    nothing     |
    | a gdbserver via    | jtag          |                |
    | local tcp link     |               |                |
    +--------------------+               +----------------+

same scenario as above, however no need to modify gdb, just gdbserver
must be modifed.

</require fixed width font>

> There's nothing preventing you from implementing use of hardware
> watchpoints and breakpoints in gdbserver. Would probably require some
> kernel features to be added as well. But those debugging features are
> part of the CPU, not the wiggler hardware.
you are right.
I know that the wiggler doesn't do anything but wiggle bits, however I
need access to the CPU via JTAG to use the internal debug registers like
address & data breakpoints. If I have this link, I do not need any
further links. If I was mentally insane, I could implement tcp/ip
via JTAG (write packets directly to RAM and poll memory locations)
and run gdbserver on target via this link.

the question is: what advantage does solution 3. (above) have compared
with solution 2.?

> As anything else OS, it's just a question of someone getting fed up
> with the current state of affairs and implement the new stuff, making
> the world a better place :)
I want to hack the minimal possible amount of code, I have no interest
in
making the world a better place. Since I learned that solution #2 exists
for MPC8xx, I wondered if somebody could help me change that for
PPC405GP.
The JTAG chain and commands will propably be different. I need docu for
that
part of the PPC405, and unlike Motorola IBM did not include sufficent
info
in the datasheets of the chip (will they ever learn what open is about
or
are they just making up some linux marketing hype?).

Thank you Jesper,
Rolf


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
