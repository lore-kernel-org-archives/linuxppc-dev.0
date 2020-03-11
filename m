Return-Path: <SRS0=kzwA=44=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1324C10F25
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2020 07:41:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71CC820578
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2020 07:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71CC820578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (unknown [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48ckRb1r5szDqQg
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2020 18:41:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=tiwai@suse.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.de
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48ckPn4XTszDqDf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2020 18:39:51 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 87D21AD72;
 Wed, 11 Mar 2020 07:39:45 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 linux-hwmon@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] hwmon: (ibmpowernv) Use scnprintf() for avoiding potential
 buffer overflow
Date: Wed, 11 Mar 2020 08:39:44 +0100
Message-Id: <20200311073944.7487-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Since snprintf() returns the would-be-output size instead of the
actual output size, the succeeding calls may go beyond the given
buffer limit.  Fix it by replacing with scnprintf().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/hwmon/ibmpowernv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
index 0e525cfbdfc5..a750647e66a4 100644
--- a/drivers/hwmon/ibmpowernv.c
+++ b/drivers/hwmon/ibmpowernv.c
@@ -186,7 +186,7 @@ static void make_sensor_label(struct device_node *np,
 	u32 id;
 	size_t n;
 
-	n = snprintf(sdata->label, sizeof(sdata->label), "%s", label);
+	n = scnprintf(sdata->label, sizeof(sdata->label), "%s", label);
 
 	/*
 	 * Core temp pretty print
@@ -199,11 +199,11 @@ static void make_sensor_label(struct device_node *np,
 			 * The digital thermal sensors are associated
 			 * with a core.
 			 */
-			n += snprintf(sdata->label + n,
+			n += scnprintf(sdata->label + n,
 				      sizeof(sdata->label) - n, " %d",
 				      cpuid);
 		else
-			n += snprintf(sdata->label + n,
+			n += scnprintf(sdata->label + n,
 				      sizeof(sdata->label) - n, " phy%d", id);
 	}
 
@@ -211,7 +211,7 @@ static void make_sensor_label(struct device_node *np,
 	 * Membuffer pretty print
 	 */
 	if (!of_property_read_u32(np, "ibm,chip-id", &id))
-		n += snprintf(sdata->label + n, sizeof(sdata->label) - n,
+		n += scnprintf(sdata->label + n, sizeof(sdata->label) - n,
 			      " %d", id & 0xffff);
 }
 
-- 
2.16.4

