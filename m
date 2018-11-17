Return-Path: <SRS0=8VeL=N4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E77C43441
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 18:59:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C64F520815
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 18:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XYLhyO5m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C64F520815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42y4Cq1NVszF3J6
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Nov 2018 05:59:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XYLhyO5m";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=ard.biesheuvel@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="XYLhyO5m"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42y4911VSFzF3kk
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Nov 2018 05:57:25 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id v28so1526179pgk.10
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Nov 2018 10:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=26kHMy6e9ZHNMFq26DfYcP5qT10rPVni7XnqYDLJuPI=;
 b=XYLhyO5mN3FVA4ReKitsYfMKGuHNDNlOhuo5CX3m1WdOPZeKdKBplc4oZZ6V6yFg5A
 hQ83SmcdvQq6M0spjr5rwWJUh9QdiW39oPX0Z2kNZVWF+j0XU6sZnr/m82angEa1AG65
 GQ2t7WMlRjYOWyc5If1zGyUDez/kBmIctb+b4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=26kHMy6e9ZHNMFq26DfYcP5qT10rPVni7XnqYDLJuPI=;
 b=Cl23jmhKEZQP2IDWODPoj7HOf5Z+YSGKE6b1v9Lk9NLFTpLeyytVxDs9QRqmFUVsRl
 tVduzfcZr5MxnmIAN9OMvZeHyJEVG0bfFYOm69GbIQNhfo24HN8q3uIYcqNluXlALjvJ
 oE3XFhgX4uOlb5taQrbGg8eTas0ugzsP86iKutPpEgP/YcwAX/91eBMby/P4is1LzcxY
 tMTkmsW+5cMJ2VcfZNIjtUbYmWP+kApPwcayLWP1UgQh5D0ZC2boKFtjziP0byXDrBuC
 v3qOOaGF1QMgvy96C161VP92mYUE0JADCuLBNlDX4OJDFL9b8BttwitOiTxp1Z4tg8Oy
 7JeA==
X-Gm-Message-State: AGRZ1gJKNYNJk3/bzQAqykNIumLbaGN/aIgV0QFk/O5UILmx3nUp3uoj
 Od+DJwVrM/fbP3IRw3TWEEEZ0g==
X-Google-Smtp-Source: AJdET5dbJskaau0oeh2D+j2r5+z2XCOLI6qC1Gpj92MrCzlhVrhcUg2kk12XFX1xpT0h9FiUT1nBcw==
X-Received: by 2002:a63:f241:: with SMTP id d1mr14569834pgk.2.1542481043353;
 Sat, 17 Nov 2018 10:57:23 -0800 (PST)
Received: from mba13.psav.com ([64.114.255.114])
 by smtp.gmail.com with ESMTPSA id u76-v6sm49550745pfa.176.2018.11.17.10.57.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 17 Nov 2018 10:57:22 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] bpf: add __weak hook for allocating executable memory
Date: Sat, 17 Nov 2018 10:57:14 -0800
Message-Id: <20181117185715.25198-4-ard.biesheuvel@linaro.org>
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

By default, BPF uses module_alloc() to allocate executable memory,
but this is not necessary on all arches and potentially undesirable
on some of them.

So break out the module_alloc() call into a __weak function to allow
it to be overridden in arch code.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 kernel/bpf/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 29f766dac203..156d6b96ac6c 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -609,6 +609,11 @@ static void bpf_jit_uncharge_modmem(u32 pages)
 	atomic_long_sub(pages, &bpf_jit_current);
 }
 
+void *__weak bpf_jit_alloc_exec(unsigned long size)
+{
+	return module_alloc(size);
+}
+
 struct bpf_binary_header *
 bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
 		     unsigned int alignment,
@@ -626,7 +631,7 @@ bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
 
 	if (bpf_jit_charge_modmem(pages))
 		return NULL;
-	hdr = module_alloc(size);
+	hdr = bpf_jit_alloc_exec(size);
 	if (!hdr) {
 		bpf_jit_uncharge_modmem(pages);
 		return NULL;
-- 
2.17.1

