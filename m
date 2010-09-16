Return-Path: <peterz@infradead.org>
Subject: Re: 2.6.35-stable/ppc64/p7: suspicious rcu_dereference_check()
	usage detected during 2.6.35-stable boot
From: Peter Zijlstra <peterz@infradead.org>
To: paulmck@linux.vnet.ibm.com
In-Reply-To: <20100809161200.GC3026@linux.vnet.ibm.com>
References: <1280739132.15317.9.camel@subratamodak.linux.ibm.com>
	<20100809161200.GC3026@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 16 Sep 2010 17:50:31 +0200
Message-ID: <1284652231.2275.569.camel@laptop>
Mime-Version: 1.0
Cc: sachinp <sachinp@linux.vnet.ibm.com>,
	"Valdis.Kletnieks" <Valdis.Kletnieks@vt.edu>,
	Li Zefan <lizf@cn.fujitsu.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	Subrata Modak <subrata@linux.vnet.ibm.com>,
	DIVYA PRAKASH <dipraksh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-08-09 at 09:12 -0700, Paul E. McKenney wrote:

> > [    0.051203] CPU0: AMD QEMU Virtual CPU version 0.12.4 stepping 03
> > [    0.052999] lockdep: fixing up alternatives.
> > [    0.054105]
> > [    0.054106] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > [    0.054999] [ INFO: suspicious rcu_dereference_check() usage. ]
> > [    0.054999] ---------------------------------------------------
> > [    0.054999] kernel/sched.c:616 invoked rcu_dereference_check() witho=
ut protection!
> > [    0.054999]
> > [    0.054999] other info that might help us debug this:
> > [    0.054999]
> > [    0.054999]
> > [    0.054999] rcu_scheduler_active =3D 1, debug_locks =3D 1
> > [    0.054999] 3 locks held by swapper/1:
> > [    0.054999]  #0:  (cpu_add_remove_lock){+.+.+.}, at: [<ffffffff814be=
933>] cpu_up+0x42/0x6a
> > [    0.054999]  #1:  (cpu_hotplug.lock){+.+.+.}, at: [<ffffffff810400d8=
>] cpu_hotplug_begin+0x2a/0x51
> > [    0.054999]  #2:  (&rq->lock){-.-...}, at: [<ffffffff814be2f7>] init=
_idle+0x2f/0x113
> > [    0.054999]
> > [    0.054999] stack backtrace:
> > [    0.054999] Pid: 1, comm: swapper Not tainted 2.6.35 #1
> > [    0.054999] Call Trace:
> > [    0.054999]  [<ffffffff81068054>] lockdep_rcu_dereference+0x9b/0xa3
> > [    0.054999]  [<ffffffff810325c3>] task_group+0x7b/0x8a
> > [    0.054999]  [<ffffffff810325e5>] set_task_rq+0x13/0x40
> > [    0.054999]  [<ffffffff814be39a>] init_idle+0xd2/0x113
> > [    0.054999]  [<ffffffff814be78a>] fork_idle+0xb8/0xc7
> > [    0.054999]  [<ffffffff81068717>] ? mark_held_locks+0x4d/0x6b
> > [    0.054999]  [<ffffffff814bcebd>] do_fork_idle+0x17/0x2b
> > [    0.054999]  [<ffffffff814bc89b>] native_cpu_up+0x1c1/0x724
> > [    0.054999]  [<ffffffff814bcea6>] ? do_fork_idle+0x0/0x2b
> > [    0.054999]  [<ffffffff814be876>] _cpu_up+0xac/0x127
> > [    0.054999]  [<ffffffff814be946>] cpu_up+0x55/0x6a
> > [    0.054999]  [<ffffffff81ab562a>] kernel_init+0xe1/0x1ff
> > [    0.054999]  [<ffffffff81003854>] kernel_thread_helper+0x4/0x10
> > [    0.054999]  [<ffffffff814c353c>] ? restore_args+0x0/0x30
> > [    0.054999]  [<ffffffff81ab5549>] ? kernel_init+0x0/0x1ff
> > [    0.054999]  [<ffffffff81003850>] ? kernel_thread_helper+0x0/0x10
> > [    0.056074] Booting Node   0, Processors  #1lockdep: fixing up alter=
natives.
> > [    0.130045]  #2lockdep: fixing up alternatives.
> > [    0.203089]  #3 Ok.
> > [    0.275286] Brought up 4 CPUs
> > [    0.276005] Total of 4 processors activated (16017.17 BogoMIPS).
>=20
> This does look like a new one, thank you for reporting it!
>=20
> Here is my analysis, which should at least provide some humor value to
> those who understand the code better than I do.  ;-)
>=20
> So the corresponding rcu_dereference_check() is in
> task_subsys_state_check(), and is fetching the cpu_cgroup_subsys_id
> element of the newly created task's task->cgroups->subsys[] array.
> The "git grep" command finds only three uses of cpu_cgroup_subsys_id,
> but no definition.
>=20
> Now, fork_idle() invokes copy_process(), which invokes cgroup_fork(),
> which sets the child process's ->cgroups pointer to that of the parent,
> also invoking get_css_set(), which increments the corresponding reference
> count, doing both operations under task_lock() protection (->alloc_lock).
> Because fork_idle() does not specify any of CLONE_NEWNS, CLONE_NEWUTS,
> CLONE_NEWIPC, CLONE_NEWPID, or CLONE_NEWNET, copy_namespaces() should
> not create a new namespace, and so there should be no ns_cgroup_clone().
> We should thus retain the parent's ->cgroups pointer.  And copy_process()
> installs the new task in the various lists, so that the task is externall=
y
> accessible upon return.
>=20
> After a non-error return from copy_process(), fork_init() invokes
> init_idle_pid(), which does not appear to affect the task's cgroup
> state.  Next fork_init() invokes init_idle(), which in turn invokes
> __set_task_cpu(), which invokes set_task_rq(), which calls task_group()
> several times, which calls task_subsys_state_check(), which calls the
> rcu_dereference_check() that complained above.
>=20
> However, the result returns by rcu_dereference_check() is stored into
> the task structure:
>=20
> 	p->se.cfs_rq =3D task_group(p)->cfs_rq[cpu];
> 	p->se.parent =3D task_group(p)->se[cpu];
>=20
> This means that the corresponding structure must have been tied down with
> a reference count or some such.  If such a reference has been taken, then
> this complaint is a false positive, and could be suppressed by putting
> rcu_read_lock() and rcu_read_unlock() around the call to init_idle()
> from fork_idle().  However, although, reference to the enclosing ->cgroup=
s
> struct css_set is held, it is not clear to me that this reference applies
> to the structures pointed to by the ->subsys[] array, especially given
> that the cgroup_subsys_state structures referenced by this array have
> their own reference count, which does not appear to me to be acquired
> by this code path.
>=20
> Or are the cgroup_subsys_state structures referenced by idle tasks
> never freed or some such?

I would hope so!, the idle tasks should be part of the root cgroup,
which is not removable.

The problem is that while we do in-fact hold rq->lock, the newly spawned
idle thread's cpu is not yet set to the correct cpu so the lockdep check
in task_group():

  lockdep_is_held(&task_rq(p)->lock)

will fail.

But of a chicken and egg problem. Setting the cpu needs to have the cpu
set ;-)

Ingo, why do we have rq->lock there at all? The CPU isn't up and running
yet, nothing should be touching it.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 kernel/sched.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/kernel/sched.c b/kernel/sched.c
index bd8b487..6241049 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -5332,7 +5332,19 @@ void __cpuinit init_idle(struct task_struct *idle, i=
nt cpu)
 	idle->se.exec_start =3D sched_clock();
=20
 	cpumask_copy(&idle->cpus_allowed, cpumask_of(cpu));
+	/*
+	 * We're having a chicken and egg problem, even though we are
+	 * holding rq->lock, the cpu isn't yet set to this cpu so the
+	 * lockdep check in task_group() will fail.
+	 *
+	 * Similar case to sched_fork(). / Alternatively we could
+	 * use task_rq_lock() here and obtain the other rq->lock.
+	 *
+	 * Silence PROVE_RCU
+	 */
+	rcu_read_lock();
 	__set_task_cpu(idle, cpu);
+	rcu_read_unlock();
=20
 	rq->curr =3D rq->idle =3D idle;
 #if defined(CONFIG_SMP) && defined(__ARCH_WANT_UNLOCKED_CTXSW)
