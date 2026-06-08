Return-Path: <linuxppc-dev+bounces-22224-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E79CD8C9D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:53:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4T4tmQz3c8l;
	Tue, 09 Jun 2026 00:52:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780930344;
	cv=none; b=FNw9ccZOAHf/Hh4HpP+Dx4T0RCAhJYm+Cq7PSjmRs9zc0Jyu0d/c7hLW+BbGcrpjDXbG6kEmG4w4h8sx5XE0K6gttnSGaoZPvWwOA/ni66q6M1l67kk6bFFS2hW14Z89mrm8P+B+n34rJvN5tIBW+aBuVCQFaq5+a5sByPxZk80Bs9K8tmSzzUeWK2E34RC6wNxKkLoDeCjK2jbQDgDE2zb2tqeTE7cTNd66gdtXEBGL8O4AE3rZe4xdCR5bJui+3r872qF6WBCEhfAmjFyF+m1svP7mUrkRAkBipQDk9Jj2emV/w1oLAagqujsMEbSpfHmAIjBxlnbPBJbFxhcbNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780930344; c=relaxed/relaxed;
	bh=77z+saR0aMn6CMzMR4mf7c/3OSvK45/5U3DRYMcaKwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nP/qQvR874YbRLP5ybCtDdQ56AgoDB6h/4EHVWW/InU4LSMbE2WdmpOM/oRmujaxOgFYzqckgz66qVV0jlbON9hBf4KeYTHL5HnTe+gTIyehXkAphtjBg18L9C/DwAP9f088lvA+jzhmOCw++y1uSI7dxLoKCfL792UIrPSsrjSgoYfmrzUNwzNhZqUv32XiC3IFHykbpQhf7sJ02wzzzTuShphNofqrvpGDHBV/1pOiiIRvYdks19/sGChk/2iJxdxChp2IE9giaHF8EqcyNNHLHnefpsCOy3//aq/jhj3NB0HSRqEJVUavY4u39aotgMKUrZoEqtoDXRbwpCwgcg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass (client-ip=85.214.250.239; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org) smtp.mailfrom=8bytes.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=8bytes.org (client-ip=85.214.250.239; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org)
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4K5bTWz3bwX
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:52:17 +1000 (AEST)
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id F24592028B9;
	Mon,  8 Jun 2026 16:43:09 +0200 (CEST)
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
Subject: [PATCH 23/60] kvm: Move kvm_vcpu sigset members to struct kvm_vcpu_common
Date: Mon,  8 Jun 2026 16:42:15 +0200
Message-ID: <20260608144252.351443-24-joro@8bytes.org>
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

These are the same across all planes for one VCPU, so make then
shared.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 include/linux/kvm_host.h |  4 ++--
 virt/kvm/kvm_main.c      | 18 ++++++++++++------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 73786712495d..9220c452aa3a 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -348,6 +348,8 @@ struct kvm_vcpu_common {
 
 	struct pid *pid;
 	rwlock_t pid_lock;
+	int sigset_active;
+	sigset_t sigset;
 
 	/* Scheduling state */
 #ifdef CONFIG_PREEMPT_NOTIFIERS
@@ -371,8 +373,6 @@ struct kvm_vcpu {
 
 	struct kvm_run *run;
 
-	int sigset_active;
-	sigset_t sigset;
 	unsigned int halt_poll_ns;
 
 	u64 plane_requests;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index af3c4e0081b8..1858880ee3d3 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3694,7 +3694,9 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_mark_page_dirty);
 
 void kvm_sigset_activate(struct kvm_vcpu *vcpu)
 {
-	if (!vcpu->sigset_active)
+	struct kvm_vcpu_common *common = vcpu->common;
+
+	if (!common->sigset_active)
 		return;
 
 	/*
@@ -3703,12 +3705,14 @@ void kvm_sigset_activate(struct kvm_vcpu *vcpu)
 	 * ->real_blocked don't care as long ->real_blocked is always a subset
 	 * of ->blocked.
 	 */
-	sigprocmask(SIG_SETMASK, &vcpu->sigset, &current->real_blocked);
+	sigprocmask(SIG_SETMASK, &common->sigset, &current->real_blocked);
 }
 
 void kvm_sigset_deactivate(struct kvm_vcpu *vcpu)
 {
-	if (!vcpu->sigset_active)
+	struct kvm_vcpu_common *common = vcpu->common;
+
+	if (!common->sigset_active)
 		return;
 
 	sigprocmask(SIG_SETMASK, &current->real_blocked, NULL);
@@ -4391,12 +4395,14 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 
 static int kvm_vcpu_ioctl_set_sigmask(struct kvm_vcpu *vcpu, sigset_t *sigset)
 {
+	struct kvm_vcpu_common *common = vcpu->common;
+
 	if (sigset) {
 		sigdelsetmask(sigset, sigmask(SIGKILL)|sigmask(SIGSTOP));
-		vcpu->sigset_active = 1;
-		vcpu->sigset = *sigset;
+		common->sigset_active = 1;
+		common->sigset = *sigset;
 	} else
-		vcpu->sigset_active = 0;
+		common->sigset_active = 0;
 	return 0;
 }
 
-- 
2.53.0


