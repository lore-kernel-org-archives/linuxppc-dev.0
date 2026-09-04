Return-Path: <linuxppc-dev+bounces-26600-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD8EC624DB
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Sep 2026 06:18:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hcNSh3QsWz2yvV;
	Sat, 05 Sep 2026 16:18:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788551504;
	cv=none; b=HvwKnYyoskEA4fADVWccOUZyWylw4zpUcVywzWd6Y3HA1bZNq/2b1lw8qVNTVI/6HI7uxDqxPmgysK3MLjpJjbIUd/6Ih0WnQPNF6cwUuQVYOpo4/Zjqoz0JSDG4Ek9/yAdCUy6e/+54qxEw3SVd1yauSy7hVUgg9JTnf3oo/DnqVtkg8BDiO76gy33AczgumUfdEOlQH7aX5tZA0NTKh9lIv0096NKAozThXteqz632FGo0JztcNks+aoLykmK5rR/NWn1MZnUM7TBy48KKveVJ1gZlHUTc+nGRNKRZs7R0Nntf+i3FWBsLPFYrFd45hri03FnkOorq8hwonfU1Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788551504; c=relaxed/relaxed;
	bh=yVBsoFTvre1N55biXZd8wIwrI+sXnvIOODIR/1bsh18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iFeuV7ZkSFJws+sPxceT3s0YvthqN44Le5WhGqgdKYky0bcas7wmi3TzYJCJdQj4QXYIP/rnHRBIXRd1iNOCTQjzC+YMZSjEN/ksNSqHnYCwe2y5qC+squafXleVVQOe5wsAiIjeYBAyFAGXcVoCC2Q4NGO+qHJkYcFlU+eexe2JLnhWH4f+PBVi6g2iHYQyzJGjwpaXUtWjTC+Aes1c8Z9tDxeOyXdpdtJk78yuhz/CMI1x+UYFAinNqpPgrR8dYgdYami++GBwx9bFn3rdPNJaGV6y0dBi7EGEVx5z6YH/+NiBR9zT6UE/pgYrmBav8t+gRf30Uu9KSmdPkcUQkA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lilI6uQS; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=sidchintamaneni@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lilI6uQS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=sidchintamaneni@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hc6YC6YQcz2yrW
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Sep 2026 05:51:43 +1000 (AEST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-84f3ab8750cso1201486b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 12:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788551502; x=1789156302; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yVBsoFTvre1N55biXZd8wIwrI+sXnvIOODIR/1bsh18=;
        b=lilI6uQSYHYgUXJalzPvcDQE/7iF6RP7aEDVCqI1rn8a5ycJl4dF9aKw1eYkZOdLEk
         ulQcldwvHkxHQW4q+uaeVlYk655DFlf+VEBojBelf9tXwTUtsxNr5nmYnuYP0NGonvQP
         cxEiTTJj1+Brm3qAAU2I3cH9wwPKW5MwHLlwDfYOQiFE1GWN812aHlNU5wod3+lG9Fi8
         fGfWGcTFkP/LnHyamUAf53X1mGd5DB+Hom6wJg21PyqGM7suOYRFqiLviBjDoyVJtb86
         fDUH9jXlcFeZKaARR9MqGOqD9Qiymf6zf2qnE87nmEJF1ADk+6j8QzA2h/G0lABzxxZZ
         G39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788551502; x=1789156302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yVBsoFTvre1N55biXZd8wIwrI+sXnvIOODIR/1bsh18=;
        b=ZVNtnKhDSp8hNeheET1Kl7i1mxHTA/CEdS3Duz+p/yop7q4V9ZVBZqb7Os1XARADMQ
         ccr7CKFF3Vf8jt9RYgbDjt+K+W9CnIJ80cAG6D8/zWoyfDGUkZgE4K8QeZc4ReG5df/r
         jk723t/WWRq20e/PfVJyIQaDQhxjlR8KNGOx6c4HsNzwMxnSEoDYF/fIqle+YKzZUr+f
         PvoPlkwCqWD8Varsi2zpBGxlTTYMS/C+r7/0jw36/m5z6jX4z+XOn26xy0Ro3F2ujwWW
         157NcYFtc99LWFMf+R/CBeNtgdhlK19Qf8frh99iffUzSxqEgJaiTl3I6E5XnFVavEUx
         h5rw==
X-Forwarded-Encrypted: i=1; AKwUvBwwICEU3xt23zxYUH281h5UM13tjlPYXot9NsSAzOIDisX3KTLEumMnD5R3Q/YbqbU7egul4MID1LDajbc=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nuc+JaH+DTh0cerwKDk3/JakC4sYtYkapYhBekhqd6m9VZnZWp
	OPy0Sue1liME9VL/f6U2bZWfzTx8QeMA+WkgLm5QMyHkgjhr0EZOqkZ5
X-Gm-Gg: AYBFou3oUUBWjcghGAFVdGuQmoHYoXCspUtff3xZAdTDSAWteRjRKoiSUMaQqY7ROeZ
	K6cKNuNNRIyuZPBAQl2VOml0QkDiv+JbbgLlCI+K6EaRHmGve4dlkwcaTv+awNrWskzHt2hhCdn
	/FAo1psYJ5SWD05RNS4a6tCjEVMgxUMmF/OrXgPWwlNEwqC1ifz7ZUYc7Yesoj9+p7dzB7Kyo8h
	qnHeJ42uHOsaZajDRQp3wAaglYuPWkTANtzq9qyCltPv2VIvPBBRQfJ8PYRfh4pfAsq0S+YESMz
	eiAA6QV7/Qk4C+pvGLt/p4FsCgZHPucpXLCg3SY5i0ygF+UH0HYeGJryXX9yJn6jGCKEaYCmU9q
	He3qItR7S6DMgG8/8PE2jjWNYrXC/Mgt/jclzsWQgLGZ7IVdgub5orJEClpnZrdb6sRB7tnS5qB
	hmDZbJuCSabDch1CD/kDC+ta5a/8SyhQdEAgYHxdkYuKNe12YJqstBfORer8bI5GmaNybgc/iHj
	PqZy4cwnCGYbvi/bAoRtOOycuBKb0+ZSLYFKs/gPIS9r3kebOYp6d8+1sEf7xpieE6gfiBbbDVb
	3l1RmxESj4yj7v0rL3kzT/G0IJH6NToVAU7dMFkCKyX4uXhsG3nLEO+D0gAo1W/dJBe0OwltTVf
	z3AXWQlDqQEI=
X-Received: by 2002:a05:6a00:2994:b0:857:7384:b5fc with SMTP id d2e1a72fcca58-86169f6cbcbmr14428608b3a.24.1788551501408;
        Fri, 04 Sep 2026 12:51:41 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8615404876fsm1497684b3a.59.2026.09.04.12.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 12:51:41 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 6/7] bpf, s390: Use resolved pointer for timed may_goto
Date: Fri,  4 Sep 2026 19:51:31 +0000
Message-ID: <20260904195132.141068-7-sidchintamaneni@gmail.com>
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
BPF_REG_AX instead of a stack offset and BPF frame pointer pair.

Copy the pointer directly into the first argument register and update the
special calling convention documentation.

Fixes: b8efa810c1db ("s390/bpf: Add s390 JIT support for timed may_goto")
Reported-by: Jeremy Jean <jeremy.jean@oss.cyber.gouv.fr>
Link: https://lore.kernel.org/all/20260824213158.3755932-2-Jeremy.Jean@oss.cyber.gouv.fr/
Assisted-by: Copilot:gpt-5.6-sol
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 arch/s390/net/bpf_jit_comp.c       | 6 +++---
 arch/s390/net/bpf_timed_may_goto.S | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index c46872b071ce..4098c3377c21 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -1872,9 +1872,9 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		if ((void *)func == arch_bpf_timed_may_goto) {
 			/*
 			 * arch_bpf_timed_may_goto() has a special ABI: the
-			 * parameters are in BPF_REG_AX and BPF_REG_10; the
-			 * return value is in BPF_REG_AX; and all GPRs except
-			 * REG_W0, REG_W1, and BPF_REG_AX are callee-saved.
+			 * parameter and return value are in BPF_REG_AX; all
+			 * GPRs except REG_W0, REG_W1, and BPF_REG_AX are
+			 * callee-saved.
 			 */
 
 			/* brasl %r0,func */
diff --git a/arch/s390/net/bpf_timed_may_goto.S b/arch/s390/net/bpf_timed_may_goto.S
index 06f567a460d7..e34c99982c4a 100644
--- a/arch/s390/net/bpf_timed_may_goto.S
+++ b/arch/s390/net/bpf_timed_may_goto.S
@@ -21,9 +21,9 @@
 
 SYM_FUNC_START(arch_bpf_timed_may_goto)
 	/*
-	 * This function has a special ABI: the parameters are in %r12 and
-	 * %r13; the return value is in %r12; all GPRs except %r0, %r1, and
-	 * %r12 are callee-saved; and the return address is in %r0.
+	 * This function has a special ABI: the parameter and return value are
+	 * in %r12; all GPRs except %r0, %r1, and %r12 are callee-saved; and
+	 * the return address is in %r0.
 	 */
 	stmg %r2,%r5,FRAME_OFF+R2_OFF(%r15)
 	stg %r14,FRAME_OFF+R14_OFF(%r15)
@@ -33,7 +33,7 @@ SYM_FUNC_START(arch_bpf_timed_may_goto)
 	lay %r15,-FRAME_SIZE(%r15)
 	stg %r1,__SF_BACKCHAIN(%r15)
 
-	lay %r2,0(%r12,%r13)
+	lgr %r2,%r12
 	brasl %r14,bpf_check_timed_may_goto
 	lgr %r12,%r2
 
-- 
2.43.0

