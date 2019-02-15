Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B0EC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 01:07:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05F7121934
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 01:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBYz2HKb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05F7121934
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440w950d0zzDq6M
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 12:07:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="OBYz2HKb"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440vlF4mw8zDqYM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 11:48:41 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id u6so3957789pfh.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 16:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zq9ro1PNUrGZhz3vdvQdB+Sa2oN1F8UCArtchBdWO2I=;
 b=OBYz2HKbKws2HNfVeuDnKk5zob4ysGDnrz10Rr0P3jCUNJ/kanycGdASg5erIOYa6y
 guhgR8RoCPrEWzRhSG08OzTMqz/PkvXbxzm4Z10hl5l3zNNDSddJVVsq914kdgEJWtWn
 jjHVjDmk0UQq29S9D/gr6ad9Y3fxTSfxI7e0NU2ArhKGXRJTUyv6dLPj+6CjZgo1YQ9k
 pifQiI9huURevT9RGJYRuCowmtHKzm3cRSdcamXy02H+S2Jd5LjYPr75fpEELG6unXnC
 uyc01yfR3Bp78trKm5pzLU6N+RGL+O+adWLLM3ztensa5VawXmAHSjPBx3O8vkaXKv2d
 2PWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zq9ro1PNUrGZhz3vdvQdB+Sa2oN1F8UCArtchBdWO2I=;
 b=r2ndDmF1y2xfNI4zrpgkjKWOuFgZgLDJ/MW3qTuV5fAlc8vdzzt+yf3xD64rEDlEvC
 gg1OE5teD58J4CiZ0IRWzPm2VZTHwiw7IMkFtFPE3TrJ53AG5RJZKbR3OTr2hP2eJQLP
 q1uUbPBDxGGCOuy2KhEOYApRFPyL8ZY7dfl6VWKyraoNdoC7vjt/JllXaBDRMRs+gOxu
 L/LqhtZOYoEMIY0fGaXgFZBbMxMJXgEaoMSqsRp40zK9VW3gY2YaiKxwYkZuzNi0XXC9
 YinpwwsCjVmdOLSwlLYMlhon9WKz1BgqfJc5MrSQ7+nQqmKux5KUrVToBPt8uBgTe1m5
 jeLQ==
X-Gm-Message-State: AHQUAuaGkvUVyKPw/ST4sECl/INvUz6HzC2bupyOxX5L3LCpA3BDldpi
 lHamjMeAkvyY9wY0MAMCc9xSyPJ6
X-Google-Smtp-Source: AHgI3IbZcV3gFXlFpPYyEDMdAr88da8KBA5dwT44xxLXkbxSf4CPk3bSuW8TY4G9PBGHEv0cmcceZA==
X-Received: by 2002:a63:d047:: with SMTP id s7mr2655013pgi.311.1550191719770; 
 Thu, 14 Feb 2019 16:48:39 -0800 (PST)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id v26sm4993751pfg.62.2019.02.14.16.48.37
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 14 Feb 2019 16:48:39 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 6/7] powerpc/eeh: Allow disabling recovery
Date: Fri, 15 Feb 2019 11:48:16 +1100
Message-Id: <20190215004817.19961-6-oohall@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215004817.19961-1-oohall@gmail.com>
References: <20190215004817.19961-1-oohall@gmail.com>
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

Currently when we detect an error we automatically invoke the EEH recovery
handler. This can be annoying when debugging EEH problems, or when working
on EEH itself so this patch adds a debugfs knob that will prevent a
recovery event from being queued up when an issue is detected.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/include/asm/eeh.h  |  1 +
 arch/powerpc/kernel/eeh.c       | 10 ++++++++++
 arch/powerpc/kernel/eeh_event.c |  9 +++++++++
 3 files changed, 20 insertions(+)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 478f199d5663..810e05273ad3 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -220,6 +220,7 @@ struct eeh_ops {
 
 extern int eeh_subsystem_flags;
 extern u32 eeh_max_freezes;
+extern bool eeh_debugfs_no_recover;
 extern struct eeh_ops *eeh_ops;
 extern raw_spinlock_t confirm_error_lock;
 
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 82d22c671c0e..9f20099ce2d9 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -111,6 +111,13 @@ EXPORT_SYMBOL(eeh_subsystem_flags);
  */
 u32 eeh_max_freezes = 5;
 
+/*
+ * Controls whether a recovery event should be scheduled when an
+ * isolated device is discovered. This is only really useful for
+ * debugging problems with the EEH core.
+ */
+bool eeh_debugfs_no_recover;
+
 /* Platform dependent EEH operations */
 struct eeh_ops *eeh_ops = NULL;
 
@@ -1810,6 +1817,9 @@ static int __init eeh_init_proc(void)
 					   &eeh_enable_dbgfs_ops);
 		debugfs_create_u32("eeh_max_freezes", 0600,
 				powerpc_debugfs_root, &eeh_max_freezes);
+		debugfs_create_bool("eeh_disable_recovery", 0600,
+				powerpc_debugfs_root,
+				&eeh_debugfs_no_recover);
 		eeh_cache_debugfs_init();
 #endif
 	}
diff --git a/arch/powerpc/kernel/eeh_event.c b/arch/powerpc/kernel/eeh_event.c
index 227e57f980df..19837798bb1d 100644
--- a/arch/powerpc/kernel/eeh_event.c
+++ b/arch/powerpc/kernel/eeh_event.c
@@ -126,6 +126,15 @@ int eeh_send_failure_event(struct eeh_pe *pe)
 	unsigned long flags;
 	struct eeh_event *event;
 
+	/*
+	 * If we've manually supressed recovery events via debugfs
+	 * then just drop it on the floor.
+	 */
+	if (eeh_debugfs_no_recover) {
+		pr_err("EEH: Event dropped due to no_recover setting\n");
+		return 0;
+	}
+
 	event = kzalloc(sizeof(*event), GFP_ATOMIC);
 	if (!event) {
 		pr_err("EEH: out of memory, event not handled\n");
-- 
2.20.1

