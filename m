Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBDBC00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 08:16:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 259652064D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 08:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MWd+hOYP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 259652064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RMzP6kWdzF3Mb
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 18:16:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MWd+hOYP";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2a00:1450:4864:20::344; helo=mail-wm1-x344.google.com;
 envelope-from=ard.biesheuvel@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="MWd+hOYP"; 
 dkim-atps=neutral
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RMw70nrtzF3Jh
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 18:13:42 +1000 (AEST)
Received: by mail-wm1-x344.google.com with SMTP id a8-v6so1022890wmf.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 01:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=M974k2iyDJIOjsCt9yr954r2LChEqIlYPLi3JqN8ezM=;
 b=MWd+hOYP/XT8JhDN37zPYJpwEJYaMjz+DGw/Gv25gw+eg0s/a5gjnsTq2fxMFRjXfa
 XOMVBcpP7CyWqNHbBWmey7hjHyMNnG+gxrzc/jDFOObGBsroeG0GPzJLFwCtev3yPYQp
 vVyxleV0C7JUqQAW22vpLbZCcIWLOpw1cxhDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=M974k2iyDJIOjsCt9yr954r2LChEqIlYPLi3JqN8ezM=;
 b=kde0CtfEzr7T4AlAcbX1SMLOGt9QFv2tX4haYrsb0XDlCKuvJVICbJcQZJJe0Epgri
 ty/euquNtdwbMx775e/T5NU1/En2eYveEHXAMtF6nGuHoijIkPfRMpWRcYO1GLwFTjAT
 Ds535gEPqpjBBoMAvtNFiqZA4NjeliwC+TJRKJS79chPrGVKVx2QZa8xs+BItj+ZjPqP
 Y84w4bTxCXZM7BDxYveAAWOEeCLYduc3gtBWOITkw0IiUTqZuQprMz5ZMmfRWA5IyTV7
 +W96atd+yKRyEJ/6B6CZWMB1rTZyKuCSB2mReAAQRkDfAnUcrqmGoM1ReUjmAaZM51Lv
 8nsA==
X-Gm-Message-State: ABuFfoj54PkCO0Fj5NNLsNLuVgS29J3tWxOdc/54TAOoAg74LI8Zr2nG
 aUVvpaM2iemUznk3PkHtwYTQ5Q==
X-Google-Smtp-Source: ACcGV614x+adL4bvBW2ETzXeZ17LWqoKCU2QTWwE8UtRdZ8cX4K5Bkp1v89Z9ZQ2IkgyOmpJzyMJig==
X-Received: by 2002:a1c:9901:: with SMTP id b1-v6mr4381093wme.15.1538727220155; 
 Fri, 05 Oct 2018 01:13:40 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:112:6f00:697e:67d9:a05d:22c7])
 by smtp.gmail.com with ESMTPSA id t4-v6sm6565620wrb.45.2018.10.05.01.13.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Oct 2018 01:13:39 -0700 (PDT)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/9] kernel: add support for patchable function pointers
Date: Fri,  5 Oct 2018 10:13:25 +0200
Message-Id: <20181005081333.15018-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
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
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Samuel Neves <sneves@dei.uc.pt>, Paul Mackerras <paulus@samba.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Richard Weinberger <richard@nod.at>,
 Eric Biggers <ebiggers@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-crypto@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add a function pointer abstraction that can be implemented by the arch
in a manner that avoids the downsides of function pointers, i.e., the
fact that they are typically located in a writable data section, and
their vulnerability to Spectre like defects.

The FFP (or fast function pointer) is callable as a function, since
the generic incarnation is simply that. However, due to the fact that
C does not distinguish between functions and function pointers at the
call site, the architecture can instead emit it as a patchable sequence
of instructions consisting of ordinary branches.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/Kconfig        |  3 ++
 include/linux/ffp.h | 43 ++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 6801123932a5..2af3442a61d3 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -862,6 +862,9 @@ config HAVE_ARCH_PREL32_RELOCATIONS
 	  architectures, and don't require runtime relocation on relocatable
 	  kernels.
 
+config HAVE_ARCH_FFP
+	bool
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
diff --git a/include/linux/ffp.h b/include/linux/ffp.h
new file mode 100644
index 000000000000..8fc3b4c9b38f
--- /dev/null
+++ b/include/linux/ffp.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __LINUX_FFP_H
+#define __LINUX_FFP_H
+
+#include <linux/types.h>
+#include <linux/compiler.h>
+
+#ifdef CONFIG_HAVE_ARCH_FFP
+#include <asm/ffp.h>
+#else
+
+struct ffp {
+	void	(**fn)(void);
+	void	(*default_fn)(void);
+};
+
+#define DECLARE_FFP(_fn, _def)						\
+	extern typeof(_def) *_fn;					\
+	extern struct ffp const __ffp_ ## _fn
+
+#define DEFINE_FFP(_fn, _def)						\
+	typeof(_def) *_fn = &_def;					\
+	struct ffp const __ffp_ ## _fn					\
+		= { (void(**)(void))&_fn, (void(*)(void))&_def };	\
+	EXPORT_SYMBOL(__ffp_ ## _fn)
+
+static inline void ffp_set_target(const struct ffp *m, void *new_fn)
+{
+	WRITE_ONCE(*m->fn, new_fn);
+}
+
+static inline void ffp_reset_target(const struct ffp *m)
+{
+	WRITE_ONCE(*m->fn, m->default_fn);
+}
+
+#endif
+
+#define SET_FFP(_fn, _new)	ffp_set_target(&__ffp_ ## _fn, _new)
+#define RESET_FFP(_fn)		ffp_reset_target(&__ffp_ ## _fn)
+
+#endif
-- 
2.11.0

