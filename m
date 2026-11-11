Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497DE606A336
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 22:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=A/Qgv401
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPyqx4P00z3bkT;
	Thu, 12 Nov 2026 09:29:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794436173;
	cv=none; b=cdCpyjX83kpDvHTSgKtEyajsHk4cNVDguNSR+VLVtfiJX8jQ8fRnyUNvCTX9AkKKX0PjWwyuIV8pMdCzsr3ULqtFx/hTOwQtZfq6DcpoaeE1U9EdABsp+WABkpa/TA27E/ZNhYTav8tTiY3DRyIoQKn5FFmjApt58ks+WVsenlJWg7sJzPemkopzdH3vF8+knzxjId1hqSk6q3vLswdxGQUe1UbkVTeajvYCB6kZWDBIC+lekU1K4TaK7FOOoAkpNReiAPpTpmd3ON9lY+7WrfdltXs6LMXN9SrAQ9p2oc1CY23YITwThKPFuijPg9HUERAKg1JIY3lLNPmg4PwFkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794436173; c=relaxed/relaxed;
	bh=wBoZDHT0z6uhalEs33RytkDoGLTQdmaMj7+RO9mWG/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eX5LE6BBC0CziG/ZpeMSkDNpIbUBeW95qmwjeopyH0p6LEw2dSihaGzmQvtzNSoo8aQe6eEmt23pbby46WgyCOFQGiNZ97mTOVe+jqyt4Wvudg/Kb1ebewij6/1C9nz3L/2sX0D++PzoCAEZnrRtbodbme0UVTDf0GXWPis9DnTlmHTOrF6iM1ai0jbIWtTVp8Mb0Iou5Mu2GwE6AY8JE/52C+J6pbVvqqzNDC5QG05e8ES/qTdL++MHN/+lZnStMgfVybxwH1WcTanafAmwOiSs4vwAy/iuv4eNyLuKBDwriRN51aCSsWLxVAkSXl1kTu3h52ZckNVJk7pubS57oA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=A/Qgv401; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+abad5507353db368323c+8480+infradead.org+dwmw2@casper.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=A/Qgv401;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+abad5507353db368323c+8480+infradead.org+dwmw2@casper.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPyqj27tJz2yLY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 09:29:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=wBoZDHT0z6uhalEs33RytkDoGLTQdmaMj7+RO9mWG/g=; b=A/Qgv401Xd439MOoTlIWy/QCUX
	KkI0CNA5bjK9uvI3mC7FrQPIsPnBsOl1WzcM4u6IBagrIswEGZc1a4vg8CwxqXx6hyKG/orjReKID
	Lgczt9ZjgYx+asxZPytsfJVI2OLqITC/QhFGiKti2xuWx9ed+cgr+FDvQAmZZDzX+2VQojbOBusuL
	KtmUSmkOk+recg6loelcyEIwFpy9jVHJobd1dJ6xW9UzdD5MVUmk7WccPuzwk+hkGgRPibC21NvUB
	nT22ymAKXmFQ/02LEEAAorNIfLGw4es/AtlWw2jWalDpF5FIdRPnpYy1F3Fc17pZci3dPc+x68ZpS
	vIhN9o4Q==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRGoa-0000000G3nw-0LUa;
	Wed, 11 Nov 2026 22:29:12 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRGoZ-0000000008G-3ZWT;
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
Subject: [PATCH 07/16] KVM: x86/mmu: Free obsolete roots of all planes
Date: Wed, 11 Nov 2026 14:29:02 -0800
Message-ID: <20261111222911.477-8-dwmw2@infradead.org>
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

KVM_REQ_MMU_FREE_OBSOLETE_ROOTS lives in the request set shared by all
planes of a vCPU. A fast zap (e.g. memslot deletion) invalidates
*every* plane's TDP roots and raises the request once per vCPU, but
whichever plane enters the guest next consumes the shared bit and
frees only its own obsolete roots. The other planes keep an obsolete
root with a valid-looking root.hpa, kvm_mmu_reload() does nothing for
them, and every page fault bails out in is_page_fault_stale() with
RET_PF_RETRY. The vCPU livelocks, taking the same EPT violation
forever.

Observed with a Windows VSM guest spinning at ~18k EPT violations/s
after a memslot update during boot, with the root obsolete (inv=1
obs=1) and the request already consumed (req=0).

Service every plane twin in kvm_mmu_free_obsolete_roots(). The
inactive twins cannot be running (all planes of a vCPU share one
thread), so their MMUs are stable.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/mmu/mmu.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 89cec6dd757a..e8eb1e48df36 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6401,8 +6401,20 @@ static void __kvm_mmu_free_obsolete_roots(struct kvm *kvm, struct kvm_mmu *mmu)
 
 void kvm_mmu_free_obsolete_roots(struct kvm_vcpu *vcpu)
 {
-	__kvm_mmu_free_obsolete_roots(vcpu->kvm, &vcpu->arch.root_mmu);
-	__kvm_mmu_free_obsolete_roots(vcpu->kvm, &vcpu->arch.guest_mmu);
+	struct kvm_vcpu *v;
+	int i;
+
+	/*
+	 * KVM_REQ_MMU_FREE_OBSOLETE_ROOTS is tracked in the request set
+	 * shared by all of the vCPU's planes, so the plane that consumes
+	 * the request is not necessarily the plane whose root is obsolete.
+	 * Service every plane: the inactive twins cannot be running (all
+	 * planes of a vCPU share one thread), so their MMUs are stable.
+	 */
+	vcpu_for_each_plane(vcpu->common, i, v) {
+		__kvm_mmu_free_obsolete_roots(vcpu->kvm, &v->arch.root_mmu);
+		__kvm_mmu_free_obsolete_roots(vcpu->kvm, &v->arch.guest_mmu);
+	}
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_free_obsolete_roots);
 
-- 
2.50.1


