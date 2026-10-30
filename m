Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B3A606A995
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 21:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Eo0iqUFr
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGYv811X5z3cGK;
	Sat, 31 Oct 2026 08:21:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793395300;
	cv=none; b=ASC8XIJ4nrV6xA2QRtu4a4ag+Ja3RN3oAne+E3vMHVnv2bE2oG2rbOAtQCyqAQe0s3Wp5SECFgQ0G/tN+qRlSo1A9I7DmH7jGF/U6Qz0rMdOx8RGSgf0168rQ6xhBOiS1CUwjUzpcbIjuq34b/vDxq/Ypx4Q6RYQSEFtBXEK0DToM+EYVE1sw8lfdUgAZFZ0R06SiNwtryZRLOgPnV/8z2OktTFKpKflZDZbwctA5bi3snvFeGrt3EAAtgobiqG6hbUUapCor7N2B+BlGLmTcAlim/q7g1lijcwQeWA6JrTdSVdJMbuT3fRqzW+yZnYirgCQzVZ/dXUe9CUVzszNtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793395300; c=relaxed/relaxed;
	bh=1RT2Hwd4eS7iM21uuSoBg92EWPQROZNPCWfD+pi67rE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ICGkKHdLlN26gozStWH7Q42790S8QDFnZt1kb3H9MaUPrlUtwgQfsndeb0Jw9aHr+JSiUWuzVLi+oB4eDr5kKBJhNlV3WDRRz/ku29SkvpgZO0vI0h9XhU0hcnjVX76aTeFt1ILpfJD0qEINa7x2xA8JC8ngujqvSmNifj7UkjZRXO3qxZJQnbknFovoAc1ZDfXiKs+woEj7iTtJ7fwyjN9j8RSy6Jk2D0uuNZgGoxBEbrWmYVg9rN5+lK3VVDbUiGuMKV7P6p4RaKJjGxreUa9kMkS0VjjYf+vM0pTLRqknYv7lpxEronSgiV78o941kdtw9uNQUgpSdrShVnhpjA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Eo0iqUFr; dkim-atps=neutral; spf=pass (client-ip=209.85.216.71; helo=mail-pj1-f71.google.com; envelope-from=3yarlagykdgcxjfsohlttlqj.htrqnszcuuh-ijaqnxyx.teqfgx.twl@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Eo0iqUFr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=209.85.216.71; helo=mail-pj1-f71.google.com; envelope-from=3yarlagykdgcxjfsohlttlqj.htrqnszcuuh-ijaqnxyx.teqfgx.twl@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGYv739qlz3cDT
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 08:21:39 +1100 (AEDT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ad53f538d2so1012352a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 14:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395297; x=1794000097; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1RT2Hwd4eS7iM21uuSoBg92EWPQROZNPCWfD+pi67rE=;
        b=Eo0iqUFrX/2Jplvs+IZKdNSRwoPFGlZw4QoosCzPLAIBAN/txTuwk2LbFj3B7z5XPY
         a8Le7enGpaqfrUomMGSBdAlb0vywEHf0dIuL1aX1k4X4V3ydFHfS7nyOD1INRqDw4r0v
         HU7wacZc4CkclP5QFNBsYqhuiY9pIEr51xyRLH2mQ1KJmcLFp6VR3BzmXyNo/uGyLRkF
         TdLVN3uMrpiqjzRp40wYg/TV6nKgW3GpMv+dOUfyiKOYpy/jcHh77N+1C3OwkW68EZBK
         cDEYVlmcd/XhrfgGILbV4UHRlFbTgj8b0rs75tP0zsNbsBHWOcpWWmZ5q5XBFIEaGJKi
         Ju9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395297; x=1794000097;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1RT2Hwd4eS7iM21uuSoBg92EWPQROZNPCWfD+pi67rE=;
        b=z/mOZIC7Jr+1lKbwWe+yhLg9ZsEw9e08pNmVmOpOmVW8saJ7naeheKgDxVOdAO9HgJ
         fzB+Jnfg17VP5LQQ24UvPrT+tFySC0Zww60eokgUiVcZ9jZod9mX+8g6VAPbfvn7mzPh
         99xcGh11x9DJWDe+q6yGpSAmGAfOvT4yZpaZCpLASDbLJlcErV5nejHJZOd57r950Tce
         XIi4NDGoGZC/UqyC9D3PWIT+xATFEAO5ewjWjuvjsgrrAHCaBNfGQlCfA6MEjYyzxt8L
         7F47DS+9MD2Zh0Nc8t1D2RYs/w2fcfVQmYlnsWazM4T1hePHhC5iKQPnL3X/sIxmTnwk
         UrNg==
X-Forwarded-Encrypted: i=1; AKwUvBzw4hofs39Faf7PYg7GDl2X2MQzZ/E7a7RqJelutGrni2z4UuU3nUABzWZoyNVzTjiYlFnOpmb32uOmZww=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJIFpoNuYVzIKykFuTCIZLcoWEeGEIslB1Q4l0sEcjRGPjV+4n2
	XPOQfB5uj9PS3H1pEzQBtqrGXl+LOGBhcieB2OCP0bIordDAqbZ1yCuEFPJ0eUpgxEnTfWMLlIc
	Y0HONuQ==
X-Received: from pjrm17.prod.google.com ([2002:a17:90a:b791:b0:3a8:6a28:2f71])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:264c:b0:3a7:d2b5:2e99
 with SMTP id 98e67ed59e1d1-3ae8970fd76mr2702613a91.20.1793395296953; Fri, 30
 Oct 2026 14:21:36 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:21:07 -0700
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
Message-ID: <20261030212112.2598640-20-seanjc@google.com>
Subject: [PATCH v4 19/23] KVM: Add lockdep-only APIs to query and assert that
 a vCPU is unreachable
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

Add an APIs to assert that a vCPU is unreachable, along with a helper to
deduplicate the "is unreachable" logic with the existing "assert the vCPU
is locked or unreachable".  The new assert API will be used by VMX to
ensure a not-so-innocuous vCPU teardown helper is really only used when
the vCPU is unreachable and being destroyed.

Disallow using the query API without lockdep to prevent it from being used
to make control-flow decisions in KVM.  Taking different actions based on
whether or not a vCPU is reachable isn't fundamentally broken, but would
all but guarantee other code _is_ flawed and/or brittle, e.g. that unwind
error code relies on common functionality to behave differently.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_host.h | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index ba8ea62b7304..28a0c01d6a55 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -984,11 +984,26 @@ static inline struct kvm_io_bus *kvm_get_bus(struct kvm *kvm, enum kvm_bus idx)
 					 lockdep_is_held(&kvm->slots_lock));
 }
 
+static inline bool kvm_is_vcpu_unreachable(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * There is no actual dependency on lockdep, but generally speaking KVM
+	 * shouldn't be making runtime decisions based on whether or not a vCPU
+	 * is reachable.
+	 */
+	BUILD_BUG_ON(!IS_ENABLED(CONFIG_LOCKDEP));
+	return vcpu->vcpu_idx < 0 || !refcount_read(&vcpu->kvm->users_count);
+}
+
+static inline void kvm_lockdep_assert_vcpu_is_unreachable(struct kvm_vcpu *vcpu)
+{
+	lockdep_assert_once(kvm_is_vcpu_unreachable(vcpu));
+}
+
 static inline void kvm_lockdep_assert_vcpu_is_locked_or_unreachable(struct kvm_vcpu *vcpu)
 {
 	lockdep_assert_once(lockdep_is_held(&vcpu->mutex) ||
-			    vcpu->vcpu_idx < 0 ||
-			    !refcount_read(&vcpu->kvm->users_count));
+			    kvm_is_vcpu_unreachable(vcpu));
 }
 
 static inline struct kvm_vcpu *kvm_get_vcpu(struct kvm *kvm, int i)
-- 
2.56.0.385.gac671c819a-goog


