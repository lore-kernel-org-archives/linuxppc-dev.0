Return-Path: <linuxppc-dev+bounces-27322-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E810C88E53
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 11:06:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkfMp4k6Hz2yFW;
	Tue, 15 Sep 2026 21:06:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::d8"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789461992;
	cv=none; b=T7OaVSk5hTaj2buDa7EuYc2bhtyFQDHbRlplQ51wi5oQnVN6PzdMoTjL+MHeTakP+YbQBvZekexQopd6pr5miBZ054+b2ylh8nC/UmeT2TJvywB+cFrQuMPsaNovk8KsI6SMLN0Uof5NxMeoaoV9bjMiSqekTapYBkVc9xitRQVUaw/M9G19bDID523dmtAyy1OMyUDQpgwA+m4Uz/Tk1YYWjBkj2RFuyPxpNVlR/bVvqZSlJB2b6cPxIsPCK0TiLBWdNG0faIUu1zCEyhB8AKfJrKzeMu9/39iLv+HD/Vq8RcpED6D1pGjl7xRtz4UA3mlxxMGriokrAFjkd9Xl5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789461992; c=relaxed/relaxed;
	bh=H6vnXZPBZBPBLGBoC4F9BPf0LkExxgpUY6++1oeg4M8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BRFi5oi0JOi0HtgecwdRWUDZufJTielRe1Q4gDhog5HpnEXX0fjT2EF0OsVeqygq2+E6ehUdmFQb/muFLCCDtteskx/7gvR7zCplASutFnE+g3cQv8psGTm3GphFSPVp0JKdUyrLwuHFAOi162puVTnTlDfsDLb1BB44OdyIbbq+BGUhH2mNtLRklcL0XjXRXknv1ONvcBrIc4q5a5MuikDY8gN0m/CtRzWdB/3Lggi0Y6KXLc47xgbO1Q7mnbLwNJNwYAk7YnE9ehMIYGSPNtETnNEa32aKXgM0BjvhvLKGSMcQBvWh4CKUYH8HnpJJPUSjoWPkZzQr1VXN+v98EQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=q9PQ3b7R; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::d8; helo=mta0.migadu.com; envelope-from=fuad.tabba@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=q9PQ3b7R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::d8; helo=mta0.migadu.com; envelope-from=fuad.tabba@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-216.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkbGY5XQLz2yfH
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 18:46:29 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=+4rM/vb9bgnywxjBITcpXSRkVe9CVyh/SFm0f0Uf3bA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789461971; v=1; x=1790066771;
 b=q9PQ3b7Rw1iMmHhJ5rQ0OUE/rkKlIcvEsEpDmP53rLwsepFCisJZEEJbvMK/IaO+NtCw8SQx
 QyWaOR3bWxhKVNMGhjH6klSRPxUtMo+yjfJk6bvHTvEkr4a9sO4tvS3FiyS0rpenmYtjffr9xXU
 060o5F+vtzt5smlH/7PlZG5o=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id bf7d1fed5110460d;
	Tue, 15 Sep 2026 08:44:52 +0000
X-Mizu-Trace-ID: bf7d1fed5110460d
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
Subject: [PATCH 3/3] KVM: PPC: Book3S HV: Fix comment naming a non-existent KVM_VCPU_RUN ioctl
Date: Tue, 15 Sep 2026 09:44:41 +0100
Message-Id: <20260915084441.3846947-4-fuad.tabba@linux.dev>
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

There is no KVM_VCPU_RUN ioctl. The one that enters the guest is
KVM_RUN, so refer to it by that name.

Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 arch/powerpc/kvm/book3s_hv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index dbac3573b2c89..db090f4c5e95b 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -269,7 +269,7 @@ static void kvmppc_fast_vcpu_kick_hv(struct kvm_vcpu *vcpu)
  * stolen time for a vcore when it is inactive, or for a vcpu
  * when it is in state RUNNING or NOTREADY.  NOTREADY is a bit of
  * a misnomer; it means that the vcpu task is not executing in
- * the KVM_VCPU_RUN ioctl, i.e. it is in userspace or elsewhere in
+ * the KVM_RUN ioctl, i.e. it is in userspace or elsewhere in
  * the kernel.  We don't have any way of dividing up that time
  * between time that the vcpu is genuinely stopped, time that
  * the task is actively working on behalf of the vcpu, and time
-- 
2.39.5


