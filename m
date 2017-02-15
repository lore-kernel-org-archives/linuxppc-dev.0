Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNQ621TCFzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 14:40:10 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org
Cc: dan.carpenter@oracle.com, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH] KVM: Prevent double-free on HPT resize commit path
Date: Wed, 15 Feb 2017 14:40:04 +1100
Message-Id: <20170215034004.9255-1-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

resize_hpt_release(), called once the HPT resize of a KVM guest is
completed (successfully or unsuccessfully) free()s the state structure for
the resize.  It is currently not safe to call with a NULL pointer.

However, one of the error paths in kvm_vm_ioctl_resize_hpt_commit() can
invoke it with a NULL pointer.  This will occur if userspace improperly
invokes KVM_PPC_RESIZE_HPT_COMMIT without previously calling
KVM_PPC_RESIZE_HPT_PREPARE, or if it calls COMMIT twice without an
intervening PREPARE.

To fix this potential crash bug - and maybe others like it, make it safe
(and a no-op) to call resize_hpt_release() with a NULL resize pointer.

Found by Dan Carpenter with a static checker.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 013552f..72ccac2 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -1407,6 +1407,9 @@ static void resize_hpt_release(struct kvm *kvm, struct kvm_resize_hpt *resize)
 {
 	BUG_ON(kvm->arch.resize_hpt != resize);
 
+	if (!resize)
+		return;
+
 	if (resize->hpt.virt)
 		kvmppc_free_hpt(&resize->hpt);
 
-- 
2.9.3
