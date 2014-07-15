Return-Path: <aik@ozlabs.ru>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E7ED81A01E6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:45 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 15 Jul 2014 19:25:45 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B5E2D2BB0023
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:42 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6F930Wb63832184
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:03:00 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6F9PfKX022407
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:42 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 10/13] KVM: PPC: Fix kvmppc_gpa_to_hva_and_get() to return
 host physical address
Date: Tue, 15 Jul 2014 19:25:30 +1000
Message-Id: <1405416333-12477-11-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1405416333-12477-1-git-send-email-aik@ozlabs.ru>
References: <1405416333-12477-1-git-send-email-aik@ozlabs.ru>
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

The existing support of emulated devices does not need to calculate
a host physical address as the translation is performed by the userspace.

The upcoming support of VFIO needs it as it stores host physical
addresses in the real hardware TCE table which hardware uses during DMA
transfer. This translation could be done using page struct object
which is returned by kvmppc_gpa_to_hva_and_get().

However kvmppc_gpa_to_hva_and_get() does not return valid page struct
for huge pages to avoid possible bugs with excessive page releases.

This extends kvmppc_gpa_to_hva_and_get() to return a physical page address.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kvm/book3s_64_vio.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 8250521..573fd6d 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -321,7 +321,7 @@ fail:
  * and returns ERROR_ADDR if failed.
  */
 static void __user *kvmppc_gpa_to_hva_and_get(struct kvm_vcpu *vcpu,
-		unsigned long gpa, struct page **pg)
+		unsigned long gpa, struct page **pg, unsigned long *phpa)
 {
 	unsigned long hva, gfn = gpa >> PAGE_SHIFT;
 	struct kvm_memory_slot *memslot;
@@ -337,6 +337,10 @@ static void __user *kvmppc_gpa_to_hva_and_get(struct kvm_vcpu *vcpu,
 		if (get_user_pages_fast(hva & PAGE_MASK, 1, is_write, pg) != 1)
 			return ERROR_ADDR;
 
+		if (phpa)
+			*phpa = __pa((unsigned long) page_address(*pg)) |
+				(hva & ~PAGE_MASK);
+
 		/*
 		 * Check if this GPA is taken care of by the hash table.
 		 * If this is the case, do not show the caller page struct
@@ -404,7 +408,7 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 		return ret;
 
 	idx = srcu_read_lock(&vcpu->kvm->srcu);
-	tces = kvmppc_gpa_to_hva_and_get(vcpu, tce_list, NULL);
+	tces = kvmppc_gpa_to_hva_and_get(vcpu, tce_list, NULL, NULL);
 	if (tces == ERROR_ADDR) {
 		ret = H_TOO_HARD;
 		goto unlock_exit;
-- 
2.0.0
