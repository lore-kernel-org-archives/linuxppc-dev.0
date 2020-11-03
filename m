Return-Path: <SRS0=iSul=EJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0AAC2D0A3
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2020 09:34:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F8F7223BD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2020 09:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="T5pOlxf8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8F7223BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fossix.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CQPkx1VwpzDqXG
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2020 20:34:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=fossix.org
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=santosh@fossix.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=fossix.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=fossix-org.20150623.gappssmtp.com
 header.i=@fossix-org.20150623.gappssmtp.com header.a=rsa-sha256
 header.s=20150623 header.b=T5pOlxf8; dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CQPhq5gylzDqLW
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2020 20:32:55 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id y14so13662677pfp.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2020 01:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fossix-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bXPiKnajprsVmoagr8lc4F80WvhfqnnWb0E5r9CyaTA=;
 b=T5pOlxf8VV1zzfEju8qFL0DQ4EgCEIfPJz8yMuOXt9szWzNyKhE3E7pCm9Z+QU9CmQ
 nFrDtg7EldsI+XtcSwwtrCnMy2PqYorfKH7J31UgniG2rjwnNWjcnLc6uVdBJdxsxsoU
 vE/JNiNwI72jpR/PfnREef8qfnb/YPJj/H4Mhz0hrhMa+s7R3UzhhVoATGKGImB+hfZf
 vJB9T46VmRkQyPI5Dvtxp8xkOVwKj96e1WYcF9kvLK2nU6ol8WdoGfdDU8IHvSXXa7s+
 l+vQ+h0j0cZAxTv6mCAnYz5y+8WayoQQIJ+8zbVpb9CODqZgIxt+fV7VxCv+38oV9fKV
 3JvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bXPiKnajprsVmoagr8lc4F80WvhfqnnWb0E5r9CyaTA=;
 b=PSuN40TWNx4WBUbHtZXjrEJRqkFJyoTF/0fT/wVwG5zQlBpbuuYPvQGYTFpMr2sIvR
 ZrxZB4pn+EoL5KZg/6ZN9AiEBxMTXPda6lErDcvsYB033SaTwAIeML0mWWLfDz8KK7gt
 I2sPsigTIXwwD2yvpToBaUJj+rh2EXxctUc0ltVcLtVyBik+8G4yj3csG/IdKAJ72MgV
 jISoZy77AuTocEHSidBG93WhLssW9r2Cxm0Vf9W6YwJPMgiaCK2gH31T42r0ELi4wDbd
 wLbAO6Bmfas8XGpRvhQZuQVl7/emnUBkz+TaUg0xH/2GQFJhsGPzOUScdb+lFoIaLUkS
 dwKA==
X-Gm-Message-State: AOAM530Pe0+fLDbyllvAikotUzG+c33Z7Mg39s1gxXGMDZANZI/1U1mI
 8JE3N7YXHgu03iijTjihSgJO7A==
X-Google-Smtp-Source: ABdhPJxFlhZATRI9DgOKBEyXjdfT2Eg14GrNTRW8hc1WOeEvBSg28bBtiktlPKw2bfrHQ9h0nZhDOA==
X-Received: by 2002:a65:688b:: with SMTP id e11mr6790464pgt.175.1604395972269; 
 Tue, 03 Nov 2020 01:32:52 -0800 (PST)
Received: from santosiv.in.ibm.com.com ([103.21.79.4])
 by smtp.gmail.com with ESMTPSA id 194sm4441193pfz.142.2020.11.03.01.32.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 01:32:51 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [RESEND PATCH] kernel/watchdog: Fix watchdog_allowed_mask not used
 warning
Date: Tue,  3 Nov 2020 15:02:35 +0530
Message-Id: <20201103093235.655665-1-santosh@fossix.org>
X-Mailer: git-send-email 2.26.2
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
Cc: pmladek@suse.com, Santosh Sivaraj <santosh@fossix.org>,
 bala24@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Define watchdog_allowed_mask only when SOFTLOCKUP_DETECTOR is enabled.

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---

Original patch is here:
https://lore.kernel.org/lkml/20190807014417.9418-1-santosh@fossix.org/

A similar patch was also sent by Balamuruhan and reviewed by Petr.
https://lkml.org/lkml/2020/8/20/1030

 kernel/watchdog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 5abb5b22ad13..71109065bd8e 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -44,8 +44,6 @@ int __read_mostly soft_watchdog_user_enabled = 1;
 int __read_mostly watchdog_thresh = 10;
 static int __read_mostly nmi_watchdog_available;
 
-static struct cpumask watchdog_allowed_mask __read_mostly;
-
 struct cpumask watchdog_cpumask __read_mostly;
 unsigned long *watchdog_cpumask_bits = cpumask_bits(&watchdog_cpumask);
 
@@ -162,6 +160,8 @@ static void lockup_detector_update_enable(void)
 int __read_mostly sysctl_softlockup_all_cpu_backtrace;
 #endif
 
+static struct cpumask watchdog_allowed_mask __read_mostly;
+
 /* Global variables, exported for sysctl */
 unsigned int __read_mostly softlockup_panic =
 			CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE;
-- 
2.26.2

