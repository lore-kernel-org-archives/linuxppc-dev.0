Return-Path: <linuxppc-dev+bounces-26642-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 056B9C79F89
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 04:52:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdZSS23Hhz2yxG;
	Mon, 07 Sep 2026 14:52:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::529"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788756760;
	cv=none; b=gBG/C3kSEdFCtMcGZ9upvGCOlsj15SFT4AOWQbpZCc2KDgIEAOoDo5IlcqvFN4nuzPmEARKMgPJ4F2nSDpm3/r7cEVbXrcZfLUzDJcgfmkS8FzGEZKcF7arzbV6fv8wdV32Isx5RbnIBintGF//45Qcedw1i0snUB3wZNasICjYtCw+5ZHOf1EQLR1zlP6dG8dpGWf5uOXsGd5k0LUMhv2+DYsYDyXiBAUH4DX76PSS1eJnT/HcdlsqgFlOJalADq1MTYrL9N2vyp93+ecEOeiQEOyNxAiEVv3yr2sngnObWCU1aaSXdCiOAkjYYLP3R6zr6WePu3GayY0pDJ6xHuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788756760; c=relaxed/relaxed;
	bh=Fv/8WAsrrZD9Z6WoNFeiwDVhsb+FhzzkoAYrTP/tCf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b1/VcshTA/qL6HUfsT3RtIpoTQEKrVfEccn2aT4SoqlIPK8JifyOymr84hEP8ZHXdJAWI4lyq9bbTKRAZJan0LmRAdq0GYBrto8e1l7mJwTRNTg1/vjwdfQAf7nJjnfOYwlU/ci1zDyfAoV9AXYVtWpb0utVPr28L0o0LZ98t0ncP6prVHS4215gFeR6cBPaL/eV3fmUt7mPhqGOCPNLrMpwN7hO444tpddQp1SPfDaq5STabjO+CSuuveQyAbiH6HygEDv6u4o49wUvgNe0JTWa1vb545q+MYvg209XDbyGnHxPsNznRgu4EY9SIMF+ncYRpYjycJNfrJDWqCpXMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cF7WonAe; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cF7WonAe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdZSR4C96z2ywN
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 14:52:39 +1000 (AEST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-cc1cb472b76so2495258a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Sep 2026 21:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788756757; x=1789361557; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fv/8WAsrrZD9Z6WoNFeiwDVhsb+FhzzkoAYrTP/tCf8=;
        b=cF7WonAeMJYY4p4HG0xVyS9MIHgy7HzuKTjjSH6okbh26FRbD2pa0j0AKFhlS8fIcJ
         jakSqQAiRFIc/diupGxXKCG5UTXuC8qk/asjWy/Kddz6mEMjQMb9K9dbj8OY9GfpvVBb
         nn8s3yfQd8ueRLDWEMts2c0UFDi2OmrhRk0fyjJlwRayjdh37yz+eQ0N5U8aBgqEDBKc
         Zz5OEtr3zwNCwqurIPVLwb1BCYvDNZH6l4qmiIkbbOmtGtsQ/X0EdVijTfciSsDJBw8W
         9APpRvA2Lib4UVUqRu118YYzTMR0Ja1qssLGq2jsNtwrZr76EqK71IWcR0BnHRR/s/5i
         A0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788756757; x=1789361557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fv/8WAsrrZD9Z6WoNFeiwDVhsb+FhzzkoAYrTP/tCf8=;
        b=MZzw36le+dIZjGOaKjmX3fzjn1vZZKfHFDA34NdTvxt93SaqAwKxFcA6U5aELfZCBx
         PsE5jmMYclPhj6wT48G0rhWeFHd/jt7oTojoPvwV4vpiddMCYsFQN9NtmIvxquBv2EEH
         UV/hJ+mxmzPCZmE5oU4C+G9SxKmPXolnEHu9f01UeC4UHKHTwywQgU/txO4/UAma/t3w
         qCT5BFP92rIIEFFUXRQg34JJwp2J46mVZ++Ojgs/zSW6e2cN7fyvYT0f6zdJCGkLNNRx
         yxrOlI1fwExJk1DX+JaRv5G8kVEVwb5xrG5jxD71mdkI5i+4gsXxtVnXqV9D3S4bwLQa
         Wgvg==
X-Forwarded-Encrypted: i=1; AKwUvBx+xJ8SFbg9ShJRzLTayAB4VW9ydSjBZ2PJyTp8bgwSa4AY0j3SAqmqhaZEu5NkrzBTpKfSnoOTBdFeCcE=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mscrreh4HDQCwoJj18hFRl3zzRaYMvowQIKb6tA+uCkvDJ6eQC
	7vJStOB/gJ5+unScyDGoankNvEtOMysAxXf9CTxkjH9CtO1ARUZR+3uW
X-Gm-Gg: AYBFou3AlLnYDnrnSRDtgPFEP+qiBXixybTDMlJykUYqJOuqywUMZ2A0f86PU6JW128
	SwRvgXeVX9ZxWJHLZy5Je8AZozeVMC6ocjLsjfFvmbGhorRuz2t4znvFVTKsVvQekD8Q3eccaHi
	vUtiJBF3PfeSE4JKi52rTYHhif8Ug/w8Bb//2qN2nonO5oBPNAf2YSkRqBgVcta6ihvzsyXF86S
	sKISZqsVoRCfkSAFKzpfq6geZkrce9BEEXiNO01uBdY5X1u/onDCG1YNBa1+wPRduOR3L118aAy
	60P7KSIpt4YaVA4/QsmjJmEDnaHkjq1+WVT3CZJysFzO+DNVtaGcUHTpQITozdphKOks/yYU0cj
	jZLx6/jhBFPasCq6hSbFMRbsEv4bpwI0lcnoAXD12+kcEiWBCvtlgqqH3XMML/b6xOl695MwibH
	WiAkUDwy8hYgh5YCnH3xQjcPbGU+2Xc/9HoML5XAJRmTDK182HmVlhaAU5/qnoZaPIuwbI9gyu1
	oNn+O3B3pta8w==
X-Received: by 2002:a05:6a20:72a6:b0:3d1:e510:905f with SMTP id adf61e73a8af0-3da39b3a6b3mr28486268637.1.1788756757103;
        Sun, 06 Sep 2026 21:52:37 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324410092sm21979675c88.14.2026.09.06.21.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 21:52:36 -0700 (PDT)
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
Subject: [PATCH v2 6/7] libbpf: Fix typos in comments
Date: Mon,  7 Sep 2026 10:21:34 +0530
Message-ID: <20260907045135.13317-7-hemanth.selam@gmail.com>
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
index 8417de92d028..c1745bee37c0 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -3843,7 +3843,7 @@ static int btf_dedup_remap_types(struct btf_dedup *d);
  * types, in general, can form graphs containing cycles, not just DAGs.
  *
  * While algorithm does deduplication, it also merges and resolves type
- * information (unless disabled throught `struct btf_opts`), whenever possible.
+ * information (unless disabled through `struct btf_opts`), whenever possible.
  * E.g., in the example above with two compilation units having partial type
  * information for structs `A` and `B`, the output of algorithm will emit
  * a single copy of each BTF type that describes structs `A`, `B`, and `S`
@@ -5644,7 +5644,7 @@ static int btf_dedup_resolve_fwds(struct btf_dedup *d)
  *
  * After we established for each type its corresponding canonical representative
  * type, we now can eliminate types that are not canonical and leave only
- * canonical ones layed out sequentially in memory by copying them over
+ * canonical ones laid out sequentially in memory by copying them over
  * duplicates. During compaction btf_dedup->hypot_map array is reused to store
  * a map from original type ID to a new compacted type ID, which will be used
  * during next phase to "fix up" type IDs, referenced from struct/union and
diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index 2e56e3ab5b6c..c0933580930b 100644
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

