Return-Path: <linuxppc-dev+bounces-21666-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF57CD4F54
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2026 20:13:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRHjz4Sp6z2yD6;
	Fri, 29 May 2026 06:13:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::b1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779999207;
	cv=none; b=SPDVE3xLJWhUKSYK8Tv90Hm5SrFq442cSGgBWD4NZNk3aLpTsLBxig8h/8/ylfXmv0Rzt5zzbmHywTPfVHt22CBou+z2vBAND3QnE46SZzzvEoPlR5ZgdyAWYAk//yUIhhHMTvWPt+nupD2u/5jBk/qgBg1VRifAkDC7E2OIqSVXm/04nTQmIRwufRrTVkR7gmN6FgsRUMIzOXvA9p380WyLXox3f/m+Unm/8XLwEk8lnAyDAz50+GYLVxpjsXccOcJBal2QJWZ0+dVgH+ucu1fTYeylvUUXtZVMbcAxgcVxwK3+JIFUCYp9iBLPBRzcgtzLvQ0j3Y2QSZmK7fur8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779999207; c=relaxed/relaxed;
	bh=+6daMKvHNSz59JQjO/O9wJOU1wC6Fg64/a4W67M4u5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D3wdb5+NHjh/pAhcQf4RQ5DYi9l9rj2099ORRm2x6ckA5Auq6egNWaGDJeyHymzl1aUnP20wQHAjb2ZieA4aH4RReo9FYaGyuLmI00edgyx1r+3w2f/KDSRBdGvHArqhc0R/v+ACvIM6bKVlqWPn3ct9M25sTtVIqe+hYlGaQPA0XkL5VpUq2/d7oVF6OiepNhc+jAucac9h2Rzr0q8C+76jHaDw2RukTiaabqT+DV+uL4hsKsdc9zxj6R9sJlM1ESFtcvIaaNPN7QSJ0LAo45qwTQLMaPEEP081OKBt+y+EzJrK4/7pM3r13yKP01RPoG5LnbASl8RoNRbGN4stzg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=H0SYJgJ8; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::b1; helo=out-177.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=H0SYJgJ8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::b1; helo=out-177.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRHjw3SnSz2xl5
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 06:13:22 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779999182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+6daMKvHNSz59JQjO/O9wJOU1wC6Fg64/a4W67M4u5w=;
	b=H0SYJgJ80WeMgeiLvSEnrDJBVKXYEmvimQDGfdr1u7NDg3iJKwdDAAmbDizbKm+bAHAdH2
	pjnj1Vqz21cfPCRi7p5q361ox98x1vAr0ZaCDlkKuM0+kip1WY9p935wJyARlmPzHw2Lff
	Gg0ChWuAgrVcaawycTvKbDEjMaqigcM=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Srikar Dronamraju <srikar@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: rtas: use get_user to simplify manage_flash_write
Date: Thu, 28 May 2026 22:12:27 +0200
Message-ID: <20260528201226.1599977-3-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2184; i=thorsten.blum@linux.dev; h=from:subject; bh=8O9URT5B5VeVobAXWIkIqYJmai22F4B/MFQ7ldsFD+k=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkSC1eV3Uyd7Huj+H3uypjeSM7EnW3XEi+uc9Lo0BD5+ n2ftVhIRykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAEzEnZ+R4cr+zPiPCV1/Hm4U Fo9ftfUx/6Xjm74WXZRed//NesWH2gcZ/tcePH6M/UW71t7ohTxTrlnuPcDafyPy9EV+pZc1ioo a7xgA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Drop the local 10-byte buffer. The old code copied at most 9 bytes from
the user buffer, but only the first byte was used to select the RTAS
operation.

Use get_user() to read the command byte instead and compare it directly
with '0' and '1'. Drop the explicit user buffer check, since get_user()
will fail on a NULL pointer and correctly return -EFAULT instead of
-EINVAL. Remove the now-obsolete string constants as well as any
strncmp() and strlen() calls.

Return the original count instead of a potentially capped value, since
the full user write has been consumed once the command is accepted.

Use unsigned int op to better match the manage_flash() interface.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/kernel/rtas_flash.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/kernel/rtas_flash.c b/arch/powerpc/kernel/rtas_flash.c
index 583dc16e9d3c..722dbfb6fbf8 100644
--- a/arch/powerpc/kernel/rtas_flash.c
+++ b/arch/powerpc/kernel/rtas_flash.c
@@ -394,30 +394,23 @@ static ssize_t manage_flash_write(struct file *file, const char __user *buf,
 				size_t count, loff_t *off)
 {
 	struct rtas_manage_flash_t *const args_buf = &rtas_manage_flash_data;
-	static const char reject_str[] = "0";
-	static const char commit_str[] = "1";
-	char stkbuf[10];
-	int op;
+	unsigned int op;
+	char cmd;
 
 	guard(mutex)(&rtas_manage_flash_mutex);
 
 	if ((args_buf->status == MANAGE_AUTH) || (count == 0))
 		return count;
 		
-	op = -1;
-	if (buf) {
-		if (count > 9) count = 9;
-		if (copy_from_user (stkbuf, buf, count))
-			return -EFAULT;
-		if (strncmp(stkbuf, reject_str, strlen(reject_str)) == 0) 
-			op = RTAS_REJECT_TMP_IMG;
-		else if (strncmp(stkbuf, commit_str, strlen(commit_str)) == 0) 
-			op = RTAS_COMMIT_TMP_IMG;
-	}
-	
-	if (op == -1) {   /* buf is empty, or contains invalid string */
+	if (get_user(cmd, buf))
+		return -EFAULT;
+
+	if (cmd == '0')
+		op = RTAS_REJECT_TMP_IMG;
+	else if (cmd == '1')
+		op = RTAS_COMMIT_TMP_IMG;
+	else
 		return -EINVAL;
-	}
 
 	manage_flash(args_buf, op);
 	return count;

