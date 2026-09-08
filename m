Return-Path: <linuxppc-dev+bounces-26722-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6B5C79F99
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 05:50:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfChH1YZPz2yqw;
	Tue, 08 Sep 2026 15:50:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788846607;
	cv=none; b=PlN3pEv5VKzAVWrK9oxQeJVu3F4jyaBs0D6QlzQkJFCrqzlx8GyoBMYqxsH/ZRDiXf6YHDNyIboyyST4uHo5weHsQhsUBK5eWBU/EWt6R2//yKyEV+nvPJS2/2xHQDvka+N4u9Bv/LS2y18VLxXyjUsERuxi2O/G4qfDnjKPUlQt8C9W4S+h+8TItlpy0CS3APRCTP7hWp4YZvGU3748wHYtjSyAInf2h9juu2PiI2jbpvmOFigrt1693iFom1/62eRrVgEJQ6m4wlIyY4adDtaTe46b19sY7XIMWDSPPthq9XdLZRhNX5gc5f7Y8dUqsztBS1HmHiLd5gpWq7cxkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788846607; c=relaxed/relaxed;
	bh=iSdhcylG8upaYgz/wmJd+JoSvai0ylGkPowyAHHfN0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mh7fw6wYomlFBfO/ZIGfkRWMn91MFRO2nygyVT4cANFgL/hu312HtZKbWkaS5yWR+ITjZUg3Hh/N2iJHQSB0UAYDB6O03uy4+JN7ZUqiD5e6Z5L6M2R1II3o+0ZHVFSbWR3N7Dh9KI+VffsTFK+XJa47Oyk0pAUfa8dQj6THjNGaWciQpiwR18884DHYdN6UL5kKSoqzundGmevVZfBURYpXqwFEMLYOqWefbUSe4Vrd46HiWhd/j8OOcTB3UynvuRo08iC7Wl9LE9dZygOS/5kWfP1OxecqiMb8C9c2x592lttW1bEm8SWT8ImrgHmOqmq/DNj4upaj73HPbORNDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XCtVg3Ii; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XCtVg3Ii;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfChG3vfjz2yqs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 15:50:06 +1000 (AEST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-863c229c3adso2072836b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 22:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788846604; x=1789451404; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iSdhcylG8upaYgz/wmJd+JoSvai0ylGkPowyAHHfN0o=;
        b=XCtVg3IiJcvE2InYa1RHO8hgHe9lJPZ1w5ppo3SB0KoE/d7wMdQ7WgTHU0E/c3KJzQ
         BV67F7sf3HmZ+mAQjKwMWYHI1EdiZR85OxQSOP5jiM12+M42HggpfOuU6x48yhoGkHB+
         jRen0/DtE72BkplN0EAB1MIUJUnm+0wdgwsCC2jbCwb9Q5RGWqdKM5q5+/fFTqj9n9St
         P0M8HeiQix96g1DkfBhdesFnF3psODJLWdaeJMNJemg7F5uFN4AsoaDh0glpZrP+OCCF
         BngBIgABMvroLv9/wNVI/PcbMapnpOmhJj2LeJZq9V2kIv/9rU/jwfcwROD9JUt0duR7
         eRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788846604; x=1789451404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iSdhcylG8upaYgz/wmJd+JoSvai0ylGkPowyAHHfN0o=;
        b=L//xdDTCT1EozeJZzIy2oq46jpuuhsGK1TgajpRGpUr/s5LNtZBxXiJI/027utvI3A
         tFHvyJfkXrNXhI7reQrbtI+ljQ+LrEndpfM6AFPZ+pqQIfAJxfuQ7ytS4g67VfiohuNP
         UYH7YU8IuKTkPpEv3TBuX5AE2XI5mS+/drEM50054JPzOIK8X+tAuryBIGcU9tPyB52t
         X20P1Lm3fIMlUXLQY1pWyMW8h2dvCG8bMG9YyjwRxPqiI5SwmGECloTjcE6X5lQdPhm2
         8if9njT6x1i3Zk1nr1pMKbpXz7ErdbiS6cG/kId20DgYd4l/CLdu9qwuvfHpJf92VHQ1
         tbMQ==
X-Forwarded-Encrypted: i=1; AKwUvBzE8Zh2X/Mm0aIM1yf0cG5CJ/13mmRDZDa7WSBCq5rl+vHQtlq/yAwHd/EwHJ8ftZnkrDzZcxRSLxgStGU=@lists.ozlabs.org
X-Gm-Message-State: AFuF++m6QzOl0uZ8L54WYBC7jK9MnmorZDoMb2gk51JHGA9EohCc9Sn0
	TVb95YlS6K9n2xgKWIMOKdPVyyyMFeGIbzwxyu6Moc9wuiu9pMQXPoRg
X-Gm-Gg: AYBFou22xIRCyATSRuhQLVuC0BE9BVBqGDBNuQsgN80JR6DY/UJ7f/KOnuXYgMeXNmJ
	mGt5vwv5+DPlDxWQdUtg1irxG7kjISRJhedWy/4zzKEttM33mktYmItIaI6442n9LMVP/NAKIld
	7+vbIbx6a2Lo2SjjW9MTloqenZwfKeUI5KT2thz4H4dBoYHJq5ofWTKnLA8hQ01onOyHJ23QNUx
	7e0erGKuLOJiLF1BPEEE8evABpvVNd1/6Z7TwUc3z6WEGb855wMJQxZS4DG6JOD8A38zfJf2Ckz
	uByhfXCfJmtfgD1QUeuvSQNtr3fYqMk3d7xD+2ZnFnot8ygPE655yPHyjejvBy9ir3XeIt/LZjc
	Ie8eahW8IrNmx6cK9yNIuUF9uKAZ+YRJtc0cGDpDjpjqNWGE/eJuyl8eVyW4gVNfeIuJWtIFG3x
	r2Nb61VcLmktbwCAr9rtiA5w7MHy57WqDDbVYveNxIxj01ukl0mQf2TLhcWeih35M4saddrRU21
	hmWCwgDBtH7frkp1Yi68v4d
X-Received: by 2002:a05:6a21:7989:b0:3da:421e:40f3 with SMTP id adf61e73a8af0-3da421e4978mr36173588637.17.1788846604363;
        Mon, 07 Sep 2026 22:50:04 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-334fbd5e6f6sm25690109eec.23.2026.09.07.22.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 22:50:04 -0700 (PDT)
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
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH bpf-next v4 7/7] selftests/bpf: fix repeated words in comments
Date: Tue,  8 Sep 2026 11:18:53 +0530
Message-ID: <20260908054853.13820-8-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260908054853.13820-1-hemanth.selam@gmail.com>
References: <20260908054853.13820-1-hemanth.selam@gmail.com>
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
index de656b69d13a..fb50ee4ad097 100644
--- a/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
@@ -204,7 +204,7 @@ static __always_inline bool check_asan_args(s8 __arena *addr, size_t size,
 		goto confirmed_valid;
 
 	/*
-	 * Wraparound is possible for values close to the the edge of the
+	 * Wraparound is possible for values close to the edge of the
 	 * 4GiB boundary of the arena (last valid address is 1UL << 32 - 1).
 	 *
 	 *
diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index c6699159dacd..e44a979270ea 100644
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
-- 
2.48.1


