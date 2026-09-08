Return-Path: <linuxppc-dev+bounces-26716-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054FFC79F99
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 05:49:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfCgJ23mqz2yqs;
	Tue, 08 Sep 2026 15:49:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788846556;
	cv=none; b=Z9JK0JJ6/VsH0yMKR78RGzRY0T9K0e0FY1QiJ0+R/w/2J2zmfMx9sqyRpJ6MRHyb43d276CybOjdzwbFuwyj8poT/NxLzUgoICXIDZjLvA17IbdUoy2QqnPNrd/izaOvP30e4KbfsQz2no3M0ipeJRyS+qCAlzco1gItFCMC/y6aUbEL2tUtv6GJgKnBPIUjFoXOOhoHNnbB/FxSLvPvz8wzirjQvbyhB/rQvDxh7opaWhBegjiFNhZePCSS5++UFq/eee+kzwGk0e5/GxYfquVnNx5SAYoEZEqhb9VnxX+QMY9z0+1NU8gp2fzO6bvtjP6QXYj+K4GDxZGKdXNrmw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788846556; c=relaxed/relaxed;
	bh=CjnURsU06dXJhEmQk8UgpVeNwhEKlwAdFOshlqNlRoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=edydCr/AGY21uUTWc+4aAGNauRzCIlLBG2BJm2gSMYk9AmRq9zpnKWq0H4SQiNONBc6MDc4/zD0xm2nFYyeK7ufvIWdD62VQk37mqB8JAFwoC93gYgz6vNpofY9Z8RVGq0ZWo4cQvD0aPDKVjh8sswyJBOFnyd8PZYnuQ4PEyVIbHzw932JfH90e+CfX48txNIu+Wx2yOlJ0eyJQN5qvJB1QX4W8v9R+76eduzwlBCzh8iqS39ZeGI79shcZN3RYJ10JNwQWnIUY3BXfdEm9G5c+kzYdvnMEax+dRNbS/jDx3DLPRaAqFiyJ7F+M37VombTrBJ/X9GnbZhaxzBEJWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E8DyLqt3; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E8DyLqt3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfCgH4PvWz2xqp
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 15:49:15 +1000 (AEST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-cc1c73645a1so3111758a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 22:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788846553; x=1789451353; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CjnURsU06dXJhEmQk8UgpVeNwhEKlwAdFOshlqNlRoY=;
        b=E8DyLqt3iBLRWfUQSHRqn6EJFDrJ5hJJBDz2AxjJ0biCYbxy/lHnao0cD0PyxG9ul9
         RhHbIujjyfJZnB8hR0IzHqY07hyz5pfKfziztzFk06vNI8OkiYYDT11PsyKMAstBDIj+
         lUHGTbowSYHzlLT2NmDKTnZuk1ltjT3S424aVt3N+zvhEqZ9mg0btfsmVaMteIRSAfMm
         iXnzwmEsUnJbDMWQYhSN7TckrltdsP16auOQYnrRSTY0s/U1MOj4OXMI90s7K+GHvVGE
         kqfl5Z5LHCdGhwvYr0hjIodwObprbms6KadxVkarJpwVzMFic9OlZflFr9QqOgGvvQ/V
         swqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788846553; x=1789451353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CjnURsU06dXJhEmQk8UgpVeNwhEKlwAdFOshlqNlRoY=;
        b=qnPjURgtkRwna2mNNJ1tMvXIikvNJoaPcDkNqCskfhTS2o+jUrHt+t+RzytpGcROPn
         vlAOuBJhneNyFfkzByrLx13fUmOC8CO5yJraNHQbhtsWz+oy1hWCWC9M2pezOOWMlgfT
         kSsMr8gnr58uu4qzvj354QDODRVLSLbxoHaHt9jmqRrITVd/5P3C309IKpoRt5CoHCZS
         S1oOGkWeDmX3OJJcVpaetJiNX4ADV+164dzjxWsaCyUGzpKl4fdsLtGEyu8mzcOIpZP4
         lTIeQ/D5a87f0eQqhyzWU7To5uE4/aZoqAQ5A0F4P/0P1sIgYitPoE0kvFnmE15Fc7Ib
         E6GQ==
X-Forwarded-Encrypted: i=1; AKwUvBwi20v4st24XV+7YJ7n2mgopXpjpH2/fto9804Q4lX2vQq8DWIjcVrSJ7dPgnlY0aerUxspXym1vMqMfDs=@lists.ozlabs.org
X-Gm-Message-State: AFuF++n6qQYQ2CA0rdK7cyL7P0spXPjf79+Ou/+dh349U+t6EnX45bHz
	7tB4Ag4JnuCDOJ8+wfxLSmQ5x6wZRReKay95+xK4W53Y91ZMJf5CgXNf
X-Gm-Gg: AYBFou0dPYWfGJ7mhRG7sg06cfZgUFktMdgFrwL2EqR0JIua4AaFRZjP52dHDOnXisn
	jD8S1CsFjuNikomCtmNT115z51SZVwhapKlKT5ATXRpSjIjQQRxPKfooRV7jNRCxYSCZe1/m04k
	c77xNi6QCSaeVzKTscCSXapVNGBgOCvAr9NM1rBxWvvXa61346SsWrjHKNg3Ikr3o4XYGzPFIx/
	R3UP98xKrIbuLxCFpRe5vqZXeE1MnKZhaiqJPprbDVfHSFcXFdXDek6VyU1wwUh19cYRJPvUV/c
	4qaRfADMnskTLxUYlwE3A+lc3SciOQozSQAwk9CbpkTZalFuLXUr4hojoId3IZG29lBQgSU9IZw
	Somp9+Q3cS37JUJ7tgP257wHqXFyB3yBseLPklHmL/ogyo833NwK9759kLTTRSwisa+Xc094ebO
	qU/u/tzjdNSDWjiwp6irDyd3kQUwp1mt8nWePgdof1teoDDN7mRu+cp5sFOoT3QHIRDxNu0iyM+
	3ksHOYPuvjdkA==
X-Received: by 2002:a05:6a21:38c:b0:3d3:ae1f:d7f8 with SMTP id adf61e73a8af0-3da3a0cc91cmr42894753637.24.1788846553447;
        Mon, 07 Sep 2026 22:49:13 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-334fbd5e6f6sm25690109eec.23.2026.09.07.22.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 22:49:13 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 1/7] ARM: net: fix typo "arithmatic" in comment
Date: Tue,  8 Sep 2026 11:18:47 +0530
Message-ID: <20260908054853.13820-2-hemanth.selam@gmail.com>
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
-- 
2.48.1


