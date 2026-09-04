Return-Path: <linuxppc-dev+bounces-26596-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E5FC624D6
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Sep 2026 06:18:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hcNSD5GKMz2yvC;
	Sat, 05 Sep 2026 16:18:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788551503;
	cv=none; b=ECSvxe9AZV1ff8GVlKc5fXwN+sTfqo2KkeMa2jpEo9LzmyXJXi2J8kifu9vMmytVCBoCHsGbXML/G+fAtc8GX9UBCgV40QDTksWyy1ibJN8x5Gr6V9ufsaoLe5tu52FoPQoaCRgEO4tWssZCnBcitBCY1QNYj2U4fWP6xrCjGRY0cXZlnkyanC9Pq+JPL8AM0Io0WcfFcr8208t7QUhrGsD7ZgmHmCAhCelOWYDu+T3DGqEkzNL2oAqD3y0v5/k5hQMbTC9anX5HyrQaIsD5vdblvNZYtkF8Y6UYdQcu+5tLEiwtnM3pW33bpp59/Ys9DzNZBp7jRJeZbvT7zt6luw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788551503; c=relaxed/relaxed;
	bh=+qDNedZBe5IOgOVXUT3YGJ7aNww3Lf+ZOsFiBHpPGIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K3SAs9f6S9MYJ68yP+FbWZEaQrGIKoLps8iOtje2h2XA23WQ3kL8j3TgLjVW6g/Tv+KkI2bwKy0flhkPnLBm/wppAkYg85nG/9z/WpHTfRTkI5R+MNIGDmV/5bDFdAvjs0O7xcBwr+m9ZloPvpA1GCzacnxnKbXW48CbGP6TJMOkcIi1kWrN3OzhyoDi5astcx3chgsONtA62Y+pLnCjvZWResh0YpXWNbpZjAdUxNn2EjUnKKOkl4Cp+yEhtHXG3Yw7kyBUV5Poye7/x4RWr8Rb9LqTYMdJvY+aEUROvGoCRE2mpOYZAGVYfOyihoz2QAMOS0qNrAom9PXVegulGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=b4EY80Gu; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=sidchintamaneni@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=b4EY80Gu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=sidchintamaneni@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hc6Y82NVmz2y2h
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Sep 2026 05:51:39 +1000 (AEST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-85377c8bc96so1278669b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 12:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788551497; x=1789156297; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+qDNedZBe5IOgOVXUT3YGJ7aNww3Lf+ZOsFiBHpPGIg=;
        b=b4EY80GuemvwCiY5hvc0T4gxozIdoLiSFzPdPmnmU8eCvMWnIvlUMPFbvVui1Noaav
         dWMinZC/zgeOOPVIEwpZG3QWgB9EbIw/Y++pImlLic7FNDMrwI0EcsdDmRcdCWynAZjJ
         mJf81X2viZ6O+DBQ1s8jQzK3cbWQ47xHKZ9w9GdVzFx+i5zF+26x9BQ7ZEnL+yCI59Ux
         O291rlkqm5CZOJEWZ5aG9IBd0k7nQg74FOs3nG8B6UZkVIL9T3YsK1JgT+zjJ88OSlhr
         K7LV5lK263EKhKnK6h7NB55nUvTwzORyc/ey2guAn43gkAwva0qIWcy799v9im4Clc26
         R0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788551497; x=1789156297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+qDNedZBe5IOgOVXUT3YGJ7aNww3Lf+ZOsFiBHpPGIg=;
        b=Vw5S5VT+GRSU2hNJI/JKU1xAfIIgu+9ZLmP2FMpzTo7+LMyGmEYEW7oHMV6NR8arbD
         Qgo53xu+49TAEmEiUlWbhdw1Yz0KeBmH5X2JzD3T3y7dr8oEcWCKo2GOTKF1UQnyFr/X
         +GQit64a6+36Do5EtV8ZyUDhdws3zU+4DSuwCpFE0yllnh5x6fn7iX+eBF4Lw09PCal4
         QfvKxfyEmhkef3NfkKBwAexVucNFLsGUn6sx7psWr4XQtc0oivdAEB0M6LfbJ7jyDhhd
         bVvYjDDuo2fgHtJekK6iRO4lfYZKl40OZ7xCXOmQgXIk0TpiA1aWhhyEbf0YJNZ3KMbi
         6NVQ==
X-Forwarded-Encrypted: i=1; AKwUvBzZZZw0PD0Z8L4aKFer4f1KxGDT7YpKkUBT5vBBB49ovwr28psK5gK3eog/WxsrgUEqjFrJ0m/TKwtt5H8=@lists.ozlabs.org
X-Gm-Message-State: AFuF++koAJi9oFQMQYStb6kbWXWt72wSUYFm1LS0gpeKOppT9zeqm0RY
	gmA5y+b/tN8cJTdjL41pKOpfxP/r/p+bvvREr+KGAxtar4/TuevuOm5Q
X-Gm-Gg: AYBFou0Ns72DR7pB+Jh/JPfm46Vj0uZnzsLmURwTQhYwijSc/iq+3PmIi7fDTyxQu1k
	BLxpmK6iVxjgjFtk5vUvjtAZhaODVNyCca5PtdPyvacbMdM6Cfkc6tDexLrX5Uk0lm5Io45ncFH
	L6NMLn/TC9uXdS0DUyVazjXcQWJNbMGvW0iX+nap29cCgp2tbPnZ9+vo+DGWi7VAef4Z/4DsJT5
	Ck51cYhHVOXnq8Of3CVpm5W1wepT+vIkflpcwNQiYV/wSLyfi0a0sCVX+qXjz6CQOx3apmDNJm6
	Q6X/+9Bvv5aa85MMJ8y59SXj/mrqFn+m59bnHiG+eIlT9Ek+OlDpQAXQx5DwYfpwnAFCH0olKZT
	tqDpVO3hU8OM9uwYooAvtcAnEjRX/ELPVpAYLKSlf67eJL4Yg9my/S5hEKz7mbqzAXP8piSYfJy
	/2u9YjemmDVOJny5Zi2MJ/KxdA9VHsHLdyceCgQWm4Om7NVIE8VxgXwlWbVpuBc93z5vfsnwOqA
	gGtHuQ3fEkG+6mx3gljOZ+EhrN78iE6mlYTR4nFyRQZiJiM/sidsVNf0R4IwQPugkPpa4rQ0JLm
	uwDArJz8inCVHNBjYZKijKSFq7gEeXLvbLe7I/4sC5IlB1y6C8N+4vAm8Ot3/+huDdL/D8eciW8
	=
X-Received: by 2002:a05:6a00:3007:b0:846:4d4c:23f8 with SMTP id d2e1a72fcca58-861662d4c34mr11674869b3a.1.1788551497395;
        Fri, 04 Sep 2026 12:51:37 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8615404876fsm1497684b3a.59.2026.09.04.12.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 12:51:36 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 2/7] bpf, x86: Use resolved pointer for timed may_goto
Date: Fri,  4 Sep 2026 19:51:27 +0000
Message-ID: <20260904195132.141068-3-sidchintamaneni@gmail.com>
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

Use the pointer directly rather than adding it to RBP. This preserves the
private-stack address selected by the JIT through R9.

Fixes: 2fb761823ead ("bpf, x86: Add x86 JIT support for timed may_goto")
Reported-by: Jeremy Jean <jeremy.jean@oss.cyber.gouv.fr>
Link: https://lore.kernel.org/all/20260824213158.3755932-2-Jeremy.Jean@oss.cyber.gouv.fr/
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 arch/x86/net/bpf_timed_may_goto.S | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/net/bpf_timed_may_goto.S b/arch/x86/net/bpf_timed_may_goto.S
index 54c690cae190..6e9d9e7c2b1d 100644
--- a/arch/x86/net/bpf_timed_may_goto.S
+++ b/arch/x86/net/bpf_timed_may_goto.S
@@ -11,12 +11,6 @@
 SYM_FUNC_START(arch_bpf_timed_may_goto)
 	ANNOTATE_NOENDBR
 
-	/*
-	 * r10 passes us stack depth, load the pointer to count and timestamp
-	 * into r10 by adding it to BPF frame pointer.
-	 */
-	leaq (%rbp, %r10, 1), %r10
-
 	/* Setup frame. */
 	pushq %rbp
 	movq %rsp, %rbp
-- 
2.43.0

