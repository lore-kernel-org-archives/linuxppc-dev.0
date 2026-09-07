Return-Path: <linuxppc-dev+bounces-26668-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF578C79FA0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 12:01:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdlzK4TKDz2yvv;
	Mon, 07 Sep 2026 22:01:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::c32"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788782493;
	cv=none; b=QhMDRWhIFb8PtEGqAyrOS8wEXtX9ath/PmKROEJQNRWNqBjYrd0JmH3hfz+t0XNLlHtK03crVe56yEZI8o7jQ+aTrAEN5clcx0MPKF6vl8c/7G8kCgR2xmRVWgcVwt2BflgELgfIytvL5IG3wqQDOtwAUqR7zocFIwwV39rwSGqIUwKDSWzks5nQWMQQjtQYJtUZNzTcQAy6orAN7U8LHFmV7IoXmznqHxNd2Ghr5EXB6YQiGi7kxWCl1h7bSMkl3SPFFTrnEyDNbZapG7xvp6WkBXb0H3MOvRr5w8yck0YtomwHYzS2D3gssCFygBfxP/LkYawp6JMat0bDAxAmjg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788782493; c=relaxed/relaxed;
	bh=rfDPZXNcg+Nl7/Ylu6hp6siIi0FsvzwquJx1kpnnIKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=by0gfFjT2a2Qw2YC2LT0rjW7IEeTuL+ySWGtX2Ym5dMZZ/ojrYSyPNl1LqpRntjRbpi8qYvFGLktYxa7mj/P+PNpvLqDLTo77VwFebwSB43d9Wlc9seRH9/Bw1L4I1FbUK+e39Uhzm8WipEMLYtPXxELWe1X8Bi0vnzNuQLcOTr1OwL+l85CZ+a9u69wydHDNbqqliQuzC1elYNmwKOL/7a+k8BIJ2uwbTqByXiyiQeiJFvYV0EPQ3JWKNaPl/zx5DEwcQNRja9stG0qRha57C2BPSMR50zxSLpzvEPL/ohhS+a0d1f5F/dpqzpXU1KxDIIt4azfyOCLFE7iaSnYlQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ExDdnXRM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::c32; helo=mail-oo1-xc32.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ExDdnXRM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::c32; helo=mail-oo1-xc32.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdlzJ5pZRz308k
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 22:01:32 +1000 (AEST)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-6b0496f4bbcso2109132eaf.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 05:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788782491; x=1789387291; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rfDPZXNcg+Nl7/Ylu6hp6siIi0FsvzwquJx1kpnnIKw=;
        b=ExDdnXRMeSu6e7aEaXDGEVnT/4j0E1jAKrQTHzF/BnnOnqwzqesSR3PAUp6GelG/A5
         nc3yMwHrzAVN3KUig80W36181ZVky1D2IJPIQ6zjmZQdgUZ/kQg1tD52xjtERyKd+GAR
         gNnFrVZMdoAvsbXxmgAIc5AhY74LLLw3Y4kyS+xvltrt/w2U9BptIocgNZD2swoo/YgF
         c0kF3HFn3hf+GFQXZEaTIu1vWmqS3sAXTvGdUM9OylZytdxUKuGTbW+I5LaDGD9crW+Y
         AhILdnFhQHgyruTrUzFLD1QFJhJbl2jHRRZRpYtwFQZ23XT1Y2u/SzjPCIkgs3mDYnGb
         ljAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788782491; x=1789387291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rfDPZXNcg+Nl7/Ylu6hp6siIi0FsvzwquJx1kpnnIKw=;
        b=fUplvNS/6p3lg0kLwqGTMT853yLJFlplkIRa3kW27DTQR6TmdmYBSHOpFRFNcu/DOd
         jrO1beHN3BGxRk9kU/j9WRyir/R5z887TK3cXA2Qa5lP1xIv/sZ2W2eGNVEcjXVpRuBt
         x1twEXejh4LVxIlZ6IzowN96/u8kOVhmWmSI0oO+/n3aj6OXDHYUX63dEZF+Pj51FkHH
         gNN6Kpp6BS8A+D9vFSEkfJVI/jO0b/GuDNPtFI5z1OLbGIuEkGDML41RshRDDAxrh2wi
         VGJYtm3UpPq+idCS9fIPTix3yRKMB9SZHfB0UyQvXvq3M29bPOqTNB6Bfjcd/7KihbQ1
         uoAQ==
X-Forwarded-Encrypted: i=1; AKwUvBwMZ1gkLh/nDUUxLIgmhF8R6SKA3NKlt+/CXRh8yzv1wGPpWJvxGFY2UdzbkRBr3JQtiuAeztSiYSTZt+E=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kfCT0NYQq/ZXOpbP4LlCgO3z3BYWzEAxx/W6OPBdfMJfT3IHFS
	3csm5SL5sz0KDIWQ8ljHfbEOQ4H5gvy7hjZejsQz3+wEeNFly4nrCIlf
X-Gm-Gg: AYBFou31WVNJ3tr42QdHts587vhJVOCieBhuj5O36oS+2vvFd8yDBkv9CgxnoAalELC
	GFeEeJWy0R+SvZz0LhaAZJVqK1c3swurXgOroj6iITeLrENpTR+sB8A5gQVVsMEqwZ3tji+Sl2f
	je8iawrMdm5tvEfToPV9POwp/2o16o56Ci12R5NSzmAeypv2dD1dC87nfxKBm5CzbanfZAC8BRz
	MOBJjbAJv3uMH5A0ToBecuMF8zO7JEoV6QTap5ZxYAnJhMVf5O7ek8jwjAcnJB7/XH9KJ2p5foV
	JPu8oFC2rzXzVyFLY1N0Fe9PM4jinTOwt3wTHoXgzTZN8jw4dzwkkGc7DDmvRysGnenaaE3uP+1
	vpDiCtzQDngFUieLSPJ21rm01g/iH2wm8Y1jO/avZUwoEmUvqKZ4MYan0Huo92xIrDY9feWYYF9
	nxAcP98cvOnYTRgAlF+wCVzbPQGrZnld59mLiwHCGpOTwmY48CyroNQ/CBIYsSPG4HgxTqCXNIb
	xLQxJ0wBiYm/w==
X-Received: by 2002:a05:6820:6ae7:b0:6aa:d13c:a709 with SMTP id 006d021491bc7-6b6fe2aeaf0mr12073907eaf.31.1788782490438;
        Mon, 07 Sep 2026 05:01:30 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885ca07sm31244462eec.1.2026.09.07.05.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 05:01:30 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 4/7] selftests/bpf: fix typos in comments
Date: Mon,  7 Sep 2026 17:30:40 +0530
Message-ID: <20260907120043.36894-5-hemanth.selam@gmail.com>
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


