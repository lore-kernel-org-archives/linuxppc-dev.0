Return-Path: <linuxppc-dev+bounces-24045-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717E3C43458
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Jul 2026 13:10:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gy8Fp5sFnz2y8F;
	Sat, 11 Jul 2026 23:10:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.181
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783775438;
	cv=none; b=DC870Bt/VKb4YqGJ9M8zqjeTDVWX1QCG5mig4bGuPmtJVBGAw0LF+HkvJmzRlnSr4xatfT9dQxo2kKrkv3aLup5SxseMqw9DnLp6d/5zAL0eoWKAEV8jtC4PTxw/wSp/q14uKHIRlJDWnUjRQn/qej+8BtqXZf3I4rXhXe1eBIr4pz2J6MK85yDw7idOaiiFamYHykE5SAkcjwgHONnhCIZLPER/z6wmP3vO41JXK6Y3+vEuR5oDSt11qIXxIbxalkumYIFqIa3ma+qYhBMzdlBdjWaCBJcUr0BTHJ5/JWu/+Yitlwj30GuiHt0VXIsDDJ1e+3ZqiGo8aPe76Zfw/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783775438; c=relaxed/relaxed;
	bh=jVKKrioraKSDfaDaMgjgygxPfYcIZrSPy52HWbulI0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I2g0wZr5rOg3vPqWxu72mfVfz8TNwxptahcVWHXZPArBiD7hJMEGnOrUIV1vNUbvbqrqbs8paVwFJLL1bRCTbg/jk15as+Svz3FTE9Q+2PnY07WTL5mZetqwUurP9hsMU2Zbqo/oFKlwBo8ZEUKyKtkxy7qrJPzVKsrFLncjkj3+uklGf4os6YYej2an8/JUGoRGKv4kUR8JAJ+UCTYI9ux52q8LwOu+e3IdnX0k75FaWrdDTutvepD023VwfoOigPiPRMt4lQZtgCAdoFwIdBttsaQ4dRmpEmHZPG7sy4xiK0BIIF168hfLAxoE6H2Mrt+XbsbsX4+XaCNoP8HC3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=RbbaB3m1; dkim-atps=neutral; spf=pass (client-ip=91.218.175.181; helo=out-181.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=RbbaB3m1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.181; helo=out-181.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gy8Fk4rTKz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jul 2026 23:10:32 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783775407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jVKKrioraKSDfaDaMgjgygxPfYcIZrSPy52HWbulI0s=;
	b=RbbaB3m1jmWIHpVQU8CXskIyhsYL8TST/LJW5qIUR/c8Q9+GQ5LlnzAjTyvhSfWFsmLPPY
	KNXKhe9V2US9IvqZpHRIix5ggRhzIHLnRrIm6spY+XISGTzmgpgEGiobqS0ANxVu6SXc7m
	4DTqx0JoJ7LLN5NM1Ahh49NGFtPcMgo=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Geoff Levand <geoff@infradead.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Paul Mackerras <paulus@ozlabs.org>,
	MOKUNO Masakazu <mokuno@sm.sony.co.jp>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	Geoff Levand <geoffrey.levand@am.sony.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/ps3: Fix map failure path in dma_ioc0_map_pages()
Date: Sat, 11 Jul 2026 15:09:32 +0200
Message-ID: <20260711130931.740719-3-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1027; i=thorsten.blum@linux.dev; h=from:subject; bh=T0GD5bivugp2d8VVA9aIzmp/hDHu9TKTk9CZkdcMi6c=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFlBDt03bZckXWqR2jHbYLG3lfO5YM07odfPTZ93c/ttl x+vjT3DOkpZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAiUTsYGU7srE9y4566cu+/ sJ3uPGFrHc7ODP5SX8z0fdlamTesH2UZGVb5vemyEagxmt6vdMaq0LVq2flgmz+aL7QCg1qZZ5R 9ZgIA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

If lv1_put_iopte() fails in dma_ioc0_map_pages(), the error path
decrements iopage but keeps using the failed mapping's offset. As a
result, it repeatedly tries to invalidate the failed IOPTE slot and
leaves the already installed IOPTEs valid.

Recompute offset and invalidate the installed IOPTEs instead.

Fixes: 6bb5cf102541 ("[POWERPC] PS3: System-bus rework")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/platforms/ps3/mm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/ps3/mm.c b/arch/powerpc/platforms/ps3/mm.c
index 20fc5b68faee..315a32fd75b1 100644
--- a/arch/powerpc/platforms/ps3/mm.c
+++ b/arch/powerpc/platforms/ps3/mm.c
@@ -615,6 +615,7 @@ static int dma_ioc0_map_pages(struct ps3_dma_region *r, unsigned long phys_addr,
 
 fail_map:
 	for (iopage--; 0 <= iopage; iopage--) {
+		offset = (1 << r->page_size) * iopage;
 		lv1_put_iopte(0,
 			      c->bus_addr + offset,
 			      c->lpar_addr + offset,

