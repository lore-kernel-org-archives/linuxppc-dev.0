Return-Path: <linuxppc-dev+bounces-26717-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88093C79F99
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 05:49:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfCgS6mq3z2yFK;
	Tue, 08 Sep 2026 15:49:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788846564;
	cv=none; b=bNSdRYFzCmCVPunAnvaULdA2Ja/k2DGL7KiUwk5mUcsyoTMXv7A0J3KNOCgyj/InN3qLfTt1sZIDWDo+O1O5cM++tUArAfh3rmgJIqvaVjpgW8Mvzl/yxCtNIAnFpfuseDlvdzUMVXxaWVUh41aLlCkAEeyukSm19oyjvIAlIN2j4Ezw75uS8ezzCPCUU+DhutJ5566OGWhCdCrcbhacjBxtQs+HO/5/7q0iMf6HvP+h1oJt5EdnugtBE3TZ1mr6PyaO1Ya8p4Vmxjsm8CjpiO1jKT3giCOjItNQQWZuf0nHacOrfyJU/PieQh59lCxZNYuU8tjWAeUYOGUHq89Aiw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788846564; c=relaxed/relaxed;
	bh=bC1WWh/xuFVa+YUjJaTnVEkwteG3jK4MlszJkiclU94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LNtjuWWnzNBaas7zwBBjHJA6nhU5DC6mZrZbWSnwkFmLMgN2b7VJE33kuWkAf80+KKS6+6/GnxiDMt1AHsiWY1et/kOA62cpdBTtShnJ40KzHsm/ZePHptY31LxALJWIlEoWIk0NUE+U5ycrEQ/GbSaDWxB/Dt74PH+c/dIl1MHb4e6cnvtgHYR4WTPSdUv/X1fr51nESxK8o25BKg8tyyK4pRF6UmFZ2ZdLlL1SdZDIE6b6/NmUZlRnfilVsJ6v/cbQQ2YvGzt2d9aXel1IHfMFKADu712QUa6YC3G0e0FoTp96ET6e6K9RERsLlh3bU0QIvYlkQKH553RLYrESfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VhMP1K7/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VhMP1K7/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfCgS1lDdz2xqp
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 15:49:24 +1000 (AEST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-c9d1fff21edso3362163a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 22:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788846562; x=1789451362; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bC1WWh/xuFVa+YUjJaTnVEkwteG3jK4MlszJkiclU94=;
        b=VhMP1K7/L3XKuWZdjQf539MSyhazuiUkWEk4YnrAgmiJXl0giUw/4536cz1uA8Q3lJ
         /Sv+RVcwIJ5E2eXQq+mojxlCw2iqsLT3l04sDH/HLiQz6EHBizcUmpZaHb3vKitn6mF6
         14MSoDdI1PT6F4U1jc/jLMeQizxHYqepE+FoSS63etWQrzWmBnLtEIgYkUbg0FocHtB0
         vrFbIO03x4Jcpcs5f6+vzvPKzMkhHdEAOvqPRZTTRgz3sLEweQk0CcRImLw3JhHswxWS
         13yZ2B7htvm+nJw3EZFyiBMCzU4MFReGdyXUsJbFVVaQo8u56Gmaxskzqe3sFc882lcN
         p2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788846562; x=1789451362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bC1WWh/xuFVa+YUjJaTnVEkwteG3jK4MlszJkiclU94=;
        b=KlyH4Jh74PhDlNFv2XtnZt5dH1sU8YzwN45yQ0zHbSMq3DkSVUfzB668NsjUxcG1Rg
         qU7jLApMtBCbjRTELgPHuWxwYMOgnJtyeo8Bp+iQvP3KB39TA23IvfCmI78aGNL4SUHc
         QPHB47j27k7HWgzGapLs56tHGPrVTjiEpO6ETHc+4Sx+4RQtxVKACGPU6nKpUX4P7fUn
         /1HSwqA1uKAI2S9iALj9hwnqMt9e4iyPS4htb/ZlwYf+iWqdi/mmtal/v/MTZe0Zf0lm
         3dBUojkJ0fR96hZPdZ4B8esESyp2jK0ZZt+h5cuwlD5Br1jvG7b/EcO2btM10BYC1uOC
         SyPA==
X-Forwarded-Encrypted: i=1; AKwUvByTTJUWTAH87LiNZ09E4jZKbgfJY56yB3qiS3rDQ7Y5GiWpUZjI7Qaw5/KB575Rx4n2R8BzZbVPT55QaGI=@lists.ozlabs.org
X-Gm-Message-State: AFuF++n9SWam+Gdhlgt21cuet0gf/qwPLGnHrj6HPXNR+MjX6Q751ALY
	dwnMngAdGuUUoH8O/eOodOWX6KfDEL2yQAAggz/kwPIy2JxGJ63fF0iI
X-Gm-Gg: AYBFou1NvrQgSNFs3llRXEuuJ65cZ0ZwyOzk8CEhJiq6kDOD3A5QDIG5SSGCEwUKPJD
	4mvwLCQpWJ/mZ2TwaqCHogROHHK/Ldq5RVWCk0G7AFW5YVf0IMvpvCh+2hwuCtgOABGi2u0N80R
	nuU35BRR6NbqtZavaL5SIOumpKxksInInxsFwzSXzEZTkcwUgug59uRk1iSSB85801DcshCiuGy
	COpgTl8k4aJ6LVfC8mbXF/wC/LZyK+fn30WErktog1zdoXPrApD0aT9tqMtr/X0M/zXXLjIj7Kh
	JwtiS2jdhSdJ6elVGCHuem4OgmWyG2bhyU8wNIN/+QzwcpTHAs+7doY+PTC6B7P0A1taWXddoSc
	y8Gl2xhdMylXYv8QP4j33UvFJeEnP2JLHLhJ0R/q4uHbxLKIXBb5mRcIiFTOfavhsEgynub/Zy0
	itmu0sYtR2739jfJ8SQZ4Z6Ns04Zx65qhSaVUGiTilJeeOoaW2WJmOI8DZVIvjgVpiVtKFiP8Qn
	VhhVnNI5M+TK9sXowGMNvYc
X-Received: by 2002:a05:6a20:4393:b0:3d3:af66:9f61 with SMTP id adf61e73a8af0-3da3a16b389mr43628321637.27.1788846561929;
        Mon, 07 Sep 2026 22:49:21 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-334fbd5e6f6sm25690109eec.23.2026.09.07.22.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 22:49:21 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 2/7] bpf: fix typos in comments
Date: Tue,  8 Sep 2026 11:18:48 +0530
Message-ID: <20260908054853.13820-3-hemanth.selam@gmail.com>
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


