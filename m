Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508DFC10F14
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 04:09:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C060320843
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 04:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ewcDEyxA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C060320843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44p92103p3zDqDc
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 14:09:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.74; helo=conuserg-07.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="ewcDEyxA"; 
 dkim-atps=neutral
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44p8dK2XvjzDqKZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 13:51:33 +1000 (AEST)
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp
 [153.142.97.92]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id x3N3o2cJ023044;
 Tue, 23 Apr 2019 12:50:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x3N3o2cJ023044
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1555991419;
 bh=YGW0gg01jtKnXbnK1Ap0mVZ9GqJOY8DcvskWgXT4tQY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ewcDEyxAy830oNo0YRW7jR4QvsmMHJ7U9S64TPwRMLWVV1Rsdm+QuGqFD8eVuQzA1
 JDeIVx3feidNla9E96nmF8wSY728TufIWZCckpdG4EdzTiWFjhDkl1qYWAhbGtMOvH
 xo8ifEmC+GwRQFpXB00+PHkczCbiY3Edx/sD0mvzV134YRwxkX7r+n7NXQBI2jQ/PC
 tzTk4fiyXAczxbRs/vk2vJTApA0bhWQQ9OU7i7d1T/3wDZ0R7kU9AELrMePMx0TqNa
 MxOdnol7IZuan0BiS94RGSAcH1PAU3odAktvY0h5BgyeHTBXnhekgv8YtdPaUB6ptG
 t6M2dszBtsRcg==
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 linux-arch <linux-arch@vger.kernel.org>
Subject: [RESEND PATCH v3 11/11] compiler: allow all arches to enable
 CONFIG_OPTIMIZE_INLINING
Date: Tue, 23 Apr 2019 12:49:59 +0900
Message-Id: <20190423034959.13525-12-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190423034959.13525-1-yamada.masahiro@socionext.com>
References: <20190423034959.13525-1-yamada.masahiro@socionext.com>
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
Cc: linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Mathieu Malaterre <malat@debian.org>, x86@kernel.org,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>,
 Ingo Molnar <mingo@redhat.com>, linux-mtd@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Commit 60a3cdd06394 ("x86: add optimized inlining") introduced
CONFIG_OPTIMIZE_INLINING, but it has been available only for x86.

The idea is obviously arch-agnostic. This commit moves the config
entry from arch/x86/Kconfig.debug to lib/Kconfig.debug so that all
architectures can benefit from it.

This can make a huge difference in kernel image size especially when
CONFIG_OPTIMIZE_FOR_SIZE is enabled.

For example, I got 3.5% smaller arm64 kernel for v5.1-rc1.

  dec       file
  18983424  arch/arm64/boot/Image.before
  18321920  arch/arm64/boot/Image.after

This also slightly improves the "Kernel hacking" Kconfig menu as
e61aca5158a8 ("Merge branch 'kconfig-diet' from Dave Hansen') suggested;
this config option would be a good fit in the "compiler option" menu.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Borislav Petkov <bp@suse.de>
---

Changes in v3: None
Changes in v2:
  - split into a separate patch

 arch/x86/Kconfig               |  3 ---
 arch/x86/Kconfig.debug         | 14 --------------
 include/linux/compiler_types.h |  3 +--
 lib/Kconfig.debug              | 14 ++++++++++++++
 4 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 62fc3fda1a05..f214bb5d60d8 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -310,9 +310,6 @@ config ZONE_DMA32
 config AUDIT_ARCH
 	def_bool y if X86_64
 
-config ARCH_SUPPORTS_OPTIMIZED_INLINING
-	def_bool y
-
 config ARCH_SUPPORTS_DEBUG_PAGEALLOC
 	def_bool y
 
diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index 15d0fbe27872..f730680dc818 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -266,20 +266,6 @@ config CPA_DEBUG
 	---help---
 	  Do change_page_attr() self-tests every 30 seconds.
 
-config OPTIMIZE_INLINING
-	bool "Allow gcc to uninline functions marked 'inline'"
-	---help---
-	  This option determines if the kernel forces gcc to inline the functions
-	  developers have marked 'inline'. Doing so takes away freedom from gcc to
-	  do what it thinks is best, which is desirable for the gcc 3.x series of
-	  compilers. The gcc 4.x series have a rewritten inlining algorithm and
-	  enabling this option will generate a smaller kernel there. Hopefully
-	  this algorithm is so good that allowing gcc 4.x and above to make the
-	  decision will become the default in the future. Until then this option
-	  is there to test gcc for this.
-
-	  If unsure, say N.
-
 config DEBUG_ENTRY
 	bool "Debug low-level entry code"
 	depends on DEBUG_KERNEL
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index ba814f18cb4c..19e58b9138a0 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -140,8 +140,7 @@ struct ftrace_likely_data {
  * Do not use __always_inline here, since currently it expands to inline again
  * (which would break users of __always_inline).
  */
-#if !defined(CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING) || \
-	!defined(CONFIG_OPTIMIZE_INLINING)
+#if !defined(CONFIG_OPTIMIZE_INLINING)
 #define inline inline __attribute__((__always_inline__)) __gnu_inline \
 	__maybe_unused notrace
 #else
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 00dbcdbc9a0d..37402f210115 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -310,6 +310,20 @@ config HEADERS_CHECK
 	  exported to $(INSTALL_HDR_PATH) (usually 'usr/include' in
 	  your build tree), to make sure they're suitable.
 
+config OPTIMIZE_INLINING
+	bool "Allow compiler to uninline functions marked 'inline'"
+	help
+	  This option determines if the kernel forces gcc to inline the functions
+	  developers have marked 'inline'. Doing so takes away freedom from gcc to
+	  do what it thinks is best, which is desirable for the gcc 3.x series of
+	  compilers. The gcc 4.x series have a rewritten inlining algorithm and
+	  enabling this option will generate a smaller kernel there. Hopefully
+	  this algorithm is so good that allowing gcc 4.x and above to make the
+	  decision will become the default in the future. Until then this option
+	  is there to test gcc for this.
+
+	  If unsure, say N.
+
 config DEBUG_SECTION_MISMATCH
 	bool "Enable full Section mismatch analysis"
 	help
-- 
2.17.1

