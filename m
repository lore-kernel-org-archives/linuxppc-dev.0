Return-Path: <SRS0=8VeL=N4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70422C43441
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 19:08:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7C022077C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 19:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cObMuJm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7C022077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42y4Q55wpSzF3TP
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Nov 2018 06:08:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cObMuJm7";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=ard.biesheuvel@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="cObMuJm7"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42y49328QWzDr5Y
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Nov 2018 05:57:24 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id d72so8580130pga.9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Nov 2018 10:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=FFyK4Oz1QZNyPCsvoKn4MQd4VSSgFUXXhCBgp8QbhcQ=;
 b=cObMuJm7WoQyjusLl+MSm4ZIOr4K71j4aNd5tPxwLRhwvXT/sYcvL7RDfA86wcLwA1
 MBgV1MZKVJe1BNu/nkLqb6788B61g2+j8XPg6DFJaa+9SwGmzpOHS6y6Xqbefq4fvVkj
 +/MH7MuuSDpYgCOZS+o5G38042o7Ps9gEKLjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=FFyK4Oz1QZNyPCsvoKn4MQd4VSSgFUXXhCBgp8QbhcQ=;
 b=ZdOGjJPBlE+/1dvlrwJXzsFaTw92TccLVQaikO+hHQCcHuhQEwdc8JtJqEQjgFm/Ka
 kyu7Kcjs/o2jmEPBlEc0bit66OktVGbq4bORsPTj+fFEiJ2OIC/OoPIzRKEKAqpk+zI5
 2sNmM1fjNpnrivqJZ5Oxsyn2IUB2wQCjlSFD0yWwiBEage1nsxsf7gT92Rp0FcxZgLiQ
 1TbztkCudwHyKjyYbsTllX7erdRNvVde7n0YMdATnysOHTLdieWbH/dIF9hnIyT0WdCM
 YiaxODcnQeIhdJAnk2B2Bafeh6SK4h1Gxv8VttUNZ/XpMM0WPEYN3FJKHQboEUBen/m7
 uLnw==
X-Gm-Message-State: AGRZ1gJPSITHGcpwdiszavOSoQXaqevLrFy5ctl9rlwnccgOqyeu8xn3
 5qFEA4KXintXmg9wq9q6BpBH4A==
X-Google-Smtp-Source: AJdET5eTfTm7MZO1Ys5mfFPU5yjtvrYsgtZia1/NgQb951W2tIaAMrSSEf/Q1za/zZx27f//YDj5kQ==
X-Received: by 2002:a62:da5a:: with SMTP id w26mr3755848pfl.106.1542481042106; 
 Sat, 17 Nov 2018 10:57:22 -0800 (PST)
Received: from mba13.psav.com ([64.114.255.114])
 by smtp.gmail.com with ESMTPSA id u76-v6sm49550745pfa.176.2018.11.17.10.57.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 17 Nov 2018 10:57:21 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] net/bpf: refactor freeing of executable allocations
Date: Sat, 17 Nov 2018 10:57:13 -0800
Message-Id: <20181117185715.25198-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181117185715.25198-1-ard.biesheuvel@linaro.org>
References: <20181117185715.25198-1-ard.biesheuvel@linaro.org>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
 Will Deacon <will.deacon@arm.com>, Alexei Starovoitov <ast@kernel.org>,
 Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>,
 Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>,
 Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Jann Horn <jannh@google.com>, linux-arm-kernel@lists.infradead.org,
 Eric Dumazet <eric.dumazet@gmail.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, netdev@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
 Jessica Yu <jeyu@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

All arch overrides of the __weak bpf_jit_free() amount to the same
thing: the allocated memory was never mapped read-only, and so
it does not have to be remapped to read-write before being freed.

So in preparation of permitting arches to serve allocations for BPF
JIT programs from other regions than the module region, refactor
the existing bpf_jit_free() implementations to use the shared code
where possible, and only specialize the remap and free operations.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/mips/net/bpf_jit.c           |  7 ++-----
 arch/powerpc/net/bpf_jit_comp.c   |  7 ++-----
 arch/powerpc/net/bpf_jit_comp64.c |  9 +++------
 arch/sparc/net/bpf_jit_comp_32.c  |  7 ++-----
 kernel/bpf/core.c                 | 15 +++++----------
 5 files changed, 14 insertions(+), 31 deletions(-)

diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
index 1b69897274a1..5696bd7dccc7 100644
--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -1261,10 +1261,7 @@ void bpf_jit_compile(struct bpf_prog *fp)
 	kfree(ctx.offsets);
 }
 
-void bpf_jit_free(struct bpf_prog *fp)
+void bpf_jit_binary_free(struct bpf_binary_header *hdr)
 {
-	if (fp->jited)
-		bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
-
-	bpf_prog_unlock_free(fp);
+	module_memfree(hdr);
 }
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index a1ea1ea6b40d..5b5ce4a1b44b 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -680,10 +680,7 @@ void bpf_jit_compile(struct bpf_prog *fp)
 	return;
 }
 
-void bpf_jit_free(struct bpf_prog *fp)
+void bpf_jit_binary_free(struct bpf_binary_header *hdr)
 {
-	if (fp->jited)
-		bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
-
-	bpf_prog_unlock_free(fp);
+	module_memfree(hdr);
 }
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 84c8f013a6c6..f64f1294bd62 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -1021,11 +1021,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	return fp;
 }
 
-/* Overriding bpf_jit_free() as we don't set images read-only. */
-void bpf_jit_free(struct bpf_prog *fp)
+/* Overriding bpf_jit_binary_free() as we don't set images read-only. */
+void bpf_jit_binary_free(struct bpf_binary_header *hdr)
 {
-	if (fp->jited)
-		bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
-
-	bpf_prog_unlock_free(fp);
+	module_memfree(hdr);
 }
diff --git a/arch/sparc/net/bpf_jit_comp_32.c b/arch/sparc/net/bpf_jit_comp_32.c
index 01bda6bc9e7f..589950d152cc 100644
--- a/arch/sparc/net/bpf_jit_comp_32.c
+++ b/arch/sparc/net/bpf_jit_comp_32.c
@@ -756,10 +756,7 @@ cond_branch:			f_offset = addrs[i + filter[i].jf];
 	return;
 }
 
-void bpf_jit_free(struct bpf_prog *fp)
+void bpf_jit_binary_free(struct bpf_binary_header *hdr)
 {
-	if (fp->jited)
-		bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
-
-	bpf_prog_unlock_free(fp);
+	module_memfree(hdr);
 }
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 1a796e0799ec..29f766dac203 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -646,25 +646,20 @@ bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
 	return hdr;
 }
 
-void bpf_jit_binary_free(struct bpf_binary_header *hdr)
+void __weak bpf_jit_binary_free(struct bpf_binary_header *hdr)
 {
-	u32 pages = hdr->pages;
-
+	bpf_jit_binary_unlock_ro(hdr);
 	module_memfree(hdr);
-	bpf_jit_uncharge_modmem(pages);
 }
 
-/* This symbol is only overridden by archs that have different
- * requirements than the usual eBPF JITs, f.e. when they only
- * implement cBPF JIT, do not set images read-only, etc.
- */
-void __weak bpf_jit_free(struct bpf_prog *fp)
+void bpf_jit_free(struct bpf_prog *fp)
 {
 	if (fp->jited) {
 		struct bpf_binary_header *hdr = bpf_jit_binary_hdr(fp);
+		u32 pages = hdr->pages;
 
-		bpf_jit_binary_unlock_ro(hdr);
 		bpf_jit_binary_free(hdr);
+		bpf_jit_uncharge_modmem(pages);
 
 		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(fp));
 	}
-- 
2.17.1

