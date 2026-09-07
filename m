Return-Path: <linuxppc-dev+bounces-26667-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6107C79F89
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 12:01:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdlzG3Pnhz2ywN;
	Mon, 07 Sep 2026 22:01:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:4860:4864:20::2d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788782490;
	cv=none; b=kiv/kMDGkqh+D507mStKidJCNiJCQ1c26DaZAtWdhYBVLvC+zzkqQs5cdaZg5wRuIXwlmH0F7TLKaAlKo33qFKUNbgrAJMFmr/oYdeNVM+giEaBYKjHrDIQxeSSbJaHxgv5uWduICSOYMGrcR3nDG/xMXiZB1dEeER2oI8VkH0hCfmhC/nA7BIbzfPh7zPpFx0yO7bSWRAX2DAWTPEHi2xMjBR1nVvqAzrr6Lun7c9d5YeEvvQqcnp205xbQWN4Hj43Cyn1B7tQRNKeFl4DiPTjdeRqUfS+fs1n1NmINzLRsdS2LuPq57a/t+qX3cxqNs7bwG9bp+vtzR8QJ1F8xAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788782490; c=relaxed/relaxed;
	bh=gH9gg1qvejjX/sPdW+X7GvG6xfgdjVwQ/p+bz1yISpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yiv9Z6oPabuxySsUp3ac7pr7XrVqdoz/oGtHjPN/Hnwieqa533MDw6mvcF/JWF0R/7PBH1gQvywEg2hErcTzc561YZbNm7dDOrsslPVW8+ibDgn9erLoglmSjqxkYHS0q1zxGNxZgtzu+7cTQP2FOgmx8h1iLUl6Ug9Cv4UU0QCNe81AKrJuXDdyxVw/JaLVEkLEy06QBYHfytkF8XvMowXhormYglfu34yC4Lj7Dv6k7DBJAs64P21yAwQs3ZnP91G5ohgdCXMYqqdN4LuTI4UEAOmO/IpT0ih2Men78ITEuSUyjY7dCPydXw3pnM3Dde8ccrBJU56vGqvof3B6qA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Yrsp8/ut; dkim-atps=neutral; spf=pass (client-ip=2001:4860:4864:20::2d; helo=mail-oa1-x2d.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Yrsp8/ut;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2001:4860:4864:20::2d; helo=mail-oa1-x2d.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdlzF4fw3z2yvv
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 22:01:29 +1000 (AEST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-465cfc7e33dso2019814fac.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 05:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788782482; x=1789387282; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gH9gg1qvejjX/sPdW+X7GvG6xfgdjVwQ/p+bz1yISpM=;
        b=Yrsp8/utD7PuN/l4V2ZzgRDJ59PX5AYC6EIzLYftTGAVFST4BEof6Zoc8k4hz1R2uZ
         Tz4SE/yu0q4VlhwV5YtHbE2Zno5GLdkw8IygulOwuBabDR5YH1F5CGLWCHRRpwnDkP6O
         oN4GLZ+lF+dKdZt80ULTxaPPuUoIVJ/v0YjuICieFTytkNGi/rEd+0DdP2fLpAo//Zv/
         NQOBnqXOl8reiNWfdXo9LgbysW+kDpGhzfwMR7K7PdGYVXLNksJiojnG5ZsmKiMv5j0r
         NDwgDclEmClIdCmJXxIJsBkqzBspRhWhFDhd4qwgr05LhHCUXM345r26LL5HCN+sv/Yp
         nYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788782482; x=1789387282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gH9gg1qvejjX/sPdW+X7GvG6xfgdjVwQ/p+bz1yISpM=;
        b=qyxjQS+lFfpyPMmuZYQAt0EesHBqhzTEyLPaqdm0hwwSO1WocvaauPRuwLL3CMc53F
         7LGOHj8WFr59DvLnZTULLQtAaWKKYOBNGSCLd89dbvt7Jsep82/O9fI43GhuE7gY0+iT
         aNQIn1418wxS6zke/fIuOINgbIZ4xpi9l4BvNjvzYPhq5THpq85LujZ4R0WXGg86YRU7
         s7l1SkRwLxwuxeUv4fOIsmjAG6reJTvTMnc/ywsjx/gXkrOquyIV0ieXWIMQdVOF1Q2q
         t5Rubc6G0pusLhlikiO3pvVyYfHc0FsBjKNeuifySMKNt5NHlqT5O7YkDtBNdhr8GVuW
         RYmA==
X-Forwarded-Encrypted: i=1; AKwUvByU1F35JZqobGD5QHOLKTXMN3H9CWE0Vl70+C/oyuX1ZfEvxyu2ioKDcv0hKoPgmRa2+vrZDbeNPqJMQfU=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kf4/DVmVW/MYjN7/NRWDImhVbkpRGCAu7INk++F/CBuQqcQU9s
	4M17L/rlGm/jGpwRbvqc8XUxXgROpph1oQWUxaZ0SGIWZH34fd1OAGQp
X-Gm-Gg: AYBFou0m1NCa3duq54RnpYY1YZ76u3Zs7VSgFLBsiIrlT79z4STQWPiLSj32TSy639T
	mbaoxnNk4+FjGrGptfB8doxKraXb6Li4vm4dsmHwygTkPFMBUo63xSKe2HZFrd4y7b7iUVNIFMQ
	31oHoFP+GLge3fAGLy6e7Ve1rFEeM7MCq5uGVrLv588C4QnX3NUDJ3J9kYdGLoqCpYPA1lhUzsO
	9vm4q794kzt9xsY5EVd93Nf3YecVGHXH7WBbqXXKHTaQFvkUKNqGoWApFi4XFq71yU0FZ27GAiQ
	6bOKxPTxk7XNcP3uLwdY6913s06S3n/EihzzBrhO1JbqyNQI1ccxhHJFzPJrCACwt81ri+EOX+3
	UghuzoKZuDN9nsawYdYSWqc00Y6gGJWgKR7b7nt8oG/bkq3Ewtk3n9hS+SaKhcN7X73F5qIS4oL
	Rz8hiPiHe2m6ccg6UjrbNbeeMQi/G0i3MJx4dXtW9q4XqzpwNb/YfishOnH8zJiPmfKwvUTNNvv
	FoYGDT7ljEOxw==
X-Received: by 2002:a05:6820:a0e:b0:6b6:d425:53f3 with SMTP id 006d021491bc7-6b6fddbd240mr13817787eaf.33.1788782481883;
        Mon, 07 Sep 2026 05:01:21 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885ca07sm31244462eec.1.2026.09.07.05.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 05:01:21 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 3/7] powerpc: net: fix typo "upto" in comments
Date: Mon,  7 Sep 2026 17:30:39 +0530
Message-ID: <20260907120043.36894-4-hemanth.selam@gmail.com>
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

Correct "upto" to "up to", reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 arch/powerpc/net/bpf_jit_comp32.c | 2 +-
 arch/powerpc/net/bpf_jit_comp64.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index bfdc50740da8..cf8c1b49da25 100644
--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -23,7 +23,7 @@
  *
  *		[	prev sp		] <-------------
  *		[   nv gpr save area	] 16 * 4	|
- * fp (r31) -->	[   ebpf stack space	] upto 512	|
+ * fp (r31) -->	[   ebpf stack space	] up to 512	|
  *		[     frame header	] 16		|
  * sp (r1) --->	[    stack pointer	] --------------
  */
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index fc9db691e820..8a1a00026c69 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -23,7 +23,7 @@
  * Stack layout with frame:
  * Layout when setting up our own stack frame.
  * Note: r1 at bottom, component offsets positive wrt r1.
- * Ensure the top half (upto local_tmp_var) stays consistent
+ * Ensure the top half (up to local_tmp_var) stays consistent
  * with our redzone usage.
  *
  * tail_call_info - stores tailcall count value in main program's
@@ -35,7 +35,7 @@
  *		[   nv gpr save area	] (6 * 8)	|
  *		[ addl. nv gpr save area] (12 * 8)	| <--- exception boundary/callback program
  *		[    local_tmp_var	] 24		|
- * fp (r31) -->	[   ebpf stack space	] upto 512	|
+ * fp (r31) -->	[   ebpf stack space	] up to 512	|
  *		[     frame header	] 32/112	|
  * sp (r1) --->	[    stack pointer	] --------------
  *
-- 
2.48.1


