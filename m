Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CDE606A8B2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 02:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CPHScZw0
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQhbq0Hmvz3bZm;
	Fri, 13 Nov 2026 13:51:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794538294;
	cv=none; b=LM+4nm/iEH9JjKtRBuB3FO5UU/7O5Fbl2AyyYJ1pVtWJgd+/XuEFrTV80Vj+XiJaJYCExBwdQviGZ51ddwxme9AfxPiCdNpLLqrcQGVobshUsn8ycu7jf7iShujh3n1/KiE4viyEsxps473N6QmjpEaCpPp6uoZSGLVamzPnBmwXZFeTYo3DpAjraA5jERyozr+MZBpGTSP5OzVyPdZzJzQUIq9SJ231Snh590vB2ka19f9W75eOaixgy5E/glSgGkCLtGRezBofxvz0YGXsFMe0vJj5EYdsLGXnYslgd5Acn0KMzOUNRFEwDh9CtmFFPRnYr94XQSgY7ZEwhyd6hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794538294; c=relaxed/relaxed;
	bh=541U14IJrP2hrNeb4y3odC8xzLwDlMERY6cgBOIWeKs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l2TkaTKIvHV0k2LxMd7XrrpwdpsNJ0tsXJhqUUtZr+dCosNC4HmGylr1EFTUB2aEspkClKkJ0JgbSmKpTh5YhC3xlj6IjTkxyL3D3kq9DQ5JyewgpntHhbGgPjrzLJroqz1s6VEeZ8Yf29ybbD5giNx2iBfRcdfS2w0A/fFW4aX3gIeilOoyKoacj+kkDAZ3lJzLzr28Ccq4bEP/uVGeTYSUTmX7hxz2YtAYi4kR5/xX79lklio1fJxV9Lx4XMa7WM0T9jniIZHB7Fkv+bls0k6p5qaSxfY1RRxUXdrHKNnjNBD6W6mnzE7EpPflNZpbKG+ixMSiRKHBNXEDsoQb9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CPHScZw0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122a; helo=mail-dl1-x122a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CPHScZw0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122a; helo=mail-dl1-x122a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122a.google.com (mail-dl1-x122a.google.com [IPv6:2607:f8b0:4864:20::122a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQhbn6KPrz2xnh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 13:51:33 +1100 (AEDT)
Received: by mail-dl1-x122a.google.com with SMTP id a92af1059eb24-15dd124bbe7so324525c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 18:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794538292; x=1795143092; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=541U14IJrP2hrNeb4y3odC8xzLwDlMERY6cgBOIWeKs=;
        b=CPHScZw0sQT66EIMb1eKvZggkhrzGTqY45eoi4Rkog6np4w03Ut5pAKCs6mSkjVHkG
         CklZGn7y1Tlb/DyVUVtXJWVXr83GUnhVG5iruReE+3+fla6ZV5wCsxDoXF6z7pw/APV9
         Yi30SMhoGXd4nyho5buDdlQiGJAs8Yt9qgcWX7Z+7bURqZn5Za1mRhpaFpe9tkQB5ZEK
         SbOKwySR/9Gfqz4tHVyx5ainn26Seocjioj18AMITWg1fwWzn520ndOl8x8/XKd93z0S
         2i9lO6agY+TzF3VS+IsEN0fxWRCggLQfoeSr31wZTeVh5D6wdFtH3bmRllQMxYItTuBG
         hhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794538292; x=1795143092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=541U14IJrP2hrNeb4y3odC8xzLwDlMERY6cgBOIWeKs=;
        b=qpXU0XRsFumMXjhAAq2p1BoAIxe5q74aD5fZNX2mg5PmZj1K7zZxHN14DRbHuF6bpz
         9skVgF1NyvqNdowSQJ60BHtvJ8F/H+4ERT5r+cWlrkolinP0m+qksmLNEyrTQUBKUTWa
         0xSJ58w/vyjTL/RwuhwMzyoReCqtCfVcqUZ/pSQwI9OE0wc5dUSfzd2AdpkqIUN0K1hy
         yhn0KwRdSdFBNyzHQRCUhnP5WXH+/DKFPW59rQIF71T3rbyictvaxKwD/1/ITpSjS9k+
         D682zy2UQOBOG8ltZBfZxb+apjF3D+Pw7okP88wmqPrO6ps/6YBqYQ7ba5pNPlWZRTqx
         bovA==
X-Gm-Message-State: APuU4Z/ZfVrun3CYZOQzX2+z9CBwYOco8C8IGkTXqFRbCaQP2lQv+6pA
	AFdWggjy6qvQweUVM3thBfdhsBlzsP4FOZPjrhPWTZV238SKHWwHqlUTkWJ5oA==
X-Gm-Gg: AYBFou1tP9eSbbg/1MYIIqtCBDEmpvOaxd9ZvsLrgw2ziIOJ89ynH9sCQjEq6VDgG4f
	k0+kVgJ04cDb5Il9Rs55sRvy1cNcicdE1ZzuFWK3WJmvA8z+EU4rJABo1svStiAnI9m9hBsjFYH
	HNSKih8NiSpm7+emfBd2CEdf3DYrAaClEt0XPjAQkyTgHxy6VHbxIqTtai/ble83YQSGBMiv3F4
	/oaAq5fQFkpQC/2oSFENOzwJyIWO6ldynW3PaZAulzw04v6YiI30FOXq7IenEFVR7FRyPlaZNWA
	r4+au+oVuTwsVYD+erTyX90SmFwFpSfY1z9MIX0WNLc+zFKiiZve9Ltl3J/aEyHrrhiff38XKUM
	LX8B27gLHHyh8XwfA+Cs7qpAKkJFFCuSRj/+hmkTvQHwK4RQtZiQe2TttPd7HKU9+1+XT4BRfSh
	hKBLIvuCzsjAxjQNMwxUD2X3jl3L1Ujx08OFOycourpFdNmn3qjTV3fRz/MqzCfjWMUkwOLS4vk
	WE8v49AOf/Ww+RSfguQZoQxnQRAi7B5ykdcWXx/kCzphjyFa2PfmfZUvGE4hU0mCzLCm8bmwEDc
	JnB8xi3nByFP8P/su12BJ8T72DcL5DzHKg==
X-Received: by 2002:a05:7022:3a82:b0:1b2:6855:998a with SMTP id a92af1059eb24-1b503199e7cmr1303894c88.34.1794538291748;
        Thu, 12 Nov 2026 18:51:31 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50319d40asm2853771c88.11.2026.11.12.18.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 18:51:31 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	linux-mm@kvack.org,
	kvm@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH 2/2] KVM: PPC: BOOK3S HV: Use ksm_disable() for secure guests
Date: Fri, 13 Nov 2026 08:21:14 +0530
Message-Id: <0500fbfbb98776091c89584155368610095b4dd5.1794537345.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <7510ddb55a34e8a669eb7c2624d652264701bfba.1794537345.git.ritesh.list@gmail.com>
References: <7510ddb55a34e8a669eb7c2624d652264701bfba.1794537345.git.ritesh.list@gmail.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Pages of a secure guest are moved to device private memory with
migrate_vma_*(), which can't be done for a KSM page. So, when a guest
wants to switch to secure mode, kvmppc_memslot_page_merge(), walks the
VMAs backing each memslot and calls for ksm_madvise(MADV_UNMERGEABLE) on
them. It does the reverse if the H_SVM_INIT_START fails or when the
memslot is getting deleted.

Instead of using ksm_madvise(), one can use ksm_disable() on the mm.
IIUC, ksm_disable() was introduced for this purpose itself in commit
  2c281f54f556e ("mm/ksm: move disabling KSM from s390/gmap code to KSM code").

Also, it seems there are other existing issues in current code.
For e.g. The current code can turn KSM on for the memory the VMM never
marked mergeable. This can happen say for a guest whose H_SVM_INIT_START
fails and therefore the cleanup routine ends up setting VM_MERGEABLE on
it's memory.

Note: This was spotted and reported in one of the series which was
converting legacy vm_flags_t to vma_flags_t, showing concern around why
powerpc has to call into an mm internal functions. Besides, this is the
only remaining user of ksm_madvise(), outside of mm.

Let's fix the existing issues and also address the reported concern.

Reported-by: David Hildenbrand (Arm) <david@kernel.org>
Closes: https://lore.kernel.org/linuxppc-dev/1c0b1368-a381-4b25-bba9-7a4f8e92b764@kernel.org/
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/include/asm/kvm_book3s_uvmem.h |  1 +
 arch/powerpc/kvm/book3s_hv_builtin.c        | 26 ++++++++
 arch/powerpc/kvm/book3s_hv_uvmem.c          | 69 ++++-----------------
 mm/ksm.c                                    |  1 -
 4 files changed, 40 insertions(+), 57 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_uvmem.h b/arch/powerpc/include/asm/kvm_book3s_uvmem.h
index 0a6319448cb6..c8cc11325639 100644
--- a/arch/powerpc/include/asm/kvm_book3s_uvmem.h
+++ b/arch/powerpc/include/asm/kvm_book3s_uvmem.h
@@ -27,6 +27,7 @@ int kvmppc_uvmem_memslot_create(struct kvm *kvm,
 		const struct kvm_memory_slot *new);
 void kvmppc_uvmem_memslot_delete(struct kvm *kvm,
 		const struct kvm_memory_slot *old);
+int kvmppc_uvmem_disable_ksm(struct mm_struct *mm);
 #else
 static inline int kvmppc_uvmem_init(void)
 {
diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
index fa0e3a22cac0..e39fc28a27a7 100644
--- a/arch/powerpc/kvm/book3s_hv_builtin.c
+++ b/arch/powerpc/kvm/book3s_hv_builtin.c
@@ -14,11 +14,14 @@
 #include <linux/sizes.h>
 #include <linux/cma.h>
 #include <linux/bitops.h>
+#include <linux/ksm.h>
+#include <linux/mmap_lock.h>

 #include <asm/cputable.h>
 #include <asm/interrupt.h>
 #include <asm/kvm_ppc.h>
 #include <asm/kvm_book3s.h>
+#include <asm/kvm_book3s_uvmem.h>
 #include <asm/machdep.h>
 #include <asm/xics.h>
 #include <asm/xive.h>
@@ -627,3 +630,26 @@ void kvmppc_check_need_tlb_flush(struct kvm *kvm, int pcpu)
 	}
 }
 EXPORT_SYMBOL_GPL(kvmppc_check_need_tlb_flush);
+
+#ifdef CONFIG_PPC_UV
+/*
+ * Pages of a secure guest are moved to device private memory one by one with
+ * migrate_vma_*(). This cannot be done to a KSM page, so the VM is not allowed
+ * to have any and neither get new ones. This functions stops KSM for the
+ * whole mm.
+ *
+ * This lives here and not with the rest of the secure guest code, because
+ * that can be built as a module and ksm_disable() is not exported.
+ */
+int kvmppc_uvmem_disable_ksm(struct mm_struct *mm)
+{
+	int ret;
+
+	mmap_write_lock(mm);
+	ret = ksm_disable(mm);
+	mmap_write_unlock(mm);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kvmppc_uvmem_disable_ksm);
+#endif
diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
index 190f64d992d8..fa50c103a9ee 100644
--- a/arch/powerpc/kvm/book3s_hv_uvmem.c
+++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
@@ -47,7 +47,7 @@
  * Locking order
  *
  * 1. kvm->srcu - Protects KVM memslots
- * 2. kvm->mm->mmap_lock - find_vma, migrate_vma_pages and helpers, ksm_madvise
+ * 2. kvm->mm->mmap_lock - find_vma, migrate_vma_pages and helpers, ksm_disable
  * 3. kvm->arch.uvmem_lock - protects read/writes to uvmem slots thus acting
  *			     as sync-points for page-in/out
  */
@@ -89,11 +89,9 @@
 #include <linux/pagemap.h>
 #include <linux/migrate.h>
 #include <linux/kvm_host.h>
-#include <linux/ksm.h>
 #include <linux/of.h>
 #include <linux/memremap.h>
 #include <asm/ultravisor.h>
-#include <asm/mman.h>
 #include <asm/kvm_ppc.h>
 #include <asm/kvm_book3s_uvmem.h>

@@ -388,78 +386,30 @@ static bool kvmppc_next_nontransitioned_gfn(const struct kvm_memory_slot *memslo
 	return ret;
 }

-static int kvmppc_memslot_page_merge(struct kvm *kvm,
-		const struct kvm_memory_slot *memslot, bool merge)
-{
-	unsigned long gfn = memslot->base_gfn;
-	unsigned long end, start = gfn_to_hva(kvm, gfn);
-	vm_flags_t vm_flags;
-	int ret = 0;
-	struct vm_area_struct *vma;
-	int merge_flag = (merge) ? MADV_MERGEABLE : MADV_UNMERGEABLE;
-
-	if (kvm_is_error_hva(start))
-		return H_STATE;
-
-	end = start + (memslot->npages << PAGE_SHIFT);
-
-	mmap_write_lock(kvm->mm);
-	do {
-		vma = find_vma_intersection(kvm->mm, start, end);
-		if (!vma) {
-			ret = H_STATE;
-			break;
-		}
-		vma_start_write(vma);
-		/* Copy vm_flags to avoid partial modifications in ksm_madvise */
-		vm_flags = vma->vm_flags;
-		ret = ksm_madvise(vma, vma->vm_start, vma->vm_end,
-			  merge_flag, &vm_flags);
-		if (ret) {
-			ret = H_STATE;
-			break;
-		}
-		vm_flags_reset(vma, vm_flags);
-		start = vma->vm_end;
-	} while (end > vma->vm_end);
-
-	mmap_write_unlock(kvm->mm);
-	return ret;
-}
-
 static void __kvmppc_uvmem_memslot_delete(struct kvm *kvm,
 		const struct kvm_memory_slot *memslot)
 {
 	uv_unregister_mem_slot(kvm->arch.lpid, memslot->id);
 	kvmppc_uvmem_slot_free(kvm, memslot);
-	kvmppc_memslot_page_merge(kvm, memslot, true);
 }

 static int __kvmppc_uvmem_memslot_create(struct kvm *kvm,
 		const struct kvm_memory_slot *memslot)
 {
-	int ret = H_PARAMETER;
-
-	if (kvmppc_memslot_page_merge(kvm, memslot, false))
-		return ret;
+	int ret;

 	if (kvmppc_uvmem_slot_init(kvm, memslot))
-		goto out1;
+		return H_PARAMETER;

 	ret = uv_register_mem_slot(kvm->arch.lpid,
 				   memslot->base_gfn << PAGE_SHIFT,
 				   memslot->npages * PAGE_SIZE,
 				   0, memslot->id);
 	if (ret < 0) {
-		ret = H_PARAMETER;
-		goto out;
+		kvmppc_uvmem_slot_free(kvm, memslot);
+		return H_PARAMETER;
 	}
 	return 0;
-out:
-	kvmppc_uvmem_slot_free(kvm, memslot);
-out1:
-	kvmppc_memslot_page_merge(kvm, memslot, true);
-	return ret;
 }

 unsigned long kvmppc_h_svm_init_start(struct kvm *kvm)
@@ -482,6 +432,9 @@ unsigned long kvmppc_h_svm_init_start(struct kvm *kvm)
 	if (!kvm->arch.svm_enabled)
 		return H_AUTHORITY;

+	if (kvmppc_uvmem_disable_ksm(kvm->mm))
+		return H_STATE;
+
 	srcu_idx = srcu_read_lock(&kvm->srcu);

 	/* register the memslot */
@@ -1107,8 +1060,12 @@ int kvmppc_send_page_to_uv(struct kvm *kvm, unsigned long gfn)

 int kvmppc_uvmem_memslot_create(struct kvm *kvm, const struct kvm_memory_slot *new)
 {
-	int ret = __kvmppc_uvmem_memslot_create(kvm, new);
+	int ret;
+
+	if (kvmppc_uvmem_disable_ksm(kvm->mm))
+		return H_STATE;

+	ret = __kvmppc_uvmem_memslot_create(kvm, new);
 	if (!ret)
 		ret = kvmppc_uv_migrate_mem_slot(kvm, new);

diff --git a/mm/ksm.c b/mm/ksm.c
index d24b129932bf..9d3db831ac87 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -3058,7 +3058,6 @@ int ksm_madvise(struct vm_area_struct *vma, unsigned long start,

 	return 0;
 }
-EXPORT_SYMBOL_GPL(ksm_madvise);

 int __ksm_enter(struct mm_struct *mm)
 {
--
2.39.5


