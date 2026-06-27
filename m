Return-Path: <linuxppc-dev+bounces-23040-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2BBC43458
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Jun 2026 10:48:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gnTm858MVz2yRF;
	Sat, 27 Jun 2026 20:48:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.177
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782557304;
	cv=none; b=LHDS1rmUng2BRoDzvX7aTx63HgaYKesdAKdGbNCSLJXQ3umuNRZCOMXif0MB/3bG2/7oz4hqIuxMD/NTVt5nJS/lzXwGTnpNVkQfnFzbT7wExjVHRk8LcjeQOxM97MPAnuaIkwoMAbeRoRf/+KJ0X4VeIijrEbHHTt0HBYBL9j9bMKX0OxIrPo6dSFJz9P0L3kZDTjKMErWx3oe4UP/fFPV+asUk7AYIRAZ8JgyXYxoNYc++yXM7+Wim3e8gXq0Hvag8w5Qo42XuoO/+0RMdlxF+gLRPXGFi+rjaK019i4Re2Icp8ofHGBIdGxWwf9pUwtGmTaZcC2cjBPLLHvaOMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782557304; c=relaxed/relaxed;
	bh=StgTirl0Rj2vUuy7CWisepMx5gnF7T18k74H+s3zDpk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hOLzjHsK/IosjA8H+gxIcjeBaVdFMshrH0Oeaw1elNAaSh6m11O705/5KjaNli76Znw3asL74YL7VU47fshYFlaAYJeSt+m/1iD+s+ZNo9tuDL9pYFThllhWEM+hTcWUmcxreleDMYC/P/59cOVuTCVbik/IFE0pvc3IXqWf3UAw/PMy7gIXp9WVaTEX6vCEP/C5hZ4ytSsXuSOLn184r1TyMjmJu1Ti6krfx7JslPv01crD7PJgnXTWjOfYhjuzRH3dDb1OFnVGnbSyxOINVguYvTYmzHgz3wMj88B1tB8FhfR78aTB1DwAVGzseIOUUJvJghl6YU59hirUw0rsQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=eR1QJXCe; dkim-atps=neutral; spf=pass (client-ip=91.218.175.177; helo=out-177.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=eR1QJXCe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.177; helo=out-177.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gnTm43R4Lz2xWP
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jun 2026 20:48:18 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782557278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=StgTirl0Rj2vUuy7CWisepMx5gnF7T18k74H+s3zDpk=;
	b=eR1QJXCeix1tKw+jx/B9CSmOd18dg3HwKbXpu/cjaJTjjYA5RUunenz1j+04OWeEMdnwUL
	tBRQISBj3EpcLnvo6i3YsIEPzUDB9yzzCzvO9WeX3O4NRgpgcFyvVoLbvLS0LTVA/KYlPz
	nFegjp/95zcI9t3WoHdGlcoLbCMWxrA=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Haren Myneni <haren@linux.ibm.com>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] powerpc/rtasd: Use struct_size() to simplify log_rtas_len()
Date: Sat, 27 Jun 2026 12:47:30 +0200
Message-ID: <20260627104730.276858-3-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1790; i=thorsten.blum@linux.dev; h=from:subject; bh=g/XAC4YTm7L/6ggWuIzma/uPc4NzRH3yNHBr+EYnD5c=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFn2q5x8lO7eLokzdfVeuN33tXhaQNwsc/6lSnJLNs91b GBye83dUcrCIMbFICumyPJg1o8ZvqU1lZtMInbCzGFlAhnCwMUpABOZGsrwPzRxkUVJDv/Li/UL G4447LnozmDaftHd+saezfqvYk7HrWb4Zzj94fRr1R/y7arvrpzVMdNy6ieGu2ebHNyP/kst2NW 5hQ8A
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Now that struct rtas_error_log uses a flexible array member for the
extended log buffer, use struct_size() to calculate the total RTAS error
log size and avoid using the hard-coded header size of 8 bytes.

Use min() to replace the open-coded implementation while at it.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
No changes in patch 1/2.
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

base-commit: ab8bbf8024b7434e2b630965fd373fba5b89f29f

