Return-Path: <SRS0=w0cb=TX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6660AC282DD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 May 2019 11:49:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9963620851
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 May 2019 11:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vIq7tLlX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9963620851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 458nqC0GpZzDqg7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 May 2019 21:49:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::442; helo=mail-wr1-x442.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="vIq7tLlX"; 
 dkim-atps=neutral
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 458nn00m8yzDqMX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2019 21:47:47 +1000 (AEST)
Received: by mail-wr1-x442.google.com with SMTP id l2so5919450wrb.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2019 04:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9YqtCW0tbRef0Fm5cqvSOdlCFpzkVDTaJgcqIQyiBT8=;
 b=vIq7tLlXXXDRV0gFGARjH6SvTg2BRhRk+p7+wzeII7TToU58ZIRP19lTK0gPptdRKm
 6Qzk8l9R1faq5Z7bl1f+koGGaIjDcALA+jsrK5hJAvxR6Y+4p0igiPcj4pi9U56g1DnR
 EK0zS6hPscmlDdrQHPgtuJQR2o2Pq7kBF5G/8npIHz1ejhYwEQlrhEjg3n4GqGXAYmh6
 PUSfodzylh10zl+/38JW9GzShsYD6cxcw7009XvIoHMY4YYpDrXY085RMj20c7+YIafa
 DbKOw7r6H/NTN32XAvF6fUC5LjsYdimAXsRBZoTzBe98fDKZuCyVCkMxp2VYPBkh+rmK
 0V7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=9YqtCW0tbRef0Fm5cqvSOdlCFpzkVDTaJgcqIQyiBT8=;
 b=gYHKVvqXxwTVWJEB0A+XdfzmDYPUyGZ2d5YUtpr9KQjb5U87IF8ksNdU/WclTwS4ks
 r2Am1ZDZuERNpFHbW7Abp3PYYWOS+vErVKvEQy/aek91MhIi5+HgxbZ4JyNc9ywqL1oQ
 gtri3c1iPDfRjGTUZY1Wm0JKv21l6CaWz9Ewm9+LyNWw6LEO9Lr7AE4Ee7zsN91zCGTi
 XXEl4Y+VwQZpWgz0usggSQKHrsf0GZXL0DxKctCEDSfrG/Tx4NE9WHxAA/Qn31Hz7/s6
 yuzQKcMLAB53aaNimaL/IZgQQZ0Yov66SDG5d7CY/dvv3nj569e9n8jt0+aSWxn5R6rB
 v3lg==
X-Gm-Message-State: APjAAAWDgU6AN6dQKEolVCM1Vc8FmHNUfdnzbCrfe03wcgtNrdNLUYFI
 0askObVtiih44o2IWvT1IxE=
X-Google-Smtp-Source: APXvYqyXDaVtFOjnuCjBHo3dqsM/hp9hs8h7Skl2dQIHLPNKdqJiMHf1WrYMBDLGZurDJsBXeQ7P+w==
X-Received: by 2002:a5d:4b52:: with SMTP id w18mr329581wrs.262.1558612061895; 
 Thu, 23 May 2019 04:47:41 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net.
 [78.225.224.134])
 by smtp.gmail.com with ESMTPSA id x68sm9075665wmf.13.2019.05.23.04.47.40
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 23 May 2019 04:47:40 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
 id D6B341146D57; Thu, 23 May 2019 13:47:39 +0200 (CEST)
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc/power: Expose pfn_is_nosave prototype
Date: Thu, 23 May 2019 13:47:36 +0200
Message-Id: <20190523114736.30268-1-malat@debian.org>
X-Mailer: git-send-email 2.20.1
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
Cc: Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
 Mathieu Malaterre <malat@debian.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Pavel Machek <pavel@ucw.cz>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The declaration for pfn_is_nosave is only available in
kernel/power/power.h. Since this function can be override in arch,
expose it globally. Having a prototype will make sure to avoid warning
(sometime treated as error with W=1) such as:

  arch/powerpc/kernel/suspend.c:18:5: error: no previous prototype for 'pfn_is_nosave' [-Werror=missing-prototypes]

This moves the declaration into a globally visible header file and add
missing include to avoid a warning in powerpc.

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/suspend.c | 1 +
 include/linux/suspend.h       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/suspend.c b/arch/powerpc/kernel/suspend.c
index a531154cc0f3..9e1b6b894245 100644
--- a/arch/powerpc/kernel/suspend.c
+++ b/arch/powerpc/kernel/suspend.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/mm.h>
+#include <linux/suspend.h>
 #include <asm/page.h>
 #include <asm/sections.h>
 
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 3f529ad9a9d2..2660bbdf5230 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -395,6 +395,7 @@ extern bool system_entering_hibernation(void);
 extern bool hibernation_available(void);
 asmlinkage int swsusp_save(void);
 extern struct pbe *restore_pblist;
+int pfn_is_nosave(unsigned long pfn);
 #else /* CONFIG_HIBERNATION */
 static inline void register_nosave_region(unsigned long b, unsigned long e) {}
 static inline void register_nosave_region_late(unsigned long b, unsigned long e) {}
-- 
2.20.1

