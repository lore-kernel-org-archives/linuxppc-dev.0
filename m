Return-Path: <linuxppc-dev+bounces-23255-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CF0C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 05:51:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqpzR1Qrwz2yjn;
	Wed, 01 Jul 2026 15:51:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782885075;
	cv=none; b=dwEaM950RTi2kQiWFGQeZA6Gjwjhqm84c2/SDkPTG2HH4fZjVUjytPjJf4dE+ZZaER0Vrh1KDF9k9XihEbwcLU+EmgZsV8ZZH0LWYKgpot5eKwIFl/TmyUmr+VDKd/aAvL5EAyrQfgMiqMQHS5cJ+ArjieBTvh3pMMahttxuRQ1kGPgAujagmhNFyNXRRoZ36wddgl72SfIjss1D/cYPV/kmVE/DPwYVCwSdqIGdTIWIFabBTliTSZD76dS0J9kYYDxnZZVCD69k2yIh7kQAUTHPXh2HH7DgMdg2MaqXaYSKeS+dlSJq0zSmdpvlC+rXMxiabXj8x2WExqep/4KLBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782885075; c=relaxed/relaxed;
	bh=asRIaEd/4xjJYIGtw3zuzx+gj7hp/R5cp2IcFUGc0Jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=memhOanlxdLHBmHpU70Bs87GSeHKML313KXKxbBB563+zB1YQFwZbw5/vJweSO5K2taQV8BxG9eOQkbGXJVpoVE0k70RUYtVMwhVfL5KaRuXu5hFQLowdhDoAz9Z1flL9efwHVzclasx2MgLWXVOpPDZQU4Z/18lyFLw6XNVR5YuvppHn5IEzKr0tzzFetAPGJzy2chI3sgUOgrCWboOo2gNEZOqW0JyJOQnF4m0ytd8TTqXu6i3zCp6UczoH4pXaKiJ6qZkdbVrTmlEmBuI0brNliuz9F0UYKydg50XgpzJ1YIfodr9m9MSI9qvDKNessySq850gXVasNb2xqmhvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j4osoUj9; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j4osoUj9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqpzQ2M08z2yft
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 15:51:14 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 67D45600AB;
	Wed,  1 Jul 2026 05:51:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433C51F00A3A;
	Wed,  1 Jul 2026 05:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782885072;
	bh=asRIaEd/4xjJYIGtw3zuzx+gj7hp/R5cp2IcFUGc0Jo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j4osoUj9I8yeii54T3u3pBSNp8p9xiEhJWUw3aaBdBJT0G/KufvfaIpGGv8COfiNl
	 ymf6HwNOY9rr6N3Q9VVv0uuYIjwtuZiy5HxDZIPXrr0ivNbH2ZQ8+utRxN5aZcVpGE
	 aafd+DyNMFr6D3SoIqr9ms23CveKGidlx02FYfgZl7AcHEDGIttSU+r0L2ZB4WNlWO
	 IAt9UZ79529koYkCHM59leWoNs0Ragyb1uQoZv9Qooeh7QsS68CQ5ETEmTl35TjmzN
	 kBNX3L/kq3Xv6KEue8F/nWRtBjGoDTQk15zoZxtBwCtNQPOGuDbz+VofKpt3UsKxND
	 +K1R8FtJVezmw==
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
Subject: [PATCH v7 08/22] coco: arm64: s390: powerpc: Mark secure guests with CC_ATTR_GUEST_MEM_ENCRYPT
Date: Wed,  1 Jul 2026 11:19:12 +0530
Message-ID: <20260701054926.825925-9-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701054926.825925-1-aneesh.kumar@kernel.org>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
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
 arch/arm64/kernel/rsi.c                      | 1 +
 arch/powerpc/platforms/pseries/cc_platform.c | 1 +
 arch/s390/mm/init.c                          | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/rsi.c b/arch/arm64/kernel/rsi.c
index 92160f2e57ff..207e36db1e7a 100644
--- a/arch/arm64/kernel/rsi.c
+++ b/arch/arm64/kernel/rsi.c
@@ -27,6 +27,7 @@ bool cc_platform_has(enum cc_attr attr)
 {
 	switch (attr) {
 	case CC_ATTR_MEM_ENCRYPT:
+	case CC_ATTR_GUEST_MEM_ENCRYPT:
 		return is_realm_world();
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


