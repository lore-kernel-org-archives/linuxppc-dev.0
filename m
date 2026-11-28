Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1924A606A31F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Nov 2026 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rmttZie5
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jcCPx6phRz2xpt;
	Sun, 29 Nov 2026 01:31:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795876261;
	cv=none; b=T4xWMvVnvD/8Uo1zi+DbBiHU+9UhoWLnhRmrFsHMTOZMomdonH05UFnFGRKVB9hqFZo89+Z7XvNVndA77yd/9OOdQZydnmxOp9smfOp1JqKMMtyhXohxl4FbTaybRV+KVwsJ62AHyC0dQH1x1dHnOk6pJflve1JUuaEwUTJY5EYjsrFKhQ2EsaeTb74pJsD7DbGm6+2PLulHAIlpxeI/KiXHQBr5GHhA64vIv5sHTPfmKRIQ7j4Nf0eVbYWMG4tnP1Ec8CGE7BVG5okILMhdhFaVg1fvG4QNyqIlEW0jbxQIvOvscNTJ85I7t6NJvpHJ7SyI8aCx5pwruLrN5lBRSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795876261; c=relaxed/relaxed;
	bh=TAeMfYpE8Osn2ZlADlOhEsnNQgCG1HIa4JYQz3ncjy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fw0Klsuxkcz3scxZhMLjGYSOIHtzt7i83ORDz6OlJWxfDFsufcSlcFJQtVHA66yZi+r5NkrtxE9YFIbGCq9WKE5918BPP2STvGVWxoojm3oD3CLhNzjV2hx1ZHxr3ijjLHq1kaQJocobQmlvPzidJ3vhUppGxOe/gT27NlDgnE3AFv06FVywtSTDmhgGe/1iFGtTQiJMOtacXcmG131IkLeZmrkF2iUpQ6tR0hOzO8HMT3NNm2PNpdZVrTENOXzmIWd8NsBn2wmAdNr0Ho3BayqLrMbKVI/ntIT66RydTXUW3+Vt3aYMm28V4kKxdUph9ZYaor2VeAOHQ2go8rcyjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rmttZie5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=mdshahid03@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rmttZie5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=mdshahid03@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132a.google.com (mail-dy1-x132a.google.com [IPv6:2607:f8b0:4864:20::132a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jcCPw3cMgz2xKx
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Nov 2026 01:30:59 +1100 (AEDT)
Received: by mail-dy1-x132a.google.com with SMTP id 5a478bee46e88-386cf1041cdso6770193eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Nov 2026 06:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795876256; x=1796481056; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TAeMfYpE8Osn2ZlADlOhEsnNQgCG1HIa4JYQz3ncjy8=;
        b=rmttZie5GzsCy+LKW3iUKZDXsyksqED5luMEB8xeDYgYWN96dgdy3QM75DxUsNi8+f
         3LHgBZL+mHSdB94F78i6mSfkLtU+O9pgIBxcThgdahmTtGKs4d5Lsqu83UrfeCgMHOMV
         VfokrzAyd0kcTHT7ZfX1LP9POGs7Ad5ADmOseWh88Y2CcOy9gRUwoEVgzeE3IjjOCgTb
         3voSKJ5YnrtBVy+UDFQ7MAvQbaTAEGyn5nJOi6l4XiVxXgCx1eRNUVEU7A+PwJNgszB1
         6glMRMHiZgSm2AOopTNSq90kOSz9dVqb4RPyRat1qeOFieec52EEj6uBrZRBjpzwRHJX
         2g7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795876256; x=1796481056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TAeMfYpE8Osn2ZlADlOhEsnNQgCG1HIa4JYQz3ncjy8=;
        b=Vd11Nog9DW0yNfzJts9fYxhe9VtAd1yduHsoeaPLMn+kt/21spQrfgx5KwTVuD5k6X
         JObt/Cmdwt9yoRmAuoVlXgFfLTTq7MX/xT3F7Sm2DDzqNLjGSnQi8WxEBpGYPrEUm6/A
         wkiFJLVXYHgAh8DkX2lat9uHA+mTzhNTGhq/eK5eEUs9mDQcZ3gxaXLY3h34ut09dwE6
         AI7+20eFuvIhz/v5GCYJA/XzaSJJ08kjuEI/VlFed2WRYOdxifixXsr/09AazS0hltgO
         /l4NVl3wqOxn9lghkAZCQhbodYS5XFCju9Nwpkeag3LRPihCTPkRFWBQ4wWlK7ayXGIp
         +KuQ==
X-Forwarded-Encrypted: i=1; AL+hErHmmFmrEuN4WSkfNtpNpv6P0aFm2oVwpEvYP3Xg68Bw8DMIPBdbGDoLU4RR3IP/nkWd43CWpJRB9m70l+o=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+dQtceXwnUcR+AOvO4CGxkxy4RY4sbCNZZ6vpnncnI0upHLhr2
	9sqin7SZLqiS2HABMnSq0FN2qyF8O1MvTvps948b1nCCPf/UY22l3CTn
X-Gm-Gg: AZFdTZdD2bOrBvNeD7hwuwM8/G+LjECPikxRDcKTG/OVzxXtg9J/rJBTTaZZB7O7otq
	m7try37lMt0U+vZ6NaoleS+7cG/mM/AHxgWYZe9sDSWDqxWbhTXcBU4j+r1WJqXtj6yRVfa9UG7
	SeeMPjie16nsqSXlnKtpwuz3wyw+gEWVU3+CMaZcKjkjYw5EjYhjiopt8/tieNbFJwG8vorDfAR
	SaUBHpk7NMBEvoiIA5T0hBQ7rVT1ubVtEB34Y1mYus4j7lYtmqkbbPeasmh0Zw1qkMhANzTcjvR
	Kx1UOeqO9gH8G3TuxZ6/xjI4FfZ7CyXkoojnWEW1ZUsrBRZ0mQVy9TwfFtbQirUJ/i5BBsUbuXF
	BwJMQyB1xpplpm0BIl4OFsDBV8sti1jqnhHSu4mJARajwCZt2GuorOEF9b+jYL9HoZTvGCYTKdt
	vPNpNjAPcXu+YICfH/6pgWhP/EBTaK5s6qydxQi5GkEaLp1CL8BRtmNzawUB7aYVpFJAkPI3GmZ
	cGY5+hpsp8NylcDy6kOOyj7eMeUQ4cH6hAbjR30lbq7D3GBzTtDuFq7s0UJDU1xmr0zEt7scEzs
	/PZMMtMQ3MCdpAgwwf8YTpz9LD2i
X-Received: by 2002:a05:693c:8947:20b0:386:9ef2:8e01 with SMTP id 5a478bee46e88-3869ef28fe2mr19916723eec.0.1795876255590;
        Sat, 28 Nov 2026 06:30:55 -0800 (PST)
Received: from ubuntu.. ([2405:201:8026:213e:5952:703b:1e4f:156b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3866f299d0bsm72064841eec.19.2026.11.28.06.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 06:30:55 -0800 (PST)
From: mdshahid03@gmail.com
To: maddy@linux.ibm.com
Cc: mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	kjain@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org,
	Mohammad Shahid <mdshahid03@gmail.com>,
	Athira Rajeev <atrajeev@linux.ibm.com>
Subject: [PATCH v3] powerpc/perf: vpa-dtl: fix resource leak on allocation failure
Date: Sat, 28 Nov 2026 20:00:29 +0530
Message-ID: <20261128143029.15262-1-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mohammad Shahid <mdshahid03@gmail.com>

vpa_dtl_event_init() allocates the DTL buffer while holding
dtl_global_lock. Move the allocation before acquiring the spinlock
to avoid performing memory allocation while holding a spinlock.

Since the buffer is allocated before acquiring dtl_access_lock
allocation failure can be returned directly without releasing the
semaphore.

Free the allocated buffer if acquiring dtl_access_lock fails.

Fixes: 4708fba19ade ("powerpc/vpa_dtl: Add interface to expose vpa dtl counters via perf")
Suggested-by: Athira Rajeev <atrajeev@linux.ibm.com>

Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
---
 arch/powerpc/perf/vpa-dtl.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/perf/vpa-dtl.c b/arch/powerpc/perf/vpa-dtl.c
index 3d34417e6aae..57bc5773949f 100644
--- a/arch/powerpc/perf/vpa-dtl.c
+++ b/arch/powerpc/perf/vpa-dtl.c
@@ -338,7 +338,7 @@ static int vpa_dtl_mem_alloc(int cpu)
 	if (!dtl_cache)
 		return -ENOMEM;
 
-	buf = kmem_cache_alloc_node(dtl_cache, GFP_ATOMIC, cpu_to_node(cpu));
+	buf = kmem_cache_alloc_node(dtl_cache, GFP_KERNEL, cpu_to_node(cpu));
 	if (!buf) {
 		pr_warn("buffer allocation failed for cpu %d\n", cpu);
 		return -ENOMEM;
@@ -350,6 +350,7 @@ static int vpa_dtl_mem_alloc(int cpu)
 static int vpa_dtl_event_init(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
+	struct vpa_dtl *dtl = &per_cpu(vpa_dtl_cpu, event->cpu);
 
 	/* test the event attr type for PMU enumeration */
 	if (event->attr.type != event->pmu->type)
@@ -377,6 +378,10 @@ static int vpa_dtl_event_init(struct perf_event *event)
 		return -EINVAL;
 	}
 
+	/* Allocate before taking the global spinlock */
+	if (vpa_dtl_mem_alloc(event->cpu))
+		return -ENOMEM;
+
 	spin_lock(&dtl_global_lock);
 
 	/*
@@ -391,13 +396,11 @@ static int vpa_dtl_event_init(struct perf_event *event)
 	 */
 	if (dtl_global_refc == 0 && !down_write_trylock(&dtl_access_lock)) {
 		spin_unlock(&dtl_global_lock);
-		return -EBUSY;
-	}
+		/* Release the buffer allocated above */
+		kmem_cache_free(dtl_cache, dtl->buf);
+		dtl->buf = NULL;
 
-	/* Allocate dtl buffer memory */
-	if (vpa_dtl_mem_alloc(event->cpu)) {
-		spin_unlock(&dtl_global_lock);
-		return -ENOMEM;
+		return -EBUSY;
 	}
 
 	/*
-- 
2.43.0


