Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F4C606A31D
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Nov 2026 22:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lukasstockner-de.20260707.gappssmtp.com header.i=@lukasstockner-de.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QaU4MOJO
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXjtY3nwcz2yfN;
	Mon, 23 Nov 2026 09:10:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795376613;
	cv=none; b=Q0zTfUkAAQnscvfHtL5NdqNfb+6qxRF68YtsKYKo7eDqroBX9dyQ1jyVyHU67Xbf8DK4uZXfTuRAKMwq0fPqOG0WmsuUNJxZb+0QTwxkXI0Txzdfz74LfCYBgSL/4xJPA2XzqhM6W7tCUVHuCRhdVIToBRcpqvpASIbo3gokNXrQzJDrOYFY24cgSMKUinqfS4Yeawu38WBoybXKI0YR8f3jFFxeIWYZ63PLHm7k80Tru9x2v1kHkau3Ui3zmg9PDIpT2KfdmBOTGPUTargdCmPJlaZhzmuI3fbfEDZccBTby8+AZKjx7ZJSccALV5BaxwjYEEzQhEceHvKBDt8CKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795376613; c=relaxed/relaxed;
	bh=Kymp+J2o3UsNdNweR6Jcb6B6Bh4mLi4upsmCFa3PCvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/GH1ZfUn9aTanht3QtwSFYqnd1jaVIE/FM6QNhGuSrWxlu5Te0JuZpf9HTQZFR8/YEKIbYhQSv/wFd0YPMcBiazINjpf9SCQFCFmN319Dc9EGyzm5CDZocP/po3hUaCcquwnXMbnrv7fOCMirEPtiYxHKZ+nt1Cf894KC3OOTqg5rkG9r8O/JWGSCYSL0Tjr6E44x2RE3uSLTnZcDxnvdpQxpA2OSY6wcae+eRpKVOlG4m/JUeg33esGBG8wOrbc00GmhjeDfZEgdAemjJeNrInYcC98mCudpZy5p3ZmSQLiVux/0SbMDvB7RQM3+zVPdXHOjnOeTUsV7oD9uZQkA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lukasstockner.de; dkim=pass (2048-bit key; unprotected) header.d=lukasstockner-de.20260707.gappssmtp.com header.i=@lukasstockner-de.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QaU4MOJO; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com; envelope-from=lukas@lukasstockner.de; receiver=lists.ozlabs.org) smtp.mailfrom=lukasstockner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lukasstockner.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=lukasstockner-de.20260707.gappssmtp.com header.i=@lukasstockner-de.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QaU4MOJO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lukasstockner.de (client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com; envelope-from=lukas@lukasstockner.de; receiver=lists.ozlabs.org)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXfdJ2y9tz2xsW
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 06:43:32 +1100 (AEDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so13959545e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Nov 2026 11:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lukasstockner-de.20260707.gappssmtp.com; s=20260707; t=1795376609; x=1795981409; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kymp+J2o3UsNdNweR6Jcb6B6Bh4mLi4upsmCFa3PCvE=;
        b=QaU4MOJOsojBSaJBOfnFd6CTVLDCi+rbU5G5fGICWLZX3TnzaT/sYkLMKWoPlS3YDt
         t+VTi6mPz9knH2EV4FfWgcoLO3FxwhHDf/IQFu1wZQ14aK2PWMAmtv9wUyUFUT2Nhwh0
         a5BdhJMj8zKQZgFAZkw8ESW8bv91vjrIlvSjwFH1qhwKLN4r9ac9zzkItD6sIAIG+5g0
         9PKwPQwjDNR98sypCuxCsJ3CrD8h6VdEQZ3SDF5jdShOEJZaKSsqOLU3CZvzvyu8D/yy
         AFxftm/YyxYH7kfm3JcYdK76OEp0cecK+q7w5kcUBdqm6BTvhQ+/G+O6Sdjxq+47iUW7
         fkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795376609; x=1795981409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kymp+J2o3UsNdNweR6Jcb6B6Bh4mLi4upsmCFa3PCvE=;
        b=ZinctU608DwH0roELzobLAL86BsuMZ16bz7JKiPH22wYKoOcxZ9+EoU/LnCKSn3Bik
         Ce5RaXXfMujWXJqQZ0CxVW1P2dX481qbiexzb9JNR6prCu0qLAns9RceKD+hHaIYgErC
         CmmAtyqz/lzcYSF9OHga4koYQMEBfc44qVkI7RPvEbWd8ioRsXhLDlV8A0qYt+1yRAKj
         YrLg3PjnmVCOy8EQv0nmm2bI2goQ4D1qlJz/nrjjw6dsBPeFYjHUNGUIbtOvUyuZsz7S
         aaVm3XyDe3jf87O1jIWl79WwEio1OxYHrSEg6QMCInmGqs7r+MyUAaX+1UiAvxdr3dOh
         Z4jw==
X-Forwarded-Encrypted: i=1; AL+hErHssw0YVy3iNcck+uGrljr/91lzp3CGzvugkpwHXHp+m9+Kc8KhUoh2/wczseWgihZgPQfTwhgdY0Lgy3c=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/pfxalaWLyymwhns5IIFftb3+oIBP+UdHRE7tcjZ4AwDjs/j2L
	4U0SYTTwewmtRMwRiXd3wRfAd/E+U2B3aYUkuKk3WIxiQNmBeK+Bq0lNdU1UO+vq94Q=
X-Gm-Gg: AZFdTZeDQFff/MoW1ST8iZwQvCbCi3ax/PQvJCRU2o6b09DNRoC0TU8bpGn1X084u+j
	bFBlNpFiLG1dY9VCdUIpQY8pLhSPkoQHD1yBqbAHPzGJsR5RRez+BR9WNJBeyf+E5QtsHWBQM6i
	pWkb0ALoGnPP3vabZnydpeEpcmG/CnrYLWbM0LJMyQ5smdrDhlS0Nu00FtqKouBXTmqp9FaVmtI
	W6i6jJLuj5fhLTPAcKixXPPI4CTm7Fj7BnpFnzzlHLjqToUYkzILbB6CkbndyAymYOf2ZmB3Lzs
	sGaWq1TMjTUT19eUJSYXLx588Sr2LY8C6yOm0tSU0UJMD2IvjvL0kfShlSJ8p7OS2Gtp48MzyPU
	cKQKNpNAU0MsSzV+d+GSHTaGSKG5SooDLD3t5TdGcJ6VuPZYWBDRJBWiyJstwc4bFq6Q0QQ6NjO
	QPknf8I/RtnRdpf3vhnqkcIR9eljNZSzVJB1XNjstdJsNQZGbb5h/ymrwuVXsZARnfrboFf6bI5
	KeAWnyVPjNtbgdYL0WC6OR8DZmMQLWPJn0U8g014075uJyITKBR3soR+Wvj9LI9YF5RNE6d3Tyl
	UycBeH7KCPL9fJn8Bld5p54nFqShHlHWQP2lqWziJ7eK5X7BtcTez9BnTa8k8QeMDO7Qe7V4iNW
	V7g==
X-Received: by 2002:a05:600c:a08b:b0:4bb:6651:9eda with SMTP id 5b1f17b1804b1-4bb88922ca4mr188621625e9.14.1795376609171;
        Sun, 22 Nov 2026 11:43:29 -0800 (PST)
Received: from lukas-laptop (195-200-20-154.mclarenap.oninferno.net. [195.200.20.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88442995sm293917125e9.2.2026.11.22.11.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 11:43:28 -0800 (PST)
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
Subject: [PATCH 4/4] powerpc32/bpf: don't fold MOV into instructions that use dst_reg
Date: Sun, 22 Nov 2026 20:42:05 +0100
Message-ID: <20261122194205.218543-5-lukas@lukasstockner.de>
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

The PPC32 eBPF JIT folds MOVs followed by an ALU operation to the same
destination into 3-operand PPC instructions by dropping the MOV and
reusing its source as the second operand for the second instruction.

That is wrong when the second instruction also uses the destination
register as its source, since the MOV that would have assigned it
is dropped, so the folded instruction will end up using the previous
content of the register.

For example, "r2 = r1; r2 += r2" gets folded to "r2 = r1 + r2", while
the correct result would be 2 * r1.

In particular, this also happens for zero-extension MOVs inserted by the
verifier, where "r2 = r1; w2 = w2" becomes just "w2 = w2", so the actual
assignment is skipped.

Fixes: 19daf0aef84f ("powerpc/bpf/32: perform three operands ALU operations")
Signed-off-by: Lukas Stockner <lukas@lukasstockner.de>
---
 arch/powerpc/net/bpf_jit_comp32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index 7414e350d2d4..3ba50d6696a2 100644
--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -367,7 +367,8 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 		if (i && (BPF_CLASS(code) == BPF_ALU64 || BPF_CLASS(code) == BPF_ALU) &&
 		    (BPF_CLASS(prevcode) == BPF_ALU64 || BPF_CLASS(prevcode) == BPF_ALU) &&
 		    BPF_OP(prevcode) == BPF_MOV && BPF_SRC(prevcode) == BPF_X &&
-		    insn[i - 1].dst_reg == insn[i].dst_reg && insn[i - 1].imm != 1) {
+		    insn[i - 1].dst_reg == insn[i].dst_reg && insn[i - 1].imm != 1 &&
+		    !(BPF_SRC(code) == BPF_X && insn[i].src_reg == insn[i].dst_reg)) {
 			src2_reg = bpf_to_ppc(insn[i - 1].src_reg);
 			src2_reg_h = src2_reg - 1;
 			ctx->idx = addrs[i - 1] / 4;
-- 
2.56.0


