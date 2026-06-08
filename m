Return-Path: <linuxppc-dev+bounces-22259-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8262CD8C9F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:56:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw522SnBz3fDD;
	Tue, 09 Jun 2026 00:52:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:238:42d9:3f00:e505:6202:4f0c:f051"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780930370;
	cv=none; b=MBE6G/LIpUTeTVsDdoQwsgu24KZhwUAp47afS7cam0hB4lYOkBwqX8MGywjCp8YXpXAFagW2JOl2rzbyXeVots7sZbJIHGBmKZzr+H90Qenm7h8K3F3uhU6a0PU1oetWhVy2k+/R3G5sRhDNfYKAjMqskaLJyN0Nt+yVnvodcRyexyWFL+1U4V8SuVP6CVP7u2Kg/m32ueo/cV2DSqqOxQoRYuw1tdXtt/ZrNntv4j/2CY0R8SEuEp1L1mqnC9xJuyMzDPv4t60eQnFukIoGmZiXK9s4BUAcgCAB9GNCx5xU1eZJrUUtcYBCWLrIecVbnftSetyYJ7ZWh08Fsgo6Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780930370; c=relaxed/relaxed;
	bh=DOmiMCQRUCV3y/c7Lio5rGAJjflaL7PaWSGf3wYl13I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cxb+D05W4j789vulANp3QFwKXcirTDwzUO/Zuh2AuYuIXz9eahMF6DCd53h6a62VaZcKCpqYuWJpWWXD+yY1SQGN7bqOAeFWFNaULYlNDvTNrooVBb20RBbfW65cjvOWqI5shK0FNr0h79w0bPn6m3JRM8IG/RiJzIgAz85Ug4haIORzMQKhwSGXQ2FKCtJOBOpmAFFaW8QQXycqD158O0066dqhpnPRBj6KL86OicYjFXKgZEEsrZo1+3/lVEzGwEcIOSu45fRHgJJ5BObPENLk9zuMIJ+xvr0UdU7fkJseJK9KWBJOMSy4MwHsRUt4ey6qAieX6W0J7NCZ1Lvwrw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org) smtp.mailfrom=8bytes.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=8bytes.org (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org)
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4h1MK9z3d8T
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:52:36 +1000 (AEST)
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id C82252028D5;
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
Subject: [PATCH 50/60] kvm: x86: Make KVM_REQ_UPDATE_PROTECTED_GUEST_STATE per plane
Date: Mon,  8 Jun 2026 16:42:42 +0200
Message-ID: <20260608144252.351443-51-joro@8bytes.org>
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

The VMSAs are per plane, so this request must be too.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/x86/include/asm/kvm_host.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 0955097aca9c..0327b77e56b7 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -129,7 +129,7 @@
 #define KVM_REQ_HV_TLB_FLUSH \
 	KVM_ARCH_REQ_FLAGS(32, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
 #define KVM_REQ_UPDATE_PROTECTED_GUEST_STATE \
-	KVM_ARCH_REQ_FLAGS(34, KVM_REQUEST_WAIT)
+	KVM_ARCH_REQ_FLAGS(34, KVM_REQUEST_WAIT | KVM_REQUEST_PER_PLANE)
 
 #define CR0_RESERVED_BITS                                               \
 	(~(unsigned long)(X86_CR0_PE | X86_CR0_MP | X86_CR0_EM | X86_CR0_TS \
-- 
2.53.0


