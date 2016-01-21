Return-Path: <aik@ozlabs.ru>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5F75A1A1903
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 18:41:10 +1100 (AEDT)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Thu, 21 Jan 2016 17:41:08 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 18E022CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 18:41:06 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0L7ev1C13762630
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 18:41:05 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0L7eXnl026496
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 18:40:33 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel v2 3/6] KVM: PPC: Account TCE-containing pages in
 locked_vm
Date: Thu, 21 Jan 2016 18:39:34 +1100
Message-Id: <1453361977-19589-4-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1453361977-19589-1-git-send-email-aik@ozlabs.ru>
References: <1453361977-19589-1-git-send-email-aik@ozlabs.ru>
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

This changes release_spapr_tce_table() to store @npages on stack to
avoid calling kvmppc_stt_npages() in the loop (tiny optimization,
probably).

This does not change the amount of (de)allocated memory.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v2:
* switched from long to unsigned long types
* added WARN_ON_ONCE() in locked_vm decrement case
---
 arch/powerpc/kvm/book3s_64_vio.c | 55 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 9526c34..ea498b4 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -39,19 +39,62 @@
 
 #define TCES_PER_PAGE	(PAGE_SIZE / sizeof(u64))
 
-static long kvmppc_stt_npages(unsigned long window_size)
+static unsigned long kvmppc_stt_npages(unsigned long window_size)
 {
 	return ALIGN((window_size >> SPAPR_TCE_SHIFT)
 		     * sizeof(u64), PAGE_SIZE) / PAGE_SIZE;
 }
 
+static long kvmppc_account_memlimit(unsigned long npages, bool inc)
+{
+	long ret = 0;
+	const unsigned long bytes = sizeof(struct kvmppc_spapr_tce_table) +
+			(npages * sizeof(struct page *));
+	const unsigned long stt_pages = ALIGN(bytes, PAGE_SIZE) / PAGE_SIZE;
+
+	if (!current || !current->mm)
+		return ret; /* process exited */
+
+	npages += stt_pages;
+
+	down_write(&current->mm->mmap_sem);
+
+	if (inc) {
+		unsigned long locked, lock_limit;
+
+		locked = current->mm->locked_vm + npages;
+		lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
+		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
+			ret = -ENOMEM;
+		else
+			current->mm->locked_vm += npages;
+	} else {
+		if (WARN_ON_ONCE(npages > current->mm->locked_vm))
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
+	unsigned long npages = kvmppc_stt_npages(stt->window_size);
 
-	for (i = 0; i < kvmppc_stt_npages(stt->window_size); i++)
+	for (i = 0; i < npages; i++)
 		__free_page(stt->pages[i]);
 
 	kfree(stt);
@@ -89,6 +132,7 @@ static int kvm_spapr_tce_release(struct inode *inode, struct file *filp)
 
 	kvm_put_kvm(stt->kvm);
 
+	kvmppc_account_memlimit(kvmppc_stt_npages(stt->window_size), false);
 	call_rcu(&stt->rcu, release_spapr_tce_table);
 
 	return 0;
@@ -103,7 +147,7 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 				   struct kvm_create_spapr_tce *args)
 {
 	struct kvmppc_spapr_tce_table *stt = NULL;
-	long npages;
+	unsigned long npages;
 	int ret = -ENOMEM;
 	int i;
 
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
2.5.0.rc3
