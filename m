Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3664B606A327
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 22:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KmNLoJKD
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDl914zn1z30T8;
	Wed, 28 Oct 2026 09:12:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::548"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793139141;
	cv=none; b=DnKVzzdxV8C6tg41pN7FrrGmWH6DYk+8/WgsgpZq58jYSo7BsaVkgKtvvKIR/OxzgNcfGT2X6S9Lj+AouYx2tWIVS/aQ+LwF71YRMBdaiibcTLmtQ0xGppdDqdJC6qAj8YI8u0uyaZZv0pT5d5kowlPAQyX14ov1G3ROJTQPrE8FN1C3HjpBG+3ZcyboTK8HA/f65K/bQRqlAyPXmspmqBDbRD63EBO6yGpHv9AKHKYbd2X0CEc4lPMBlprRYMnzG/Lw9LRlS9hqSF7Z7K/ymV/aLKpNLXunpbaA3JsehZZqcZWqP0oma03aNkjzYANcbekCdKA18Fz2V351N0D+pw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793139141; c=relaxed/relaxed;
	bh=Na27bDyEPgeDt12EX7VPW4wAyW1QKigeaVHb8mXSq+Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=owFaEHXNKC4M2uVHf4JV1AwXh45KvXTC11qY4ONyEWmzx+Z5h1VQUXu5eZfBN4xGLS91/uZ9JPpvOelBL2iO5FAb2RxL6486KfVyEjgiViH4MDKaGODOU5l9A8AAs1NXe2yJPiMIqyJOPua+fiLtY9+usUjfz+gJCiXRxNZeZzbvLcFFm0zksPjgcEwqmdpg428UpmrWJeHDLdxW6WiE+O75hGqOoVWUIY8lYNMwXpKs8TVVjmfsree16cq0PuSf7Ju1L3CxiImUrwivsOs3vUMFhJCs/xzdKTDKiRNrNOjVvmMKw/ZEJHGn7tPIVE6466rKfM8VlLxBbfvWxU3aDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KmNLoJKD; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::548; helo=mail-pg1-x548.google.com; envelope-from=3wihhagykdocbnjwslpxxpun.lxvurwdgyyl-mneurbcb.xiujkb.xap@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KmNLoJKD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::548; helo=mail-pg1-x548.google.com; envelope-from=3wihhagykdocbnjwslpxxpun.lxvurwdgyyl-mneurbcb.xiujkb.xap@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x548.google.com (mail-pg1-x548.google.com [IPv6:2607:f8b0:4864:20::548])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDl906Kk6z30NF
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 09:12:20 +1100 (AEDT)
Received: by mail-pg1-x548.google.com with SMTP id 41be03b00d2f7-cd5ca3840c5so431523a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 15:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793139139; x=1793743939; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Na27bDyEPgeDt12EX7VPW4wAyW1QKigeaVHb8mXSq+Y=;
        b=KmNLoJKDMsQAGo2pCNVXP0wMTM8QFuCCAwnDTdxhICcgMOeEKE/JE6ZGT2IbTs2LmG
         NzNvGHluBojn+mCJV680Z4fPM3IIodfqK1D0eO4WZcAun7RcqqdLaAc6U8a+EKwtUrfi
         QdTQUf7XRFiZ2259txCc+BzWUqz0XPlbUYF8ZmNzvXEvSU+q/JIvPpZhTZM2AgDjCMFz
         Hu3OsfF5v4iTpjQwpJ9itUnQhS+cvPvqIQfAt+uLC4xndGNouxu16k3KahzigjGWVtxl
         raIlCQONjNbAnCYtijpE9CT37rIAApaqViHMj/s/t21zwD6Xtce0USvJg9FMexndnbyE
         vvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793139139; x=1793743939;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Na27bDyEPgeDt12EX7VPW4wAyW1QKigeaVHb8mXSq+Y=;
        b=SLJOA//2xdWSmV/XN4IulL3KnYgbPhvmutBDbC7NUx6KXHRVJxXZGYilLhVBhMB6Ya
         XUPIAWLTEh1sGood7ZLN+HCPVvqRQ/JfXH6ybINEUqkx/f3X58pUyjMlnalE/Pz5sPRP
         PTtyeorkmru9zsFGLR/g806znO0JIj5kn75CYkxb5FFHa7J8xspTsi1/7sOgsGwkjnEy
         DcatMawbYh49vwimmgxv0Jus5TOZXv8DmTq/m1/EsV0BM+QufPonAt1otsGnqWviF4gR
         mF344rcuVFOkqe/pwWl72inesmHuoTJN0fKdXEImfom5cQ9to8UbYk5F9lkGqkdX8lLt
         5S5Q==
X-Forwarded-Encrypted: i=1; AKwUvBwt6wUgbVaeKn6S0IRi+4D0aV0PGceq1zVnjRXfCmVGWqezqm9IXMFxBAPrMwRf5nAZpD4GRx1d0vMDwhk=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIDr6sIa8wDnRbfPuVoBoL7l0lbCMj6Ye98WpcAyiVBfwDT9Fmy
	CXq/48yGDoSr3CYIWEtf4XHahCkIyxLnUK+sx7SCszOoVihniOl3/BfBhcToFvS/EZnqH99+TSg
	lo/WdaQ==
X-Received: from pgbcq7.prod.google.com ([2002:a05:6a02:4087:b0:cd5:f7a5:5490])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d48f:b0:3e2:4350:1527
 with SMTP id adf61e73a8af0-3e90232b765mr412509637.24.1793139138551; Tue, 27
 Oct 2026 15:12:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 27 Oct 2026 15:11:59 -0700
In-Reply-To: <20261027221209.1560865-1-seanjc@google.com>
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
References: <20261027221209.1560865-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027221209.1560865-7-seanjc@google.com>
Subject: [PATCH v3 06/15] KVM: Destroy memslots immediately after
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
index e7c89861632a..1058b864d427 100644
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
2.56.0.307.g5fe7bd680c-goog


