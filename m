Return-Path: <linuxppc-dev+bounces-26643-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5535C79F9E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 04:52:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdZSc3m8Gz2yxP;
	Mon, 07 Sep 2026 14:52:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788756768;
	cv=none; b=hlmS7G48F5ZoeP0C1ABaNSiX4J8yTbntot06roJQdlmojJgJiqrggXltS6N+RElEa6NNZbOxUvi+XGmQA6PcbySwZNrGPVQhgHgrMBHkTUTnVk0se5V0uq0RSSSwS7PhDde6jbstkfcSq3ATpFhsSxbEqcyaUnuuadyu82qG628/1uRyNaTXBLt0QpIbyhkwwiNGeWyoanTgb64uGAisZk9y3s8Ooewo/BYPy2TIe3lC9BCvYc8OeyZpFo9Xa3mLfzNZFPW+bLFVAzxC5Tla9596bp+QTXcimmiJ5sq22cHesxiM2VsnKjLYWJWG1GjG9NNbYrJuFUu0854Jo7KeLg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788756768; c=relaxed/relaxed;
	bh=nKUvGXFfM1WSd/D5lDioUe9VV0OdsRUwt1UqjYJjYJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LLCEFH7a/CpXTbZN+b8EDjmVkO2BpkEVuMxKKJ4zgO8hdGZK/zkR1y3k3NVs815IGIN9XST7E4Oy7Ys/Xc+PVxyTsGUxiO7N40TsMxbTPCxqAzGNVFwSSRQm7+zARNAQWPNGzwiF/zPsVPppRKQTQfH72UY364k4/Mls2wyzEged/tNCcSpN57irPVRnGRRZ/qZcIBeTbt311pLWRCyUZs0ZYMzkAeE6ZX6/3OGC55JQnrtE/1rz+l8nDDQHyzJ6aRVm9ts95J9aJpikmWAp8Lcw9SecmNqa8VPohoO/sBChWh7H3Bdn3L2Yxy/8jqiOGKykLZAoShLmuCYOIJogig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dVUV5hFJ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dVUV5hFJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdZSb60yNz2ywN
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 14:52:47 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-3964dfb5b9aso3933372a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Sep 2026 21:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788756766; x=1789361566; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nKUvGXFfM1WSd/D5lDioUe9VV0OdsRUwt1UqjYJjYJI=;
        b=dVUV5hFJ/Qr95UayZQo5YqJHYtqa/6OqGui9bXp3PdelHD8CPofIM20QgCZhjXHHNc
         z07NI+5Y8jyZNvgJCCNQGdOm/PGkFvK4OsmJr98q0lIXPwXthA23N22RrOGyvnC+YUNZ
         docbhKNl9fO111JpD4eeLgcaSt6tW30GEnMnM9/aQOecYJhzSdV9DwTI2LB8cAXIR+gZ
         6A5JPKio1MopQH4b4rnlvKonZlIgC67mwUAW9crUYOHGwv+a6u4AfD1j4FXhkYczPIbb
         2sTUaaisaF4oaFheB0SesE9h8K42JyRf79Ze63hoJR5r1FS5Rxdymntu+1BC93QTvbaK
         QiuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788756766; x=1789361566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nKUvGXFfM1WSd/D5lDioUe9VV0OdsRUwt1UqjYJjYJI=;
        b=XhVo/JWG8sCxzeLbThMJONtpOF6Q8s+xYCvssDJDS/R3rbGEQinEM/nidQ0Hl18P7e
         pSquD9k8PXF3VGeqtjyCMIIuUC14BzjwBEGt+63Zyq3zdGQRwvrmuij2P6tx7Q/1r4+b
         JBP12pPt63Yo/ZjTOn6oFyxjGqNHBLXGNKzd1iIMQ22ePblNU3K2yG/8Mb6/86EBzuo5
         BgwqBT3aSv+C2llfxQAKS4kHvOho8dv7OHMqciwiGDMZRCXko/Em33qwaB/Nlucw6A0B
         vxpCMTFDdKlUyvonPxbi975dIHIgEOkallRSgwjEUYscXD06hiPb7Qpg3s/oRXQFgpEb
         ZNOA==
X-Forwarded-Encrypted: i=1; AKwUvBzVpkV/SS0pLsXW47EQpeY8PIKaJVvijFpsX0cMDFZS3oN2zKyCGDNRtF4l1jA6dzSYrOcxc68i3qKmoOs=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lTAnjvoNv/uA8XkovfIxv00Rc7MvBEQkvLMH/kR+uwOXTXHCIc
	3P2gk1GL+IsuG8QD3Dn6/XfowzfAPsLw+NcmkX0MUerxbnVltvlhXC5b
X-Gm-Gg: AYBFou2qjIu2OsK5VxvseXQUKQNXc9jgEW1o1PpSArktPG46yjklJjav+CUEZ3ZZn3y
	p5MENLIGZWkX5E18nmnlCdf7dKaEkfYQx5sNyipa34aS/CgR7gaxdfXKUURmwN/o8SWoeHEmicA
	xfhE6qOeI5TzuE6/JGvJ4Qh+GiF0ESnWpVvjXWBn7TvAio9nKba3uwvA5D71RCMEtJyaym4rJnV
	5L5JtLThYuwovjxfLNrReYBlrAXCPlTvo2b1mwMF3Hwm59gCpAovRot5gVdvy1lvSBPH+7LKf0I
	VTjlmPGAuN4PkipSs39IeqtYeNMhjBtWsg7O+Ewn3bh6SVwRye7nHXYKqrhgDpgR/H0DGveGzxv
	+Cph5xKJIdrdzz0/lcqTZeXL/XhijX2y55G573AIekjCamfprfByvDTT90vcyoYFcH585TKQNn3
	Oz2axIwCllVXJBu9HCfb4+ib0zjtkYC4KtTKAMjugwQrjwGLSkGkF+Uu+NeRwi2IpjRKeBmgq/s
	csvdQNRhJ+w9A==
X-Received: by 2002:a17:90a:1c81:b0:39b:2c00:c3f5 with SMTP id 98e67ed59e1d1-39b2c00ed40mr18971030a91.18.1788756765648;
        Sun, 06 Sep 2026 21:52:45 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324410092sm21979675c88.14.2026.09.06.21.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 21:52:45 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Russell King <linux@armlinux.org.uk>,
	Puranjay Mohan <puranjay@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH v2 7/7] selftests/bpf: fix repeated words in comments
Date: Mon,  7 Sep 2026 10:21:35 +0530
Message-ID: <20260907045135.13317-8-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907045135.13317-1-hemanth.selam@gmail.com>
References: <20260907045135.13317-1-hemanth.selam@gmail.com>
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
Content-Transfer-Encoding: 8bit

Drop repeated words in comments, reported by scripts/checkpatch.pl.  Only
touches comments, no code changes.

The subject prefix changed since v1, from "selftests: bpf:" to
"selftests/bpf:", to match the rest of the history in this directory.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 tools/testing/selftests/bpf/libarena/src/asan.bpf.c | 2 +-
 tools/testing/selftests/bpf/progs/iters.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/src/asan.bpf.c b/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
index 5135d5c72a46..158d95c2520b 100644
--- a/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
@@ -221,7 +221,7 @@ static __always_inline bool check_asan_args(s8 __arena *addr, size_t size,
 		goto confirmed_valid;
 
 	/*
-	 * Wraparound is possible for values close to the the edge of the
+	 * Wraparound is possible for values close to the edge of the
 	 * 4GiB boundary of the arena (last valid address is 1UL << 32 - 1).
 	 *
 	 *
diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index 62d7df9e80be..340670e89ba9 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -1511,7 +1511,7 @@ __naked int checkpoint_states_deletion(void)
 	 * would get equal to one of the explored states and thus loop
 	 * exploration would be finished (at-least for a specific path).
 	 * Verifier evicts explored states with high miss to hit ratio
-	 * to to avoid comparing current state with too many explored
+	 * to avoid comparing current state with too many explored
 	 * states per instruction.
 	 * This test is designed to "stress test" eviction policy defined using formula:
 	 *

