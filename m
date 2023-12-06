Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F4BC10DC1
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Dec 2023 11:59:16 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=fXcAShD0;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SlbXz3Jyqz3cbw
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Dec 2023 22:59:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=fXcAShD0;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (unknown [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SlbTR5pf6z3cT7
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Dec 2023 22:56:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1701863761;
	bh=qfTv7trOFW7wmA/TBICbf0KuIcEksoKPz2QxdGh/RTE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fXcAShD0ZKZh4DYWyCwyWRC/wwZLJZ0Uu8peeprqfBzUEZ6aWGRQbH/RHY33LyvYg
	 YKOJyQ1F1czFl0BS4E6efC7FvR7JHncUBzWVKtcc6PA20OHN+Hm6e9oFwaKw7N608k
	 IPHhnsSWuEO8mHyYRm+k30PTQDXcWpcncPfktf8iusvYieJVNHWS+Tj6bAJCQfYlM4
	 G8Ve40K/CZFivSuGZGv2sxD0MiVIbBEWTbQkC+5OTWdI6BDvtSBKsDtOiwVKWAuQyI
	 PhsTLz4AoUVXiVOLDa6YMCUT8uYlHJasIA6wVtldQKmz1QNWSkYw+HLqX+bz0nxqst
	 Of20brMbTShvA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SlbTF4Vkfz4wd1;
	Wed,  6 Dec 2023 22:56:01 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 4/4] powerpc/Makefile: Auto detect cross compiler
Date: Wed,  6 Dec 2023 22:55:48 +1100
Message-ID: <20231206115548.1466874-4-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206115548.1466874-1-mpe@ellerman.id.au>
References: <20231206115548.1466874-1-mpe@ellerman.id.au>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

If no cross compiler is specified, try to auto detect one.

Look for various combinations, matching:
  powerpc(64(le)?)?(-unknown)?-linux(-gnu)?-

There are more possibilities, but the above is known to find a compiler
on Fedora and Ubuntu (which use linux-gnu-), and also detects the
kernel.org cross compilers (which use linux-).

This allows cross compiling with simply:

 # Ubuntu
 $ sudo apt install gcc-powerpc-linux-gnu
 # Fedora
 $ sudo dnf install gcc-powerpc64-linux-gnu

 $ make ARCH=powerpc defconfig
 $ make ARCH=powerpc -j 4

Inspired by arch/parisc/Makefile.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Makefile | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 48c06f5a0dc1..051247027da0 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -10,6 +10,17 @@
 # Rewritten by Cort Dougan and Paul Mackerras
 #
 
+ifdef cross_compiling
+  ifeq ($(CROSS_COMPILE),)
+    # Auto detect cross compiler prefix.
+    # Look for: (powerpc(64(le)?)?)(-unknown)?-linux(-gnu)?-
+    CC_ARCHES := powerpc powerpc64 powerpc64le
+    CC_SUFFIXES := linux linux-gnu unknown-linux-gnu
+    CROSS_COMPILE := $(call cc-cross-prefix, $(foreach a,$(CC_ARCHES), \
+                       $(foreach s,$(CC_SUFFIXES),$(a)-$(s)-)))
+  endif
+endif
+
 HAS_BIARCH	:= $(call cc-option-yn, -m32)
 
 # Set default 32 bits cross compilers for vdso and boot wrapper
-- 
2.43.0

