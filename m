Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149DA606A333
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 22:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=S89Ev5TO
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPyqx72Zkz3bl1;
	Thu, 12 Nov 2026 09:29:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1:d65d:64ff:fe57:4e05"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794436173;
	cv=none; b=IfVd1kI+tJkjMewnHhKE/G2Ip51KxJiWX3s3ZHv4dZJkMCMIdu+E5M6QNnN+A/UlQ/c0pQEMOfCp//Uecq6eMAStE8XwF+8yzfporCxvoA08Kvu3t0t7Rhq0SGwJKNsSHsQr/nN+bimWfqQaFEsf8naskUA8keyTUeoK8zMSU7BA1AiS1qugatmEcSrPHKQzgKdnMAxYdNeS77Nmp7LHB3rQZvQq3Y9EzR0giNfMzsUhaO2r4AnEtpHaigZrY3TWFiWFCEbpTjZZdTc6V3ehYpwhLNy3cV9zB6HXX8kNDsadUT/Bm/PA0SgwWKSG5l5dZzFMCq18Y3KiVaXs3qJsag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794436173; c=relaxed/relaxed;
	bh=W87fSQlkCnHCOpy3utcFbD7aEeTD91fXvM7EUGmB8/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pa2C17Ks7As5AxvRPjtvtAT9bvTwzef6m2nVlFXF2i19Ppm/rtI73pdb5Lwla5qJkvAXfUqhG6TmF+UqiMnzTJ+JlWW7TEe/0JKMIGdlsqg7kvYNOuW/Ruupy5uo8wXiRIR16EG1OX/ZPQm2B+cObUTV3mW5EBP+pSAe8Sgvr/tFUzqxARwXObVV4ZOiIgN0SH3l//252gYzYF0aK2Tk2zGXLpSkmk3bCYwA3K2QuKtzg9nXYET3qHl8WmikBkbousKf85ctX8LijNtNm6Bw86T4jzSYPkA6WCSDpiASYfwOgSACyl4j8Ajnjw3PN+n/b5XGR6xoWsSnlD3BHdwekg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=S89Ev5TO; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=batv+6fbd95a72608138381e9+8480+infradead.org+dwmw2@desiato.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=S89Ev5TO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=desiato.srs.infradead.org (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=batv+6fbd95a72608138381e9+8480+infradead.org+dwmw2@desiato.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPyqj3MVGz30VX
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 09:29:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=W87fSQlkCnHCOpy3utcFbD7aEeTD91fXvM7EUGmB8/Y=; b=S89Ev5TOPgWtVFvcEZ+48OAJIO
	XHz1eDA+g6T6JYfr9wgyxYW44qIPA8sMuP2LBy3drm3Mq6Z16AUPK4cIEXJctn0e5AK/C/ii/1BPF
	I8sHywp0m+SfQ0xUp4Ii92OiXPKnlcRyDIBGQF+a6OjjCamoqWClM6iPFWN+CGsFU0S6T+6yXOAEm
	eOqyw+qJlVgYyC6BY/D3zJSWLRDxFfI0oJ4GoGkSwhknnUlc2HminKTDEuO4NmygkjAg2Fwc9SFRK
	RWREfWfDrkmvA1BXZou0ErgSnapYQD/h+818v2lfgDVsrjTdwXB80aHIrnGH8dGLlsf4QdWgSC6r2
	vKOpUNOg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRGoc-00000009dbZ-2ABi;
	Wed, 11 Nov 2026 22:29:14 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRGoZ-0000000007r-26M1;
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
Subject: [PATCH 01/16] KVM: s390: arm64: Pass plane_level to the kvm_set_routing_entry() stub
Date: Wed, 11 Nov 2026 14:28:56 -0800
Message-ID: <20261111222911.477-2-dwmw2@infradead.org>
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

kvm_set_routing_entry() gained a plane_level argument, and every
architecture's implementation was converted except the stub in the
arm64 KVM module on s390, which arrived in the same release. An s390
build with that module then fails:

  arch/s390/kvm/arm64/arm.c:745:5: error: conflicting types for 'kvm_set_routing_entry'

Give the stub the new signature. It still refuses every routing entry.

Fixes the s390 arm64 stub that "kvm: Pass plane_level to
kvm_set_routing_entry()" did not convert.

Fixes: https://lore.kernel.org/all/20260608144252.351443-38-joro@8bytes.org/
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202611102242.ywP1yvPR-lkp@intel.com/
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/s390/kvm/arm64/arm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
index 64a609f087a8..0f0fab76e71a 100644
--- a/arch/s390/kvm/arm64/arm.c
+++ b/arch/s390/kvm/arm64/arm.c
@@ -744,7 +744,8 @@ int kvm_set_msi(struct kvm_kernel_irq_routing_entry *e, struct kvm *kvm,
 
 int kvm_set_routing_entry(struct kvm *kvm,
 			  struct kvm_kernel_irq_routing_entry *e,
-			  const struct kvm_irq_routing_entry *ue)
+			  const struct kvm_irq_routing_entry *ue,
+			  unsigned plane_level)
 {
 	return -EINVAL;
 }
-- 
2.50.1


