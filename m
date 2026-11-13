Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE1A60A5BD5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 18:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=oxtqnu7y
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jR5LM12Jmz2xlf;
	Sat, 14 Nov 2026 05:26:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794594379;
	cv=none; b=lHKSnnvuMArFlSlpsI/T8T/JlWmlYAaarb9VrRi5ZBgRhYZKXw1mMR3jVyyqz7tltKhgmbO0HPcvGp6EGNEvTbVxN8wIZH3gBw/+mLVSjxaeXZCez3JBtx4Gb0I1fQIVQjtLsnaaq5pm50Jq+uy6Ur1MQJMznZW8KA74nrgdNZkS2gRcqiPo6QonxvNqHApMdOEhdOau5AI+ir83q7EHlIfCIWlBAj5yvBysPVyaT7zkF78B8FeXA35mAqQc0UPA7nhzpF0xU7EjxyYENK6jCMUCVvmRmqlCejvLIJT7nHQQmhm8l1jQv0OvSe9ZUL07dvYQigPEdkIOVvo2MX5gbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794594379; c=relaxed/relaxed;
	bh=3knGUwEX3LR/PwBuS8cYZDYxWXd5qe0dWzFQ3S99SZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n09ImPc/jNAogyknEYd1XcJemeAwaaFMRaH6VnuE67pecH5Zu4Bc7Fwqm5vM+3nJCm1+COW3D8iJvFlUc1gcpQHvbaCDqav6LWuxeX6UNotZtLsKKS9p39ZOzAfXUT1ZLdesRr5WWJPh5sWtAXJhAHEEkdCzBqSiEz/Rskycx4tco7q0yrmm92KhM+EUsxClVkxz0jsQ5nfsoiZHFaXX5xjTeSPyda6vzBSCOgJtpmf6+xBE9khq/4Wa9kFfH18jKwM9jNwyWa8RWBrVX6xB4zutjswgcO7sWTaNacR8ClG002L/FpecIPrTLeqvhmb1J8EupN9ckVFlnPj6TpFoBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=oxtqnu7y; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+7654657bf7a82263391f+8482+infradead.org+dwmw2@casper.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=oxtqnu7y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+7654657bf7a82263391f+8482+infradead.org+dwmw2@casper.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jR5LJ670lz2xRm
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 05:26:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=3knGUwEX3LR/PwBuS8cYZDYxWXd5qe0dWzFQ3S99SZs=; b=oxtqnu7yOfVjjijBSQNv6hFkAT
	7rrf4C0IFfgpDJHNae3KAaOYtDlGhhNFvPZU2XMyUH8q9ZgayQiIx5CUPtgh3qKPmvkznd5baell4
	qT+nJLyntHk9jV723rPFRcZfvzas034jOQBPBiUCLpjjjk/eyQzeHqFCh6+Yg+ct4FZA7lVHTaTOW
	RgtSjD2ZNno3pTU8PAE6z7ZxMEAff7eFttgHQGG5tFvUWCa0Lk/NHsbfHE0mZ11lDeDs0MnyozGS8
	Ef1g2IAtTO8xtRJ2DCaeW/ucr+aaT7BEB+6hAAfjOGKwCCaEDO3TfXO+zWWbEmffSMa2YbnxgZpv9
	frzIfiMA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRvyR-00000004cT3-3mmx;
	Fri, 13 Nov 2026 18:26:08 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRvyR-00000000LYN-2yMj;
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
Subject: [RFC PATCH 09/13] KVM: x86: Let userspace choose state for plane twins to share
Date: Fri, 13 Nov 2026 11:26:03 -0700
Message-ID: <20261113182607.82813-10-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: David Woodhouse <dwmw@amazon.co.uk>

Which per-vCPU state the planes of a vCPU share is policy for the VMM.
Hyper-V VSM shares XCR0 between VTLs, and whether it shares DR6 depends
on the processor, as HvRegisterVsmCapabilities.Dr6Shared reports; a VMM
with a different privilege model may want neither. So far the only knob
is the plane count, which leaves nothing to key such sharing on but the
opt-in itself.

Take a mask of state to share in args[1] of KVM_ENABLE_CAP(KVM_CAP_PLANES),
set once together with the count. Unknown bits, and a non-zero args[2]
or args[3], fail with -EINVAL. A new KVM_CAP_PLANES_SHARE reports the
supported bits on the system fd and the enabled bits on a VM fd, as
KVM_CAP_PLANES reports the ceiling and the live count. No bits are
defined yet; the following patches add XCR0 and DR6.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/virt/kvm/api.rst  | 12 +++++++++++-
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/x86.c              |  8 ++++++++
 arch/x86/kvm/x86.h              | 11 +++++++++++
 include/uapi/linux/kvm.h        |  1 +
 5 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 4196f3fc5718..a6008cb33e99 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -9316,7 +9316,8 @@ hpage_2g module parameter is not set to 1, -EINVAL is returned.
 
 :Architectures: x86
 :Target: VM
-:Parameters: args[0] contains the number of planes to make available
+:Parameters: args[0] contains the number of planes to make available,
+             args[1] a mask of state that the planes of a vCPU share
 
 Opts the VM in to using multiple planes, raising the limit on plane ids
 that KVM_CREATE_PLANE accepts to args[0], which must be between 1 and the
@@ -9339,6 +9340,15 @@ This capability must be enabled before any vCPU or extra plane has been
 created, and the chosen count cannot be changed afterwards; otherwise
 -EEXIST is returned.
 
+Each plane of a vCPU normally keeps its own copy of the vCPU's register
+state, apart from the CPUID model, which the planes always share.  args[1]
+selects state that the planes of a vCPU share instead, so that a write
+through one plane is seen by all of them.  KVM_CHECK_EXTENSION
+(KVM_CAP_PLANES_SHARE) returns the bits KVM supports on the system fd, and
+the bits the VM enabled on a VM fd.  Setting an unsupported bit, or a
+non-zero args[2] or args[3], fails with -EINVAL.  Like the count, the mask
+is set once.
+
 8. Other capabilities.
 ======================
 
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 596be8ad7154..99a671ac2386 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1195,6 +1195,7 @@ struct kvm_arch {
 	bool has_protected_eoi;
 	bool has_protected_pmu;
 	bool pre_fault_allowed;
+	u8 plane_share;
 	unsigned int user_max_planes;
 	struct hlist_head *mmu_page_hash;
 	struct list_head active_mmu_pages;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index af28e73e4b9b..4d70e111eeb0 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2460,6 +2460,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_VM_TSC_CONTROL:
 		r = kvm_caps.has_tsc_control;
 		break;
+	case KVM_CAP_PLANES_SHARE:
+		r = kvm ? READ_ONCE(kvm->arch.plane_share) : KVM_PLANE_SHARE_VALID;
+		break;
 	case KVM_CAP_X2APIC_API:
 		r = KVM_X2APIC_API_VALID_FLAGS;
 		if (kvm && !irqchip_split(kvm))
@@ -4174,6 +4177,10 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		r = -EINVAL;
 		if (cap->args[0] < 1 || cap->args[0] > KVM_MAX_USER_PLANES)
 			goto planes_unlock;
+		if (cap->args[1] & ~KVM_PLANE_SHARE_VALID)
+			goto planes_unlock;
+		if (cap->args[2] || cap->args[3])
+			goto planes_unlock;
 		/* Planes are only supported with a split irqchip. */
 		if (!irqchip_split(kvm))
 			goto planes_unlock;
@@ -4195,6 +4202,7 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		if (kvm->created_vcpus || kvm->has_planes ||
 		    kvm->arch.user_max_planes)
 			goto planes_unlock;
+		WRITE_ONCE(kvm->arch.plane_share, cap->args[1]);
 		WRITE_ONCE(kvm->arch.user_max_planes, cap->args[0]);
 		r = 0;
 planes_unlock:
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index fb87ceaa9563..2f51b476dbd1 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -923,4 +923,15 @@ struct kvm_plane *x86_alloc_plane(void);
 void x86_free_plane(struct kvm_plane *plane);
 unsigned kvm_x86_default_max_planes(struct kvm *kvm);
 
+/*
+ * The per-vCPU state that userspace may ask the planes of a vCPU to share,
+ * in args[1] of KVM_ENABLE_CAP(KVM_CAP_PLANES).
+ */
+#define KVM_PLANE_SHARE_VALID	0
+
+static inline bool kvm_plane_shares(struct kvm *kvm, u64 state)
+{
+	return READ_ONCE(kvm->arch.plane_share) & state;
+}
+
 #endif
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index abf023ed78c4..aef86ef3976f 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1017,6 +1017,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_ARM_PMU_V3_STRICT 251
 #define KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES 252
 #define KVM_CAP_PLANES 254
+#define KVM_CAP_PLANES_SHARE 256
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
-- 
2.50.1


