Return-Path: <linuxppc-dev+bounces-27321-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6016DC88E53
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 11:03:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkfJs65hlz2xlZ;
	Tue, 15 Sep 2026 21:03:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::d7"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789461992;
	cv=none; b=Wxdr8UcqA8HeAvxHT57pVQs72TJmgB12YAAPCAxPZLetMhIk/REcJCToZCmghCnSlaLi54a2bYzO3NiMWb5p88H6SZBTEvhvMeW0j3Mo/olhyQr4PBqvP7ShRQYbbKch8S51tMVv0ZsqMFB18ByPrzZAadgGCdyuS47wX6I/F2Xin5sNZVDN6Sgo989ilCj9PfE4XlEoEKr+hsv3am3+36TmpG9s/32xJZBA5c3b6KuLMCF+dGGgpanmMSfM6Utdz8hCYA8lbor6TVtUaHFVnxVge05RqxSiV4MhiJfuPnTgfEbz+1GiVw4m79PnJM9PQtnM3CRvCl0rbaKb+5Uwow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789461992; c=relaxed/relaxed;
	bh=5bz0t/wzhOnFF7NxvIbxwEy/LZARgXTl37SWJAHJOB8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YuooIcmysAvq3+7vEBCByalL0x+6A3e8HUHl1uH+iRwD2HB4SAFaKx7jW4RDV1xsNmQyNypI0F2N4VufKOH57G6qcZrBAJS7xTmO0EkIVTn/1Edqkgz9rIFxlzxvSWkvl9JtUeitso00Y1ITUHCupG9f+cSL6OBiO0FL6Gyim8cWCYV9t2evLVkRFxVCbaYC+6rBgGch3OFVF75C8fKOGSwIDv08xP95cbrzyHSckDwufxL+DCMOyX3D/YHGbVo/VhFgSSpkmif+/jphiqTqFv9Kq1wqZ9ARplaBCQVK+NN+XUfBe65bxtV6RHKO56rH3X/GzM5DBZxOJsJPWnU2qg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EY7tXAhB; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::d7; helo=mta0.migadu.com; envelope-from=fuad.tabba@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EY7tXAhB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::d7; helo=mta0.migadu.com; envelope-from=fuad.tabba@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-215.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkbGV5JCwz2yFW
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 18:46:26 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=bSEkY03asFd7ncFCJXorUGr/EvrnfLd1LZhh/lJlyYA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789461968; v=1; x=1790066768;
 b=EY7tXAhBQ7xvjTjYOTLTHG3RaK2KdfjAyw4tuWNmUuXPMz77MUl6t3yDetEKRl4fiT5tUcRt
 s4bwC3PLgf+jJQag7IuXIw1r9LFVShfohah0pFym2PtUzv3LMxUcOfJV0Gik0nu6qj4rEqTKh5m
 7OFdj14dL1GGA4rJAOHNxQlw=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 08fbd8a02e04e0fe;
	Tue, 15 Sep 2026 08:44:47 +0000
X-Mizu-Trace-ID: 08fbd8a02e04e0fe
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
Subject: [PATCH 2/3] KVM: arm64: Fix references to the non-existent VCPU_RUN ioctl
Date: Tue, 15 Sep 2026 09:44:40 +0100
Message-Id: <20260915084441.3846947-3-fuad.tabba@linux.dev>
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

There is no VCPU_RUN ioctl. The one that enters the guest is KVM_RUN,
so refer to it by that name.

Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 Documentation/virt/kvm/arm/pkvm.rst | 2 +-
 arch/arm64/kvm/arm.c                | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/virt/kvm/arm/pkvm.rst b/Documentation/virt/kvm/arm/pkvm.rst
index 514992a79a833..18d8afe36ebce 100644
--- a/Documentation/virt/kvm/arm/pkvm.rst
+++ b/Documentation/virt/kvm/arm/pkvm.rst
@@ -67,7 +67,7 @@ largely due to the lack of MMU notifiers:
   then it will either return ``-EFAULT`` or forcefully reclaim the
   memory pages. Reclaimed memory is zeroed by the hypervisor and a
   subsequent attempt to access it in the pVM will return ``-EFAULT``
-  from the ``VCPU_RUN`` ioctl().
+  from the ``KVM_RUN`` ioctl().
 
 CPU state isolation
 -------------------
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 8b080804bc90b..a18ec13bd6677 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1263,7 +1263,7 @@ static int noinstr kvm_arm_vcpu_enter_exit(struct kvm_vcpu *vcpu)
  * kvm_arch_vcpu_ioctl_run - the main VCPU run function to execute guest code
  * @vcpu:	The VCPU pointer
  *
- * This function is called through the VCPU_RUN ioctl called from user space. It
+ * This function is called through the KVM_RUN ioctl called from user space. It
  * will execute VM code in a loop until the time slice for the process is used
  * or some emulation is needed from user space in which case the function will
  * return with return value 0 and with the kvm_run structure filled in with the
-- 
2.39.5


