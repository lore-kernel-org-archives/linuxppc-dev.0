Return-Path: <SRS0=Iv+L=OG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60598C43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 17:18:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8D2A2086B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 17:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ng+sxjj4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8D2A2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4349Tr6vHtzDqPC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 04:18:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ng+sxjj4";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=chromium.org
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=keescook@chromium.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="ng+sxjj4";
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4349R13vkpzDqkg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 04:15:41 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id a14so15910597plm.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 09:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=bLNvaoCCH05m2PTISfDtvUr4vGDUjtejnoxkkoIzmc0=;
 b=ng+sxjj4CQQC1GuUmoqJ0IWsj/psYeBJZ/1nK+/txS9PJQiwNaKIPPg79o/UfCFzwE
 QplL9x850zKlDLaxk/yXGOYGjGjBoAN2BncSTbXrYDtkvONXmUs8GYMCdIJ4yIwgKio9
 zkYBOmFKX2tsShaazLVFKRPhz2j/Avc4wOwW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=bLNvaoCCH05m2PTISfDtvUr4vGDUjtejnoxkkoIzmc0=;
 b=L/uJaFym4mwHSobNrmuoe+GtzY1lnsU/0RSwP4lge5UIPw5Ayue+QiLgHYBJ5QQQY4
 6d07SinF0U24fpaDNjScYEaAm0nkCyeqxgOR3UVpnd4bxF7n/IF9WSNYCv3ju5yKg1gY
 IzNgt8i2Zdoilo7QoSdT4GcsNIuA0pwtWBgB/Isgxkjj4X30UIOG2VCCn8pznfhhSSel
 bLGn+aoBgyzq5KtcsFaEUTmumbR02cs2fCXNNf3CNlhy6kPwmKmyQmNy6ci1VAxi3Xax
 FXbQEPHqgtKOMC9SgFcAqPKTeyb1Nu9nsP2BmF9QoFgnko+Uqa3kPu6k+/i4scVd5QCV
 jOMg==
X-Gm-Message-State: AA+aEWZ+siuCVnVoOps4IyxuvpaosVN6MiJPwJ8b5EuC8njhxN8ezvZh
 dwxLkZCfPvW1+Z6Z6sHWBSc8+g==
X-Google-Smtp-Source: AFSGD/VZK6/U5QKx0atWvx9RKBXjp3HYdW26581F2mH3o5vMKH63LK8+TNvrqSj/cF/w0QYtvv294Q==
X-Received: by 2002:a17:902:3383:: with SMTP id
 b3mr32687445plc.170.1543338939186; 
 Tue, 27 Nov 2018 09:15:39 -0800 (PST)
Received: from www.outflux.net
 (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
 by smtp.gmail.com with ESMTPSA id z8sm5153904pgz.53.2018.11.27.09.15.38
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 27 Nov 2018 09:15:38 -0800 (PST)
Date: Tue, 27 Nov 2018 09:15:37 -0800
From: Kees Cook <keescook@chromium.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] lkdtm: Do not depend on BLOCK and clean up headers
Message-ID: <20181127171537.GA5300@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

After the transition to kprobes, symbols are resolved at runtime. This
means there is no need to have all the Kconfig and header logic to
avoid build failures. This also paves the way to having arbitrary test
locations.

Reported-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/core.c | 9 ---------
 lib/Kconfig.debug         | 1 -
 2 files changed, 10 deletions(-)

diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index 2837dc77478e..5d41c2230d2e 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -37,16 +37,9 @@
 #include <linux/kprobes.h>
 #include <linux/list.h>
 #include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/hrtimer.h>
 #include <linux/slab.h>
-#include <scsi/scsi_cmnd.h>
 #include <linux/debugfs.h>
 
-#ifdef CONFIG_IDE
-#include <linux/ide.h>
-#endif
-
 #define DEFAULT_COUNT 10
 
 static int lkdtm_debugfs_open(struct inode *inode, struct file *file);
@@ -102,9 +95,7 @@ static struct crashpoint crashpoints[] = {
 	CRASHPOINT("MEM_SWAPOUT",	 "shrink_inactive_list"),
 	CRASHPOINT("TIMERADD",		 "hrtimer_start"),
 	CRASHPOINT("SCSI_DISPATCH_CMD",	 "scsi_dispatch_cmd"),
-# ifdef CONFIG_IDE
 	CRASHPOINT("IDE_CORE_CP",	 "generic_ide_ioctl"),
-# endif
 #endif
 };
 
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
2.17.1


-- 
Kees Cook
