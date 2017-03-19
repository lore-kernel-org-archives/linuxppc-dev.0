Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vmPyG29yGzDqZR
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 03:42:46 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2JGcYM8084589
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Mar 2017 12:42:28 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 298y7cymfx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Mar 2017 12:42:27 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 19 Mar 2017 12:42:26 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH 2/3] mm: Let arch choose the initial value of task size
Date: Sun, 19 Mar 2017 22:11:57 +0530
In-Reply-To: <1489941718-10734-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1489941718-10734-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1489941718-10734-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As we start supporting larger address space (>128TB), we want to give
architecture a control on max task size of an application which is different
from the TASK_SIZE. For ex: ppc64 needs to track the base page size of a segment
and it is copied from mm_context_t to PACA on each context switch. If we know that
application has not used an address range above 128TB we only need to copy
details about 128TB range to PACA. This will help in improving context switch
performance by avoiding larger copy operation.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 fs/exec.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index 65145a3df065..5550a56d03c3 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1308,6 +1308,14 @@ void would_dump(struct linux_binprm *bprm, struct file *file)
 }
 EXPORT_SYMBOL(would_dump);
 
+#ifndef arch_init_task_size
+static inline void arch_init_task_size(void)
+{
+	current->mm->task_size = TASK_SIZE;
+}
+#define arch_init_task_size arch_init_task_size
+#endif
+
 void setup_new_exec(struct linux_binprm * bprm)
 {
 	arch_pick_mmap_layout(current->mm);
@@ -1327,7 +1335,7 @@ void setup_new_exec(struct linux_binprm * bprm)
 	 * depend on TIF_32BIT which is only updated in flush_thread() on
 	 * some architectures like powerpc
 	 */
-	current->mm->task_size = TASK_SIZE;
+	arch_init_task_size();
 
 	/* install the new credentials */
 	if (!uid_eq(bprm->cred->uid, current_euid()) ||
-- 
2.7.4
