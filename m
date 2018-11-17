Return-Path: <SRS0=8VeL=N4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB01C43441
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 19:04:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 643E620815
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 19:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HCrZnyJK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643E620815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42y4K21c3SzF3lx
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Nov 2018 06:04:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HCrZnyJK";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=ard.biesheuvel@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="HCrZnyJK"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42y4916LWrzF3kr
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Nov 2018 05:57:22 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id u6so471617pfh.11
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Nov 2018 10:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=vKtcwajq6uet7RwpHABNJRRfvhJ5RLh+7DwnrP6tkoU=;
 b=HCrZnyJKCfFnJaZK1DpCvziEmRstnj4rwYTbT92UFXz73rvqQ9ZSjTGDU8wRnGgNJ+
 ExMscyjZDgE+uBnbk94MoYbWGi/Ppcc1XZG5FsvUrcfYFnni03qp7O8Pw8kD/mV3EtA8
 4qJ0sf0q5nq3snS/fKcmV1/2jIO7ddsYaFvVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=vKtcwajq6uet7RwpHABNJRRfvhJ5RLh+7DwnrP6tkoU=;
 b=cfDdLYs4QyK0L38XYOo8PPqRpjCd1IZEOjtLN6F8KR+kOrxR5WZ6RIqXty9ScIU6rP
 WUcp+78l8b7ys1Ph2knDs+mI2ePQHv5psrgGZ4L8XhsMAZJPoyVtU0DfF8mT+awU/SW2
 Rh0u5wEriCEwmQltK5SEh4AWxF73hfP2cySSdRd6C7XZEgEfSHt3G5slnT+Fvf3Hftof
 Kgj1+/wG6NU0LMrrZMxgYZxB8j/9xIdVae5xVsQw0V6mBSPg3j8g4tgNdVPmgN9FZpYW
 STmoEkfDD+icAvw/SO+ogGWmj+n4hdxK+WhB8LQQC04itcidClZbieahRDQSUWmLnh+3
 PSxA==
X-Gm-Message-State: AGRZ1gJG9L/u1JmVUZxYogsCedQYujekR/1xpYDY67RgzYWBBg+Kx+lC
 Euvx67WRayuz5QHMAhoBp+Dtow==
X-Google-Smtp-Source: AJdET5ctCscFODEPbn/yoyf1Ns6z0NZ0bHOkoDOM6hIBx8Sdy8wtnp67zeIE7sjr1zu/AsWtPwDO4g==
X-Received: by 2002:a62:cac4:: with SMTP id
 y65-v6mr16264821pfk.27.1542481040868; 
 Sat, 17 Nov 2018 10:57:20 -0800 (PST)
Received: from mba13.psav.com ([64.114.255.114])
 by smtp.gmail.com with ESMTPSA id u76-v6sm49550745pfa.176.2018.11.17.10.57.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 17 Nov 2018 10:57:20 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] bpf: account for freed JIT allocations in arch code
Date: Sat, 17 Nov 2018 10:57:12 -0800
Message-Id: <20181117185715.25198-2-ard.biesheuvel@linaro.org>
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

Commit ede95a63b5e84 ("bpf: add bpf_jit_limit knob to restrict unpriv
allocations") added a call to bpf_jit_uncharge_modmem() to the routine
bpf_jit_binary_free() which is called from the __weak bpf_jit_free().
This function is overridden by arches, some of which do not call
bpf_jit_binary_free() to release the memory, and so the released
memory is not accounted for, potentially leading to spurious allocation
failures.

So replace the direct calls to module_memfree() in the arch code with
calls to bpf_jit_binary_free().

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/mips/net/bpf_jit.c           | 2 +-
 arch/powerpc/net/bpf_jit_comp.c   | 2 +-
 arch/powerpc/net/bpf_jit_comp64.c | 5 +----
 arch/sparc/net/bpf_jit_comp_32.c  | 2 +-
 4 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
index 4d8cb9bb8365..1b69897274a1 100644
--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -1264,7 +1264,7 @@ void bpf_jit_compile(struct bpf_prog *fp)
 void bpf_jit_free(struct bpf_prog *fp)
 {
 	if (fp->jited)
-		module_memfree(fp->bpf_func);
+		bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
 
 	bpf_prog_unlock_free(fp);
 }
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index d5bfe24bb3b5..a1ea1ea6b40d 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -683,7 +683,7 @@ void bpf_jit_compile(struct bpf_prog *fp)
 void bpf_jit_free(struct bpf_prog *fp)
 {
 	if (fp->jited)
-		module_memfree(fp->bpf_func);
+		bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
 
 	bpf_prog_unlock_free(fp);
 }
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 50b129785aee..84c8f013a6c6 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -1024,11 +1024,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 /* Overriding bpf_jit_free() as we don't set images read-only. */
 void bpf_jit_free(struct bpf_prog *fp)
 {
-	unsigned long addr = (unsigned long)fp->bpf_func & PAGE_MASK;
-	struct bpf_binary_header *bpf_hdr = (void *)addr;
-
 	if (fp->jited)
-		bpf_jit_binary_free(bpf_hdr);
+		bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
 
 	bpf_prog_unlock_free(fp);
 }
diff --git a/arch/sparc/net/bpf_jit_comp_32.c b/arch/sparc/net/bpf_jit_comp_32.c
index a5ff88643d5c..01bda6bc9e7f 100644
--- a/arch/sparc/net/bpf_jit_comp_32.c
+++ b/arch/sparc/net/bpf_jit_comp_32.c
@@ -759,7 +759,7 @@ cond_branch:			f_offset = addrs[i + filter[i].jf];
 void bpf_jit_free(struct bpf_prog *fp)
 {
 	if (fp->jited)
-		module_memfree(fp->bpf_func);
+		bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
 
 	bpf_prog_unlock_free(fp);
 }
-- 
2.17.1

