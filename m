Return-Path: <linuxppc-dev+bounces-25824-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F00C5CFEB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2026 10:25:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLM2K5THyz2ykT;
	Thu, 13 Aug 2026 20:25:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786616745;
	cv=none; b=NvN0gNFulwb9EwTK/XXk3gE/CPZa/dP4psVxmlDtsn7AxSwXp2ulsJCFfVacBOzCi5gjw5fKZNmcIYrcAASPzc8VPSwmTTbISYrmSBiFq1j+/JiuJTrOHlTLGaQidFozNyh3z7tu1KxZaZJrPOwT6SQ7lyAXESS5164HAXM8NZ6kBaRVmi/jNTjXOa1NZbHRZ1vGsOXfnwssUHq3sCfiC5A/GJe3BhMrBxQEyCMkdQjD2L1nxAvlxSuHbABG7ye3PyKZdEFbtTPoCDEODTenaqukG1tyEa8UD60e92YJOlmFFPwMNKzRz9l7Q83ofoxg/U31apcvVECaT1Rxxq03dA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786616745; c=relaxed/relaxed;
	bh=FVNjqM+zwy4QYexnpN/41yp4Y21cpzfvt2MhMZndR8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PcyVURvUudXd1YLiR7OJclTlaTcTs15UqQWCOzrISi47FBJNY0ojG1l6lxEYrhELqHWL3ig7+6AleT63so5xkpw+ADwadiVlXZLcIFbnT8vyoXQ2o+4Cw7ozsXdeD39hTI7pZ/V1wBiQhrZCv316KvuoKNQyl3z6tNT+7Lq/pVW69TSINrdAdIEeyWYWlfJ1a6MjvTRJF1qV/1Ze9qJY+yeGlaKJDD2eyjzJ2cbGUOpefPb9YQpS9t3Iqj0eACeqIwAzNhF5Z9guCWL2rJom4u5Iks0JJtzh54lod/uN3q0bb05jO9LxsC5RkWCmFNoQWLTdktadFP4DxX9u0fBt2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aMbBUmmd; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aMbBUmmd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLM2J5GvCz2yjs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 20:25:44 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7F7DC4068A;
	Thu, 13 Aug 2026 10:25:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C402D1F000E9;
	Thu, 13 Aug 2026 10:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786616742;
	bh=FVNjqM+zwy4QYexnpN/41yp4Y21cpzfvt2MhMZndR8w=;
	h=From:To:Cc:Subject:Date;
	b=aMbBUmmdjZgu5lCS1WS9hyBaTLJtu5WeLInClKtcETAgtdsa7oT78Xoo4MYmEWcMk
	 ce0CMx4pQSLjG/zl16WJ5eHQTGg/ULfDMsXRiu6aTjft7uODu51SJLodq2dDWjc2ZG
	 TxSsQnaqidxriuLm8klE37n3/8crAKvY6lRdMvkRPo/IW2u6HiNWljLK4uvFrefGlp
	 cgYugSEDYb0tcM5oA3lFaQj4Z5Q6GDz8mjd5aVi0mTyUPkq1f6592AItSK/PKG8uzh
	 9LzjYlThZCxpb1suwn2oG4sACwFRlHapPhhI3FJiloWVbbtz0tWBqcTwaZUMpZJkRW
	 SeyruFS2PkVLA==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: Robin Murphy <robin.murphy@arm.com>,
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
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	x86@kernel.org,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: [RFC PATCH v2 0/2] dma: swiotlb: Centralize default pool sizing
Date: Thu, 13 Aug 2026 15:55:19 +0530
Message-ID: <20260813102521.1367737-1-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
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

Hi,

This series centralizes swiotlb default-pool initialization and sizing.

The first patch replaces the addressing-limit argument with initialization
flags. It also moves the reduced kmalloc-bounce sizing policy into the
swiotlb core.

The second patch centralizes swiotlb sizing for memory-encrypted systems.
It moves the existing x86 guest-sizing policy into the core. Host memory
encryption retains the normal pool size. A shared default pool is not
needed when a restricted DMA pool is present.

SWIOTLB_INIT_CC_SHARED keeps the first patch self-contained. It is removed
by the second patch when the policy moves into the core.

This series is based on the dma-mapping-for-next branch of:
https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git

Aneesh Kumar K.V (Arm) (2):
  dma: swiotlb: Centralize default pool initialization and sizing
  dma: swiotlb: Initialize and size shared default pools for memory
    encryption

 arch/arm/mm/init.c                   |   6 +-
 arch/arm64/mm/init.c                 |  14 +---
 arch/loongarch/kernel/setup.c        |   2 +-
 arch/mips/cavium-octeon/dma-octeon.c |   2 +-
 arch/mips/loongson64/dma.c           |   2 +-
 arch/mips/sibyte/common/dma.c        |   2 +-
 arch/powerpc/kernel/dma-swiotlb.c    |   4 +-
 arch/powerpc/mm/mem.c                |  15 +++-
 arch/powerpc/platforms/pseries/svm.c |  10 ---
 arch/powerpc/sysdev/fsl_pci.c        |   1 +
 arch/riscv/mm/init.c                 |  18 +----
 arch/s390/mm/init.c                  |   2 +-
 arch/x86/include/asm/iommu.h         |   2 +
 arch/x86/kernel/amd_gart_64.c        |   1 +
 arch/x86/kernel/pci-dma.c            |  17 +++--
 arch/x86/mm/mem_encrypt.c            |  24 ------
 include/linux/swiotlb.h              |  10 ++-
 kernel/dma/swiotlb.c                 | 110 ++++++++++++++++++++++-----
 18 files changed, 146 insertions(+), 96 deletions(-)

-- 
2.43.0


