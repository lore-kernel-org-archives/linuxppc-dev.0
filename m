Return-Path: <linuxppc-dev+bounces-17462-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D29FD0045
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Mar 2026 01:35:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fNl4h3KZrz3bp0;
	Sun, 01 Mar 2026 12:35:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772328932;
	cv=none; b=Kvp8rAz6YH/xkv+Fkf+nIREmg92Ox/sPBL112cIwI9/XYqIv7ZE9byHUqd3bSwb3HKOTGGpfQxuGglZTDXBcRveHQhhe1jzG0P9ZlQnvkogqEVW4uQb+wHzk9tdHRXAhHB1WyfJcvorqB0kEkMpkc6c6EiyRRkIlAcC0k+BFida+hznhiWZ+NwqXe2kvhpfklixLdTSlR20IOe9OAxRQlpXhBqcGGt1OGHXuBYoQPU+XoBn3jeZDqV1+vPT+2HjDQwgoINwjJIdsGec8WfIJq8cgnRMMjYXku2mXwV5A50nFILSgdu3OfJQXhxfYVq3Qwzw8aH4h9LVSQIspFm2I6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772328932; c=relaxed/relaxed;
	bh=PFrJOci438ln0zOVsVGZNrpZgyVt3Mlti2h6xxfpKmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XYHQAtQ2NOUCEiV+bsAMTDyAJDcaf5j1MavR0OFzoux4SMmQ8vzfbXraow79NQuFV8/eE3HqV+qp9KQ6QYqFDXDidJH1mOyPJUNpNyDpRLg6pxjZgpbroyYfnevxKUWr41Jkd87xmLfa2n9n65MJqDZi10Zp+AqG5G9HZ2DybYPULjUlpdf5IqrGrT5zvdfqb1Z9bca+WCGKMp1yfD9PAMISq8W3xJZ7KaL5xiOd/6TDGasVRIRFCyegSuQlX5u3zliDwLMHatOKxW+XxbQ/N6R3t1o9MRUW5SoFsMjeY1m5bgoEDUeUv8e74xZ/Skz3GMewv4eNr/4NyGh15hieEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=odpbHLry; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=odpbHLry;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fNl4g5sqWz2yF1
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Mar 2026 12:35:31 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2425560126;
	Sun,  1 Mar 2026 01:35:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BEEC19421;
	Sun,  1 Mar 2026 01:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328929;
	bh=hQHVjddpf7hi5VOf+HYbPLrWcsziyH8t913F44jchaQ=;
	h=From:To:Cc:Subject:Date:From;
	b=odpbHLry6Hh3GYPuHUpYccY/MA93eYzgumtTpZelWRy72iQr75m0bq6ebdPK0HEDb
	 GpjfMz+JeeolR8SsHY12pGODNB5Tosy860u2WrszAhF69j+JwHFeKVm9FILcFfCqLs
	 nHxkUyoDJKdcxVYHCgZKuNOZqZL8ghcopYNzcocIMmiQ2TnYTtdaK+RH76APGAGx5h
	 tnyFhOQiAwZglcHE5wk3pMG4jJLCkeFt+a8N8HRkSY0V03y/X3DCJk0n0cnWWKukP0
	 64ktFNFwKLUck0pS9nr7IOcmZjIKdhKROBndm/ga2GhU4hKs+InG5sHNMMXSxlmjJB
	 n0Xa+uxSO9W0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	lgs201920130244@gmail.com
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: FAILED: Patch "powerpc/smp: Add check for kcalloc() failure in parse_thread_groups()" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:35:27 -0500
Message-ID: <20260301013528.1695155-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
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
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 33c1c6d8a28a2761ac74b0380b2563cf546c2a3a Mon Sep 17 00:00:00 2001
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 23 Sep 2025 21:32:35 +0800
Subject: [PATCH] powerpc/smp: Add check for kcalloc() failure in
 parse_thread_groups()

As kcalloc() may fail, check its return value to avoid a NULL pointer
dereference when passing it to of_property_read_u32_array().

Fixes: 790a1662d3a26 ("powerpc/smp: Parse ibm,thread-groups with multiple properties")
Cc: stable@vger.kernel.org
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/20250923133235.1862108-1-lgs201920130244@gmail.com
---
 arch/powerpc/kernel/smp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 292fee8809bc8..cad3358fa4c35 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -822,6 +822,8 @@ static int parse_thread_groups(struct device_node *dn,
 
 	count = of_property_count_u32_elems(dn, "ibm,thread-groups");
 	thread_group_array = kcalloc(count, sizeof(u32), GFP_KERNEL);
+	if (!thread_group_array)
+		return -ENOMEM;
 	ret = of_property_read_u32_array(dn, "ibm,thread-groups",
 					 thread_group_array, count);
 	if (ret)
-- 
2.51.0





