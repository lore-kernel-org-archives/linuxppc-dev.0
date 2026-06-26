Return-Path: <linuxppc-dev+bounces-23034-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0AC6C43638
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2026 18:49:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gn4TX34W6z2yfN;
	Sat, 27 Jun 2026 04:49:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::aa"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782499760;
	cv=none; b=fNPpzYhDy2uz3toPx1TxSYuEq+P5T58F4TcqAGpSsVtyl1sNMr6lL99rE9rfRR8j5PTNM8kBLfcu7vjWyasG2rNdYV5yQylrH7YPRDM5iNBG9Dd+foaN5ie9JEwmnt9HyGAPDOYgeOXWeSrt+XVs2xw3fHA+Aw2XHgE380LsCuSNaDvYdCMHfns8zJ7u/twGskJ/Myxht+q4bkQEAdMJbuUZffzeIPK3oJWH2OTg+VPdOA3lGHjTaZgE3cIqFw8hA0CIsbyJ7bsYPMKvWKWGSguK1O5UBQr+1mE/FbEJPT5R6kjlsOHxOK2ApqPmZvYZ9DQ1zEOhGm6gwhk4d++Taw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782499760; c=relaxed/relaxed;
	bh=BXR2tZurJ1eKqJHB84SXKvdWd2G7Lw74Pt5/iYEF5lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lsgzQwoWHprDlGa8LKNJHmwlC6YOwMi5xnnhdkTWDJUmkpMzfKBi0Wt2PEFL26AQTV5DrWRotoRTz+EOTk4GhTTLqc3xoMBZjfW4f4maGSNRSDIg4sXkw2/SJtvqxiuZWnvYsTCCaC7hd2hkDUAHxCtvR6byfXyfRem/23zESnzeS81tlSFZHF75H3jcWnGvLKzcGlduW4fgbgj2JZMDTlO8IfBkBtRjMTw+zqTtB7M+SuUWc8LdxDCjAjPyIxdu2qf6pPBhj911GtXkBeWjXtE+viryDGPqW8uym3rzN6fy2WBCde7LCc54Go9zHf5/8rXJSQ97gjYt+12XHX2ZNw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pKQrfZPi; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::aa; helo=out-170.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pKQrfZPi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::aa; helo=out-170.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [IPv6:2001:41d0:1004:224b::aa])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gn4TW3q45z2yd7
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jun 2026 04:49:18 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782499735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BXR2tZurJ1eKqJHB84SXKvdWd2G7Lw74Pt5/iYEF5lI=;
	b=pKQrfZPi/g5/Vb3Iry3kNNhrHXh2hJh9KJN149Dkx4ORUxOBvnUQM9rqYb5MrzbMUmcC2n
	faeVqPRvreW5bmReiHTGCKvJ1JqLHtwM9rLTpqh04+VV3rt/pU3x7L+KKKaF6QA26B+ImP
	5zJZgklWIGB+qufbboycDjHYk/wvyeU=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] powerpc/pseries/ras: Use struct_size() to simplify fwnmi_get_errinfo()
Date: Fri, 26 Jun 2026 20:47:50 +0200
Message-ID: <20260626184750.166642-4-thorsten.blum@linux.dev>
In-Reply-To: <20260626184750.166642-3-thorsten.blum@linux.dev>
References: <20260626184750.166642-3-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2128; i=thorsten.blum@linux.dev; h=from:subject; bh=YXjaVhhauUwhC8W0e+m1P/XaX9aBADxcZZNQnVrjEwE=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFl2JxOufz4qE5PO9UlBOTKjkjP4w+kqHpPI4JWsZ9kuJ P/zWraro5SFQYyLQVZMkeXBrB8zfEtrKjeZROyEmcPKBDKEgYtTACaS1s7wT63z9qkr/R4dQa0P 1Zj5FtYdFbnzlnsPn2tDfEbcZCumXwz/9A1+7cox3bKMLTbL0Cl2g1LFZhfOVImNKyqPcfeKb1n CAgA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Now that struct rtas_error_log uses a flexible array member for the
extended log buffer, use struct_size() to calculate the total RTAS error
log size and avoid using the hard-coded header size of 8 bytes.

Use memcpy_and_pad() instead of memset() and memcpy() while at it.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/platforms/pseries/ras.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index adafd593d9d3..d54030fd2324 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -7,6 +7,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/of.h>
+#include <linux/overflow.h>
 #include <linux/fs.h>
 #include <linux/reboot.h>
 #include <linux/irq_work.h>
@@ -440,6 +441,8 @@ static __be64 *fwnmi_get_savep(struct pt_regs *regs)
 static struct rtas_error_log *fwnmi_get_errinfo(struct pt_regs *regs)
 {
 	struct rtas_error_log *h;
+	u32 extended_log_length;
+	size_t len;
 	__be64 *savep;
 
 	savep = fwnmi_get_savep(regs);
@@ -449,17 +452,11 @@ static struct rtas_error_log *fwnmi_get_errinfo(struct pt_regs *regs)
 	regs->gpr[3] = be64_to_cpu(savep[0]); /* restore original r3 */
 
 	h = (struct rtas_error_log *)&savep[1];
+	extended_log_length = rtas_error_extended(h) ? rtas_error_extended_log_length(h) : 0;
+	len = struct_size(h, buffer, extended_log_length);
+	len = min(len, RTAS_ERROR_LOG_MAX);
 	/* Use the per cpu buffer from paca to store rtas error log */
-	memset(local_paca->mce_data_buf, 0, RTAS_ERROR_LOG_MAX);
-	if (!rtas_error_extended(h)) {
-		memcpy(local_paca->mce_data_buf, h, sizeof(__u64));
-	} else {
-		int len, error_log_length;
-
-		error_log_length = 8 + rtas_error_extended_log_length(h);
-		len = min_t(int, error_log_length, RTAS_ERROR_LOG_MAX);
-		memcpy(local_paca->mce_data_buf, h, len);
-	}
+	memcpy_and_pad(local_paca->mce_data_buf, RTAS_ERROR_LOG_MAX, h, len, 0);
 
 	return (struct rtas_error_log *)local_paca->mce_data_buf;
 }

