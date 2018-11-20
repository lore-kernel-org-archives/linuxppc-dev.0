Return-Path: <SRS0=vwdz=N7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDDEC04EBC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 13:01:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF13020672
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 13:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qv3OyuNI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF13020672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42zm7P3C6HzDrj2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 00:01:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qv3OyuNI";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=tiny.windzz@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qv3OyuNI"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42zm2V4pVVzF3Wr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 23:57:38 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id w73so958445pfk.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 04:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=ehElaOGNaa+9uehoMuZC2eArC7M9wbegSB7h/+nKnWI=;
 b=Qv3OyuNISewIMaQsvKFFvhoFhObzRyAV6Sg/hro1DiEddVXaaos5VhlJ4qE4nV3IoZ
 AzkWyEx9LTJYFcD0/CLiZPze0zzEwPrvchr54J0zScsgUXR6Rs1Yad8pQBuRJ9Hafb/i
 sAclzJxvIQN04YlktaKAOFXWRueACQLbof7zEprxpT/coTU7V/3w/vvSweRg3n+9Vmh6
 bgEUcoOYAkKNsRhOPftLQ1S8YSbfswV/1yqfllGkA1GGdc1WkvJ+6aJ9MJNrYelaa1kV
 V1Ui0zq3olUb2DAU8nThrIni7P87VW9fwsZuT0w5ft0sDWZquZogU8StL9jInccTH2Ao
 IReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=ehElaOGNaa+9uehoMuZC2eArC7M9wbegSB7h/+nKnWI=;
 b=GU+oILE3TcO2YYckm89uFTfJDAL6We7y8jYAlTV2cQjqHOuAXIS0neeydvpmmjeomd
 P9ZxzUX4WVhSCl7rnsvvvZ2Pj4pdBtmu9pf1LrPgslGTC3oSx02+XClmbETctSwYuQAP
 n/Ml6x1RQa7xa1+wYr0ulc2MxWkTXRq6CB74Vy6HHCks4DyrJVnvJC2YKAniCtZNij2Q
 rUo2gg5AnOhp4bG5L4KDP1/pB50goa4hT+Bb3ClxOWGdZpYYysFQLAWAJ7+O9VSXLAql
 5EcXMC1NIrtU+bnZua8IK4mSFUS5fYEfrR3djG2j3VpDje0Vc6KdI+UdeDAiX0wNzlcS
 +qZg==
X-Gm-Message-State: AA+aEWZEODUC/KfwZp8At5jdl2+LyRjUVCQk6Bo6jQnpQsy6h3f7xGMj
 a6cjkfwk31Vt9/7YcHnDMLo=
X-Google-Smtp-Source: AFSGD/WNJ6Z0Ru49H+Qch6MbX+3qreMsatnQ3/MIToC6DDyHW7UKJ27WnPq4yC3OmYbBgPATGBCjFA==
X-Received: by 2002:a65:4b82:: with SMTP id t2mr1790628pgq.189.1542718656979; 
 Tue, 20 Nov 2018 04:57:36 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id e123sm43854673pgc.58.2018.11.20.04.57.36
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 20 Nov 2018 04:57:36 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH] cpufreq: powernv: add of_node_put()
Date: Tue, 20 Nov 2018 07:57:31 -0500
Message-Id: <20181120125731.19368-1-tiny.windzz@gmail.com>
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

use of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
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

