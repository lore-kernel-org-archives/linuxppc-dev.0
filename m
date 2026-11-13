Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EB7606A323
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 18:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=IurXzNvO
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jR5Ls3gwRz3bmc;
	Sat, 14 Nov 2026 05:26:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1:d65d:64ff:fe57:4e05"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794594405;
	cv=none; b=mGxOJbzKsXzUJgrNPYNnnzFePfQRtih9trM8gf+VYQsFcIq7qw6woEXjTP/Dc1esgKBIYdcVlQgdUs6watnK5HPtCiwShDnlH6Wv9CDnMLUjdfvqJFhU9xUxr1RbBEwMYEfcS0f/HKzx1/SOjlv7KFiCuuVVvaUnwYNDaDsix8L+YuAK1e2zxnVhSRwLAHrskZfFov8zi8oS5G9fkQPMr30CIAjxcQKwVRKbIyP3m6HDMVh3giKDQBoZuu70jJwBJWy5x3z7yrB9VjXPs1+dotN7KZDfSm9mUsJCiZxoET6Le3/NyqUau60ReGjrrg6Aq4ijkWbBgQVZt6kn0eLprQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794594405; c=relaxed/relaxed;
	bh=wt/q8P3zBd6hu3TnYFCC/E9Q4utWihMtB20Llr0upI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHmakJFWoHtHL5ysMXJcwxgI+eF8YjWtXaJmIpY6HD+FSGFr4KTMgNDxjOEpfGtcxWcW+kpvATdS9oeRFVUR5G+JodufPnMexLLLGA/GTpP3ubvGy3rFKE6xQOGVsBfagd+KU43b03TniQmdng9LY6/xyvJsB5qOjpZUAppirneVSoic4FxG5kpYuqRqssKxauXBFIIApwxbzFEAVoUj/wBzWEAo6kP9qEQmHVV6OG9q1lYlA5jAYntRzszBClY+q3sA4UkarUlWXQt33IHuAI1W05cZkdxRMqvIEUwd9+kpMDk6oOmBOBRzM5iFLV6dLe+4qymXE7O10mnd1VOdRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=IurXzNvO; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=batv+93247ba2969c1d9fc2b6+8482+infradead.org+dwmw2@desiato.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=IurXzNvO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=desiato.srs.infradead.org (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=batv+93247ba2969c1d9fc2b6+8482+infradead.org+dwmw2@desiato.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jR5Lm315Xz2xnQ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 05:26:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=wt/q8P3zBd6hu3TnYFCC/E9Q4utWihMtB20Llr0upI4=; b=IurXzNvOVzHUcQTnti7AZh9iWR
	2PP1E9zBV7zj0qsF2ZP+4FPlAHRv6adPzJmuYKePMPZELglQtVflHlNUVyH45pRep/Nnz3pKM7cJC
	xynxAXqcJ3Mw8dMFpiH817ogl/06FIs+3k7trMuaeqn8dH1MFGrhkqWfepyGFVtgOD+nuVOEf7wNL
	tLg5nMccierJmLRrPIljFS2pkkOPccd3+KeviApcxvzMRIPOMeNPPuvyNBN+lmyL/kK8/TSipAI7s
	uv77YUqE3/BiVqMZ3+tzNXB6mnoDk2nvjrRhZIjDNTVe0jLeBRQeKBnsUgCkIrUx2PUFratgVzwT4
	3h1pmwcQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRvyU-0000000BeOa-173F;
	Fri, 13 Nov 2026 18:26:30 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRvyR-00000000LYJ-2o1a;
	Fri, 13 Nov 2026 18:26:07 +0000
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
Subject: [RFC PATCH 08/13] KVM: planes: Enlarge every twin's fpstate for dynamic xfeatures
Date: Fri, 13 Nov 2026 11:26:02 -0700
Message-ID: <20261113182607.82813-9-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113182607.82813-1-dwmw2@infradead.org>
References: <20260608144252.351443-1-joro@8bytes.org>
 <20261113182607.82813-1-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: David Woodhouse <dwmw@amazon.co.uk>

Plane twins share CPUID, so a twin's guest can set the XCR0 bits for a
dynamic xfeature such as AMX's XTILEDATA with its own XSETBV. But
kvm_check_cpuid() calls fpu_enable_guest_xfd_features() only for the
vCPU that KVM_SET_CPUID was issued on, and a twin created afterwards
starts with the default fpstate. A twin that then runs AMX code loses
its tile data on every fpstate save, because the fpstate it saves into
has no room for it. On a host that exposes AMX to the guest, any twin
using AMX hits this.

Whether the XRSTORS on the next entry can also leave a previous
context's tile registers in place for that twin to read is an open
question; it has not been verified.

Enlarge the fpstate of every twin in kvm_check_cpuid(), and give a twin
created after KVM_SET_CPUID the dynamic xfeatures of its plane-0
sibling's fpstate.

Only a twin that has not run may have its fpstate enlarged:
fpstate_realloc() hands a guest fpstate that is not loaded a fresh
image and copies nothing, so a twin that has run would lose its XSAVE
state. kvm_set_cpuid() already accepts only identical CPUID once the
vCPU has run, but it checked only the vCPU the ioctl was issued on.
With plane 0 held while a higher plane runs, KVM_SET_CPUID2 on plane 0
would pass that check and resize the plane that ran. Since the twins
share CPUID, take the identical-CPUID path once any twin has run.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/cpuid.c | 21 +++++++++++++++++++--
 arch/x86/kvm/x86.c   | 17 +++++++++++++++++
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index c5fa0551ddd5..971ebd781c6e 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -141,7 +141,9 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_find_cpuid_entry2);
 static int kvm_check_cpuid(struct kvm_vcpu *vcpu)
 {
 	struct kvm_cpuid_entry2 *best;
+	struct kvm_vcpu *v;
 	u64 xfeatures;
+	int i, r;
 
 	/*
 	 * The existing code assumes virtual address is 48-bit or 57-bit in the
@@ -168,7 +170,18 @@ static int kvm_check_cpuid(struct kvm_vcpu *vcpu)
 	if (!xfeatures)
 		return 0;
 
-	return fpu_enable_guest_xfd_features(&vcpu->arch.guest_fpu, xfeatures);
+	/*
+	 * The planes share CPUID, so any twin's guest can enable these
+	 * xfeatures in its XCR0: enlarge every twin's fpstate, not just
+	 * this vCPU's.
+	 */
+	vcpu_for_each_plane(vcpu->common, i, v) {
+		r = fpu_enable_guest_xfd_features(&v->arch.guest_fpu, xfeatures);
+		if (r)
+			return r;
+	}
+
+	return 0;
 }
 
 static u32 kvm_apply_cpuid_pv_features_quirk(struct kvm_vcpu *vcpu);
@@ -545,8 +558,12 @@ static int kvm_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
 	 * VMMs (e.g. QEMU) reuse vCPU fds for CPU hotplug/unplug and do
 	 * KVM_SET_CPUID{,2} again. To support this legacy behavior, check
 	 * whether the supplied CPUID data is equal to what's already set.
+	 * Plane twins share CPUID, so this applies once any twin has run.
 	 */
-	if (!kvm_can_set_cpuid_and_feature_msrs(vcpu)) {
+	vcpu_for_each_plane(common, i, v) {
+		if (kvm_can_set_cpuid_and_feature_msrs(v))
+			continue;
+
 		r = kvm_cpuid_check_equal(vcpu, e2, nent);
 		if (r)
 			goto err;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6d3d93e85a65..af28e73e4b9b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9771,6 +9771,23 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	vcpu->arch.hv_root_tdp = INVALID_PAGE;
 #endif
 
+	/*
+	 * A plane twin created after KVM_SET_CPUID shares CPUID that may
+	 * already allow dynamic xfeatures, which KVM_SET_CPUID enabled only
+	 * in the twins that existed at the time.  Give it the dynamic
+	 * xfeatures of its plane-0 sibling's fpstate.
+	 */
+	if (vcpu->plane_level && vcpu->common->vcpus[0]) {
+		u64 dyn = vcpu->common->vcpus[0]->arch.guest_fpu.fpstate->xfeatures &
+			  XFEATURE_MASK_USER_DYNAMIC;
+
+		if (dyn) {
+			r = fpu_enable_guest_xfd_features(&vcpu->arch.guest_fpu, dyn);
+			if (r)
+				goto free_guest_fpu;
+		}
+	}
+
 	/*
 	 * A plane twin created after KVM_SET_CPUID shares CPUID that may
 	 * already advertise Hyper-V.  Allocate the Hyper-V context now so
-- 
2.50.1


