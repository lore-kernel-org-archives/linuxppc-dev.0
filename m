Return-Path: <linuxppc-dev+bounces-25603-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2BE4C5AC7A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 15:32:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGp6h34NCz3c75;
	Sat, 08 Aug 2026 01:32:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.176
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786116732;
	cv=none; b=l9SMHXqk6Lmap7z98R0pLsP/jWJ+jIV0+63da1ACAQvq7NRM+Sqd3xPoABiWmmxc5mO4LoKx4TT3FXiXAmUEiIG66a/lHQoFdyY0EQC3O9+LxM2jQ1zbczGTQWeFyzUQbSiy8+Io06X3UOp6pZMtRrOlX4hN98YL6n4JHMzDAftIYKkfeJO6YwGChUBAjK0//QhY57y103CJeXGOZoc3JOvmcIKkl++cfQQE8fnRuiWlmVYOty9KcuxOZW7G3u/5ERMnLcjns/H8snTm/Q5CTlUWax+xCSL4IdsTT4HsrXV0BkPzqgzhaJwHFFtNwommSL7fNlGbSeLfIeRhkr0Lbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786116732; c=relaxed/relaxed;
	bh=iN95xa6NnO/iEg8YYVWS4Ihnptc/Q/Aco6C/8mmiemA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GBHpnBeR8lrO+iCFq0B+Tt56ITrpwqssrH02ootKhf4LI9SXTs0swqpbIRwGlXLDZaNVDCfuQXyIWbqonwfJNflZ++qk4O8ntUtYVevF6Ile+bLvHKtmf3MMqqd8+gzfDH2cmgQjJgfl2j4LP2il90y5n2sxdOk0oCc5XIpWXIOKDZeu31SoH0z9bOA5B5GWRnLwv7FwMwP72JR10LJ97AEa25EX2KRD54K9UkhnZ/z1jjtCL2cKYcos6dA1i7Tx9r65ylEZcbInHENR4N97jQNwfEt5uN4WS0VsuxPhLSss/oDm1UGo4Fky0Qdec7eiC/GHb3aO6CtbdgzEXBuwrw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TY1sqpWk; dkim-atps=neutral; spf=pass (client-ip=95.215.58.176; helo=out-176.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TY1sqpWk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.176; helo=out-176.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGp6d0SGyz3c6c
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Aug 2026 01:32:08 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786116302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iN95xa6NnO/iEg8YYVWS4Ihnptc/Q/Aco6C/8mmiemA=;
	b=TY1sqpWk+aXtgOi/zxhRUdMmq0ZpsyS/7iBZILGYgW+p3dyHkm70P4DRC0w8KkvLShwUvC
	gOIGpz1nxt8R5gbiYtcRqLwENamF9MhIsrYDiLmQtafX4jbqkqvrL/ORp49h6Ii69VtE5S
	nwp6zJHqjhmuJkAYAEYwFom7vmjg3ac=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Geoff Levand <geoff@infradead.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/boot: Mark exit() and ps3_exit() as __noreturn
Date: Fri,  7 Aug 2026 17:23:53 +0200
Message-ID: <20260807152353.306889-2-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1059; i=thorsten.blum@linux.dev; h=from:subject; bh=Te66I3/oXUwQciXEYplZBLazQetOY/A4HNBH3qQlFvo=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmlP7oy52x/aJxX+iVYTbU8foHTIt9uqX1hEsrmS3rYK tqM2FZ2lLIwiHExyIopsjyY9WOGb2lN5SaTiJ0wc1iZQIYwcHEKwETmvWb4H37tbl3DhVd7A/ZM ZfvOsYvBw2LBx7cy31suHG/hM2t8y87I8HF93s39i6U3a774t3Mxu/6/r7de7l+kaMS7+M7U6df iDjICAA==
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Since neither exit() nor ps3_exit() return, annotate both functions with
the __noreturn attribute to improve compiler optimizations.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/boot/ops.h | 2 +-
 arch/powerpc/boot/ps3.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index a40c2162a4e9..df52b14816e2 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -217,7 +217,7 @@ static inline void free(void *ptr)
 		platform_ops.free(ptr);
 }
 
-static inline void exit(void)
+static inline void __noreturn exit(void)
 {
 	if (platform_ops.exit)
 		platform_ops.exit();
diff --git a/arch/powerpc/boot/ps3.c b/arch/powerpc/boot/ps3.c
index 89ff46b8b225..22fa35960926 100644
--- a/arch/powerpc/boot/ps3.c
+++ b/arch/powerpc/boot/ps3.c
@@ -45,7 +45,7 @@ static void ps3_console_write(const char *buf, int len)
 {
 }
 
-static void ps3_exit(void)
+static void __noreturn ps3_exit(void)
 {
 	printf("ps3_exit\n");
 

