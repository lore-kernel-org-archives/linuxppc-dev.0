Return-Path: <linuxppc-dev+bounces-21549-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9A9CD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 00:02:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQ8v11rD9z2xLs;
	Wed, 27 May 2026 10:02:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.171
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779840141;
	cv=none; b=HdWJmtD7l9pQfWFlZwEPJEviqVIYKnoNHzUNghkeDW26Vu8On8yO/zSZ+qoms4kue4wBpwG+vTwebltqMo9iPY8x0viXfzi3ORlWsWpQPjekkmfHDm9kwhvpU5ZZVnn6grbfYojP1ni/Op6rLIKPBIUPx55d45ECAAnHHIN4WpR7SYSXdA6QOKSvL5woGsdxoqZJF0S57aPACf3AtSHlPxqq99upLgcQ5aZoAZl4Atv/d4BeZACPg1IW3pDqf8rbcps4O7Ydzb/g/kfVvoQfCYhr9XRqoXqnFQCYSf8NJ4dd+JWd5pOkwkVyx7ORjnHCnmsQGVTQzoyWMmIM0N+C9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779840141; c=relaxed/relaxed;
	bh=/mUNYVbQO7WzMBWFoPK4p8GJoNAcMMtkwfQmm2mOiPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oARBtAI4YIqUa/lS5FA9JeNCt10KMQgFI+Bz+XNdT5h/MT501XFyI2+Eq5uhlhP3FcDnQI4pIHgPZoX2pIRtjU+ToCl48Cwu91Q9b4kJZsaHKJMJrFOqN4blGx1zEytLi7Hwp7AZCrpp26HqC6uEbRcqEzSidKOM+3WhE3MiOPVJapguan9EE2IebIoj5PclyFMZFa+B2TmGF/hIneiLvwwvn+roeKwS//S87T86AinpwQPzMA8IN7bOilqQl/bqRR0qDMw/E8k94c26IYrxtw3tkQRzMrNsHxCekrR5e20amPFWl4Hf0XIjQicu2blfxWP9tCwUuUo+I0CZNrUHAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=aiDVxuzl; dkim-atps=neutral; spf=pass (client-ip=91.218.175.171; helo=out-171.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=aiDVxuzl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.171; helo=out-171.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQ8tx50n7z2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 10:02:16 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779840115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/mUNYVbQO7WzMBWFoPK4p8GJoNAcMMtkwfQmm2mOiPc=;
	b=aiDVxuzl6xKnDyhylyilTBRa4eKJJuAAspqZ1pYorXNyi3Is14v7Nc1tfCbSQMT+44oOVT
	E21FZmqM92RYCQriQAlXtxgLflm433Nh3tOiyBIUinAwnUqHV48efb9wrNOPUD7yne0Wwf
	7NKdMrqxKZnGSNodudsmCPyV9Mgi3eo=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/kexec_file: use snprintf to simplify setup_kdump_cmdline
Date: Wed, 27 May 2026 02:01:06 +0200
Message-ID: <20260527000105.1081651-3-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1702; i=thorsten.blum@linux.dev; h=from:subject; bh=nd5yPR8MeFvqegyDZWdCPUoqwQ5AW3bnIbMhUoTcHU4=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFliJo5vHnEJ3FidsGN3RNvaLLWtXdHdvm/fpszq6Yp8x Z2r8NOmo5SFQYyLQVZMkeXBrB8zfEtrKjeZROyEmcPKBDKEgYtTACZyt4Xhf8ivSyx72sMX3Ig9 6/jsQ63QrDz1vwmTKk02VySGv/xoGMjwi+m1+Q6m36v8uSem1Z04/euj60L/A8mtX9WXhpYYSZZ r8QMA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace the manual string length accounting, memcpy(), and NUL
termination with a single snprintf() call to prepend the elfcorehdr=
address and to detect string truncation at the same time.

Use kmalloc() to avoid unnecessarily zeroing the memory. While at it,
also use "prepending" instead of "appending" in the error message.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/kexec/file_load.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kexec/file_load.c b/arch/powerpc/kexec/file_load.c
index 4284f76cbef5..597998235136 100644
--- a/arch/powerpc/kexec/file_load.c
+++ b/arch/powerpc/kexec/file_load.c
@@ -36,25 +36,19 @@
 char *setup_kdump_cmdline(struct kimage *image, char *cmdline,
 			  unsigned long cmdline_len)
 {
-	int elfcorehdr_strlen;
 	char *cmdline_ptr;
 
-	cmdline_ptr = kzalloc(COMMAND_LINE_SIZE, GFP_KERNEL);
+	cmdline_ptr = kmalloc(COMMAND_LINE_SIZE, GFP_KERNEL);
 	if (!cmdline_ptr)
 		return NULL;
 
-	elfcorehdr_strlen = sprintf(cmdline_ptr, "elfcorehdr=0x%lx ",
-				    image->elf_load_addr);
-
-	if (elfcorehdr_strlen + cmdline_len > COMMAND_LINE_SIZE) {
-		pr_err("Appending elfcorehdr=<addr> exceeds cmdline size\n");
+	if (snprintf(cmdline_ptr, COMMAND_LINE_SIZE, "elfcorehdr=0x%lx %s",
+		     image->elf_load_addr, cmdline_len ? cmdline : "") >= COMMAND_LINE_SIZE) {
+		pr_err("Prepending elfcorehdr=<addr> exceeds cmdline size\n");
 		kfree(cmdline_ptr);
 		return NULL;
 	}
 
-	memcpy(cmdline_ptr + elfcorehdr_strlen, cmdline, cmdline_len);
-	// Ensure it's nul terminated
-	cmdline_ptr[COMMAND_LINE_SIZE - 1] = '\0';
 	return cmdline_ptr;
 }
 

