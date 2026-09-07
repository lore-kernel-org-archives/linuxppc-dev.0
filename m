Return-Path: <linuxppc-dev+bounces-26670-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9447C79F89
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 12:02:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdlzm1z5Mz2yxG;
	Mon, 07 Sep 2026 22:01:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788782516;
	cv=none; b=lnigqMNUO8MgDSwGYc2jM09l3ls8aR5emNFRFSKPqzQwFrjJIm7j3k1Pc8b1bPL0p6qN64Hk9D6T9B1Rrmue06ieTUmM+pefX5kWXSHq9yK3b1GNPSA+6sr9W0IpYdbGE7eMze1GzE/aoDUtaBu1JO5X+Z0QESQAHEg8oikHbAEMm1u0z6kMGOsoDSXlK+fMhLQTFS0i+6V3BtjjuZvukH60fH+/RHG1z0qmDyhkfcUia5qgZ78kfcoZq8CLEVEg/ccccor5UF5SYUWh+Wxh034OyPhSGIvA0bqVkEKX2mCZr+P/XbhGfWrx2Nppoe/HTMEYdJpW5F1lxAg0elu86A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788782516; c=relaxed/relaxed;
	bh=3F8xNc6JnbnOhSUa3MmC6YFjLwngFDOoggPy4Vs2zK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfrvrvlpJs9H52gB8pEi+LnRrjadOcvRSJkdmFFRMZK+c783GdxA+W9IerExX33A3QI7GVJAHSvNdCZR89EmZIlrYBjNp/7dHKmso2Do29FV0xD3vjCz1XtJPEER8BeUPHovPPtT0xXCGcANDB+FPgdn3Ua76vMv0F6h6Y+Cs6ugPM369OVfFlE3GroaGSWUGl3k8Z/OjUtlrgtApmoiTUBlkK0FB729UcOkVHfG1mnrT6eg/AqnYrJwvsZuI0UJ7dl9yok5LLGB8By2v1TuYwKUbx5A2ZJTy1J1z00WoPjzZhxyvxEqy8u9caENCe3fuilGXKniHbwTYtpet3T9zQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CL2tlFwf; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CL2tlFwf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdlzl4LJVz2ywR
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 22:01:55 +1000 (AEST)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-7f4ea388ba6so3323719a34.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 05:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788782513; x=1789387313; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3F8xNc6JnbnOhSUa3MmC6YFjLwngFDOoggPy4Vs2zK4=;
        b=CL2tlFwfH+MXSfxEPb+E0b2bEk258cKEzbdDwxFkTikWV4lpqe5ThECnY2Zk5aYOwn
         X2w9ZYDghXNFkKMeOfS/vXSdJjsE9SQ0rWyvcRhGbaRtmunrqWixiXqw41CeiIigJ2qs
         XDcsQwrft+dqvH4unX5KmW7IImcE96z9jRV5A4jspMp0fAkZ01L0+fxIguSgBlA3XpWH
         HAbw1a1fjj+pSLbV8atQJ0MoyHq5tMkNfIcCxNUfFZJ27ByhKVWLOJKk8APrRmWhbBhL
         djWxVgRFcOSJPyqIb2QYpzQ+XXl9qcmfmnQA20xLJCSmACL7NI3Fv0Jg6obKe6zy9nR9
         U6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788782513; x=1789387313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3F8xNc6JnbnOhSUa3MmC6YFjLwngFDOoggPy4Vs2zK4=;
        b=rz8LL67jRa9CuOX5KalzWTc70kME28tuuZGC2ZjHzWzwV3uWnOVl8YWMoZhQVTSlqY
         1v3Vh4HnDMJv1BaJLqWJ/4s5N4XV63IFQKyyW24wU6K5Axto4NTA/T7utG+dJCApUX6r
         tlERasjJiIEQbi/pBBomntWy+/jaBFqB/LpohQSD6uyTl9k36NhXY2kMI6SWw9gfeirD
         t9o8mYX++1xcqGupxJhiO5KBmyIiy6m6w42pTcfTXdf7xAaEjXVgRP4Omb9B9Vxa+9bJ
         ooSB+t6rqN1wOgThEyM5nT4wWtD/oEdrRwXdinsEumkaBZud2XPYWIwRnZPCyGNxHqWM
         uWaQ==
X-Forwarded-Encrypted: i=1; AKwUvBxU1Vcmjlp095VJEwXAMV0Dkh22Z/vMjM7LrMrKO+QnYbq7RrvOT9N7jkHL15KtW3XBsHKJ16tTc1EtpOg=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nZ5dLQN4gM9LF79G010OUlaGW2u4SgxhmY3L9cqc0rNuIYZTlV
	7gUgUzYVgD4gL7vm+5BexcY07ZFtWDCvGixqQ0cCHX/KvjVRH0WQYEls
X-Gm-Gg: AYBFou3mX1S+dmGRDCuJOI7aStrWcxLq4AfTc3ZYCwdVfEH1VY4lBU3CK9plyDzv7Zv
	jUAnCdKeuqIo0G9UDll/iEZq2EmJMF4JBfYO53+JSch/ZSLdqLsaJSsmJK1BVYOjb26jEyT0Mhp
	rwfYcoGWL2EEbwDpL1tf9OeStf5Rn224eCGoycy4dGJYYT6a4MPcu+nP1+mP/nKC/1mhf1t58eB
	HJpBDx84mrLtsJSf3esrcAI3Se/SCmB3WOICLtTx5cnDevKxogRC/u7BxjN9beHbVGeNOzP/7Ac
	EHmnCzY68YQifO1tkT0um+2g9Pi8nM0ANFsVMXHLa0czbbYoxH1ICq4Uww3F0hiz0qdaLcnps9D
	TX8xu99yAWQ4s+2Nawcf5hOonQ1v4GWLfJr36SCWzJrHmSoR1jlkkTIjt/ZtpZTDMxvcZPFNH9x
	KKCQnvxezR7AEB+eXn7f+/LIE/XcKVXxR21SP3mCUnBsexE7B/RMGcIBeUYqVYJ1Av8eAtcYeGa
	OHGTpezlMFzmQ==
X-Received: by 2002:a05:6830:4424:b0:7fa:5c49:5243 with SMTP id 46e09a7af769-7fa5c4954c8mr12694235a34.28.1788782507546;
        Mon, 07 Sep 2026 05:01:47 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885ca07sm31244462eec.1.2026.09.07.05.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 05:01:47 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 6/7] libbpf: Fix typos in comments
Date: Mon,  7 Sep 2026 17:30:42 +0530
Message-ID: <20260907120043.36894-7-hemanth.selam@gmail.com>
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


