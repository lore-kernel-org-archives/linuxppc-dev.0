Return-Path: <linuxppc-dev+bounces-26721-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DA0C79F99
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 05:50:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfCh6668Fz2yql;
	Tue, 08 Sep 2026 15:49:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788846598;
	cv=none; b=GA/bA/PtKS8k23T71CTjWM3/fpkLD/wiEmPuslC3NH90BkMYAhEcx4AhNmkXxFALxC091x6M0kpUeVRKW2udgV/XhCQFXK3RDVNbqk4GErJTPG9TFYGR37+rCr3SrdA38CRMC+PUwUibX3iySkYbLGt4NaEyBCtJF93KBevR5XYWV3zalZMWLioaHoTS5GIhmARFJE9vSxBWshS6Ywopi6onw4lccMYVh87jEhF26FjE7a6YzzcQeY5bcfyLEKAqlYrmWN9r8qpWdKSzxr45wlaoav8oVkLLpPbfAQsZqSptkeBknvAmdGgVe1GR1E+RePhp3VKk5X26sUm+nhrSqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788846598; c=relaxed/relaxed;
	bh=3F8xNc6JnbnOhSUa3MmC6YFjLwngFDOoggPy4Vs2zK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNdwxIVLtAJqXrTw4oOgxTZq7NWxjh/l721q+ymC1DZ8WuvokgFSwgamyLjLA268Hs+mQgWzaXgLpZxQmE64Nw9SzT8q3RAszer/ERZf8s2kMJyvZoPSZiodwJlkai1LuwkGfaUMZFl4PDQ5i79gp17BAkigrFlT+v0abv6I5eUr/tdpupFq0AfmdqNnj2BQbXKIRVbZhqKSijySTH0jB4s1lcJrTlgRFyOLONVLnSaM/us3gBbCg9NYfkZOpsGJmJxcuf9O7gAfcPZnQliYVCHhTTecnZqSyJZyWKzTjaHN0105lhDdoRtipetEmJ1iB+Kp2RaOGK/ZdmNUESts5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RSJHwWX2; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RSJHwWX2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfCh60TG2z2yqL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 15:49:58 +1000 (AEST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-cc1c3d79b9bso3014220a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 22:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788846596; x=1789451396; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3F8xNc6JnbnOhSUa3MmC6YFjLwngFDOoggPy4Vs2zK4=;
        b=RSJHwWX2lGzvITfpppqBeiJf/FpCOV3I9//jIwOaHyvSjVG6oLKFdXUCCWKJsRFh1F
         ANaKuUcCup00qCA3meUY1GwSztmu/CVI91DfNmnQErnAvA2skhVx8KOwGi/AIzcL13Dp
         tIAQel3FJl4vWn1I1U1HlALghrJshPKIIzcmc9RmavizuiUPn8LWGMloq+NlGpPsPvS0
         I3kEmsEoRAzNQycHsNXN5qFB4TBMIMhmw77ctsJoHKanErOuX8JxZNxmgzIm1EdwNvZu
         8mApcvqlSo90bFCmYJCdz+y0EFIbBoSY58REpaD64HFtKdq/8N3fLCbXzjGplPJrmuUe
         LaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788846596; x=1789451396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3F8xNc6JnbnOhSUa3MmC6YFjLwngFDOoggPy4Vs2zK4=;
        b=WceUK75ykUGSIRohB0pqDEWsSCjtujEFRrkEOqCSa/zP9sa43pFoCzwWgtgdsejoy4
         5EtxP077otm9m6VqsQK9j6j14y9/6AxG1qWBXMPsQQ5ndCmVBxMBGJdDkSL5K1SRgjJJ
         UxrTQOP3oSQ2PL47aeJTq6VN5QFIHwOLgr4H9TRilfWms9wPVFxUroaT3Qc88D9MQpEF
         51/ZUWrBwEaRyURZdNT2DJOIS2FjPY4Q92PNQyEgZ3bXigYNv6SfrYdkHXczW048NHlj
         E+z7orDhMY3VAKjGnsPUFywSGfkkDRhP6U46f92GTxfR7bC3kcvhhaEoBH8bm84KWp+o
         sd0A==
X-Forwarded-Encrypted: i=1; AKwUvBziw6YQKZEGjG09pSMNjylySnSAmSJgBCAGWPN/gRHZoN4+k6UjTQdj9fj/wtAjj1NfCDZxKSooNi8B1Q8=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nrV8diBlO4jorqmFYiKN818aEvcbdezj2FWnQwpqWFQY+Mxjwz
	aegEAnNCf+GGwbvg19BR+0bL2N83CfFOFczXEx8rvyKbThi9Jo+GbAhD
X-Gm-Gg: AYBFou1U7HZdmsK8FYFmgziO0UKRqYIFILHgWCyruYx5l5TjprXtkCYRw0TXGlVH7Fj
	kVFQzCP8bviX8vdp+L6dUVbU7PuEhU6CwKRBl/JphGsHGhHUBgzTpWRxUEhHbq/nw4dughPE8qI
	ajnUCRxEDrN2H1zXSker2yvn0jmXfy8nEcpBh/U3LA3n7kAPGd4BSnA+YzZ4r/3SmUilfYsphMR
	msjGVzhpPrH9/p3i0oNG/hVAnTDphU/6D1uIgnwBjqySMWnmchGwQAeq512TcW9Qftoz3YnhCXM
	3JuGB++fZViIkJYqN9NfMrZhI4xWau6TcRpUPrD72jSaOKBo7hEcoZc/rBou4U71q5Q/a/zoYNI
	krSEv4OxnJXt4SBVOr7rtrb07A23aox/nhrZqN4Sp1Ndk75bvsP5YQyHPPZx343YPrLkNuTt2y8
	Lb69yFh4MRFGkUO2c+1cg79+p1iYnuxXQzfMeRjyd2MivCVsXPtWGDfzIB/IbHDf26g6vMWx9tI
	AGd7cmcs9U5djiNFR/J5YFk
X-Received: by 2002:a17:90b:2e4b:b0:398:a145:5d3d with SMTP id 98e67ed59e1d1-39b26151b89mr41589578a91.6.1788846595925;
        Mon, 07 Sep 2026 22:49:55 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-334fbd5e6f6sm25690109eec.23.2026.09.07.22.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 22:49:55 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 6/7] libbpf: Fix typos in comments
Date: Tue,  8 Sep 2026 11:18:52 +0530
Message-ID: <20260908054853.13820-7-hemanth.selam@gmail.com>
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

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

The subject changed since v1, from "tools/lib: fix typos in comments":
both files are under tools/lib/bpf/, where the prevailing form is
"libbpf: Fix ...".

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 tools/lib/bpf/btf.c  | 4 ++--
 tools/lib/bpf/usdt.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index c783359977b4..d1c73113e58f 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -3847,7 +3847,7 @@ static int btf_dedup_remap_types(struct btf_dedup *d);
  * types, in general, can form graphs containing cycles, not just DAGs.
  *
  * While algorithm does deduplication, it also merges and resolves type
- * information (unless disabled throught `struct btf_opts`), whenever possible.
+ * information (unless disabled through `struct btf_opts`), whenever possible.
  * E.g., in the example above with two compilation units having partial type
  * information for structs `A` and `B`, the output of algorithm will emit
  * a single copy of each BTF type that describes structs `A`, `B`, and `S`
@@ -5648,7 +5648,7 @@ static int btf_dedup_resolve_fwds(struct btf_dedup *d)
  *
  * After we established for each type its corresponding canonical representative
  * type, we now can eliminate types that are not canonical and leave only
- * canonical ones layed out sequentially in memory by copying them over
+ * canonical ones laid out sequentially in memory by copying them over
  * duplicates. During compaction btf_dedup->hypot_map array is reused to store
  * a map from original type ID to a new compacted type ID, which will be used
  * during next phase to "fix up" type IDs, referenced from struct/union and
diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index ee9d1b614883..67c60f716c1a 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -144,7 +144,7 @@
  * about. This state has to be maintained per-BPF object and coordinate
  * between different USDT attachments within the same BPF object.
  *
- * Spec ID is the key in spec BPF map, value is the actual USDT spec layed out
+ * Spec ID is the key in spec BPF map, value is the actual USDT spec laid out
  * as struct usdt_spec. Each invocation of BPF program at runtime needs to
  * know its associated spec ID. It gets it either through BPF cookie, which
  * libbpf sets to spec ID during attach time, or, if kernel is too old to
-- 
2.48.1


