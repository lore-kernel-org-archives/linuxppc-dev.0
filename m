Return-Path: <SRS0=8MIQ=RP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEABC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 22:20:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BC212175B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 22:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="KQLanF/4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC212175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44JqCf2hSdzDqHp
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 09:19:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="KQLanF/4"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Jq7K6vkVzDqDt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 09:16:13 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44Jq7G0syJzB09ZJ;
 Tue, 12 Mar 2019 23:16:10 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=KQLanF/4; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id qEKF0zGnhklk; Tue, 12 Mar 2019 23:16:10 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44Jq7F6XsPzB09ZG;
 Tue, 12 Mar 2019 23:16:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1552428969; bh=WruMu/BwAMo8I9a3LF55jCSVvG/Tocg3gOnV17/tBYE=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=KQLanF/4dftXRqC6GCD0M0L1NDv7Tk3uwmOLHYfcMbzeC+NVftLENFHGm877fbTEE
 IqUJ0eJji/7Ty9h8hcq5o7AKByQwIgnGz7GlXQDYuo0WJNsnh7JvHOi3x3QBcfrO/f
 4Tu4y32RrhY61drJqkgYuM6v7mtP3CrHTGS+Yi7M=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1F0638B8B1;
 Tue, 12 Mar 2019 23:16:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id jEDvnohJtjOg; Tue, 12 Mar 2019 23:16:10 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E58B48B8A7;
 Tue, 12 Mar 2019 23:16:09 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id B3CFA6FA15; Tue, 12 Mar 2019 22:16:09 +0000 (UTC)
Message-Id: <09fc2bc930197987745b937b3817b2563b0a42ab.1552428161.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1552428161.git.christophe.leroy@c-s.fr>
References: <cover.1552428161.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v10 04/18] powerpc: remove CONFIG_CMDLINE #ifdef mess
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Daniel Axtens <dja@axtens.net>
Date: Tue, 12 Mar 2019 22:16:09 +0000 (UTC)
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch makes CONFIG_CMDLINE defined at all time. It avoids
having to enclose related code inside #ifdef CONFIG_CMDLINE

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig            | 6 +++---
 arch/powerpc/kernel/prom_init.c | 9 +++------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index b5dce13a6132..facaa6ba0d2a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -833,9 +833,9 @@ config CMDLINE_BOOL
 	bool "Default bootloader kernel arguments"
 
 config CMDLINE
-	string "Initial kernel command string"
-	depends on CMDLINE_BOOL
-	default "console=ttyS0,9600 console=tty0 root=/dev/sda2"
+	string "Initial kernel command string" if CMDLINE_BOOL
+	default "console=ttyS0,9600 console=tty0 root=/dev/sda2" if CMDLINE_BOOL
+	default ""
 	help
 	  On some platforms, there is currently no way for the boot loader to
 	  pass arguments to the kernel. For these platforms, you can supply
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index f33ff4163a51..ecf083c46bdb 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -631,17 +631,14 @@ static void __init early_cmdline_parse(void)
 	const char *opt;
 
 	char *p;
-	int l __maybe_unused = 0;
+	int l = 0;
 
 	prom_cmd_line[0] = 0;
 	p = prom_cmd_line;
 	if ((long)prom.chosen > 0)
 		l = prom_getprop(prom.chosen, "bootargs", p, COMMAND_LINE_SIZE-1);
-#ifdef CONFIG_CMDLINE
-	if (l <= 0 || p[0] == '\0') /* dbl check */
-		strlcpy(prom_cmd_line,
-			CONFIG_CMDLINE, sizeof(prom_cmd_line));
-#endif /* CONFIG_CMDLINE */
+	if (IS_ENABLED(CONFIG_CMDLINE_BOOL) && (l <= 0 || p[0] == '\0')) /* dbl check */
+		strlcpy(prom_cmd_line, CONFIG_CMDLINE, sizeof(prom_cmd_line));
 	prom_printf("command line: %s\n", prom_cmd_line);
 
 #ifdef CONFIG_PPC64
-- 
2.13.3

