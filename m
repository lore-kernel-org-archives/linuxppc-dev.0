Return-Path: <linuxppc-dev+bounces-26671-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FEF7C79F89
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 12:02:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdlzq1dw3z2yxl;
	Mon, 07 Sep 2026 22:01:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788782519;
	cv=none; b=Rtt8iqUz4yIANKgVZryS8S2VeytNFe1ENdwR3gAEL+hr6t1074b73bldTXvrtDRMYSH/huj0uzlRSjHfnl3nykSQkNzjuyF0Q45eoaeFB1sFb46Fhz3Ho/PTm7zLUXijh6N++Ivz3r3zyhjXwEm5xyCUVOuK7opIY+jrZuRoZS42aoeJ88vBVWS14oh5Bk1e4Mi1s/ueh30I/CzKl90aUfH7qfFgSWb5m5PoF/CvRhNWU7/8XFhOIymEwewEeAbVm/hukwJxGFvicQRK+gQE4S+/nynCMcfkN0DLwTn0iUzdKpGU2THQFFe3eFjUTmCMv9HkfBzcs7GwJ26VsOY2fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788782519; c=relaxed/relaxed;
	bh=iSdhcylG8upaYgz/wmJd+JoSvai0ylGkPowyAHHfN0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eK8POzT8eVyQfbG7pzZEaFSu0L4FzR30r3oZxvs5rI31la8CphpjrRSNMcJpOFN3HhBnRvhKnvzAFNpoya6qRKrqicO+Ax2D6yzQg7zS+Zha2hd101OdPoruWijX7mD6/KqCMHkraXUWmRuwa9b3bUgr1sfflgHT18WqHd6Iyn8w1rI/3O5JmlRrwCM3u8WqToK3UJKZCSLLc6JK7wqOjQCe+u31Y8hiW+uOt6geOnkJUPsgnc3ju0a5aiLaAabJ4Vpdvh1GGzMTnORIqVGPSwgUM7q5zBEYI4N8FOEjhMzLB5nLZWv4NBrKGFqv3GxyKmWe57MWwomRkwWoBFvoxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=M8nNe3k6; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=M8nNe3k6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdlzp34Cvz2ywR
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 22:01:58 +1000 (AEST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2d9db539a54so27274755ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 05:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788782516; x=1789387316; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iSdhcylG8upaYgz/wmJd+JoSvai0ylGkPowyAHHfN0o=;
        b=M8nNe3k62KFOwbvaI4bhiKZnB7KMpWQ/SLs9IP70xHrL+HfZ6/UtFDNamC3N4exZpm
         u1PO+BJ8eEKvKbEVqdHU0wOMyPTB9HVSSRyCgZno0WRuXpKNqVezlIN51kLCcxI38pL2
         PLQEt4fWY9EoKdSS9/O8O1U0jYzkvNxRs6be1r/jzsBPd95Yf10UgdM0DIoEiTaqs97u
         Ily01nVHv4rZAWdeWyYMt/m76Xr0LdLpAtYr1hF2dOfHB8ZXikYMvIMGqY6Z7CHg0bAK
         lBEXSKc8CBZU3h6xslTlR11pe3iNrMFq7I9VvjrENnDt7zvdNCFF3R7y+zAkPJuZyV9p
         WfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788782516; x=1789387316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iSdhcylG8upaYgz/wmJd+JoSvai0ylGkPowyAHHfN0o=;
        b=FSAIvuiwMWGS6odoEF+8YidV4jkI75AOHb8eyGgEKN/xk3Tk9jHLfgKx8PhXxKMWCJ
         RvTsV40gX4stDpOaypen3ASvpB/kiVYXImkujoNaF7obK6yX9JWQArK1sVElaqu9ak1F
         XF7gBJmXsgyX5K8XoiVOm8GF31s/fmHfYcHWeTGhXTtIcSzLf7NOjhlFmxILZm9IlxuI
         lq2x4FSGWtJMMD7b2K9JOnKQXDOsYfrtYRZZgCpx5j7e4+AlRdoboEBi0Uf8dRJ68o3D
         KLpBjCudO2s0YWNfrbfh96he9ZUH1G/FFducsxuVLdwXNVLqAzXhs1HDQnrhG+nPJU2n
         hoxQ==
X-Forwarded-Encrypted: i=1; AKwUvByVyRtAXLpz6y79mn9vWvWRT0vYjeiMNRJk0OoR5EMKDek7t+kDGil3hOmNVWz0hf2welP0deCbVcXFHOQ=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kkwH9DS8gnngh1/qNA2a89PUi9SytxDWsRmEmmVuKIvke1uv18
	oX8NemprKGe2Jk/Q3xSWBNl6DL7ohG0XUqFA8QFPgHmWsnyIdpTvJ7WX
X-Gm-Gg: AYBFou2M1cGnnkh6LWB373xEAXcr3QXyOtJFao0F6YTxgQBXb5teG37riElw37cnVke
	jXYfBSwacZ8YEQkpnVbz1d4d2xcvr9aPBnK49RfC8vUio5XO8M2YVjI2mNQzGysMxGxwYCjG7Yj
	Egi4qO+uZx6DTHw1skhQPXpu/hyagdWjpMVCygpnzFVYO9hktwZajKDkpo2MKnZDFmZCf0vmMke
	qoPjbri2fZmuKhl1yYSwFFLe5Z8IaTAuHScYdEaJ/tmXJhft8oo/4Xdo8nglh+tlxAxBj+htMO3
	EhuFPBffUCvBPc7UfUjlycG5m9vBGEiyDX1JlBE3mNztzLOzXkwUN0TYtijdC09CDWOqnEPcU5J
	K1VfR7QCKvpnQPM0rS9BQOZ9K624w0xiEv6xSVHlLSkHlsH+20KL6RGK2GofutE8MyZ2gcqqm8r
	+BHThxjRM8f/6RVOXCOQZfNbBYEGTdYLY6NQmnOqsCX/qus5b9k1wEUIVBhkKUuskwRWZJtM3tv
	wegq3h94GehlQ==
X-Received: by 2002:a17:903:3810:b0:2d6:3c22:99bf with SMTP id d9443c01a7336-2db124afcefmr348302995ad.9.1788782516134;
        Mon, 07 Sep 2026 05:01:56 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885ca07sm31244462eec.1.2026.09.07.05.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 05:01:55 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 7/7] selftests/bpf: fix repeated words in comments
Date: Mon,  7 Sep 2026 17:30:43 +0530
Message-ID: <20260907120043.36894-8-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907120043.36894-1-hemanth.selam@gmail.com>
References: <20260907120043.36894-1-hemanth.selam@gmail.com>
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


