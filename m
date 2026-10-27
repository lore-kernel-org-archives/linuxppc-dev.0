Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789BC60A260E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 22:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nCwUZsXO
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDlm441Rdz2yY0;
	Wed, 28 Oct 2026 09:39:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1347"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793140756;
	cv=none; b=jzM6kCfWRm8ed9IwDZsbbRFihRH4wzbJNIE51XnkL7R1lizhFCCqTE80UzTWsy5WBulXZnZ43yIlHJR+sR1sgV2PyAzKdBzKKygPeiAp/o4AhiyDr9GoS4pAHVeh+fAdJJYJ7Je3nyjzuPu9fiiARBVKAFatsx3P8QWJXUQFelnhwmw3iW6n22NSW094l6W6ISsMCJ7Yk/WrUQlBhyRkQ6hVrgg2zJpr5V0M5tfMw7kHtzXtE1wZZvvaJm8YIN7BpEPeJUQyVVY7HqWPK9GuWty2N68BWbaSwlk8HUaptZj3pfivHdBgw5fqX1cgvt2zQHEetTClFGd/US1C7eorXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793140756; c=relaxed/relaxed;
	bh=dWBu3E1+9O630leKOxiPf33Qem+izCRkowC6gFS9sVM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WGCJ5GVqrPgOL6QKkWS6hH3gt6EwPkw83I1QVfTNUdz63sTmbChJuAFSdEzDNlfkoUEwbUFfVsjOW2L3YddsXZ/4q5rplYo1/63w9VvZABBCOM46j3yqyXCfn5TAek+rAkmadyMk4HSryKmWZxCM4cGUftjazoj6ncKvzBpXiyPEwufNmRNsDgHza5nCKmLe9+PX7I8lGNnZd35dk5VhVxl5M+/Mytuf7JjfE5Sy/Jq01cy+p0lf44wVn6N8P7wtMbW1+D1c7d8NqKfLHCCYAlCfzs8iz5lExPdGkE9Xh6boLiF/1s+oWy4GjgnTsr+NuKaNCa8r0aIQKHmI+SDznA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nCwUZsXO; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1347; helo=mail-dy1-x1347.google.com; envelope-from=3dyjhagckdeimvskivwksskpi.gsqpmry1ttg-hizpmwxw.s3pefw.svk@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nCwUZsXO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--irogers.bounces.google.com (client-ip=2607:f8b0:4864:20::1347; helo=mail-dy1-x1347.google.com; envelope-from=3dyjhagckdeimvskivwksskpi.gsqpmry1ttg-hizpmwxw.s3pefw.svk@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1347.google.com (mail-dy1-x1347.google.com [IPv6:2607:f8b0:4864:20::1347])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDlm31dc0z2xjh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 09:39:14 +1100 (AEDT)
Received: by mail-dy1-x1347.google.com with SMTP id 5a478bee46e88-30bcb065bfdso523841eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 15:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793140753; x=1793745553; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dWBu3E1+9O630leKOxiPf33Qem+izCRkowC6gFS9sVM=;
        b=nCwUZsXOY9r1r1uZoEbhaG+I0BGThlUURzFRwfSD3QWWRlSLdmCM+5RAc2jVZyI2DO
         ifRFXSBDlSTje9wSLO/ljP7ruKLoJl92gYxk8dXebZx543WrYj4B1hmfurpJc0MDiBrJ
         WCHKHCsEHIL+wC19hyeBtXap6NMdFOGWJwqwvh9prH04Cpl1Lw7ghPlNmMaeZQzxQQ4W
         lQ/igt1A3z4mgM48+1oMCgtXjymkjLn/2MHG0S5y1zwPUmPEXJuDzo/SFnG6rNhu6P+6
         aNJuDKAOEyPivID2bfKF09xdsOB4tjNR9GjrMEOCIcdwYT05439GOGhteXK31RzMUq2P
         CChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140753; x=1793745553;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dWBu3E1+9O630leKOxiPf33Qem+izCRkowC6gFS9sVM=;
        b=xha1KnQrQz+ddWzukFbpRbmo5ZAPmQ4QBW6LwCRarczo6pjSzFYu1HfGgmR793cn3V
         NJZ5pNInjOrGUP8rC+Y9Tiw/9SrVKDPLs53sb3SJrEyFPd6LnfAhxdJOtgpUk8aBBpgR
         AYeSDdSxaIscfcvMrrbNj4ZcKcMbPcHUIjCEzhoXWUs48idIKzW+w6P+nhQEMYzWxYtD
         XUEwHMV4b9o6if5/2PVTVEJSv2UpwqZujkYvfZVotHiI69KLNSV53objHgVs5EQgdybr
         LSs2ueJQEh/z8wUg0zpbxGd8lrzBv54eMtbTU2q2C8y/gZwMjFUDnA8DqnORau8IgiLe
         DkIA==
X-Forwarded-Encrypted: i=1; AKwUvBwtVonSG4taexzMY+jRGxchPa1W5YFg6txs10o2HXAWWnRHY5AfLtsxGIs+VtzzrFjCg+fUHbXQaWA+UpY=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYI3w6BKEy4FmmGp7yLVlt4Zp0kYyzfQsUnfM4qH13LtFn7G+CUd
	Jl2J4sFc1uKlvO2q5UeD9oqnq5ewZXiPsFpjlGriEQwehMMtz3d1go6QhiCIVHljck6rf5EQpOz
	fenZ5yl2EVA==
X-Received: from dybnl11.prod.google.com ([2002:a05:7300:cf8b:b0:36a:117:523b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:250d:b0:369:f5f6:36a7
 with SMTP id 5a478bee46e88-36a2014b887mr1132027eec.16.1793140751881; Tue, 27
 Oct 2026 15:39:11 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:38:36 -0700
In-Reply-To: <20261027223847.652884-1-irogers@google.com>
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
Mime-Version: 1.0
References: <20261027223847.652884-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261027223847.652884-2-irogers@google.com>
Subject: [PATCH v2 1/9] Compiler Attributes: Add __must_init macro
From: Ian Rogers <irogers@google.com>
To: Kees Cook <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-31.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Clang supports the 'require_explicit_initialization' attribute on struct
fields to indicate that a field must be initialized explicitly by the
user when the object is constructed. When an aggregate initializer or
uninitialized variable omits an annotated field, Clang emits a
-Wuninitialized-explicit-init warning (enabled by default).

Add the __must_init macro to include/linux/compiler_attributes.h (which
is included by include/linux/compiler_types.h and
include/linux/compiler.h) so kernel structs with error-prone
initialization (such as mandatory callbacks or cleanup handlers) can
enforce explicit initialization at compile time, as discussed at the
Linux Plumbers Conference. The shorter __must_init spelling, rather than
the attribute's full name, keeps annotated struct members readable and
was suggested by Greg Kroah-Hartman.

Note that Clang does not yet diagnose file-scope objects declared
without any initializer (initializers at file scope that omit the field
are diagnosed), see https://github.com/llvm/llvm-project/issues/232483.

Also teach Sphinx (Documentation/conf.py), kernel-doc
(tools/lib/python/kdoc/xforms_lists.py), and checkpatch.pl about the new
attribute macro.

Link: https://lpc.events/event/20/contributions/2392/
Link: https://lore.kernel.org/lkml/2026101532-fantastic-deafness-e04c@gregkh/
Acked-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 Documentation/conf.py                 |  1 +
 include/linux/compiler_attributes.h   | 12 ++++++++++++
 scripts/checkpatch.pl                 |  1 +
 tools/lib/python/kdoc/xforms_lists.py |  1 +
 4 files changed, 15 insertions(+)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 5ab26ce89daf..baaa4035258c 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -203,6 +203,7 @@ c_id_attributes = [
     "__noreturn",
     "__packed",
     "__pure",
+    "__must_init",
     "__section",
     "__always_unused",
     "__maybe_unused",
diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 476c4c560d17..b9c0b56dd22e 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -322,6 +322,18 @@
  */
 #define __pure                          __attribute__((__pure__))
 
+/*
+ * Optional: not supported by gcc
+ * Optional: only supported since clang >= 20.0
+ *
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#require-explicit-initialization
+ */
+#if __has_attribute(__require_explicit_initialization__)
+# define __must_init __attribute__((__require_explicit_initialization__))
+#else
+# define __must_init
+#endif
+
 /*
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-section-function-attribute
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-section-variable-attribute
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index c9840f5219c2..5232f66d2b80 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6860,6 +6860,7 @@ sub process {
 				"noreturn"			=> "__noreturn",
 				"packed"			=> "__packed",
 				"pure"				=> "__pure",
+				"require_explicit_initialization" => "__must_init",
 				"section"			=> "__section",
 				"used"				=> "__used",
 				"weak"				=> "__weak"
diff --git a/tools/lib/python/kdoc/xforms_lists.py b/tools/lib/python/kdoc/xforms_lists.py
index 320f977c5bac..3c744cbd2f34 100644
--- a/tools/lib/python/kdoc/xforms_lists.py
+++ b/tools/lib/python/kdoc/xforms_lists.py
@@ -36,6 +36,7 @@ class CTransforms:
         (CMatch("CRYPTO_MINALIGN_ATTR"), ""),
         (CMatch("__private"), ""),
         (CMatch("__rcu"), ""),
+        (CMatch("__must_init"), ""),
         (CMatch("____cacheline_aligned_in_smp"), ""),
         (CMatch("____cacheline_aligned"), ""),
         (CMatch("__cacheline_group_(?:begin|end)"), ""),
-- 
2.56.0.313.g2479322e68-goog


