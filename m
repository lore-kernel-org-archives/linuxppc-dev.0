Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97CB606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 17:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hg5MvL5N
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTXCq15Wsz2yfS;
	Wed, 18 Nov 2026 04:44:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::112a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794937447;
	cv=none; b=oO589yiSRiMR+e8kgQmAU4osZQ/U3/Ate4NWRJO5hd2JKLPNUH2MYFAUX5M1yZ+IQF35F2Z9Vy075EdRkAAhWKwrWfKvZho568ufxCI436Vb93sY/loMQpc3h54wVc8LPnpaa8VBzphm+X1CvJ6rXmolwK1XvsdGLjtbbuMkFU5hbhBOcfdctnnrIPwqCyZ7qJ0lX33CdBstkxn6j1h4NcVetzLc5aYF0VnW6SilFG9/uP7xKDr+9eVT07DCoW7udb2S18WNbymHZvsJVOadCW9IteQrQTnG2kQ+W6i8iGqG1eiIt2wtImrHLhifhUo2QWEU+O6Jo7Da9Y3dx0Ec6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794937447; c=relaxed/relaxed;
	bh=cAmMaaOh4mmljO0k7/aal9UucWgDGFN6FfL/f489KJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hQRE5TG8dYOqDo/bmL7SOlEZxLP4MwVIPukhWZDslt7AhTHLl25enGkg5R0zV0mv7BT2faXAlMWhlhDB44k9kNrWeJurATVNtb/q/5dZZBP9NlmiTGFiUcgfDyeab/2SqFqBDOxW5NxsolXuMi2FxyN3fxCxqQIOsMkWep2PRalwk+o3YP98bk9pY4gqMF++IjDKUcZ5hciaA+JIpwl3l08ItCIn3e8fzQXMoF1J5RYjqilcAsjQ3bbHgtYJJCMgu/D1Gvpf5Ntl6jlPpqYT+LM1RN1AsWpR8x6j9SeGbWky0CgmfK4sRHQQB2RveHLS5L/YtXM7bq8VFUQg7XRgHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hg5MvL5N; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::112a; helo=mail-yw1-x112a.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hg5MvL5N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::112a; helo=mail-yw1-x112a.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTXCp3Vpvz2yr7
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 04:44:06 +1100 (AEDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-8b4d86f5328so18173287b3.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 09:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794937444; x=1795542244; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cAmMaaOh4mmljO0k7/aal9UucWgDGFN6FfL/f489KJ0=;
        b=hg5MvL5NIUKjaL/3PwiDeg+mwpsxclwrBs+jSIOVj8deR5AIcskgKFZoLAeA29Gw1C
         yeWlQdZLSvmtNuBBpfqvnYPJh1n/O15llxrbeA4gUsSWw4TPUZcZyiKYLVnMt/BhsfNE
         Hl6ZTOR019wYL4xq13P+KQSUdt+IYdv7J5RSOMRX+wXMB0yqUr7gPSwuGd5XeBKkQEl1
         0q79jbQDrg4vOoKRuxfor3hKPMPcWQYd1P9Ek8tMd+SZIziK3V2mo1dWY+WzIGcuI4Po
         0QmWxY+SkG9lKIQfvlRm0yokxhaU5t1xCRWmy2YQ3CwZaJmPFkIZWQTz38LV0QEoTdP7
         KvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794937444; x=1795542244;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cAmMaaOh4mmljO0k7/aal9UucWgDGFN6FfL/f489KJ0=;
        b=LIGVJTg3uaToEoEX+jMnW7Q9JxarjT/M+G92QCkXZLsXAvrg6v1hAk2hZRiFCA1eBT
         L4XVvKdBnSR3AzH0vDDxPWsa8ZopvE6BzQ8LpVLsVdmvOHrhs4NPPQcMBAKO8YqoI/Q5
         7zZi2pDAEMoYPS1KPI+7NythFyzylL9d7jcash0YeGafT1jb2tQ1Qt6efsSC/btAIM6E
         OIjGXsRpU0TsMnNbZz0NDP4yeipTkgTUG21OCfGdjzfD2AaWQnjyLKN/OJHyuIQrf4eI
         vqbaDyt03811QqHYXR80yRsxmjryYEkx7fKBk49WfrVZCnMqahAjG91m3q4N3yRcMRq7
         65hw==
X-Gm-Message-State: APuU4Z8uDzfw8HmezZfzW172oXzFoqZvpFnr+KPO4/paBLkYC/R0pK1+
	S5LDlu79ID/9jX3jq0jW4onVIQaAxEKIU14WRo+IYK4oHVNEzLXtP7hs
X-Gm-Gg: AZFdTZd4rDIO98OPwB6p/0g9BfyWstnhMvFM4V6p61hfvoVUkNjngVQQk/ieZucc7Id
	42iHlHsNpuCCiggtgAPSKg98rCx2PXqF7DVPrJuO4jeMfNWV7FjC9PTZ3NWTuDgYjGmgwPpQHX8
	+vTiQM5GecZD8q8/7KynBK0f6SF14I+sryZPEIEzCrF85vG0nm5Tw/KVJcmExw4qOMnptp0aJHI
	efx4WAO8KXrkOalnPTKeUTeQaXa/VPfVy+rocPD07GOigd5osOmalzUP+V3DOIkIl4BvhqD6Spr
	XPQTh/JYGrXjqD5sQUVRZiJbJwAJKlo8/wFFVcqezEtVA9SIlxKbAwWBqIaMa51FUCW3EOXtpG9
	2ahXcj7kqbFNLCeflMzjq/a2jpjCBLJnwp9cI4htN+O44Ki71KkTHCMcY8RakIMoEqknrf2n+6q
	qziQ39OxmWX9/TcuZtW4IAJ6fS8rCc6hEWKJSj8PEYnC1b0iWoIAXlf4oYj2sV8gKQXeFQPQVp3
	eI/DLmCGk0kK2KY3hoXp8CJkCDRTzIRIYBYOQPJ4b0v9B5drrtM8wI2qlS5MMEvIT6XxUvZX+Fu
	3zyU1qDkSdecr6KqMn1L13S72aZ9LlW8R1kwCBdLeyiKgl+lPoULHleWHEQwerGbiznkDmZjGU1
	ispFjwDuGJDvuwzM+blCaOp1ZM2UOEyvSLCX8P75Q19pmr03m1Myi88dri+C6Bq0Wp06F+WhbKK
	TFjpYPRbvAOS03Y8MZNA==
X-Received: by 2002:a05:690c:931a:10b0:8b0:cc41:a124 with SMTP id 00721157ae682-8b4aa2c5d8bmr58717197b3.49.1794937444057;
        Tue, 17 Nov 2026 09:44:04 -0800 (PST)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net. [107.220.129.194])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4fdd9f2fasm2666937b3.0.2026.11.17.09.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 09:44:03 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 17 Nov 2026 12:43:56 -0500
Subject: [PATCH v2 5/8] powerpc/perf: mpc7450: Add the PMC6 L3 events to
 the alternatives table
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-ppc32-perf-v2-5-2072e9b90009@gmail.com>
References: <20261117-ppc32-perf-v2-0-2072e9b90009@gmail.com>
In-Reply-To: <20261117-ppc32-perf-v2-0-2072e9b90009@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Matt Turner <mattst88@gmail.com>, Tanushree Shah <tshah@linux.ibm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1942; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=4ehustDNUkGWLKyFDxeF6Q5SPo7UK1WNROW4Ki9ot+Y=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLL+TIqw+ylpkPTjxpsz8hfXOU80yYiel7xdxNf+19yqx
 rSNucXSHR9ZGMS4GGaKKbLErVdkmdW2Y6nPaelfMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 IZChYxQPkdNj0MgsLi5NLdJNKyhyyMsvSSzJzM8r1ssvSM0rSC/QS8tMK8nIyC8qTgUaoZeXWmL
 q6uhmZGhgYuloYeZk4Whq4uzsZOjk5ujo7OpkZGluYuBs6WjiamnOwMUpAHNNujgjw/ozgv8mP4
 2J3/Rs59sTfDerzEW54zf27vrKt2elgnq9/mZGhumFi6JllZiCV/vbmGs9LYp8t2h/t5vZ/vCYc
 3NjlPmzmQE=
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PMC6 repeats five L3 events at a second select value that the
alternatives table doesn't list:

  0x61f  L3 hits, also 0x503 and 0x603
  0x620  L3 misses, also 0x514 and 0x61e
  0x621  L3 instruction misses, also 0x505 and 0x605
  0x622  L3 data misses, also 0x507 and 0x607
  0x625  L3 touch hits, also 0x50e and 0x60e

Each is the same event as the PMC5 code, so add them to its row.  The
scheduler can then move them to PMC5 when PMC6 is taken.

Not tested on hardware with an L3; the 7448 has none.

Reviewed-by: Tanushree Shah <tshah@linux.ibm.com>
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/powerpc/perf/mpc7450-pmu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/perf/mpc7450-pmu.c b/arch/powerpc/perf/mpc7450-pmu.c
index 27337a03ebde..b2fe977cea16 100644
--- a/arch/powerpc/perf/mpc7450-pmu.c
+++ b/arch/powerpc/perf/mpc7450-pmu.c
@@ -185,18 +185,18 @@ static int mpc7450_get_constraint(u64 event, unsigned long *maskp,
 static const unsigned int event_alternatives[][MAX_ALT] = {
 	{ 0x217, 0x317 },		/* PM_L1_DCACHE_MISS */
 	{ 0x502, 0x602 },		/* PM_L2_HIT */
-	{ 0x503, 0x603 },		/* PM_L3_HIT */
+	{ 0x503, 0x603, 0x61f },	/* PM_L3_HIT */
 	{ 0x504, 0x604 },		/* PM_L2_ICACHE_MISS */
-	{ 0x505, 0x605 },		/* PM_L3_ICACHE_MISS */
+	{ 0x505, 0x605, 0x621 },	/* PM_L3_ICACHE_MISS */
 	{ 0x506, 0x606 },		/* PM_L2_DCACHE_MISS */
-	{ 0x507, 0x607 },		/* PM_L3_DCACHE_MISS */
+	{ 0x507, 0x607, 0x622 },	/* PM_L3_DCACHE_MISS */
 	{ 0x50a, 0x623 },		/* PM_LD_HIT_L3 */
 	{ 0x50b, 0x624 },		/* PM_ST_HIT_L3 */
 	{ 0x50d, 0x60d },		/* PM_L2_TOUCH_HIT */
-	{ 0x50e, 0x60e },		/* PM_L3_TOUCH_HIT */
+	{ 0x50e, 0x60e, 0x625 },	/* PM_L3_TOUCH_HIT */
 	{ 0x512, 0x612 },		/* PM_INT_LOCAL */
 	{ 0x513, 0x61d },		/* PM_L2_MISS */
-	{ 0x514, 0x61e },		/* PM_L3_MISS */
+	{ 0x514, 0x61e, 0x620 },	/* PM_L3_MISS */
 };
 
 /*

-- 
2.56.1


