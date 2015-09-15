Return-Path: <aik@ozlabs.ru>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9090C1A2C78
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 20:51:01 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 15 Sep 2015 20:51:00 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A50452BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 20:50:58 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8FAoo8F52166722
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 20:50:58 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8FAoQwQ026650
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 20:50:26 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Alexander Graf <agraf@suse.com>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel 5/9] KVM: PPC: Account TCE-containing pages in locked_vm
Date: Tue, 15 Sep 2015 20:49:35 +1000
Message-Id: <1442314179-9706-6-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1442314179-9706-1-git-send-email-aik@ozlabs.ru>
References: <1442314179-9706-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At the moment pages used for TCE tables (in addition to pages addressed
by TCEs) are not counted in locked_vm counter so a malicious userspace
tool can call ioctl(KVM_CREATE_SPAPR_TCE) as many times as RLIMIT_NOFILE and
lock a lot of memory.

This adds counting for pages used for TCE tables.

This counts the number of pages required for a table plus pages for
the kvmppc_spapr_tce_table struct (TCE table descriptor) itself.

This does not change the amount of (de)allocated memory.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kvm/book3s_64_vio.c | 51 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 9526c34..b70787d 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -45,13 +45,56 @@ static long kvmppc_stt_npages(unsigned long window_size)
 		     * sizeof(u64), PAGE_SIZE) / PAGE_SIZE;
 }
 
+static long kvmppc_account_memlimit(long npages, bool inc)
+{
+	long ret = 0;
+	const long bytes = sizeof(struct kvmppc_spapr_tce_table) +
+			(abs(npages) * sizeof(struct page *));
+	const long stt_pages = ALIGN(bytes, PAGE_SIZE) / PAGE_SIZE;
+
+	if (!current || !current->mm)
+		return ret; /* process exited */
+
+	npages += stt_pages;
+
+	down_write(&current->mm->mmap_sem);
+
+	if (inc) {
+		long locked, lock_limit;
+
+		locked = current->mm->locked_vm + npages;
+		lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
+		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
+			ret = -ENOMEM;
+		else
+			current->mm->locked_vm += npages;
+	} else {
+		if (npages > current->mm->locked_vm)
+			npages = current->mm->locked_vm;
+
+		current->mm->locked_vm -= npages;
+	}
+
+	pr_debug("[%d] RLIMIT_MEMLOCK KVM %c%ld %ld/%ld%s\n", current->pid,
+			inc ? '+' : '-',
+			npages << PAGE_SHIFT,
+			current->mm->locked_vm << PAGE_SHIFT,
+			rlimit(RLIMIT_MEMLOCK),
+			ret ? " - exceeded" : "");
+
+	up_write(&current->mm->mmap_sem);
+
+	return ret;
+}
+
 static void release_spapr_tce_table(struct rcu_head *head)
 {
 	struct kvmppc_spapr_tce_table *stt = container_of(head,
 			struct kvmppc_spapr_tce_table, rcu);
 	int i;
+	long npages = kvmppc_stt_npages(stt->window_size);
 
-	for (i = 0; i < kvmppc_stt_npages(stt->window_size); i++)
+	for (i = 0; i < npages; i++)
 		__free_page(stt->pages[i]);
 
 	kfree(stt);
@@ -89,6 +132,7 @@ static int kvm_spapr_tce_release(struct inode *inode, struct file *filp)
 
 	kvm_put_kvm(stt->kvm);
 
+	kvmppc_account_memlimit(kvmppc_stt_npages(stt->window_size), false);
 	call_rcu(&stt->rcu, release_spapr_tce_table);
 
 	return 0;
@@ -114,6 +158,11 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 	}
 
 	npages = kvmppc_stt_npages(args->window_size);
+	ret = kvmppc_account_memlimit(npages, true);
+	if (ret) {
+		stt = NULL;
+		goto fail;
+	}
 
 	stt = kzalloc(sizeof(*stt) + npages * sizeof(struct page *),
 		      GFP_KERNEL);
-- 
2.4.0.rc3.8.gfb3e7d5
