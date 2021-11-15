Return-Path: <SRS0=UfQ7=QC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1244CC433F5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Nov 2021 19:47:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C15861ACE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Nov 2021 19:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3C15861ACE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=sent.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HtKTm6Pfjz3c5b
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Nov 2021 06:47:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sent.com header.i=@sent.com header.a=rsa-sha256 header.s=fm2 header.b=xB60fto7;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=ARzj9GHt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=sent.com (client-ip=66.111.4.229;
 helo=new3-smtp.messagingengine.com; envelope-from=zi.yan@sent.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=sent.com header.i=@sent.com header.a=rsa-sha256
 header.s=fm2 header.b=xB60fto7; 
 dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm1 header.b=ARzj9GHt; 
 dkim-atps=neutral
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HtKSB1Kdyz2yHP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Nov 2021 06:46:01 +1100 (AEDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id 49F79580604;
 Mon, 15 Nov 2021 14:37:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Mon, 15 Nov 2021 14:37:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references:reply-to
 :mime-version:content-transfer-encoding; s=fm2; bh=AnymEuCYCocHA
 Ds+cC0A+imh3dmQP2pOP/ONvg/OKOg=; b=xB60fto7b9p9zKYRdTNdwVmSChO8D
 SsoFs9Iaft6I6qyt8nf1cWMRPpERDLgYtJOY0e4P4TglBSN2AD5X5hepF72gu8A9
 3bvt5vdgmvsE1/Rmxdq98v6ijYxlrVXB08X4oJCo6XWKh+j/x3mT3xJBTVhK9UTt
 gwPKsITbiYfpYQR72+sVMrihaWedOfxpwppqGJoxAVxys5BWkP3r8uWtHMgsBZEP
 L8ilWVDaa5mKsOtUesoBnZRwPXg4inqJjIUHFvHiZH7aFIfqcT+9zn68o17HRl4t
 cso1oqksai7tfAsNxYbjKiE9enRRMgsV4ASU/j9Z362aYKw93iODw8t0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=AnymEuCYCocHADs+cC0A+imh3dmQP2pOP/ONvg/OKOg=; b=ARzj9GHt
 89g8ElhfXy2AeWhnjWydjJMa7fp8+4jCzsf+jp8rv0KH7rW7KKKl40wkQOQP06K3
 sop3YEKBNBAa2jUfpJo9pZ5EXaNJDa8zswYcftk3XMqBYiSXrHSa066NfWqNn1Zw
 96W9bSlWUscrUpyoAwaJMRaf23fi7ZvWYnEN9xPvIO48sq/n6KAOCEpZN2Rd3MeP
 9YghOUKXbxaU+2GuzQ/JKc6O2blT1W9oJ5qdLMt1YGGj6temHwPaGPTJ0jVGypV3
 djHnqcVbuQ/oN//2e48ZaqMMYe18Fm+pc0vyoOAp66vhtkFhOqx5WInoUtNJLyTX
 Vb0drxpdVv3WIg==
X-ME-Sender: <xms:D7eSYepi9_Z8uf-YaHwqRwLRPKfy8_CJW2g9ecIlmuCKhdZavlICEg>
 <xme:D7eSYcp14c186VrFe3DZgntVxmtYeZCcVNEh5-NBfBfe2e5nELed8sVqHe72rpUXU
 XvaoGjEFFbgF0eo_Q>
X-ME-Received: <xmr:D7eSYTP7avKM76qeEnjbyf3F9-6N7NXUyyLCQRFSS4ZKQoxTp6EMnMvUHusYBIy8Gnf1HltY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfedtgddutddtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
 rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
 dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecuvehluhhs
 thgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvg
 hnthdrtghomh
X-ME-Proxy: <xmx:D7eSYd4yJGehSQMDMdWB_xRmvIPDOk3IdN66w9wppYPuVduHoVtIyw>
 <xmx:D7eSYd7gCBUQmT2CMLvfkRawMDbo81AJQ-SFsg-Cja9aKjU1iUGJ9g>
 <xmx:D7eSYdjOXUCZtIHGbIbHMr9SQgmvy-WOZndHNEJ1sY9TXOEVGqurhQ>
 <xmx:D7eSYSHHQ-Is8qJNgu2aA7Y43q2g-vUX36d-mkxiqCvX19_ozECB1g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Nov 2021 14:37:50 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Subject: [RFC PATCH 3/3] arch: powerpc: adjust fadump alignment to be
 pageblock aligned.
Date: Mon, 15 Nov 2021 14:37:24 -0500
Message-Id: <20211115193725.737539-4-zi.yan@sent.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211115193725.737539-1-zi.yan@sent.com>
References: <20211115193725.737539-1-zi.yan@sent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Reply-To: Zi Yan <ziy@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Zi Yan <ziy@nvidia.com>,
 virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Zi Yan <ziy@nvidia.com>

CMA only requires pageblock alignment now. Change CMA alignment in
fadump too.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 arch/powerpc/include/asm/fadump-internal.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/fadump-internal.h b/arch/powerpc/incl=
ude/asm/fadump-internal.h
index 8d61c8f3fec4..9198f20b6b68 100644
--- a/arch/powerpc/include/asm/fadump-internal.h
+++ b/arch/powerpc/include/asm/fadump-internal.h
@@ -20,9 +20,7 @@
 #define memblock_num_regions(memblock_type)	(memblock.memblock_type.cnt)
=20
 /* Alignment per CMA requirement. */
-#define FADUMP_CMA_ALIGNMENT	(PAGE_SIZE <<				\
-				 max_t(unsigned long, MAX_ORDER - 1,	\
-				 pageblock_order))
+#define FADUMP_CMA_ALIGNMENT	(PAGE_SIZE << pageblock_order)
=20
 /* FAD commands */
 #define FADUMP_REGISTER			1
--=20
2.33.0

