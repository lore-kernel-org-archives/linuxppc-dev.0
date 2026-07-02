Return-Path: <linuxppc-dev+bounces-23453-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F7AC43602
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 21:17:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grqTq1b5Hz2ySg;
	Fri, 03 Jul 2026 07:17:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.188
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783027055;
	cv=none; b=S67TG5TmvBHt1MmdskTo76VJ6lQpM7Apua3MDMHRcyUVc9uCL1k1XsGeg0pFO5ZwGNY804lzpjhsqqrF2vH2Hfcw8F4YFd7R5BOeq/GA+ukxdYHknb8Pdj2jG/IzpBJ7DIRdbh6/uhOv96Cfn99pcZ22sCIh62B/YwHLzZfJSEbUFOy53JxIFQ7F93nQTe3kGbaUlPiNRRlWm7saNJ0Gr7mLuP9tCVLsJY2pgrSBsLR5Z6pW8fJBgma55cSL1Cb2qBFh1tQrGRFifS//H3reQGhj2ia6GtbaKitbP9MryecgtuWgrUW74duERUU8dwccFc7uxUb7jp1yFH7Rdp3bTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783027055; c=relaxed/relaxed;
	bh=FckzSume9UAhWiCYjPeKT36jEriGGdovDEyFKM1FYdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nsbbWtXPEtDgnkDRbUQmKfxlL6A65iQX5az2L8dF5I4E1zuv23yXoV6iykN6WdLjRJ8CUpUHNyrGjBGoiaP/nPCQVjFDVMW0Voxoug/SUfB2m1lO+zjWy0ffh2IS/tha6CqcZRqsiilO0ISl7dNrxAN6Ghrd5/Fna0Kt0B60gZlva2pjCcPtT55KBJtJ94NKuX8DT3vXTLcYJDrq/KY6hVVwCgrpYtQaU4j31pLV/2spYUey4VIdyucIZ+wpx0iJkLScJHObS/bx3kD02rHZRI/e4LdLdg/yZKJR6WbJ6EVJLndYOTSOgEKp6NF8nlW2Pl6WoMcl/zn5/yCJ/fv3sw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AlIFqVjd; dkim-atps=neutral; spf=pass (client-ip=91.218.175.188; helo=out-188.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AlIFqVjd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.188; helo=out-188.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grqTl5HxLz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 07:17:28 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783027027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FckzSume9UAhWiCYjPeKT36jEriGGdovDEyFKM1FYdU=;
	b=AlIFqVjdi8/mjO2vbbk5RfrR9z5ae9BqLW1E0RUz4RVsbtCdj72M8UK4Bno3NYac0Q/+CJ
	vQYAnKxH7BI3T31Yy/r1KiCfapk+Yk/Kp4Gh6auE3Ar3eBEJdK1k7BaqLu050lyd9wJROt
	vv/Uj2nN2fWbgX+uQYRElKJhDZDCqy8=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Josh Boyer <jwboyer@linux.vnet.ibm.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Tony Breeds <tony@bakeyournoodle.com>,
	Alistair Popple <alistair@popple.id.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>
Subject: [PATCH 1/3] powerpc/boot: Fix simpleboot CPU node lookup check
Date: Thu,  2 Jul 2026 23:15:55 +0200
Message-ID: <20260702211554.56923-4-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=955; i=thorsten.blum@linux.dev; h=from:subject; bh=a8z9ZcVrkiRPripAUUepnLp9TG1kSmUTU/ZeAF7JaQo=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFluV7kMfNzcjKVEd2Rw3VnTv07WXyFdW4trYWXyprgfX dbShcs6SlkYxLgYZMUUWR7M+jHDt7SmcpNJxE6YOaxMIEMYuDgFYCJznBgZJl12/Hy0je9q0hXu 7xVm/Gs4+6f3Lma5oq14XD5tasT9uYwMy5vZX/odSfopnnQlf/cWHunvU9/N01+9VV323mvL+It 7uAE=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

fdt_node_offset_by_prop_value() returns a negative error code on
failure - fix the check accordingly.

Fixes: d2477b5cc8ca ("[POWERPC] bootwrapper: Add a firmware-independent simpleboot target.")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/boot/simpleboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/simpleboot.c b/arch/powerpc/boot/simpleboot.c
index c80691d83880..27591df41e9e 100644
--- a/arch/powerpc/boot/simpleboot.c
+++ b/arch/powerpc/boot/simpleboot.c
@@ -68,7 +68,7 @@ void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
 	/* finally, setup the timebase */
 	node = fdt_node_offset_by_prop_value(_dtb_start, -1, "device_type",
 					     "cpu", sizeof("cpu"));
-	if (!node)
+	if (node < 0)
 		fatal("Cannot find cpu node\n");
 	timebase = fdt_getprop(_dtb_start, node, "timebase-frequency", &size);
 	if (timebase && (size == 4))

