Return-Path: <linuxppc-dev+bounces-22935-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5F0CDB471
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2026 15:39:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gl8Pq0b6Kz2yS4;
	Wed, 24 Jun 2026 01:39:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.179
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782229167;
	cv=none; b=TKrRwLWlSCLSz/Kvs+66GLsvSfIosMgQhV7XO9SbMVWn02nevA1vj1ef13sWv272/ndxFmU2t/EroouT/4YWtD1jVoDNGt8WN4h0OmsIfRymzDVffKgY6pnGjyNrM2uDVYTiw5nX+D3hYW2JT0SwmU59jZRCM6S9v8pLFd2noiVI6pdYP2pKFYJ+y3MlSxfh/K0PPzljS1o8bnXrt/5tYeoEc2scxHqa1ridvN1+qdZ5RX1/4v7NMLz4d+qqQwsHGZO1FKy2d/cnSjA73gydWYVBMw0kjot2PsW+Vlt4dAOFlurC96QPBRpbJRIEbkXP+FEmQTLJ8MqqtPPzY7xx0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782229167; c=relaxed/relaxed;
	bh=Y/ocUICsy65Y1mgFq/LsXs6J+MQAk/ZO9Azkdo+7zWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EzlhbmXTIzycfgB6wNtlLXtlam/gc7dLstlHtOJFL77G6ZySiFAgXOXkJi/HqkI4mAYX7R7bScbX8AV8IK1McXwEU4fyXqG+OAqXGCCqldXrTcylwdMnvL/zgP2LZycJS+0VEQyDKqgSeg2A6iuSso2XK2KUMVYum0oGSwI49CtxuooJ/daJiRl+gGUxkqZD7L0lMGyoJntJYtTcQZ2Jvibx+/szSRw9XuTR4nGox4wX2NL/2H1UOpx1iQsKKK4NO1Q2Lsi0sdXXs53PMsNCz+6oncbfCiNl5hhdjVatzWIiOnOZ7Z2F8/DKJTCVvMJLDRAI3GVbb+OIPA8wQi/viQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mefOYuWH; dkim-atps=neutral; spf=pass (client-ip=91.218.175.179; helo=out-179.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mefOYuWH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.179; helo=out-179.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gl8Pj1lWNz2y71
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2026 01:39:20 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782229139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Y/ocUICsy65Y1mgFq/LsXs6J+MQAk/ZO9Azkdo+7zWs=;
	b=mefOYuWHlvARVSS5bqpPHdg4VmFmLWtIZBJELc5Za50o5L+jxfZBvXJycXKLzgSJuMjO3c
	fmpLmB4/Dus9SRhJ565lYzTnRBFI0mwOgoRq+aMeu1Hfi85DOiiD+saLjBWwc0cAZMpBpp
	al/AhwIeKZ/ZUr6AFzluxCQy9Veb05s=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/serial: Fix include guard comment
Date: Tue, 23 Jun 2026 17:38:25 +0200
Message-ID: <20260623153825.403819-2-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=830; i=thorsten.blum@linux.dev; h=from:subject; bh=O+egtxl3FGeEgCunqgjMc4FehShbJuDfZCzq6oPYrRk=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFlWKwoDD/pNlIvwm3NypuCkttVvXoqnd5gzlb1hNrDeL pfyTsm5o5SFQYyLQVZMkeXBrB8zfEtrKjeZROyEmcPKBDKEgYtTACYyay/DT8aDjP1iU5/Fc0St s2/f/2ap1KsNSue3Lm5ZnbVcUPGckSwjw4prn9737jri1bvPXT92td+q5jJRFYvD1+4+2/PzY0/ PYT4A
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace _PPC64_SERIAL_H with _ASM_POWERPC_SERIAL_H to match the actual
macro name. Remove an empty comment while at it.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/include/asm/serial.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/serial.h b/arch/powerpc/include/asm/serial.h
index cd6c18d0e66e..c3eb4a64b3f5 100644
--- a/arch/powerpc/include/asm/serial.h
+++ b/arch/powerpc/include/asm/serial.h
@@ -1,6 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- */
 #ifndef _ASM_POWERPC_SERIAL_H
 #define _ASM_POWERPC_SERIAL_H
 
@@ -18,4 +16,4 @@ extern void find_legacy_serial_ports(void);
 #define find_legacy_serial_ports()	do { } while (0)
 #endif
 
-#endif /* _PPC64_SERIAL_H */
+#endif /* _ASM_POWERPC_SERIAL_H */

