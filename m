Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7993FC282C2
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 03:09:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E824D21907
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 03:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YofiSC/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E824D21907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wgCL07bxzDqW0
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 14:09:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="YofiSC/C"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wg9Y0S25zDqNd
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 14:08:16 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id w4so1008895plz.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Feb 2019 19:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=En/cQz1CaN6WxYMxiMQSVtOzjQANHlMPZ4WLYqhNDmA=;
 b=YofiSC/Cjb9GLlkJgmUFfKOhi86LV/x4z6qQTEKF98WHxATlh9yWJFOfp3tGfwWMBH
 FSOAJxASw7RN4Fp7L8qO0A2+nPs/QDa8iwNX/aQdrjIuq3ZPoSVDNXUCkRaONJZxwGeY
 YxHjs4zmUmH3JvgxM2SvKZ8QlrbP2kzan03FtM4o7Oib7EEtMIVAxx3LSldXzYLVzFW4
 oNlOKevEWFmo77yXsQMOJ5GkMbYRgk0QLxNRhNhdkxBq89XGrG0/jK5JaauY/Zuo94IA
 xEutttpx3u31pmLYqylE/5U2BccKeq5VzNLaWUN5EA9J3s/1CsMJwQArxihFOU0OWWV7
 cvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=En/cQz1CaN6WxYMxiMQSVtOzjQANHlMPZ4WLYqhNDmA=;
 b=EIB58QsfZ6U0fIwbVgoG+Eti/ZELxN6vUXifyFhieF3/YvXxZifmbWA6lOV/YDlGjn
 RENEt20MtG0tgou0Qa5tj6+eFMs4G66Pi+stmQeGOlhOdSUb0B/ufKjDX+304h3+OrZI
 xdURHSTz6aCwD8/GBP+Z7RRYXbVFl/wxGz4bcx+ebkAqwq+NRqjChr7ghvs4B1XJpPtB
 EwmuuVbJy7dqnUgkrMZA4J1qbpmCYNOFrbE/uOgWbEFz1FZafhxc8Jy0orB6sU+CGcMl
 EUAsVJxuEBk17yg2MmJsNdmzLHjHCLppvxO+PZ6ytqZFzuxgTS7dhRlQR0La0OLP7+Zh
 6yWQ==
X-Gm-Message-State: AHQUAuaEhvMnVsqVka0fGAf2G8fuhiwrAFjTasNWl9s263C8zEBwXJ+z
 G1gbqJfwq+Lk/TTVnRqSTONFWqw2
X-Google-Smtp-Source: AHgI3IbuI6yLGBqIhxPmkbIFLG1Wf73TiDPybX8JhYQK0fwwwNs8V8+ASW5RBjLsTRCFHceIR8HzbQ==
X-Received: by 2002:a17:902:a70b:: with SMTP id
 w11mr20128607plq.84.1549595294634; 
 Thu, 07 Feb 2019 19:08:14 -0800 (PST)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id o66sm658884pgo.75.2019.02.07.19.08.12
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Feb 2019 19:08:13 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/7] powerpc/eeh: Use debugfs_create_u32 for eeh_max_freezes
Date: Fri,  8 Feb 2019 14:07:56 +1100
Message-Id: <20190208030802.10805-1-oohall@gmail.com>
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
Cc: Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

There's no need to the custom getter/setter functions so we should remove
them in favour of using the generic one. While we're here, change the type
of eeh_max_freeze to uint32_t and print the value in decimal rather than
hex because printing it in hex makes no sense.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/include/asm/eeh.h |  2 +-
 arch/powerpc/kernel/eeh.c      | 21 +++------------------
 2 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 8b596d096ebe..c003628441cc 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -219,7 +219,7 @@ struct eeh_ops {
 };
 
 extern int eeh_subsystem_flags;
-extern int eeh_max_freezes;
+extern uint32_t eeh_max_freezes;
 extern struct eeh_ops *eeh_ops;
 extern raw_spinlock_t confirm_error_lock;
 
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index ae05203eb4de..f6e65375a8de 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -109,7 +109,7 @@ EXPORT_SYMBOL(eeh_subsystem_flags);
  * frozen count in last hour exceeds this limit, the PE will
  * be forced to be offline permanently.
  */
-int eeh_max_freezes = 5;
+uint32_t eeh_max_freezes = 5;
 
 /* Platform dependent EEH operations */
 struct eeh_ops *eeh_ops = NULL;
@@ -1796,22 +1796,8 @@ static int eeh_enable_dbgfs_get(void *data, u64 *val)
 	return 0;
 }
 
-static int eeh_freeze_dbgfs_set(void *data, u64 val)
-{
-	eeh_max_freezes = val;
-	return 0;
-}
-
-static int eeh_freeze_dbgfs_get(void *data, u64 *val)
-{
-	*val = eeh_max_freezes;
-	return 0;
-}
-
 DEFINE_DEBUGFS_ATTRIBUTE(eeh_enable_dbgfs_ops, eeh_enable_dbgfs_get,
 			 eeh_enable_dbgfs_set, "0x%llx\n");
-DEFINE_DEBUGFS_ATTRIBUTE(eeh_freeze_dbgfs_ops, eeh_freeze_dbgfs_get,
-			 eeh_freeze_dbgfs_set, "0x%llx\n");
 #endif
 
 static int __init eeh_init_proc(void)
@@ -1822,9 +1808,8 @@ static int __init eeh_init_proc(void)
 		debugfs_create_file_unsafe("eeh_enable", 0600,
 					   powerpc_debugfs_root, NULL,
 					   &eeh_enable_dbgfs_ops);
-		debugfs_create_file_unsafe("eeh_max_freezes", 0600,
-					   powerpc_debugfs_root, NULL,
-					   &eeh_freeze_dbgfs_ops);
+		debugfs_create_u32("eeh_max_freezes", 0600,
+				powerpc_debugfs_root, &eeh_max_freezes);
 #endif
 	}
 
-- 
2.20.1

