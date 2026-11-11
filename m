Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC21606D4C3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 22:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=SuaqGxGm
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPyqp0GJ1z30WS;
	Thu, 12 Nov 2026 09:29:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1:d65d:64ff:fe57:4e05"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794436165;
	cv=none; b=ITgUinlEIG5kLxE3lMc07lS8hUkI6iqgRAv1lVVkl8lZU12SGIQkpD0kzdOmASZA4glhLUPjBtBnHLz7XlqPP5g47cz1ZGDf+DJMP2s+73wM+sJkLCpK+im6lpgvpSMd2uW886XQw7LjwXPkpreJT34chL/bpwq/eVYfIRaDfLFQu2hpupe1W5xrat0xGYZmzFfE6tXb3/dpfTgTbYlV1MdsKBiYh+Oo8S5KHNuLfmmdHONffHewJFKUobb01nU4WWJpIPmQEWRgG3Hg8RKDdu0ysNx1iKd2D+eU6FOIK+ZfZ+96o+E9W8ijPlLtDjtKuQ3155G/9b5i4dvvBsUoJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794436165; c=relaxed/relaxed;
	bh=7RHV+rjBkPO4VUSCvrUXysZFgfDWuM9lOqjoSxGasSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fSWUtr+rbHYJin137+z6LAC9VL2e3KbAWqDyG6nQX8wfhK/nin+anJol6FHWKr6JGO0GpR/iBdvb2S1idZlzGLf3IyfRvFjyB77gwkg0ZWjdN+1NpHViOTIv5Vw7TIPn0E7jrNMAd+Y5W2dr5kq47pSjIdhTA8OI3yV7IUGcivM4JdzbRaAwkmV8JgrLz4ArlA1XNONhBTeVfFUpAlL3wwS/4DKgh49IFcOtblTf1XZxwybnmd7T3Qin1eUqQZh1ogKyrpnv8kk5Cet2F3CFVUuwAoXuIoEep5TNClfqqqtDDz1s9zmlmCz5LP1gBeZi10PSRfq5OU/AjUu+3FP4rw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=SuaqGxGm; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=batv+6fbd95a72608138381e9+8480+infradead.org+dwmw2@desiato.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=SuaqGxGm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=desiato.srs.infradead.org (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=batv+6fbd95a72608138381e9+8480+infradead.org+dwmw2@desiato.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPyqj3JWWz30VV
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 09:29:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=7RHV+rjBkPO4VUSCvrUXysZFgfDWuM9lOqjoSxGasSw=; b=SuaqGxGmXc2Sfykyn+Q4BHtYCo
	Ba8kq40ST/H4RXlkceuSOEEAoWHxlToKg7EvDFMz7Of3AKdrouUCu5B2hbC+Lg3pn0cUnu/bOt8HW
	Ua0cHnHe1JlVGiH83Al5U/FJUBecJp17Qu1eA6+7HjsBcYNtcVEzVJkaz5T+h9Xr5Z7wWFn2VZ8U7
	pOQVK9rwu25yw688zAaOeGtbkIbJK8bX0z8K/hrQ1d2SGVjx/R8ke3lAAJ+i78hC4l23wE6SRpUQ4
	B9EAPBNdaCf18Ket7fEZkpoIXOFrXYWtX7AZ+oiAaGKF6HFna4IJwpKJ97HFpdvi6abTRPIjbupIB
	w12K+HLw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRGoc-00000009dbb-2A2g;
	Wed, 11 Nov 2026 22:29:14 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRGoZ-0000000008K-3uiS;
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
Subject: [PATCH 08/16] KVM: planes: Publish a new plane only once KVM_CREATE_PLANE cannot fail
Date: Wed, 11 Nov 2026 14:29:03 -0800
Message-ID: <20261111222911.477-9-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: David Woodhouse <dwmw@amazon.co.uk>

kvm_create_plane() publishes the new plane in kvm->planes[] before
kvm_vm_ioctl_create_plane() can still fail at anon_inode_getfile(),
and the error path freed the plane without unpublishing it. Anything
that later reads kvm->planes[] reaches the freed plane, and VM teardown
destroys it a second time.

Unpublishing it on the error path is not enough either. Some readers of
kvm->planes[] take no lock: the SEV VMPL-switch target lookup takes the
level from the guest, so it can pick up a plane that is published and
then freed with no grace period in between.

Publish the plane in kvm_vm_ioctl_create_plane() only after
anon_inode_getfile() succeeds, so a failing create frees a plane that
no reader has ever seen. kvm_create_vm() publishes plane 0 itself,
before the VM is reachable. The store stays smp_store_release(), and
the lock-free readers (MSI delivery and the SEV VMPL target lookup) now
load the pointer with READ_ONCE() to pair with it.

Found by a local Sashiko review.

Fixes the error path in "kvm: Implement KVM_CREATE_PLANE ioctl".

Fixes: https://lore.kernel.org/all/20260608144252.351443-30-joro@8bytes.org/
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/irq.c     |  5 +++--
 arch/x86/kvm/svm/sev.c |  2 +-
 virt/kvm/kvm_main.c    | 16 ++++++++++++----
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index f3044aec7188..26912161997e 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -235,7 +235,7 @@ int kvm_set_msi(struct kvm_kernel_irq_routing_entry *e,
 		return -1;
 
 	kvm_msi_to_lapic_irq(kvm, e, &irq);
-	plane = kvm->planes[e->msi.plane_level];
+	plane = READ_ONCE(kvm->planes[e->msi.plane_level]);
 
 	return kvm_irq_delivery_to_apic(plane, NULL, &irq);
 }
@@ -260,7 +260,8 @@ int kvm_arch_set_irq_inatomic(struct kvm_kernel_irq_routing_entry *e,
 
 		kvm_msi_to_lapic_irq(kvm, e, &irq);
 
-		if (kvm_irq_delivery_to_apic_fast(kvm->planes[e->msi.plane_level], NULL, &irq, &r))
+		if (kvm_irq_delivery_to_apic_fast(READ_ONCE(kvm->planes[e->msi.plane_level]),
+						  NULL, &irq, &r))
 			return r;
 		break;
 
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index fd7605e47216..32a4ba4ffdbb 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4249,7 +4249,7 @@ static int sev_snp_ap_creation(struct kvm_vcpu *vcpu)
 	vmpl = array_index_nospec(vmpl, SVM_SEV_VMPL_MAX);
 
 	/* Obtain the target plane and vCPU */
-	target_plane = vcpu->kvm->planes[vmpl];
+	target_plane = READ_ONCE(vcpu->kvm->planes[vmpl]);
 	if (target_plane) {
 		target_vcpu = plane_get_vcpu(target_plane, apic_id);
 	} else {
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 95de904f0c61..d256bbf301f4 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1252,8 +1252,7 @@ static struct kvm_plane *kvm_create_plane(struct kvm *kvm, unsigned plane_level)
 	if (kvm_arch_plane_init(kvm, plane, plane_level))
 		goto out_free_plane;
 
-	kvm->planes[plane_level] = plane;
-
+	/* The caller publishes the plane in kvm->planes[]. */
 	return plane;
 
 out_free_plane:
@@ -1312,7 +1311,8 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 	BUILD_BUG_ON(KVM_MEM_SLOTS_NUM > SHRT_MAX);
 
 	/* Initialize planes array and allocate plane 0 */
-	if (kvm_create_plane(kvm, 0) == NULL) {
+	kvm->planes[0] = kvm_create_plane(kvm, 0);
+	if (!kvm->planes[0]) {
 		r = -ENOMEM;
 		goto out_no_planes;
 	}
@@ -5627,13 +5627,21 @@ static int kvm_vm_ioctl_create_plane(struct kvm *kvm, unsigned id)
 		goto put_kvm;
 	}
 
+	/*
+	 * Publish only once nothing can fail, so that the error path frees
+	 * a plane no reader has seen.  Pairs with the READ_ONCE() of the
+	 * lock-free readers of kvm->planes[] (MSI delivery, SEV VMPL
+	 * targeting): the plane's fields must be visible before the
+	 * pointer is.
+	 */
+	smp_store_release(&kvm->planes[id], plane);
 	kvm->has_planes = true;
 	fd_install(fd, file);
 	return fd;
 
 put_kvm:
-	kvm_put_kvm(kvm);
 	kvm_destroy_one_plane(plane);
+	kvm_put_kvm(kvm);
 put_fd:
 	put_unused_fd(fd);
 	return r;
-- 
2.50.1


