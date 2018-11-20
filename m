Return-Path: <SRS0=vwdz=N7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDE9C32789
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 16:08:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78A2B20684
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 16:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLNNeswc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78A2B20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42zrG02wrCzF3WB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 03:07:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jLNNeswc";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=tiny.windzz@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="jLNNeswc"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42zrCL6PmrzF3W7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2018 03:05:34 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id w6so1094729pgl.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 08:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=v7hJLl0nspNEvb5LwkAvDpIYRT2ClkaKvvqCVQdKmBE=;
 b=jLNNeswcf3FOJ5G9jP4ic5x1MQ49CRXg7PKspUXRRdKJUYjSMXRKktrVm0xfUPSWWt
 Nn1dx1poJP7Y6x16+OscSuhwpLAMDbPWYH9pZoEdNSeOozcL79KAja4XbNfYpPRrH/Gu
 KLoPN1Le6IXlfBIjXpuctvAqNUMnOFLzyczaAqSBb/ixxt3J+awRiA3fGbgyq1Nz+J/S
 9Jb+UfiZ1SD4f3IXrWax/47fq8Qok6nZrVmbanf232Te9TVu5FHZHOrzbxXe6d/Gh1Qj
 ZTnLh89jOpCL/nyBcQVStfXo2yt9yWInLVEfKSYQ4JcLQEi+R2NqsIWBIuqkIREXjMC0
 TlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=v7hJLl0nspNEvb5LwkAvDpIYRT2ClkaKvvqCVQdKmBE=;
 b=p1JkwZxmrLdi4ymnd2Ztq7CtVDkvWPkPtTvwqV1a/nwGJeGX6AFhwYvL5TXRXLq0cL
 atNgPOMYwB/uRMG9CVSVbIK5Q1cbvwE4/1a/vFE6AJMfs9usWKhFPOLDIGO7UFg+2DDS
 os5fTWkLgHg+aAkwYtUxSaL6gjO4zySK84yxhx/l87MUyC0sU4d56JDbto5ebLZaRvzM
 UUDRc4xDz4YQA1IhIGnkWUHA3xneNrCIficykkner30oDUP43Q808lDSFRkTQSvTJkfr
 wuKBrOEe3aUgVpwcBjo05tQdkGtPdm+wBrJC3XvdP6Qwf/pcwU9njYguBRX/jRUWgnxs
 uhvA==
X-Gm-Message-State: AA+aEWa527eaSqP9m89PSZzH/w92bQM2vKBAajLczlC+2shttOM8WonG
 D1hEvJo2Zg3VOp4ns4BevTU=
X-Google-Smtp-Source: AJdET5f9hOLNARt5YmCnrd1st/tsZu05GUlkalcnzc0Pg4UW1WxNW0kADQMEVgT4jAPWiAVs3R2GGg==
X-Received: by 2002:a63:2d82:: with SMTP id t124mr2422551pgt.260.1542729932942; 
 Tue, 20 Nov 2018 08:05:32 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id i63-v6sm10019749pfi.66.2018.11.20.08.05.31
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 20 Nov 2018 08:05:32 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH v2] cpufreq: powernv: add of_node_put()
Date: Tue, 20 Nov 2018 11:05:30 -0500
Message-Id: <20181120160530.21015-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
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
Cc: Yangtao Li <tiny.windzz@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The of_find_node_by_path() returns a node pointer with refcount
incremented,but there is the lack of use of the of_node_put() when
done.Add the missing of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
Changes in v2
-update changelog
---
 drivers/cpufreq/powernv-cpufreq.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index bf6519cf64bc..7e7ad3879c4e 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -253,18 +253,18 @@ static int init_powernv_pstates(void)
 
 	if (of_property_read_u32(power_mgt, "ibm,pstate-min", &pstate_min)) {
 		pr_warn("ibm,pstate-min node not found\n");
-		return -ENODEV;
+		goto out;
 	}
 
 	if (of_property_read_u32(power_mgt, "ibm,pstate-max", &pstate_max)) {
 		pr_warn("ibm,pstate-max node not found\n");
-		return -ENODEV;
+		goto out;
 	}
 
 	if (of_property_read_u32(power_mgt, "ibm,pstate-nominal",
 				 &pstate_nominal)) {
 		pr_warn("ibm,pstate-nominal not found\n");
-		return -ENODEV;
+		goto out;
 	}
 
 	if (of_property_read_u32(power_mgt, "ibm,pstate-ultra-turbo",
@@ -293,14 +293,14 @@ static int init_powernv_pstates(void)
 	pstate_ids = of_get_property(power_mgt, "ibm,pstate-ids", &len_ids);
 	if (!pstate_ids) {
 		pr_warn("ibm,pstate-ids not found\n");
-		return -ENODEV;
+		goto out;
 	}
 
 	pstate_freqs = of_get_property(power_mgt, "ibm,pstate-frequencies-mhz",
 				      &len_freqs);
 	if (!pstate_freqs) {
 		pr_warn("ibm,pstate-frequencies-mhz not found\n");
-		return -ENODEV;
+		goto out;
 	}
 
 	if (len_ids != len_freqs) {
@@ -311,7 +311,7 @@ static int init_powernv_pstates(void)
 	nr_pstates = min(len_ids, len_freqs) / sizeof(u32);
 	if (!nr_pstates) {
 		pr_warn("No PStates found\n");
-		return -ENODEV;
+		goto out;
 	}
 
 	powernv_pstate_info.nr_pstates = nr_pstates;
@@ -352,7 +352,12 @@ static int init_powernv_pstates(void)
 
 	/* End of list marker entry */
 	powernv_freqs[i].frequency = CPUFREQ_TABLE_END;
+
+	of_node_put(power_mgt);
 	return 0;
+out:
+	of_node_put(power_mgt);
+	return -ENODEV;
 }
 
 /* Returns the CPU frequency corresponding to the pstate_id. */
-- 
2.17.0

