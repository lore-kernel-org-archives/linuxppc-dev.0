From: "Oliver Oppitz" <o.oppitz@web.de>
To: "Albert Cahalan" <albert@users.sourceforge.net>,
	<oprofile-list@lists.sourceforge.net>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: AW: porting oprofile to ppc
Date: Tue, 4 Mar 2003 17:36:15 +0100
Message-ID: <CGEEJPDDNJPLIOFJDCMDKEEFCBAA.o.oppitz@web.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1046474835.1090.303.camel@cube>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have been playing around a bit with performance counters  on an MPC7441
(eMac), even found an undocumented "issue" with the "retired instructions"
counter: the value is erroneously incremented by interrupts (+1 for each
time entering/leaving the interrupt handler), even though it was set up for
counting only user-mode instructions. I did these tests via some hijacked
system call (vm86), that I adapted to read/write the SPRs. Is no good style,
but works for my purposes.

In any case, I would like to offer my help with the porting project. Maybe
testing for a beginning, as I need to learn something about kernel modules
before being of any help with that...

Regards, Oliver

-----Ursprüngliche Nachricht-----
Von: owner-linuxppc-dev@lists.linuxppc.org
[mailto:owner-linuxppc-dev@lists.linuxppc.org]Im Auftrag von Albert
Cahalan
Gesendet: Samstag, 1. März 2003 00:27
An: oprofile-list@lists.sourceforge.net
Cc: linuxppc-dev@lists.linuxppc.org
Betreff: porting oprofile to ppc



I'm considering a port to the MPC7400 ("G4") PowerPC.
This is out of desperation, since there isn't anything
beyond gprof available for Linux/ppc users.

I could use some advice. Where do I even start?
Anybody else doing this or interested in helping?

I run both 2.4.xx and 2.5.xx kernels, compiled from
source. Neither one has any performance monitoring
hooks ready to use. I could add them. What is needed?

I notice that RTC support conflicts with the /dev/rtc
driver. Couldn't it use the driver? Sometimes the RTC
is available via memory-mapped IO, and sometimes the
RTC is emulated by the /dev/rtc driver. Even on x86 you
need the /dev/rtc driver to safely set the clock with SMP.

I'm not a Qt fan. Can I avoid it? All my stuff is GNOME,
plain X11, or non-GUI. Somehow libqt.so.2.3.1 did get
installed though.

On the 7xx and 74xx chips, I get a user-readable 64-bit
counter that ticks at 1/16 of the memory bus clock. So on
my 450 MHz Mac with a 100 MHz bus, it ticks at 6.25 MHz.
There's also a privileged 32-bit count-down register that
gives an interrupt. There isn't a CPU core cycle counter,
unless you have a 7400 (or above?) and are willing to
devote a performance counter to that purpose.

The 7400 chip additionally gives me a set of performance
monitoring registers, with read-only access from user code.
There are four counters, PMC1 to PMC4, and control registers.
I can freeze the counters in kernel mode, in user mode,
and according to a flag that may be used to mark a process.

There's a threshold value for some of the performance
counters, taking on values from 0..63 times 2 or 32.
(0,2,4,...,124,126,128,160,192,...,1952,1984,2016)
So for example, I could count loads that stall for more
than 1952 ticks.

I can enable counters PMC2..PMC4 when PMC1 goes negative.
I can freeze all the counters (or cause an interrupt)
when one of PMC2...PMC4 goes negative.

There are ways for external hardware to mask counting or
interrupt generation. I'm not about to solder a button
onto my CPU for this, but I guess it should be supported.

All four counters can count:

core cycles
completed instructions, excluding folded branches
memory cycles divided by 32, 8k, 128k, or 2M
instructions dispatched (0, 1, or 2 per core cycle)

Then of course each register has a selection of other
choices. Of interest:

instruction breakpoint matches, with a bit mask
(could be abused to count system calls or interrupts)
various cache things, loads, stores, etc.

There must be 60 to 240 choices, depending on how one
counts duplicates.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
