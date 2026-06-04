Return-Path: <linuxppc-dev+bounces-22020-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C659ACD6E57
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 08:43:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWJ4R3lSyz3bsy;
	Thu, 04 Jun 2026 18:43:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780562599;
	cv=none; b=NOJhuDNxF4mWJVwnlyhblNVlEL0Wq5naNnVMQDn0ZEyPS/1qE73a9iOBzVhIJgmqfxMPLACPaqnk8wFG5xmwnXBWgPddGiyusJHX4dS+u2t241cR6MFJu5aA3QT4ZC4eZdkclI8INxJjOgXtgp84pxqZJW2A/DNITVji1SHVWgu5rBuNbMsPmYWcfmAbF6rounj0INzBhVxSBAVW4esoGTKHtW717lp67qqeypLAM+4biQho3wVYpLrXo56gQM/OwEtEEeDZ4Vw/FbyQwDyWwMOGoaGOj7np1IlAQt0Aojz3D/Q7i8EkAsyAmJ3FYMALL8sGxkrvR+zZWU7tN4Cp7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780562599; c=relaxed/relaxed;
	bh=ePeZTaXNJBx/2RYYA/AuIc3DdpRwUBlOsN24dG2IECQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YAGJwsnxAGg3ut7HlvobVill0RLmxZ+WJk6wgiTgaG4hBIQ7ZPIyOMjkwxK3i/MNA+Zy85o8G9z2q+1YBt/xdWWAgJCxOE3WC430k5p4TNawiper4JKm840G00n7yn5jdcuhFIrNJ/0U+oPDpLMDTm5Od8mEB/nDbSeWi6CSz8nvP60VGug9Icu9LgOsD4DNSxcLJJVrZB0Exb6D3u0MsUTdfMfcKbNr7yCVeVW+Axz5IOTgRfLJQFtt/NttbVCT4kpXxN6mU9ZPX8SoSaZM3kj1FuyOWwErLJ/k7DVypjFIKoDB4mQ4qnoaBO3450BmUP7DKkBiAKUHbzQON/yhjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cgae1E98; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cgae1E98;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWJ4Q6MtSz3bsn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 18:43:18 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C4B6860154;
	Thu,  4 Jun 2026 08:43:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480651F00898;
	Thu,  4 Jun 2026 08:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780562596;
	bh=ePeZTaXNJBx/2RYYA/AuIc3DdpRwUBlOsN24dG2IECQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cgae1E98GtHsFcI4+E6f2e3cq2gB5ntC7mDmNNAmlcu5ofgb9Rubm286CJNZMNO10
	 qSFJCmn7ZFC61rYD6tfmuyK2Pzcg2VxIatIJe4OAZ5ves1nEMvLkEV/62k1e+xJ//b
	 nXAAvIdPZbsJnOB0bCNBUOXCMcnl51t8XBadLEDJSbPxMoUwt9hpY2bJyOQRq7k+Tb
	 ZXEo7XRzcFBuF2TBZpyM78U0taYt44WBdBG2MnDNlV5a6W/7EMKvsx0Rsg20fl8Xkz
	 RFARCUaz4S8GDwUqoxWryHd722PxfNT5E8SHmtzPEgPvhIKK5O3G0JsyBaIGYbWz+8
	 DaVLcJHMYLEGQ==
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
Subject: [PATCH v6 20/20] swiotlb: remove unused SWIOTLB_FORCE flag
Date: Thu,  4 Jun 2026 14:09:59 +0530
Message-ID: <20260604083959.1265923-21-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
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

SWIOTLB_FORCE has no remaining in-tree users. Forced bouncing is now
controlled through the swiotlb=force command line option via
swiotlb_force_bounce.

Remove the unused flag and simplify the force_bounce initialization.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 include/linux/swiotlb.h | 1 -
 kernel/dma/swiotlb.c    | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 526f82e9da45..af88ca7182f4 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -15,7 +15,6 @@ struct page;
 struct scatterlist;
 
 #define SWIOTLB_VERBOSE	(1 << 0) /* verbose initialization */
-#define SWIOTLB_FORCE	(1 << 1) /* force bounce buffering */
 #define SWIOTLB_ANY	(1 << 2) /* allow any memory for the buffer */
 
 /*
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index e4bd8c9eaeda..81cc4928e949 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -400,8 +400,7 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 	if (swiotlb_force_disable)
 		return;
 
-	io_tlb_default_mem.force_bounce =
-		swiotlb_force_bounce || (flags & SWIOTLB_FORCE);
+	io_tlb_default_mem.force_bounce = swiotlb_force_bounce;
 
 #ifdef CONFIG_SWIOTLB_DYNAMIC
 	if (!remap)
-- 
2.43.0


