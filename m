Return-Path: <jstancek@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CF3A41A033E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 23:33:44 +1100 (AEDT)
From: Jan Stancek <jstancek@redhat.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/perf: add missing put_cpu_var in power_pmu_event_init
Date: Tue, 24 Mar 2015 08:33:22 -0400
Message-Id: <aa8dd4f5b50686871c9d3a1c27337006b1c9eea9.1427200114.git.jstancek@redhat.com>
Cc: linux-kernel@vger.kernel.org, paulus@samba.org, anton@samba.org,
 tj@kernel.org, cl@linux.com, jolsa@redhat.com, jstancek@redhat.com,
 joel@jms.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

One path in power_pmu_event_init() calls get_cpu_var(), but is
missing matching call to put_cpu_var(), which causes preemption
imbalance and crash in user-space:

  Page fault in user mode with in_atomic() = 1 mm = c000001fefa5a280
  NIP = 3fff9bf2cae0  MSR = 900000014280f032
  Oops: Weird page fault, sig: 11 [#23]
  SMP NR_CPUS=2048 NUMA PowerNV
  Modules linked in: <snip>
  CPU: 43 PID: 10285 Comm: a.out Tainted: G      D         4.0.0-rc5+ #1
  task: c000001fe82c9200 ti: c000001fe835c000 task.ti: c000001fe835c000
  NIP: 00003fff9bf2cae0 LR: 00003fff9bee4898 CTR: 00003fff9bf2cae0
  REGS: c000001fe835fea0 TRAP: 0401   Tainted: G      D          (4.0.0-rc5+)
  MSR: 900000014280f032 <SF,HV,VEC,VSX,EE,PR,FP,ME,IR,DR,RI>  CR: 22000028  XER: 00000000
  CFAR: 00003fff9bee4894 SOFTE: 1
   GPR00: 00003fff9bee494c 00003fffe01c2ee0 00003fff9c084410 0000000010020068
   GPR04: 0000000000000000 0000000000000002 0000000000000008 0000000000000001
   GPR08: 0000000000000001 00003fff9c074a30 00003fff9bf2cae0 00003fff9bf2cd70
   GPR12: 0000000052000022 00003fff9c10b700
  NIP [00003fff9bf2cae0] 0x3fff9bf2cae0
  LR [00003fff9bee4898] 0x3fff9bee4898
  Call Trace:
  ---[ end trace 5d3d952b5d4185d4 ]---

  BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:41
  in_atomic(): 1, irqs_disabled(): 0, pid: 10285, name: a.out
  INFO: lockdep is turned off.
  CPU: 43 PID: 10285 Comm: a.out Tainted: G      D         4.0.0-rc5+ #1
  Call Trace:
  [c000001fe835f990] [c00000000089c014] .dump_stack+0x98/0xd4 (unreliable)
  [c000001fe835fa10] [c0000000000e4138] .___might_sleep+0x1d8/0x2e0
  [c000001fe835faa0] [c000000000888da8] .down_read+0x38/0x110
  [c000001fe835fb30] [c0000000000bf2f4] .exit_signals+0x24/0x160
  [c000001fe835fbc0] [c0000000000abde0] .do_exit+0xd0/0xe70
  [c000001fe835fcb0] [c00000000001f4c4] .die+0x304/0x450
  [c000001fe835fd60] [c00000000088e1f4] .do_page_fault+0x2d4/0x900
  [c000001fe835fe30] [c000000000008664] handle_page_fault+0x10/0x30
  note: a.out[10285] exited with preempt_count 1

Reproducer:
  #include <stdio.h>
  #include <unistd.h>
  #include <syscall.h>
  #include <sys/types.h>
  #include <sys/stat.h>
  #include <linux/perf_event.h>
  #include <linux/hw_breakpoint.h>

  static struct perf_event_attr event = {
          .type = PERF_TYPE_RAW,
          .size = sizeof(struct perf_event_attr),
          .sample_type = PERF_SAMPLE_BRANCH_STACK,
          .branch_sample_type = PERF_SAMPLE_BRANCH_ANY_RETURN,
  };

  int main()
  {
          syscall(__NR_perf_event_open, &event, 0, -1, -1, 0);
  }

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 arch/powerpc/perf/core-book3s.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 7c4f669..b101c0b 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1832,8 +1832,10 @@ static int power_pmu_event_init(struct perf_event *event)
 		cpuhw->bhrb_filter = ppmu->bhrb_filter_map(
 					event->attr.branch_sample_type);
 
-		if(cpuhw->bhrb_filter == -1)
+		if (cpuhw->bhrb_filter == -1) {
+			put_cpu_var(cpu_hw_events);
 			return -EOPNOTSUPP;
+		}
 	}
 
 	put_cpu_var(cpu_hw_events);
-- 
1.7.1
