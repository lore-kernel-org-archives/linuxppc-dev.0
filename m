Return-Path: <linuxppc-dev+bounces-22218-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB53CD8C92
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:53:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4N3VQPz3c1C;
	Tue, 09 Jun 2026 00:52:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:238:42d9:3f00:e505:6202:4f0c:f051"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780930338;
	cv=none; b=BoTYiodGkQxZQLJ2PEZWNpwc7TWKpozQid2bgK5oPU5JmNjwCUzBKh9ddMhoQjIhvV9VgzxiJyDZ0OL4cEUBtUZXiuZGliqr+xTD1hQwdsg5Cpn6PNB1XM/nXj3uxmIwftivkFesHOBHydjW/Z41q9164j5eEwzAoMjtj6V7rnmdF95/mJrD5zUZzsSoC0GdXWAjoEOhUsHZFu3/Bhs9jQv997dNY63mWfo0dZP5H5DZMTmtdmGTc1KPqNKGD8AdL8m0oyTkgIYvqFPpkioXdeMpimBIO98fW1ngMFpKIiUYI0KGyU33A5DmDCuijWF4X0z1hOvgy4o0+Zjl/w0J9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780930338; c=relaxed/relaxed;
	bh=Ejpiz6Y/mWPaxJzPjqaA8eKVKvlGQFZkkgY1EdWU85o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gvdOH9PjDornBIVJ/oZXQDE+HZpwSwQ4e+5+6Ec3/UnoEFCzWA1wY/OcK0t6D9j/f8DFrpc8yQ7udOGWZLhJPm63NEZoAuYS1NWOzjED4tFaI0+B3hWMzKgKOoPC9q4c3Mr6DB57zvXyqKrAeZGUL8doHzivwzSMuEco2jhFXJXaj0WiKY5wZTClIBnX2EjTFKnn652SRG6z/Ocyt6/49lo7PkHgjYiGD0Sp+Kc11xMWuUevXRXh0pALonw2gIHW3I3SxSOpfC3DlcpjkVLO6JYriLH/sZnjLkKX2YiWjPIiuLvrrIwGmXjXgpcfSpityBqhPFABGgmopZZWGhhvYw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org) smtp.mailfrom=8bytes.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=8bytes.org (client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org)
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4H6Bf5z3btP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:52:15 +1000 (AEST)
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 80CE32028C1;
	Mon,  8 Jun 2026 16:43:11 +0200 (CEST)
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
Subject: [PATCH 30/60] kvm: Add KVM_EXIT_PLANE_EVENT
Date: Mon,  8 Jun 2026 16:42:22 +0200
Message-ID: <20260608144252.351443-31-joro@8bytes.org>
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

From: Paolo Bonzini <pbonzini@redhat.com>

Add a new exit-type to KVM for telling user-space that a plane-vcpu is
missing. Create a helper which fills out the kvm_run exit structure.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Co-developed-by: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 include/linux/kvm_host.h |  2 ++
 include/uapi/linux/kvm.h | 10 ++++++++++
 virt/kvm/kvm_main.c      | 12 ++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 3ecd472c7cfa..90b97137840e 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1649,6 +1649,8 @@ void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu);
 bool kvm_vcpu_wake_up(struct kvm_vcpu *vcpu);
 
+int kvm_request_create_plane(struct kvm_vcpu *vcpu, unsigned plane, u64 apic_id);
+
 #ifndef CONFIG_S390
 void __kvm_vcpu_kick(struct kvm_vcpu *vcpu, bool wait);
 
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 24e34b8e4819..a88d987c7882 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -146,6 +146,13 @@ struct kvm_exit_snp_req_certs {
 	__u64 ret;
 };
 
+struct kvm_plane_event_exit {
+#define KVM_PLANE_EVENT_CREATE_VCPU	1
+	__u32 cause;
+	__u32 plane;
+	__u64 extra[8];
+};
+
 #define KVM_S390_GET_SKEYS_NONE   1
 #define KVM_S390_SKEYS_MAX        1048576
 
@@ -193,6 +200,7 @@ struct kvm_exit_snp_req_certs {
 #define KVM_EXIT_ARM_SEA          41
 #define KVM_EXIT_ARM_LDST64B      42
 #define KVM_EXIT_SNP_REQ_CERTS    43
+#define KVM_EXIT_PLANE_EVENT      44
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -497,6 +505,8 @@ struct kvm_run {
 		} arm_sea;
 		/* KVM_EXIT_SNP_REQ_CERTS */
 		struct kvm_exit_snp_req_certs snp_req_certs;
+		/* KVM_EXIT_PLANE_EVENT */
+		struct kvm_plane_event_exit plane_event;
 		/* Fix the size of the union. */
 		char padding[256];
 	};
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 03a44ff62f0f..f0f78bb74e51 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3973,6 +3973,18 @@ bool kvm_vcpu_wake_up(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_wake_up);
 
+int kvm_request_create_plane(struct kvm_vcpu *vcpu, unsigned plane, u64 apic_id)
+{
+	vcpu->run->exit_reason = KVM_EXIT_PLANE_EVENT;
+	memset(&vcpu->run->plane_event, 0, sizeof(vcpu->run->plane_event));
+	vcpu->run->plane_event.cause = KVM_PLANE_EVENT_CREATE_VCPU;
+	vcpu->run->plane_event.plane = plane;
+	vcpu->run->plane_event.extra[0] = apic_id;
+
+	return 0;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_request_create_plane);
+
 #ifndef CONFIG_S390
 /*
  * Kick a sleeping VCPU, or a guest VCPU in guest mode, into host kernel mode.
-- 
2.53.0


