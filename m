Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9497606E20B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 22:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=wCjtEbpv
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPyqs2h3gz3bZR;
	Thu, 12 Nov 2026 09:29:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794436169;
	cv=none; b=I1+Km48ZXXj4y18izRJJqnZnW30shBSgk5ZJeAzm1o2V1fKQD9FTjYhybjuu9TdHoi8IEKrXsXad7G+ZuRFnKc4Z9FRhcfoDxrOZzamjm1Y4LjyPnPXFU/QYfmGKrkDhxpUKx1syBT3gZWcEw0KraXhKymhO2HJN+377mSTy78hN9NfCTUWfcTwchq/xVpri9ROHiI3StywV9E7JlZ1SJFp8Vxg2DF+PhzXhobRRqGI6m1vQ1Cqn4YXeeXGREaErQGgFyPFaGZCT6fLRRIWf1E1Pa+rqbrT33Oo3eToBjifArvIXhLP6lRK66iJHI9vJXWuLbNuoPtijmGT4wvoHTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794436169; c=relaxed/relaxed;
	bh=E8rVfKCMqU27RWIM2bfWVZEtsM9bj4ortAwrQwz/hPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=geiPZyMyVc46Bnuy6j0C9ts5v+c+HOvpDRPxolDR6hAcG9GgqWZwlzmok/vagyGsjkY/Tivai/do+5WjbPEORLVywBIa8mcnIRZ2pq6qHiBh4iMsSEwamJryHHbhjcA2ENatJbYFrwxB+m531YxBxGFvUJ1MYzwumqXh/RZ//l32N2sxXVhH9sw6Qh/sXtqtJOPKIJt7DWnM/BmMcKg1Mao2g7ZTYWv49BCegdWD5CFHLH45yRnzw0spI14H5iTaerci/+EdjYWBRNZ4ocVeBseTMSkO+xmQENw4zUxVfq5WDUucI7aeKCQIUtESLWhmv7QM2Z8Uf90kci8p4x0ovQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=wCjtEbpv; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+abad5507353db368323c+8480+infradead.org+dwmw2@casper.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=wCjtEbpv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+abad5507353db368323c+8480+infradead.org+dwmw2@casper.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPyqj2Mkjz2ylm
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 09:29:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=E8rVfKCMqU27RWIM2bfWVZEtsM9bj4ortAwrQwz/hPM=; b=wCjtEbpv8XHuBy6wJMmQMnzuo0
	h0jSZydE2akV5ZyvNvFU8gfabmnnX1AvPipDVPw8246mtWUuU0pqGoi9KOmi9xDMlTnWUd3RFEsvu
	wNx9R8j+Tv10A/0+n1ha9K917Mfen35ra3jusd2RJHDj8TcYgZoU6ofIr1TSFWqRK3h8Sh3fPEAxu
	svIoD7jIOopcL6q84r7feglY523gu6q+DATzxxIoGKhygr5u8wz/Bx0cJ1oknpRP3XqCD8DJW7JiH
	5OjrfuABd5NyZA3x73i3dJcjLwYlKffTZdbNWzzOmLK1VFVZZoIq5/XVZiQvOzF9Sotr67KDOwB5P
	5M3WSmmg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRGoa-0000000G3ny-1BO7;
	Wed, 11 Nov 2026 22:29:12 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRGoa-0000000008W-0P3R;
	Wed, 11 Nov 2026 22:29:12 +0000
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
Subject: [PATCH 11/16] KVM: x86: Load each plane twin while updating it after KVM_SET_CPUID
Date: Wed, 11 Nov 2026 14:29:06 -0800
Message-ID: <20261111222911.477-12-dwmw2@infradead.org>
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

kvm_vcpu_ioctl_set_cpuid() runs kvm_vcpu_after_set_cpuid() on every
plane twin, but only the calling vCPU is loaded. The vendor callback
writes VMCS/VMCB controls, and on VMX those writes go to whatever VMCS
is loaded on the current pCPU: the caller's, not the twin's. The
twin's controls shadow is updated anyway, so the stale values in its
real VMCS can never be corrected later; a twin created before
KVM_SET_CPUID2 keeps its empty-CPUID controls (RDSEED/RDRAND exiting
among them), and the guest's higher VTL takes a spurious #UD on its
first RDSEED.

Swap each twin in as the loaded vCPU for its update, and reload the
caller once at the end. Plane ioctls all share the common vCPU mutex,
so the twin cannot be loaded elsewhere concurrently. A preemption
inside the window is safe only because vcpu_load() now publishes the
loaded twin as common->current_vcpu (previous patch); before that, the
preempt notifiers would arch-put and arch-load the caller instead.

Fixes the twin updates in "kvm: x86: Update state for all plane VCPUs
after CPUID update".

Fixes: https://lore.kernel.org/all/20260608144252.351443-46-joro@8bytes.org/
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/cpuid.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 54bcfedc5226..c9b7dfc5c967 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -501,7 +501,7 @@ static int kvm_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
 {
 	struct kvm_vcpu_common *common = vcpu->common;
 	u32 vcpu_caps[NR_KVM_CPU_CAPS];
-	struct kvm_vcpu *v;
+	struct kvm_vcpu *v, *loaded = vcpu;
 	unsigned i;
 	int r;
 
@@ -568,9 +568,24 @@ static int kvm_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
 #ifdef CONFIG_KVM_XEN
 		v->arch.xen.cpuid = kvm_get_hypervisor_cpuid(vcpu, XEN_SIGNATURE);
 #endif
+		/*
+		 * The ioctl loaded the calling vCPU; updating a twin's
+		 * VMCS/VMCB controls requires that twin to be the loaded
+		 * one, so swap it in for the update.
+		 */
+		if (v != loaded) {
+			vcpu_put(loaded);
+			vcpu_load(v);
+			loaded = v;
+		}
 		kvm_vcpu_after_set_cpuid(v);
 	}
 
+	if (loaded != vcpu) {
+		vcpu_put(loaded);
+		vcpu_load(vcpu);
+	}
+
 success:
 	kvfree(e2);
 	return 0;
-- 
2.50.1


