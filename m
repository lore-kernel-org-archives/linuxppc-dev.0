Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BFDA41A06A7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 20:56:18 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Wed, 2 Mar 2016 19:56:16 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id CE1342BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 20:56:12 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u229u4K63867100
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Mar 2016 20:56:12 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u229tdG8019775
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Mar 2016 20:55:40 +1100
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH] hw_breakpoint: Fix Oops at destroying hw_breakpoint event on
 powerpc
Date: Wed,  2 Mar 2016 15:25:17 +0530
Message-Id: <1456912517-5711-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At a time of destroying hw_breakpoint event, kernel ends up with Oops.
Here is the sample output from 4.5.0-rc6 kernel.

  [  450.708568] Unable to handle kernel paging request for data at address 0x00000c07
  [  450.708684] Faulting instruction address: 0xc0000000000291d0
  [  450.708750] Oops: Kernel access of bad area, sig: 11 [#1]
  [  450.708798] SMP NR_CPUS=1024 NUMA pSeries
  [  450.708856] Modules linked in: stap_4c2bdcf3e1aee79b646bb9a844e600f7__4962(O) xt_CHECKSUM ...
  [  450.709539] CPU: 5 PID: 5106 Comm: perf_fuzzer Tainted: G           O    4.5.0-rc5+ #1
  [  450.709620] task: c0000000f8795c80 ti: c0000000e3340000 task.ti: c0000000e3340000
  [  450.709691] NIP: c0000000000291d0 LR: c00000000020b6b4 CTR: c00000000020b6f0
  [  450.709760] REGS: c0000000e3343760 TRAP: 0300   Tainted: G           O     (4.5.0-rc5+)
  [  450.709831] MSR: 8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 22008828  XER: 20000000
  [  450.710001] CFAR: c000000000010708 DAR: 0000000000000c07 DSISR: 42000000 SOFTE: 1
  GPR00: c00000000020b6b4 c0000000e33439e0 c000000001350900 c00000009efa7000
  GPR04: 0000000000000001 c00000009efa7000 0000000000000000 0000000000000001
  GPR08: 0000000000000000 ffffffffffffffff 0000000000000000 0000000000000000
  GPR12: c00000000020b6f0 c000000007e02800 c00000009efa5208 0000000000000000
  GPR16: 0000000000000001 ffffffffffffffff 0000000000000000 c0000000f3ad7f10
  GPR20: c0000000f87964c8 0000000000000001 c0000000f8795c80 fffffffffffffffd
  GPR24: 0000000000000000 c0000000f3ad7f08 c0000000f3ad7f68 c00000009efa6800
  GPR28: c0000000f3ad7f00 c00000009efa5000 c000000001259520 c00000009efa7000
  [  450.710996] NIP [c0000000000291d0] arch_unregister_hw_breakpoint+0x40/0x60
  [  450.711066] LR [c00000000020b6b4] release_bp_slot+0x44/0x80
  [  450.711117] Call Trace:
  [  450.711165] [c0000000e33439e0] [c0000000009c1e38] mutex_lock+0x28/0x70 (unreliable)
  [  450.711257] [c0000000e3343a10] [c00000000020b6b4] release_bp_slot+0x44/0x80
  [  450.711332] [c0000000e3343a40] [c0000000002036c8] _free_event+0xd8/0x350
  [  450.711404] [c0000000e3343a70] [c000000000208260] perf_event_exit_task+0x2b0/0x4c0
  [  450.711490] [c0000000e3343b20] [c0000000000b8ac8] do_exit+0x388/0xc60
  [  450.711563] [c0000000e3343be0] [c0000000000b9484] do_group_exit+0x64/0x100
  [  450.711641] [c0000000e3343c20] [c0000000000c9100] get_signal+0x220/0x770
  [  450.711716] [c0000000e3343d10] [c000000000017884] do_signal+0x54/0x2b0
  [  450.711793] [c0000000e3343e00] [c000000000017cac] do_notify_resume+0xbc/0xd0
  [  450.711865] [c0000000e3343e30] [c000000000009838] ret_from_except_lite+0x64/0x68
  [  450.711948] Instruction dump:
  [  450.711986] f8010010 f821ffd1 7c7f1b78 60000000 60000000 e93f01e8 2fa90000 419e0018
  [  450.712107] e9290098 2fa90000 419e000c 39400000 <f9490c08> 38210030 e8010010 ebe1fff8
  [  450.712230] ---[ end trace 3cf087de955e9358 ]---

Call chain:

  hw_breakpoint_event_init()
    bp->destroy = bp_perf_event_destroy;

  do_exit()
    perf_event_exit_task()
      perf_event_exit_task_context()
        WRITE_ONCE(child_ctx->task, TASK_TOMBSTONE);
        perf_event_exit_event()
          free_event()
            _free_event()
              bp_perf_event_destroy()//event->destroy(event);
                release_bp_slot()
                  arch_unregister_hw_breakpoint()

perf_event_exit_task_context sets child_ctx->task as TASK_TOMBSTONE
which is (void *)-1. arch_unregister_hw_breakpoint tries to fetch
'thread' attribute of 'task' resulting in Oops.

This patch adds one more condition before accessing data from 'task'.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/hw_breakpoint.c | 3 ++-
 include/linux/perf_event.h          | 2 ++
 kernel/events/core.c                | 2 --
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index 05e804c..43d8496 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -29,6 +29,7 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
+#include <linux/perf_event.h>
 
 #include <asm/hw_breakpoint.h>
 #include <asm/processor.h>
@@ -110,7 +111,7 @@ void arch_unregister_hw_breakpoint(struct perf_event *bp)
 	 * and the single_step_dabr_instruction(), then cleanup the breakpoint
 	 * restoration variables to prevent dangling pointers.
 	 */
-	if (bp->ctx && bp->ctx->task)
+	if (bp->ctx && bp->ctx->task && bp->ctx->task != TASK_TOMBSTONE)
 		bp->ctx->task->thread.last_hit_ubp = NULL;
 }
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index f5c5a3f..491c50e 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1192,4 +1192,6 @@ _name##_show(struct device *dev,					\
 									\
 static struct device_attribute format_attr_##_name = __ATTR_RO(_name)
 
+#define TASK_TOMBSTONE ((void *)-1L)
+
 #endif /* _LINUX_PERF_EVENT_H */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6146148..121f30c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -159,8 +159,6 @@ static void perf_ctx_unlock(struct perf_cpu_context *cpuctx,
 	raw_spin_unlock(&cpuctx->ctx.lock);
 }
 
-#define TASK_TOMBSTONE ((void *)-1L)
-
 static bool is_kernel_event(struct perf_event *event)
 {
 	return READ_ONCE(event->owner) == TASK_TOMBSTONE;
-- 
1.8.3.1
