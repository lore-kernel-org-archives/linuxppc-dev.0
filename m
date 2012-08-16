Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: K Prasad <prasad@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: powerpc/perf: hw breakpoints return ENOSPC
Date: Thu, 16 Aug 2012 14:23:54 +1000
Message-ID: <28857.1345091034@neuling.org>
Cc: Ingo Molnar <mingo@kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I've been trying to get hardware breakpoints with perf to work on POWER7
but I'm getting the following:

  % perf record -e mem:0x10000000 true

    Error: sys_perf_event_open() syscall returned with 28 (No space left on device).  /bin/dmesg may provide additional information.

    Fatal: No CONFIG_PERF_EVENTS=y kernel support configured?

  true: Terminated

(FWIW adding -a and it works fine)

Debugging it seems that __reserve_bp_slot() is returning ENOSPC because
it thinks there are no free breakpoint slots on this CPU.

I have a 2 CPUs, so perf userspace is doing two perf_event_open syscalls
to add a counter to each CPU [1].  The first syscall succeeds but the
second is failing.

On this second syscall, fetch_bp_busy_slots() sets slots.pinned to be 1,
despite there being no breakpoint on this CPU.  This is because the call
the task_bp_pinned, checks all CPUs, rather than just the current CPU.
POWER7 only has one hardware breakpoint per CPU (ie. HBP_NUM=1), so we
return ENOSPC.

The following patch fixes this by checking the associated CPU for each
breakpoint in task_bp_pinned.  I'm not familiar with this code, so it's
provided as a reference to the above issue.

Mikey

1. not sure why it doesn't just do one syscall and specify all CPUs, but
that's another issue.  Using two syscalls should work.

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index bb38c4d..e092daa 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -111,14 +111,16 @@ static unsigned int max_task_bp_pinned(int cpu, enum bp_type_idx type)
  * Count the number of breakpoints of the same type and same task.
  * The given event must be not on the list.
  */
-static int task_bp_pinned(struct perf_event *bp, enum bp_type_idx type)
+static int task_bp_pinned(int cpu, struct perf_event *bp, enum bp_type_idx type)
 {
 	struct task_struct *tsk = bp->hw.bp_target;
 	struct perf_event *iter;
 	int count = 0;
 
 	list_for_each_entry(iter, &bp_task_head, hw.bp_list) {
-		if (iter->hw.bp_target == tsk && find_slot_idx(iter) == type)
+		if (iter->hw.bp_target == tsk &&
+		    find_slot_idx(iter) == type &&
+		    cpu == iter->cpu)
 			count += hw_breakpoint_weight(iter);
 	}
 
@@ -141,7 +143,7 @@ fetch_bp_busy_slots(struct bp_busy_slots *slots, struct perf_event *bp,
 		if (!tsk)
 			slots->pinned += max_task_bp_pinned(cpu, type);
 		else
-			slots->pinned += task_bp_pinned(bp, type);
+			slots->pinned += task_bp_pinned(cpu, bp, type);
 		slots->flexible = per_cpu(nr_bp_flexible[type], cpu);
 
 		return;
@@ -154,7 +156,7 @@ fetch_bp_busy_slots(struct bp_busy_slots *slots, struct perf_event *bp,
 		if (!tsk)
 			nr += max_task_bp_pinned(cpu, type);
 		else
-			nr += task_bp_pinned(bp, type);
+			nr += task_bp_pinned(cpu, bp, type);
 
 		if (nr > slots->pinned)
 			slots->pinned = nr;
@@ -188,7 +190,7 @@ static void toggle_bp_task_slot(struct perf_event *bp, int cpu, bool enable,
 	int old_idx = 0;
 	int idx = 0;
 
-	old_count = task_bp_pinned(bp, type);
+	old_count = task_bp_pinned(cpu, bp, type);
 	old_idx = old_count - 1;
 	idx = old_idx + weight;
 
