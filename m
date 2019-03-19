Return-Path: <SRS0=MfaX=RW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D06FC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 23:28:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76F632075E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 23:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="He0aqAz4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76F632075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44P8Pf18J9zDqGW
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 10:28:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=cisco.com
 (client-ip=173.37.86.75; helo=rcdn-iport-4.cisco.com;
 envelope-from=danielwa@cisco.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=cisco.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=cisco.com header.i=@cisco.com header.b="He0aqAz4"; 
 dkim-atps=neutral
Received: from rcdn-iport-4.cisco.com (rcdn-iport-4.cisco.com [173.37.86.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44P8KS2vXCzDqD4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 10:24:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=cisco.com; i=@cisco.com; l=3816; q=dns/txt; s=iport;
 t=1553037900; x=1554247500;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=MTFoVhwIQZNGeytNbraLJ1jAIHQLVwsMfigDEt0MtsE=;
 b=He0aqAz4oPLbn/fRjpW53KZqR1eiL0KjXQSl+jg+Ak6IBeVLKnaxm9V8
 EloS0E5SHp7vGkkn9xrz4GqQKksRAZKYoll4ebbimtR16YHAU4ftUMcd2
 fihU4Op8Vx6J6PRXE2PGZaseiF6jXHwe+LX6id/IMK8nDF/zOeLeDqE3R A=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AEAAC5eZFc/4cNJK1jGgEBAQEBAgE?=
 =?us-ascii?q?BAQEHAgEBAQGBUQUBAQEBCwGCEGiBAyeMJ6VrgXsNH4RNhG0iNAkNAQEDAQE?=
 =?us-ascii?q?JAQMCbSiGAwFGKYEVARKDIgGBdAGsEIo1FIEbAYZphEgXgUA/gRGNdAOKLod?=
 =?us-ascii?q?ukk0JgkuFEotDDBmTXolOgT6TK4FHOIFWMxoIGxWDJwmCDReOPh8zj2sBAQ?=
X-IronPort-AV: E=Sophos;i="5.60,246,1549929600"; d="scan'208";a="537260106"
Received: from alln-core-2.cisco.com ([173.36.13.135])
 by rcdn-iport-4.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA;
 19 Mar 2019 23:24:56 +0000
Received: from sjc-ads-2388.cisco.com (sjc-ads-2388.cisco.com [171.70.63.76])
 by alln-core-2.cisco.com (8.15.2/8.15.2) with ESMTP id
 x2JNOrtX019667; Tue, 19 Mar 2019 23:24:56 GMT
From: Daniel Walker <danielwa@cisco.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Rob Herring <robh+dt@kernel.org>, xe-linux-external@cisco.com,
 linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 3/4] powerpc: convert to generic builtin command line
Date: Tue, 19 Mar 2019 16:24:47 -0700
Message-Id: <20190319232448.45964-4-danielwa@cisco.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 171.70.63.76, sjc-ads-2388.cisco.com
X-Outbound-Node: alln-core-2.cisco.com
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
Cc: Daniel Walker <dwalker@fifo99.com>, linux-kernel@vger.kernel.org,
 Maksym Kokhan <maksym.kokhan@globallogic.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This updates the powerpc code to use the CONFIG_GENERIC_CMDLINE
option.

[maksym.kokhan@globallogic.com: add strlcat to prom_init_check.sh
whitelist]
Cc: Daniel Walker <dwalker@fifo99.com>
Cc: Daniel Walker <danielwa@cisco.com>
Cc: xe-linux-external@cisco.com
Signed-off-by: Daniel Walker <danielwa@cisco.com>
Signed-off-by: Maksym Kokhan <maksym.kokhan@globallogic.com>
---
 arch/powerpc/Kconfig                   | 23 +----------------------
 arch/powerpc/kernel/prom_init.c        |  8 ++++----
 arch/powerpc/kernel/prom_init_check.sh |  2 +-
 3 files changed, 6 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index def41a06377b..385120ff0236 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -173,6 +173,7 @@ config PPC
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
 	select GENERIC_TIME_VSYSCALL
+	select GENERIC_CMDLINE
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_KGDB
@@ -780,28 +781,6 @@ config PPC_DENORMALISATION
 	  Add support for handling denormalisation of single precision
 	  values.  Useful for bare metal only.  If unsure say Y here.
 
-config CMDLINE_BOOL
-	bool "Default bootloader kernel arguments"
-
-config CMDLINE
-	string "Initial kernel command string"
-	depends on CMDLINE_BOOL
-	default "console=ttyS0,9600 console=tty0 root=/dev/sda2"
-	help
-	  On some platforms, there is currently no way for the boot loader to
-	  pass arguments to the kernel. For these platforms, you can supply
-	  some command-line options at build time by entering them here.  In
-	  most cases you will need to specify the root device here.
-
-config CMDLINE_FORCE
-	bool "Always use the default kernel command string"
-	depends on CMDLINE_BOOL
-	help
-	  Always use the default kernel command string, even if the boot
-	  loader passes other arguments to the kernel.
-	  This is useful if you cannot or don't want to change the
-	  command-line options your boot loader passes to the kernel.
-
 config EXTRA_TARGETS
 	string "Additional default image types"
 	help
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index f33ff4163a51..e8e9fca22470 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -30,6 +30,7 @@
 #include <linux/delay.h>
 #include <linux/initrd.h>
 #include <linux/bitops.h>
+#include <linux/cmdline.h>
 #include <asm/prom.h>
 #include <asm/rtas.h>
 #include <asm/page.h>
@@ -637,11 +638,10 @@ static void __init early_cmdline_parse(void)
 	p = prom_cmd_line;
 	if ((long)prom.chosen > 0)
 		l = prom_getprop(prom.chosen, "bootargs", p, COMMAND_LINE_SIZE-1);
-#ifdef CONFIG_CMDLINE
+
 	if (l <= 0 || p[0] == '\0') /* dbl check */
-		strlcpy(prom_cmd_line,
-			CONFIG_CMDLINE, sizeof(prom_cmd_line));
-#endif /* CONFIG_CMDLINE */
+		cmdline_add_builtin_section(prom_cmd_line, NULL, sizeof(prom_cmd_line), __prombss);
+
 	prom_printf("command line: %s\n", prom_cmd_line);
 
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/kernel/prom_init_check.sh b/arch/powerpc/kernel/prom_init_check.sh
index 667df97d2595..ab2acc8d8b5a 100644
--- a/arch/powerpc/kernel/prom_init_check.sh
+++ b/arch/powerpc/kernel/prom_init_check.sh
@@ -18,7 +18,7 @@
 
 WHITELIST="add_reloc_offset __bss_start __bss_stop copy_and_flush
 _end enter_prom memcpy memset reloc_offset __secondary_hold
-__secondary_hold_acknowledge __secondary_hold_spinloop __start
+__secondary_hold_acknowledge __secondary_hold_spinloop __start strlcat
 strcmp strcpy strlcpy strlen strncmp strstr kstrtobool logo_linux_clut224
 reloc_got2 kernstart_addr memstart_addr linux_banner _stext
 __prom_init_toc_start __prom_init_toc_end btext_setup_display TOC."
-- 
2.19.1

