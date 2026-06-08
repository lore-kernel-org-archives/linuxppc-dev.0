Return-Path: <linuxppc-dev+bounces-22258-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C67BCD8C9D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:56:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw503JHbz3f7j;
	Tue, 09 Jun 2026 00:52:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:238:42d9:3f00:e505:6202:4f0c:f051"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780930371;
	cv=none; b=AaozHdJGKDEaZYysy39NK2QWzDW2OGwqd7jaYkYLcl6c++93LKhkxspSP6HiDknTr9I0R313xRT7+U/rSRdc4b+qu7zMoSvhJ4xWFQH5d/ouRp2YwMMZ0m9qApo3qTedNm/upKf2LIiRsvJcCQRrtjaePlYTg0MZXrUVueAlzOLFrq7/kJBHJ7s2W4zWabyM54Q5wEbd/gaEAdoRzu3/G8iImxzmZDyE7HUInSOb+uL/sG4tec4jMVXo5HDHUq+2seuRhHygiEBPacsnRtLXzNX3iKOlB0WJwSf8iRdjqRp+9aAj4jtkoAIoXjx4h4VGPT33wHwFcGo5+WtJolQbPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780930371; c=relaxed/relaxed;
	bh=2HYRKtgPmHes85s4ttWuFhKBxpfY02al38lkrxODXjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GmP14FMrYe9Ufm2YCJweFrlsbyDOYRnme0QzhNmrtIOkQuxHrqdKL2nnIcsOqwR9Z5QyaoUno1udvDGZ8oNIu20Cv3hluo3FgG6KgZx8Y4YwYlv4MC2p/FqeTqmBe2Yreg8ZArX7VWU5pzo8tsTFvfa83krsN9H6cWQJi+UkIvtl703GTjHUwdjxz8nLSAbfzPQvrMjnyQkN6W+ooTTZO894kHtLVfVaI2nC47VqGXho+JvemA3qh8mQgX92iga7dq3e9ysgLSh/sDKLmsY+kkeo+Td8EyMROVRr+axAdjgu11XnY67S6VLiq82q2qpReRTtqZX7tIpRIcy/WSpo6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org) smtp.mailfrom=8bytes.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=8bytes.org (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org)
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4j5ZkGz3dJB
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:52:37 +1000 (AEST)
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id A6BAD2028CB;
	Mon,  8 Jun 2026 16:43:13 +0200 (CEST)
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
Subject: [PATCH 40/60] kvm: x86: Handle IOAPIC EOIs per plane
Date: Mon,  8 Jun 2026 16:42:32 +0200
Message-ID: <20260608144252.351443-41-joro@8bytes.org>
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

Make sure the handling of IOAPIC EOIs is aware of planes.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/irq.c              |  3 ++-
 arch/x86/kvm/x86.c              | 10 ++++++++--
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 1393566741a0..134bc02962fd 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -109,7 +109,7 @@
 #define KVM_REQ_APIC_PAGE_RELOAD \
 	KVM_ARCH_REQ_FLAGS(17, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
 #define KVM_REQ_HV_CRASH		KVM_ARCH_REQ(18)
-#define KVM_REQ_IOAPIC_EOI_EXIT		KVM_ARCH_REQ(19)
+#define KVM_REQ_IOAPIC_EOI_EXIT		KVM_ARCH_PLANE_REQ(19)
 #define KVM_REQ_HV_RESET		KVM_ARCH_REQ(20)
 #define KVM_REQ_HV_EXIT			KVM_ARCH_REQ(21)
 #define KVM_REQ_HV_STIMER		KVM_ARCH_REQ(22)
diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index 90e2d2db2123..bc748a4b7cbd 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -400,7 +400,8 @@ void kvm_scan_ioapic_routes(struct kvm_vcpu *vcpu,
 		hlist_for_each_entry(entry, &table->map[i], link) {
 			struct kvm_lapic_irq irq;
 
-			if (entry->type != KVM_IRQ_ROUTING_MSI)
+			if (entry->type != KVM_IRQ_ROUTING_MSI ||
+			    entry->msi.plane_level != vcpu->plane_level)
 				continue;
 
 			kvm_msi_to_lapic_irq(vcpu->kvm, entry, &irq);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 623838885753..a158740a6fc1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11336,8 +11336,14 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 				goto out;
 			}
 		}
-		if (kvm_check_request(KVM_REQ_SCAN_IOAPIC, vcpu))
-			vcpu_scan_ioapic(vcpu);
+		if (kvm_check_request(KVM_REQ_SCAN_IOAPIC, vcpu)) {
+			struct kvm_vcpu *v;
+			unsigned i;
+
+			vcpu_for_each_plane(vcpu->common, i, v) {
+				vcpu_scan_ioapic(v);
+			}
+		}
 		if (kvm_check_request(KVM_REQ_LOAD_EOI_EXITMAP, vcpu))
 			vcpu_load_eoi_exitmap(vcpu);
 		if (kvm_check_request(KVM_REQ_APIC_PAGE_RELOAD, vcpu))
-- 
2.53.0


