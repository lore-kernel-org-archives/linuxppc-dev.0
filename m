Return-Path: <linuxppc-dev+bounces-28690-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62BECA5FCE
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 20:23:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwjyh0B3dz3btX;
	Fri, 02 Oct 2026 06:22:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1048"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790886171;
	cv=none; b=P8TrIcXjR/dpuJxzMWVcEwrgoWcQ/l0V+eKJnOBD/2vmppKGxVbJrjcRYYA8fXBYjGIXdlyGrvWKn4yx/0oQMd/Fmcnozx6MSKCEh29hcHGT/QuC6kWMxM6BvofZ2dyVXjTFO02qXQxOUn4dH1PuhFVmGRjXf6XEBT86joFvJsRlZe9T4PaqdETAtvoIey5WCj4KL/F16vujDGxFBEYQuBuuSI9ifhGWQLSGC4MxPpPXHFJ8EJzPtByrezW4eFQySBBYy2Sp5HMs5rUS+lPHL3+rGTARQf9IwbkL0ZQ0242yUC5+Y9lRm0ZTv7TWi/YYInwaR7oQ4P0u6DeOT2oh/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790886171; c=relaxed/relaxed;
	bh=DkEUby8k1GuirLgDM70VkYF1zdud3CmFD1i1s3HAuxY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MsJIs0hGkfZuugZk8GIxhM5R9VXYrIluT3pa6PKZzFaXKeS757j1P6SR1U2haao16nNaPwSDzflH0ZXWGlk0a0nmWEXTzt6VGR/HqAh3oI5W5k+iB8azv7SfY1uvSZqE6D9cStat7h52y0inwWM7RqAt5DkrBLS4tcD/W2EwVU+965PhOwxPrTTP+VW0wSpv50sCKnke43NZyCGuK6SBZLSl38TWx9LX8ucbEQhn9Cs2Ta17yWMAyxEUNIUd9viAZmkqV0vqC8SvZzDzQ4S5kculqJc5iFlOjou0ZqwtgvPcU3oRqOL/XL5MJbIkjgArwui+odr7uxUdKPwC3FroWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=bsyMrI/d; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1048; helo=mail-pj1-x1048.google.com; envelope-from=3f8g-agykdpakwsfbuyggydw.ugedafmphhu-vwndaklk.grdstk.gjy@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=bsyMrI/d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::1048; helo=mail-pj1-x1048.google.com; envelope-from=3f8g-agykdpakwsfbuyggydw.ugedafmphhu-vwndaklk.grdstk.gjy@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1048.google.com (mail-pj1-x1048.google.com [IPv6:2607:f8b0:4864:20::1048])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwjyf5x2jz3brc
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 06:22:50 +1000 (AEST)
Received: by mail-pj1-x1048.google.com with SMTP id 98e67ed59e1d1-3a46f0f158dso1445299a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 13:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790886168; x=1791490968; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DkEUby8k1GuirLgDM70VkYF1zdud3CmFD1i1s3HAuxY=;
        b=bsyMrI/dZHQcUmQou3padwrYQ/Q8UBc8rg0E5zrE2Ndv7/d6PbWDy5bKSAXMmEN1YL
         ZOZ13ej9ycFt7blWTa43nzVGe9/mbGVwYgdzRyt5I6ONN7pmXORMMXIPxghWb6uOYFlE
         wIAFjpzw8CLhsQzWG2cI0kmMOA8qYuDp0cI4K1X1hl0gs1YFna5twgL2fQNrY2g9qdI9
         Fr+td9VX84UQMTnXHsoVyLteQQftAsJybrvsJ/n0KhRXgFyrigbWKKvVH1aPM8VdogVO
         3xxCeF85qbyfNGECF+Ne8pR5YZ+NhkJnxtfPtvNBin7oNp86c0P6Qd0dn3twUjLwtyYM
         AzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790886168; x=1791490968;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DkEUby8k1GuirLgDM70VkYF1zdud3CmFD1i1s3HAuxY=;
        b=vrbIaR0SCb4fpZ0vBS6MIb6O91W+0MSPfPQFdeibv6Eyu3PyuEz37iKbBlQaUuUnTn
         PmSS/kjU5wNipL67w+M/uhKkrxBJ2gbxTZSpP4IsihmIX9IkLfXIZEKWw/HDwJuBcMWq
         zv3p9OzO+HL8YjMv83iitPleHVKUA7kM3fHEULNwFzwXrZEozWs2pkG5QW8ITkrkNiGe
         4kijcjQRxl42ku5UB3PjO8VVbSOp7w26PB08PfVWcJTmBNnsKUXzdCn9MB3ZURl1h9k5
         DRRXlEn9uB9LTHsrRDd8gnD6VXGf4JNyv3WFZ2Y0wEd6RrhKUQ5OFqnqs/rJulzKHoHh
         9KsQ==
X-Forwarded-Encrypted: i=1; AKwUvBzKqL0ZqBGSEHNtRkjzfpWBU20iuyktO96ueEeAeexGq0mM/NeR2p9PFg7JNfvyOZS4DuJZy1kE+JAgy24=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYL+7OLq6NOMYm28HYEL237n9NGUY4T7jZvXk3lzKaXgDp3bQFem
	vGNUpOqlJk0yNwIHw0rkWY27Ik65ChH3lygfOc7NfAexBb3d5vF1z1Wuy4jDShcQNtCMCQg4dbp
	xRmbWvA==
X-Received: from pjrz11.prod.google.com ([2002:a17:90a:bd8b:b0:3a4:740f:e86f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:c2d0:b0:3a4:7195:ecba
 with SMTP id 98e67ed59e1d1-3a6ceae19b7mr344412a91.20.1790886167964; Thu, 01
 Oct 2026 13:22:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  1 Oct 2026 13:22:29 -0700
In-Reply-To: <20261001202234.3794060-1-seanjc@google.com>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
Mime-Version: 1.0
References: <20261001202234.3794060-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001202234.3794060-6-seanjc@google.com>
Subject: [PATCH v2 05/10] KVM: Destroy memslots immediately after
 mmu_notifiers are unregistered
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

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
index f368240aa1cd..770a2c3bd445 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -955,23 +955,42 @@ static void kvm_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
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
@@ -1302,12 +1321,10 @@ static void kvm_destroy_vm(struct kvm *kvm)
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
2.56.0.rc1.315.gc6ed9934b7-goog


