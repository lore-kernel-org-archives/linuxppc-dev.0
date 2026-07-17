Return-Path: <linuxppc-dev+bounces-24366-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85945C44515
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 18:06:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h1yXX3stmz3c4y;
	Sat, 18 Jul 2026 04:06:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784311596;
	cv=none; b=aa9P2xOnmg5/supz5KeO6VR3qae0kxjO3yWBhOLMz4h0p170/LgAVFPyKEdwKHA5ytXJvKSHv6+1ihnAUgW5STeBxhR9kNEa6p50DmmuXREISGQBiP2e0rDDB4tjQtpL5rTUn0ku/efIFS/DIehvkgRyQ+iaAdDgCs6xe7SqwCyswH0NZQhdL6u+2f2e2dQp35UCR3bmmmTSb8ppwvJ+wFo4bXVUMzdYnB7G5JeW7NAP+Znm2N4+CMmR2oj8wUDbbjmsnUyC4WHLaQe5OUMAzMmBAKE8/BiLY6bqBWyLlXA+3K18b2qYE8+vrh+dWe+tx6VboRih2/irzfJsYhtXMw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784311596; c=relaxed/relaxed;
	bh=9dRlfhm2GJvO0NKET2nomIv2slIBL0lQ9SwCkEKvtM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+I8OlLoZzG3Ww69BbZR7r4RNE8IbNf4h1Go6r19P05be5lc79MtSz6H5mAj7jaAVSVkB6c6ZWwe9prxCVdBPZu+qsPzV0dBlwUY+BAUXo8AtkJ7gtQJvoxM9fzcHiFZgNX18t1MOkqeoQY+3ip8UfdRrDXfxzrSWBDBb9+IN4VZLXg+WUr9TLQJ5Exe3lVRP5+TTkQxU5pK+t4C/44ypqFzmor1pffMgrr164wdeR2emmY1TeKyfE/tX3fmYXb9oBxVV3yZ03cvZvAZUhtwItK2twW7yVJeCiqJJTiZcDWHrNzYUUG3teGWBzcH4DNhvnfKzqNxvifESCR4ibUU5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W4D94t/w; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W4D94t/w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h1yXW5ZnTz3c3v
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2026 04:06:35 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1EE4F43CFD;
	Fri, 17 Jul 2026 18:06:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00181F000E9;
	Fri, 17 Jul 2026 18:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784311594;
	bh=9dRlfhm2GJvO0NKET2nomIv2slIBL0lQ9SwCkEKvtM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W4D94t/wneRBeRYLAxxxPKoeAyp9CDNhgy+7bpaY5yTYbVT8ophnINPXzQyM9OHYN
	 uagA6UPpU0Lgd0flDoEB5rlssvKZ3tyRPfFbpPV2sf4zB7a3+52/Uwmoy4G5i14rxU
	 R6qttKEJdgr3zR0OdDRKEWhPzw3UvFgaBhsrJTAssxanyZ8F5+nRj1wmIDiSTDvFfT
	 C9XrJ8Uks6+0EVkTEMzI/n52dg18W/W/0DljfnwfNv/RbZ5MkYOz1a6E2e7S53d5Rv
	 /7mUns0bXxC78eCQaFFkVK6EawRz39RdB16ufoyCKINyYamNITiKhCj3jV2gzhZkpL
	 a4YscX7FQeceg==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	x86@kernel.org
Subject: [PATCH v8 08/23] coco: arm64: s390: powerpc: Mark secure guests with CC_ATTR_GUEST_MEM_ENCRYPT
Date: Fri, 17 Jul 2026 23:34:26 +0530
Message-ID: <20260717180442.110954-9-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717180442.110954-1-aneesh.kumar@kernel.org>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
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

arm64 Realms, powerpc secure guests and s390 protected virtualization
guests currently report CC_ATTR_MEM_ENCRYPT, but not
CC_ATTR_GUEST_MEM_ENCRYPT.

These environments are all secure guest configurations. Their
force_dma_unencrypted() implementations also treat the same secure guest
state as requiring unencrypted DMA. Report CC_ATTR_GUEST_MEM_ENCRYPT for
the same condition so generic confidential-computing code can distinguish
guest memory encryption from host memory encryption instead of relying only
on CC_ATTR_MEM_ENCRYPT.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/mm/init.c                         | 1 +
 arch/powerpc/platforms/pseries/cc_platform.c | 1 +
 arch/s390/mm/init.c                          | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index edcc305ec883..48d69e390158 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -419,6 +419,7 @@ bool cc_platform_has(enum cc_attr attr)
 {
 	switch (attr) {
 	case CC_ATTR_MEM_ENCRYPT:
+	case CC_ATTR_GUEST_MEM_ENCRYPT:
 		return is_realm_world() || is_protected_kvm_guest();
 	default:
 		return false;
diff --git a/arch/powerpc/platforms/pseries/cc_platform.c b/arch/powerpc/platforms/pseries/cc_platform.c
index e8021af83a19..46e110a5a717 100644
--- a/arch/powerpc/platforms/pseries/cc_platform.c
+++ b/arch/powerpc/platforms/pseries/cc_platform.c
@@ -17,6 +17,7 @@ bool cc_platform_has(enum cc_attr attr)
 {
 	switch (attr) {
 	case CC_ATTR_MEM_ENCRYPT:
+	case CC_ATTR_GUEST_MEM_ENCRYPT:
 		return is_secure_guest();
 
 	default:
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index c29326c44af0..6b1c5a4fa9ce 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -148,6 +148,7 @@ bool cc_platform_has(enum cc_attr attr)
 {
 	switch (attr) {
 	case CC_ATTR_MEM_ENCRYPT:
+	case CC_ATTR_GUEST_MEM_ENCRYPT:
 		return is_prot_virt_guest();
 
 	default:
-- 
2.43.0


