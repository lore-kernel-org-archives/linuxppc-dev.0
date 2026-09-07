Return-Path: <linuxppc-dev+bounces-26638-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31BF3C79F89
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 04:52:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdZRp2WJvz2yvX;
	Mon, 07 Sep 2026 14:52:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788756726;
	cv=none; b=DgK66LhAJQimm8Dl8xkp/Tbhe9IVjquslUbEAgC6coJzUxfJR7XeiJ+L0l4sepJKktfsm/bDLkBFgTgEPLAB7cERYa/BTBKzfO14i66c8XczZKd62hslSVPkRmvJZvQXHkSLwB5LyK8U9gcJa7l4bGzBmACxCCPbnQi2URrIjbaANV4h+YRUdd3r1/kZgpdUBx6mdpbOLUWQ/tg9L7vR7tu54AvxQdPIHlwvY9v9AKuH61pWUieiSQbzy/aHaCzebixEZW3rVA/negzRtsejMq1kYzZB1LYvs4VVkrgzZSxG8w6UVVWMd4zVUT9L1eZplCWv3iebEhp8y7w32YC+zA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788756726; c=relaxed/relaxed;
	bh=lk88M/pDZxe/5FAVj+dp68PIWOvqnCOJ0AD0p9smdgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a/XjTkAqmjg6XPJR4oeisnlVsjAJlvNZ1fO+eUMzOym/gOovTYL8W/sQMlxKiRYob26tCfNyvZhHfpHrznk4BiLaKkViRxWOi/hu8z05zcfePjACvFAAI5ii9VFX4Ywytyn2yDJokX41gR4awoRdnxKu0Ikr0ZMV1HA8Ym2WIQ58uryCPmiU5K0dX+iEROCduZS8f3tYtgPDFi4tcdXF4t7+KNJwYbQGmYYujh6wq0g9YihySvhG6ctdarDaushGxbGMlrcFaesOGYI2NYM0GOo6J4aKaL9Inj6mqRIt2ys5QRFqNuTzGfcffFr52kJ9RJH0pMCEubSnp6k/Ev8a8A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ap/t84Df; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ap/t84Df;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdZRn3qfqz2yjw
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 14:52:05 +1000 (AEST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-cc1bcdb3c4cso2040053a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Sep 2026 21:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788756723; x=1789361523; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lk88M/pDZxe/5FAVj+dp68PIWOvqnCOJ0AD0p9smdgE=;
        b=Ap/t84DfwXWbFUdLt1vdTG6xu8vrLXpS6bD2hzVc/Lb72CtwX2lnL/6Lj8c7PLf9Kk
         0qPHRCAvvEw69IiKHQef0G+bIaphhwS2Gs2O5SVR6iOBzKUGmZpFCrDboIVejXe1wfts
         8gm8dgr/kfExt9hHSTdb+/0cWg1MYjiKQj5YZWwiU0fymt6aOG0wPE4rQFPpw+LV+m9J
         CVmWVVXOYd9myG6hzVkRiefe7w3/m1DTRhWz7vwDGp3O3ZLXnjkKIlPF89EeoiVHYb3Z
         zcz5qr61qpx5/XnLQR5OHoPGE90fgOr6GKKbUyNj/WSKjdejvS3vAqwSfHU3bI/hSspd
         TkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788756723; x=1789361523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lk88M/pDZxe/5FAVj+dp68PIWOvqnCOJ0AD0p9smdgE=;
        b=scCS2u/YMKEl4lCWKR2Y+srIPHNI37R4w4yBAYy1OYVJrWyZFxqMViCfXRY/XBs7DA
         TGwDAFBjcJ3OMygbDuVWbRL9uYP7RK6vk4WEYHfJ1BUwB7TEtumLsq2G96LQAVd456GY
         gHyV7QYKTVwDthrel+MgYcgsioSdHlHsYZj0zQgIzo0k/y0IXeAmoEVgvBldL/n5RI16
         0Qp0nDggcTMI8qnAgN1xMs3Q8DOkPOzQvXyUvhZ8tJJR7HFDVD0PhAwXxDdHxyme/AnX
         1gsK7IfU6jLI9oBoMJCQeZi/qB1rMcKYkgCYyZp28YHRG79hAacQFMAwyRfEyPiZLF3T
         LW3Q==
X-Forwarded-Encrypted: i=1; AKwUvBwoFEDNLez7FTirWg6+GHBZ9PGS411T76zAw+57xHY3AJKh3OftYNPb+72RADI+XIQAU8mkhexv1xbPstc=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lWIiy22KUCITWzma4e49DXKP1SK4fKH+/tkCfy37PMUi8dqTO7
	PghAgtVdC07kHiybkkAIPEVH97hQQANqqjCDjR55T0WxljppAxTLwvdl
X-Gm-Gg: AYBFou1bUMvAC7EnS1JQkkihz4opSFCIS6qL25uNaQsXJuymi4B8PiPElPZuKf3/BXH
	5GhgNrJHRc55v40IlzR7QSrPo7ybbJTkpxpZ0mPKk12SBE1tR5ExEeNYbhD2w1E5o1VLxLVXCF5
	jx6yq4nTr8T+AzsvCESJ0QAMl3p1zuM/nfR3PI0FONAaMJneBZ+CIldq6dT6xdReDu0swCI5efu
	zAIHtp0nm2QNokSH/bJpio/cluD6DQ3h4zcIDp6lE6bcEM2fJo5oh5BAczzL1NJmXWM8FWtPA4+
	SxztyeOt8N6pNfGdMRdYaY0ZthlOSGq5SLm7emu00+VdPHKmp28ypolRX/WRQrBTZnBR4Nf09J+
	wH0+PEpJFvaOosuktAUceNncGwGdSNwl0k4028npErCW7Me4xqHGyhlbMxJwVkpponMFkArZ9Gl
	EELSmKL9v8UrlCY9Hey79johuwDvfTYckNTgcLBjU2bHcr75oSAE8tkPmjTb/3trZSghVXOv0Vy
	3SWfbfseYvmkg==
X-Received: by 2002:a17:90b:33c9:b0:398:c16e:69d3 with SMTP id 98e67ed59e1d1-39b26122fbamr28838386a91.1.1788756723030;
        Sun, 06 Sep 2026 21:52:03 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324410092sm21979675c88.14.2026.09.06.21.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 21:52:02 -0700 (PDT)
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
Subject: [PATCH v2 2/7] bpf: fix typos in comments
Date: Mon,  7 Sep 2026 10:21:30 +0530
Message-ID: <20260907045135.13317-3-hemanth.selam@gmail.com>
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

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 include/linux/filter.h       | 4 ++--
 kernel/bpf/reuseport_array.c | 2 +-
 kernel/bpf/stream.c          | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 4a9bc6a848f2..0a067c2e923d 100644
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
diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index be9ce98e9469..54f5be1289d2 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -24,7 +24,7 @@ static struct bpf_stream_elem *bpf_stream_elem_alloc(int len)
 	/*
 	 * Length denotes the amount of data to be written as part of stream element,
 	 * thus includes '\0' byte. We're capped by how much bpf_bprintf_buffers can
-	 * accomodate, therefore deny allocations that won't fit into them.
+	 * accommodate, therefore deny allocations that won't fit into them.
 	 */
 	if (len < 0 || len > max_len)
 		return NULL;

