Return-Path: <aik@ozlabs.ru>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4E45C1A01C4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 13:06:13 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Wed, 23 Jul 2014 13:06:11 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id EFF1A2CE805E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 13:06:09 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6N2nD6158720406
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 12:49:14 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6N368lC031041
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 13:06:09 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 03/18] KVM: PPC: Account TCE pages in locked_vm
Date: Wed, 23 Jul 2014 13:05:49 +1000
Message-Id: <1406084764-24685-4-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1406084764-24685-1-git-send-email-aik@ozlabs.ru>
References: <1406084764-24685-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kvm/book3s_64_vio.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 516f2ee..48b7ed4 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -45,18 +45,48 @@ static long kvmppc_stt_npages(unsigned long window_size)
 		     * sizeof(u64), PAGE_SIZE) / PAGE_SIZE;
 }
 
+/*
+ * Checks ulimit in order not to let the user space to pin all
+ * available memory for TCE tables.
+ */
+static long kvmppc_account_memlimit(long npages)
+{
+	unsigned long ret = 0, locked, lock_limit;
+
+	if (!current->mm)
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
+
 static void release_spapr_tce_table(struct kvmppc_spapr_tce_table *stt)
 {
 	struct kvm *kvm = stt->kvm;
 	int i;
+	long npages = kvmppc_stt_npages(stt->window_size);
 
 	mutex_lock(&kvm->lock);
 	list_del(&stt->list);
-	for (i = 0; i < kvmppc_stt_npages(stt->window_size); i++)
+	for (i = 0; i < npages; i++)
 		__free_page(stt->pages[i]);
+
 	kfree(stt);
 	mutex_unlock(&kvm->lock);
 
+	kvmppc_account_memlimit(-(npages + 1));
+
 	kvm_put_kvm(kvm);
 }
 
@@ -112,6 +142,9 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 	}
 
 	npages = kvmppc_stt_npages(args->window_size);
+	ret = kvmppc_account_memlimit(npages + 1);
+	if (ret)
+		goto fail;
 
 	stt = kzalloc(sizeof(*stt) + npages * sizeof(struct page *),
 		      GFP_KERNEL);
-- 
2.0.0
