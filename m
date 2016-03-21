Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qT22r6fs2zDq7K
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Mar 2016 14:52:20 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org,
	aik@ozlabs.ru,
	benh@kernel.crashing.org
Cc: bharata@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 michael@ellerman.id.au, David Gibson <david@gibson.dropbear.id.au>
Subject: [RFCv3 15/17] powerpc/kvm: KVM-HV HPT resizing, preparation path
Date: Mon, 21 Mar 2016 14:53:22 +1100
Message-Id: <1458532404-21258-16-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1458532404-21258-1-git-send-email-david@gibson.dropbear.id.au>
References: <1458532404-21258-1-git-send-email-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds code to initialize an HPT resize operation, and complete its
prepare phase, including allocating and clearing a tentative new HPT.  It
also includes corresponding code to free things afterwards.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 05e8d52..acc6dd4 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -54,6 +54,10 @@ struct kvm_resize_hpt {
 	/* These fields protected by kvm->lock */
 	int error;
 	bool prepare_done;
+
+	/* Private to the work thread, until prepare_done is true,
+	 * then protected by kvm->resize_hpt_sem */
+	struct kvm_hpt_info hpt;
 };
 
 #ifdef DEBUG_RESIZE_HPT
@@ -1157,6 +1161,17 @@ void kvmppc_unpin_guest_page(struct kvm *kvm, void *va, unsigned long gpa,
  */
 static int resize_hpt_allocate(struct kvm_resize_hpt *resize)
 {
+	int rc;
+
+	rc = kvmppc_allocate_hpt(&resize->hpt, resize->order);
+	if (rc == -ENOMEM)
+		return H_NO_MEM;
+	else if (rc < 0)
+		return H_HARDWARE;
+
+	resize_hpt_debug(resize, "resize_hpt_allocate(): HPT @ 0x%lx\n",
+			 resize->hpt.virt);
+
 	return H_SUCCESS;
 }
 
@@ -1172,6 +1187,10 @@ static void resize_hpt_pivot(struct kvm_resize_hpt *resize)
 static void resize_hpt_release(struct kvm *kvm, struct kvm_resize_hpt *resize)
 {
 	BUG_ON(kvm->arch.resize_hpt != resize);
+
+	if (resize->hpt.virt)
+		kvmppc_free_hpt(&resize->hpt);
+
 	kvm->arch.resize_hpt = NULL;
 	kfree(resize);
 }
-- 
2.5.0
