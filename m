Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3854F60A5BCA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 22:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EtJEqnr4
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDl8z0Fgcz2ygg;
	Wed, 28 Oct 2026 09:12:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1045"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793139138;
	cv=none; b=RPDlXIbMGeQE2C7jEPLoULPND6FLdeza3JO0JAs85U3/aKJEqPajD4Nh+VyfeK+7BhTzWV9OGmWWF/fe8ewFsGWbIrhx9fFVWeoAxO1bAoMWkyDfkpWAnWu0Mo8x8MklkQh3i4G5fSVoXmqui5UwT2oxqljfWNfzqHkswDTdarBLTvDPaNjGDfNVA0FNQl7vA9roJUo52PTstQfoGoS50mpf4omxDWIuOYPtkGTWpydx7tpZwSb067hSs4HfB0BebTHubuR6+HbuArun3OSb0pUpYu3iYQgu9fGLLWFn4gq72n7cy9Mt9u/pwKJObwl8St3EMB/RU3MnVBkZMnrhaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793139138; c=relaxed/relaxed;
	bh=GXFll2rwFr+11U65zmd4BD/o9D9qDEYJ5GKHj/mz+LA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OOojj2IKzBCgeh22j/gLHG6txcqO8VY/dt93LWk9bZcyIY8UsLC5wcmBQGc5IX9rVOnkNd0dnk6hWf9vGiarQCPp+Uoi5Wu3cVFMuuL6TYSt6tUGYv+9pVrrXBvecy91WpGgGD0DP1IIugnSh49uqa0K5F2OggDrGQul1ffQ7QjZm76Qf9FMTN45UlCDX7lAvQGqTyRynGLrMNjMzlNo4DtByTYqiC5w1n2BKLD7Bm2/J6cbrBbvLOmgPUbJ+Yo+T6r1ruecd51tYyS1Y4TfLUoxwd28mZ478Zk5emJn/7SKPZtc/3D/ylvKEWRUx6FQY79ygLky4mxRUoyVIENeRw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EtJEqnr4; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1045; helo=mail-pj1-x1045.google.com; envelope-from=3vyhhagykdoqykgtpimuumrk.iusrotadvvi-jkbroyzy.ufrghy.uxm@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EtJEqnr4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::1045; helo=mail-pj1-x1045.google.com; envelope-from=3vyhhagykdoqykgtpimuumrk.iusrotadvvi-jkbroyzy.ufrghy.uxm@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1045.google.com (mail-pj1-x1045.google.com [IPv6:2607:f8b0:4864:20::1045])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDl8x6jqxz2yVd
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 09:12:17 +1100 (AEDT)
Received: by mail-pj1-x1045.google.com with SMTP id 98e67ed59e1d1-3adf71ee6a5so438374a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 15:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793139135; x=1793743935; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GXFll2rwFr+11U65zmd4BD/o9D9qDEYJ5GKHj/mz+LA=;
        b=EtJEqnr4Rw/vakOGavnzb/IyRKiMB0VQzDclTgZgBNW4qojt9zKrc7CQ3wf63d3Wqs
         ulaeOc/pOr0jBtGwCbhEWcPi9R04L+X2At51RkBmoF1iN75qD7/BXc9pQ4AvLWoYFZNt
         JAI3kneR3RtuClji1+7E2ATR2vy2F0SEqUKY7tr7CsBsFNzfTx+whVPmf+f3U5ffJq97
         Ks1Hkq7RlhEKijceKE87bnkQ0mehCoayrj7BWh7s83d3XCJGbgSUdvsAH6x3aI09279u
         br/eP2VbEivh14ZnqdU3geYxNx1Oqd/O/sO99ojoZ4+dXKtE5/4rbZTz0lXeq0hDr8lY
         U4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793139135; x=1793743935;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GXFll2rwFr+11U65zmd4BD/o9D9qDEYJ5GKHj/mz+LA=;
        b=AEcLJS7W+vaCHjOIUcEAere1TZy58c46L/8EMC+noCvNpJqdf44ODbZz9o4FVKlJJ8
         e2jbzz8redJhwhELDWqFeDzJG4HDand5a3pbB40kMQmWZ8fYgkFuOCy8j08/41HSifrS
         pBDFXPVVdbbKzp5etN18XhtwgGsLLRKzyC8rmLoLOy0XSRwS3KRz20wSn19wf44bJYSG
         aCabiDAaxFvFYf72+qwx6ElDc7I7TBzm6+/FEQ7x6r1WkNCck2qg5gi8H36an2SYFxhc
         DkMsmV7lvaMtdODeARCR1xLT8oIdWYnoScgaSDuZV+YMes9vVG1WLpUvUDqA8bfvvkYM
         Ct0Q==
X-Forwarded-Encrypted: i=1; AKwUvBy80muD9x67YgcmCwZ+EChLvUVp164Ei/StjJZCRGB2MyICz2MvhKxSQjkxo79cY2mBLxRp4jvQk1odOgQ=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKIHxk3RgZxrziu7Usm5z/jtKrZgI3fO7Zupo2C66z1fCblMp48
	cb4avBtTJWDZ+HsfgpGhcXUDYHH0QtIyEGIiDoUbAjz6T5HTTQ3K4dNsU741iNCwUQlkdBdM93f
	VYUqIaQ==
X-Received: from pjtn20.prod.google.com ([2002:a17:90a:c694:b0:3ae:1810:840c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2645:b0:3ac:9d26:551d
 with SMTP id 98e67ed59e1d1-3ae58313b6dmr297261a91.50.1793139135013; Tue, 27
 Oct 2026 15:12:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 27 Oct 2026 15:11:56 -0700
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
Message-ID: <20261027221209.1560865-4-seanjc@google.com>
Subject: [PATCH v3 03/15] KVM: PPC: Flush/zap all memslots on kvm_arch_flush_shadow_all()
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

Flush/zap every memslot in kvm_arch_flush_shadow_all(), i.e. when the
owning userspace process is exiting, as KVM must ensure all associated
memory is unmapped from the guest.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/powerpc/include/asm/kvm_host.h |  1 -
 arch/powerpc/kvm/powerpc.c          | 11 +++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 708a32f89776..50a42f80e5f1 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -910,7 +910,6 @@ struct kvm_vcpu_arch {
 #define __KVM_HAVE_CREATE_DEVICE
 
 static inline void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen) {}
-static inline void kvm_arch_flush_shadow_all(struct kvm *kvm) {}
 static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu) {}
 static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {}
 
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 9194cf492d1c..9e9d0865c2f6 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -764,6 +764,17 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 	kvmppc_core_commit_memory_region(kvm, old, new, change);
 }
 
+void kvm_arch_flush_shadow_all(struct kvm *kvm)
+{
+	struct kvm_memory_slot *slot;
+	struct kvm_memslots *slots;
+	int bkt;
+
+	slots = kvm_memslots(kvm);
+	kvm_for_each_memslot(slot, bkt, slots)
+		kvmppc_core_flush_memslot(kvm, slot);
+}
+
 void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
 				   struct kvm_memory_slot *slot)
 {
-- 
2.56.0.307.g5fe7bd680c-goog


