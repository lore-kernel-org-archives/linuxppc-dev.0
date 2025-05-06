Return-Path: <linuxppc-dev+bounces-8364-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F11C5C3ABBC
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 May 2025 21:37:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZsWty4DWzz3064;
	Wed,  7 May 2025 07:36:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1746567418;
	cv=none; b=oG+2j/Xn4wCS5Xp90NmGCxSzejVR/9z9Tn1Q53QezsjJsYmgNvfl5j0Q1PmViViFYr//srypfCIZbyA1TJ1hQ8te+1qaei1qplglsa01dshIRb5cmD8ReXEmi5pBWo9BNWyMPU7baE3Je19YWZpCyhHr75lpp8FtVQxvIPGr/G2jW1WAixUqvxaJSWHTt/caxDGsdE3BtqORS92sRHkMg79soRh0n7nentuFF84/vybS4tMmzx1XNqbEamwsxYMBotYdMABunl7gz1rAHLcHyHc0O8d5SWWDOIbtwxXr+ZgLitew/zIJGhPpuurOjJ4fxksqAwRc7sb3Jv8AUyjHIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1746567418; c=relaxed/relaxed;
	bh=Cr7N2dezP78cVJMktfdwBMBPLaglWq41DjwjkCTKySA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qu9jJxhM8pF6szyvdvpG2JBV3kQoZF5AUKhnAKCX7BV0lerG9Qx7ldRWHp/KxkLskQExo/xJVwVMphDgu/NkZneiyyyejvqADrtJ+1P4tDMy4wGmjVzSEhvyqwlITrzzY4gvOxPwZiDjrtTEPdk5R3jw7st4Wn6AJu4G0ZJ4spRc4pQyRymV5jhXoLxte8VRtGRKO9sfnhxfNPrw5rt5j/MyXw/cJDlEreynW+3HAWiszRU1KPtJ/sPkZJjekhXeDHAmN9KB6rpPfGThOhEGKcj3THpz2mMFFtkZoAAPOWB4n3deelxNcX9KS0K2gAtqQlbzGE626XLa32eOIWmDYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uxOo2WeV; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uxOo2WeV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZsWty04QGz2yvs
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 May 2025 07:36:57 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 216A861136;
	Tue,  6 May 2025 21:36:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A8DC4CEEF;
	Tue,  6 May 2025 21:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746567415;
	bh=3kJx4RrF/TV+86iMY/0XpKRaCCjS+kWAD0tKlrf/ejc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uxOo2WeVO5cbuQv7FwSXiMQiSnuYVoT8R1gohIxtSRzzph1JoP+oERYtdvr6M7BHW
	 5mu1VfbEgY/zLniy5B7+AklyWBo0x/Kxn2zOALJwSFt/iqUQS8dsFLb41VqPOs5c7M
	 wfVkoWB3CZYtWIA2h77yQNt3RJxq85cpjs80hq3sWHu3VecQUVTkdZjUTyvos/VGrd
	 w5sKmUWoW+AvkzZfMjIhuf00jK1+i7FPlgSrTVuz9jPVUgsg4tkzVCRItO7T37pzFA
	 wF4OGJQYtAK/iceMMJPTKDO1MzAlbq/T1O+VrO1YAZ54CTBU2aRhKYrtSEfEYhcX2p
	 QHxrB+zkyetmw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Donet Tom <donettom@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	mpe@ellerman.id.au,
	hbathini@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 02/12] book3s64/radix: Fix compile errors when CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP=n
Date: Tue,  6 May 2025 17:36:37 -0400
Message-Id: <20250506213647.2983356-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250506213647.2983356-1-sashal@kernel.org>
References: <20250506213647.2983356-1-sashal@kernel.org>
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
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>

[ Upstream commit 29bdc1f1c1df80868fb35bc69d1f073183adc6de ]

Fix compile errors when CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP=n

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/8231763344223c193e3452eab0ae8ea966aff466.1741609795.git.donettom@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/book3s64/radix_pgtable.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index c6a4ac766b2bf..425b1a9eed8f0 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -912,7 +912,7 @@ int __meminit radix__vmemmap_create_mapping(unsigned long start,
 	return 0;
 }
 
-
+#ifdef CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
 bool vmemmap_can_optimize(struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
 {
 	if (radix_enabled())
@@ -920,6 +920,7 @@ bool vmemmap_can_optimize(struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
 
 	return false;
 }
+#endif
 
 int __meminit vmemmap_check_pmd(pmd_t *pmdp, int node,
 				unsigned long addr, unsigned long next)
-- 
2.39.5


