Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F42606A33A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 22:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Mhmpih29
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPyqz4wP0z3bmQ;
	Thu, 12 Nov 2026 09:29:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794436175;
	cv=none; b=OmhELas5EUrZmmeMMGM5u0Q+SllBx3g3/EUPR0A8RYL9ZCSDSQ73RU+IeL2KJIR5Rmjl7+RG6jeWN5y1ckGxqOd4MchVAEKYxx1xgrRkB2jiJDKWMtMI7LrYVhWqz8allKcgSQoBIgI7+WygUsEbVEAKXN4TlMnTLw8jc1PvbJ/6tPdS9x759wQ6sfFQVxjLX28lWIDSlm1Dp081r7sQGfBN7ac7gE4Rl4b5n4do4ARDy/MsXxKYlFZv0bkhtwBL8OKCXUP8XOC8/I8tZtGC+yhyLNfuDNYK+QLfT7VgvyplKlTvMmL2//P4gLu6c5LxiCuqiKtPN83vuAOQdhPuhg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794436175; c=relaxed/relaxed;
	bh=8rIcuP/4Kb5zS07YkanQvDf9xFXdSyL1L4TPZLIk6kE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xb9zVkjOR55y1RnSD86HD5DzdNMoGkG7QkJ2IYqQ5oOVRZ55FfOAr5DyhUkI+txjBqc06PvEoeCOI6gTLTmfckZdAQBQRj72372EKo4YCqwSyFtXD9hdA3hw5U90plPzcZ3z2/FmVwYNCrBjHbzJDlmpdBIF/30c+kpT8YXWb7PUdZ9yevtZ3nKN8tZMVbKEV9HrWfH2VOE2k1uHGx1HdsPxNCQSi8iWn3MI5VFmMKIIXbtKXByM3Mkq2oPYB7hLVBTfkMWHLeRjN3uzkEMQ1rt4g1Hnpgd73eWo0HVdtPpm6x8f/ErgQLg6/qyUz9sgT+lxVEvrHqNMIst5+0APjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Mhmpih29; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+abad5507353db368323c+8480+infradead.org+dwmw2@casper.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Mhmpih29;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+abad5507353db368323c+8480+infradead.org+dwmw2@casper.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPyqk3nSfz30WQ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 09:29:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=8rIcuP/4Kb5zS07YkanQvDf9xFXdSyL1L4TPZLIk6kE=; b=Mhmpih290/1F4Cy7rNJmsiv5xh
	KTagvj0bmx+Rz/i0HPD3LG1iyTt/YmhjDLkwCJ6yHvibNng59JHqE5BtJb9aKzo/MWT+/eB4oK7PQ
	eTna6CYO28WO6lwYglmDm/xSFfqkQZoizUi5y0Qaz9Ty61r0JMZdXBURF/cMtIJDbKjA9D9u3ODHa
	onjj0lnNe8MSLGmSP4n4y825566WLHZTuVs1adnPZyKyiN9uFpPP6pJgcA9XKflU+jvrFpUnayZnN
	p7k6mKovmSz+llF1OnTs1x+AEIYOdy7OnvmjDLtRjBdYbc8pE55CLndTDWfWHVu4WlK9Vz6EZ5/l6
	hHZ6kcSg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRGoa-0000000G3o6-1sWv;
	Wed, 11 Nov 2026 22:29:14 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRGoa-0000000008m-15dz;
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
Subject: [PATCH 15/16] KVM: planes: Annotate the lockless twin-publication protocol
Date: Wed, 11 Nov 2026 14:29:10 -0800
Message-ID: <20261111222911.477-16-dwmw2@infradead.org>
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

Plane twins are published with a plain store to common->vcpus[] plus an
smp_wmb() that pairs with online_vcpus, not with twin initialisation,
while vcpu_for_each_plane() reads the slots with a bare load.  x86-TSO
hides it, but the protocol is unannotated generic code: KCSAN reports
it, and nothing stops a reordered publication from exposing a
half-initialised twin to a lockless iterator.

Publish the slot with smp_store_release(), read it with READ_ONCE() in
vcpu_for_each_plane(), and document the pairing at the iterator. The
lockless readers here are vcpu_for_each_plane() callers that walk other
vCPUs' twins, such as the APICv BLOCKIRQ recompute; the kick paths read
common->current_vcpu instead, and the Hyper-V twin lookups that also
pair with the release come later, with the VSM code.

No functional change on x86.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 include/linux/kvm_host.h | 7 ++++++-
 virt/kvm/kvm_main.c      | 9 ++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 1f47b3bfa4bb..6922e3063ad8 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -393,9 +393,14 @@ struct kvm_vcpu_common {
 	struct kvm_vcpu_arch_common arch;
 };
 
+/*
+ * The slot read pairs with the smp_store_release() publication in
+ * kvm_vcpu_finish_common() for iterators running outside the locks that
+ * serialise twin creation.
+ */
 #define vcpu_for_each_plane(common, i, v)			\
 	for ((i) = 0; (i) < KVM_MAX_PLANES; ++(i))		\
-		if (((v) = common->vcpus[(i)]) != NULL)
+		if (((v) = READ_ONCE(common->vcpus[(i)])) != NULL)
 
 /* Tracked per plane-VCPU - used for deciding which plane-vcpu to run */
 enum kvm_vcpu_state {
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index b6bdbe5c5133..7f215822e48e 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -548,7 +548,14 @@ static int kvm_vcpu_init_common(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned
 static void kvm_vcpu_finish_common(struct kvm_vcpu *vcpu)
 {
 	WARN_ON(vcpu->common->vcpus[vcpu->plane_level] != NULL);
-	vcpu->common->vcpus[vcpu->plane_level] = vcpu;
+	/*
+	 * Publish with release semantics so that vcpu_for_each_plane()
+	 * callers running outside the locks that serialise twin creation
+	 * (such as the APICv BLOCKIRQ recompute, which walks every vCPU's
+	 * twins) observe a fully initialised vCPU through their READ_ONCE()
+	 * of the slot; the plain store relied on x86-TSO.
+	 */
+	smp_store_release(&vcpu->common->vcpus[vcpu->plane_level], vcpu);
 	smp_wmb();
 	if (vcpu->plane_level == 0) {
 		/*
-- 
2.50.1


