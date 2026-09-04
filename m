Return-Path: <linuxppc-dev+bounces-26598-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C90C624DB
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Sep 2026 06:18:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hcNST6Gh0z2yvR;
	Sat, 05 Sep 2026 16:18:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788551503;
	cv=none; b=jE4AYMRzNWmVKAwjmOCPOf7poTWSgLi9DIuK3oUmgAsmaHOlAhQwGc0J0qZh2EqRdhhZqh8hGOc916T1oBn0bbXjcBuX01PfatVN7v52uOgz1tMzBPq+oMMwnO4RTu88HpmMDHIENNdR6iAQBZyxUxBeLv52n4nfHcAIxFUJPD/NSzWTadCSgTrbWbkJ1hxAtNaroBFyYbnSHy3xab3tgIDydL/RrZZnSB3vT8Jtv6h2IbDX5vffkeCr0NqEQsSUa+4K5ucesmfvfE8tVGMBmfCZkhVOA4oAlSnS5phamlXY7TWDd8UWwuDtoT6guHrTu9RqFl+k2EOqHA5CcGRKWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788551503; c=relaxed/relaxed;
	bh=sQVUWoA7x45iUD9G/BjlX2mTaB7Twjm1Fp1QyKVPw8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJZPprXjedISkKXueviEwtEWP3g3zWkhdmMu+GzCwEtjp2GrZk0Sd7RgbBscHZ66/mdGW+Xk7ahR34K1/tS//u/7Xl10/eGFHaEtgblSgjTLXaPlodfdPN7NJQc0AWVXRtHfeTKXJTzTj3/r/0ZpzJjJuf4q3vroVASYm2/HNaK3xahQtJ/fRg2oyEET81iZpJu6aXjxueQTRuPZwEeoYlVrZv251H3dqszE5mU8ONuMQ1nU6GMjaXHHks7DglVrTelFocVDvpmDXjwXdCqXCU4l0009ATRINasHKrK4rfyRqjd3emuBwSkRFr8q5ld65t2Cbl52cVsZT5+nHcRzdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sk/p6ad8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=sidchintamaneni@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sk/p6ad8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=sidchintamaneni@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hc6Y96rNRz2yrd
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Sep 2026 05:51:41 +1000 (AEST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso1393157b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 12:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788551500; x=1789156300; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sQVUWoA7x45iUD9G/BjlX2mTaB7Twjm1Fp1QyKVPw8I=;
        b=sk/p6ad8AdWYuH2EPYZ11ozJ0gvUNTvhdUAoM4bp2Hisb84za0MUY9I5xNb+MEarEy
         Qz6krJ2gY2tg6ZrDAjI9SIHn87o2cj4RrGMnbto8zlYuTpMeng+d3IlvJafnpx+tIaQB
         zvyKMHxQqRMpHpArxTyWOTEu2mJNkvWiv+j+dVQDEhlol00OX4vAbcEPuIby2Slvl5fR
         4ej1nrUrF5lcVLOSLabvFQRVCIBiqiM7cA9AmHoFePvnSRm8sTSD7s0omLNe8fOBmHVM
         VSUjOCmsCwsQT+rQDTv/kQk1CsWfrsnL7HYmnlREjb3Qhxc/cA8CHLM8Tz7fYlfFvwzr
         k9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788551500; x=1789156300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sQVUWoA7x45iUD9G/BjlX2mTaB7Twjm1Fp1QyKVPw8I=;
        b=G9A7g2/KrH8B967taGu2p0bAP9YpkyxYZDIBoNfbqr3KLkDJVzDVmgcxyuK1fpV7Yi
         6DHV3mcc/XvmmTEPpmj3BXQkt5iYNdzl5adPVsMif0K+yrZnh46AmkwQpXTpURNUntmS
         wnCmzvrYNkXkBunpKlz0o8dPFsCXeWbvy9R4Eeml8L28VMKwM/Ups9v/JprC4JPydo/x
         eMvsCWBFs0c89QwM6M2kwrKrlbIc/ZKU7CnTUqfmdFbtUSEcNSR+gb40+K5xICqPEn8f
         D7KntUK4ukXzSDeTBYf/b8CJYUse+f0rpmLthiXlHBj37qM+skw0qx7YBUpw1oKwCOc3
         GZgQ==
X-Forwarded-Encrypted: i=1; AKwUvBzUePYdubx98/2TWccfkuwx8M7rX6/FAGfhXwJ364lvSYg0YsaqGggnWfEQSQvYEGBFk5Lp4mSW3jSoMwY=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mja2V/+N51ZgvdcljwlJFElUKeZhy750jgoWN3XLX88Z/WWL4z
	r5XrNe2TFD4H4g1tm4AjsTRL6PTeH9jnPFLInv+l9GIOvzJTNtBpDTlcTmbdGQ==
X-Gm-Gg: AYBFou1mcN/yFBVyAIFCRiM7xtgJB72pcKI25APZ9Dsk6+TrxP1oQa/aRkA3ZgXaKOY
	CmbX1Gv5hfra5Q7BrHGzRXGjZvmOUSlApz7qfrrpI6NImw99yAJd1yVPi8RTX2rZCqKTtCD1c5I
	5WJ4H5W/Alkj459UWYH9iNsxQYzwWjVkDuJHOWvi1x+9SoPhGxlaNOFUATukC8P6bNn6h7zZxMP
	Y5/M/h0pT8VYCoHQR/pHRCM+brAmM6812U7WiFu1oScMoR/VZA/9JhHmlUAv/fW2hTVuLBJs+L0
	TAowUGEHFwWZ/7WNzAluYKicMIhwDZMrSx0/BCbpRAvI+sAbMgeNaKvxfMvfWNPyofY60C7aqPP
	rqMmS0f5Z9vIt4y5hH4SyGfEzQgbY6YsHgcQjQPViYEZg2Kz6s1CmnRDqrXJofZifQbabPv+LWi
	GzjjjJ3am8YzK7G6S9WorBa0N8aKgQtE9B1T/31jT5gdsnnlEtpZEoWatBImNnSqugm+spnl9HO
	ip4OxM+ljY7ne70el81IAcEZv7SNmMaKBJnO2WOOCTY9Heo0APVrQ4jPBcY1xLL9xy/Lo8Kc8m0
	ImgO+R/JlOx80OBYn1dZ7xU2J7eZfHBdhwLcERCZAZmudiBC2Y19qIZ7TCx2ynKYS1d28fVWneo
	=
X-Received: by 2002:a05:6a00:159a:b0:84a:65e8:137e with SMTP id d2e1a72fcca58-85ffe1099ecmr11049338b3a.17.1788551499491;
        Fri, 04 Sep 2026 12:51:39 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8615404876fsm1497684b3a.59.2026.09.04.12.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 12:51:39 -0700 (PDT)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: bpf@vger.kernel.org
Cc: Siddharth Chintamaneni <sidchintamaneni@gmail.com>,
	Jeremy Jean <jeremy.jean@oss.cyber.gouv.fr>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	rlmenge@gmail.com,
	hargar@linux.microsoft.com,
	apais@microsoft.com
Subject: [PATCH bpf-next v1 4/7] bpf, powerpc64: Use resolved pointer for timed may_goto
Date: Fri,  4 Sep 2026 19:51:29 +0000
Message-ID: <20260904195132.141068-5-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904195132.141068-1-sidchintamaneni@gmail.com>
References: <20260904195132.141068-1-sidchintamaneni@gmail.com>
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

The timed may_goto fixup now passes the resolved counter pointer through
BPF_REG_AX instead of a stack offset.

Copy the pointer directly into the first argument register rather than
adding it to the BPF frame pointer again.

Fixes: b55b6b9ad76c ("powerpc64/bpf: Add powerpc64 JIT support for timed may_goto")
Reported-by: Jeremy Jean <jeremy.jean@oss.cyber.gouv.fr>
Link: https://lore.kernel.org/all/20260824213158.3755932-2-Jeremy.Jean@oss.cyber.gouv.fr/
Assisted-by: Copilot:gpt-5.6-sol
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 arch/powerpc/net/bpf_timed_may_goto.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/net/bpf_timed_may_goto.S b/arch/powerpc/net/bpf_timed_may_goto.S
index 84ecf6fa7f5d..d88825dd34fe 100644
--- a/arch/powerpc/net/bpf_timed_may_goto.S
+++ b/arch/powerpc/net/bpf_timed_may_goto.S
@@ -8,7 +8,7 @@
  * arch_bpf_timed_may_goto() trampoline for powerpc64
  *
  * Custom BPF convention (verifier/JIT):
- *	- input:  stack offset in BPF_REG_AX (r12)
+ *	- input:  count and timestamp pointer in BPF_REG_AX (r12)
  *	- output: updated count in BPF_REG_AX (r12)
  *
  * Call bpf_check_timed_may_goto(ptr) with normal powerpc64 ABI:
@@ -32,10 +32,10 @@ SYM_FUNC_START(arch_bpf_timed_may_goto)
 	std     r8, 72(r1)
 
 	/*
-	 * r3 = BPF_REG_FP + BPF_REG_AX
-	 * BPF_REG_FP is r31; BPF_REG_AX is r12 (stack offset in bytes).
+	 * BPF_REG_AX (r12) contains the count and timestamp pointer; pass it as
+	 * the first argument in r3.
 	 */
-	add     r3, r31, r12
+	mr      r3, r12
 	bl      CFUNC(bpf_check_timed_may_goto)
 
 	/* Put return value back into AX */
-- 
2.43.0

