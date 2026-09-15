Return-Path: <linuxppc-dev+bounces-27323-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01924C88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 11:06:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkfMx3dCLz2y8m;
	Tue, 15 Sep 2026 21:06:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::d6"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789461992;
	cv=none; b=M/OoycnA30OjquVJGnDfE9kPF1KcFIp5hOcJ7glIYthLLP2Qg+jlEdaYscTogqP86R5ICDssjNQClEnQdvQVTnjTiLjGbSP/flHQp73ByPtq4Ke5Psb87XT57vpdCbTJC17QR3tyTzVImqiOeeXn30g+Kgv1eWPlWJGU+Z6tyoWcjulBwmM8FPA8zh1wQj4hKOYwuxrupDS8Hw+i8bF13ComDbufMlQoPnb33AI7awF+z9tWLmAH24cOUW38A3AOPhEzniuUBh1SfD47iy6HZXjUKeXsJ243dSTZCYqa5Mn9AaQk1BDUQVGg1RYT4oAuElV6d8wDLxiobLWQmebDZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789461992; c=relaxed/relaxed;
	bh=SuE1WyxOK40ZmtZptZeB4jvDAIB375JkCDhI+pPgijw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZEXZ/Asuw+YRamC4XWdmxZ9f0pVtiNGNza4MZ0uC2r7/PJII9zt6+sHTCVePffc3hvleU5njSdYucxTdncFjZyUShPpzFtEKZIxJFpMJmCFDQI4UxE9xM4iHpJ82osrKiHBXJK6AtV2kyiwQFZ9MJseuvj5Fy7ZSKxH2oGjXAPwdF0rALPERK+xrLqW5VXoFxbhvaBVfvvm9hhSP9ZyP2hJf7uUKQe+gCjrtdzRzaxbKqNqB/Cp7dwunp9FcfjtEq4Bv2qTLxJwcSv9YH7gJLdElXay637YMuex7MQp5MD8CVdTal/DPjFiaeAxKZluUb0lFnTzzYRKd8bss31gDeg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mnnAo0Gs; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::d6; helo=mta0.migadu.com; envelope-from=fuad.tabba@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mnnAo0Gs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::d6; helo=mta0.migadu.com; envelope-from=fuad.tabba@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 79 seconds by postgrey-1.37 at boromir; Tue, 15 Sep 2026 18:46:25 AEST
Received: from mta0.migadu.com (out-214.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkbGT6kYnz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 18:46:25 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=5VNjXBdl2JBF32g6/pFWNc4t2873DtQP3kDUrQxNzQc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789461967; v=1; x=1790066767;
 b=mnnAo0Gs6uwOMEpJsoiQ6hSUAztb/GO5W44GMC620uIzWvMkQ3qxw+xpzMFVYakmiG/MAAXY
 PNXeHnzAHmuO72lEKlxNl+1Mg0CyX+g2VjtMOarD3uVStBTi9Km9JgdzrmwbXGhcHlgvjBfPwoM
 Jy79vkpqr2aNkP5jGVSJTgZU=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id c21aa090cc761614;
	Tue, 15 Sep 2026 08:44:42 +0000
X-Mizu-Trace-ID: c21aa090cc761614
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
Subject: [PATCH 0/3] KVM: Replace VCPU_RUN with KVM_RUN in comments and docs
Date: Tue, 15 Sep 2026 09:44:38 +0100
Message-Id: <20260915084441.3846947-1-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.39.5
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

Hi folks,

This one has been bugging me for a while. Five comments and doc lines
name a VCPU_RUN ioctl (KVM_VCPU_RUN in book3s_hv.c, VCPU RUN in
kvm_host.h). The ioctl that enters the guest is KVM_RUN.

The patches are independent and split by tree, one each for generic
KVM, KVM/arm64 and Book3S HV, so each can go through its own
maintainer. Nothing else in the tree refers to the ioctl by a wrong
name.

Based on Linux 7.3-rc3 (fd73f4a665989).

Cheers,
/fuad

Fuad Tabba (3):
  KVM: Fix comments that refer to the non-existent VCPU_RUN ioctl
  KVM: arm64: Fix references to the non-existent VCPU_RUN ioctl
  KVM: PPC: Book3S HV: Fix comment naming a non-existent KVM_VCPU_RUN
    ioctl

 Documentation/virt/kvm/arm/pkvm.rst | 2 +-
 arch/arm64/kvm/arm.c                | 2 +-
 arch/powerpc/kvm/book3s_hv.c        | 2 +-
 include/linux/kvm_host.h            | 2 +-
 virt/kvm/kvm_main.c                 | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)


base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
-- 
2.39.5


