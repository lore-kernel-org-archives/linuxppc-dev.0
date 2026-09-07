Return-Path: <linuxppc-dev+bounces-26666-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0EA0C79F89
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 12:01:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdlz10LVPz2yvj;
	Mon, 07 Sep 2026 22:01:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788782477;
	cv=none; b=eG5OZu+nQQcWDxL0/JM1tlfuDg/lJGxOBXFZK28MQrl8sG+4f/48bb+LW4gzQfdTazUrzwLRcGSlJQoE+Kcn5rWtDAhqmg9/w2cbuTxqNishFNm+14+Uzvg829uKbzZqXotq2e/qPuVdUhFdsrDe6SlrPkQtG2uAICsfMneG3zNMs84/3C2dWo1uc4Caen/fvVpr8AreQ+L7kqc+bPUAb4z24lDJz+Sx0+g6x70zt2ZD1qQ8vL86a6o5TzGOvMwe6z/Gfo6pYpU8QJZ/dhnT6grD3Y+/Ys/wNdW30EwchE0jaTCbdz3H2Mf/tAFtg5u+++lCDi0cQJy4za9YZDDcRA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788782477; c=relaxed/relaxed;
	bh=bC1WWh/xuFVa+YUjJaTnVEkwteG3jK4MlszJkiclU94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DvBbPvbKUN3OBoXZ0H7toa5iPHghqqSaSASnx9krU4U3Zu9x0k7pz5dZDbWtp0O5CwqJcUtMr4El3GqB2F08blIqTjEB+SgIs1Kyeez+ufIF/FeCohAYKGok6JU3mvve0vn3k9+ykKK4vJMUIBB+WEgg1Cvo9Fw1kYvKWwYSRqyH2UdgNoAZphsilJJnJpV0PBoOQcPjt56g2zWGHDOLYgEDfgaT08uU9JCBDNEG1+Q5rFL8RrQ8as7ra9xV71o98244lbh9FQhx+cJ/TK0Aj6Hipsc4e19juDTVrOZtgY9uJKJgkoh+Bvd+AnsG30We2d2aa8w6iO2g7sJZAiUCOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l72tQk/Q; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l72tQk/Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdlz01LD5z2yvv
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 22:01:16 +1000 (AEST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2db710396ffso294395ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 05:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788782474; x=1789387274; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bC1WWh/xuFVa+YUjJaTnVEkwteG3jK4MlszJkiclU94=;
        b=l72tQk/QURBCxrUsNBL/8aJzARmKJUkaMNrIr8zK3UIFf35SYAjkZlYsAjRNYRqwej
         NRwcEM4WFeYTm4OM/waD8HF1lEl3m/ih7Y/gOwSSU64ZeI1A5PGT8TFpHKVqEwfaO1C6
         5wFedAgiAgdxNvfttLI4m6feJsMCy2pc6JHdc04cpFnYTbpC5eEvMYB/sxb4ymRmCsLm
         YRyUxXKI+2n/YEWxHU7GVHaUoIWcsyGJQh9oEYXZr0HtZKSC3jCzl60gaivrWelgk+HG
         tXjfoBACOMl7Mi0K6ozNmDhMHuSYV8iP5OdIuGaeE+jOjTP4CFj40oR9b5l0GfMBO1eG
         SZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788782474; x=1789387274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bC1WWh/xuFVa+YUjJaTnVEkwteG3jK4MlszJkiclU94=;
        b=Qf2EPs4DHlcdaKWMbzwDZn+0FTdJkdKBqj1uedjqReVcuybp2adShhoaIg/iNWT7LM
         jMvOWdpq4v9kyGdHd+8PvKfBBfPdJP4ABbNKpwlM8D+Y71sniyMxHnWT60wFvuccGGJX
         8M4y48SNoH3bteF60ujP3mTYS/xtJQbO4GnMk/7SbCuEUpNTlEY2B0c26NdyxBGLMTHQ
         y/qZ4hj0Z/jhz2/cLL2AAenZt3cor7YovZTBtQC4wAYVNKFdITWhLixHVDkKhdZTpVqk
         aYW4ZvzKIcNlfYBs0CqYgfGNuAWFjiZHFoE6/OH1nNzcGJWssSfo4sZHo57cqTafX6Ce
         LvIw==
X-Forwarded-Encrypted: i=1; AKwUvBwTxdEkmuZi5yohQ/vauaWi3Cem07j9WJWtqetd7Js8WeemDJrMbBO42uGWQCRwZ2nlL8PtLNncm6sZwL0=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kST88PPNhhSvRuh8RCcqTdGPw0RkpNoWv0wv+O7YEyvJeWnpr7
	6vcsrnAjqdX3PAqXMPdv/pzySDl+uFO2sjGrL0K9zCybzDDqGq28GiOf
X-Gm-Gg: AYBFou2SVTOTSj1Rczeaj0+T0s9fRSL7ZVl7o1KsEshZ8W5uN9R12/FiMt47T/hhHlz
	+jBZxGEyV+DwZX9OwQjnxE1J1pQSnEtD1e79hl49f8pXuybo0eTBhZOaTfWTQ12VIQRwAjU5/Uc
	MEMeXV2f852WqvgZxF5MJfptVv/DYiG2XAV8ia3iMfr7E3Di4RN32ZGDGeU2DYmG02UlPYpbsEl
	XDNo2Sl8GC7G9zt+M5BO4WFhhKIbxU5cPot0AGjhZPFDQnDGaYu8J2lp+BUYC2iN55KtR9FcXgM
	01D6VLI0mXqa+7JONOPZn5F1SsxDAcmRZW2TuqL1dgzYpAAruscigt9XWDktF93JWJc6NbsxfMZ
	4n0M2Y/dt9f49S3yvBycGWv7ZL8rmpsZgE8nlf3IOZjoeBXH3POtHQ2HRyK5wc60fvxe1GkMi1e
	HDOJ+WVGzqWuEBl21SBpkITeYUJl0AEjkxEDiW26pqy3nrbFDM54+/Z5Xh1UMWPHjDa1097Lmkg
	vfIgcB3o/pohxQiS0naFSEv
X-Received: by 2002:a17:90b:5745:b0:396:669c:b5f6 with SMTP id 98e67ed59e1d1-39b0803accdmr31092584a91.12.1788782473281;
        Mon, 07 Sep 2026 05:01:13 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885ca07sm31244462eec.1.2026.09.07.05.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 05:01:11 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 2/7] bpf: fix typos in comments
Date: Mon,  7 Sep 2026 17:30:38 +0530
Message-ID: <20260907120043.36894-3-hemanth.selam@gmail.com>
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

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 include/linux/filter.h       | 4 ++--
 kernel/bpf/reuseport_array.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 00ad8b63aa47..4eff6e601b05 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -147,7 +147,7 @@ struct ctl_table_header;
 #define BPF_ALU32_IMM(OP, DST, IMM)				\
 	BPF_ALU32_IMM_OFF(OP, DST, IMM, 0)
 
-/* Endianess conversion, cpu_to_{l,b}e(), {l,b}e_to_cpu() */
+/* Endianness conversion, cpu_to_{l,b}e(), {l,b}e_to_cpu() */
 
 #define BPF_ENDIAN(TYPE, DST, LEN)				\
 	((struct bpf_insn) {					\
@@ -1029,7 +1029,7 @@ static inline u8 *bpf_skb_cb(const struct sk_buff *skb)
 	 *
 	 * In some socket filter cases, the cb unfortunately needs to be
 	 * saved/restored so that protocol specific skb->cb[] data won't
-	 * be lost. In any case, due to unpriviledged eBPF programs
+	 * be lost. In any case, due to unprivileged eBPF programs
 	 * attached to sockets, we need to clear the bpf_skb_cb() area
 	 * to not leak previous contents to user space.
 	 */
diff --git a/kernel/bpf/reuseport_array.c b/kernel/bpf/reuseport_array.c
index 49b8e5a0c6b4..4de08abfd94e 100644
--- a/kernel/bpf/reuseport_array.c
+++ b/kernel/bpf/reuseport_array.c
@@ -207,7 +207,7 @@ reuseport_array_update_check(const struct reuseport_array *array,
 		return -ENOTSUPP;
 
 	/*
-	 * sk must be hashed (i.e. listening in the TCP case or binded
+	 * sk must be hashed (i.e. listening in the TCP case or bound
 	 * in the UDP case) and
 	 * it must also be a SO_REUSEPORT sk (i.e. reuse cannot be NULL).
 	 *
-- 
2.48.1


