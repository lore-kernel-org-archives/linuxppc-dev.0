Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjrZm5WRCzDqGZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Sep 2017 04:32:32 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7VIVPjs057904
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 14:32:30 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cpnqwp17x-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 14:32:29 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 1 Sep 2017 04:32:27 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7VIWPDF22741044
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Sep 2017 04:32:25 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7VIWPEG002713
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Sep 2017 04:32:25 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Oleg Nesterov <oleg@redhat.com>, Anton Blanchard <anton@samba.org>
Subject: [PATCH] uprobe: Warn if unable to install breakpoint
Date: Fri,  1 Sep 2017 00:02:15 +0530
Message-Id: <20170831183215.4306-1-naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When we try to install a uprobe breakpoint in uprobe_mmap(), we ignore
all errors encountered in the process per this comment at the top of
the function:
    /*
     * Called from mmap_region/vma_adjust with mm->mmap_sem acquired.
     *
     * Currently we ignore all errors and always return 0, the callers
     * can't handle the failure anyway.
     */

However, this is very confusing for users since no probe hits are
recorded nor is an error logged in dmesg.

Fix this by logging an error in dmesg so that users can discover that
there was an issue with the uprobe. To facilitate use of uprobe_warn(),
we move that function to the top of the file.

With this patch, we see a message similar to this in dmesg:
    [  201.449213] uprobe: uprobe_t:9740 failed to setup probe at 0x95c (-524)

Reported-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 kernel/events/uprobes.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 0e137f98a50c..587c591a535c 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -112,6 +112,12 @@ struct xol_area {
 	unsigned long 			vaddr;		/* Page(s) of instruction slots */
 };
 
+static void uprobe_warn(struct task_struct *t, const char *msg)
+{
+	pr_warn("uprobe: %s:%d failed to %s\n",
+			current->comm, current->pid, msg);
+}
+
 /*
  * valid_vma: Verify if the specified vma is an executable vma
  * Relax restrictions while unregistering: vm_flags might have
@@ -1087,7 +1093,14 @@ int uprobe_mmap(struct vm_area_struct *vma)
 		if (!fatal_signal_pending(current) &&
 		    filter_chain(uprobe, UPROBE_FILTER_MMAP, vma->vm_mm)) {
 			unsigned long vaddr = offset_to_vaddr(vma, uprobe->offset);
-			install_breakpoint(uprobe, vma->vm_mm, vma, vaddr);
+			int ret = install_breakpoint(uprobe, vma->vm_mm, vma, vaddr);
+			if (ret) {
+				char msg[64];
+				snprintf(msg, sizeof(msg),
+						"setup probe at 0x%llx (%d)",
+						uprobe->offset, ret);
+				uprobe_warn(current, (const char *)msg);
+			}
 		}
 		put_uprobe(uprobe);
 	}
@@ -1470,12 +1483,6 @@ static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
 	return 0;
 }
 
-static void uprobe_warn(struct task_struct *t, const char *msg)
-{
-	pr_warn("uprobe: %s:%d failed to %s\n",
-			current->comm, current->pid, msg);
-}
-
 static void dup_xol_work(struct callback_head *work)
 {
 	if (current->flags & PF_EXITING)
-- 
2.14.1
