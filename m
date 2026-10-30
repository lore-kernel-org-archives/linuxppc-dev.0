Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EA3606B785
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 21:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SzCLGOGX
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGYtz3m9gz3bp0;
	Sat, 31 Oct 2026 08:21:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793395291;
	cv=none; b=VEFBl3QFakxZ8IaQjny16TmewQIGTLn+A6WRXW3c0ANt6Z6I/UK9RegU19Rp8VgAsDh4Pbc1OGkFwqylskmtSMpvvkV2yiCflGjkSvObOhMyQAsqmcV3igXxygywLfkmtd5YdBA/rriu0JvSxMhUgfPjagOmnjGjcR1HuXZyF4snf0TQlwf8TGVMGW3IoSZKSgerEZzbnUkd9qOSzfuRvBLCH3badwuiqACB6JjzchWkZ1WOYEjzYGfHqmX/HF+KC6TVdoxN9r5Nw6/y6B+f6zQoqQzLiKUktaSKiCmqqLKlCV55EQw7juaFFkYAnmewOu5ma4iQJM2qzGUnVNqZqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793395291; c=relaxed/relaxed;
	bh=RcX2YZRJWHg2bC94YnzCHmgguqsUuMXALdhLJOO1CSU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lBCQ35CKLTsNVN21ZhhJUuB3ctfwzMQ2xCMDpnGQuM8tcOcMcQSjIaQ2XCOBzJOY63TRHnAWy5Sss5xv5JRqW0amcPb7AkIY8/yCT81qExGgoDd6DffSqp1Ruqb313YnvkZ8Y6gKq+nCA11eDLZbs2PJXCUR5UV50Y8LwKvdGxrara8FmpjUodYlEdfwmuYbsJlpN3ez+UPlALYqYYT3al4dNw10UItes9MiQnv+oZBzPKc6XYPnm4fL96ew0u/yeP3njxJCo1jJ8ryuLLxObzAiOkbJN+bneya5w0PBupdA47wDm5a8C/zsSdttMHZT8hDESr1GseFhxIKlZE2bvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SzCLGOGX; dkim-atps=neutral; spf=pass (client-ip=209.85.214.197; helo=mail-pl1-f197.google.com; envelope-from=3warlagykdf8pb7kg9dlldib.9ljifkrumm9-absifpqp.lwi78p.lod@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SzCLGOGX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=209.85.214.197; helo=mail-pl1-f197.google.com; envelope-from=3warlagykdf8pb7kg9dlldib.9ljifkrumm9-absifpqp.lwi78p.lod@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGYty6l0Wz3bqh
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 08:21:30 +1100 (AEDT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e8dd9b9743so14562695ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 14:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395288; x=1794000088; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RcX2YZRJWHg2bC94YnzCHmgguqsUuMXALdhLJOO1CSU=;
        b=SzCLGOGXoPCgs/mdMzIjrCMfKyW5pCwSzqUIfGEgniKJ4VPHyZHrIBbLJEW2OJ5HSx
         qn2gLVLTsk5C7gevbEEk73o0GcL/D7fjbTizxUkXaad1ELXzfl5GqrBQkVU14dXpknKZ
         zMdmF93+/QsUq7mtYPyQZFrdLXue9zEyzA7b4kv0efYWhyJZ48jYMR2iUnlyuFtnn8Bf
         5D2BblxbUZnIZNj1qNr0geOQyonQWsqcPjN53L4Nj+fQQUB10zrVYTYTOIB9VANSlXHI
         YExCPX8Mzyvnfdm+ZjE46HXKHApLFXFvRRS4ohYiWjlubgdQE2kJGAjOU91Rov+pOeEQ
         DmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395288; x=1794000088;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RcX2YZRJWHg2bC94YnzCHmgguqsUuMXALdhLJOO1CSU=;
        b=kc7TecJ09UF3ya5pQK1JqXllIJElc0hOlD40sP9zif6lbPABH7tSKpzQPuLbhiDiwf
         yw2PZ1+KMQZKFOoqB365GllZkiQU02wf5isEUAJlJpwIevREUZQNMO+XEMTCa4/tq9QM
         7tQjEIt0GsOc5M5xpklhJi3PAIYQqwgrtwlNWQefEKByvEpbudW4FbFbRUPJmRM5WOk+
         MuyuX1cxpZoudx8o62EUyd6YP7rWSz3APdg/W57Si9coLJhOF0BC3vGIwx51O7WZUwLd
         gKe/872jhHF2keDWligjvRbFuYISNTM34a+27DmA1q2c1DFNtgsHbLFQzY1YxSvp2Vq8
         gCcw==
X-Forwarded-Encrypted: i=1; AKwUvBwcQS9y8AFaolDe+A3H9jlj+ZH6jwfxhdwlNBmIpBb5VgQc9EFvec2KHuPC/q4c8mlBsk0Hv/0abqFvc7c=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLaMMrAmH3aokd2Ye5QTnxStjCdRL1Qf1Js+Zm1n+W2YRFMXMFS
	AtnOVJMlWc8vA8Y2s1sH/acYXNVC1PFLkeFOLcBuLUb1O4VCloAapq8VqjhOVRAwgLxO2ZXrDtJ
	27JFFnw==
X-Received: from plbkn5.prod.google.com ([2002:a17:903:785:b0:2e9:6e08:e249])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a30:b0:2e3:598:75b8
 with SMTP id d9443c01a7336-2eb364b0dc1mr36320905ad.27.1793395288251; Fri, 30
 Oct 2026 14:21:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:21:00 -0700
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
Message-ID: <20261030212112.2598640-13-seanjc@google.com>
Subject: [PATCH v4 12/23] KVM: Destroy memslots immediately after
 mmu_notifiers are unregistered
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

Instally dummy, empty memslots immediately after unregistering KVM's
mmu_notifier during VM destruction to harden against accessing memory from
the wrong address space when tearing down a VM.  Because kvm_destroy_vm()
often runs when the associated VM's file is being released, current->mm is
often no longer kvm->mm, i.e. using the memslots to access userspace memory
is inherently broken/dangerous.

While KVM's APIs to read/write guest memory explicitly reject accesses if
current->mm != kvm->mm, taking away the memslots adds another layer of
defense and helps guard against rogue accesses that don't go through KVM's
standard API, or that do GUP+kmap().

Note, simply hoisting memslot destruction above kvm_arch_destroy_vm()
without installing dummy slots is not a viable alternative.  Doing so would
require auditing all the paths of kvm_arch_destroy_vm(), which is nearly
infeasible, and missing even one case would result in a NULL pointer
dereference and/or use-after-free, neither of which is a substantially
better outcome than the status quo.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 45 +++++++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index fa548b12228f..2eda12a52bf4 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -963,23 +963,42 @@ static void kvm_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
 	kfree(slot);
 }
 
-static void kvm_free_memslots(struct kvm *kvm, struct kvm_memslots *slots)
+static const struct kvm_memslots kvm_empty_memslots = {
+	.generation = -1ull,
+	.hva_tree = RB_ROOT_CACHED,
+	.gfn_tree = RB_ROOT,
+	.id_hash[0 ... (ARRAY_SIZE(kvm_empty_memslots.id_hash) - 1)] = HLIST_HEAD_INIT,
+	.node_idx = 0,
+};
+
+static void kvm_destroy_memslots(struct kvm *kvm)
 {
 	struct hlist_node *idnode;
 	struct kvm_memory_slot *memslot;
-	int bkt;
+	int bkt, i;
+
+	/*
+	 * Install empty memslots to guard against memslot lookups while the VM
+	 * is being destroyed.  Consuming memslots at this stage is a KVM bug,
+	 * but "gracefully do nothing" is a much better outcome than "crash the
+	 * host" or "corrupt random memory" when there inevitably is a bug.
+	 */
+	mutex_lock(&kvm->slots_lock);
+	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++)
+		rcu_assign_pointer(kvm->memslots[i], &kvm_empty_memslots);
+
+	synchronize_srcu_expedited(&kvm->srcu);
+	mutex_unlock(&kvm->slots_lock);
 
 	/*
 	 * The same memslot objects live in both active and inactive sets,
-	 * arbitrarily free using index '1' so the second invocation of this
-	 * function isn't operating over a structure with dangling pointers
-	 * (even though this function isn't actually touching them).
+	 * arbitrarily free using index '1'.
 	 */
-	if (!slots->node_idx)
-		return;
-
-	hash_for_each_safe(slots->id_hash, bkt, idnode, memslot, id_node[1])
-		kvm_free_memslot(kvm, memslot);
+	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
+		hash_for_each_safe(kvm->__memslots[i][1].id_hash, bkt, idnode,
+				   memslot, id_node[1])
+			kvm_free_memslot(kvm, memslot);
+	}
 }
 
 static umode_t kvm_stats_debugfs_mode(const struct kvm_stats_desc *desc)
@@ -1310,12 +1329,10 @@ static void kvm_destroy_vm(struct kvm *kvm)
 		kvm->mn_active_invalidate_count = 0;
 	else
 		WARN_ON(kvm->mmu_invalidate_in_progress);
+	kvm_destroy_memslots(kvm);
+
 	kvm_arch_destroy_vm(kvm);
 	kvm_destroy_devices(kvm);
-	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
-		kvm_free_memslots(kvm, &kvm->__memslots[i][0]);
-		kvm_free_memslots(kvm, &kvm->__memslots[i][1]);
-	}
 	cleanup_srcu_struct(&kvm->irq_srcu);
 	srcu_barrier(&kvm->srcu);
 	cleanup_srcu_struct(&kvm->srcu);
-- 
2.56.0.385.gac671c819a-goog


