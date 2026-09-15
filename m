Return-Path: <linuxppc-dev+bounces-27324-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA1EEC88E53
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 11:07:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkfNg2YmBz2yfH;
	Tue, 15 Sep 2026 21:06:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::da"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789461996;
	cv=none; b=RzWnzxCZoW2W8m0kdH8Frm5zdPXhh1JnEMatcZS0dutV5ilLurcwFW87uQ2O54CeVodvQf3dtBVznpl5ncrbic3rWbJ9kZb/Fdnkrxg77rFG11c00AGFE0qP03f5DIUW9ZkOyzyAOFo++6p7BPE20clVe551wxd6wptWQw8bUXG7/tQp8f4k9IjjWsnLl50Vo+BTBmN96nDtr8qv16zC+CIUyOujuCZYpqN1eIqxu0FoFXiv56jy41a7ChCbLwc0GzMVWueQ/RlqQSWnTAAWTbMPNtCoLkVdDRy4+0To7x0cJPTCAVQNIgMob1GjPojtLT642h93jHXGnc2tOI99Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789461996; c=relaxed/relaxed;
	bh=XzP6SDztjDOnvRYg9UZXm7XpZhK1Ey/RVwG8s/v52TI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MX+WrQEUNZCHu7rIbKv7aSn2CEouIETdW9L9X3+j3FVRoRHhsmT4uN7f9CC0AycQsZf6FmiBEvArf/jp15XkyydQhOs8vvOL6T6ZODl9QtCngWkssECo299ItToI8CqMbYk03h7+Ix3uGDYBuHLyP4kob+Vwq7WKm1pVhRZsTd6GVbZdeEtZ103k2NzG/l1clAX0zFo3gTA5B3I464PUCvGzLF2yhGND85dvvTphDxR9EnIM5edeGF7GK8zGldges8F7XfGukCOjSMM4ovkm4CrnCWCEvakGe1SZDEOKhks0cOj8XRwbt/5AJrTBV8xw2jAcPCdhz3SQLagEi8ZUIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=d+ebs/cB; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::da; helo=mta0.migadu.com; envelope-from=fuad.tabba@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=d+ebs/cB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::da; helo=mta0.migadu.com; envelope-from=fuad.tabba@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-218.mta0.migadu.com [IPv6:2001:41d0:1004:224b::da])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkbGg5MLZz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 18:46:35 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=cfJHLD9q9zHmMljo9vPmqqbTUt1+su2cEdMIw8eDGo0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789461977; v=1; x=1790066777;
 b=d+ebs/cBCBgRRQw5mxLkAbQgyoH4j78WqKjP+zoJNihmvAE9nWkiFhgnrF5iZ0ENnvSSzqgc
 dTuWoMQ/g3PkyJPGdDKO3j4+wExpolxKmDdZEre91rWDKqClExX4XmtuXSVOi92BIAppbk7oK0B
 qRFaPSMG/HA7YhzNeoaCqap8=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 53447c2444ce877a;
	Tue, 15 Sep 2026 08:44:46 +0000
X-Mizu-Trace-ID: 53447c2444ce877a
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Will Deacon <will@kernel.org>,
	Fuad Tabba <tabba@google.com>,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] KVM: Fix comments that refer to the non-existent VCPU_RUN ioctl
Date: Tue, 15 Sep 2026 09:44:39 +0100
Message-Id: <20260915084441.3846947-2-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260915084441.3846947-1-fuad.tabba@linux.dev>
References: <20260915084441.3846947-1-fuad.tabba@linux.dev>
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

Neither the VCPU_RUN in kvm_main.c nor the VCPU RUN in kvm_host.h names
an ioctl that exists. The one that enters the guest is KVM_RUN, so refer
to it by that name.

Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 include/linux/kvm_host.h | 2 +-
 virt/kvm/kvm_main.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 03bfc92864b6e..acae5a61e7f8f 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -562,7 +562,7 @@ static inline int kvm_vcpu_exiting_guest_mode(struct kvm_vcpu *vcpu)
 	/*
 	 * The memory barrier ensures a previous write to vcpu->requests cannot
 	 * be reordered with the read of vcpu->mode.  It pairs with the general
-	 * memory barrier following the write of vcpu->mode in VCPU RUN.
+	 * memory barrier following the write of vcpu->mode in KVM_RUN.
 	 */
 	smp_mb__before_atomic();
 	return cmpxchg(&vcpu->mode, IN_GUEST_MODE, EXITING_GUEST_MODE);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 65eb26a0520d8..cc391b0666a6d 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -470,7 +470,7 @@ static void kvm_vcpu_destroy(struct kvm_vcpu *vcpu)
 	kvm_dirty_ring_free(&vcpu->dirty_ring);
 
 	/*
-	 * No need for rcu_read_lock as VCPU_RUN is the only place that changes
+	 * No need for rcu_read_lock as KVM_RUN is the only place that changes
 	 * the vcpu->pid pointer, and at destruction time all file descriptors
 	 * are already gone.
 	 */
-- 
2.39.5


