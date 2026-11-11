Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A042606A334
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 22:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=eSSA3SuQ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPyqy3Qbdz3blK;
	Thu, 12 Nov 2026 09:29:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794436174;
	cv=none; b=kdTOLP3/cz6ad0rCpQnirN6RLM1oot3r/d/j8FIUQ2Ro9NR/YIKzLI+GM4RJh6Jq4ZcYy41q6SWb349YE6eG9jIvsqkreQIVn+od2IZDi+P5U5hJzbP3Ip8Chpndt0blI3Swj/pg4CDPJLQKo6KimKTvyibIpMlzh+5asvFCIkInvdrCRAJJ8EXqIhPpwxxK3WYku/Yh2ZkDoEypO9PVVSF0gf1++Uvox3kw0nCq9GGEaCs3kpHVZdn9/VXoH9W8itANmW36xoQaXpjryNi6M5QSswPIGUyiCBVeKCrV2PGcreRYq8C1reC0Vl3y90IRQxunCvtslXHyfsyvU7EPHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794436174; c=relaxed/relaxed;
	bh=qg4dsdUWrHNUQGIYWhI/E4Pn9hGFAoeUGWOQoX7lETY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZKDODEDm1vc4UlAE9wx3p/q52br19n1u2k2VJ4B6em+yNOVbcLihRY0xeXI183A5RRDLW/w5z2tlc4S955qPkJGhamEEdNcExXJ3vvzd9ntuRAkgFtwqTFCSX4K39RyzAXRGkH2l54prIA9h2tv0iVdadD5bjwWHYZlzWKPZDYpwthXQi6z6Em716VA1HNJ7WKH1qBzk30Q4oDy/MrA2pBSK+CSZzmWd3MjhXiBF2lGt7w6f4wbUFyHM4yvvG6yLxZCb26EzChn6wvU6sgk70QZKM0X7rVflju76+T3k5WkwIRKY9o2CN8SXyJnbwHwV6+FJu/PaILJERiL6pnOqDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=eSSA3SuQ; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+abad5507353db368323c+8480+infradead.org+dwmw2@casper.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=eSSA3SuQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+abad5507353db368323c+8480+infradead.org+dwmw2@casper.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPyqj2XClz308Q
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 09:29:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=qg4dsdUWrHNUQGIYWhI/E4Pn9hGFAoeUGWOQoX7lETY=; b=eSSA3SuQlMt5A4ymjSKbZ4+3Y5
	AY9qhyQp3oXaXy6RZeBtmnzhVnanUq1wb//9yniM02VUx8As/MNIL3+jCss/Pb44IrMnQ8jh97dEj
	NskmtlWGnjyxGp3Weh8hZHxQHKl2NsRhd0hYgp3mnzZlqqiCj2GYFBx+AS/ZHqNGpBzrizzfWfS1I
	h/e/UOa93aiNYt9+86iVvc27QrIRdmR3iObd0qhfL4hQd0qwN8DMBTxkuwNtelg3jKpP3KN5gCHQy
	X/IuhYxTDKtWSR29mY6ON/CkeH1S81Sr4I+siXlOSI3cgyUQ4EVe2F3i+b13mubg+hBAlrOwNguw1
	H2Lq/5HQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRGoZ-0000000G3nj-3d0K;
	Wed, 11 Nov 2026 22:29:12 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRGoZ-0000000007v-2PTR;
	Wed, 11 Nov 2026 22:29:11 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	ashish.kalra@amd.com,
	michael.roth@amd.com,
	nsaenz@amazon.com,
	anelkz@amazon.de,
	James.Bottomley@HansenPartnership.com,
	Melody Wang <huibo.wang@amd.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	kvm-riscv@lists.infradead.org,
	x86@kernel.org,
	coconut-svsm@lists.linux.dev,
	joerg.roedel@amd.com,
	Mushahid Hussain <hmushi@amazon.co.uk>,
	Sriram Nambakam <snambakam@linux.microsoft.com>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 02/16] KVM: SVM: Derive the plane limit from the immutable VM type
Date: Wed, 11 Nov 2026 14:28:57 -0800
Message-ID: <20261111222911.477-3-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111222911.477-1-dwmw2@infradead.org>
References: <20260608144252.351443-1-joro@8bytes.org>
 <20261111222911.477-1-dwmw2@infradead.org>
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
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: David Woodhouse <dwmw@amazon.co.uk>

svm_max_planes() calls ____sev_snp_guest() without kvm->lock, from
KVM_CHECK_EXTENSION(KVM_CAP_PLANES). That races __sev_guest_init(),
which sets and rolls back sev->active/es_active/SNP_ACTIVE under
kvm->lock, and userspace can force the rollback (ASID exhaustion,
firmware init failure). It is exactly the rule
kvm_lockdep_assert_sev_lock_held() documents, dodged by using the
assertion-free helper. It also leaves KVM_CREATE_PLANE's pre-lock
bound check with a limit that can change under it.

Key SNP-ness off kvm->arch.vm_type == KVM_X86_SNP_VM instead, which is
fixed at VM creation. While there, tidy the max_planes plumbing:

 - floor sev_snp_max_planes() at 1, so a host CPUID reporting zero
   VMPLs cannot make the VM report no planes at all;
 - drop the sev_nr_vcpu_planes() declaration, which has no definition
   or caller;
 - drop the !CONFIG_KVM_AMD_SEV sev_snp_max_planes() stub, dead since
   its only caller sits under the same #ifdef (and its return type
   disagreed with the declaration).

Fixes the unlocked SEV state check in "kvm: svm: Implement max_planes
x86 operation".

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/kvm/20260608233359.644B01F00893@smtp.kernel.org/
Fixes: https://lore.kernel.org/all/20260608144252.351443-60-joro@8bytes.org/
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/svm/sev.c |  6 +++++-
 arch/x86/kvm/svm/svm.c | 11 ++++++++++-
 arch/x86/kvm/svm/svm.h |  2 --
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index bb61bdf9e336..fd7605e47216 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -6000,5 +6000,9 @@ bool sev_snp_blocked(enum inject_type type, struct kvm_vcpu *vcpu)
 
 int sev_snp_max_planes(struct kvm *kvm)
 {
-	return vmpl_levels;
+	/*
+	 * CPUID 0x8000001f EBX[15:12] is host-provided data; a zero there
+	 * must not report "no planes at all" (plane 0 always exists).
+	 */
+	return max(vmpl_levels, 1U);
 }
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 6cc070952b93..1848136f3bb9 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5517,7 +5517,16 @@ static void svm_free_plane(struct kvm_plane *plane)
 static unsigned svm_max_planes(struct kvm *kvm)
 {
 #ifdef CONFIG_KVM_AMD_SEV
-	if (____sev_snp_guest(kvm))
+	/*
+	 * Key SNP-ness off the immutable vm_type, not the mutable SEV
+	 * state: KVM_CHECK_EXTENSION(KVM_CAP_PLANES) reaches here with no
+	 * lock held, while __sev_guest_init() sets and rolls back
+	 * sev->active/es_active/SNP_ACTIVE under kvm->lock.  The VM type
+	 * is fixed at creation, so the lockless read neither races the
+	 * rollback nor lets the limit change under KVM_CREATE_PLANE's
+	 * pre-lock bound check.
+	 */
+	if (kvm->arch.vm_type == KVM_X86_SNP_VM)
 		return sev_snp_max_planes(kvm);
 #endif
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 00ce3f4ef497..2b7663722be6 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -1069,7 +1069,6 @@ static inline bool sev_snp_is_rinj_active(struct kvm_vcpu *vcpu)
 	return is_sev_snp_guest(vcpu) &&
 		(sev->vmsa_features & SVM_SEV_FEAT_RESTRICTED_INJECTION);
 };
-int sev_nr_vcpu_planes(struct kvm *kvm);
 int sev_snp_max_planes(struct kvm *kvm);
 #else
 static inline struct page *snp_safe_alloc_page_node(int node, gfp_t gfp)
@@ -1104,7 +1103,6 @@ static inline bool sev_snp_inject(enum inject_type type, struct kvm_vcpu *vcpu)
 static inline void sev_snp_cancel_injection(struct kvm_vcpu *vcpu) {}
 static inline bool sev_snp_blocked(enum inject_type type, struct kvm_vcpu *vcpu) { return false; }
 static inline bool sev_snp_is_rinj_active(struct kvm_vcpu *vcpu) { return false; }
-static inline unsigned sev_snp_max_planes(struct kvm *kvm) { return 1; }
 #endif
 
 /* vmenter.S */
-- 
2.50.1


