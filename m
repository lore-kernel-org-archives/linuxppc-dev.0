Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2D2606BF88
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 19:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PsT9POWq
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFGwC3my3z30DH;
	Thu, 29 Oct 2026 06:03:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::548"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793214187;
	cv=none; b=AQ0yKkkmHX2J9lW1R0pXgxNyJvowfd5GHQkVMnDsSTbony45Gzb8MAaXGmZRKXCk5GMGjb9jDriWfEesZhfc9NsLJPQgpdTAY7BdNpq7idhqMsi29Jo+gKuMYasljJA1lln/56y9H3cgk5jPuYDJ28wcr4omGtNIF/XD/MH4fM4rnbWSxFOUSLM/dXabtGKDCd59Rq+eEqyt/i93hUJeX25ZS8Pb8eT9crc/SEBuqBT1C0YRxexWaDM549x76ageNAh4osbs5asrTZbv8priOPkrrXI9phxLMz66utQqSxzX4J98MowZbA0DLLXnveubY5TSwaojUqpFoXNqA6gIbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793214187; c=relaxed/relaxed;
	bh=ua8GfkfDrHDUR8px+Sy19+vmLzFSWzTq6VAHh+SakiE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jWvaGZPnzxZpJ5mF1/EwTEli19ux1VHf7nuAccCRZIZPuYa1noJdgySRZJH3ovLWUwqiEuVSs+D/qgh5z9n923cM7ksvxCjnAtnnoT7FMxcLr8DMi7bhkQe3iZHmvWLRRFkaTadeXs4vqbwlXJ5/CFaR0vvUi0Bzgvch6iC6hZ2fQlLpwa/fvTWcgPYlvWu8UAuenZyFpC0h3km0lhf7LdzRBnQglOFRvzMlAYj9ehZxf4/gBqO7ZFRIpFRVfMKYGrkrEBRy/af405mwi3wHH/5tEAtsWD8uyuxlMz+hQcuYl2A47+cOIGYhHFbDsMn4HPV8gffKJd2I9nuCMYrQOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PsT9POWq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::548; helo=mail-pg1-x548.google.com; envelope-from=36ebiagykdf0n95ie7bjjbg9.7jhgdipskk7-89qgdnon.jug56n.jmb@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PsT9POWq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::548; helo=mail-pg1-x548.google.com; envelope-from=36ebiagykdf0n95ie7bjjbg9.7jhgdipskk7-89qgdnon.jug56n.jmb@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x548.google.com (mail-pg1-x548.google.com [IPv6:2607:f8b0:4864:20::548])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFGwB4ztYz2yqq
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 06:03:06 +1100 (AEDT)
Received: by mail-pg1-x548.google.com with SMTP id 41be03b00d2f7-cd8b7226694so650795a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 12:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793214184; x=1793818984; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ua8GfkfDrHDUR8px+Sy19+vmLzFSWzTq6VAHh+SakiE=;
        b=PsT9POWqUtJwv/Rx9Mtm4HrHaXasq7qcE0U9g0aPewzWgqM+kjPTF4zj9FUBsDGq9E
         x7Z1IqhybcFMkguVUfASEJKhQQfiOmNCB8+Vo3q6DM0owsHq9q4ociR09a4YXp0Ru7f6
         j4obl1+8U8WpkbQSl7WC4ImVcxgMkWESYJFU0928W64e0iK5JmR9v+OT63lCJzMgK1b4
         tThy6mtpFoFc/wB2wYtq2e28EKaKS8YKWnYYEHcD6C97QrempbQndbl6K51gREhcmvFB
         ZLPz3CxGptwZvAJu8hO1PWtfsEVA5pZkq9ffDyVzkBMuvoe7tFDNzR4eC60zqBEUdgFX
         ua6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793214184; x=1793818984;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ua8GfkfDrHDUR8px+Sy19+vmLzFSWzTq6VAHh+SakiE=;
        b=eEoqjwvVLdUmHzGf1BYkqFAqFI76KRe1hdWm/bq5J0fJab6hyOR5P/bXJHuwLcdGqY
         e9vXHgYN5QzFp0EUFG62uvHUI/2aZjCVDpMfzPdIVzTGK6Y9F+wHT3Tn0YYyASN7u40n
         c7/U+jG0q78p4Aqa2KcqI621RKp1QnWc6IAL29vn+4q3etb1j9XkU8zIyrAfEeDE9+4I
         VMS1Xd7VwlHpJm/n0cBNyhPuffNIBkGqhIw7AUmBKJCmBRay0T/gKInSt925/BfpLhZ3
         5YkxF5vLE2qMZYOFNpKWp0cBXfAB6QNgWNodUkSAqwchBdUoDDZtxwwW4AR9QT6J+Gf1
         whSg==
X-Forwarded-Encrypted: i=1; AKwUvBxRYeD/mJZw3VoKn/BbhGvl278+szGPiAQFBRQgX+RDQSW4xFPvVH1RF6AjZJT3rJbYCR2G2t7XCqcS7cw=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLNCJ+77ugiFJjKY7g2u+jx1xMRrzTi7fdetBElpX+9vBAQiqP0
	rYJPeKQkuUt2F7FtPOWjkdkrC82+7C+1hfSAsfuBnVkFzkHFzp+2b+EAJDm/9eIKbtfkeMpvU08
	/aZjs3Q==
X-Received: from pjbov14.prod.google.com ([2002:a17:90b:258e:b0:3a8:d9d:78ef])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:224f:b0:3a0:b312:1fbe
 with SMTP id 98e67ed59e1d1-3ae580a7ac7mr2187674a91.23.1793214184152; Wed, 28
 Oct 2026 12:03:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 28 Oct 2026 12:02:54 -0700
In-Reply-To: <20261028190259.1819571-1-seanjc@google.com>
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
References: <20261028190259.1819571-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261028190259.1819571-3-seanjc@google.com>
Subject: [PATCH 2/7] KVM: Add a @force param to __kvm_vcpu_kick() for PPC
 backwards compatibility
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Plumb in a @force param to __kvm_vcpu_kick() to force an IPI without
checking kvm_arch_vcpu_should_kick().  The param will be used to drop
kvm_arch_vcpu_should_kick() in favor of kvm_request_needs_ipi() without
regressing PPC, which for unknown reasons unconditionally blasts an IPI
in a variety of kvm_vcpu_kick() flows.

No functional change intended (nothing yet passes in @force=true).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_host.h |  6 +++---
 virt/kvm/kvm_main.c      | 10 +++++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index e7fc94e2910a..3b9844c3906d 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1570,11 +1570,11 @@ void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu);
 bool kvm_vcpu_wake_up(struct kvm_vcpu *vcpu);
 
 #ifndef CONFIG_S390
-void __kvm_vcpu_kick(struct kvm_vcpu *vcpu, bool wait);
+void __kvm_vcpu_kick(struct kvm_vcpu *vcpu, bool wait, bool force);
 
 static inline void kvm_vcpu_kick(struct kvm_vcpu *vcpu)
 {
-	__kvm_vcpu_kick(vcpu, false);
+	__kvm_vcpu_kick(vcpu, false, false);
 }
 #endif
 
@@ -2315,7 +2315,7 @@ static __always_inline void kvm_make_request(int req, struct kvm_vcpu *vcpu)
 static inline void kvm_make_request_and_kick(int req, struct kvm_vcpu *vcpu)
 {
 	kvm_make_request(req, vcpu);
-	__kvm_vcpu_kick(vcpu, req & KVM_REQUEST_WAIT);
+	__kvm_vcpu_kick(vcpu, req & KVM_REQUEST_WAIT, false);
 }
 #endif
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index cf4cb586f140..67addb9e48a7 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3908,7 +3908,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_wake_up);
 /*
  * Kick a sleeping VCPU, or a guest VCPU in guest mode, into host kernel mode.
  */
-void __kvm_vcpu_kick(struct kvm_vcpu *vcpu, bool wait)
+void __kvm_vcpu_kick(struct kvm_vcpu *vcpu, bool wait, bool force)
 {
 	int me, cpu;
 
@@ -3933,9 +3933,13 @@ void __kvm_vcpu_kick(struct kvm_vcpu *vcpu, bool wait)
 	 * after kvm_arch_vcpu_should_kick(), which could result in sending an
 	 * IPI to the previous pCPU.  But, that's ok because the purpose of the
 	 * IPI is to force the vCPU to leave IN_GUEST_MODE, and migrating the
-	 * vCPU also requires it to leave IN_GUEST_MODE.
+	 * vCPU also requires it to leave IN_GUEST_MODE
+	 *
+	 * Note #2, do NOT check if an IPI is needed if @force is true, as the
+	 * check also modifies vcpu->mode and KVM PPC needs to avoid that side
+	 * effect for unknown historical reasons.
 	 */
-	if (kvm_arch_vcpu_should_kick(vcpu)) {
+	if (force || kvm_arch_vcpu_should_kick(vcpu)) {
 		cpu = READ_ONCE(vcpu->cpu);
 		if (cpu != me && (unsigned int)cpu < nr_cpu_ids && cpu_online(cpu)) {
 			/*
-- 
2.56.0.313.g2479322e68-goog


