Return-Path: <htejun@gmail.com>
Received: from mail-qk0-x244.google.com (mail-qk0-x244.google.com
 [IPv6:2607:f8b0:400d:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x4V7r3TY6zDr9C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Jul 2017 21:47:04 +1000 (AEST)
Received: by mail-qk0-x244.google.com with SMTP id v143so7356436qkb.3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Jul 2017 04:47:04 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sat, 8 Jul 2017 07:46:52 -0400
From: Tejun Heo <tj@kernel.org>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: sachinp <sachinp@linux.vnet.ibm.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, ego <ego@linux.vnet.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Li Zefan <lizefan@huawei.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Ingo Molnar <mingo@kernel.org>, mpe <mpe@ellerman.id.au>,
 kernel-team@fb.com, Roman Gushchin <guro@fb.com>
Subject: [PATCH cgroup/for-4.13-fixes] cgroup: don't call migration methods
 if there are no tasks to migrate
Message-ID: <20170708114652.GA1305447@devbig577.frc2.facebook.com>
References: <1497266622.15415.39.camel@abdul.in.ibm.com>
 <20170627153608.GD2289@htj.duckdns.org>
 <1499092582.10651.15.camel@abdul.in.ibm.com>
 <20170705152855.GD19330@htj.duckdns.org>
 <1499409574.19784.26.camel@abdul.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1499409574.19784.26.camel@abdul.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>From 610467270fb368584b74567edd21c8cc5104490f Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Sat, 8 Jul 2017 07:17:02 -0400

Subsystem migration methods shouldn't be called for empty migrations.
cgroup_migrate_execute() implements this guarantee by bailing early if
there are no source css_sets.  This used to be correct before
a79a908fd2b0 ("cgroup: introduce cgroup namespaces"), but no longer
since the commit because css_sets can stay pinned without tasks in
them.

This caused cgroup_migrate_execute() call into cpuset migration
methods with an empty cgroup_taskset.  cpuset migration methods
correctly assume that cgroup_taskset_first() never returns NULL;
however, due to the bug, it can, leading to the following oops.

  Unable to handle kernel paging request for data at address 0x00000960
  Faulting instruction address: 0xc0000000001d6868
  Oops: Kernel access of bad area, sig: 11 [#1]
  ...
  CPU: 14 PID: 16947 Comm: kworker/14:0 Tainted: G        W
  4.12.0-rc4-next-20170609 #2
  Workqueue: events cpuset_hotplug_workfn
  task: c00000000ca60580 task.stack: c00000000c728000
  NIP: c0000000001d6868 LR: c0000000001d6858 CTR: c0000000001d6810
  REGS: c00000000c72b720 TRAP: 0300   Tainted: GW (4.12.0-rc4-next-20170609)
  MSR: 8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 44722422  XER: 20000000
  CFAR: c000000000008710 DAR: 0000000000000960 DSISR: 40000000 SOFTE: 1
  GPR00: c0000000001d6858 c00000000c72b9a0 c000000001536e00 0000000000000000
  GPR04: c00000000c72b9c0 0000000000000000 c00000000c72bad0 c000000766367678
  GPR08: c000000766366d10 c00000000c72b958 c000000001736e00 0000000000000000
  GPR12: c0000000001d6810 c00000000e749300 c000000000123ef8 c000000775af4180
  GPR16: 0000000000000000 0000000000000000 c00000075480e9c0 c00000075480e9e0
  GPR20: c00000075480e8c0 0000000000000001 0000000000000000 c00000000c72ba20
  GPR24: c00000000c72baa0 c00000000c72bac0 c000000001407248 c00000000c72ba20
  GPR28: c00000000141fc80 c00000000c72bac0 c00000000c6bc790 0000000000000000
  NIP [c0000000001d6868] cpuset_can_attach+0x58/0x1b0
  LR [c0000000001d6858] cpuset_can_attach+0x48/0x1b0
  Call Trace:
  [c00000000c72b9a0] [c0000000001d6858] cpuset_can_attach+0x48/0x1b0 (unreliable)
  [c00000000c72ba00] [c0000000001cbe80] cgroup_migrate_execute+0xb0/0x450
  [c00000000c72ba80] [c0000000001d3754] cgroup_transfer_tasks+0x1c4/0x360
  [c00000000c72bba0] [c0000000001d923c] cpuset_hotplug_workfn+0x86c/0xa20
  [c00000000c72bca0] [c00000000011aa44] process_one_work+0x1e4/0x580
  [c00000000c72bd30] [c00000000011ae78] worker_thread+0x98/0x5c0
  [c00000000c72bdc0] [c000000000124058] kthread+0x168/0x1b0
  [c00000000c72be30] [c00000000000b2e8] ret_from_kernel_thread+0x5c/0x74
  Instruction dump:
  f821ffa1 7c7d1b78 60000000 60000000 38810020 7fa3eb78 3f42ffed 4bff4c25
  60000000 3b5a0448 3d420020 eb610020 <e9230960> 7f43d378 e9290000 f92af200
  ---[ end trace dcaaf98fb36d9e64 ]---

This patch fixes the bug by adding an explicit nr_tasks counter to
cgroup_taskset and skipping calling the migration methods if the
counter is zero.  While at it, remove the now spurious check on no
source css_sets.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-and-tested-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: Roman Gushchin <guro@fb.com>
Cc: stable@vger.kernel.org # v4.6+
Fixes: a79a908fd2b0 ("cgroup: introduce cgroup namespaces")
Link: http://lkml.kernel.org/r/1497266622.15415.39.camel@abdul.in.ibm.com
---
Applied to cgroup/for-4.13-fixes.  Thanks.

 kernel/cgroup/cgroup-internal.h |  3 +++
 kernel/cgroup/cgroup.c          | 58 ++++++++++++++++++++++-------------------
 2 files changed, 34 insertions(+), 27 deletions(-)

diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index 793565c..8b4c3c2 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -33,6 +33,9 @@ struct cgroup_taskset {
 	struct list_head	src_csets;
 	struct list_head	dst_csets;
 
+	/* the number of tasks in the set */
+	int			nr_tasks;
+
 	/* the subsys currently being processed */
 	int			ssid;
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 620794a..cc53111 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2006,6 +2006,8 @@ static void cgroup_migrate_add_task(struct task_struct *task,
 	if (!cset->mg_src_cgrp)
 		return;
 
+	mgctx->tset.nr_tasks++;
+
 	list_move_tail(&task->cg_list, &cset->mg_tasks);
 	if (list_empty(&cset->mg_node))
 		list_add_tail(&cset->mg_node,
@@ -2094,21 +2096,19 @@ static int cgroup_migrate_execute(struct cgroup_mgctx *mgctx)
 	struct css_set *cset, *tmp_cset;
 	int ssid, failed_ssid, ret;
 
-	/* methods shouldn't be called if no task is actually migrating */
-	if (list_empty(&tset->src_csets))
-		return 0;
-
 	/* check that we can legitimately attach to the cgroup */
-	do_each_subsys_mask(ss, ssid, mgctx->ss_mask) {
-		if (ss->can_attach) {
-			tset->ssid = ssid;
-			ret = ss->can_attach(tset);
-			if (ret) {
-				failed_ssid = ssid;
-				goto out_cancel_attach;
+	if (tset->nr_tasks) {
+		do_each_subsys_mask(ss, ssid, mgctx->ss_mask) {
+			if (ss->can_attach) {
+				tset->ssid = ssid;
+				ret = ss->can_attach(tset);
+				if (ret) {
+					failed_ssid = ssid;
+					goto out_cancel_attach;
+				}
 			}
-		}
-	} while_each_subsys_mask();
+		} while_each_subsys_mask();
+	}
 
 	/*
 	 * Now that we're guaranteed success, proceed to move all tasks to
@@ -2137,25 +2137,29 @@ static int cgroup_migrate_execute(struct cgroup_mgctx *mgctx)
 	 */
 	tset->csets = &tset->dst_csets;
 
-	do_each_subsys_mask(ss, ssid, mgctx->ss_mask) {
-		if (ss->attach) {
-			tset->ssid = ssid;
-			ss->attach(tset);
-		}
-	} while_each_subsys_mask();
+	if (tset->nr_tasks) {
+		do_each_subsys_mask(ss, ssid, mgctx->ss_mask) {
+			if (ss->attach) {
+				tset->ssid = ssid;
+				ss->attach(tset);
+			}
+		} while_each_subsys_mask();
+	}
 
 	ret = 0;
 	goto out_release_tset;
 
 out_cancel_attach:
-	do_each_subsys_mask(ss, ssid, mgctx->ss_mask) {
-		if (ssid == failed_ssid)
-			break;
-		if (ss->cancel_attach) {
-			tset->ssid = ssid;
-			ss->cancel_attach(tset);
-		}
-	} while_each_subsys_mask();
+	if (tset->nr_tasks) {
+		do_each_subsys_mask(ss, ssid, mgctx->ss_mask) {
+			if (ssid == failed_ssid)
+				break;
+			if (ss->cancel_attach) {
+				tset->ssid = ssid;
+				ss->cancel_attach(tset);
+			}
+		} while_each_subsys_mask();
+	}
 out_release_tset:
 	spin_lock_irq(&css_set_lock);
 	list_splice_init(&tset->dst_csets, &tset->src_csets);
-- 
2.9.3
