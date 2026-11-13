Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5F0606A323
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 18:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=Qn2EM2hE
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jR5Ls5rfjz2y8W;
	Sat, 14 Nov 2026 05:26:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1:d65d:64ff:fe57:4e05"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794594405;
	cv=none; b=CWkOJalnCDQsPCbJGIGScFRyQsilQw2VPz3Nxb7OW2EJ8Xjz7G6m0ioHjsg+noTs2RtYuzgHZ5Kpa1WqmksANVuFolBf+NtVDRCELLdm4/XN6qkZXeQKu8lQLQdESONGgBValwvSMT1eM+CL6ro1ARUe0q1KmTRDL2tc17gejZgIjTpGcek/aRt7YcHPlpDRvtoyDu9qk81d3NmucA7mk/tMCf0tYhtT22AhVfe42K+XFiDef4aLgjoiq2sKsLENsgui57qZjKkd6+qaGwTGsOdRSe3xL9XhUjk7tPxZ8fNHWvydaEoanDvcC/+W6bdW1uYvt1dhwwIuOXDkI5cmow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794594405; c=relaxed/relaxed;
	bh=vhD9zqcQ9I2xlJwWYwXWk6MJvw5eWbXdZkn7PypG6JM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LuCzs03i0B4QUDhFrgrCMHezuOiPfcaUsKewHIn66w/uhSfji/JQelM402AIOgOyDQRuc5b278hYc0xAY0mjOVbR3t4Rimvk4iOtSbnNjBNC59uIaRxtDDo5h/9Ht8AqdmqZGvOgJpE5k+VXuD+jdkQs0ZpYQQY3YJMVM1T5QJPybrjtl1v1mqBH7Znto3rGsFzX/7SNYzgYCZFcPjoUUMpEGWQBNxyJ+Ez3A1i+QDSKHTGLTldJ9O6ahGvw0HlqHZBcTlNpGQ31J0VtCZ5rdn5ee7j+o33Egq3bV4MIew171cEckfZH26sfJznt3RhM97zeK2HRZwDw5zLx7gOOfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=Qn2EM2hE; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=batv+93247ba2969c1d9fc2b6+8482+infradead.org+dwmw2@desiato.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=Qn2EM2hE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=desiato.srs.infradead.org (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=batv+93247ba2969c1d9fc2b6+8482+infradead.org+dwmw2@desiato.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jR5Lm2zskz2xlf
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 05:26:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vhD9zqcQ9I2xlJwWYwXWk6MJvw5eWbXdZkn7PypG6JM=; b=Qn2EM2hE0DULE2YXO4vgcYFo1P
	IYQRBXfu5Zo3umDl2NdDTuLwTNWFabPCd3j5t1h91xjDlCS5pJ0CmOxv67hbFfb5drKJyaB6qOemN
	ScYg5FHhGeIb/KyK+/bHLpYntOkeARbWkWixTpy5vcG3Zwx9GxIEl1eDhy7dyrJV54u8LZb4b9fIJ
	LW/Eg949YM/nytwZEn4lu4Tq2+cVwunnQKuw44D6sWwCZBJHhZ2ZYRXDeStPvLqP5cMO0d6zkx9Pj
	UoAiRvGnAmaxOLMwiAtJMlsB8Dhv3TTgUzDFAuSIHVBj1HgPAzAy8kjOgFhugc+7uTWXqDy8JQysF
	U/PL5A9g==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRvyU-0000000BeOb-16OL;
	Fri, 13 Nov 2026 18:26:30 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRvyR-00000000LYR-38ur;
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
Subject: [RFC PATCH 10/13] KVM: planes: Let plane twins share XCR0
Date: Fri, 13 Nov 2026 11:26:04 -0700
Message-ID: <20261113182607.82813-11-dwmw2@infradead.org>
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

XCR0/XFEM is shared between VTLs (TLFS 15.4). The planes series keeps
arch.xcr0 per vCPU, so an XSETBV in one VTL is invisible in the other,
and VTL1 reads a stale XFEM: a feature VTL0 enabled (AVX, for the
Windows secure kernel) is not enabled in VTL1's XCR0. The register
contents themselves are a separate matter, carried by the code that
switches VTLs.

Add KVM_PLANE_SHARE_XCR0 to the KVM_CAP_PLANES share mask. With it set,
propagate the validated value to every plane twin in __kvm_set_xcr(),
covering both guest XSETBV and the KVM_SET_XCRS ioctl path, and let a
twin created later inherit plane 0's current value. The CPUID
dynamic-bits dirty marker lives in the shared common state, so the
existing single set covers the twins. Update the planes section of
api.rst and the kvm_cpuid_apply_runtime() comment, which still listed
XCR0 among the per-plane registers.

SEV-SNP VMPLs bank XCR0 per VMSA, and sharing it there would be wrong
in two ways: sev_es_sync_from_ghcb() feeds a VMPL's GHCB XCR0 to
__kvm_set_xcr(), so a less-privileged VMPL would overwrite its siblings'
values (and the MSR-protocol CPUID leaf 0xD sizes would then follow the
wrong VMPL); and a pre-launch KVM_SET_XCRS on one twin would change
plane 0's VMSA, and with it the launch measurement. An SNP VM cannot
set the share mask, since KVM_CAP_PLANES refuses its VM type, so its
VMPLs keep XCR0 of their own by construction.

The twins' fpstate sizing does not depend on this bit: the planes share
CPUID, so any twin's own XSETBV can enable a dynamic xfeature whether or
not XCR0 is shared.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/virt/kvm/api.rst  | 11 ++++++++---
 arch/x86/include/uapi/asm/kvm.h |  3 +++
 arch/x86/kvm/cpuid.c            |  4 +++-
 arch/x86/kvm/x86.c              | 34 +++++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.h              |  2 +-
 5 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index a6008cb33e99..22dc3c793bc4 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -374,8 +374,9 @@ The planes of a vCPU share its CPUID model, set through the plane 0 fd with
 KVM_SET_CPUID2.  The CPUID bits that follow a vCPU's own registers (OSXSAVE
 from CR4.OSXSAVE, OSPKE from CR4.PKE, the APIC enable, MWAIT from
 MISC_ENABLE, and the XSAVE area sizes from XCR0 and XSS) reflect the plane
-that executes CPUID, since every plane has these registers of its own.
-KVM_GET_CPUID2 returns them as plane 0 sees them.
+that executes CPUID, since every plane has these registers of its own,
+unless the VM asked the planes to share XCR0 with KVM_PLANE_SHARE_XCR0 (see
+:ref:`KVM_CAP_PLANES`).  KVM_GET_CPUID2 returns them as plane 0 sees them.
 
 4.8 KVM_GET_DIRTY_LOG
 ---------------------
@@ -9347,7 +9348,11 @@ through one plane is seen by all of them.  KVM_CHECK_EXTENSION
 (KVM_CAP_PLANES_SHARE) returns the bits KVM supports on the system fd, and
 the bits the VM enabled on a VM fd.  Setting an unsupported bit, or a
 non-zero args[2] or args[3], fails with -EINVAL.  Like the count, the mask
-is set once.
+is set once.  The bits are:
+
+- KVM_PLANE_SHARE_XCR0: XCR0, whether written by the guest with XSETBV or
+  with KVM_SET_XCRS on any plane's vCPU fd.  A plane vCPU created later
+  starts with plane 0's value.
 
 8. Other capabilities.
 ======================
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 00ce265391e1..edec00979acf 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -922,6 +922,9 @@ struct kvm_sev_snp_launch_finish {
 #define KVM_X2APIC_ENABLE_SUPPRESS_EOI_BROADCAST	_BITULL(2)
 #define KVM_X2APIC_DISABLE_SUPPRESS_EOI_BROADCAST	_BITULL(3)
 
+/* KVM_CAP_PLANES args[1]: state the planes of a vCPU share */
+#define KVM_PLANE_SHARE_XCR0				_BITULL(0)
+
 struct kvm_hyperv_eventfd {
 	__u32 conn_id;
 	__s32 fd;
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 971ebd781c6e..aa89d1b6f6c4 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -2155,7 +2155,9 @@ get_out_of_range_cpuid_entry(struct kvm_vcpu *vcpu, u32 *fn_ptr, u32 index)
 
 /*
  * The planes share the CPUID table but not CR4, the APIC enable, MISC_ENABLE
- * or XCR0/XSS: the bits that follow those come from the executing plane.
+ * or XSS, nor XCR0 unless userspace asked for KVM_PLANE_SHARE_XCR0, in which
+ * case __kvm_set_xcr() keeps it equal across the twins: the bits that follow
+ * those come from the executing plane.
  */
 static void kvm_cpuid_apply_runtime(struct kvm_vcpu *vcpu, u32 function,
 				    u32 index, u32 *eax, u32 *ebx, u32 *ecx,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4d70e111eeb0..ceec10d116a9 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -799,6 +799,31 @@ int __kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr)
 
 	vcpu->arch.xcr0 = xcr0;
 
+	/*
+	 * XCR0/XFEM is shared across VTLs (TLFS 15.4): propagate the new
+	 * value to every plane twin so the other VTLs observe it.  This
+	 * covers both guest XSETBV and the KVM_SET_XCRS ioctl path.  The
+	 * CPUID dirty marker below lives in the shared common state, so one
+	 * set covers the twins too.
+	 *
+	 * Only planes that userspace asked to share XCR0 do so.  SEV-SNP
+	 * VMPLs bank it per VMSA, and an SNP VM cannot set the share mask
+	 * (KVM_CAP_PLANES refuses its VM type), so they never fan out.
+	 *
+	 * Skip the fan-out until this vCPU is published in
+	 * common->vcpus[]: the architectural reset of a twin still being
+	 * created must not clobber a live sibling's XCR0 (the new twin
+	 * inherits the shared value instead, in kvm_arch_vcpu_create()).
+	 */
+	if (kvm_plane_shares(vcpu->kvm, KVM_PLANE_SHARE_XCR0) && vcpu->common &&
+	    vcpu->common->vcpus[vcpu->plane_level] == vcpu) {
+		struct kvm_vcpu *twin;
+		int i;
+
+		vcpu_for_each_plane(vcpu->common, i, twin)
+			twin->arch.xcr0 = xcr0;
+	}
+
 	if ((xcr0 ^ old_xcr0) & XFEATURE_MASK_EXTEND)
 		cpuid_set_dirty(vcpu);
 	return 0;
@@ -9820,6 +9845,15 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	kvm_vcpu_after_set_cpuid(vcpu);
 	kvm_set_tsc_khz(vcpu, vcpu->kvm->arch.default_tsc_khz);
 	kvm_vcpu_reset(vcpu, false);
+	/*
+	 * With XCR0 shared, a twin created after its plane-0 sibling has run
+	 * (Hyper-V VSM enables VTL1 at runtime) inherits the current shared
+	 * value; the architectural reset value only stands when no sibling
+	 * exists yet, or when the planes keep XCR0 of their own.
+	 */
+	if (kvm_plane_shares(vcpu->kvm, KVM_PLANE_SHARE_XCR0) &&
+	    vcpu->plane_level && vcpu->common->vcpus[0])
+		vcpu->arch.xcr0 = vcpu->common->vcpus[0]->arch.xcr0;
 	kvm_init_mmu(vcpu);
 	vcpu_put(vcpu);
 	return 0;
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 2f51b476dbd1..aa8abd219507 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -927,7 +927,7 @@ unsigned kvm_x86_default_max_planes(struct kvm *kvm);
  * The per-vCPU state that userspace may ask the planes of a vCPU to share,
  * in args[1] of KVM_ENABLE_CAP(KVM_CAP_PLANES).
  */
-#define KVM_PLANE_SHARE_VALID	0
+#define KVM_PLANE_SHARE_VALID	KVM_PLANE_SHARE_XCR0
 
 static inline bool kvm_plane_shares(struct kvm *kvm, u64 state)
 {
-- 
2.50.1


