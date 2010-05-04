Return-Path: <takuya.yoshikawa@gmail.com>
Received: from mail-px0-f170.google.com (mail-px0-f170.google.com
	[209.85.212.170]) by ozlabs.org (Postfix) with ESMTP id 5B559B7D1A
	for <linuxppc-dev@ozlabs.org>; Tue,  4 May 2010 22:58:58 +1000 (EST)
Received: by pxi18 with SMTP id 18so1788631pxi.15
	for <linuxppc-dev@ozlabs.org>; Tue, 04 May 2010 05:58:56 -0700 (PDT)
Date: Tue, 4 May 2010 21:58:54 +0900
From: Takuya Yoshikawa <takuya.yoshikawa@gmail.com>
To: Takuya Yoshikawa <takuya.yoshikawa@gmail.com>
Subject: [RFC][PATCH 1/12 applied today] KVM: x86: avoid unnecessary bitmap
	allocation when memslot is clean
Message-Id: <20100504215854.cd46c959.takuya.yoshikawa@gmail.com>
In-Reply-To: <20100504215645.6448af8f.takuya.yoshikawa@gmail.com>
References: <20100504215645.6448af8f.takuya.yoshikawa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-arch@vger.kernel.org, x86@kernel.org, arnd@arndb.de,
	kvm@vger.kernel.org, kvm-ia64@vger.kernel.org,
	fernando@oss.ntt.co.jp, mtosatti@redhat.com, agraf@suse.de,
	kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
	yoshikawa.takuya@oss.ntt.co.jp, linuxppc-dev@ozlabs.org,
	mingo@redhat.com, paulus@samba.org, avi@redhat.com,
	hpa@zytor.com, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Although we always allocate a new dirty bitmap in x86's get_dirty_log(),
it is only used as a zero-source of copy_to_user() and freed right after
that when memslot is clean. This patch uses clear_user() instead of doing
this unnecessary zero-source allocation.

Performance improvement: as we can expect easily, the time needed to
allocate a bitmap is completely reduced. Furthermore, we can avoid the
tlb flush triggered by vmalloc() and get some good effects. In my test,
the improved ioctl was about 4 to 10 times faster than the original one
for clean slots.

Signed-off-by: Takuya Yoshikawa <yoshikawa.takuya@oss.ntt.co.jp>
---
 arch/x86/kvm/x86.c |   37 +++++++++++++++++++++++--------------
 1 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6b2ce1d..b95a211 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2744,7 +2744,6 @@ int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm,
 	struct kvm_memory_slot *memslot;
 	unsigned long n;
 	unsigned long is_dirty = 0;
-	unsigned long *dirty_bitmap = NULL;
 
 	mutex_lock(&kvm->slots_lock);
 
@@ -2759,27 +2758,30 @@ int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm,
 
 	n = kvm_dirty_bitmap_bytes(memslot);
 
-	r = -ENOMEM;
-	dirty_bitmap = vmalloc(n);
-	if (!dirty_bitmap)
-		goto out;
-	memset(dirty_bitmap, 0, n);
-
 	for (i = 0; !is_dirty && i < n/sizeof(long); i++)
 		is_dirty = memslot->dirty_bitmap[i];
 
 	/* If nothing is dirty, don't bother messing with page tables. */
 	if (is_dirty) {
 		struct kvm_memslots *slots, *old_slots;
+		unsigned long *dirty_bitmap;
 
 		spin_lock(&kvm->mmu_lock);
 		kvm_mmu_slot_remove_write_access(kvm, log->slot);
 		spin_unlock(&kvm->mmu_lock);
 
-		slots = kzalloc(sizeof(struct kvm_memslots), GFP_KERNEL);
-		if (!slots)
-			goto out_free;
+		r = -ENOMEM;
+		dirty_bitmap = vmalloc(n);
+		if (!dirty_bitmap)
+			goto out;
+		memset(dirty_bitmap, 0, n);
 
+		r = -ENOMEM;
+		slots = kzalloc(sizeof(struct kvm_memslots), GFP_KERNEL);
+		if (!slots) {
+			vfree(dirty_bitmap);
+			goto out;
+		}
 		memcpy(slots, kvm->memslots, sizeof(struct kvm_memslots));
 		slots->memslots[log->slot].dirty_bitmap = dirty_bitmap;
 
@@ -2788,13 +2790,20 @@ int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm,
 		synchronize_srcu_expedited(&kvm->srcu);
 		dirty_bitmap = old_slots->memslots[log->slot].dirty_bitmap;
 		kfree(old_slots);
+
+		r = -EFAULT;
+		if (copy_to_user(log->dirty_bitmap, dirty_bitmap, n)) {
+			vfree(dirty_bitmap);
+			goto out;
+		}
+		vfree(dirty_bitmap);
+	} else {
+		r = -EFAULT;
+		if (clear_user(log->dirty_bitmap, n))
+			goto out;
 	}
 
 	r = 0;
-	if (copy_to_user(log->dirty_bitmap, dirty_bitmap, n))
-		r = -EFAULT;
-out_free:
-	vfree(dirty_bitmap);
 out:
 	mutex_unlock(&kvm->slots_lock);
 	return r;
-- 
1.7.0.4
