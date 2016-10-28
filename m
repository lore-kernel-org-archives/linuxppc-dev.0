Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t4rKp664XzDvR7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 15:26:06 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9S4PRuu107104
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 00:26:04 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26bvc1sv55-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 00:26:04 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Fri, 28 Oct 2016 14:26:00 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id BBCE02BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 15:25:56 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9S4PuL310944630
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 15:25:56 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9S4PtXp022213
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 15:25:56 +1100
From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org,
 xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org, x86@kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mingo@redhat.com, peterz@infradead.org, paulmck@linux.vnet.ibm.com,
 will.deacon@arm.com, kernellwp@gmail.com, jgross@suse.com,
 pbonzini@redhat.com, bsingharora@gmail.com, boqun.feng@gmail.com,
 borntraeger@de.ibm.com, rkrcmar@redhat.com, David.Laight@ACULAB.COM,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v6 07/11] KVM: Introduce kvm_write_guest_offset_cached
Date: Fri, 28 Oct 2016 04:11:23 -0400
In-Reply-To: <1477642287-24104-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1477642287-24104-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Message-Id: <1477642287-24104-8-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It allows us to update some status or field of one struct partially.

We can also save one kvm_read_guest_cached if we just update one filed
of the struct regardless of its current value.

Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 include/linux/kvm_host.h |  2 ++
 virt/kvm/kvm_main.c      | 20 ++++++++++++++------
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 01c0b9c..6f00237 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -645,6 +645,8 @@ int kvm_write_guest(struct kvm *kvm, gpa_t gpa, const void *data,
 		    unsigned long len);
 int kvm_write_guest_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 			   void *data, unsigned long len);
+int kvm_write_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
+			   void *data, int offset, unsigned long len);
 int kvm_gfn_to_hva_cache_init(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 			      gpa_t gpa, unsigned long len);
 int kvm_clear_guest_page(struct kvm *kvm, gfn_t gfn, int offset, int len);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 2907b7b..95308ee 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1972,30 +1972,38 @@ int kvm_gfn_to_hva_cache_init(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 }
 EXPORT_SYMBOL_GPL(kvm_gfn_to_hva_cache_init);
 
-int kvm_write_guest_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
-			   void *data, unsigned long len)
+int kvm_write_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
+			   void *data, int offset, unsigned long len)
 {
 	struct kvm_memslots *slots = kvm_memslots(kvm);
 	int r;
+	gpa_t gpa = ghc->gpa + offset;
 
-	BUG_ON(len > ghc->len);
+	BUG_ON(len + offset > ghc->len);
 
 	if (slots->generation != ghc->generation)
 		kvm_gfn_to_hva_cache_init(kvm, ghc, ghc->gpa, ghc->len);
 
 	if (unlikely(!ghc->memslot))
-		return kvm_write_guest(kvm, ghc->gpa, data, len);
+		return kvm_write_guest(kvm, gpa, data, len);
 
 	if (kvm_is_error_hva(ghc->hva))
 		return -EFAULT;
 
-	r = __copy_to_user((void __user *)ghc->hva, data, len);
+	r = __copy_to_user((void __user *)ghc->hva + offset, data, len);
 	if (r)
 		return -EFAULT;
-	mark_page_dirty_in_slot(ghc->memslot, ghc->gpa >> PAGE_SHIFT);
+	mark_page_dirty_in_slot(ghc->memslot, gpa >> PAGE_SHIFT);
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(kvm_write_guest_offset_cached);
+
+int kvm_write_guest_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
+			   void *data, unsigned long len)
+{
+	return kvm_write_guest_offset_cached(kvm, ghc, data, 0, len);
+}
 EXPORT_SYMBOL_GPL(kvm_write_guest_cached);
 
 int kvm_read_guest_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
-- 
2.4.11
