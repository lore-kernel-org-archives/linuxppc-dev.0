From: Joe Green <jgreen@mvista.com>
To: diekema@bucks.si.com (diekema_jon), linuxppc-embedded@lists.linuxppc.org
Subject: Re: Wait Queue bug triggered on EST SBC8260
Date: Wed, 24 May 2000 13:29:45 -0700
Content-Type: text/plain
Cc: all@cideas.com
References: <m12uhYO-001SyaC@bucks>
In-Reply-To: <m12uhYO-001SyaC@bucks>
MIME-Version: 1.0
Message-Id: <0005241332450C.07271@minotaur.mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I should also point out that the real-time scheduler primarily changes
the responsiveness of processes and threads that are scheduled with
real-time priorities.  Non-realtime threads are handled by the standard
scheduler algorithm, so if there's a bug in there it may very well
still be present with the real-time scheduler, unless it was something
we caught in our testing.

On Wed, 24 May 2000, diekema_jon wrote:
> Previous message:
>
> http://lists.linuxppc.org/listarcs/linuxppc-embedded/200005/msg00180.html
>
> > bad magic 0 (should be c01fb2e0, creator 0), wq bug, forcing oops.
> > kernel BUG at sched.c:656!
> > NIP: C000FB5C XER: 00000000 LR: C000FB5C REGS: c01adc00 TRAP: 0700
> > MSR: 00081032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
> > TASK = c01ac000[1] 'init' Last syscall: 6
> > last math 00000000 last altivec 00000000
> > GPR00: C000FB5C C01ADCB0 C01AC000 0000001B 00001032 C010EF80 C01FB260 C0128502
> > GPR08: 0000001B C0110000 F00000B8 C01ADBF0 24444028 1001EEB4 00000000 00000000
> > GPR16: 00000000 00000000 00000000 00000000 00009032 C01DA060 00000000 00000000
> > GPR24: 00000021 00000001 C01DA060 C010A3E0 C0125000 C0110000 C01FB2D4 C01ADCB0
> > Call backtrace:
> > C000FB5C C008CB8C C007F560 C007FE8C C0033CE4 C0033D80 C0032818
> > C00328CC C00328FC C00048F0 10005548 10005A20 0FF09E78 00000000
> > Kernel panic: Exception in kernel pc c000fb5c signal 4
> > Rebooting in 180 seconds..
>
> We are walking into a scheduling bug in kernel/sched.c with Linux
> 2.3.99-pre9.  MontaVista has an experimental real-time scheduler that
> can be installed into Linux 2.2.14.  Will this scheduler work with
> Linux 2.3.99-pre9?  If it has a shot at working, I would like to try
> it.  Perhaps I can avoid my problem.
>
>
> From hhl-kernel-rtsched.patch:
>
> REAL TIME SCHEDULER for Linux version 2.2.14
>
> Released under the GNU Public License.
>
> This patch contains the real time scheduler developed by
> MontaVista Software, Inc.  It applies cleanly against the
> Linux kernel version 2.2.14.  It adds the kernel configuration
> option CONFIG_RTSCHED.  If CONFIG_RTSCHED=y, the real time
> scheduler is configured, otherwise the standard scheduler is
> used.
>
> This patch also contains some fixes for the standard scheduler.
>
> May 5, 2000:
> Add real time scheduler option, as well as fixes for the standard scheduler.
> This updated version fixes a build problem on the PowerPC.
>
> CONTACT: <source@mvista.com>

--
Joe Green <jgreen@mvista.com>
MontaVista Software, Inc.
(408) 328-9209

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
