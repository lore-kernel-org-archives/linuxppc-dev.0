Return-Path: <linuxppc-dev+bounces-22220-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1CD1CD8C9D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:53:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4Q4K3xz3c4C;
	Tue, 09 Jun 2026 00:52:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:238:42d9:3f00:e505:6202:4f0c:f051"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780930341;
	cv=none; b=Ir8fVa9OivFCQcoOov5j4qdAEQkPUwZGCJSpbIxUd0rv6KiwrDpPTclJbKJeohQ5hOGRN3D4EnwWw5T35Qd3lbZ15DjWYrLfHfQ4t/eT0GxF5Mn5L4aNhfDwso8VYPrVRUY46LZxJhLCSKPY1wfjbyEC28NB+/hSLUMJwXua6yZ2c+EbTYxBHFrYck8Ae0ACPsu2pMA6mgiFX3Buo4NT93v467Os2RyB8Ul6MgL8v9Y3wpY9a8zrs9+Jj6YJmcGgb+sqSGsIgUoiUyw+VwNOHrMinlK+gA347JG1e6K9JGlRnBpB2RAChc142baKy9Pflp3KLNOh1Z7qz27sLmeQGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780930341; c=relaxed/relaxed;
	bh=SpVi5n0ud58fulsJOsECPBVkkn7UkPSLl9l/8xgX1N0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZ7CpQWam1NdSkVbOzTNbADzRkns6nvrcxFoK1aB66akBeSA+vr5ghINRn69m/nEEnkFdrygSymv5ys7ciSuceXt1iLF7B7SeuU6xqJ7dxPkgnQoEwcC5prd1Hw51M43fwROrVktetpmnyF/rr5/JJDAuTEUvWIsuClHlvjCu2LUKZuBoqCEDQPFgOkwU+OyLewZHyoLTbo7Enikcvwb3HoM04OLxYwRF/qjbSh9zuPioic6gKisortxqq8UZQE2OmXqqv0+gY0/Kg7BwN3NLEOLRUk0/yFGPe0fg4Gns7tRE0NKEwLhhcujVEQ2l+3CB9crfxel/Tf395zcDKDkBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org) smtp.mailfrom=8bytes.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=8bytes.org (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org)
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4J2ZpHz3btY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:52:16 +1000 (AEST)
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 611962028D3;
	Mon,  8 Jun 2026 16:43:15 +0200 (CEST)
From: =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
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
	joerg.roedel@amd.com
Subject: [PATCH 48/60] kvm: x86: Make event injection VCPU requests per-plane
Date: Mon,  8 Jun 2026 16:42:40 +0200
Message-ID: <20260608144252.351443-49-joro@8bytes.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608144252.351443-1-joro@8bytes.org>
References: <20260608144252.351443-1-joro@8bytes.org>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joerg Roedel <joerg.roedel@amd.com>

These events must be handled on the plane-vcpu that they were raised
on.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/x86/include/asm/kvm_host.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index f30173093c44..c2651774d785 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -85,20 +85,20 @@
 						 KVM_X86_NOTIFY_VMEXIT_USER)
 
 /* x86-specific vcpu->requests bit members */
-#define KVM_REQ_MIGRATE_TIMER		KVM_ARCH_REQ(0)
+#define KVM_REQ_MIGRATE_TIMER		KVM_ARCH_PLANE_REQ(0)
 #define KVM_REQ_REPORT_TPR_ACCESS	KVM_ARCH_REQ(1)
 #define KVM_REQ_TRIPLE_FAULT		KVM_ARCH_REQ(2)
 #define KVM_REQ_MMU_SYNC		KVM_ARCH_REQ(3)
 #define KVM_REQ_CLOCK_UPDATE		KVM_ARCH_REQ(4)
 #define KVM_REQ_LOAD_MMU_PGD		KVM_ARCH_REQ(5)
-#define KVM_REQ_EVENT			KVM_ARCH_REQ(6)
+#define KVM_REQ_EVENT			KVM_ARCH_PLANE_REQ(6)
 #define KVM_REQ_APF_HALT		KVM_ARCH_REQ(7)
 #define KVM_REQ_STEAL_UPDATE		KVM_ARCH_REQ(8)
-#define KVM_REQ_NMI			KVM_ARCH_REQ(9)
-#define KVM_REQ_PMU			KVM_ARCH_REQ(10)
-#define KVM_REQ_PMI			KVM_ARCH_REQ(11)
+#define KVM_REQ_NMI			KVM_ARCH_PLANE_REQ(9)
+#define KVM_REQ_PMU			KVM_ARCH_PLANE_REQ(10)
+#define KVM_REQ_PMI			KVM_ARCH_PLANE_REQ(11)
 #ifdef CONFIG_KVM_SMM
-#define KVM_REQ_SMI			KVM_ARCH_REQ(12)
+#define KVM_REQ_SMI			KVM_ARCH_PLANE_REQ(12)
 #endif
 #define KVM_REQ_MASTERCLOCK_UPDATE	KVM_ARCH_REQ(13)
 #define KVM_REQ_MCLOCK_INPROGRESS \
-- 
2.53.0


