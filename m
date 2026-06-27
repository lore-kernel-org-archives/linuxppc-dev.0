Return-Path: <linuxppc-dev+bounces-23041-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD87FC43327
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Jun 2026 10:48:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gnTm85L7hz2yS4;
	Sat, 27 Jun 2026 20:48:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782557304;
	cv=none; b=FYgiDIupy3nCkQ5PyODvnDFrdm7Mn88jN/Ln85F4jBzVjSVW0IoxssNl3oTYsI12pcgUH7E0Roysqc/oHGXVSGm34VIFVdiwobRunSL2mYqsQJaLTKv/fcuAWYHd1rkzbUJ1lJ4vX3Ne3ESUwPP980TFE74pvaxYqZ1viJS14e3Jo0lPOmKrdbrOKSivexNJbwA6u8PIpJ86FAVIYx2Kh8Gj55cCBx34bOPwI3UByKesIZv/D3PVyTUuOoa/gbx868VlLay46ibfT4ghJdyu4tD2loMYXt1BUiB4KXIch1ZHEWSxEofZxJMwCYQW6Orve3kMSr3f2SpLrSvxp3LzxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782557304; c=relaxed/relaxed;
	bh=Q0bXOJE6tHd+pYP54YvtCZ62SW/PO7nF/2RtSUXtdbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QBs3p+fI5cxkjee7/B1N8/fUWIQD18RyPWkjbNCiKAhfte4zDSpLGVowPwumI4c3TsgTLtM6ce6XzD2g65uqfySgsMHv0ad1hgSZSNY8QyuC1VKwTjxh+1SaohgvmHqT/OfBSxyF6OSlVhMomIexIfbVasMdPxnhO328UPcvUaMtlZi0UhrTSpchq6um7h7aK5oClQ5RGDrzZzGrk6VPi+B7CIvKnDQwfmJwPVsGR6Q4N2adumPGcKO4yiEfd1L1UqRSJNT+kGvOUKv+i+Ps0yLasvawOhGbZfpWUGtTQi4CM3KooIsdXuLlIrPUHEz5nFCrY6NzF9xomfLNO5cOiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NbUsJCOS; dkim-atps=neutral; spf=pass (client-ip=91.218.175.172; helo=out-172.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NbUsJCOS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.172; helo=out-172.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gnTm46qtkz2y71
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jun 2026 20:48:20 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782557280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q0bXOJE6tHd+pYP54YvtCZ62SW/PO7nF/2RtSUXtdbs=;
	b=NbUsJCOSsl1Jk+ovYIzpsmnNxWblZ8TSUR/uaew+DboEHMZeBqZN0s49UTPUWW6h+EUFmA
	bXo1OceTlVnhFvjWVQH/HXSRdmLYeiqN56CfEaIbsQCpVQx5piunhteRkItMFLYsZ0sP5T
	O45xuOtUlSC32NdtTSe59tzZ/wlax7Y=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] powerpc/pseries/ras: Use struct_size() to simplify fwnmi_get_errinfo()
Date: Sat, 27 Jun 2026 12:47:31 +0200
Message-ID: <20260627104730.276858-4-thorsten.blum@linux.dev>
In-Reply-To: <20260627104730.276858-3-thorsten.blum@linux.dev>
References: <20260627104730.276858-3-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2201; i=thorsten.blum@linux.dev; h=from:subject; bh=5f9DRxCgxvpKHvnJSiV97tR0B71w7wB17eQP9/xYHCA=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFn2q3w19hQyGdydaWfbInupj5NvcW+8ls430TT/V9YaT yJOdit0lLIwiHExyIopsjyY9WOGb2lN5SaTiJ0wc1iZQIYwcHEKwERecDP8T5Gruv1GdJJS2l3/ uOdRETkq37dYdm1N6T8kMEsi5L15FsP/pGsFG878ebV8b7IV/9GJyjaOUx+f90ho+LO1/s3qUDV XLgA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Now that struct rtas_error_log uses a flexible array member for the
extended log buffer, use struct_size() to calculate the total RTAS error
log size and avoid using the hard-coded header size of 8 bytes.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- memcpy_and_pad() cannot be used in real mode; use memset() + memcpy()
- v1: https://lore.kernel.org/r/20260626184750.166642-4-thorsten.blum@linux.dev/
---
 arch/powerpc/platforms/pseries/ras.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index adafd593d9d3..7b8713bdd978 100644
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
@@ -449,17 +452,12 @@ static struct rtas_error_log *fwnmi_get_errinfo(struct pt_regs *regs)
 	regs->gpr[3] = be64_to_cpu(savep[0]); /* restore original r3 */
 
 	h = (struct rtas_error_log *)&savep[1];
+	extended_log_length = rtas_error_extended(h) ? rtas_error_extended_log_length(h) : 0;
+	len = struct_size(h, buffer, extended_log_length);
+	len = min(len, RTAS_ERROR_LOG_MAX);
 	/* Use the per cpu buffer from paca to store rtas error log */
 	memset(local_paca->mce_data_buf, 0, RTAS_ERROR_LOG_MAX);
-	if (!rtas_error_extended(h)) {
-		memcpy(local_paca->mce_data_buf, h, sizeof(__u64));
-	} else {
-		int len, error_log_length;
-
-		error_log_length = 8 + rtas_error_extended_log_length(h);
-		len = min_t(int, error_log_length, RTAS_ERROR_LOG_MAX);
-		memcpy(local_paca->mce_data_buf, h, len);
-	}
+	memcpy(local_paca->mce_data_buf, h, len);
 
 	return (struct rtas_error_log *)local_paca->mce_data_buf;
 }

