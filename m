Return-Path: <SRS0=UMO+=JB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532C6C433B4
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Apr 2021 17:21:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE5476128B
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Apr 2021 17:21:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE5476128B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FD0tz1cmBz3bc7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Apr 2021 03:21:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FD0tb1NTsz301k
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Apr 2021 03:20:51 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4FD0tP1t4vz9tymG;
 Sun,  4 Apr 2021 19:20:45 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id ffq992l6CBkv; Sun,  4 Apr 2021 19:20:45 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4FD0tP0d2fz9tymF;
 Sun,  4 Apr 2021 19:20:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9F2F08B78E;
 Sun,  4 Apr 2021 19:20:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id b-KtXSnASDF0; Sun,  4 Apr 2021 19:20:48 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4454D8B76A;
 Sun,  4 Apr 2021 19:20:48 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 06D3A67685; Sun,  4 Apr 2021 17:20:48 +0000 (UTC)
Message-Id: <34d20d1dbb88f26d418b33985557b0475374a1a5.1617556785.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH v6 1/1] cmdline: Add capability to both append and prepend
 at the same time
To: will@kernel.org, danielwa@cisco.com, robh@kernel.org,
 daniel@gimpelevich.san-francisco.ca.us, arnd@kernel.org,
 akpm@linux-foundation.org
Date: Sun,  4 Apr 2021 17:20:48 +0000 (UTC)
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
Cc: linux-arch@vger.kernel.org, devicetree@vger.kernel.org,
 microblaze <monstr@monstr.eu>, linux-xtensa@linux-xtensa.org,
 linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, nios2 <ley.foon.tan@intel.com>,
 linux-mips@vger.kernel.org, linux-mm@kvack.org, openrisc@lists.librecores.org,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

One user has expressed the need to both append and prepend some
built-in parameters to the command line provided by the bootloader.

Allthough it is a corner case, it is easy to implement so let's do it.

When the user chooses to prepend the bootloader provided command line
with the built-in command line, he is offered the possibility to enter
an additionnal built-in command line to be appended after the
bootloader provided command line.

It is a complementary feature which has no impact on the already
existing ones and/or the existing defconfig.

Suggested-by: Daniel Walker <danielwa@cisco.com>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
Sending this out as an RFC, applies on top of the series
("Implement GENERIC_CMDLINE"). I will add it to the series next spin
unless someone is against it.
---
 include/linux/cmdline.h |  3 +++
 init/Kconfig            | 12 +++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/cmdline.h b/include/linux/cmdline.h
index 020028e2bdf0..fb274a4d5519 100644
--- a/include/linux/cmdline.h
+++ b/include/linux/cmdline.h
@@ -36,6 +36,9 @@ static __always_inline bool __cmdline_build(char *dst, const char *src)
 
 	len = cmdline_strlcat(dst, src, COMMAND_LINE_SIZE);
 
+	if (IS_ENABLED(CONFIG_CMDLINE_PREPEND))
+		len = cmdline_strlcat(dst, " " CONFIG_CMDLINE_MORE, COMMAND_LINE_SIZE);
+
 	if (IS_ENABLED(CONFIG_CMDLINE_APPEND))
 		len = cmdline_strlcat(dst, " " CONFIG_CMDLINE, COMMAND_LINE_SIZE);
 
diff --git a/init/Kconfig b/init/Kconfig
index fa002e3765ab..cd3087ff4f28 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -128,6 +128,14 @@ config CMDLINE
 	  If this string is not empty, additional choices are proposed
 	  below to determine how it will be used by the kernel.
 
+config CMDLINE_MORE
+	string "Additional default kernel command string" if GENERIC_CMDLINE && CMDLINE_PREPEND
+	default ""
+	help
+	  Defines an additional default kernel command string.
+	  If this string is not empty, it is appended to the
+	  command-line arguments provided by the bootloader
+
 choice
 	prompt "Kernel command line type" if CMDLINE != ""
 	default CMDLINE_PREPEND if ARCH_WANT_CMDLINE_PREPEND_BY_DEFAULT
@@ -154,7 +162,9 @@ config CMDLINE_PREPEND
 	bool "Prepend to the bootloader kernel arguments"
 	help
 	  The default kernel command string will be prepended to the
-	  command-line arguments provided by the bootloader.
+	  command-line arguments provided by the bootloader. When this
+	  option is selected, another string can be added which will
+	  be appended.
 
 config CMDLINE_FORCE
 	bool "Always use the default kernel command string"
-- 
2.25.0

