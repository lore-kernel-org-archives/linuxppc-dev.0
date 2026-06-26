Return-Path: <linuxppc-dev+bounces-23033-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE7BEC43458
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2026 18:49:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gn4TV66Tzz2yYd;
	Sat, 27 Jun 2026 04:49:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.188
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782499758;
	cv=none; b=RU6JbKRzog4SzDS6Z2WeZA9h1hinRfOiNYR8g9vvzlGkPM+mYOimSjKvrYt/Qplh7uN1AcOKJwRcX0XvUoUydZZUnyTlBNuuPviwQhWW2hfnv+A6nmvKoaCw9ofl6igKnBNeeX4UvopAlx5cvk76RHtsh/odFKKNaZQhcf3nJF9T3PM2AOzEHqRRYG4BBaKxeD24ch/njBDh8hE6Mb9b3SnsfIjSbuHcto9cX1j+FYQvoZj6SGJAYbUXrChd4Fz1h17Jeo+6prgWF87dttdFb7hfcLAnFRBB+VFL50pN6OLMdyefSFa9Ir5UMSbf7fdjECq0m2CN9k+00hxksx41SA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782499758; c=relaxed/relaxed;
	bh=ZsWyLvWJwqeNbF489UKOxlVtznFI97BRXUa6zN1YiSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=THz92mMMx/Zyf2OCbdxo3uXyo6z4KfKPBq6TPJVLn2g6mvES1KKTh7axPgcdBzTXW2X6PL0HzK18aLHwU+w920hrqPbhMILuZbTOuTL8GpzT4PeRz0PXN/hncc1/SloNYEk4NGiNNtjhUv9eilSUIrrR0s2DH8BP9AbYfewY4/gc5udiMtvuXOsnx6ejPW2P0kegBqSZo2ImSTGdnrOu8PM83RoD1zoLDFLncqF+CPkn84Y/w6adGYJn8KYmXzCi+6kwqVyGPnCDNmX/E7VdKUVkVq92yZdkeOtlHUZbVZqfxtMUR+aflVYcPdUWBf0I1GIiyEVd+9bWF8k99DF8kQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=W0rrzsj+; dkim-atps=neutral; spf=pass (client-ip=91.218.175.188; helo=out-188.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=W0rrzsj+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.188; helo=out-188.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gn4TQ5p6cz2xn3
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jun 2026 04:49:13 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782499732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZsWyLvWJwqeNbF489UKOxlVtznFI97BRXUa6zN1YiSg=;
	b=W0rrzsj+q2Dk7PprwXObbdibAFQ+vyyp7gqqN+qhrQlMgG3o6gYgAgO/YvtygLhlT2CjDh
	qCJcQ8eOUdHBmPCY7Nk4ENY+jmNLZAK+CzfZKi+YHPESRwDpCzdsGg23sVYVmIsQpkC6QV
	T9iZ4QLuR3B4quo24XbkZOWgOV+s3gc=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Tyrel Datwyler <tyreld@linux.ibm.com>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Haren Myneni <haren@linux.ibm.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] powerpc/rtasd: Use struct_size() to simplify log_rtas_len()
Date: Fri, 26 Jun 2026 20:47:49 +0200
Message-ID: <20260626184750.166642-3-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1702; i=thorsten.blum@linux.dev; h=from:subject; bh=UUyEyLi2JOzXDLgwwRzK+qlFfg6Gn9vLkYBO0kIDLCs=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFl2J8M6s7af01Va621fOCGZ20nizl5+uyupzw+35mreZ Hxb8udkRykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAExEzZ6RoSfnteAbawNGecUr j35KhBgc+3TSeccanrm6vD/XOnT+f8jwT/epuvglzwqT0EncHFoVUVGTtc6ztFl6XU1bsFVNYJ4 0DwA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Now that struct rtas_error_log uses a flexible array member for the
extended log buffer, use struct_size() to calculate the total RTAS error
log size and avoid using the hard-coded header size of 8 bytes.

Use min() to replace the open-coded implementation while at it.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/kernel/rtasd.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
index 6336ec9aedd0..fd40864bdb70 100644
--- a/arch/powerpc/kernel/rtasd.c
+++ b/arch/powerpc/kernel/rtasd.c
@@ -10,6 +10,7 @@
 #include <linux/sched.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
+#include <linux/overflow.h>
 #include <linux/poll.h>
 #include <linux/proc_fs.h>
 #include <linux/init.h>
@@ -160,25 +161,17 @@ static void printk_log_rtas(char *buf, int len)
 
 static int log_rtas_len(char * buf)
 {
-	int len;
+	size_t len;
 	struct rtas_error_log *err;
-	uint32_t extended_log_length;
+	u32 extended_log_length;
 
-	/* rtas fixed header */
-	len = 8;
 	err = (struct rtas_error_log *)buf;
-	extended_log_length = rtas_error_extended_log_length(err);
-	if (rtas_error_extended(err) && extended_log_length) {
-
-		/* extended header */
-		len += extended_log_length;
-	}
+	extended_log_length = rtas_error_extended(err) ? rtas_error_extended_log_length(err) : 0;
+	len = struct_size(err, buffer, extended_log_length);
 
 	if (rtas_error_log_max == 0)
 		rtas_error_log_max = rtas_get_error_log_max();
-
-	if (len > rtas_error_log_max)
-		len = rtas_error_log_max;
+	len = min(len, rtas_error_log_max);
 
 	return len;
 }

