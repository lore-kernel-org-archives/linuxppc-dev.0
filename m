Return-Path: <linuxppc-dev+bounces-24069-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497B8C43458
	for <linuxppc-dev@archiver.kernel.org>; Sun, 12 Jul 2026 15:14:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gypxj4jP6z2xyj;
	Mon, 13 Jul 2026 01:14:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.180
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783869241;
	cv=none; b=FCvj7z3zzHadnzPRxRdHmK6sPAYMA+Z9vjJqr6INsSL4VdQsOxfXVV4mqNjafqLrYVn+L2AqhWYaC3V67NXBoupi+7sezh/1wQA5na4YU48cmD4kapNe6JiU2JWEHrMi9tycUAA90IzITDfY0JCFss6RPuEfRvYhxptHqy2C1K9nXeThsbkrhs4/jsYtGJBT1Hj+hT8DHNwXDy/a1tIKLSEUhL9w4b3oOZmUovHdy5dT6OdFNBpQP8bxsadjC1yaeoULLDk9JqY9PYwpiMcXZxXdOdxJXoCN19niSRDhN8qtZlbvDKIRFZnBSbEPlUxcjj6Tqul3w9dbUtyjjwLYRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783869241; c=relaxed/relaxed;
	bh=qlBazuDfTLLgJMNtACifdzpIJ9ZwZRj4oxVY6o2V1vU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FCCKqUhT5nKCcjpWHSoqbpgvSibTRSvoMWNE4pjMserbmJkRHHCtpoFdq0x0dl79kK71hUedDu5C9nPAYdp4V+3wccN9x1ZwytbVII257NmdE4BLm850OkhuSUIERVi3t1born/zgRni/1mF5wf+H3xJZYvilseq0MXb5AkyYng9e/ZBaxmH8ABnWHuQE+ii/TcWOnttX7noOv5euUswLrQa0rC8jXoRl1xfWf0fPyaaH7dUikSvHxouKLYSiOBZyMHeJnzNkNmgdYqcc0pG43DTKtbfjACnV1CaFWR3DtredTSeTPYcWzT6PpXzYkuJiC0kDpEjsN5B+bHqd63k3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=J3dmoOQW; dkim-atps=neutral; spf=pass (client-ip=95.215.58.180; helo=out-180.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=J3dmoOQW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.180; helo=out-180.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gypxd1PB7z2xqM
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 01:13:55 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783869215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qlBazuDfTLLgJMNtACifdzpIJ9ZwZRj4oxVY6o2V1vU=;
	b=J3dmoOQW6GS/+aQlELWzLRnjwGs5blmY0IFVMunwxvszzaW13qwCc02wWsNd/HtgJo5PoZ
	JLT2mvIrsPZ5S1hZ6BfKkYbDL5VRv06gKtjgSGsND0vEl2BmOcyTBhkqC6jkP8q0MLtuTd
	vER7gJTE7qDSQWIn4AuMvrMjKq1RJ+4=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Geoff Levand <geoff@infradead.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/ps3: Remove unused struct table in setup_areas()
Date: Sun, 12 Jul 2026 17:13:02 +0200
Message-ID: <20260712151300.3664-3-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1031; i=thorsten.blum@linux.dev; h=from:subject; bh=J/5szq7ehq7CZ6MfrtbtoN0Ra31a83MS5wHgAbgJIsk=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnB6/6cWa906ZNr9OnV21SyG3plnl5hUA/bO2dNT803v 1Slvx1HO0pZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAi95QZ/ufeyzi5YWOmEL9Q zZQbGccSO9jZlr0L3DTd4cXjRUuipKoZ/mk++39eLqmzfGEIq5RU1735887tPLvKq3dp0QuthD8 zktgB
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The local table structure is not used - remove it.

Remove % in the comment while at it.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/platforms/ps3/spu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/spu.c b/arch/powerpc/platforms/ps3/spu.c
index e817def7f424..c904f9fa1caa 100644
--- a/arch/powerpc/platforms/ps3/spu.c
+++ b/arch/powerpc/platforms/ps3/spu.c
@@ -185,13 +185,11 @@ static void spu_unmap(struct spu *spu)
  * The current HV requires the spu shadow regs to be mapped with the
  * PTE page protection bits set as read-only.
  *
- * Returns: %0 on success or -errno on error.
+ * Returns: 0 on success or -errno on error.
  */
 
 static int __init setup_areas(struct spu *spu)
 {
-	struct table {char* name; unsigned long addr; unsigned long size;};
-
 	spu_pdata(spu)->shadow = ioremap_prot(spu_pdata(spu)->shadow_addr,
 					      sizeof(struct spe_shadow),
 					      pgprot_noncached_wc(PAGE_KERNEL_RO));

