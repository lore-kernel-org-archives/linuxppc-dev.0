Return-Path: <linuxppc-dev+bounces-26637-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A31C79F9E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 04:51:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdZRd72Cfz2yxN;
	Mon, 07 Sep 2026 14:51:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::435"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788756717;
	cv=none; b=XdoaajVPTBGEzIdxFT4RWIybX7cG8dOPRBvH7RUYA8k/M+YgT2qDyFHME7am2uTCBDgglWGkbGQfa2owaKaBHE35xVLga03qtErgJA4JLSEzVA7SXYHT2NrSyhv3fmdaW6+HyJdekBzes3a76rD/uP+axUn2fz2PAqimGFyR1WC4y3m/ciGUllCGH/WA6wpAIB0mTatmMG9J9b3x9/sCRgDzOUScEVqTcm1X84cbTnWxXheyGpzQ7Za3pCqjVep6M1p879osb1wo5WV54K8u7c0vt14GlINLWO75Y+3VZ9q/MloxH3hPgreEx85h8zlVTd/DYphMRoei6Lcra/HFYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788756717; c=relaxed/relaxed;
	bh=6ZDdWvx8nd79EclYwIbserkqXBmdMeyV10TLzPxe1TU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKa6ZdhA7KrY0UMU52VbbYriHTWdnOqwwaS87Pyzhd/k3jC2OTvhk/q7la5IK5aHrCWUtgNK050Qe5ZiYtWJf2Qo05m6hbnLDbDOZk6fwXzwijF13Ubz5WxO2DajNx6/FWfPvWandPxblloHE2Lkoew0lHyoZ+n//D9PdCFgA+Qgy0QEkEmXHy+1PqvLcI8Yd56eqpeVeQOtONOUhq+I+F5uux1hSlwCJ7IDEH9KqDBV/DEwTRtIB9V3z85ooxOlo/Pv9Y0zxvgjjHW/H9bxQGp05sMXgAIEW+wKJAku/5sPwg7Q7szrumL1zVJ3xx/DeelsC0s2KWfh3YJDmU2biw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CkV/p6yd; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CkV/p6yd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdZRd13XCz2yjw
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 14:51:56 +1000 (AEST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-853e2610bb4so2713157b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Sep 2026 21:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788756714; x=1789361514; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6ZDdWvx8nd79EclYwIbserkqXBmdMeyV10TLzPxe1TU=;
        b=CkV/p6ydRbOwMjxZxTRKtRAbd51TdWE8inmaGss+hROjTkG8Iy0uZWqD3v9vtZsBaO
         4pUFw3ipGyzhza9uWJKNmEIQ0WviipliiU/SxoWqx7KkOnbt06VHikaTV78nHFF9ffmS
         dOHFvd0OBptmvrEGkj6i1XQJY1rsjtp+4NjpDWFrmdxQNUDcycMyPABjYAzwgXl6nBOs
         qJcTqYwy7ioZyn87pgpx20T0zOAlaREagCKrz+Gu5ScI/nQ77UtrmNIk+KUdkowD+uyH
         nfxRQhvvBavmVM095qxm9neh0JwOmbon8ojfxnHwugjFg1gYaWl4l6RCANSz/9y3DTkk
         kLag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788756714; x=1789361514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6ZDdWvx8nd79EclYwIbserkqXBmdMeyV10TLzPxe1TU=;
        b=l8i7D8+b+eMipQHxOwllSCh2O9shUItkHrnQLBa0yjjdXPdL3D7TGR8RYXfVuU8fEX
         GxTjEAzo+onhCF6xO+QgTp3aTGmAK8s0NLy9T8lcl3XabMqXfjrPqdmN19bsJobgB1NQ
         TF6UC1FgxEJktoURgb6Ibitgx7px5DL/sad9tP6oUmI1kTd/LF0+rFbCS9W+wmGUEcKq
         HmgNnNIi6pyJHuh5eORW9o/LGdD89UvDjek3xyeWR7ij33FweQ/6Vi0z4a3isnvQTU9R
         oGq+nDUV1armrtGmXQavP1sJA9n1px8Zht+2ieZQ8Q3mZ55tSEPKHyJp6yPqsr+9xdq3
         4Mwg==
X-Forwarded-Encrypted: i=1; AKwUvBwxvWEnQ/NtXqZhKar+jHdKpArMH6ickyAEW2HggEg9AbJyeJI4KdOOacfJJqNW96W1uxlL/R1xwJtxUo4=@lists.ozlabs.org
X-Gm-Message-State: AFuF++l5usxwEn/sULlbgOEDkb9nrXuLkjKXyE48wzRZlIRtGlQmCed8
	HSypDiFzRXaspOpaKQAEbvBy7Em46T9/JgwB7Zz1AJnxzAbhYI8iNop3
X-Gm-Gg: AYBFou3ZMQYR/pFfHIUsV7blz8wkPJjVxLV0kvZlZ4cQp+NOh2AhgmDhMctBJEYDDkh
	NA0xbw2sn2T1/pUCTx3zE/139Bx25Ip1dJf3lcUkOKZQymNQX2BeXQVyJDja5NdkeBsZC1ZcIwZ
	dVlq5nykML0/Eap1ppvei2GTt8jXkJQvstyXppg2LzOJiQcYalIfOWsJcSTBo9lPbXFWPdQuouU
	bw9BSCC1PunjNXYO+jt1GPPm/MDfMwsse6FS2zJfmv6tlBUg5pSFOMp0IbdmuZGRzL8vr4qabOm
	H8SmK3sNlxJnqMuhuoAfjFW2tkulnpZ5Se9j5DExSaNDjROXz+aaXxudIrdAmUscFMc/VAnX58Q
	7Z7vq9yoNDCCQCcIahUAJdI9dqqyEKqprgpqyY07QmHyijfzhPbS+a0q/JvKMtyvWMa805O8T8z
	urixg5shN1wTigmudAqxBFet9L+YOae5l7qoonviJ0qHzz1dZ1pL5V60L/uMtxCIgR7k2zxKXYf
	bB4ofYAIDX4bA==
X-Received: by 2002:a05:6a21:e082:b0:3d3:aed2:6f21 with SMTP id adf61e73a8af0-3da2160e09fmr24886058637.21.1788756714529;
        Sun, 06 Sep 2026 21:51:54 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324410092sm21979675c88.14.2026.09.06.21.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 21:51:54 -0700 (PDT)
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
Subject: [PATCH v2 1/7] ARM: net: fix typo "arithmatic" in comment
Date: Mon,  7 Sep 2026 10:21:29 +0530
Message-ID: <20260907045135.13317-2-hemanth.selam@gmail.com>
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

Correct "arithmatic" to "Arithmetic", reported by scripts/checkpatch.pl
using the misspelling list in scripts/spelling.txt.  Only touches comments,
no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 arch/arm/net/bpf_jit_32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 9ede81afbc50..b1c21c014c9c 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -1346,7 +1346,7 @@ static inline void emit_ldsx_r(const s8 dst[], const s8 src,
 	arm_bpf_put_reg64(dst, rd, ctx);
 }
 
-/* Arithmatic Operation */
+/* Arithmetic Operation */
 static inline void emit_ar_r(const u8 rd, const u8 rt, const u8 rm,
 			     const u8 rn, struct jit_ctx *ctx, u8 op,
 			     bool is_jmp64) {

