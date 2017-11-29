Return-Path: <spopovyc@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yn5nf61g8zDql1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Nov 2017 03:38:30 +1100 (AEDT)
From: Serhii Popovych <spopovyc@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: michael@ellerman.id.au, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, david@gibson.dropbear.id.au
Subject: [PATCH 1/4] KVM: PPC: Book3S HV: Drop prepare_done from struct
 kvm_resize_hpt and cleanups
Date: Wed, 29 Nov 2017 11:38:23 -0500
Message-Id: <1511973506-65683-2-git-send-email-spopovyc@redhat.com>
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

Replace ->prepare_done flag functionality with special handling
of -EBUSY in ->error as indicator that allocation work is running.

Besides cosmetics this reduces size of struct kvm_resize_hpt by
__alignof__(struct kvm_hpt_info) and saves few bytes of code.

While there correct comment in struct kvm_resize_hpt about locking
used to protect access to certain fields.

Assert with BUG_ON() in case of HPT allocation thread work runs
more than once for resize request or resize_hpt_allocate()
returns -EBUSY that is treated specially.

Change comparison against zero to make checkpatch.pl happy.

Signed-off-by: Serhii Popovych <spopovyc@redhat.com>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 42 ++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 235319c..0534aab 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -65,11 +65,17 @@ struct kvm_resize_hpt {
 	u32 order;
 
 	/* These fields protected by kvm->lock */
+
+	/* Possible values and their usage:
+	 *  <0     an error occurred during allocation,
+	  * -EBUSY allocation is in the progress,
+	 *  0      allocation made successfuly.
+	 */
 	int error;
-	bool prepare_done;
 
-	/* Private to the work thread, until prepare_done is true,
-	 * then protected by kvm->resize_hpt_sem */
+	/* Private to the work thread, until error != -EBUSY,
+	 * then protected by kvm->lock.
+	 */
 	struct kvm_hpt_info hpt;
 };
 
@@ -1432,15 +1438,21 @@ static void resize_hpt_prepare_work(struct work_struct *work)
 	struct kvm *kvm = resize->kvm;
 	int err;
 
+	BUG_ON(resize->error != -EBUSY);
+
 	resize_hpt_debug(resize, "resize_hpt_prepare_work(): order = %d\n",
 			 resize->order);
 
 	err = resize_hpt_allocate(resize);
 
+	/* We have strict assumption about -EBUSY
+	 * when preparing for HPT resize.
+	 */
+	BUG_ON(err == -EBUSY);
+
 	mutex_lock(&kvm->lock);
 
 	resize->error = err;
-	resize->prepare_done = true;
 
 	mutex_unlock(&kvm->lock);
 }
@@ -1465,14 +1477,12 @@ long kvm_vm_ioctl_resize_hpt_prepare(struct kvm *kvm,
 
 	if (resize) {
 		if (resize->order == shift) {
-			/* Suitable resize in progress */
-			if (resize->prepare_done) {
-				ret = resize->error;
-				if (ret != 0)
-					resize_hpt_release(kvm, resize);
-			} else {
+			/* Suitable resize in progress? */
+			ret = resize->error;
+			if (ret == -EBUSY)
 				ret = 100; /* estimated time in ms */
-			}
+			else if (ret)
+				resize_hpt_release(kvm, resize);
 
 			goto out;
 		}
@@ -1492,6 +1502,8 @@ long kvm_vm_ioctl_resize_hpt_prepare(struct kvm *kvm,
 		ret = -ENOMEM;
 		goto out;
 	}
+
+	resize->error = -EBUSY;
 	resize->order = shift;
 	resize->kvm = kvm;
 	INIT_WORK(&resize->work, resize_hpt_prepare_work);
@@ -1546,16 +1558,12 @@ long kvm_vm_ioctl_resize_hpt_commit(struct kvm *kvm,
 	if (!resize || (resize->order != shift))
 		goto out;
 
-	ret = -EBUSY;
-	if (!resize->prepare_done)
-		goto out;
-
 	ret = resize->error;
-	if (ret != 0)
+	if (ret)
 		goto out;
 
 	ret = resize_hpt_rehash(resize);
-	if (ret != 0)
+	if (ret)
 		goto out;
 
 	resize_hpt_pivot(resize);
-- 
1.8.3.1
