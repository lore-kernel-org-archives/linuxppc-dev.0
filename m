Return-Path: <linuxppc-dev+bounces-26665-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A98C79FA0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 12:01:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdlyp5qTkz2yxk;
	Mon, 07 Sep 2026 22:01:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788782466;
	cv=none; b=NdVwrWoTCMFTyKDeAKx5vA9uhXP7NuU1PyNpJL/3ufK18fBUOi2lFwn8KA6DweRW4SBqHBnq0FWz+J4PMf/hW/texrBwX1XbRWbqg93drOdFcKUbRffkwHBEZhMvYyPPHoqyG5GLafQizgqLzlWGIUcm8ngYFd1JzoWbGSuM4RxRmfKB2Lc/6uXusxo6ek5Q9gX9kjZLk2ssGhtDGsfjYeSm/76qvKlsvJVAxFVTAGd/64WajnSJFvxt5T6mp6vB3Fca8/hXWPDR8cXAFH2FQbQx+F/hKAoqriNachnbn2Fe6n6nkVqK0BNqK/kU+9wAO14EiHTsPf0IC9SKMvwwTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788782466; c=relaxed/relaxed;
	bh=CjnURsU06dXJhEmQk8UgpVeNwhEKlwAdFOshlqNlRoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L5QRQKApo1OgdS27c4f7KqBvH6t+1Fn1Kmg9e459x2jWL2AntcAMPADU1mvFz2Q/Ql8E+XZybacJbsP6q9zbvCsydXo5kZOZOYhwrAlssyiWTPYHQVhq5GZi4yB/OpTbFD2s6OVjNkqj6PClaX+moQL/iwa9DTjx60Ih7L0MMcMaNOmMz82YOyh7CTANgB9KKTuLUhTxYXOY9yRNavTF5R+P/c1iQ4WnGgyJVpYjbDbpFvnQk+t4kBgUDqTz21lgyeS+rnIVBotMbGTPyK/9eKAbeGhzbc8FUiAD8nNNvHddoZQLMCFXFAqzxNxBBxemdrQKM89Zd/DHWg64qSVP/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lpYCH09m; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lpYCH09m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdlyn64N8z2ygK
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 22:01:05 +1000 (AEST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-398b3c37877so3151595a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 05:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788782463; x=1789387263; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CjnURsU06dXJhEmQk8UgpVeNwhEKlwAdFOshlqNlRoY=;
        b=lpYCH09mt6QORcn3kFAX35uf5aMkpBCx1WIRgoENVFwOns7FTK9AXI1/lyDyZwLyKK
         7QryaklEELzBMpULIqsxipws9x2vl06On5V2wRRGGJVpM1b4Py7VYTKKc/vK/gVsHdfb
         D2uTSCOKogyn2Ye21zJwEglDfSUOAv0xtbQsjxENQGMDkl/DMpEvh3e+u7kRVc01DNsx
         i+a7jDrwGhrb+cyiEyLnxrBNEgQoXm3sFRMRtCCMdPDOqZQVR0VEEDzTjQuEAaJJ1Zhk
         oNnp1bDSOymdDtDb+TdzTkmHT/Sl8r3OrM6s1YvKxcNYOQunOpFa04TCLL2tVhTj54ap
         c8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788782463; x=1789387263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CjnURsU06dXJhEmQk8UgpVeNwhEKlwAdFOshlqNlRoY=;
        b=OC1Mc+x6ZbqNJwODP+vUyqXImEcxJ3RhjkOAfzuVxxJ+13Lpsjuvu1LdfJMlhWxVmT
         geHtATf4HL1tmo4w3pRHcSiq/Z8oSmNSQoY/QWoBuJ+xWi+W22khONjkyjgJJMhA9mnh
         ew7aegbvwwPXV0su0o/Q078PPgUku7cAjkdsUShBhKREIuMUdP6seNoECYpkA8TGlf71
         ZM3EPjW5WAoqJf4CpJOoCWqGN02rlaEztYOGtLK1ktX5H6rw33I27VmefDCT4rK5e1+r
         L0XPZhggsT+fL/Hplvuutb+giiqhRH2CWgWzVHeQVlL49MeIRWqiATTU/KOjMb/P007u
         8Wkw==
X-Forwarded-Encrypted: i=1; AKwUvBwc2N3CEQM1MGkLdrUa/PQ7kKQ6oDA3cb4UXJRU6/65teJlu+1ZFH+y3VuKnjoci2NDB0SSHvA8jWvSdfw=@lists.ozlabs.org
X-Gm-Message-State: AFuF++klWZ50VzwU5D3cXYYQLjha+/0knJ31YKTfTC/ShujJ0Ga42I6f
	jJjyCXk0I4zLfETBti8cM8ZQZZm1jJSIOe3+VrXJe5aK9Ofi4schcImQ
X-Gm-Gg: AYBFou0KXYr/BtLCHo8F3JiTb8C08Uy+TbEN68CtPnz4jr0EagBuyJcTdGKJbXCG2wa
	V7I2dzovdCPElhpTB5d9QYFaBgxXipWft0GicZPJGp9nsI9hRuOT6a/OcVAo4cUFJncaRFvXm6b
	gIYdZc0ANabFLXPcJBIInXAk4hJg5BhFZPOHefsZPLN7/eZ9wBmFn/CCjKt0BBgMvN7gssIJsj7
	ok9hhkQa82xmnJNBCpLdgaQYDRlG9s3XWOIgPHmEP3SjqTDikSsBr0QKqTftfEcNN8roLMs02ZM
	37aaXJQU7ifbqg/fXvS70cqSEzVuEVYkFxYDI8qYCZ6LdeDQKSttqKwbscIPGG4T2RkCVNfhcey
	gODYMTyDxIj40qnJiDvjRLrSN/HBWFAEtubmKc5hOYPwovAwKGI4EOtwMH04VwJ62ApaLAJGvoO
	zNXTWv2z9gqnMi+JytcWRiGKT0qauMAJluqmAmBYUqgEAIm9+0elsHkgU1c2QyzJ2digvIuRm20
	HUmx0dd2/4Sdg==
X-Received: by 2002:a17:90b:3c48:b0:398:e436:384 with SMTP id 98e67ed59e1d1-39b260d335dmr35003952a91.1.1788782463059;
        Mon, 07 Sep 2026 05:01:03 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885ca07sm31244462eec.1.2026.09.07.05.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 05:01:02 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 1/7] ARM: net: fix typo "arithmatic" in comment
Date: Mon,  7 Sep 2026 17:30:37 +0530
Message-ID: <20260907120043.36894-2-hemanth.selam@gmail.com>
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


