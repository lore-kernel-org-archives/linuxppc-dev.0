Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349D5606A31E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Nov 2026 05:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rhgkFSL7
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jbMKS6Xszz2xqh;
	Fri, 27 Nov 2026 16:24:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1233"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795757052;
	cv=none; b=HrcOKQ+k0AIrLZqzoPu5nu6Sr8Zzrd2wUHO1GAXJhVr6GuQx9la+PnX/hm6zVHENY+RIl/flVFrQta6rgSCgcCBFdqe/8K0Z+sDrotqitEieWKs/QZ/kt0zKfOPyAcKsLIVSSVrCdB7ieFY3BdddgiDHEAw7AxCFZJfKY1MPZnm5gs/m4HCjz8voJZi0Yong2N+4aG+K0mfOO7/x1IyHqTacuWKy8Yi+nshhnlfquPCc+fAJ1svfHCAqJfB8hgGzh2At4HqISe0gcQBuCcCAiM/DCYDCMSV8hEK/i2ynHsa8dqPerMLCliUw/DDwqhEl65WkpqzgXV6aR0Poqyomyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795757052; c=relaxed/relaxed;
	bh=VunIWhlXjqQbEeGcoAeOGcWx/ibG4ikraJURdAYqSgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lSgbMkBCJWI5sasY40S2OaHxbz5ZcT+6GVY467hdIjgzyL5swu+OstvdYea4PUCTfTCbXzRlfmhvr3HZYDeecF3dwxQDFouxTJUw5pVWOuM2AEuCMqD2Xx0mWRUX1645FTxmG3x8AKn9q0FeJOyH4WQcCc2REMDzD5jy13DIbfoGwDvPAybpxNZBRAkeEN7ZnaxAP5WLyqtE8xObjXzH46a2Ec12GUksEDWKkcFFv8owtPGytxqg/uFisvtD3VJ/HoaWEmPKmre4mkYGA6z5DjvtJMbt30ETk+JRinf4RFJZ7S1dfhjLOaSUQZ8GCYJDb6DeLrhH6fH60yvf0kb/nw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rhgkFSL7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1233; helo=mail-dl1-x1233.google.com; envelope-from=mdshahid03@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rhgkFSL7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1233; helo=mail-dl1-x1233.google.com; envelope-from=mdshahid03@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1233.google.com (mail-dl1-x1233.google.com [IPv6:2607:f8b0:4864:20::1233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jbMKR6cVZz2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 16:24:11 +1100 (AEDT)
Received: by mail-dl1-x1233.google.com with SMTP id a92af1059eb24-1b546061d58so17858643c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 21:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795757049; x=1796361849; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VunIWhlXjqQbEeGcoAeOGcWx/ibG4ikraJURdAYqSgo=;
        b=rhgkFSL7yOYuodXhtDsYxS0NQ2aLv3sPHU8xpRarvZLxmAJ+heQJL24Fsrt1P9/Pyu
         jahYWMt2LPSqDs/nN87hNIdaj0QRYAFDXxMzg4212940QmYwqXaWTqJw7p/ysOk1cVK2
         Xv/7yxSipuzA4ZuOxvPKmEum3nKwnz/RpskCVOrgg1r+jaBeMsk0G4euImUKB9Ze+6b+
         BjMt2TX6B/f0LmhOttVYXN+OX2UPsvucKjwvrxcLLVmXpujmir7K7VC4XEPQWANrH6PD
         b6wl6/MSeHq28ne6Mnci2YXORySC6oS8odJCrxmsR0Dydfpa2z6eL4lb0hz+bqoJioB4
         NVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795757049; x=1796361849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VunIWhlXjqQbEeGcoAeOGcWx/ibG4ikraJURdAYqSgo=;
        b=JcMsmzFNGEDqJamoz257kTKfMnAej78rdHrokFCC8TCCJUPMtqcgbwNxaK7F3zEnDA
         8CSYfgzPr41qy1DE72f7JxWh41Xgg2ve/k4Gkz3w6lxplDCb2nLCat5f6KAzQcOxvNe5
         36BAJBIZL/VgsAeCs2qyaVLxLXk7ws11YLdoAtpM4f6PitQM029lWj5TQBi54rszmwC6
         8kArtUgt6QBFNPeBKRWQKgCErIGbBJaNU6+oqvM263xzC6+vDh4jRVzGlIgqQQ0LxYOF
         7PSBrjQNHrqtw4e/VaflwIduqDFZEYjZpywDu6rRZCPs0CKQU9o0sFzJBFw+0lFv3VHg
         KUaA==
X-Forwarded-Encrypted: i=1; AL+hErHYkpQopb6/sgeYqb23B/A7XswWVqzCB5bQYRl7b1zx/0+Bn5d/4pwV3wT2gF3DEOoqF4YUgSeeDxTXTKs=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+reuGB1sCOd8YrARe1BDltZ49P4/dhl5vGlJEXaYcAl4NiubYy
	r4GNxkPXF71eZ7htoTCvlXMwCs8kMGK6xIuW4R6WrUxoEvWVY19qoKJG
X-Gm-Gg: AZFdTZds9ITsnB7raW/4gYQz6a84+GSjEk99oSYqX2LDs+lQHEGPl2xPWBs0vjTdjJV
	tm+i+cY+WLuU8ydOihpg4o8+Ia5e88LPOxRjCc/oDikecXJ4cjYRLmvVL0u/pF/P6lRKu8HJuI4
	4LiRjzl+gDaInPDijuXXK7cVh+lwgXV6EVDUEN0TKPpoaOK3XfiJyKDruQoU8wvQ7TimG4cI8t3
	8p6RRhBC3pBj6e8A9ZZh450yhltn5vY8fdW7+ikYDn5Tv9nx5RmyvtbrDymTZw2ZgJxi2SuPA68
	D5XtUWUNISKvoPmx4ahsRt8U7TxTTy1J4uvNpvh4wntoocIoIOr7PU8SYiJ7drseje5fcvTPcbT
	w9Jf/AEXlkghuEc+e0GZA2dfYLs9OClUloy/DKnXK37Fofja39GBMnqjZN4C6l3WHYBOgZ3kAPS
	m4i2AO0a7QRX0U23xfmjcn3WfAEQnSTlKO0aQ6ytLH7ZTKHTc/Y+sSjhoH4NarifduDm5e/1sU7
	FJwHWsvMLKZMyb/tHpsFrPaStnYAw1YHeac2LYP1/ZT3SJ3EcC1Rk2sLQaxzT1o/U56L4wieGBq
	hgg8MabX7kERu5/MB9ChLnwDiRjA
X-Received: by 2002:a05:7023:a8b:b0:1b3:af3a:e784 with SMTP id a92af1059eb24-1b5568fe775mr26335922c88.32.1795757048934;
        Thu, 26 Nov 2026 21:24:08 -0800 (PST)
Received: from ubuntu.. ([2405:201:8026:213e:d3da:eb46:936a:228a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386d605c894sm14736480eec.2.2026.11.26.21.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 21:24:08 -0800 (PST)
From: mdshahid03@gmail.com
To: maddy@linux.ibm.com
Cc: mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	kjain@linux.ibm.com,
	atrajeev@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH v2] powerpc/perf: vpa-dtl: fix resource leak on allocation failure
Date: Fri, 27 Nov 2026 10:53:45 +0530
Message-ID: <20261127052345.23361-1-mdshahid03@gmail.com>
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
 arch/powerpc/perf/vpa-dtl.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/perf/vpa-dtl.c b/arch/powerpc/perf/vpa-dtl.c
index 20eafeaffa6b..57bc5773949f 100644
--- a/arch/powerpc/perf/vpa-dtl.c
+++ b/arch/powerpc/perf/vpa-dtl.c
@@ -338,7 +338,7 @@ static int vpa_dtl_mem_alloc(int cpu)
 	if (!dtl_cache)
 		return -ENOMEM;
 
-	buf = kmem_cache_alloc_node(dtl_cache, GFP_KERNEL | GFP_ATOMIC, cpu_to_node(cpu));
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
@@ -391,15 +396,11 @@ static int vpa_dtl_event_init(struct perf_event *event)
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
-		if (dtl_global_refc == 0)
-			up_write(&dtl_access_lock);
-		spin_unlock(&dtl_global_lock);
-		return -ENOMEM;
+		return -EBUSY;
 	}
 
 	/*
-- 
2.43.0


