Return-Path: <SRS0=8VeL=N4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1062BC43441
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 19:06:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F3A920815
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 19:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KAW8uS2e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F3A920815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42y4Mb4Xn0zF3m0
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Nov 2018 06:06:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KAW8uS2e";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=ard.biesheuvel@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="KAW8uS2e"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42y492289czF3ks
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Nov 2018 05:57:26 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id w7so12012472pgp.13
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Nov 2018 10:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=JmtMWaiD9FenKM3ns0kNxP2J4QR+RUeNI/5TJ/tQ45I=;
 b=KAW8uS2esdTjeBcDfFodpTuBiPuzrfOgpEvhmkdmizzqp7CMEjaFC2ORlF9MeL+yeA
 stdwlyxwK9cJAK+MAYm3DEfW4lRgMCiJRj3yewaXsrtQx5DmclC4R/K9qjVetVNcal+H
 pjN2zNK/65b6+lBFp6r24jInRxn3xDvrMAU8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=JmtMWaiD9FenKM3ns0kNxP2J4QR+RUeNI/5TJ/tQ45I=;
 b=T0Ec2IalCFYwOv1W/gHMilEzmmOwlOOv86kcxCtxL4ja+SgYKJZJYOErQwZOwTP70u
 Xi2o67Dj3aLXXrx2nPepk+4mAHmyUFJv6Sv5zo3i9Gxxp2jJ1jWokcz11Hiogy5iLqs0
 JDDvi1IbY0p0YWiJCDsCKpGfMAZIMBi8OqQNrZ8rANnc0qpNe7PerbEzlTNdXfnVaAgr
 /C9QO5Eh/ggf9AeeTcPFHpAS+TKYOa4jguekc8j8e03/S8VLf4w/IhUVtS7UiFjEIyoh
 BbAcWQ1Tx+FLJxxcewgWBEGYgYcKqh2TS3q8Ayiwczz8mM/UR8mNKswcu8CHFy1nGAV7
 rQWA==
X-Gm-Message-State: AGRZ1gK2jcnHp4p5lGC1ac/v7ej02T9/FKvIFQqVeO6rlDXedlwZM+7n
 2TpkLBMKuZkoaWAnDUTPl9YIrg==
X-Google-Smtp-Source: AJdET5epwL8opIfWAHhuSBY1hNn/GKz9erLG44ejL6V5gIz84eLRbi+P5B/LB3RozshYttdcdgtQpg==
X-Received: by 2002:a62:ed09:: with SMTP id
 u9-v6mr16036733pfh.188.1542481044594; 
 Sat, 17 Nov 2018 10:57:24 -0800 (PST)
Received: from mba13.psav.com ([64.114.255.114])
 by smtp.gmail.com with ESMTPSA id u76-v6sm49550745pfa.176.2018.11.17.10.57.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 17 Nov 2018 10:57:23 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64/bpf: don't allocate BPF JIT programs in module
 memory
Date: Sat, 17 Nov 2018 10:57:15 -0800
Message-Id: <20181117185715.25198-5-ard.biesheuvel@linaro.org>
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

The arm64 module region is a 128 MB region that is kept close to
the core kernel, in order to ensure that relative branches are
always in range. So using the same region for programs that do
not have this restriction is wasteful, and preferably avoided.

Now that the core BPF JIT code permits the alloc/free routines to
be overridden, implement them by simple vmalloc_exec()/vfree()
calls, which can be served from anywere. This also solves an
issue under KASAN, where shadow memory is needlessly allocated for
all BPF programs (which don't require KASAN shadow pages since
they are not KASAN instrumented)

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/net/bpf_jit_comp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index a6fdaea07c63..e0c702c2f682 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -940,3 +940,14 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 					   tmp : orig_prog);
 	return prog;
 }
+
+void *bpf_jit_alloc_exec(unsigned long size)
+{
+	return vmalloc_exec(size);
+}
+
+void bpf_jit_binary_free(struct bpf_binary_header *hdr)
+{
+	bpf_jit_binary_unlock_ro(hdr);
+	vfree(hdr);
+}
-- 
2.17.1

