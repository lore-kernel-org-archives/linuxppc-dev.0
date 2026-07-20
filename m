Return-Path: <linuxppc-dev+bounces-24556-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C11DEC44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 23:13:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3xBm0bm1z2yT0;
	Tue, 21 Jul 2026 09:13:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.173
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784589184;
	cv=none; b=cvDf7mFjSGxGwm+xpbENYIiHxJ2hjdcEubrnqg6F9vbKlt4uNDCzWKsft+a/I4a85wv0/FUJ9JHxpp7dEqomraOl170pRKOxUKh2DYPX/ImpWnxOFDCvqyFaU5v/PjuewvBN0bwjbQ8VLv9BWqhmDM7+JUf6wuAyf+CNuPFh74rygPVlEAfX3UDdS1a9DsPVXNBVch3L36UXjUfsXv+QFaDiZMjPCmC/idwpiCW8vnEJlAVZMZUhp31io7PXT2lQgPle0LMDfzCRtoA8Y2YX7/f0cb1vVvDTmLL6Oz5WoVRMr8H7FM2+VNUTTuzr/B1nKfbkRX2Q/qDBsCHKpCZ3fg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784589184; c=relaxed/relaxed;
	bh=7bJuV0SZ2xoBq4U4y0yPh8DySjTLRw6/qKSlATYB6Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VnzOcimZ2UXOL+O6onivqWwJ2SIPW94xuC85PotPOzCm+IQ5Es/UGzIrvNN/ie/oTmYEVCrzgHYQ6fVWpgBwhGNi/gBXYMwCav0Nh+efww6Ijev8nWLp5cNrxvAEUK0VRi+UR3wqlUg6kvEp9d7aiZ1rXhcX6LmDtHU98z9B8DKvFbzCb4VbcwxJ8k9Ld7aHqUQhK0XLN9uXfQ0yFJmKYh+0y6ir5RyTN+ElvoT105j4irP+Q+V5MZULAKoZqQBMIDCiyZpAoTRWH7LiFdSwxlYdXN0Sr86XwYXfLRdlFKKPLZ/DZxwbgujoq4EQzrm71S5F1BovpJanX7/I8n88kQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KNu4eXXT; dkim-atps=neutral; spf=pass (client-ip=95.215.58.173; helo=out-173.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KNu4eXXT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.173; helo=out-173.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3xBh1bplz2ySN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 09:12:59 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784589157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7bJuV0SZ2xoBq4U4y0yPh8DySjTLRw6/qKSlATYB6Ng=;
	b=KNu4eXXT+lOUb44AngQntfTGwl9okQXIJnGNSioPbYFAt0SFpHIbkiO8nzsB9MprvWM254
	6DuoD2Ai76rUw4L80yio8ivxf0zYoDWxDjJfcBjIp2UtnIWx0Fi5qFAN8q45IWvzZCF44p
	lNreG50Ypz0WpM8qy89CuAxMHI8q+Kg=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Geoff Levand <geoff@infradead.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/ps3: Use cpu_relax() in ps3_create_spu()
Date: Tue, 21 Jul 2026 01:11:53 +0200
Message-ID: <20260720231153.116827-2-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1127; i=thorsten.blum@linux.dev; h=from:subject; bh=GIpgVspGffpwkkdjtB6BHOzz1URiFhSrELYesrG5VYQ=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFlxqy2nbKs4szxeY0JjW3pK9eL+ldN0mHM/S/p8ed8ur fzA4J1vRykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAEzEcjMjw6QJ79iX7uW2uKe8 KeIM8y9JL+HPd7/+6l3uVxWqcGqKUz/D/7xulvip22Z9+qy9jYnVfKmdc/Tx1dOY7blcP6zqSVg awQkA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use cpu_relax() to wait for the execution status SPE_EX_STATE_EXECUTED.
Drop the comments while at it.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/platforms/ps3/spu.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/spu.c b/arch/powerpc/platforms/ps3/spu.c
index e4e0b45e1b9d..8545c72385de 100644
--- a/arch/powerpc/platforms/ps3/spu.c
+++ b/arch/powerpc/platforms/ps3/spu.c
@@ -13,6 +13,7 @@
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/mm.h>
+#include <linux/processor.h>
 
 #include <asm/spu.h>
 #include <asm/spu_priv1.h>
@@ -363,12 +364,9 @@ static int __init ps3_create_spu(struct spu *spu, void *data)
 	if (result)
 		goto fail_enable;
 
-	/* Make sure the spu is in SPE_EX_STATE_EXECUTED. */
-
-	/* need something better here!!! */
-	while (in_be64(&spu_pdata(spu)->shadow->spe_execution_status)
-		!= SPE_EX_STATE_EXECUTED)
-		(void)0;
+	while (in_be64(&spu_pdata(spu)->shadow->spe_execution_status) !=
+	       SPE_EX_STATE_EXECUTED)
+		cpu_relax();
 
 	return result;
 

