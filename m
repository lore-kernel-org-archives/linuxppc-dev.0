Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8912606A31E
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Nov 2026 22:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lukasstockner-de.20260707.gappssmtp.com header.i=@lukasstockner-de.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hxp5pZgD
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXjtH3rm5z2ySH;
	Mon, 23 Nov 2026 09:09:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795376609;
	cv=none; b=KNvxqn5b3WUlE3H+SAd5DgH6Lgak2W3g3LC3lITcXlS1c5NIdOWX/vICmkrpFW2LXM8EncR7+pS69kw1wBHvpQPDU5Ohb2MUvqXYwmvHsYCMu02VhHmxs2DsC8oSLL3ZmJAAliQE3ApfNKJ/ibiXzMmmO7AQ+9Cftb2AUFhJm/dSEhLVgPWHIXOVKTFG4mSnVfeYpj74ZFHVVivhCJp3w3SX3VWDTsTbbFQvdkBFniGXJGlRZGTp5MvOqSyWNRrvbc7SJC/tkktG/A/1IfAxMbNCrFH2Z9CiiewRQwYbVDJrpTtgR9ZtBDpbiDayLzBm4Cuhrnz/j/cpZQ1cNhP1IA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795376609; c=relaxed/relaxed;
	bh=SacHS26F4wxER6qI4ojBTAAYYFLzdB/Bos5NQBqEPVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a1pvw1YNiJg6n0cZYqFKp7dhwxMg3vR7eOftz33PXE311tKFYCdAoSoMPfMbffZCFpvl3V8M+hHj//CiwxHMjv/FbWmjEwX0o2TM6spV/YeRf8YwQRkUUGLRnWiKCPuabSQqmqURI/XJjx8qwDHnkShl9F+JSTnZ+aCzuKTtzMe5rg5BYHFyZb0OEGLnNNF40IigrmloCrmaoaLKQmWnHuQ/bCZKcKjYRcKPSeUrvQs/0jFEUCn8a/1VauQLsa+hYdm0aV52ltmb50vY8dbCj+s1jwJk+KfeIixNuRy843d+JCOpHRR3piuZaC2KgFtAyR4yqNjd2u/c+MqYD1/GFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lukasstockner.de; dkim=pass (2048-bit key; unprotected) header.d=lukasstockner-de.20260707.gappssmtp.com header.i=@lukasstockner-de.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hxp5pZgD; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com; envelope-from=lukas@lukasstockner.de; receiver=lists.ozlabs.org) smtp.mailfrom=lukasstockner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lukasstockner.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=lukasstockner-de.20260707.gappssmtp.com header.i=@lukasstockner-de.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hxp5pZgD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lukasstockner.de (client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com; envelope-from=lukas@lukasstockner.de; receiver=lists.ozlabs.org)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXfdD6xH9z2xsW
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 06:43:28 +1100 (AEDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4bb6adaf0f1so22137655e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Nov 2026 11:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lukasstockner-de.20260707.gappssmtp.com; s=20260707; t=1795376606; x=1795981406; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SacHS26F4wxER6qI4ojBTAAYYFLzdB/Bos5NQBqEPVo=;
        b=hxp5pZgDpgHWtdjgFSgZOjUwJKWQTEcG2WccGDaZ81UuYAscgXXMr3K9KZYGixSCTs
         4OUdhx5UDl0+8XyLRMWaN4FmAOeKiGWLZs8toaIPqUSwm8K1UWRynBQEjq2lFRkc5XUS
         JU9G4fUmqAVA3RdNUH7u2PJe9+w/OjIjLo0fdbch5K1MD+csNLvHK6kHoPyB+Iltcfmq
         OJJ/YvIJGUDclqPHdGUTuPD3ccHfAxnrmUIc/7qPVskvHnnxfsszot7XD4kNvPnEmHlz
         oTKove+zPyVNG7GKod8saIzOz//4H0mpy3CMaCodtMrtkYtPAQJRNZ+jCanBCVr3gKXp
         1KKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795376606; x=1795981406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SacHS26F4wxER6qI4ojBTAAYYFLzdB/Bos5NQBqEPVo=;
        b=XRyGY+jTbdxvWDHYZxNdrjvX15009Bvm+rQOUnMtJRubxB7otS09dbvqTecbvIhcS6
         pHixEd9FTtP9g2aWxiAcU9Wu/Ej47RPRNwWs/bP3+IRQIzFWn5XPrjRVI6vi6quAXlli
         KbwaRv6XFl2L/Qsui0CL/jX0Do50xyF3+7ChCr3Pr9WStDS5MrszO3BqBEJSsQVKIFB2
         EXzVVOyOTFuJTFkLokjXoggBr13Pz0o7ocvGOBV41sJKuBReyPPoBaZKwOpuboGVckJ4
         HXrgmRpC/WBCO4fYXehy8BQ5K3IJREMBDN64E5jSQfogG7c3mYpyGN3TUrYqnEmJ5zce
         VzKA==
X-Forwarded-Encrypted: i=1; AL+hErEtcdZdbF6JyU+SpNKkz6ArtdQpKLRFrDy7U7AQhyGBllLfvznmXp7DU0vqu66jEk9CU3G2OHoXfW+tINQ=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8xE3hvL4i4eeTqLchMyRYk4JtlC8CnfeMb/HHHZ584wTqQL5do
	6vxyR3qgxLV5d2adC+zpohorW+skCzlOQhLs7VrfDrtkEvPEQnXfG1ZPPDv34/ZIa78=
X-Gm-Gg: AZFdTZe7hXPGahuEq7E1H+yFxXLCYb7x4UKao4TLubqmEyv1VYaPr9hf4ykN5vYxFwI
	de7sz5jlg+KDd4oj801HPcQ4t3DEPQ+Ar6ID6vD7CdgvUQFyqbHul4oyDLspmdNHBcSQo2EexHV
	kXBslGoj9ldPKE4HGU8OHi0d6ePFJzB+5sLo0AZ6sYHw4KYXlU0D4h/J3Xs38mLf72KkxtTGlUt
	modxUG3IYRfd43D/mSOetZwppN1GmqN6oCq6D7ozBuTWcHlPZlyOuX4V5xMJac3RB+VciPIOTrf
	pm+j/C7QIdDpRNRMBKf9ZeYrODVxDJkFPA5QnWIrAE3KAy14ioCMXLqX8BB2BTYUQkh+TAm1m/f
	wlUIhwQZKdC90AOUqgswvScOZ5tlBk/9pW7i2WSkws1r7KOh9HzBq3VX6MkuBxT3U48pYxK3OhY
	tbkMeI+aWdoFN2WMyhQJ8/J8FQZrSkDPGgv1964Q0qBpOi4FU9t2DfjYR7GTRVA4EgPXmw62aGF
	/YUnnUZ/9OiHsWuiS8TCIoEXAewRwv2Hg29v2oxSaI7fLaoVj2F2SYBKcHi4l5DBi8W2odVlBTp
	ZC485f/tPLpWRdskV4cEVzDeMd/dqO+gd3DCEecGIQPV4eIarDkCmnG5EcPB/nubCO5EDZmiPJZ
	9
X-Received: by 2002:a05:600c:820d:b0:4a1:dfaf:f465 with SMTP id 5b1f17b1804b1-4bb887c2ca3mr208489695e9.4.1795376605748;
        Sun, 22 Nov 2026 11:43:25 -0800 (PST)
Received: from lukas-laptop (195-200-20-154.mclarenap.oninferno.net. [195.200.20.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88442995sm293917125e9.2.2026.11.22.11.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 11:43:25 -0800 (PST)
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
Subject: [PATCH 3/4] powerpc32/bpf: mark all argument registers seen in function calls
Date: Sun, 22 Nov 2026 20:42:04 +0100
Message-ID: <20261122194205.218543-4-lukas@lukasstockner.de>
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

The JIT code tracks which registers are used and remaps based on that,
but currently does not account for the fact that function calls implicitly
use registers because the called function will treat them as arguments.

Therefore, if a function merely passes through one of its arguments
to another function call, it will incorrectly be considered unused and may
be overwritten with another register's contents.

In practice, this is unlikely to affect main programs as they only get
one argument (the context, which they are very likely to touch somehow
in addition to passing it on), so they'll have to touch other registers
if they want to pass them as arguments. Subprograms, however, are much
likelier to hit this.

Similarly, tail calls pass R1 to the callee, so mark it used as well.

Fixes: 51c66ad849a7 ("powerpc/bpf: Implement extended BPF on PPC32")
Fixes: a8936569a07b ("powerpc/bpf: Always reallocate BPF_REG_5, BPF_REG_AX and TMP_REG when possible")
Signed-off-by: Lukas Stockner <lukas@lukasstockner.de>
---
 arch/powerpc/net/bpf_jit_comp32.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index 9f55dd4bdfd6..7414e350d2d4 100644
--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -339,7 +339,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 {
 	const struct bpf_insn *insn = fp->insnsi;
 	int flen = fp->len;
-	int i, ret;
+	int i, ret, max_arg;
 
 	/* Start of epilogue code - will only be valid 2nd pass onwards */
 	u32 exit_addr = addrs[flen];
@@ -1183,6 +1183,18 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 			if (ret < 0)
 				return ret;
 
+			/*
+			 * We don't know which arguments the called function will use,
+			 * so if this is a subprogram, assume the worst case where it
+			 * uses all of them. Regular programs only get one argument,
+			 * so any others would have been explicitly set.
+			 */
+			max_arg = ctx->is_subprog ? BPF_REG_5 : BPF_REG_1;
+			for (int reg = BPF_REG_1; reg <= max_arg; ++reg) {
+				bpf_set_seen_register(ctx, bpf_to_ppc(reg) - 1);
+				bpf_set_seen_register(ctx, bpf_to_ppc(reg));
+			}
+
 			if (bpf_is_seen_register(ctx, bpf_to_ppc(BPF_REG_5))) {
 				EMIT(PPC_RAW_STW(bpf_to_ppc(BPF_REG_5) - 1, _R1, 8));
 				EMIT(PPC_RAW_STW(bpf_to_ppc(BPF_REG_5), _R1, 12));
@@ -1412,6 +1424,9 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 		 * Tail call
 		 */
 		case BPF_JMP | BPF_TAIL_CALL:
+			bpf_set_seen_register(ctx, bpf_to_ppc(BPF_REG_1) - 1);
+			bpf_set_seen_register(ctx, bpf_to_ppc(BPF_REG_1));
+
 			ctx->seen |= SEEN_TAILCALL;
 			ret = bpf_jit_emit_tail_call(image, ctx, addrs[i + 1]);
 			if (ret < 0)
-- 
2.56.0


