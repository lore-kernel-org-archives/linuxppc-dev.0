Return-Path: <linuxppc-dev+bounces-29437-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C483CC6B0F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:40:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j48Rn1mHSz30VL;
	Wed, 14 Oct 2026 09:40:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1246"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791931221;
	cv=none; b=OkhZH03b6mPVkapbZpiFYrEuP5wtrDEZaKcvxseUyX7UCoQ2OylXrrfO2ervVZqWRDv4no5PiagRwuKR5kAXUk36ubzx6FaK9GqFHLLY7f/8tHzbCfDUVuvcn8QvaLvVI7lTnKDTz/t1EUmDJ/BOI3Luoitf1JJWwk6roAacoanwwOT5zB9ZRtvk4ihtFtSBxu/r3+OSel2+eoGXFaQLilS6oNwVNbw7O+KpMO3dwJmdwCdj4bJHhyHqzwm7M8LpA/16hWzoYFfkky4GyerekNSNFtmNg9DkBQXg0PntyG7ftxSwG1gLGtqN0cqxGZpIr6CUdiaY16otJWdr6EFAww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791931221; c=relaxed/relaxed;
	bh=zS2ZTWNtYHltA9QytinDsw+p3+JtthDKSkNq3q9AYXg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h5+ekeAVmXC40imxKLjAcYL0aE+DSn1q+gwq3PeDfVWustEgj15rCLwGZJbusPC2hIpKqdbTOpgf8+vwKmHvYbvpBFLNRe+NzMCaQiEBc0U3z1MYIl7gEFnipWry8Q668N0WwQ4Os3f2lFPpEtKDow6/MDVi1uBrT4QQdt7GhwwiH3VO8zjEK5yMUb36fSPCfgiFx5ijsap9qqbhN9D77yfiPX1HhZL7nksGX/citsAnh3gRhtvdxZB5Bts4wpyQ/qZ9nazNLf2XGdPYd+RWAnCEVSBfGRnfF9oQ6iyp9dU9z9cw9BFigyIrNsE/hOSJ2yiXO6OsugcZu2QUnAqBHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=DNHQUpJh; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1246; helo=mail-dl1-x1246.google.com; envelope-from=3trpoagckde0x63vt67v33v0t.r310x29c44r-sta0x787.3e0pq7.36v@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=DNHQUpJh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--irogers.bounces.google.com (client-ip=2607:f8b0:4864:20::1246; helo=mail-dl1-x1246.google.com; envelope-from=3trpoagckde0x63vt67v33v0t.r310x29c44r-sta0x787.3e0pq7.36v@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1246.google.com (mail-dl1-x1246.google.com [IPv6:2607:f8b0:4864:20::1246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j48Rk1vk2z2yYd
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 09:40:17 +1100 (AEDT)
Received: by mail-dl1-x1246.google.com with SMTP id a92af1059eb24-149e8e8ad71so3594486c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 15:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791931215; x=1792536015; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zS2ZTWNtYHltA9QytinDsw+p3+JtthDKSkNq3q9AYXg=;
        b=DNHQUpJhyGCeGsryzCtVlx1Xtm1z+oQqMptgAVzC1a2zZ3eMN/poT5ua6z3js4trqC
         3ZaPlqiNJFSpI2/fwUVzOT/bli79rpzWj6GYMD+Yu1VGq6Pio72bcXbowUnerHr5fu28
         BRg+VpYW37+HHgHoTLUxTRwnWa2EwV0b0AF16JsQwAOc77U+bGqrT2VCwjtN/EinNOph
         m/Jb+Au4X2WMIXmtrCdalCDmbwDe20kpyyw4Y6mKs1pYUCkE9ny1oklZx7/4wjrHzTfG
         MHuilUzK4ramQfviHl93iZN4g9Bznb+3E2j4d0r/OsrHfoVlD+WXSpiXxrMt4/tRS9Vg
         kURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791931215; x=1792536015;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zS2ZTWNtYHltA9QytinDsw+p3+JtthDKSkNq3q9AYXg=;
        b=KR/d3Ko+9hpZrScRYz09YX6hpqvHWlHtcYDxqm1ej/ly7wPUKOVLov0GUDP89FJjcw
         TSzFnia8EtcEDpaSRbi81WRPKd3t7Pd9Mz2XSCqTBgE+EnVX4e8utXlaGJuc4bXFgJEs
         EJmgOslh+VxUzq1qvOWe1RlLszFA0PU9wtxmuwOmW3dKkFzwjDOSJBZihxRttM/rTUWg
         vhFg6jSSfSiXdR88FEzch+nB3gPKlzZT4DK16Ksyls47O0wBDG0sOpp88h+Kx3yDGLu4
         bt4JLXLwotE4gOonb3vNn2pJ7fbsz8x5EzJ+eFX0aF/YAzeL/vUPQYroYYVBNedcJnvY
         oTPg==
X-Forwarded-Encrypted: i=1; AKwUvBzlfe48OrIkIjSmYp1rkadk0cOz00h+YeAHsFa24x0hsiKZyUByv/qNB0Qw2/YnzpN87KC4nMvukMpHoaM=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKlWizUmFjRuMWnMc4N4LZQ1o8hklHH63ZF9+Du9gPk5otGdzaL
	3JFZF5kC0yEZcRTq7P9SHf9K1dhfTE59EwzSQB1QTILmZ2O4DFxA1M8labZ+CmHpszOWfVcaAx4
	heGxgRXgYuA==
X-Received: from dlbvs3.prod.google.com ([2002:a05:7022:3f03:b0:16a:e18b:92ba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4553:20b0:166:9e0d:3b56
 with SMTP id a92af1059eb24-16a6384d0c8mr17137930c88.38.1791931214565; Tue, 13
 Oct 2026 15:40:14 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:39:36 -0700
In-Reply-To: <20261013223946.1836757-1-irogers@google.com>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
Mime-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013223946.1836757-2-irogers@google.com>
Subject: [PATCH 01/11] Compiler Attributes: Add __require_explicit_initialization
 macro
From: Ian Rogers <irogers@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Viresh Kumar <viresh.kumar@linaro.org>, 
	David Teigland <teigland@redhat.com>, Alexander Aring <aahringo@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, driver-core@lists.linux.dev, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-s390@vger.kernel.org, 
	linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Clang supports the 'require_explicit_initialization' attribute on struct
fields to indicate that a field must be initialized explicitly by the
user when the object is constructed. When an aggregate initializer or
uninitialized variable omits an annotated field, Clang emits a
-Wuninitialized-explicit-init warning (enabled by default).

Add the __require_explicit_initialization macro to
include/linux/compiler_attributes.h (which is included by
include/linux/compiler_types.h and include/linux/compiler.h) so kernel
structs with error-prone initialization (such as mandatory callbacks or
cleanup handlers) can enforce explicit initialization at compile time,
as discussed at the Linux Plumbers Conference.

Also teach Sphinx (Documentation/conf.py), kernel-doc
(tools/lib/python/kdoc/xforms_lists.py), and checkpatch.pl about the new
attribute macro.

Link: https://lpc.events/event/20/contributions/2392/
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 Documentation/conf.py                 |  1 +
 include/linux/compiler_attributes.h   | 11 +++++++++++
 scripts/checkpatch.pl                 |  1 +
 tools/lib/python/kdoc/xforms_lists.py |  1 +
 4 files changed, 14 insertions(+)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 5ab26ce89daf..3e5cb9ca0970 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -203,6 +203,7 @@ c_id_attributes = [
     "__noreturn",
     "__packed",
     "__pure",
+    "__require_explicit_initialization",
     "__section",
     "__always_unused",
     "__maybe_unused",
diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 476c4c560d17..60522ab80c5a 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -322,6 +322,17 @@
  */
 #define __pure                          __attribute__((__pure__))
 
+/*
+ * Optional: not supported by gcc
+ *
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#require-explicit-initialization
+ */
+#if __has_attribute(__require_explicit_initialization__)
+# define __require_explicit_initialization __attribute__((__require_explicit_initialization__))
+#else
+# define __require_explicit_initialization
+#endif
+
 /*
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-section-function-attribute
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-section-variable-attribute
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 8a7787d228a6..4a3ae6b0100a 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6871,6 +6871,7 @@ sub process {
 				"noreturn"			=> "__noreturn",
 				"packed"			=> "__packed",
 				"pure"				=> "__pure",
+				"require_explicit_initialization" => "__require_explicit_initialization",
 				"section"			=> "__section",
 				"used"				=> "__used",
 				"weak"				=> "__weak"
diff --git a/tools/lib/python/kdoc/xforms_lists.py b/tools/lib/python/kdoc/xforms_lists.py
index e3dda2fe8a53..32066fbbe763 100644
--- a/tools/lib/python/kdoc/xforms_lists.py
+++ b/tools/lib/python/kdoc/xforms_lists.py
@@ -36,6 +36,7 @@ class CTransforms:
         (CMatch("CRYPTO_MINALIGN_ATTR"), ""),
         (CMatch("__private"), ""),
         (CMatch("__rcu"), ""),
+        (CMatch("__require_explicit_initialization"), ""),
         (CMatch("____cacheline_aligned_in_smp"), ""),
         (CMatch("____cacheline_aligned"), ""),
         (CMatch("__cacheline_group_(?:begin|end)"), ""),
-- 
2.56.0.385.gd3acb90ef8-goog


