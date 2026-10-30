Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3139E606B79B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 21:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SMOYOVSk
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGYtx0T3Lz3bn8;
	Sat, 31 Oct 2026 08:21:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793395289;
	cv=none; b=ih/58zjg2cPnHlbTFIgg5pJ6Pxii95DhoWJNMLA+ixVdxCVksI4x07SyvXQ8O8e+24YIVhKkErH5XW8DIS8lfV5MpbnCBrWNWbmPA1sIK1zm+75300iDpZpb7P3vXopbJmgUWfLoRQaCOnHKn12l/diq0MzTxzf9acwJQgZDl6lRCniA6A13KpR3YLKNFXVZVS2zzbLvyzniddxVrcgsa0HHoRi3APHyP3wuxpzbcvqXY5tvPV7on9KwTXUxTXqqHJZOQ8gkg/+Q/GtK8Rb2RuKwOiXAAoUel+DeeeL6yIQs3vM6axMX1X8qZ8yH/qdSbYIeorTZXIBh2E1nHRk+qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793395289; c=relaxed/relaxed;
	bh=tBGgI/GpDCr73Zv/DH70VbcIjXcJZddwPYNf2j30K9E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SXo1qFowtcwSeBwXPWf5Xuc2JH409+l8f7YNZ9osUOvYsvKe2tgbZvjbIH83t6kuFtYRGAwyyfWep8br1zdFSFkxtjh8osP5bxbveHa1Phg9gqmgwrBLagZYloVQHBeZVsrwq/6kiGesMeTWmq1n0QDICZlvT5XpmqzRj/gb+72Dji6ulaCJnej+m0LDw0dG4Edl9pvjeVTUmFJPp842GFit5oQi/BJ+DbgcP16THeCTCh3q7VlvyIp1MN5A/aeFfIn5WXgwX5KGxWvU6Sy48QWh5SUTebSQXeDjlmjDnMLOiuANqDq2NhJ741Kn/yVX37ZvAhGTvkPbCP3ReNf4yw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SMOYOVSk; dkim-atps=neutral; spf=pass (client-ip=209.85.215.198; helo=mail-pg1-f198.google.com; envelope-from=3vqrlagykdfwm84hd6aiiaf8.6igfchorjj6-78pfcmnm.itf45m.ila@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SMOYOVSk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=209.85.215.198; helo=mail-pg1-f198.google.com; envelope-from=3vqrlagykdfwm84hd6aiiaf8.6igfchorjj6-78pfcmnm.itf45m.ila@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGYtw2cZKz3blr
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 08:21:28 +1100 (AEDT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cd8b299b05fso928697a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 14:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395286; x=1794000086; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tBGgI/GpDCr73Zv/DH70VbcIjXcJZddwPYNf2j30K9E=;
        b=SMOYOVSkb0JGJQiQWCa8cf7N84Cxn3R3ldW9eQvx5nnGK7NNdaw6WcJYvoAdCo3CfH
         wy5VCC6/NWCVfEgKW1w6ciJBMkz+wp/CCCA53l/BsRMq1yt8lPdG3Kehp5GCKHL1lQeX
         sWgWFw53C9G59/DNRVfLWNI88VdGMQfxdmb3Pv54JSgCGY3fG4VXyddHKgJ9cS6nqhdH
         C/AjoXl62bWL6WSBd82IAoPmgfQwTE+rwjYKjKCfGWchjYrJMFNC4cYRPThOrKRBk+CR
         oCAXEvns4latN8AxnErLPcq7T+QanBey7i15dQhgodrqc0vWccf88dOPi7pxwprxqTen
         /6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395286; x=1794000086;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tBGgI/GpDCr73Zv/DH70VbcIjXcJZddwPYNf2j30K9E=;
        b=UI8Rqdqx9fEXv2r5tPDPKRh8kWXj0/TTVPy70mndhHAt1N0v0SKKtQGwMo3kq6e386
         0paOUAgcpKV1gelrjXaKI6G3Qf0x4VfvjGuyzgD6kJNNtkGxrNmlLITrN/6arV9k+gHf
         d4y1c0lNNyn5k6g9jZlOOK6GQtaF4COdf39LhVnrFqiV9GxADa2kXMqflBJdRLl52RV2
         sAq3qVXs9okETShsBG1siGydYLlk+0VJWoUhg0BVXTMhHq006X+Nw9dwOEFiffyGQndg
         08w1rRIOJ+lUFI8RACcy1PkDmpHA1kzE9q8sijHR9u2zKHEjY7FCWKC2BwHdUOzU88si
         1Rgg==
X-Forwarded-Encrypted: i=1; AKwUvBzufw9HAaGS8mHi6NfVsaqse4Coq4DhMOtpEIvYUF7xqGdBedGYob4+oQHex+VbIsp25K68O0yUVno5TWs=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJFOCz8lB5w/ciWtXy+WNIxASUcf3FySygKVV/TZm03ALAJTCs3
	stICvZdGTbuGyjg7K+dsZappQ3Tjj1QIv7tyH1419l6HzK6acMUk+uxdotsHVjKrfnsz54P8oyJ
	JfbtHyg==
X-Received: from pglv12.prod.google.com ([2002:a63:150c:0:b0:cd8:bb6a:e38])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1bc1:b0:3e2:1a3e:395c
 with SMTP id adf61e73a8af0-3e928a51d5dmr3526269637.59.1793395285754; Fri, 30
 Oct 2026 14:21:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:20:58 -0700
In-Reply-To: <20261030212112.2598640-1-seanjc@google.com>
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
Mime-Version: 1.0
References: <20261030212112.2598640-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261030212112.2598640-11-seanjc@google.com>
Subject: [PATCH v4 10/23] KVM: x86: Map a separate VMA for each address space
 for internal memslots
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	James Houghton <jthoughton@google.com>, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use a separate VMA for each address space when installing internal memslots,
i.e. mmap() a separate VMA for the SMM memslot, and delete the TODO along
with the hack to only unmap() the SMM memslot when freeing memslots.  Use
an explicit shmem file (as opposed to the implicit shmem file created for
an anonymous MAP_SHARED mapping) so that both memslots' VMAs point at the
same backing page.

Note, using shmem_kernel_file_setup() directly is more or less equivalent
to shmem_zero_setup(), which is used for "MAP_SHARED | MAP_ANONYMOUS"
mappings; the only practical difference is the dentry name.

Return the virtual address of the non-SMM memslot mapping, as that memslot
is guaranteed to exist.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 62 +++++++++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0b94f981a2e1..8cb58040dd81 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -59,6 +59,7 @@
 #include <linux/irqbypass.h>
 #include <linux/sched/stat.h>
 #include <linux/sched/isolation.h>
+#include <linux/shmem_fs.h>
 #include <linux/mem_encrypt.h>
 #include <linux/suspend.h>
 #include <linux/smp.h>
@@ -10007,9 +10008,19 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 }
 
 static int x86_set_internal_memslot(struct kvm *kvm, int id, int as_id,
-				    gpa_t gpa, unsigned long hva, u32 size)
+				    gpa_t gpa, struct file *f, u32 size)
 {
 	struct kvm_userspace_memory_region2 m;
+	unsigned long hva;
+	int r;
+
+	if (f) {
+		hva = vm_mmap(f, 0, size, PROT_READ | PROT_WRITE, MAP_SHARED, 0);
+		if (IS_ERR_VALUE(hva))
+			return (long)hva;
+	} else {
+		hva = 0;
+	}
 
 	if (!size && !id_to_memslot(__kvm_memslots(kvm, as_id), id))
 		return 0;
@@ -10019,7 +10030,11 @@ static int x86_set_internal_memslot(struct kvm *kvm, int id, int as_id,
 	m.guest_phys_addr = gpa;
 	m.userspace_addr = hva;
 	m.memory_size = size;
-	return kvm_set_internal_memslot(kvm, &m);
+
+	r = kvm_set_internal_memslot(kvm, &m);
+	if (r && f)
+		vm_munmap(hva, size);
+	return r;
 }
 
 /**
@@ -10047,7 +10062,8 @@ static int x86_set_internal_memslot(struct kvm *kvm, int id, int as_id,
 void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 				      u32 size)
 {
-	unsigned long hva;
+	struct file *f __free(fput) = NULL;
+	struct kvm_memory_slot *slot;
 	int i, r;
 
 	lockdep_assert_held(&kvm->slots_lock);
@@ -10055,37 +10071,31 @@ void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 	if (WARN_ON(id >= KVM_MEM_SLOTS_NUM))
 		return ERR_PTR_USR(-EINVAL);
 
-	if (size && id_to_memslot(kvm_memslots(kvm), id))
-		return ERR_PTR_USR(-EEXIST);
-
 	if (size) {
-		/*
-		 * MAP_SHARED to prevent internal slot pages from being moved
-		 * by fork()/COW.
-		 */
-		hva = vm_mmap(NULL, 0, size, PROT_READ | PROT_WRITE,
-			      MAP_SHARED | MAP_ANONYMOUS, 0);
-		if (IS_ERR_VALUE(hva))
-			return (void __user *)hva;
-	} else {
-		hva = 0;
+		if (id_to_memslot(kvm_memslots(kvm), id))
+			return ERR_PTR_USR(-EEXIST);
+
+		f = shmem_kernel_file_setup("kvm_memslot", size, EMPTY_VMA_FLAGS);
+		if (IS_ERR(f))
+			return (void __user *)f;
 	}
 
 	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
-		r = x86_set_internal_memslot(kvm, id, i, gpa, hva, size);
+		r = x86_set_internal_memslot(kvm, id, i, gpa, f, size);
 		if (!r)
 			continue;
 
-		if (size) {
-			for (i--; i >= 0; i--)
-				x86_set_internal_memslot(kvm, id, i, gpa, 0, 0);
+		for (i--; i >= 0 && size; i--)
+			x86_set_internal_memslot(kvm, id, i, gpa, NULL, 0);
 
-			vm_munmap(hva, size);
-		}
 		return ERR_PTR_USR(r);
 	}
 
-	return (void __user *)hva;
+	slot = id_to_memslot(kvm_memslots(kvm), id);
+	if (WARN_ON_ONCE(!!size != !!slot))
+		return ERR_PTR_USR(-EIO);
+
+	return (void __user *)(slot ? slot->userspace_addr : 0);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(__x86_set_memory_region);
 
@@ -10158,12 +10168,8 @@ void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
 	 * unless the memory map has changed due to process exit or fd copying.
 	 * Leak the mapping on failure, e.g. if the task is killed.  Worst case
 	 * scenario, the page(s) will be reclaimed when the process exits.
-	 *
-	 * TODO: Allocate VMAs for each address space and drop the check on the
-	 *       as_id, which depends on freeing memslots from 0=>N-1.
 	 */
-	if (current->mm == kvm->mm && slot->id >= KVM_USER_MEM_SLOTS &&
-	    slot->as_id == (kvm_arch_nr_memslot_as_ids(kvm) - 1))
+	if (current->mm == kvm->mm && slot->id >= KVM_USER_MEM_SLOTS)
 		vm_munmap(slot->userspace_addr, slot->npages * PAGE_SIZE);
 }
 
-- 
2.56.0.385.gac671c819a-goog


