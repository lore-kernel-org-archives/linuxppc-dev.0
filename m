Return-Path: <linuxppc-dev+bounces-25363-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E1FEC55184
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 11:37:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDs3Z5L3Wz2yLY;
	Tue, 04 Aug 2026 21:37:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::ad"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785843466;
	cv=none; b=JXGUqvivr/36RMPByp7T5DciSFJb9VVpRL5LcTEMkS659Iauuj+POlQUNzoZVLzBJWdbvOphEPBAJs2/erkgoruK9SRjhtkpcAUe2cJgTJdq+MwhCvcWG3ZRjv08+ZSl1JxvcbCm32tjVIjwspiwdYJDV6Ax+zhLrZXFxv4O7UF5mLsATOVc03uXl1Fgz5k8aCpjozIPJ0mP3/xXGj36JB/eHoGPT+oRx9oVJUPsSz+tv2qu/Mq3AtGbScj0DgaYgmrpyRavH5aoQmR4HUCrlAGklqpwV9AGwO6InkR7T9GzSTeiz3+z1JCnNXvy76h7EtGc5QXrUQ5JAZ4jSpDR9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785843466; c=relaxed/relaxed;
	bh=rNGq6F5u+ec8AaPXAvpZxL4+irPU2jtOcDSueug9CII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M7fGtOrmGJp0jd+K/xzRKz1eSNOpICo2HRRSZZDyyUT7rJufFULmo2heY9ocSyIgVWL0e4IgGNpT+6NzEkxM4Qb4ZpH+KEhsfSt1gGdHH/aUQjqOZVkYd1K9FMUV89ZxKXgRgcXRx5zjno6DhTss3HIrzACmQ694SPJTIlvQvBt+QPMryoW596TGBiGV8a1KK6IfpPgWR2FEbmoAWSiNf1sQnWbD/ux32WFI0XjNfTL8h0D2SKENdP9apl59j93rRZnUu9nCc3Vd/a0aP9kgI8FKD5mzLQYqLYL5v43IN0dE8vHZc0mBnD3z+HtCafOtp6BbP929RzRRkrkJjvaSPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VJT0ySdH; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::ad; helo=out-173.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VJT0ySdH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::ad; helo=out-173.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ad])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDs3X2QkFz2y1Y
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 21:37:42 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785843437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rNGq6F5u+ec8AaPXAvpZxL4+irPU2jtOcDSueug9CII=;
	b=VJT0ySdHLqF78y10Wmz4IGmABflVYGQ7Bt0OCfU2KjeqpBF3B+HZgvHfG8MIQwN/S6gF1/
	e6V98/VeufpvyTIh2K7vugJBxfyq50f69fsJcIBGvivFqnHsYNsTKdXiUnHnvhswdO5hSl
	BkeA8spNrLY1wCOlZhIUGaHFnW4ReFQ=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Geoff Levand <geoff@infradead.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	Geoff Levand <geoffrey.levand@am.sony.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/ps3: Fix failure paths in ps3_create_spu()
Date: Tue,  4 Aug 2026 13:37:12 +0200
Message-ID: <20260804113712.60967-2-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1100; i=thorsten.blum@linux.dev; h=from:subject; bh=xP+uSzjBi5Wq/EoN8eVH5Zm1zjYzVrbRyULEVaRkUY4=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmF517IzLkz/d7MVYaNN+2OaXK6FYi+3vydMaYtYeetR fXLv2rodpSyMIhxMciKKbI8mPVjhm9pTeUmk4idMHNYmUCGMHBxCsBEfloy/JW+bC7cJLTaL91/ l+rJwI1R9W9MJ77hMm7xZhG/75IxfQojw5SZBv7Kn+YFrr9euun9szD2P3kVk6/e953e87NBRsV BmAUA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

ps3_destroy_spu() expects the logical SPE to be constructed and enabled
successfully. However, ps3_create_spu() calls ps3_destroy_spu() when
either construct_spu() or enable_spu() failed.

Only free spu->pdata when construct_spu() fails. If construct_spu()
succeeded but enable_spu() fails, destruct the logical SPE before
freeing spu->pdata.

Fixes: de91a5342995 ("[POWERPC] ps3: add spu support")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/platforms/ps3/spu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/ps3/spu.c b/arch/powerpc/platforms/ps3/spu.c
index 33a676fa3d6c..05c439fed8a7 100644
--- a/arch/powerpc/platforms/ps3/spu.c
+++ b/arch/powerpc/platforms/ps3/spu.c
@@ -369,8 +369,10 @@ static int __init ps3_create_spu(struct spu *spu, void *data)
 	return result;
 
 fail_enable:
+	BUG_ON(lv1_destruct_logical_spe(spu_pdata(spu)->spe_id));
 fail_construct:
-	ps3_destroy_spu(spu);
+	kfree(spu->pdata);
+	spu->pdata = NULL;
 fail_malloc:
 	return result;
 }

