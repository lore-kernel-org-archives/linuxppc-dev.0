Return-Path: <SRS0=j/g1=IY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0EDC433E5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Mar 2021 13:47:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7880861949
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Mar 2021 13:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7880861949
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F6NZX0L4yz3dc9
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Mar 2021 00:47:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F6NWY3nhLz3btQ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Mar 2021 00:44:57 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4F6NWT4TPXz9v03D;
 Fri, 26 Mar 2021 14:44:53 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id EEqTBNdfHvPX; Fri, 26 Mar 2021 14:44:53 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4F6NWT3Zrwz9v03B;
 Fri, 26 Mar 2021 14:44:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 58E9A8B8C9;
 Fri, 26 Mar 2021 14:44:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id Yai4PS5jsljR; Fri, 26 Mar 2021 14:44:54 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 0171D8B8C7;
 Fri, 26 Mar 2021 14:44:53 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 80E9967611; Fri, 26 Mar 2021 13:44:54 +0000 (UTC)
Message-Id: <3561ef609d471949454d58f969c036f97f596211.1616765870.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1616765869.git.christophe.leroy@csgroup.eu>
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 07/17] hexagon: Convert to GENERIC_CMDLINE
To: will@kernel.org, danielwa@cisco.com, robh@kernel.org,
 daniel@gimpelevich.san-francisco.ca.us
Date: Fri, 26 Mar 2021 13:44:54 +0000 (UTC)
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
 linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This converts the architecture to GENERIC_CMDLINE.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/hexagon/Kconfig        | 11 +----------
 arch/hexagon/kernel/setup.c | 10 ++--------
 2 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 44a409967af1..1e69c99bae6b 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -18,6 +18,7 @@ config HEXAGON
 	select HAVE_PERF_EVENTS
 	# GENERIC_ALLOCATOR is used by dma_alloc_coherent()
 	select GENERIC_ALLOCATOR
+	select GENERIC_CMDLINE
 	select GENERIC_IRQ_SHOW
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_TRACEHOOK
@@ -91,16 +92,6 @@ config HEXAGON_ARCH_VERSION
 	int "Architecture version"
 	default 2
 
-config CMDLINE
-	string "Default kernel command string"
-	default ""
-	help
-	  On some platforms, there is currently no way for the boot loader
-	  to pass arguments to the kernel. For these, you should supply some
-	  command-line options at build time by entering them here.  At a
-	  minimum, you should specify the memory size and the root device
-	  (e.g., mem=64M root=/dev/nfs).
-
 config SMP
 	bool "Multi-Processing support"
 	help
diff --git a/arch/hexagon/kernel/setup.c b/arch/hexagon/kernel/setup.c
index 1880d9beaf2b..be586cea4076 100644
--- a/arch/hexagon/kernel/setup.c
+++ b/arch/hexagon/kernel/setup.c
@@ -13,6 +13,7 @@
 #include <linux/seq_file.h>
 #include <linux/console.h>
 #include <linux/of_fdt.h>
+#include <linux/cmdline.h>
 #include <asm/io.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
@@ -22,7 +23,6 @@
 #include <asm/time.h>
 
 char cmd_line[COMMAND_LINE_SIZE];
-static char default_command_line[COMMAND_LINE_SIZE] __initdata = CONFIG_CMDLINE;
 
 int on_simulator;
 
@@ -38,8 +38,6 @@ void calibrate_delay(void)
 
 void __init setup_arch(char **cmdline_p)
 {
-	char *p = &external_cmdline_buffer;
-
 	/*
 	 * These will eventually be pulled in via either some hypervisor
 	 * or devicetree description.  Hardwiring for now.
@@ -65,11 +63,7 @@ void __init setup_arch(char **cmdline_p)
 	else
 		on_simulator = 0;
 
-	if (p[0] != '\0')
-		strlcpy(boot_command_line, p, COMMAND_LINE_SIZE);
-	else
-		strlcpy(boot_command_line, default_command_line,
-			COMMAND_LINE_SIZE);
+	cmdline_build(boot_command_line, external_cmdline_buffer, COMMAND_LINE_SIZE);
 
 	/*
 	 * boot_command_line and the value set up by setup_arch
-- 
2.25.0

