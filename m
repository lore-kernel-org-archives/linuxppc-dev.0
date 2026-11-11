Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7DE606A337
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 22:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=f+ZXiJ1E
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPyr01c9xz3bmq;
	Thu, 12 Nov 2026 09:29:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794436176;
	cv=none; b=V2uuzDVw0hLKfpGLIo9zs6eaTdcT6DiD2BX8SCwE5oj73w1pEWU83zXtLIwdJ+7RKw0xPy1nf23LcSSg2Irygi7d8SwJOP4CsrMzSMhgE+Bab2Ta3dG3usr/1yGmyeIP6jh7jUD0rb8k+PkvBWHXff1zwaXYho/z6NjOlekqR0pInPSS/g4VoIEiZJAmLz4V02CXzGe9VUvyEU91sXrgDgiya6xbRBR1MVVlIROeezK4668z/Ml1MYgkJZFwzSRkdUee30Ot6cNl1HbzEGXboiYx3hYhashsoILeZiyCXzw/qYlofNDUB2UE9/fzgUq4hWwFQAhYpEmX5PhXyufITA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794436176; c=relaxed/relaxed;
	bh=JaNk7OEYJEumDm+gccWLZZ4A2vbsU0ZFt9jBxsRtaJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XL1IWZ/JbvxmyxNvVK1DStDbVFd7wD2QxQ+vs0KfO/oZ9JbbjHtbwScXuu3Fc1jlctFq1gsdiSQuUvppy1//VzkKxMGszpDHdlsEwtEkfNysHqD2WQex064IWjo94w80hmHAnbKWb+OCvmJDE4YaEZcPogYvHscCbqr8cI797nUGByuwOZXMrLtdJaNMQmV59s4+HYEEpn1QY83iZrBSe5KeHHkaoe88o9iopRJJxl2/Y5oYGXpLdJnZ21W6dsJtwu1KmIk0ovmNFQo1ihiYANzNx/UBT3O33NEPtoP90pfNiYvtxEaFtXMd18e/OUAZiJOeKzQRe6ko3xvr03Dw0A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=f+ZXiJ1E; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+abad5507353db368323c+8480+infradead.org+dwmw2@casper.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=f+ZXiJ1E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+abad5507353db368323c+8480+infradead.org+dwmw2@casper.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPyqj23Xzz2yKn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 09:29:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=JaNk7OEYJEumDm+gccWLZZ4A2vbsU0ZFt9jBxsRtaJM=; b=f+ZXiJ1E15LXl2si0WRvwLcl4f
	wo/9va1fMYYV7u8Tr+5HxPMNSTYQtI8AhWEo7a0AVikbihPeaV1fIeXPN5pqpy78KCQY04kYw4W4j
	YifJPlucAI04Wfub++b5/ARizA2/Th+VrBSwCmD+1jH5kKrlVGV3FjYIyAn9gXqm3sqJC1reqLN7e
	OAtfTi5Vo7k5ptuoEdABeHPAkIt2J+Y9VXaS+mpAfGHKl0BFsu0uflqhQWPuP8m557MVu4QRgznVB
	vMnPjbxxSShlqqjSgDE+BQh1vwFu1/2/Oz8Rzzlier1KQmhIbHEsAmgZsJna86PcdXzfQz0hbVwod
	DGZp334Q==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRGoa-0000000G3nq-0589;
	Wed, 11 Nov 2026 22:29:12 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRGoZ-0000000008C-3KMB;
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
Subject: [PATCH 06/16] KVM: x86: Widen the plane vCPU fd ioctl allowlist
Date: Wed, 11 Nov 2026 14:29:01 -0800
Message-ID: <20261111222911.477-7-dwmw2@infradead.org>
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

A VMM that puts an initial VTL context on a higher plane cannot finish
the job through the plane vCPU's fd. kvm_arch_is_vcpu_plane_ioctl()
refuses the ioctls it needs, while the one capability ioctl it does
admit, KVM_ENABLE_CAP, reaches *every* vCPU capability handler.

 - KVM_GET/SET_MP_STATE: a plane vCPU for an AP starts in
   wait-for-INIT like any non-boot x86 vCPU, and nothing ever sends
   INIT/SIPI to the higher plane of an AP. The VMM has to mark it
   runnable itself.
 - KVM_SET_GUEST_DEBUG: single-step and breakpoints on a non-zero
   plane. The debug exits surface through the plane-0 KVM_RUN loop
   like any other plane exit.
 - KVM_X86_SETUP_MCE: mcg_cap is per vCPU and every twin starts with
   the KVM_MAX_MCE_BANKS default, so programming plane 0 alone leaves
   the planes disagreeing. Hyper-V shares MCG state across VTLs.
 - KVM_ENABLE_CAP: accept only the audited capabilities on a plane fd,
   the SynIC pair and the two CPUID-enforcement toggles, which change
   state that each twin keeps separately. Anything else gets -EINVAL, as
   non-allowlisted ioctls already do. The nested paths behind
   enlightened VMCS and direct TLB flush have never been audited for
   plane_level > 0, and without the filter any future vCPU cap would
   work on planes without anyone having decided that it should.

KVM_SET_GUEST_DEBUG on a higher plane can set KVM_GUESTDBG_BLOCKIRQ
there, but the VM-wide APICv BLOCKIRQ inhibit is recomputed over
kvm_for_each_vcpu(), which walks plane 0 only. The inhibit then never
rises for a higher plane, and a plane-0 update drops it while a higher
plane still wants it. Recompute it over every twin. Nothing reaches
this yet (multi-plane VMs are SEV-SNP only, which inhibits APICv
anyway), but it would bite as soon as planes and APICv could coexist.

api.rst marks the new ioctls, and KVM_ENABLE_CAP, as accepted on all
planes, and lists the capabilities a plane fd accepts.

The KVM_ENABLE_CAP filter was found by a local Sashiko review.

The KVM_X86_SETUP_MCE part is from Mushahid Hussain.

Co-developed-by: Mushahid Hussain <hmushi@amazon.co.uk>
Not-signed-off-by: Mushahid Hussain <hmushi@amazon.co.uk>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/virt/kvm/api.rst | 14 ++++++++-----
 arch/x86/kvm/x86.c             | 38 ++++++++++++++++++++++++++++++----
 2 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 6c701cda61ef..d21378183c51 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -1494,7 +1494,7 @@ documentation when it pops into existence).
 
 :Capability: KVM_CAP_ENABLE_CAP
 :Architectures: mips, ppc, s390, x86, loongarch
-:Type: vcpu ioctl
+:Type: vcpu ioctl (all planes)
 :Parameters: struct kvm_enable_cap (in)
 :Returns: 0 on success; -1 on error
 
@@ -1515,6 +1515,10 @@ do support it, it only works for extensions that are supported for enablement.
 To check if a capability can be enabled, the KVM_CHECK_EXTENSION ioctl should
 be used.
 
+On x86, the vCPU fd of a plane other than plane 0 accepts only
+KVM_CAP_HYPERV_SYNIC, KVM_CAP_HYPERV_SYNIC2, KVM_CAP_HYPERV_ENFORCE_CPUID and
+KVM_CAP_ENFORCE_PV_FEATURE_CPUID; any other capability fails with -EINVAL.
+
 ::
 
   struct kvm_enable_cap {
@@ -1549,7 +1553,7 @@ for vm-wide capabilities.
 
 :Capability: KVM_CAP_MP_STATE
 :Architectures: x86, s390, arm64, riscv, loongarch
-:Type: vcpu ioctl
+:Type: vcpu ioctl (all planes)
 :Parameters: struct kvm_mp_state (out)
 :Returns: 0 on success; -1 on error
 
@@ -1632,7 +1636,7 @@ whether the vcpu is runnable.
 
 :Capability: KVM_CAP_MP_STATE
 :Architectures: x86, s390, arm64, riscv, loongarch
-:Type: vcpu ioctl
+:Type: vcpu ioctl (all planes)
 :Parameters: struct kvm_mp_state (in)
 :Returns: 0 on success; -1 on error
 
@@ -3779,7 +3783,7 @@ handled.
 
 :Capability: KVM_CAP_SET_GUEST_DEBUG
 :Architectures: x86, s390, ppc, arm64
-:Type: vcpu ioctl
+:Type: vcpu ioctl (all planes)
 :Parameters: struct kvm_guest_debug (in)
 :Returns: 0 on success; -1 on error
 
@@ -4623,7 +4627,7 @@ capabilities will have the corresponding bits set.
 
 :Capability: KVM_CAP_MCE
 :Architectures: x86
-:Type: vcpu ioctl
+:Type: vcpu ioctl (all planes)
 :Parameters: u64 mcg_cap (in)
 :Returns: 0 on success,
          -EFAULT if u64 mcg_cap cannot be read,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 25f574bfbb32..cd0e9b6cf8f7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3416,6 +3416,25 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 	if (cap->flags)
 		return -EINVAL;
 
+	/*
+	 * KVM_ENABLE_CAP is accepted on plane vCPU fds, but only the caps
+	 * below have been audited for plane_level > 0.  The nested paths
+	 * behind eVMCS and direct TLB flush have not; refuse those rather
+	 * than implicitly extending every current and future vCPU cap to
+	 * planes.
+	 */
+	if (vcpu->plane_level) {
+		switch (cap->cap) {
+		case KVM_CAP_HYPERV_SYNIC:
+		case KVM_CAP_HYPERV_SYNIC2:
+		case KVM_CAP_HYPERV_ENFORCE_CPUID:
+		case KVM_CAP_ENFORCE_PV_FEATURE_CPUID:
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
 	switch (cap->cap) {
 #ifdef CONFIG_KVM_HYPERV
 	case KVM_CAP_HYPERV_SYNIC2:
@@ -3468,6 +3487,7 @@ bool kvm_arch_is_vcpu_plane_ioctl(unsigned ioctl)
 {
 	switch (ioctl) {
 	case KVM_ENABLE_CAP:
+	case KVM_SET_GUEST_DEBUG:
 	case KVM_GET_DEBUGREGS:
 	case KVM_SET_DEBUGREGS:
 	case KVM_GET_LAPIC:
@@ -3480,6 +3500,8 @@ bool kvm_arch_is_vcpu_plane_ioctl(unsigned ioctl)
 	case KVM_SET_ONE_REG:
 	case KVM_GET_SREGS2:
 	case KVM_SET_SREGS2:
+	case KVM_GET_MP_STATE:
+	case KVM_SET_MP_STATE:
 	case KVM_GET_VCPU_EVENTS:
 	case KVM_SET_VCPU_EVENTS:
 	case KVM_GET_XCRS:
@@ -3488,6 +3510,7 @@ bool kvm_arch_is_vcpu_plane_ioctl(unsigned ioctl)
 	case KVM_GET_XSAVE2:
 	case KVM_SET_XSAVE:
 	case KVM_GET_REG_LIST:
+	case KVM_X86_SETUP_MCE:
 		return true;
 	default:
 		return false;
@@ -9355,19 +9378,26 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_task_switch);
 static void kvm_arch_vcpu_guestdbg_update_apicv_inhibit(struct kvm *kvm)
 {
 	bool set = false;
-	struct kvm_vcpu *vcpu;
+	struct kvm_vcpu *vcpu, *v;
 	unsigned long i;
+	int p;
 
 	if (!enable_apicv)
 		return;
 
 	down_write(&kvm->arch.apicv_update_lock);
 
+	/*
+	 * KVM_SET_GUEST_DEBUG is accepted on every plane's vCPU fd, and
+	 * kvm_for_each_vcpu() only walks plane 0: look at every twin.
+	 */
 	kvm_for_each_vcpu(i, vcpu, kvm) {
-		if (vcpu->guest_debug & KVM_GUESTDBG_BLOCKIRQ) {
-			set = true;
-			break;
+		vcpu_for_each_plane(vcpu->common, p, v) {
+			if (v->guest_debug & KVM_GUESTDBG_BLOCKIRQ)
+				set = true;
 		}
+		if (set)
+			break;
 	}
 	__kvm_set_or_clear_apicv_inhibit(kvm, APICV_INHIBIT_REASON_BLOCKIRQ, set);
 	up_write(&kvm->arch.apicv_update_lock);
-- 
2.50.1


