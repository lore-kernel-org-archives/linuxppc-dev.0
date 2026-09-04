Return-Path: <linuxppc-dev+bounces-26595-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F2BC79F85
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Sep 2026 06:18:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hcNS34YW2z2xyk;
	Sat, 05 Sep 2026 16:18:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788551502;
	cv=none; b=lXDL4/Ud5xJXmBHNUCuR/wG/ju6sQCnD7GEp4yH/X7rCcyvd7/6TuI9yeRs3V9i40umaO9kzmDnbFlaUcgZ0mtw6Tb8+ciNA3bNYIDgu6UljoAUsyb/Bj/IQMDYvPR1ZBFA8D1igVetyEpWe6RyEVEGcxO6c1tc9rtwA+B7ZyUgO7Wp3o9KQaGwSJXQc53voaL4+FyZxIarzSMkjykFoyRD/zONt2yOszIaIa/Ctfbk4AViIMebKEzxK/CehihOY1OEOd7rkn/pfSRkqBwuTi6ogloHW5k1jvpfo5LQ2wGIXAmF+Hmk4EtcgFVoI3SgBllGVr3MSbXDW9vsWnlxm6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788551502; c=relaxed/relaxed;
	bh=fvrsiIV2Lldx5aqamYQifBQ5Wmg+CQWdeLatZB+qlSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HbCRGjwPGVjYjHk47o+L7xZiI6GBSBFRT7OJrAV05fCzUaJcqxMPcEwt+iQOPLSzSZdgV76HQl1hnVeTJgEVrwNvLnl1PKzUgzOAvqZ9xkMYsDire3M8/QlmViwIdeyTjzD8fIBnDNSxuyRvIwQl3R+Ch4huRTDOWXghFIlXq7llMVMwUkgDBNXdHPyah1+0k86iUj/tqTB/Xti+2UTKrwx+4KFEAoxx6Jueib6HvKwIOZUyQoIcMIiQxjHJ/bE+aZewGnpd4EeXvb/4k+WsWslBcKjrsWA0R9sndH+6u+NLEs44IS9iaNCa52iYdx9j20Hcgz5bUoGBBjDt61N4XA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RGiA4OGU; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=sidchintamaneni@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RGiA4OGU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=sidchintamaneni@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hc6Y859T2z2yrW
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Sep 2026 05:51:40 +1000 (AEST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-86265451beeso359383b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 12:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788551498; x=1789156298; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fvrsiIV2Lldx5aqamYQifBQ5Wmg+CQWdeLatZB+qlSs=;
        b=RGiA4OGUP7Ryy7fXy9iOkUb/y4qa7MN/AKXymRMr5E5uZyPwT7FDArnpgjrRag3AXs
         u4iQXxXZVYMSCkHTiNfIhngkvNiMbUXHUjPi633l8/ddJwXdDfb1z3vgzoMQkGY5r/1F
         wed9I4TZkT9QSjD8ry1xyuIi434Xwh9VLPcB2wNW4ffZAqeJ5tfTcPH3aSTQyXXz1fa9
         iN8olNg55ssyBAr5aBhPeR5mq04M75kfGqtJjNOXaZaGe4L7nIvsVjjeo0FZfWS7aRY/
         pg4PnrXUSaU8aS9tjmVFJ9ntfFx2ucGvbAekbcFdrufEtRQ7Mrc8+5Xg5qA2kZW2UcNj
         4PmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788551498; x=1789156298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fvrsiIV2Lldx5aqamYQifBQ5Wmg+CQWdeLatZB+qlSs=;
        b=JL5JxawEeMfUzrWJjfWo2+oYnoXvi6qkGBdJMtswwerHF+60OodSdtSZqr/oyHPZ8X
         Iivair0jNObqmKjut8jxPQncFqnhiMhDAiDBvqn3HroO4+45WLd25cvGhrn+Q2x8ouyz
         bluK2hwabJNP7tb0mrkpy8niP4mksa9Z1rHJlmayBAPxPljVYJ2HJCnGbLr2d0OWnNny
         j24TCU80d5pPfzaHpvq74ZGpvmBLgoFe/idmTxZvtsVnt1exIRixzf1EUQbJFmt1ZCN1
         P4FJgRwHrtwVMvFuWfdN9zLv1XPU1VgfWAKbWZIOXV7L+hxlfS/ULNM45VpjUSK7EF5v
         hc9Q==
X-Forwarded-Encrypted: i=1; AKwUvBzQ4ZpvwNZvrTrr4hjav9osDkPgxu648R/mwyh5CsTYF09ZwWfoxxoC/s7VXNGIhD01eMTrXAY+vCZ2+y4=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kJMa4iKaqaxWB8pHONDaOiosbrLcmptMPWvS+hjsPpmzyKQHxe
	wgMpXa6lXfv1PjbE2oebeeqbII+eDcOmxatlWJPmNvhX0NwQ6/46mO6f
X-Gm-Gg: AYBFou1yhFf4kVSQiQ1h15HcBpXS3imnheRXrfZ5eEbZfq3svk+rNsaKu6/CFTKqBWs
	kInDTmsCtDNf0uNJTFj6oAJoic2IpGEHalfFb6UBSrTvdwZu93vTZAbykhideqqOfRW/yS0R062
	3fglQo+bPVQI6F2BYBQOTy1vAJEk5f5QtNlYLx/IT4z3Z0noWAdL3fbJ+UKjAUlpFK90AiYjkrx
	f/BysE9gPpCIYXKBbv499QwtGcc465s8rQ3Nq7Yv7LIq2BnuSo/X79WcfYgmrE0n08DCfCQwD3s
	K0FLipnmkJHEmRZpYZR0MUnwxJbqqIk4UlgseTD6W5S8EIAyIrYYJIeVKnLu06V1LK6HWbaPQgr
	bIJGltAcFqy4wqBV6PGmPNGZWEbCAr98oe8WppAQ+VrhtQn6sgRvRtbkMwjPYQbBWxr3NVVu61u
	+A2OfgtVSpEoPtjEUvg2WnWMizPtREoLW4EMfde7qJa1kcE30osOrp2+pa9bnjGk+WnHplYuUeA
	ZeOmo1PWzkshYRIWvGf5AKf138I09VFL1xdh7cmYAu9NkG+638ZKHWD848a8E+fvAXvpgT/GdBE
	9Kx4Q+HPotgTafHxB+Hn5fgqhKMIR8+ZFsDtTmbZMeEsDeFjxoUQzwfjcuj7SVdJvSdRcagQEbU
	=
X-Received: by 2002:a05:6a00:1151:b0:85d:84a5:b7bb with SMTP id d2e1a72fcca58-86168d8c2fdmr11042192b3a.18.1788551498348;
        Fri, 04 Sep 2026 12:51:38 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8615404876fsm1497684b3a.59.2026.09.04.12.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 12:51:37 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 3/7] bpf, arm64: Use resolved pointer for timed may_goto
Date: Fri,  4 Sep 2026 19:51:28 +0000
Message-ID: <20260904195132.141068-4-sidchintamaneni@gmail.com>
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

Fixes: 16175375da36 ("bpf, arm64: Add JIT support for timed may_goto")
Reported-by: Jeremy Jean <jeremy.jean@oss.cyber.gouv.fr>
Link: https://lore.kernel.org/all/20260824213158.3755932-2-Jeremy.Jean@oss.cyber.gouv.fr/
Assisted-by: Copilot:gpt-5.6-sol
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 arch/arm64/net/bpf_timed_may_goto.S | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/net/bpf_timed_may_goto.S b/arch/arm64/net/bpf_timed_may_goto.S
index a9a802711a7f..53148c9a1c58 100644
--- a/arch/arm64/net/bpf_timed_may_goto.S
+++ b/arch/arm64/net/bpf_timed_may_goto.S
@@ -14,16 +14,10 @@ SYM_FUNC_START(arch_bpf_timed_may_goto)
 	stp	x3, x4, [sp, #48]
 
 	/*
-	 * Stack depth was passed in BPF_REG_AX (x9), add it to the BPF_FP
-	 * (x25) to get the pointer to count and timestamp and pass it as the
-	 * first argument in x0.
-	 *
-	 * Before generating the call to arch_bpf_timed_may_goto, the verifier
-	 * generates a load instruction using FP, i.e. REG_AX = *(u64 *)(FP -
-	 * stack_off_cnt), so BPF_REG_FP (x25) is always set up by the arm64
-	 * jit in this case.
+	 * BPF_REG_AX (x9) contains the count and timestamp pointer; pass it as
+	 * the first argument in x0.
 	 */
-	add	x0, x9, x25
+	mov	x0, x9
 	bl	bpf_check_timed_may_goto
 	/* BPF_REG_AX(x9) will be stored into count, so move return value to it. */
 	mov	x9, x0
-- 
2.43.0

