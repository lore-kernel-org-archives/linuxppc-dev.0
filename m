Date: Tue, 2 May 2000 22:20:28 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Gabriel Ricard <g_ricard@yahoo.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Lombard hard freeze (still there)
In-Reply-To: <20000502191317.779.qmail@web1704.mail.yahoo.com>
Message-ID: <Pine.LNX.4.10.10005022156240.13541-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I am wondering if any of the developers who do kernel
> related work on LinuxPPC have any suggestions for us
> on how to deal with this. If I knew how to do the
> debugging work and trace the problem to its root I
> would.

It's a bit tough to debug kernel stuff on a machine like the Lombard if it
has no serial port to attach a console terminal or even a kernel debugger
to. It's even harder to remote debug such a machine over a mailing list
:-)

There's a few things that can be tried though. You can use the modem port
as serial console if you hook it up to another modem, and make the two
modems connect (ata on the one, atd on the other). On the Lombard,
console=ttyS0 in the kernel options at boot plus actually initiating the
connection from a shell with cu or minicom is all it takes for that. Once
the kernel is logging to the modem port, try to force a freeze and check
for messages on the connected system. If I remember right, xmon will
accept input via the serial console port in this situation so you can go
aboout poking around after a panic threw you into xmon. I'm not familiar
with xmon, but the modem-connected serial console helped me track down the
XFree 4.0 Mach64 problems just by looking at the panic logs.
If the kernel just hangs without producing any panic messages, this method
won't work though.

A maybe more sophisticated way to debug in that case would be to use kgdb
instead of xmon, and enter the kernel-side debugger stub when the system
appears frozen. This requires the remote machine to run gdb with support
for the PPC binfmt, as well as working serial interrupts on the machine
being debugged. If the kernel just deadlocked somewhere with interrupts
still enabled, this should work (but so should timeouts, keyboard and the
like). Otherwise, you're out of luck. I should add that I haven't been
forced to resort to kgdb so far ...

I haven't seen the result of one of the suggestions here to stay in the
text consoles instead of X. This experiment should tell about the state of
interrupts when the system freezes. One thing I notices that makes the
Lombard in question different from mine (which hasn't frozen on me in
ages despite extensive number crunching and compiling) is that it's got a
lot more RAM (64M here only) and a bigger disk (6GB here). Both combined
might account for higher power consumption, higher heat dissipation, you
name it. Batmon should tell just how much more power is drawn by that
configuration.

Just a few ideas. From the problem descriptions, I have no idea what part
of kernel or hardware to blame. The kernel needs to get caught in the act
now ...

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
