Return-Path: <spopovyc@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yr6rv3c7GzDsPq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Dec 2017 01:36:47 +1100 (AEDT)
From: Serhii Popovych <spopovyc@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, michael@ellerman.id.au,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 david@gibson.dropbear.id.au
Subject: [PATCH v2 1/2] KVM: PPC: Book3S HV: Drop prepare_done from struct
 kvm_resize_hpt and cleanups
Date: Mon,  4 Dec 2017 09:36:41 -0500
Message-Id: <1512398202-8195-2-git-send-email-spopovyc@redhat.com>
In-Reply-To: <1512398202-8195-1-git-send-email-spopovyc@redhat.com>
References: <1512398202-8195-1-git-send-email-spopovyc@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the kvm_resize_hpt structure has two fields relevant to the
state of an ongoing resize: 'prepare_done', which indicates whether
the worker thread has completed or not, and 'error' which indicates
whether it was successful or not.

Since the success/failure isn't known until completion, this is
confusingly redundant.  This patch consolidates the information into
just the 'error' value: -EBUSY indicates the worked is still in
progress, other negative values indicate (completed) failure, 0
indicates successful completion.

As a bonus this reduces size of struct kvm_resize_hpt by
__alignof__(struct kvm_hpt_info) and saves few bytes of code.

While there correct comment in struct kvm_resize_hpt which references
a non-existent semaphore (leftover from an early draft).

Assert with WARN_ON() in case of HPT allocation thread work runs more
than once for resize request or resize_hpt_allocate() returns -EBUSY
that is treated specially.

Change comparison against zero to make checkpatch.pl happy.

Signed-off-by: Serhii Popovych <spopovyc@redhat.com>
[dwg: Changed BUG_ON()s to WARN_ON()s and altered commit message for
 clarity]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 44 +++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 9660972..31fa710 100644
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
 
@@ -1433,15 +1439,23 @@ static void resize_hpt_prepare_work(struct work_struct *work)
 	struct kvm *kvm = resize->kvm;
 	int err;
 
+	if (WARN_ON(resize->error != -EBUSY))
+		return;
+
 	resize_hpt_debug(resize, "resize_hpt_prepare_work(): order = %d\n",
 			 resize->order);
 
 	err = resize_hpt_allocate(resize);
 
+	/* We have strict assumption about -EBUSY
+	 * when preparing for HPT resize.
+	 */
+	if (WARN_ON(err == -EBUSY))
+		err = -EINPROGRESS;
+
 	mutex_lock(&kvm->lock);
 
 	resize->error = err;
-	resize->prepare_done = true;
 
 	mutex_unlock(&kvm->lock);
 }
@@ -1466,14 +1480,12 @@ long kvm_vm_ioctl_resize_hpt_prepare(struct kvm *kvm,
 
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
@@ -1493,6 +1505,8 @@ long kvm_vm_ioctl_resize_hpt_prepare(struct kvm *kvm,
 		ret = -ENOMEM;
 		goto out;
 	}
+
+	resize->error = -EBUSY;
 	resize->order = shift;
 	resize->kvm = kvm;
 	INIT_WORK(&resize->work, resize_hpt_prepare_work);
@@ -1547,16 +1561,12 @@ long kvm_vm_ioctl_resize_hpt_commit(struct kvm *kvm,
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
