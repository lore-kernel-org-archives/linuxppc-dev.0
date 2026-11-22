Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E39B606A31A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Nov 2026 22:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lukasstockner-de.20260707.gappssmtp.com header.i=@lukasstockner-de.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Azzl/rKs
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXjsd61jYz2ySH;
	Mon, 23 Nov 2026 09:09:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795376591;
	cv=none; b=Bj++ivxSq05gzRSf4eTlR87uf3j7TfYuaUKylH/xJ34oZQ1R0gu38ZplBK6rkYwIUpyGCB3+Z6BDMJHrd+RFq1kY19WMx/lOsSuxX65y9cfvj+VxNcXb3gVPDOomlnDiaqq0/yAF9EbB6pWn6qPFe99d6wkoejGIA+IejOw7VFao31A9kv3qpPfGTQObtepsc2TggZCi9k9/p/sQejmULb1F0dYuXMQz8shur/Lwzd+J+UHde4CIB4tHjDOo8lFvynFE7zIX4EelUUx3gBROZbFPqtsQ87cWW8W4ZOahAm/E/UUYPdPsyxTZrCNlkoo4XhiX2DYMtt4eCPaQZltr/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795376591; c=relaxed/relaxed;
	bh=3Rts9xMlV/I79tsAmx/LYiDpXcrHBQz49ckYW4v4Vs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inEGnjMGKyFYUoSJvpzpqc005lnO2UFFnzj0IwIYNf6oGK1rSld8BQPChRQJN/ICPN4LpQOoNM/Wb+CsTLCgxpCPpjLxK0WYPhDQfCganuYBk+rle72yTphVxMv0vbfR0+WCNvY5FKuoR93o5tKt7JOqLA7ih8pG7TyQ6yCQfnRafQ292gT+lKuj3ExNS2yrFG9/oLPaAW5E5DvS8rJyrHm+w5BYGRG8tij4DxrXgSOukylSH4lCS8TaocSrCT2zkgsk4RBRWm38j8oSRS6cORbMZNafV/pbzSQIlkUGrzSurScW1E5eV/IT6KLjKYKM9tpE2oJbODo71kaXipOQOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lukasstockner.de; dkim=pass (2048-bit key; unprotected) header.d=lukasstockner-de.20260707.gappssmtp.com header.i=@lukasstockner-de.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Azzl/rKs; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com; envelope-from=lukas@lukasstockner.de; receiver=lists.ozlabs.org) smtp.mailfrom=lukasstockner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lukasstockner.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=lukasstockner-de.20260707.gappssmtp.com header.i=@lukasstockner-de.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Azzl/rKs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lukasstockner.de (client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com; envelope-from=lukas@lukasstockner.de; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXfct68jzz2xsW
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 06:43:10 +1100 (AEDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso18106665e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Nov 2026 11:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lukasstockner-de.20260707.gappssmtp.com; s=20260707; t=1795376587; x=1795981387; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Rts9xMlV/I79tsAmx/LYiDpXcrHBQz49ckYW4v4Vs8=;
        b=Azzl/rKs407ptrizys0EmYrVX88Vr3TeXXzJP0EqA+m5bzLQo+kPtykoARDcI5sP6V
         DXGhQQDwIb+gabfESAxSoGnNJuRBZbsY49ONm6EZ+7M09kHlKOavl23AxItq1nFovI7H
         XcwaTOZvsI3gxYFfpDY9ZjLgnRCBH3mOcaMN6y7OMKvWZz2IndFSN7ImB96iwpXrnvWI
         8DPeBQuDUAKTc7ENEoaiXX78wz5g+XeNx49TWjxlfCyOqMOl3YLuvyFnTdL5y13dBnBk
         xgUdn6sB5CeiVchohsOwrSpOxbKS8s7SVcgC8IFYvkJV6vWXScoSzZw0H5pJqAixDLiu
         NnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795376587; x=1795981387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3Rts9xMlV/I79tsAmx/LYiDpXcrHBQz49ckYW4v4Vs8=;
        b=gNzPd9vsMmYvD+apyPrgWlt/n+t+2RO+70xONqLAAGCnfw+7U95m+qvdN2q+jyx9Qz
         UAAqhoBQqDp0YTuLpiGxOzc350vvUSuRQNrWOAm2lGJnR2gmcVeA2gQHtiR7aPWXizFy
         xdnNAOpUXS+etM9yUZgheq5BC1q+j8F2qd5Q1DnLia5CL0rmPP0jBSu/ohiraj0RUHQa
         Yy8HfFdbqmzi9SAKcGDXDRobXdFm+P1Gv7H5NA0DWoi2DFb8Jt92blBWCp5ghJVA5VfC
         6zfMule+UnYYXnFalgK/SNc+9nC3QYxUbki6z/776jRrKsDsI9ZJbKeoK4stE0tS8SBi
         rjQQ==
X-Forwarded-Encrypted: i=1; AL+hErFsNAQ/KlgouQOcIlyhjhlvoTolMUCB9J78HwIoGxCf5MufgWWup7g/0YTqvZqLEUJ3vMEsQ2tLMFpShsQ=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+DH9ZZlYWXYUPiTMxVJny7LEnAD4hBlSamonVE9lNPCu7p6gAr
	q80n8Gm2AcYhk4UTeqCJYidPWwiYnecxjk4kcXmfjvtgrJpRYKfyHHSbOiHeTRBrZpg=
X-Gm-Gg: AZFdTZdLpA+cPJGRMgM6DsGVLxa+wbGQLJC2GEPOh/lr6iMDbjrcGHZJ+FODNiJhRHS
	8nxFNVQLwkMCtvnGe+iJ/4+61LFVjwthsU0BWfQiUqAaZeLZ0RGsb8fUmR55sS0LwneOUwEhi/Q
	KmF9qH4EzgVPLSkLJU3nhbTHbratNBUGZ/DiFf/6bGxVxLkrAsb1xZSuO2ICx7tGXdeaU98L4Xg
	Z8lzFF0Wy0AdXRun9nuwGV9S1ZDCcayN/cqYMTQzo1msCInKOFI090q7wS256sPmXoWmZORLFm2
	1v+GU8MAtxj6HbrtQ53MJ4PdN8spUC4ayWK+KZjLs3OtW+fu91gD1ap7Td3zVYMhNRNNK6FBlyE
	QxOjjhyXsyDhCHRGbHZFIZPc0vnP4vmcHxAQbN18UZck1JsYJ5pfLl+rRhHu35KS+lVaA3a1B+x
	KgoS0Arbm28zaWA+5nCxaN58P9o1r2CVKSSgUZg4T426g0DPoREtf2TW/HvFfBeZerjBcZpA1Ql
	C66MDBadlReHCAVBMYh7CpymYoNkMeRxbceOtNpPgUFdly8N76waS+G3lSJLKbQoMIaXaz2hz/W
	y8Gt2IUx0hN8EeCk2S++Qp+FxqoNWB8IrPRZ+TG4FOEyvbmmkpqXuXzznuhHOtAQB0q/4dBqzHS
	k
X-Received: by 2002:a05:600c:a085:b0:4a2:526b:d410 with SMTP id 5b1f17b1804b1-4bb8881092bmr210336715e9.13.1795376587215;
        Sun, 22 Nov 2026 11:43:07 -0800 (PST)
Received: from lukas-laptop (195-200-20-154.mclarenap.oninferno.net. [195.200.20.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88442995sm293917125e9.2.2026.11.22.11.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 11:43:06 -0800 (PST)
From: Lukas Stockner <lukas@lukasstockner.de>
To: Hari Bathini <hbathini@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	bpf@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Lukas Stockner <lukas@lukasstockner.de>
Subject: [PATCH 1/4] powerpc32/bpf: fix argument passing for subprograms
Date: Sun, 22 Nov 2026 20:42:02 +0100
Message-ID: <20261122194205.218543-2-lukas@lukasstockner.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261122194205.218543-1-lukas@lukasstockner.de>
References: <20261122194205.218543-1-lukas@lukasstockner.de>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Main programs receive a single 32-bit pointer as the first argument,
so the current prologue converts it to the 64-bit BPF_REG_1 by moving
R3 to R4 and zeroing R3.

However, subprograms are called like helper functions, so there the first
argument already is 64-bit - but the prologue still does its conversion,
so the argument ends up with its halves swapped and the upper one zeroed.
The same problem applies to the return value.

In particular, in the common case where the first argument is a context
pointer, the callee ends up with the upper (zeroed) 32 bits, which then
triggers a kernel panic as soon as it's used.

Therefore, make JIT emit the appropriate 64-bit prologue/epilogue for
subprograms.

Fixes: 51c66ad849a7 ("powerpc/bpf: Implement extended BPF on PPC32")
Signed-off-by: Lukas Stockner <lukas@lukasstockner.de>
---
 arch/powerpc/net/bpf_jit_comp32.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index f5b9441cf46a..261ac0646b96 100644
--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -179,9 +179,11 @@ void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
 	if (ctx->seen & SEEN_TAILCALL)
 		EMIT(PPC_RAW_STW(_R4, _R1, bpf_jit_stack_offsetof(ctx, BPF_PPC_TC)));
 
-	/* First arg comes in as a 32 bits pointer. */
-	EMIT(PPC_RAW_MR(bpf_to_ppc(BPF_REG_1), _R3));
-	EMIT(PPC_RAW_LI(bpf_to_ppc(BPF_REG_1) - 1, 0));
+	/* Programs receive the first arg as a 32 bits pointer, subprograms don't. */
+	if (!ctx->is_subprog) {
+		EMIT(PPC_RAW_MR(bpf_to_ppc(BPF_REG_1), _R3));
+		EMIT(PPC_RAW_LI(bpf_to_ppc(BPF_REG_1) - 1, 0));
+	}
 
 	/*
 	 * We need a stack frame, but we don't necessarily need to
@@ -231,7 +233,13 @@ static void bpf_jit_emit_common_epilogue(u32 *image, struct codegen_context *ctx
 
 void bpf_jit_build_epilogue(u32 *image, u32 *fimage, struct codegen_context *ctx)
 {
-	EMIT(PPC_RAW_MR(_R3, bpf_to_ppc(BPF_REG_0)));
+	/* Programs return a 32-bit value, while subprograms return 64 bit. */
+	if (ctx->is_subprog) {
+		EMIT(PPC_RAW_MR(_R3, bpf_to_ppc(BPF_REG_0) - 1));
+		EMIT(PPC_RAW_MR(_R4, bpf_to_ppc(BPF_REG_0)));
+	} else {
+		EMIT(PPC_RAW_MR(_R3, bpf_to_ppc(BPF_REG_0)));
+	}
 
 	bpf_jit_emit_common_epilogue(image, ctx);
 
-- 
2.56.0


