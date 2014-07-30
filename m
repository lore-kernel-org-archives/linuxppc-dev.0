Return-Path: <aik@ozlabs.ru>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D4FE11A01A4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 19:31:44 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Wed, 30 Jul 2014 19:31:43 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 207112BB002D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 19:31:41 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6U9Eaao64618742
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 19:14:36 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6U9VepC031264
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 19:31:40 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 04/16] KVM: PPC: Account TCE-containing pages in locked_vm
Date: Wed, 30 Jul 2014 19:31:23 +1000
Message-Id: <1406712695-9491-5-git-send-email-aik@ozlabs.ru>
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

At the moment pages used for TCE tables (not pages addressed by TCEs) are
not counter in locked_vm counter so a malicious userspace tool can
call ioctl(KVM_CREATE_SPAPR_TCE) as many times as RLIMIT_NOFILE and
lock a lot of memory.

This adds counting for pages used for TCE tables.

This counts the number of pages required for a table plus pages for
the kvmppc_spapr_tce_table struct (TCE table descriptor) itself.

This does not change the amount of (de)allocated memory.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v4:
* fixed counting for kvmppc_spapr_tce_table (used to be +1 page)
* added 2 helpers to common MM code for later reuse from vfio-spapr
---
 arch/powerpc/kvm/book3s_64_vio.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 5958f7d..b32aeb1 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -45,16 +45,33 @@ static long kvmppc_stt_npages(unsigned long window_size)
 		     * sizeof(u64), PAGE_SIZE) / PAGE_SIZE;
 }
 
+static long kvmppc_account_memlimit(long npages, bool inc)
+{
+	long stt_pages = ALIGN(sizeof(struct kvmppc_spapr_tce_table) +
+			(abs(npages) * sizeof(struct page *)), PAGE_SIZE);
+
+	npages += stt_pages;
+	if (inc)
+		return try_increment_locked_vm(npages);
+
+	decrement_locked_vm(npages);
+
+	return 0;
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
 	kvm_put_kvm(stt->kvm);
 	kfree(stt);
+
+	kvmppc_account_memlimit(npages, false);
 }
 
 static int kvm_spapr_tce_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
@@ -115,6 +132,9 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 	}
 
 	npages = kvmppc_stt_npages(args->window_size);
+	ret = kvmppc_account_memlimit(npages, true);
+	if (ret)
+		goto fail;
 
 	stt = kzalloc(sizeof(*stt) + npages * sizeof(struct page *),
 		      GFP_KERNEL);
-- 
2.0.0
