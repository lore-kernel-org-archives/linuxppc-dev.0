Return-Path: <SRS0=4MsH=NU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423CAC43441
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 07:07:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3DB52080D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 07:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3DB52080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rrnn1JYpzF3RZ
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 18:07:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rrlm3q9YzF3ZH
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2018 18:05:56 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42rrlb1CN4z9ty8r;
 Fri,  9 Nov 2018 08:05:47 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id SMJXeHEkxyHE; Fri,  9 Nov 2018 08:05:47 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42rrlb0kTwz9ttBy;
 Fri,  9 Nov 2018 08:05:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2CF5E8B878;
 Fri,  9 Nov 2018 08:05:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 2S0QATzhOeK8; Fri,  9 Nov 2018 08:05:52 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (unknown [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 0FA248B756;
 Fri,  9 Nov 2018 08:05:52 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id DE637699D2; Fri,  9 Nov 2018 07:05:51 +0000 (UTC)
Message-Id: <ca27a073c872e243be1d17a89afb4b4aeb9a298b.1541714054.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] lkdtm: do not depend on CONFIG_BLOCK
To: Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri,  9 Nov 2018 07:05:51 +0000 (UTC)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Most parts of lkdtm don't require CONFIG_BLOCK.

This patch limits dependency to CONFIG_BLOCK in order to give embedded
platforms which don't select CONFIG_BLOCK the opportunity to use LKDTM.

Fixes: fddd9cf82c9f ("make LKDTM depend on BLOCK")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/misc/lkdtm/core.c | 7 ++++++-
 lib/Kconfig.debug         | 1 -
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index 2837dc77478e..bc76756b7eda 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -40,9 +40,12 @@
 #include <linux/interrupt.h>
 #include <linux/hrtimer.h>
 #include <linux/slab.h>
-#include <scsi/scsi_cmnd.h>
 #include <linux/debugfs.h>
 
+#ifdef CONFIG_BLOCK
+#include <scsi/scsi_cmnd.h>
+#endif
+
 #ifdef CONFIG_IDE
 #include <linux/ide.h>
 #endif
@@ -101,7 +104,9 @@ static struct crashpoint crashpoints[] = {
 	CRASHPOINT("FS_DEVRW",		 "ll_rw_block"),
 	CRASHPOINT("MEM_SWAPOUT",	 "shrink_inactive_list"),
 	CRASHPOINT("TIMERADD",		 "hrtimer_start"),
+# ifdef CONFIG_BLOCK
 	CRASHPOINT("SCSI_DISPATCH_CMD",	 "scsi_dispatch_cmd"),
+# endif
 # ifdef CONFIG_IDE
 	CRASHPOINT("IDE_CORE_CP",	 "generic_ide_ioctl"),
 # endif
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1af29b8224fd..0dd65b4b2ad2 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1685,7 +1685,6 @@ if RUNTIME_TESTING_MENU
 config LKDTM
 	tristate "Linux Kernel Dump Test Tool Module"
 	depends on DEBUG_FS
-	depends on BLOCK
 	help
 	This module enables testing of the different dumping mechanisms by
 	inducing system failures at predefined crash points.
-- 
2.13.3

