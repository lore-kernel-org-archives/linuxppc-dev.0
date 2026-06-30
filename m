Return-Path: <linuxppc-dev+bounces-23222-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF86C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 15:47:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqSG846c3z2yfS;
	Wed, 01 Jul 2026 01:47:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.173
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782834464;
	cv=none; b=H3JEjIW2Nfmz/1yhPD1JraGOu2ufdZCe6QrQSDo3ZlC4tfDrcBBZqNCq+HO8z+EqFP9DNBXLoeLpFTdtR2WLogy6tS9jlRgv3TIqFLQA/oqWnGMZSBLy77Qd5eI3RauCCQHLN0o366pn1RrRx5Dp1TdTOC+cDXZVDEc2AFMiMfvRROWRrpMJZau4Ue6RxVFY5NmxYXP7vzkVL0vF8yJYi7cFF9hLMQGloKiRUfWfd+uGbLWh961cedNBC5miN7XTceijjWcLHik+2/sd36qLY5oajQm+Fmn61vfkqBCHWOtYIeyniOKUURzgQKZkQwGRG1PCvWWVT0GQ6DK4pyV7Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782834464; c=relaxed/relaxed;
	bh=g0pf9ki1Ai0Xt9Gsq1JCPfcLfK6MHG0DE4RAET8G76Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mrl57x+PriEv6thzndrgvCcMKpPFbckBjTD0GKGcxaTheHNJbVRTQsEepLixAwNSG1EAt1HzTwJZNF0PvwW6U/gnVKpryov58ID57s+4/t18vJUTgRqdCCApBWFWEjfsOVBSqid8lIW0g/9GXXvU3Pu07+dUtRJ3d5EFEZhYEoY0iCTASSCGo9v7QCOIIGKP1I+wiMKGUMgbhF2E28oyVeTDdnW0XcEFVmdA7i2dXoj95JTnbDFDFRrAwj2/KMi9mc1h1fpX+DBqIm8VhZcn3tZouJ+u9O79Vupz80eyPKZpZFuWhjhMbPbHgH1H1WxZsltwj58RWGfKemvAD1804w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AF0bM6Gn; dkim-atps=neutral; spf=pass (client-ip=91.218.175.173; helo=out-173.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AF0bM6Gn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.173; helo=out-173.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqSG54HYWz2yb9
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 01:47:40 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782834439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g0pf9ki1Ai0Xt9Gsq1JCPfcLfK6MHG0DE4RAET8G76Y=;
	b=AF0bM6GnVxIx4mkct6+9qn8H9JLXIiiPvkWChBIzRSXrpTasjDGtbyt8pYXrtPEe2LhIJ/
	uCHZEc63/tqn+xmBYsX+nKKg4e0UAvUMU1GXYkLSsoTa9UuwpWKWRAIRXYAbJ6NpFb3+ep
	vjOEFRPrPT5jgvIYZ2USk06P350xXGQ=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/dt_cpu_ftrs: Avoid separate strlen() in scan_callback()
Date: Tue, 30 Jun 2026 17:46:56 +0200
Message-ID: <20260630154657.693088-2-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1554; i=thorsten.blum@linux.dev; h=from:subject; bh=jcM14XAg/Rn+w1ag3XGyVlqQz4Yn6TB6lSLVOHW5hJQ=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnOTz4etmtf8Tt0d+YqhUOX2qY/mS761vib++ksxegMW TGT9BNrO0pZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAibLsZGY567HZcfyLE6Nb9 6vwXhnk1pdaevz8dnai1NOS/1k0H60RGhq6TJX/01suay8+7mvJtss35itTjk6w1/mnMvh9ZZuR ykA0A
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use the return value of strscpy() when copying the display name instead
of checking the source string length with strlen() first.

Keep dt_cpu_name static but move it into dt_cpu_ftrs_scan_callback(),
where it is assigned.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/kernel/dt_cpu_ftrs.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
index 3af6c06af02f..8d8e94e4d2bc 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -90,8 +90,6 @@ static void __restore_cpu_cpufeatures(void)
 		init_pmu_registers();
 }
 
-static char dt_cpu_name[64];
-
 static struct cpu_spec __initdata base_cpu_spec = {
 	.cpu_name		= NULL,
 	.cpu_features		= CPU_FTRS_DT_CPU_BASE,
@@ -1069,6 +1067,7 @@ static int __init count_cpufeatures_subnodes(unsigned long node,
 static int __init dt_cpu_ftrs_scan_callback(unsigned long node, const char
 					    *uname, int depth, void *data)
 {
+	static char dt_cpu_name[64];
 	const __be32 *prop;
 	int count, i;
 	u32 isa;
@@ -1106,10 +1105,8 @@ static int __init dt_cpu_ftrs_scan_callback(unsigned long node, const char
 	}
 
 	prop = of_get_flat_dt_prop(node, "display-name", NULL);
-	if (prop && strlen((char *)prop) != 0) {
-		strscpy(dt_cpu_name, (char *)prop, sizeof(dt_cpu_name));
+	if (prop && strscpy(dt_cpu_name, (char *)prop) != 0)
 		cur_cpu_spec->cpu_name = dt_cpu_name;
-	}
 
 	cpufeatures_setup_finished();
 

