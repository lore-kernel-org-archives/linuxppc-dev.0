Return-Path: <spopovyc@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yn5nh40yTzDqkJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Nov 2017 03:38:32 +1100 (AEDT)
From: Serhii Popovych <spopovyc@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: michael@ellerman.id.au, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, david@gibson.dropbear.id.au
Subject: [PATCH 4/4] KVM: PPC: Book3S HV: Remove redundant parameter from
 resize_hpt_release()
Date: Wed, 29 Nov 2017 11:38:26 -0500
Message-Id: <1511973506-65683-5-git-send-email-spopovyc@redhat.com>
In-Reply-To: <1511973506-65683-1-git-send-email-spopovyc@redhat.com>
References: <1511973506-65683-1-git-send-email-spopovyc@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is no need to pass it explicitly from the caller:
struct kvm_resize_hpt already contains it.

Additional benefit from this change is that BUG_ON()
assertion now checks that mutex is held on kvm instance
associated with resize structure we going to release.

Also kill check for resize being NULL to make code
simpler and we called with resize != NULL in all
places except kvm_vm_ioctl_resize_hpt_commit().

Signed-off-by: Serhii Popovych <spopovyc@redhat.com>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 690f061..a74a0ad 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -1415,12 +1415,11 @@ static void resize_hpt_pivot(struct kvm_resize_hpt *resize)
 	resize_hpt_debug(resize, "resize_hpt_pivot() done\n");
 }
 
-static void resize_hpt_release(struct kvm *kvm, struct kvm_resize_hpt *resize)
+static void resize_hpt_release(struct kvm_resize_hpt *resize)
 {
-	BUG_ON(!mutex_is_locked(&kvm->lock));
+	struct kvm *kvm = resize->kvm;
 
-	if (!resize)
-		return;
+	BUG_ON(!mutex_is_locked(&kvm->lock));
 
 	if (resize->error != -EBUSY) {
 		kvmppc_free_hpt(&resize->hpt);
@@ -1469,7 +1468,7 @@ static void resize_hpt_prepare_work(struct work_struct *work)
 	resize->error = err;
 
 	if (kvm->arch.resize_hpt != resize)
-		resize_hpt_release(kvm, resize);
+		resize_hpt_release(resize);
 
 	mutex_unlock(&kvm->lock);
 }
@@ -1499,13 +1498,13 @@ long kvm_vm_ioctl_resize_hpt_prepare(struct kvm *kvm,
 			if (ret == -EBUSY)
 				ret = 100; /* estimated time in ms */
 			else if (ret)
-				resize_hpt_release(kvm, resize);
+				resize_hpt_release(resize);
 
 			goto out;
 		}
 
 		/* not suitable, cancel it */
-		resize_hpt_release(kvm, resize);
+		resize_hpt_release(resize);
 	}
 
 	ret = 0;
@@ -1590,7 +1589,8 @@ long kvm_vm_ioctl_resize_hpt_commit(struct kvm *kvm,
 	kvm->arch.mmu_ready = 1;
 	smp_mb();
 out_no_hpt:
-	resize_hpt_release(kvm, resize);
+	if (resize)
+		resize_hpt_release(resize);
 	mutex_unlock(&kvm->lock);
 	return ret;
 }
-- 
1.8.3.1
