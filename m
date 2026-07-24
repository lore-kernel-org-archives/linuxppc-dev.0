Return-Path: <linuxppc-dev+bounces-24803-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C37FC531C9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 17:23:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h6FF941JJz2xnQ;
	Sat, 25 Jul 2026 03:23:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.186
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784913789;
	cv=none; b=NDzniUfZK2VcikcOn5Y8lz9v9e+CIWSqMui9gkRQGY4H6Ops+fE+ECdAvttUgODVRvp3huXajO/5T8ta3B67ZyNcENOjColQK8nAbocVctBqKfHhi1iX1rHEup3yWjZ+qxO09xqSxtjeeeH7axYGkuiPu/H5j7v5gGQ8PlnvH5IK6BA8Nsf/74ALg3d1yLKkYrT8AMLNEvBT/9LEeCKpJDjvAqn/cYCaIDUReSM7QtcGK8yx92YEm90L7rnHPhvGCiu/3gyH4WZXCkHWEXZT3ZgOxpttvr7PS7j7SAEZ7pcuAf4SLoULm8yPj0baRW8GXqrx9nIRK1RO05Gi8EEhGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784913789; c=relaxed/relaxed;
	bh=gQQLAIe3XW3GJhhBGiEY/9V43XiC+l3cHhMKbxCqABA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JBbPbTy83FbLCsBaQWDWjCw96zEXoaABGRTLdOkoOvc6x6c7pR44ck+b4faLgEMGuBb9M6J34C7T+p4TLpEC2MiCgnIg7pF1ZYsgIsx5zuAkRUz7B7RrnqlUtWYBKY0ymbe/FjgzoFFMFeTkypjZaFaAEmPi+BDVwRApiyziZqkNwEqcAgwAYbEnbI8/x6kqAPmXwLegKJoWnGX2SRzZ6Go4PCgTk5bg2xwEGnzbkH8DmAYLWJix88fg+fM+Bk60XlGHoclm1Zrzwxr3OtauqdVpt5M5zjJ+CfzZPwe996fOUnfU0ydQaF5G0vdg8Wy3Z24X3Ui6I/XJWS+WF97+7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rmhESXMY; dkim-atps=neutral; spf=pass (client-ip=95.215.58.186; helo=out-186.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rmhESXMY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.186; helo=out-186.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h6FF701Rtz2xRs
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2026 03:23:05 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784913764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gQQLAIe3XW3GJhhBGiEY/9V43XiC+l3cHhMKbxCqABA=;
	b=rmhESXMY8FOu5xEiZ2cLwils0NkXk7/EXqmJ2J8L21O3tipr6Fp2RDXUoDEhMnsxVF2Z9+
	ttD/rvQlNwvL5QCE22PL9Aiwr29ojF8anOIe05JJvO24aE/z8fKC08DYZQE2VUz2GFl/Um
	m0edQnJMABXvlVwSgS4Cy4RHg7gEMaU=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/boot: Remove unused sprintf()
Date: Fri, 24 Jul 2026 19:21:58 +0200
Message-ID: <20260724172200.208722-2-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1392; i=thorsten.blum@linux.dev; h=from:subject; bh=xg8oj3CjtFVR2VxGZDsIUIMQRudEZuz2B6O10N+zv5o=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnJ8y2U2DjLWgNTWz2tnU4pP3FfyutfNtvhd/7VigO81 3naZl7qKGVhEONikBVTZHkw68cM39Kayk0mETth5rAygQxh4OIUgIkU8zIyfJVoPPYksOuv15Zb fkVdl/3l/b19LKYcbWJsbV+17YiDJSPDm7nHtm03u14f3iWjpDS36HlkWNSRE8fE21ZdXftt7bI 8BgA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

There have been no sprintf() callers in the boot wrapper since commit
e275e023aa69 ("powerpc/44x: Warp patches for the new NDFC driver").

Remove the function definition and declaration.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/boot/stdio.c | 11 -----------
 arch/powerpc/boot/stdio.h |  3 ---
 2 files changed, 14 deletions(-)

diff --git a/arch/powerpc/boot/stdio.c b/arch/powerpc/boot/stdio.c
index 31eece29f56d..b12aa2c0b8e7 100644
--- a/arch/powerpc/boot/stdio.c
+++ b/arch/powerpc/boot/stdio.c
@@ -326,17 +326,6 @@ int vsprintf(char *buf, const char *fmt, va_list args)
 	return str-buf;
 }
 
-int sprintf(char * buf, const char *fmt, ...)
-{
-	va_list args;
-	int i;
-
-	va_start(args, fmt);
-	i=vsprintf(buf,fmt,args);
-	va_end(args);
-	return i;
-}
-
 static char sprint_buf[1024];
 
 int
diff --git a/arch/powerpc/boot/stdio.h b/arch/powerpc/boot/stdio.h
index 884d5959a9ae..d5a7a0f54453 100644
--- a/arch/powerpc/boot/stdio.h
+++ b/arch/powerpc/boot/stdio.h
@@ -12,9 +12,6 @@ extern int printf(const char *fmt, ...) __attribute__((format(printf, 1, 2)));
 
 #define fprintf(fmt, args...)	printf(args)
 
-extern int sprintf(char *buf, const char *fmt, ...)
-	__attribute__((format(printf, 2, 3)));
-
 extern int vsprintf(char *buf, const char *fmt, va_list args);
 
 #endif				/* _PPC_BOOT_STDIO_H_ */

