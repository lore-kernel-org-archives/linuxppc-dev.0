Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4532CC10F12
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 07:16:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75F3320821
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 07:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHE7LSfV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F3320821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kYSL0dCBzDqMb
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 17:16:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::142; helo=mail-lf1-x142.google.com;
 envelope-from=mohankumar718@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="HHE7LSfV"; 
 dkim-atps=neutral
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com
 [IPv6:2a00:1450:4864:20::142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44kYF15YZ6zDqC8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 17:06:26 +1000 (AEST)
Received: by mail-lf1-x142.google.com with SMTP id u17so18043104lfi.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 00:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=S9RZFSRW57VtsUIcux9hVk8YIz9I5oYSs8c9bBSdg8g=;
 b=HHE7LSfV4rSk2kILbi/if22pdx/SlNLunq42CQlsSh168S5KFwBeWJOkGSqv9EbNrv
 R7lsPltWYy7DNqCorCn8eKcE3v/JIMJygLav3BSGz34VfvpbJ9Gw6rc0BLyUxnBds0Xv
 AHWhwufsv58ZjLXO0PYoD3Y3F6TRTsuxGcaVrqHViqFjd2vqNT8hGJeL7lPpjAuvERD2
 ITOPXvPME6uBgoINtz0yUWxn7Rtv41z0y8bkJxnCYDHAdSXAaWV0qQ+B44uuelZ7IvJq
 v73Hvjx7stq/5Nh5X3xaEbHjI6+VVcCWeM3zNE7a7QVsAOgaEf21lNTooKi4HueKkfpD
 jSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=S9RZFSRW57VtsUIcux9hVk8YIz9I5oYSs8c9bBSdg8g=;
 b=s2uzp5hZXn1p4xa5rxIKMPhDkLP0SNcrRrqoChkNCeFnRuyixdd3rc8YBDIp2OsTfK
 mVYLG9rOAJzUQHoleDJqCUb4m+77/nZMe6XEEvTEAfexyStzrY53AwLfDuu3jME1mbm8
 WEeUxnv3lU8w9UjbZ7T3vOCcguz26QYLUOgqyFVE4hxtE4LSTdyMjjon/I1VxsDS6cOY
 y97qIh5XQKJVed/JP1AWK+pPF7wMGufyNybyH+1i1DcNiTowaocsEgf2LNhN/f52+edt
 L45Yuh6Icor7olA+Of8vi3W2e4y2pz1y668tStc4agEbmYMfeJWUERArLqJVw/zHgVe5
 99Ug==
X-Gm-Message-State: APjAAAVGW6ygcKUmJr1cWByp2YJWN6zwsS7JDDLSVlzRuhkfot8ozhZk
 STkZ3x0MPiFfA3NovZ1MS30=
X-Google-Smtp-Source: APXvYqyuP5rXH0JLj607qwgN67cxW27wWX7j+d+b3g+XCZewDC5wYCfmJahpksBJP5FEqacMnyjPPw==
X-Received: by 2002:ac2:44b2:: with SMTP id c18mr3882546lfm.86.1555484780022; 
 Wed, 17 Apr 2019 00:06:20 -0700 (PDT)
Received: from localhost.localdomain (62-167-31.netrun.cytanet.com.cy.
 [62.228.167.31])
 by smtp.gmail.com with ESMTPSA id z15sm10492236ljz.55.2019.04.17.00.06.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 17 Apr 2019 00:06:19 -0700 (PDT)
From: Mohan Kumar <mohankumar718@gmail.com>
To: rjw@rjwysocki.net
Subject: [PATCH] drivers: cpuidle: This patch fix the following checkpatch
 warning.
Date: Wed, 17 Apr 2019 10:06:14 +0300
Message-Id: <1555484774-5866-1-git-send-email-mohankumar718@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Mailman-Approved-At: Wed, 17 Apr 2019 17:14:46 +1000
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
Cc: linux-pm@vger.kernel.org, daniel.lezcano@linaro.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Use pr_debug instead of printk

WARNING: Prefer [subsystem eg: netdev]_dbg([subsystem]dev, ...
then dev_dbg(dev, ... then pr_debug(...  to printk(KERN_DEBUG ...

Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
---
 drivers/cpuidle/cpuidle-pseries.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index 74c2479..a9c1db8 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -282,7 +282,7 @@ static int __init pseries_processor_idle_init(void)
 	pseries_cpuidle_driver_init();
 	retval = cpuidle_register(&pseries_idle_driver, NULL);
 	if (retval) {
-		printk(KERN_DEBUG "Registration of pseries driver failed.\n");
+		pr_debug("Registration of pseries driver failed.\n");
 		return retval;
 	}
 
@@ -294,7 +294,7 @@ static int __init pseries_processor_idle_init(void)
 					   "cpuidle/pseries:DEAD", NULL,
 					   pseries_cpuidle_cpu_dead);
 	WARN_ON(retval < 0);
-	printk(KERN_DEBUG "pseries_idle_driver registered\n");
+	pr_debug("pseries_idle_driver registered\n");
 	return 0;
 }
 
-- 
2.7.4

