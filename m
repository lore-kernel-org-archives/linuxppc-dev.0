Date: Fri, 14 Mar 2003 15:37:20 -0600
Mime-Version: 1.0 (Apple Message framework v551)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: PowerPC Performance Interrupt
From: Andrew Fleming <afleming@motorola.com>
To: oprofile-list@lists.sourceforge.net,
	linuxppc-dev@lists.linuxppc.org
Message-Id: <227DFA1D-5665-11D7-8667-000393C30512@motorola.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I think I have a better idea of how oprofile works on ia64 and x86
architectures, now.  In ia64, oprofile grabs the performance monitor
interrupt using request_irq().  In x86, it makes use of the nmi.  I'm
pretty sure that these two solutions are unavailable for PowerPC.  If
I'm wrong, please tell me.

So, it seems to me that in PowerPC, we need to get the
already-installed PerfMon exception handler to call into oprofile.
But, in order to make it so other profiling systems could be used
without further modifying and recompiling the kernel, it seems to me
that there needs to be some way to register to receive the PerfMon
interrupts.

One way would be to have a register function which functions much like
request_irq, but specific to performance monitors.  Functionality could
be provided to lock out others from taking control of the counters,
though there would need to be a way to override the lock (in the event
that the controlling app died).  This would allow oprofile to get
called on interrupt.

Another method would be to register the pid of a control app (perhaps
in /proc), and then have the PerfMon interrupt send a SIG_PROF to
whichever app was registered.  I'm not sure what the consequences are
of there being an interrupt after the monitoring program dies.  Does a
sent signal with a bad destination cause problems?  Anyway, this, too,
should allow oprofile to be informed of the interrupt, though
presumably with higher overhead.

Any thoughts?

Right now, the interrupt is just unhandled.

Andy Fleming


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
