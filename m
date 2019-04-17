Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C70C282DA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 14:54:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7634221773
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 14:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOAWLP+o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7634221773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44klck6qsgzDqRR
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 00:54:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::144; helo=mail-lf1-x144.google.com;
 envelope-from=mohankumar718@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="MOAWLP+o"; 
 dkim-atps=neutral
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com
 [IPv6:2a00:1450:4864:20::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44klb25K9GzDqBt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 00:52:44 +1000 (AEST)
Received: by mail-lf1-x144.google.com with SMTP id a28so19124723lfo.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 07:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=9nw/YK2zJ58Ci60J7XUCFlBEGHNW1WY/eWuxgJxN48E=;
 b=MOAWLP+oVF13oVbQKCqJNZCj0rPLe6oVjHHqNl/hcUt+7843hetUTORZslrCY2PHfa
 35T3UnVsRfB3dOZV4MqbSrnXanbh9q2dRaQvtk4eAruZ0s3fp/8a3punwYrhzXjuI2kR
 jvb0kVfaGKj9AZg9+UTX7aa8oYt+bp5TnKFmS2vFHicsBDWn36H1URJ/LpBn6ROAL73N
 j4Qd3v1oJ3NhpxsQ8K0YqeRqpPYbluR6eaJIKjPbBqyqSeEK1RkWDSzGtpS/W4hGwQK+
 6WpptlslivEjbvGX3yrees2EVY5mP0VDEzX66ayhekw/3ExgNi+9EEn6kJYrFRSBCHC2
 AnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=9nw/YK2zJ58Ci60J7XUCFlBEGHNW1WY/eWuxgJxN48E=;
 b=NzTxXE4CvFRH7XzS5A+MSUtti9j5p6igCLOufbP3KW4EbxbxDGnZyvz9snIMrQ6f1/
 yhJ3JX95Jl/S9/jI7mfnHodmde+Vi+jxSxWQ96X8nWSD7JmaCcjUxVZIbX14cp6KvbFp
 Op7qnFOtJI7ZjGV0sj5lRkzaWxr5KC6SD/wOd8wO18rPS4JFOkYK6ybgKs/K0IF+jije
 hG06tHScJCQvfYkQIJRa9FR/l4j1LJk6TmJimxo8jASQKUHAB9GIfkuN8aWZXatVAndl
 oFa9c4N/FvS4apeS0RUsef+22IwR4Wk6XUwI7S5NZaPMtfDhQWiTcgVRqbPge/E5BmG2
 mpIQ==
X-Gm-Message-State: APjAAAXPn1L0JbsQFhvifRe7Y/yWKw1Icb5AhcgC9iz+YdPreeLD1C+y
 2VuVaeXfYtKTIBtDG/YM72Q=
X-Google-Smtp-Source: APXvYqxp9farvHtIdCO6ULBc84FlV+QVJbJ0w8usdf1jsQV2DkmHlzQ3AwOGsE/KHFT7WiuXO5J2xA==
X-Received: by 2002:ac2:41d8:: with SMTP id d24mr32478657lfi.56.1555512760453; 
 Wed, 17 Apr 2019 07:52:40 -0700 (PDT)
Received: from localhost.localdomain (62-167-31.netrun.cytanet.com.cy.
 [62.228.167.31])
 by smtp.gmail.com with ESMTPSA id d16sm5490407lfi.75.2019.04.17.07.52.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 17 Apr 2019 07:52:39 -0700 (PDT)
From: Mohan Kumar <mohankumar718@gmail.com>
To: rjw@rjwysocki.net
Subject: [PATCH] drivers: cpuidle: This patch fix the following checkpatch
 warning.
Date: Wed, 17 Apr 2019 17:52:34 +0300
Message-Id: <1555512754-6450-1-git-send-email-mohankumar718@gmail.com>
X-Mailer: git-send-email 2.7.4
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
Cc: daniel.lezcano@linaro.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Use pr_debug instead of printk

WARNING: Prefer [subsystem eg: netdev]_dbg([subsystem]dev, ... then
dev_dbg(dev, ... then pr_debug(...  to printk(KERN_DEBUG ...

Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
---
 drivers/cpuidle/cpuidle-powernv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 84b1ebe..7cf9835 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -401,7 +401,7 @@ static int __init powernv_processor_idle_init(void)
 	powernv_cpuidle_driver_init();
 	retval = cpuidle_register(&powernv_idle_driver, NULL);
 	if (retval) {
-		printk(KERN_DEBUG "Registration of powernv driver failed.\n");
+		pr_debug("Registration of powernv driver failed.\n");
 		return retval;
 	}
 
@@ -413,7 +413,7 @@ static int __init powernv_processor_idle_init(void)
 					   "cpuidle/powernv:dead", NULL,
 					   powernv_cpuidle_cpu_dead);
 	WARN_ON(retval < 0);
-	printk(KERN_DEBUG "powernv_idle_driver registered\n");
+	pr_debug("powernv_idle_driver registered\n");
 	return 0;
 }
 
-- 
2.7.4

