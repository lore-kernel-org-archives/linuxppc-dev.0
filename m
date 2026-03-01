Return-Path: <linuxppc-dev+bounces-17459-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B959EFD0049
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Mar 2026 01:24:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fNkrD1MRbz3bp0;
	Sun, 01 Mar 2026 12:24:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772328284;
	cv=none; b=FTprxabhcc7A/Wh1ElyiwhbmWrdiQHcSX8yszzNcdVBECiO/bwfbYV6DJJ75ZEgwP05TweZU00TGh8G7PyADOzoGttQTr9g/dCkKqJkYqcQLWEbCeWIEmJ++UuYCn6iP1M21N/x66vfvEo+DcTiLqzPCoT87rSAcf+AsBHA1PESSrzZpX8Utvm+LkmwK2JjZ0FhoSU2rIhc3wV9Rv517bCZFWZaBZ5ahl9Zk0K13WoGRGIMoMBDubzdwBWSOwyBBYhB2N1bBsENgnIifgtLSU2PUEGdIJOWO3FhVhd2ch8cdKSNJ9UJWPY9eqPi/k0pn1g79zsUSuStI9pEIB54y9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772328284; c=relaxed/relaxed;
	bh=s2XwAhrDbC60lrDz1umM+4SIGDEqYDeQWiORdETsSX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=crZqlcuojXKOjV2e3woGztRtWZn7H8Xyypye/oHxUAh8qawLXCNrabV9SvsHATZFZbYnMur948uKUM/8kwJvdTkC7uBRtQmzPa0JTaWUhze56cUHSEriNqp3hiSU2bfNoKuTJh36JeH2IF3UeJ2fDQRFce/qJjqZYFpgzyEBgXXOo/qj3PLsqrozKcTwYPbs95dTqAlGC38VEuezkVi8G90JE3hfEGEU+WDYcedHwnEfJYjcEysk4cR156ye+vhHAOY3dZEddteSwZ8bMvp4XL6UNY8lekTm6hI5qAIpJpAjuGwYZ7McGv30MvVOapIyeHnxTxVX3rsZvU0/eeC5Ag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ALKitZ5F; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ALKitZ5F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fNkrC1qv4z2yF1
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Mar 2026 12:24:43 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A832D600AD;
	Sun,  1 Mar 2026 01:24:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3ED4C19421;
	Sun,  1 Mar 2026 01:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328280;
	bh=1zHeqx5A0fPOef7dleWESDWxHRaitZC+ksGwBypNhFY=;
	h=From:To:Cc:Subject:Date:From;
	b=ALKitZ5F9++aYMr7EF/jJ9LetV3L0DL+FJzzwXkvgC6KxT+xoUP7qlnjEBIxVek5C
	 X00bCIMxvSZ7IynD/GjwMeP1ijTW9azgkenOr5WnxoWf15BC0kQL5ENabRSRyhY8O3
	 K5PbHofPoIZ/N7z1J1NOrchmTQ7LyZs5IKUw1Jat8RScbKc3/7nLkUjZtNROmfbmq1
	 06i4irXO5qn62/2Pu8RqydXqExzwyT2fokHCh+RG0V6ee+Wu9IRljYHHM5JKEgJnra
	 Z87wQPz3IzGEBtiEWIg0OOyz6QP/NBeezQsGCVWJM//jiPl+nF2q8hDa3IklTf7a7w
	 1EkCuCCtShu0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	lgs201920130244@gmail.com
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: FAILED: Patch "powerpc/smp: Add check for kcalloc() failure in parse_thread_groups()" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:24:38 -0500
Message-ID: <20260301012438.1681542-1-sashal@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
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





