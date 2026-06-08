Return-Path: <linuxppc-dev+bounces-22219-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6D1CD8C92
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:53:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4P4x54z3c2q;
	Tue, 09 Jun 2026 00:52:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:238:42d9:3f00:e505:6202:4f0c:f051"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780930341;
	cv=none; b=DB9+x9op7cTYY/r80NvXYn3pPk414rhx0r44oCzO95MMmaljFg4UOsD0iD1l7HYr415E/iwJqdWXB2PEWzDhKYfXLarhYp8at6s016ScSrmgafUXLhbDfA9AW7KWmM21oABCquWjLdpW7zl0LGgPHpow0p99iJgiWthOf5iXhIUHSFvzwuHh42nVuPls1Dnv1G0trE5exqzzft4/9ypHJz48i7gkKHhLBshnbb/4s1Fk06/TZ6iAHLOn1xDF86YzFbJlIBDVXp7ibiRlsLVdUX5ui8jv8dQdxddJengbBtz/vY9BfXcSmbJBo78q/FJHJm4BiQQqI7eHYKWPbcwdBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780930341; c=relaxed/relaxed;
	bh=MSoaCsHNhwggXAiuLoUjgOgIfe8z45X0C6H0JSFUY58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RZUVpfhsgC2Oqt6mAsNzsaEMH1UM3OMH/92joFlYsmRvfT65BEScaVWzXiufV7MF6A+Le1FoKPuYSm+zEw8hwvrL5GPrvMVOKxUje5h9zVdV6hNO+HA7gbpEVJ6TWTNeHO3qpld4K2tWanDKXTabAVDvwT0lXKH1fVVc7xKy8T/hdse9uunsjLmkKf9mdQBUm0ZI3cVXnK9QMkfn08Cl109Nl8PeI+2TAzlVB6+5ZRHAwSelmc7Hgx2dXyFZ0RL+u+cq4cLv+iICAZNv6NNOYZ1daMHCzBqKh+98Dv0L/VaBNY14f4WjvTL0Ie030iG0W5Jm4qMqKnWqQcQff7HkTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org) smtp.mailfrom=8bytes.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=8bytes.org (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org)
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4G6gnVz3bsZ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:52:14 +1000 (AEST)
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 84F122028CF;
	Mon,  8 Jun 2026 16:43:14 +0200 (CEST)
From: =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
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
	joerg.roedel@amd.com
Subject: [PATCH 44/60] kvm: x86: Move cpu_caps to struct kvm_vcpu_arch_common
Date: Mon,  8 Jun 2026 16:42:36 +0200
Message-ID: <20260608144252.351443-45-joro@8bytes.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608144252.351443-1-joro@8bytes.org>
References: <20260608144252.351443-1-joro@8bytes.org>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joerg Roedel <joerg.roedel@amd.com>

Now that CPUID state is shared across all planes, cpu_caps can be
shared as well.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/x86/include/asm/kvm_host.h | 33 +++++++++++++++++----------------
 arch/x86/kvm/cpuid.c            | 18 +++++++++---------
 arch/x86/kvm/cpuid.h            | 17 +++++++++--------
 arch/x86/kvm/svm/svm.c          |  4 ++--
 arch/x86/kvm/vmx/vmx.c          |  2 +-
 5 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3a64bdae6e23..b0d040528f9d 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -800,6 +800,23 @@ struct kvm_vcpu_arch_common {
 	struct kvm_cpuid_entry2 *cpuid_entries;
 	bool cpuid_dynamic_bits_dirty;
 	bool is_amd_compatible;
+
+	/*
+	 * cpu_caps holds the effective guest capabilities, i.e. the features
+	 * the vCPU is allowed to use.  Typically, but not always, features can
+	 * be used by the guest if and only if both KVM and userspace want to
+	 * expose the feature to the guest.
+	 *
+	 * A common exception is for virtualization holes, i.e. when KVM can't
+	 * prevent the guest from using a feature, in which case the vCPU "has"
+	 * the feature regardless of what KVM or userspace desires.
+	 *
+	 * Note, features that don't require KVM involvement in any way are
+	 * NOT enforced/sanitized by KVM, i.e. are taken verbatim from the
+	 * guest CPUID provided by userspace.
+	 */
+	u32 cpu_caps[NR_KVM_CPU_CAPS];
+
 };
 
 int kvm_arch_vcpu_common_init(struct kvm_vcpu_common *common);
@@ -925,22 +942,6 @@ struct kvm_vcpu_arch {
 
 	int halt_request; /* real mode on Intel only */
 
-	/*
-	 * cpu_caps holds the effective guest capabilities, i.e. the features
-	 * the vCPU is allowed to use.  Typically, but not always, features can
-	 * be used by the guest if and only if both KVM and userspace want to
-	 * expose the feature to the guest.
-	 *
-	 * A common exception is for virtualization holes, i.e. when KVM can't
-	 * prevent the guest from using a feature, in which case the vCPU "has"
-	 * the feature regardless of what KVM or userspace desires.
-	 *
-	 * Note, features that don't require KVM involvement in any way are
-	 * NOT enforced/sanitized by KVM, i.e. are taken verbatim from the
-	 * guest CPUID provided by userspace.
-	 */
-	u32 cpu_caps[NR_KVM_CPU_CAPS];
-
 	u64 reserved_gpa_bits;
 	int maxphyaddr;
 
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 6d948d63306c..27e2f7e25038 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -284,7 +284,7 @@ static __always_inline void kvm_update_feature_runtime(struct kvm_vcpu *vcpu,
 						       bool has_feature)
 {
 	cpuid_entry_change(entry, x86_feature, has_feature);
-	guest_cpu_cap_change(vcpu, x86_feature, has_feature);
+	guest_cpu_cap_change(vcpu->common, x86_feature, has_feature);
 }
 
 static void kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu)
@@ -382,7 +382,7 @@ void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	bool allow_gbpages;
 	int i;
 
-	memset(vcpu->arch.cpu_caps, 0, sizeof(vcpu->arch.cpu_caps));
+	memset(common->arch.cpu_caps, 0, sizeof(common->arch.cpu_caps));
 	BUILD_BUG_ON(ARRAY_SIZE(reverse_cpuid) != NR_KVM_CPU_CAPS);
 
 	/*
@@ -408,9 +408,9 @@ void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 		 * in guest CPUID.  Note, this includes features that are
 		 * supported by KVM but aren't advertised to userspace!
 		 */
-		vcpu->arch.cpu_caps[i] = kvm_cpu_caps[i] |
-					 cpuid_get_reg_unsafe(&emulated, cpuid.reg);
-		vcpu->arch.cpu_caps[i] &= cpuid_get_reg_unsafe(entry, cpuid.reg);
+		common->arch.cpu_caps[i] = kvm_cpu_caps[i] |
+					   cpuid_get_reg_unsafe(&emulated, cpuid.reg);
+		common->arch.cpu_caps[i] &= cpuid_get_reg_unsafe(entry, cpuid.reg);
 	}
 
 	kvm_update_cpuid_runtime(vcpu);
@@ -428,7 +428,7 @@ void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	 */
 	allow_gbpages = tdp_enabled ? boot_cpu_has(X86_FEATURE_GBPAGES) :
 				      guest_cpu_cap_has(vcpu, X86_FEATURE_GBPAGES);
-	guest_cpu_cap_change(vcpu, X86_FEATURE_GBPAGES, allow_gbpages);
+	guest_cpu_cap_change(common, X86_FEATURE_GBPAGES, allow_gbpages);
 
 	best = kvm_find_cpuid_entry(vcpu, 1);
 	if (best && apic) {
@@ -536,8 +536,8 @@ static int kvm_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
 	swap(common->arch.cpuid_entries, e2);
 	swap(common->arch.cpuid_nent, nent);
 
-	memcpy(vcpu_caps, vcpu->arch.cpu_caps, sizeof(vcpu_caps));
-	BUILD_BUG_ON(sizeof(vcpu_caps) != sizeof(vcpu->arch.cpu_caps));
+	memcpy(vcpu_caps, common->arch.cpu_caps, sizeof(vcpu_caps));
+	BUILD_BUG_ON(sizeof(vcpu_caps) != sizeof(common->arch.cpu_caps));
 
 	/*
 	 * KVM does not correctly handle changing guest CPUID after KVM_RUN or
@@ -582,7 +582,7 @@ static int kvm_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
 	return 0;
 
 err:
-	memcpy(vcpu->arch.cpu_caps, vcpu_caps, sizeof(vcpu_caps));
+	memcpy(common->arch.cpu_caps, vcpu_caps, sizeof(vcpu_caps));
 	swap(common->arch.cpuid_entries, e2);
 	swap(common->arch.cpuid_nent, nent);
 	return r;
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index 143ea8531611..75abf447eabf 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -239,36 +239,37 @@ static __always_inline bool guest_pv_has(struct kvm_vcpu *vcpu,
 	return vcpu->arch.pv_cpuid.features & (1u << kvm_feature);
 }
 
-static __always_inline void guest_cpu_cap_set(struct kvm_vcpu *vcpu,
+static __always_inline void guest_cpu_cap_set(struct kvm_vcpu_common *common,
 					      unsigned int x86_feature)
 {
 	unsigned int x86_leaf = __feature_leaf(x86_feature);
 
-	vcpu->arch.cpu_caps[x86_leaf] |= __feature_bit(x86_feature);
+	common->arch.cpu_caps[x86_leaf] |= __feature_bit(x86_feature);
 }
 
-static __always_inline void guest_cpu_cap_clear(struct kvm_vcpu *vcpu,
+static __always_inline void guest_cpu_cap_clear(struct kvm_vcpu_common *common,
 						unsigned int x86_feature)
 {
 	unsigned int x86_leaf = __feature_leaf(x86_feature);
 
-	vcpu->arch.cpu_caps[x86_leaf] &= ~__feature_bit(x86_feature);
+	common->arch.cpu_caps[x86_leaf] &= ~__feature_bit(x86_feature);
 }
 
-static __always_inline void guest_cpu_cap_change(struct kvm_vcpu *vcpu,
+static __always_inline void guest_cpu_cap_change(struct kvm_vcpu_common *common,
 						 unsigned int x86_feature,
 						 bool guest_has_cap)
 {
 	if (guest_has_cap)
-		guest_cpu_cap_set(vcpu, x86_feature);
+		guest_cpu_cap_set(common, x86_feature);
 	else
-		guest_cpu_cap_clear(vcpu, x86_feature);
+		guest_cpu_cap_clear(common, x86_feature);
 }
 
 static __always_inline bool guest_cpu_cap_has(struct kvm_vcpu *vcpu,
 					      unsigned int x86_feature)
 {
 	unsigned int x86_leaf = __feature_leaf(x86_feature);
+	struct kvm_vcpu_common *common = vcpu->common;
 
 	/*
 	 * Except for MWAIT, querying dynamic feature bits is disallowed, so
@@ -278,7 +279,7 @@ static __always_inline bool guest_cpu_cap_has(struct kvm_vcpu *vcpu,
 		     x86_feature == X86_FEATURE_OSXSAVE ||
 		     x86_feature == X86_FEATURE_OSPKE);
 
-	return vcpu->arch.cpu_caps[x86_leaf] & __feature_bit(x86_feature);
+	return common->arch.cpu_caps[x86_leaf] & __feature_bit(x86_feature);
 }
 
 static inline bool kvm_vcpu_is_legal_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 612db7ad8b2a..0b57dde29e40 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4706,7 +4706,7 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	 * XSS on VM-Enter/VM-Exit.  Failure to do so would effectively give
 	 * the guest read/write access to the host's XSS.
 	 */
-	guest_cpu_cap_change(vcpu, X86_FEATURE_XSAVES,
+	guest_cpu_cap_change(vcpu->common, X86_FEATURE_XSAVES,
 			     boot_cpu_has(X86_FEATURE_XSAVES) &&
 			     guest_cpu_cap_has(vcpu, X86_FEATURE_XSAVE));
 
@@ -4716,7 +4716,7 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	 * SVM on Intel is bonkers and extremely unlikely to work).
 	 */
 	if (guest_cpuid_is_intel_compatible(vcpu))
-		guest_cpu_cap_clear(vcpu, X86_FEATURE_V_VMSAVE_VMLOAD);
+		guest_cpu_cap_clear(vcpu->common, X86_FEATURE_V_VMSAVE_VMLOAD);
 
 	if (is_sev_guest(vcpu))
 		sev_vcpu_after_set_cpuid(svm);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 62e180651143..d10aa5f60cad 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7994,7 +7994,7 @@ void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	 * set if and only if XSAVE is supported.
 	 */
 	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_XSAVE))
-		guest_cpu_cap_clear(vcpu, X86_FEATURE_XSAVES);
+		guest_cpu_cap_clear(vcpu->common, X86_FEATURE_XSAVES);
 
 	vmx_setup_uret_msrs(vmx);
 
-- 
2.53.0


