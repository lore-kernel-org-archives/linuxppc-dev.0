Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976DC606A33D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 00:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=t8lS+h1x
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQdSV1ThKz3bQm;
	Fri, 13 Nov 2026 11:30:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794529802;
	cv=none; b=VRtunyvjY8Fu5u1mDeC59HJE7nhCBixVoDFLonqN72u7ToWTAcgVl9CJECpkCZYqNf1CteKEQa4nn79fODmPppq4H714XLEecMj4VNTSe8L+zYRUJql8ywY/w6CIZaWN6SpxB/MSCyxdoaaI+m2yZbCrdKYwKz5pGcRubsiKahDhyKAP826qZep1xiDhdlqs4Dj0repfjybLfu571VW+84tiCD1beSjS/O7CNAR5iR+oGPv2PqlxsgYoXB1F6O3KveaQWMwysqM7E3fmVadtysLGpuJReRssZ8/RsxQCZ8/8QUiuYRmZ/qCdKOnw2bi+/aycWiKP0woB0hsVL8p8xg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794529802; c=relaxed/relaxed;
	bh=r4E+MTESEWZeubmBM7/YkvNZnlWh5Dhkmonv/pR6l2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z0lgY5ijwtBeVXAoUfRToGYt1I3NLqCDSULTTsFYJrOl37aCDWR/HzOtVHrR50id4xe27v7MApVoY0CaUsA4M28UTQgmnx1YxGwhwuTFTW4WfZY7u6ddEzBVPKXZTJ8+9frgq0BdGRj7+L8wmhcFUhGXWuIp//LZq30EsOYQBQQBKVHGaDRKKmom7/yXJDLsBBjjYYFWbP18Qj/SHH2WBBVwBgyeRq08rt8cL2PCCeBGTRXZ+LsiRMda6DJH4G8BiL6H2B+aW/MlBsshR49ApqkaZA22ri/5fJ0SFUpWn4INvj+mLy5v6QJwDEVCNoIgFdAshkT3J3dFV9DvLeoCig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=t8lS+h1x; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+7654657bf7a82263391f+8482+infradead.org+dwmw2@casper.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=t8lS+h1x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+7654657bf7a82263391f+8482+infradead.org+dwmw2@casper.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQdSN6ddBz3bNw
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 11:29:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=r4E+MTESEWZeubmBM7/YkvNZnlWh5Dhkmonv/pR6l2E=; b=t8lS+h1xoqqcNCX6bvUQ6GPBG3
	czOnBE3wbdobT8Xt4PbuAuPs6szpn7rX1ZYfX4KebCgyrEdTx+HfnnFUSEjMVNXqEJzWPXJPmTDzl
	G2jDnmgINPeVSnatFqidjs2yw/xK3G/hIg72zvZo1RoW1Y8u8zJnkNvxWVJ4BgNLyatu8CmydO5hT
	btrhY2LDnkjTrKfX4BmMJGovM0g0FvdzxKr8PMjjy80ZjTDzIIWr/MRyamnDb7s9yLSSP57oCwDU2
	xdsRsVcWR0GsFxCvyPbRygnISpR20u9vxhzIJfcUO5UB/u9ZCIUHDTw2v4xbZVhheW+5uC92tv89q
	ga5jTSFA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRfAq-0000000D12s-1rZk;
	Fri, 13 Nov 2026 00:29:48 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRfAq-00000000DvP-11Bi;
	Fri, 13 Nov 2026 00:29:48 +0000
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
Subject: [PATCH 18/16] KVM: SVM: Bound the SNP plane count by the architectural VMPL limit
Date: Thu, 12 Nov 2026 17:29:48 -0700
Message-ID: <20261113002948.53522-2-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111222911.477-1-dwmw2@infradead.org>
References: <20261111222911.477-1-dwmw2@infradead.org>
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

sev_snp_max_planes() reports the VMPL count straight from CPUID
0x8000001f EBX[15:12], a 4-bit field the host provides. A value above
four lets userspace create SNP planes that no VMPL switch can ever
reach, because the switch already refuses a VMPL at or above
SVM_SEV_VMPL_MAX.

Clamp the count to between one and SVM_SEV_VMPL_MAX, so that a
VM's plane count never exceeds what the architecture defines.

Fixes the plane count in "kvm: svm: Implement max_planes x86
operation".

Fixes: https://lore.kernel.org/all/20260608144252.351443-60-joro@8bytes.org/
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/svm/sev.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index c8a9f808dcc4..eefa8641100b 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -6010,8 +6010,10 @@ bool sev_snp_blocked(enum inject_type type, struct kvm_vcpu *vcpu)
 int sev_snp_max_planes(struct kvm *kvm)
 {
 	/*
-	 * CPUID 0x8000001f EBX[15:12] is host-provided data; a zero there
-	 * must not report "no planes at all" (plane 0 always exists).
+	 * CPUID 0x8000001f EBX[15:12] is host-provided data.  A zero there
+	 * must not report "no planes at all" (plane 0 always exists), and
+	 * the architecture defines no more than SVM_SEV_VMPL_MAX VMPLs, the
+	 * bound the VMPL switch already enforces.
 	 */
-	return max(vmpl_levels, 1U);
+	return clamp(vmpl_levels, 1U, SVM_SEV_VMPL_MAX);
 }
-- 
2.50.1


