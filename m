Content-Type: text/plain;
  charset="us-ascii"
From: Oliver Oppitz <o.oppitz@web.de>
Reply-To: o.oppitz@web.de
To: "linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Date: Sat, 25 Jan 2003 19:41:32 +0100
MIME-Version: 1.0
Subject: Performance Counters on PPC
Message-Id: <200301251941.32262.o.oppitz@web.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dear *,

I have a question on G4 (MPC 74xx) performance counters. I have some PPC
assembly experience and started digging into the Linux kernel recently, but
do not own a PPC box for experiments - yet.

I would like to implement something like a deterministic scheduler, that
schedules threads identically in multiple program executions (useful for
debugging multithreaded code). For this I want to count the number of retired
instructions at each task switch (during the first program execution).  In
following executions I would use the performance monitoring interrupt to
generate an interrupt after the same number of retired instructions and force
a task switch.

Are the counters on PPC are accurate enough for this task? Does instr_retired
counter give identical values in multiple program runs (assuming there is no
input an no system calls)?

I am aware (from the PPC user manual), that reading the counters needs
serialization instructions etc. for deterministic results (due to
out-of-order execution). In my case I would count the _user_ mode
instructions and read only in _supervisor_ mode (in the interrupt handler).
So serialization should not be an issue, as all user mode instructions should
have left the pipeline long ago, when my supervisor code reads the counter
value.

I am also aware that the instr_retired events do not include folded branches.
Is it correct that the number of actually folded branches depends on branch
prediction? If so, I think this would make the count during multiple
executions non-deterministic as interrupts would affect the branch prediction
buffers. In that case I would disable branch folding - which to my knowledge
is only possible in the G4.

I evaluated some x86 hardware (PIII) and found that its performance counters
are totally inadequate for my task (e.g. it does not count REP STOSB
sequences at all). That's why I want to switch to PPC for this research
project.

I am grateful for any help on the issue.

Regards, Oliver


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
