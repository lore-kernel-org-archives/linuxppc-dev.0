Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7724606A334
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 19:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hMq5xlLM
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVpN218cqz2yGT;
	Fri, 20 Nov 2026 06:25:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1346"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795116338;
	cv=none; b=c+7GROdu+/0DiOPDjxvzned4AW4ZiTlKY1A/poms6n2W7mlsJiZqVrcajsF/qBmXvxAtzR/7NdBCz6jbflfdOqrbQvtWMGOt9FeyWHFybcftCq/ScvUSaT7I2KAkAwB3OhWfPCl3L5jfQj08xyF6hMHgECa78RQNdaosD8Xxj0Q1HNVlUKbljymbqH2wBe2XDIqXsD0oVNqW8iU9v/VBx2YoP4X0glixKtH1Gwdyfr0mIAdZE58nQ7PNc0iouVPUI9eDGlh0HAGij4d43bhOa4TtvS38OPEGEtnUalTMcmElgXnfIeJyV1UfV9SVYiK3Nh3JOVuQfXl22GK9Y4NKfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795116338; c=relaxed/relaxed;
	bh=5sSK0mEpHDMvzrLQAsEFtk5LbI4UItSogecSbLV64WI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RnwFo7J+9GUDQePV0rEAxgBRTz9oaNVA/t8vrajpCqF1O8T7Rgl2eVnMCrbu8e3BNB0rIs4mk4c3ol0SPnqWP8triRhHHYlAH4vWrzLrB3835pApaiIkgGLI4XW198/hSvCgL8Pgin3zB/b57jbyG0WIWgW0olj5PnxXeRw+XIO4Yl6QAVeMy5V1Yzr1NqAh8PubvTcOHt8eJhbez3noMk1WVOoYlnvdnQmFfHJ0Lym6g9bGdv46PUe1uJZM1kuzTc5I6en8wNNxqi5NNo7ZkooySeT1iNTe3/mlk51esPK59fn7IwchXnDwl16zkiTBPULuZwS3i+vgv4UZxtGjEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hMq5xlLM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1346; helo=mail-dy1-x1346.google.com; envelope-from=3lk3_agckdcujsphfsthpphmf.dpnmjovyqqd-efwmjtut.pambct.psh@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hMq5xlLM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--irogers.bounces.google.com (client-ip=2607:f8b0:4864:20::1346; helo=mail-dy1-x1346.google.com; envelope-from=3lk3_agckdcujsphfsthpphmf.dpnmjovyqqd-efwmjtut.pambct.psh@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1346.google.com (mail-dy1-x1346.google.com [IPv6:2607:f8b0:4864:20::1346])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVpN10Xcpz2xH7
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 06:25:36 +1100 (AEDT)
Received: by mail-dy1-x1346.google.com with SMTP id 5a478bee46e88-38531c1a566so110533eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 11:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795116335; x=1795721135; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5sSK0mEpHDMvzrLQAsEFtk5LbI4UItSogecSbLV64WI=;
        b=hMq5xlLMX5OzkfQ2nJu+6BT168YrY+PVvxhWni+4pdJqcS5NYd+fPhK19bi9snuRGi
         nzvk9cz91aKXPmndd6eY5FdcUYICDTf7vWurJuqfXy5qZW95ybHigBdzWBeuAwSeNDMo
         uBte6Le+PiE3h76PGqyZ3OgaIMWzKds7VbbYoWzUkWUg7ylPHbAS6sKLVfJrX+MsQYBT
         0sNSYanUPB3N3YM8/jbRrb+R+CbPgusgn+WXNEWnJLpdJpG9zR3XzrCcaSbbvvyADHvb
         UZ8nctdycoza55eevmoLh9X9WtImeyH4s8bs914afZc9u5/C9b4Zvb1xIWpy1cECOSLE
         P1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116335; x=1795721135;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5sSK0mEpHDMvzrLQAsEFtk5LbI4UItSogecSbLV64WI=;
        b=ZW+Qd/BuWSmRNzwU1WuRPMKIPrIc7FlFFHbtvdPlbgW7jebvWW1CwFVngAkgN8ECTf
         fbwNLYGmA+z5JodwG6davLykCTRZTljmmhpkmS6hdVmzD4duQ+lsUbm1nxoR+N5pQD2v
         /OLQKIbeqztGbM9nDSLkRRLhCoEiskY13qShI94tqjqlL4AREGB10Kx6Ov+/gM7qo0pp
         ydTfDYRcXJkT9uQPVXu5uESmV8gS3KVLxT7nU3Etgjk4DS8iFn7/ecSIuLjT/ieBUWBV
         kYhXKk1RUdbHNZDS0dlQgMGDiL0wYzNmWm6crbS7igGZ2yh3tNL6Nw2Y/DnxKaRkZPYy
         RHgA==
X-Forwarded-Encrypted: i=1; AL+hErFEqqqhmVBIqV8U317/OOaJZZwOBqubfSP3lxUe2JxgOMA+qZDfRqvhHRwUiPvUuVthSsd/6J7hpToDmco=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+0UHIxk63eh9ld+ehBhvq0VWMOxniW+rgL/6Cdn6HgPWE6C+Bi
	jieKPNP8sSdfZV7XzI5C4xkv++kJ9pfKdpkViTr5vwk+hDcyM7r5JTG37okL61YAlLVWWoHJcB8
	YY32eXYd1Gw==
X-Received: from dybqm10.prod.google.com ([2002:a05:7301:670a:b0:385:6c3c:3ea1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:152f:b0:381:c532:3d88
 with SMTP id 5a478bee46e88-3857093c38bmr360600eec.23.1795116334302; Thu, 19
 Nov 2026 11:25:34 -0800 (PST)
Date: Thu, 19 Nov 2026 11:25:12 -0800
In-Reply-To: <20261119192520.1983406-1-irogers@google.com>
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
References: <20261119192520.1983406-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261119192520.1983406-2-irogers@google.com>
Subject: [PATCH v4 1/9] Compiler Attributes: Add __must_init macro
From: Ian Rogers <irogers@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Srish Srinivasan <ssrish@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Alexander Aring <aahringo@redhat.com>, 
	Felix Kuehling <felix.kuehling@amd.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
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

Note that Clang versions prior to the fix for
https://github.com/llvm/llvm-project/issues/232483 do not diagnose
file-scope objects declared without any initializer (initializers at
file scope that omit the field are diagnosed).

Also teach Sphinx (Documentation/conf.py), kernel-doc
(tools/lib/python/kdoc/xforms_lists.py), and checkpatch.pl about the new
attribute macro.

Link: https://lpc.events/event/20/contributions/2392/
Link: https://lore.kernel.org/lkml/2026101532-fantastic-deafness-e04c@gregkh/
Acked-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Kees Cook <kees@kernel.org>
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
index b8b64f720191..6a091c45b1a1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6888,6 +6888,7 @@ sub process {
 				"noreturn"			=> "__noreturn",
 				"packed"			=> "__packed",
 				"pure"				=> "__pure",
+				"require_explicit_initialization" => "__must_init",
 				"section"			=> "__section",
 				"used"				=> "__used",
 				"weak"				=> "__weak"
diff --git a/tools/lib/python/kdoc/xforms_lists.py b/tools/lib/python/kdoc/xforms_lists.py
index db23fb650ea8..42956b98aae3 100644
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
2.56.1.708.g77570a6a1d-goog


