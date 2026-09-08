Return-Path: <linuxppc-dev+bounces-26719-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D37C79F9E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 05:49:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfCgp1FL9z2yps;
	Tue, 08 Sep 2026 15:49:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788846582;
	cv=none; b=k79wAIzLBRdVAZDodfeeabHeGH3V/4J3RdlQvOrgc2Y6yZoKbHxnw9yVdVt4q3oEbHg8e9jfQDsahJq1z+EkgSN2ib8D8OCu27/j22mBsYr08+dk2khY4CtcQPR1BX4YiQY4y98GJuGHKy59MplhM/5FSQQgq5SE5mPZ2UXp/ewWZ72fVf3KNOuzCHVb5udhszfXoqVFjRTmXKBq9N1JLo8HHbTVTSayQF4X13jk6rBn3QT+/zaDrJ/zQSXo9ySK+PTt4FYZVyoQZw+r5ol0kUhfFWmrXoJlL83a3iaxuvOJKQuZNUXUkw+lbpio4Oci8rUsd3IfS3Pm44GyzOf68Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788846582; c=relaxed/relaxed;
	bh=rfDPZXNcg+Nl7/Ylu6hp6siIi0FsvzwquJx1kpnnIKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+OIs1v8VyVuf5t/DMJ881vJwdE8ZZKdkolVPOxD1a1FN56gNvFVhDIX03IZYzouk6vYv8Zd6wGzwtTXxS+wwdUpFHD/dXkosJtWCnCprAZJI1U+tQzjzqxiWtecCoXOz85AVy0sGuvF6PmRP7WETUEA2KPHhxCdLOhNUahb0ZDnkgxe44U8EV+h9uqeAimiqeHnpw7fB88k1K1qqhGVtvehtGhQyRqj3XDCBqa5yYyWf1E4mLW1Rem3/QiZleciQlK0Inhiu+cAigVLQksRjcNilez28ZHTBu+VbN/izjQ+dacd3bvO0gjciRClS6rP1K6ZMbHyC17t+ihIqvFvyQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dpQZ2RQl; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dpQZ2RQl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfCgn2MZnz2xqp
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 15:49:41 +1000 (AEST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-8568e3ecfc3so2811494b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 22:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788846579; x=1789451379; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rfDPZXNcg+Nl7/Ylu6hp6siIi0FsvzwquJx1kpnnIKw=;
        b=dpQZ2RQlndRkl3t0LFssqhmXfVQ4Vfbj3eNdQFa5DyTzOcCbQADNhXYT3fi3A4V6RT
         SxHpS2sfcxq7KdEPCMSqCeYbcbcCiv+5JniKy93VT+G6KA0ZayfSvxoLAH+0RCViupmV
         mDo72DREhvmHdR9sGezsmjwB3648RfzrNYgd08hdGx5vpeCbcl4aFic+CWX6fRwMvLxf
         aeWsMw0c1MlVVlGMNR3SykVLYrVJsTTWU7/297M+80JKo/vlDtR5Gxmtnd4BHf7GP0Yq
         FT2+ohmqzO2kffsGdVpUjI63YDIsfhWKmqvPe65/5Z2cjErPb7cIbEsdzVvU1imPQavI
         CT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788846579; x=1789451379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rfDPZXNcg+Nl7/Ylu6hp6siIi0FsvzwquJx1kpnnIKw=;
        b=cQvsIchH/JEzmj/ejT+MYHKqXsjMapXGO/4BgYbtHbcMDN48k4qHxBh02+JdrXXn2n
         svIcgCSZshrU6A8bH0DhXgr/I61QMZoK5Hvo2sN4u8vH7KMay0BRb7cYn6rtF08wZ/n6
         pt8PIzGrzHaVxbX6oR8QjKs/8lh234xmT0/CMODKiMmWEssrx8jYLSN+N5TIjqX8ZfZ3
         pUathsyQxpbU5aFoD6xo1REYKRLtlMTbNVHoOvjY3J+hmsTLwfvg2SuISK6fsKLtSxn3
         BDFouMZRaMgVy1ue02vAI/hJbBDTsLR7R/kEQNt0HAQF4G8y4bXfc+JbAaibyMIXnp3x
         6zRA==
X-Forwarded-Encrypted: i=1; AKwUvByndLeKUmRZQfUuiRHbprFH/9T0HcqcsfFaV2/XLADnyz1Dx8ylvga7RtdDnfQpap8w6yOoVmGXL33CX2c=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nuZDhHb1tkYfJcgfUZmnNDC0bQc37y7ZbffhxeTzwLsAKvqL7y
	uX/Xzv1sSHh52hMp/iXMoFyZTyIrwAzV8G6CJMF5tIPcttDxL5ED6I+/
X-Gm-Gg: AYBFou2QeZkwnTLCi0XJBQO7sO6g+p1/X5kfvhJr3rAtD7BOS8JjXvxbD1O4ptDv0iE
	/bz5yFYEbZmq7XPnZg72JY0r16tUeg0cJsifEDt14ulzOMLHj0HNToOq2WImqCsWFFdciSYFJBU
	Kzcc+swjWmHSvhFg8HLbud6aUlPDl+OkzDMXKYCE3e0HzlyQUv3KrT76R5Of2xcg16K1BWWYqk/
	IUw56kJEbVyptGtXttfmsQq2VoLOT7uAuSvwwFilJo0WEDXQ2OKJEzncC+jnemXPK7BAQRoVqba
	0ZrpeeAExLoiQBT8jlEzJwiTJJ5ramIaoc0ZKz4hJIo+u1L+qS3J0LF0LRPxEnojfRakUrmo/nX
	yeIZg4QkQItkpjUBGHh+Hf7Olc/Y3chLW0fq3WYiouJoSh+e98NFIomBOkjp2V+iiQbqjOe1twN
	qTlOHjqEjDZPR9oBTC6WG8IaloPjqJiQpObmYJJ2lVvm/Fud1Du3HsynvfYMKoO7joFCAh5ae1o
	h6SolCOv82tOA==
X-Received: by 2002:a05:6a21:7748:b0:3da:6bdd:2c74 with SMTP id adf61e73a8af0-3da6bdd6cfcmr22673394637.10.1788846578979;
        Mon, 07 Sep 2026 22:49:38 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-334fbd5e6f6sm25690109eec.23.2026.09.07.22.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 22:49:38 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 4/7] selftests/bpf: fix typos in comments
Date: Tue,  8 Sep 2026 11:18:50 +0530
Message-ID: <20260908054853.13820-5-hemanth.selam@gmail.com>
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

The subject prefix changed since v1, from "selftests: bpf:" to
"selftests/bpf:", to match the rest of the history in this directory.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/lwt_seg6local.c       | 2 +-
 tools/testing/selftests/bpf/prog_tests/task_local_data.h     | 2 +-
 tools/testing/selftests/bpf/progs/freplace_unreliable_prog.c | 2 +-
 tools/testing/selftests/bpf/progs/verifier_var_off.c         | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_seg6local.c b/tools/testing/selftests/bpf/prog_tests/lwt_seg6local.c
index 1b25d5c5f8fb..8b96fb861368 100644
--- a/tools/testing/selftests/bpf/prog_tests/lwt_seg6local.c
+++ b/tools/testing/selftests/bpf/prog_tests/lwt_seg6local.c
@@ -13,7 +13,7 @@
  * IPv6 header with a Segment Routing Header, with segments :
  *	fd00::1 -> fd00::2 -> fd00::3 -> fd00::4
  *
- * 3 fd00::/16 IPv6 addresses are binded to seg6local End.BPF actions :
+ * 3 fd00::/16 IPv6 addresses are bound to seg6local End.BPF actions :
  * - fd00::1 : add a TLV, change the flags and apply a End.X action to fc42::1
  * - fd00::2 : remove the TLV, change the flags, add a tag
  * - fd00::3 : apply an End.T action to fd00::4, through routing table 117
diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
index 8ae4fb2027f7..9f2971fc7cd5 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_data.h
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
@@ -243,7 +243,7 @@ static tld_key_t __tld_create_key(const char *name, size_t size, bool dyn_data)
 		}
 
 		/*
-		 * TLD_DEFINE_KEY() is given memory upto a page while at most
+		 * TLD_DEFINE_KEY() is given memory up to a page while at most
 		 * TLD_DYN_DATA_SIZE is allocated for tld_create_key()
 		 */
 		if (dyn_data) {
diff --git a/tools/testing/selftests/bpf/progs/freplace_unreliable_prog.c b/tools/testing/selftests/bpf/progs/freplace_unreliable_prog.c
index 624078abf3de..d7e30ee576c9 100644
--- a/tools/testing/selftests/bpf/progs/freplace_unreliable_prog.c
+++ b/tools/testing/selftests/bpf/progs/freplace_unreliable_prog.c
@@ -7,7 +7,7 @@
 
 SEC("freplace/btf_unreliable_kprobe")
 /* context type is what BPF verifier expects for kprobe context, but target
- * program has `stuct whatever *ctx` argument, so freplace operation will be
+ * program has `struct whatever *ctx` argument, so freplace operation will be
  * rejected with the following message:
  *
  * arg0 replace_btf_unreliable_kprobe(struct pt_regs *) doesn't match btf_unreliable_kprobe(struct whatever *)
diff --git a/tools/testing/selftests/bpf/progs/verifier_var_off.c b/tools/testing/selftests/bpf/progs/verifier_var_off.c
index a63e33675091..227dea0da3a0 100644
--- a/tools/testing/selftests/bpf/progs/verifier_var_off.c
+++ b/tools/testing/selftests/bpf/progs/verifier_var_off.c
@@ -225,7 +225,7 @@ __naked void stack_write_priv_vs_unpriv(void)
 }
 
 /* Similar to the previous test, but this time also perform a read from the
- * address written to with a variable offet. The read is allowed, showing that,
+ * address written to with a variable offset. The read is allowed, showing that,
  * after a variable-offset write, a privileged program can read the slots that
  * were in the range of that write (even if the verifier doesn't actually know if
  * the slot being read was really written to or not.
-- 
2.48.1


