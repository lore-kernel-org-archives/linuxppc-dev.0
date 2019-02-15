Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7E4C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 00:59:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59F0E21934
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 00:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inNMbFHG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59F0E21934
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440vzK3j50zDqbW
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 11:59:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="inNMbFHG"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440vl33ZqHzDqXw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 11:48:31 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id b5so4065216plr.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 16:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UIYE9bYdcfMHJWGBvuW6VhheEmQQriaN8OUL9MeITH8=;
 b=inNMbFHGn3B3B+fHFXXNq5m+4AsqSG2fuRm1aez699mrtKYWdtnUBBCMMI14LTTuQx
 ID6TGZ5XetnPajjk0VUN8+eeia8uRTAWd2jeWmrdFyei+2AJ80w2kJfTTMrOKq/O00FV
 a9/kWel1JW0ZHhUkDp1sc340c2h4BYDVH7Pszckqd1qTZsExc+rw7AAqhW6MOHSQjFBf
 M9KnZgl6+3etPbKyWezttiDCDSob9WIA3SbDWAVFRGG6whBwoGLlDRVbc9hgVElhxxoY
 9NvdAoCsuDCv9tkqh2dSWN4qB9vT/pdNXUhY4HuUCPrLIR9HeldRwgIxxpG0+xH/vqSp
 nkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UIYE9bYdcfMHJWGBvuW6VhheEmQQriaN8OUL9MeITH8=;
 b=VVVEk1ciAFW2Mzvn7185SKLPpO40N6hfIkCPwm1XiJ5Lqf3oe0UcOhBKqW4SApOS8N
 XmPBDzmbyAHlzuSHbrO1TzS39JoPR0gdnqcBaRldlwTPrvm3/dzcJpXISAfTWJPMYxWj
 wHqw14AMMX/ACyVY6siRMp1JG8916oI85wphvzbUKWL2zV9BS400YJLxzG95QQFU1tPo
 JCKFv70SJkzVWOvAuXDfcV/vnKbqUK1WfLad8Bgp4Tj9QFx48X9cmLZRC8cVHJyJOP4L
 IRrmny5e3X9HZp3c0ZnMATvsk5FFkPI3Eyt24HfRUYzbGSeWYdABWyyDqvdg4Nk4+4Fs
 zDcg==
X-Gm-Message-State: AHQUAuYVYekIQnxWya7ihZ3CYB9Anef0M9BCVqxuxf902VI4UBO8Q6X+
 TFc05a6oTa7D2vSDXiF3KJfsDqbs
X-Google-Smtp-Source: AHgI3IbpfMjc2eoDpyfv6ACQlOhdLdr/NAp15eG7wsXv+RABkHh2k6e6oS0ALRpekgUCWRdg+TZ92Q==
X-Received: by 2002:a17:902:8341:: with SMTP id
 z1mr7258477pln.150.1550191708898; 
 Thu, 14 Feb 2019 16:48:28 -0800 (PST)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id v26sm4993751pfg.62.2019.02.14.16.48.26
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 14 Feb 2019 16:48:28 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/7] powerpc/eeh: Use debugfs_create_u32 for eeh_max_freezes
Date: Fri, 15 Feb 2019 11:48:11 +1100
Message-Id: <20190215004817.19961-1-oohall@gmail.com>
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
Cc: sbobroff@linux.ibm.com, Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

There's no need to the custom getter/setter functions so we should remove
them in favour of using the generic one. While we're here, change the type
of eeh_max_freeze to u32 and print the value in decimal rather than
hex because printing it in hex makes no sense.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
v2: Replaced uint32_t with u32.
---
 arch/powerpc/include/asm/eeh.h |  2 +-
 arch/powerpc/kernel/eeh.c      | 21 +++------------------
 2 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 8b596d096ebe..2daecd677855 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -219,7 +219,7 @@ struct eeh_ops {
 };
 
 extern int eeh_subsystem_flags;
-extern int eeh_max_freezes;
+extern u32 eeh_max_freezes;
 extern struct eeh_ops *eeh_ops;
 extern raw_spinlock_t confirm_error_lock;
 
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index ae05203eb4de..d021f5abeec5 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -109,7 +109,7 @@ EXPORT_SYMBOL(eeh_subsystem_flags);
  * frozen count in last hour exceeds this limit, the PE will
  * be forced to be offline permanently.
  */
-int eeh_max_freezes = 5;
+u32 eeh_max_freezes = 5;
 
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

