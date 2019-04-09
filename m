Return-Path: <SRS0=YLyy=SL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77CDC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 21:29:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B7D320883
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 21:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="SZQYcuuG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7D320883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44f0mh04V0zDqLp
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 07:29:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=rasmusvillemoes.dk
 (client-ip=2a00:1450:4864:20::541; helo=mail-ed1-x541.google.com;
 envelope-from=linux@rasmusvillemoes.dk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.b="SZQYcuuG"; dkim-atps=neutral
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44f0hS415QzDqJ8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 07:26:00 +1000 (AEST)
Received: by mail-ed1-x541.google.com with SMTP id b8so157462edq.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Apr 2019 14:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kEKRMgTdUMek0P/9cZkgQ7AhOi9UL44pxpzfZBdVTbQ=;
 b=SZQYcuuGVGNexBIYNpHl92Z1XaLRJNK3QCmDGLBQHFeMw7/S4V78CkHL3Nrfq/eBeW
 68IBeIT/+0ltr2PtwIwq10G8VBoTSjpH3GGA2rrcXPPqxIKk1rNKk5B/fQi0jMEUOq79
 nO3WDv2Zne+MY8NqQ6IYD3Lmewll2BmehxZEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kEKRMgTdUMek0P/9cZkgQ7AhOi9UL44pxpzfZBdVTbQ=;
 b=EZRy2ppPdJTZdIUakMw/twJ/38vkd8nghHXNMWZCXqy+JXiIFIQPTXQYfyHI84D1e7
 ffUaqO+pCUPcQPGKi+/+UTwmLXr23wMFthtbkL46NxGw7/l06m0sWD/opY6UXPiO3vGy
 7Rd8TEKXU6gXJ3MdmlvGqvWoqzSJNeMR69MkrhLI/qibd7FRjVhdo0XUXdRahC1s61ZJ
 00xJbAmkHPaKUNNGOoFPiyQ8i8w9QYHZZXHR8hksa1r/pSqg6N6EFQm0wphLdbhaPRrQ
 9EnmAMIbyieR7AQtWgUc5mrcf94JRaf+Kfjq4gSpJKLbSWxtZAvVDvMu6SsHGxHWG/CX
 SPbg==
X-Gm-Message-State: APjAAAULsFmSS14ZxRorIawuOLsAhhWVk62WHh2hLT4dtoO+VR/ZUyiv
 SiF4OxvCSyHTaB4B5NhPPnrASQ==
X-Google-Smtp-Source: APXvYqzZ5D2KYrx93GaBAbC2zdBqr+ZenMBgK9mqbjeMrwbokKxtJEi7Bp1zfO8sOqBGxrRdvJab+w==
X-Received: by 2002:a50:e844:: with SMTP id k4mr24220032edn.249.1554845157684; 
 Tue, 09 Apr 2019 14:25:57 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-118-63.cgn.fibianet.dk.
 [5.186.118.63])
 by smtp.gmail.com with ESMTPSA id i26sm3477986ejc.51.2019.04.09.14.25.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Apr 2019 14:25:57 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 07/10] dynamic_debug: add asm-generic implementation for
 DYNAMIC_DEBUG_RELATIVE_POINTERS
Date: Tue,  9 Apr 2019 23:25:14 +0200
Message-Id: <20190409212517.7321-8-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190409212517.7321-1-linux@rasmusvillemoes.dk>
References: <20190409212517.7321-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: x86@kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
 Jason Baron <jbaron@akamai.com>, Ingo Molnar <mingo@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

A 64 bit architecture can reduce the size of the kernel image by
selecting CONFIG_DYNAMIC_DEBUG_RELATIVE_POINTERS, but it must provide
a proper DEFINE_DYNAMIC_DEBUG_METADATA macro for emitting the struct
_ddebug in assembly. However, since that does not involve any
instructions, this generic implementation should be usable by most if
not all.

It relies on

(1) standard assembly directives that should work on
all architectures
(2) the "i" constraint for an constant, and
(3) %cN emitting the constant operand N without punctuation

and of course the layout of _ddebug being what one expects. I've
succesfully built x86-64, arm64 and ppc64 defconfig +
CONFIG_DYNAMIC_DEBUG + patches to hook up this header, and boot-tested
the x86-64 one.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/asm-generic/dynamic_debug.h | 116 ++++++++++++++++++++++++++++
 include/linux/jump_label.h          |   2 +
 2 files changed, 118 insertions(+)
 create mode 100644 include/asm-generic/dynamic_debug.h

diff --git a/include/asm-generic/dynamic_debug.h b/include/asm-generic/dynamic_debug.h
new file mode 100644
index 000000000000..f1dd3019cd98
--- /dev/null
+++ b/include/asm-generic/dynamic_debug.h
@@ -0,0 +1,116 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_GENERIC_DYNAMIC_DEBUG_H
+#define _ASM_GENERIC_DYNAMIC_DEBUG_H
+
+#ifndef _DYNAMIC_DEBUG_H
+#error "don't include asm/dynamic_debug.h directly"
+#endif
+
+#include <linux/build_bug.h>
+#ifdef CONFIG_JUMP_LABEL
+#include <linux/jump_label.h>
+#endif
+
+/*
+ * We need to know the exact layout of struct _ddebug in order to
+ * initialize it in assembly. Check that all members are at expected
+ * offsets - if any of these fail, the arch cannot use this generic
+ * dynamic_debug.h. DYNAMIC_DEBUG_RELATIVE_POINTERS is pointless for
+ * !64BIT, so we expect the static_key to be at an 8-byte boundary
+ * since it contains stuff which is long-aligned.
+ */
+
+static_assert(BITS_PER_LONG == 64);
+static_assert(offsetof(struct _ddebug, modname_disp)  == 0);
+static_assert(offsetof(struct _ddebug, function_disp) == 4);
+static_assert(offsetof(struct _ddebug, filename_disp) == 8);
+static_assert(offsetof(struct _ddebug, format_disp)   == 12);
+static_assert(offsetof(struct _ddebug, flags_lineno)  == 16);
+
+#ifdef CONFIG_JUMP_LABEL
+static_assert(offsetof(struct _ddebug, key)        == 24);
+static_assert(offsetof(struct static_key, enabled) == 0);
+static_assert(offsetof(struct static_key, type)    == 8);
+
+/* <4 bytes padding>, .enabled, <4 bytes padding>, .type */
+# ifdef DEBUG
+# define _DPRINTK_ASM_KEY_INIT \
+	"\t.int 0\n" "\t.int 1\n" "\t.int 0\n" "\t.quad "__stringify(__JUMP_TYPE_TRUE)"\n"
+# else
+# define _DPRINTK_ASM_KEY_INIT \
+	"\t.int 0\n" "\t.int 0\n" "\t.int 0\n" "\t.quad "__stringify(__JUMP_TYPE_FALSE)"\n"
+# endif
+#else /* !CONFIG_JUMP_LABEL */
+#define _DPRINTK_ASM_KEY_INIT ""
+#endif
+
+/*
+ * There's a bit of magic involved here.
+ *
+ * First, unlike the bug table entries, we need to define an object in
+ * assembly which we can reference from C code (for use by the
+ * DYNAMIC_DEBUG_BRANCH macro), but we don't want 'name' to have
+ * external linkage (that would require use of globally unique
+ * identifiers, which we can't guarantee). Fortunately, the "extern"
+ * keyword just tells the compiler that _somebody_ provides that
+ * symbol - usually that somebody is the linker, but in this case it's
+ * the assembler, and since we do not do .globl name, the symbol gets
+ * internal linkage.
+ *
+ * So far so good. The next problem is that there's no scope in
+ * assembly, so the identifier 'name' has to be unique within each
+ * translation unit - otherwise all uses of that identifier end up
+ * referring to the same struct _ddebug instance. pr_debug and friends
+ * do this by use of indirection and __UNIQUE_ID(), and new users of
+ * DEFINE_DYNAMIC_DEBUG_METADATA() should do something similar. We
+ * need to catch cases where this is not done at build time.
+ *
+ * With assembly-level .ifndef we can ensure that we only define a
+ * given identifier once, preventing "symbol 'foo' already defined"
+ * errors. But we still need to detect and fail on multiple uses of
+ * the same identifer. The simplest, and wrong, solution to that is to
+ * add an .else .error branch to the .ifndef. The problem is that just
+ * because the DEFINE_DYNAMIC_DEBUG_METADATA() macro is only expanded
+ * once with a given identifier, the compiler may emit the assembly
+ * code multiple times, e.g. if the macro appears in an inline
+ * function. Now, in a normal case like
+ *
+ *   static inline get_next_id(void) { static int v; return ++v; }
+ *
+ * all inlined copies of get_next_id are _supposed_ to refer to the
+ * same object 'v'. So we do need to allow this chunk of assembly to
+ * appear multiple times with the same 'name', as long as they all
+ * came from the same DEFINE_DYNAMIC_DEBUG_METADATA() instance. To do
+ * that, we pass __COUNTER__ to the asm(), and set an assembler symbol
+ * name.ddebug.once to that value when we first define 'name'. When we
+ * meet a second attempt at defining 'name', we compare
+ * name.ddebug.once to %6 and error out if they are different.
+ */
+
+#define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)			\
+	extern struct _ddebug name;					\
+	asm volatile(".ifndef " __stringify(name) "\n"			\
+		     ".pushsection __verbose,\"aw\"\n"			\
+		     ".type "__stringify(name)", STT_OBJECT\n"		\
+		     ".size "__stringify(name)", %c5\n"			\
+		     "1:\n"						\
+		     __stringify(name) ":\n"				\
+		     "\t.int %c0 - 1b /* _ddebug::modname_disp */\n"	\
+		     "\t.int %c1 - 1b /* _ddebug::function_disp */\n"	\
+		     "\t.int %c2 - 1b /* _ddebug::filename_disp */\n"	\
+		     "\t.int %c3 - 1b /* _ddebug::format_disp */\n"	\
+		     "\t.int %c4      /* _ddebug::flags_lineno */\n"	\
+		     _DPRINTK_ASM_KEY_INIT				\
+		     "\t.org 1b+%c5\n"					\
+		     ".popsection\n"					\
+		     ".set "__stringify(name)".ddebug.once, %c6\n"	\
+		     ".elseif "__stringify(name)".ddebug.once - %c6\n"	\
+		     ".line "__stringify(__LINE__) " - 1\n"             \
+		     ".error \"'"__stringify(name)"' used as _ddebug identifier more than once\"\n" \
+		     ".endif\n"						\
+		     : : "i" (KBUILD_MODNAME), "i" (__func__),		\
+		       "i" (__FILE__), "i" (fmt),			\
+		       "i" (_DPRINTK_FLAGS_LINENO_INIT),		\
+		       "i" (sizeof(struct _ddebug)), "i" (__COUNTER__))
+
+#endif /* _ASM_GENERIC_DYNAMIC_DEBUG_H */
diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 3e113a1fa0f1..2b027d2ef3d0 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -190,6 +190,8 @@ struct module;
 
 #ifdef CONFIG_JUMP_LABEL
 
+#define __JUMP_TYPE_FALSE	0
+#define __JUMP_TYPE_TRUE	1
 #define JUMP_TYPE_FALSE		0UL
 #define JUMP_TYPE_TRUE		1UL
 #define JUMP_TYPE_LINKED	2UL
-- 
2.20.1

