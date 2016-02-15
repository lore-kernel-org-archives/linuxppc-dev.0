Return-Path: <aik@ozlabs.ru>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 78E6C1A03EF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 12:56:42 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Mon, 15 Feb 2016 11:56:42 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B2E8C2BB005A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 12:56:38 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1F1uU7a62783684
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 12:56:38 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1F1u6iu013812
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 12:56:06 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel v3 4/7] KVM: PPC: Account TCE-containing pages in
 locked_vm
Date: Mon, 15 Feb 2016 12:55:06 +1100
Message-Id: <1455501309-47200-5-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1455501309-47200-1-git-send-email-aik@ozlabs.ru>
References: <1455501309-47200-1-git-send-email-aik@ozlabs.ru>
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
tool can call ioctl(KVM_CREATE_SPAPR_TCE) as many times as
RLIMIT_NOFILE and lock a lot of memory.

This adds counting for pages used for TCE tables.

This counts the number of pages required for a table plus pages for
the kvmppc_spapr_tce_table struct (TCE table descriptor) itself.

This changes release_spapr_tce_table() to store @npages on stack to
avoid calling kvmppc_stt_npages() in the loop (tiny optimization,
probably).

This does not change the amount of used memory.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v3:
* s/kvmppc_stt_npages/kvmppc_tce_pages/ as it returns the number of pages
occupied by TCE table
* added kvmppc_stt_pages() which returns total number of pages (TCE +
struct + all page*) to be accounted in locked_vm

v2:
* switched from long to unsigned long types
* added WARN_ON_ONCE() in locked_vm decrement case
---
 arch/powerpc/kvm/book3s_64_vio.c | 63 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 58 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 9526c34..1a1e14f 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -39,19 +39,65 @@
 
 #define TCES_PER_PAGE	(PAGE_SIZE / sizeof(u64))
 
-static long kvmppc_stt_npages(unsigned long window_size)
+static unsigned long kvmppc_tce_pages(unsigned long window_size)
 {
 	return ALIGN((window_size >> SPAPR_TCE_SHIFT)
 		     * sizeof(u64), PAGE_SIZE) / PAGE_SIZE;
 }
 
+static unsigned long kvmppc_stt_pages(unsigned long tce_pages)
+{
+	unsigned long stt_bytes = sizeof(struct kvmppc_spapr_tce_table) +
+			(tce_pages * sizeof(struct page *));
+
+	return tce_pages + ALIGN(stt_bytes, PAGE_SIZE) / PAGE_SIZE;
+}
+
+static long kvmppc_account_memlimit(unsigned long stt_pages, bool inc)
+{
+	long ret = 0;
+
+	if (!current || !current->mm)
+		return ret; /* process exited */
+
+	down_write(&current->mm->mmap_sem);
+
+	if (inc) {
+		unsigned long locked, lock_limit;
+
+		locked = current->mm->locked_vm + stt_pages;
+		lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
+		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
+			ret = -ENOMEM;
+		else
+			current->mm->locked_vm += stt_pages;
+	} else {
+		if (WARN_ON_ONCE(stt_pages > current->mm->locked_vm))
+			stt_pages = current->mm->locked_vm;
+
+		current->mm->locked_vm -= stt_pages;
+	}
+
+	pr_debug("[%d] RLIMIT_MEMLOCK KVM %c%ld %ld/%ld%s\n", current->pid,
+			inc ? '+' : '-',
+			stt_pages << PAGE_SHIFT,
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
+	unsigned long npages = kvmppc_tce_pages(stt->window_size);
 
-	for (i = 0; i < kvmppc_stt_npages(stt->window_size); i++)
+	for (i = 0; i < npages; i++)
 		__free_page(stt->pages[i]);
 
 	kfree(stt);
@@ -62,7 +108,7 @@ static int kvm_spapr_tce_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
 	struct kvmppc_spapr_tce_table *stt = vma->vm_file->private_data;
 	struct page *page;
 
-	if (vmf->pgoff >= kvmppc_stt_npages(stt->window_size))
+	if (vmf->pgoff >= kvmppc_tce_pages(stt->window_size))
 		return VM_FAULT_SIGBUS;
 
 	page = stt->pages[vmf->pgoff];
@@ -89,6 +135,8 @@ static int kvm_spapr_tce_release(struct inode *inode, struct file *filp)
 
 	kvm_put_kvm(stt->kvm);
 
+	kvmppc_account_memlimit(
+		kvmppc_stt_pages(kvmppc_tce_pages(stt->window_size)), false);
 	call_rcu(&stt->rcu, release_spapr_tce_table);
 
 	return 0;
@@ -103,7 +151,7 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 				   struct kvm_create_spapr_tce *args)
 {
 	struct kvmppc_spapr_tce_table *stt = NULL;
-	long npages;
+	unsigned long npages;
 	int ret = -ENOMEM;
 	int i;
 
@@ -113,7 +161,12 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 			return -EBUSY;
 	}
 
-	npages = kvmppc_stt_npages(args->window_size);
+	npages = kvmppc_tce_pages(args->window_size);
+	ret = kvmppc_account_memlimit(kvmppc_stt_pages(npages), true);
+	if (ret) {
+		stt = NULL;
+		goto fail;
+	}
 
 	stt = kzalloc(sizeof(*stt) + npages * sizeof(struct page *),
 		      GFP_KERNEL);
-- 
2.5.0.rc3
