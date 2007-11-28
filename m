Return-Path: <jan.kratochvil@redhat.com>
Received: from pauline.vellum.cz (pauline.vellum.cz [89.250.243.234])
	by ozlabs.org (Postfix) with ESMTP id E9923DDDF6
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 23:45:36 +1100 (EST)
Date: Wed, 28 Nov 2007 13:45:29 +0100
From: Jan Kratochvil <jan.kratochvil@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: PPC upstream kernel ignored DABR bug
Message-ID: <20071128124529.GA23349@host0.dyn.jankratochvil.net>
References: <20071126220224.GA5606@host0.dyn.jankratochvil.net>
	<200711272335.36981.arnd@arndb.de>
	<20071128085907.GA19651@host0.dyn.jankratochvil.net>
	<200711281328.50386.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <200711281328.50386.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 28 Nov 2007 13:28:48 +0100, Arnd Bergmann wrote:
> On Wednesday 28 November 2007, Jan Kratochvil wrote:
> > Please be aware DABR works fine if the same code runs just 1 (always) or
> > 2 (sometimes) threads.  It starts failing with too many threads running:
> > 
> > $ ./dabr-lost
> > TID 32725: DABR 0x1001279f NIP 0xfecf41c
> > TID 32726: DABR 0x1001279f NIP 0xfecf41c
> > TID 32725: hitting the variable
> > variable found = -1, caught TID = 32725
> > TID 32726: hitting the variable
> > variable found = -1, caught TID = 32726
> > The kernel bug did not get reproduced - increase THREADS.
> > 
> > As I did not find any code in that kernel touching DABRX its value should not
> > be dependent on the number of threads running.
> > 
> 
> Right, this is a different problem from the one reported by Uli.
> From what I can tell, your problem is that you set the DABR only
> in one thread, so the other threads don't see it. DABR is saved
> in the thread_struct, so setting it in one thread doesn't have
> an impact on any other thread.

It even prints out above:
	TID 32725: DABR 0x1001279f NIP 0xfecf41c
	TID 32726: DABR 0x1001279f NIP 0xfecf41c

that it wrote DABR in both the threads and it has also successfully read it
back from each thread specifically (according to its thread-specific TID).

for (threadi = 0; threadi < THREADS; threadi++)
    {
      pid_t tid = thread[threadi];

      setup (tid);
...
    }
static void setup (pid_t tid)
{
...
  l = ptrace (PTRACE_SET_DEBUGREG, tid, NULL, (void *) dabr);
...
}

Also if I would not set DABR specifically for each thread it would not work in
90% of cases for `THREADS == 2'.  And it would not work for `THREADS == 4' if
they are busylooping (therefore not in a syscall).
	TID 596: DABR 0x100127a7 NIP 0x10000dbc
	TID 597: DABR 0x100127a7 NIP 0x10000db0
	TID 598: DABR 0x100127a7 NIP 0x10000dac
	TID 599: DABR 0x100127a7 NIP 0x10000dbc
	TID 596: hitting the variable
	variable found = -1, caught TID = 596
	TID 599: hitting the variable
	variable found = -1, caught TID = 599
	TID 597: hitting the variable
	variable found = -1, caught TID = 597
	TID 598: hitting the variable
	variable found = -1, caught TID = 598
	The kernel bug got workarounded by WORKAROUND_SET_DABR_IN_SYSCALL.

(I found out now WORKAROUND_SET_DABR_IN_SYSCALL only reduces the probability of
the failure, it is not a 100% workaround of the problem in the testcase.)


There is some tricky kernel code around it but I did not try to debug it:

struct task_struct *__switch_to(struct task_struct *prev,
	struct task_struct *new)
{
...
	if (unlikely(__get_cpu_var(current_dabr) != new->thread.dabr)) {
		set_dabr(new->thread.dabr);
		__get_cpu_var(current_dabr) = new->thread.dabr;
	}
...
}



Regards,
Jan
