Return-Path: <htejun@gmail.com>
Received: from mail-qk0-x241.google.com (mail-qk0-x241.google.com
 [IPv6:2607:f8b0:400d:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x2lCL5R7hzDqhn
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jul 2017 01:29:02 +1000 (AEST)
Received: by mail-qk0-x241.google.com with SMTP id p21so31711094qke.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Jul 2017 08:29:02 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 5 Jul 2017 11:28:55 -0400
From: Tejun Heo <tj@kernel.org>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: sachinp <sachinp@linux.vnet.ibm.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, ego <ego@linux.vnet.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Li Zefan <lizefan@huawei.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Ingo Molnar <mingo@kernel.org>, mpe <mpe@ellerman.id.au>
Subject: Re: [next-20170609] Oops while running CPU off-on
 (cpuset.c/cpuset_can_attach)
Message-ID: <20170705152855.GD19330@htj.duckdns.org>
References: <1497266622.15415.39.camel@abdul.in.ibm.com>
 <20170627153608.GD2289@htj.duckdns.org>
 <1499092582.10651.15.camel@abdul.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1499092582.10651.15.camel@abdul.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello, Abdul.

Thanks for the debug info.  Can you please see whether the following
patch fixes the issue?  If the problem is too difficult to reproduce
to confirm the fix by seeing whether it no longer triggers, please let
me know.  We can instead apply a patch which triggers WARN on the
failing condition to confirm the diagnosis.

Thanks.

diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index 793565c05742..8b4c3c2f2509 100644
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
index dbfd7028b1c6..e3c4152741a3 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1954,6 +1954,8 @@ static void cgroup_migrate_add_task(struct task_struct *task,
 	if (!cset->mg_src_cgrp)
 		return;
 
+	mgctx->tset.nr_tasks++;
+
 	list_move_tail(&task->cg_list, &cset->mg_tasks);
 	if (list_empty(&cset->mg_node))
 		list_add_tail(&cset->mg_node,
@@ -2047,16 +2049,18 @@ static int cgroup_migrate_execute(struct cgroup_mgctx *mgctx)
 		return 0;
 
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
@@ -2085,25 +2089,29 @@ static int cgroup_migrate_execute(struct cgroup_mgctx *mgctx)
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
