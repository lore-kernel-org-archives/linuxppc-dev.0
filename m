Return-Path: <aik@ozlabs.ru>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2C8D31A01A9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 19:31:44 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Wed, 30 Jul 2014 19:31:42 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 802B7357804F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 19:31:40 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6U98dx953477602
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 19:08:39 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6U9VdMF031236
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 19:31:39 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 03/16] mm: Add helpers for locked_vm
Date: Wed, 30 Jul 2014 19:31:22 +1000
Message-Id: <1406712695-9491-4-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1406712695-9491-1-git-send-email-aik@ozlabs.ru>
References: <1406712695-9491-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Michael Ellerman <michael@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds 2 helpers to change the locked_vm counter:
- try_increase_locked_vm - may fail if new locked_vm value will be greater
than the RLIMIT_MEMLOCK limit;
- decrease_locked_vm.

These will be used by drivers capable of locking memory by userspace
request. For example, VFIO can use it to check if it can lock DMA memory
or PPC-KVM can use it to check if it can lock memory for TCE tables.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 include/linux/mm.h |  3 +++
 mm/mlock.c         | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e03dd29..1cb219d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2113,5 +2113,8 @@ void __init setup_nr_node_ids(void);
 static inline void setup_nr_node_ids(void) {}
 #endif
 
+extern long try_increment_locked_vm(long npages);
+extern void decrement_locked_vm(long npages);
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
diff --git a/mm/mlock.c b/mm/mlock.c
index b1eb536..39e4b55 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -864,3 +864,52 @@ void user_shm_unlock(size_t size, struct user_struct *user)
 	spin_unlock(&shmlock_user_lock);
 	free_uid(user);
 }
+
+/**
+ * try_increment_locked_vm() - checks if new locked_vm value is going to
+ * be less than RLIMIT_MEMLOCK and increments it by npages if it is.
+ *
+ * @npages: the number of pages to add to locked_vm.
+ *
+ * Returns 0 if succeeded or negative value if failed.
+ */
+long try_increment_locked_vm(long npages)
+{
+	long ret = 0, locked, lock_limit;
+
+	if (!current || !current->mm)
+		return -ESRCH; /* process exited */
+
+	down_write(&current->mm->mmap_sem);
+	locked = current->mm->locked_vm + npages;
+	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
+	if (locked > lock_limit && !capable(CAP_IPC_LOCK)) {
+		pr_warn("RLIMIT_MEMLOCK (%ld) exceeded\n",
+				rlimit(RLIMIT_MEMLOCK));
+		ret = -ENOMEM;
+	} else {
+		current->mm->locked_vm += npages;
+	}
+	up_write(&current->mm->mmap_sem);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(try_increment_locked_vm);
+
+/**
+ * decrement_locked_vm() - decrements the current task's locked_vm counter.
+ *
+ * @npages: the number to decrement by.
+ */
+void decrement_locked_vm(long npages)
+{
+	if (!current || !current->mm)
+		return; /* process exited */
+
+	down_write(&current->mm->mmap_sem);
+	if (npages > current->mm->locked_vm)
+		npages = current->mm->locked_vm;
+	current->mm->locked_vm -= npages;
+	up_write(&current->mm->mmap_sem);
+}
+EXPORT_SYMBOL_GPL(decrement_locked_vm);
-- 
2.0.0
