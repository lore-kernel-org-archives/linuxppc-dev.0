Return-Path: <SRS0=Luu/=QX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30B7C43381
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Feb 2019 17:08:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE5672192B
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Feb 2019 17:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9Dv3YYk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE5672192B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 441xQy3V3LzDqVy
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Feb 2019 04:08:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=tiny.windzz@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="n9Dv3YYk"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 441xP73Qh5zDqRv
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Feb 2019 04:06:32 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id y10so6540211plp.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Feb 2019 09:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=ja6mCcRLlYPsEVUIAvpllb4e3KJQWF+U3raMEkM81WA=;
 b=n9Dv3YYkhcHJajvQY58H1OcgiXeFtniUh7pwL93X6IO21Pgxy9LsH/hob3e9tTR2B7
 NuCfejpyNSGuF7O1nXy6p9jFIldGYL7sWUEyaiUk013K9LE1mfoT/GzcgfWOApEsOiNe
 y/DhBUFziXR+16MZ0ovyLWx3UYd9LaEupFr2142n91+U2O8jwrUGxo6oj72gwE58Vi7h
 UhJtjrM9w33PAC9gduL2KOE0CD0TgFSE/gMyZGbDJaEjTDr2VleYZRPOryuE0iFIq0Fd
 HzbIDE5tPdJBj+W8xWVsd0qq8VGPF5ndFv2Egl+3oBlvI+5vZOGunM0cupEd3+w72yzy
 hgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=ja6mCcRLlYPsEVUIAvpllb4e3KJQWF+U3raMEkM81WA=;
 b=Bo6bMPbuV9W9CzD2ToXkB6XpPnU3wewPi3FyqxfdUor9belsOkoVPGUi1J46d+Hfwl
 uAxoKgGoJ0rbSIN1CXYOya5cxitxg1VdJ7pI3A/SASkuLdxh0hqm+HG25aVRgjEpl7nL
 oQpKdAOTzK42AJ1dgq8wqXMG+izD21lUEFYVPf5OLIVo/ewdG2pO9YXoIJgiJS5GT619
 ZeoXgtV4qZbfXJBtGGIiR5G7qiLttYS8Dnwt5qpZpFiyipZBnGK8nkcZXDJHf8f1GnZ4
 UgQdu/Ty5WIwjAg8AJINnBQnEowXEEL00Hv/oiGjMjecHsxcvvrZPpbbq7dj2DRg7jNR
 Se0Q==
X-Gm-Message-State: AHQUAua8PHaxtO7/YqxKuVQUwZ/9yOTwvzCyNlbpw9FcWkuCoObx7UV0
 IwGgiKnQvICK8T5jiqVbAH8=
X-Google-Smtp-Source: AHgI3IZfTLoHZuOBTtj+tPGxsaO1d9aaF92QN6NRLj30AVpQyKOBVF5ko/qopM+WhNn1qe49x4D1VA==
X-Received: by 2002:a17:902:509:: with SMTP id 9mr15342227plf.94.1550336790185; 
 Sat, 16 Feb 2019 09:06:30 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id e24sm11644429pfi.153.2019.02.16.09.06.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 16 Feb 2019 09:06:29 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH] cpufreq: powernv: fix missing check of return value in
 init_powernv_pstates()
Date: Sat, 16 Feb 2019 12:06:23 -0500
Message-Id: <20190216170623.12634-1-tiny.windzz@gmail.com>
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

kmalloc() could fail, so insert a check of its return value. And
if it fails, returns -ENOMEM.

And remove (struct pstate_idx_revmap_data *) to fix coccinelle WARNING
by the way.

WARNING: casting value returned by memory allocation function to (struct
pstate_idx_revmap_data *) is useless.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 7e7ad3879c4e..d2230812fa4b 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -244,6 +244,7 @@ static int init_powernv_pstates(void)
 	u32 len_ids, len_freqs;
 	u32 pstate_min, pstate_max, pstate_nominal;
 	u32 pstate_turbo, pstate_ultra_turbo;
+	int rc = -ENODEV;
 
 	power_mgt = of_find_node_by_path("/ibm,opal/power-mgt");
 	if (!power_mgt) {
@@ -327,8 +328,11 @@ static int init_powernv_pstates(void)
 		powernv_freqs[i].frequency = freq * 1000; /* kHz */
 		powernv_freqs[i].driver_data = id & 0xFF;
 
-		revmap_data = (struct pstate_idx_revmap_data *)
-			      kmalloc(sizeof(*revmap_data), GFP_KERNEL);
+		revmap_data = kmalloc(sizeof(*revmap_data), GFP_KERNEL);
+		if (!revmap_data) {
+			rc = -ENOMEM;
+			goto out;
+		}
 
 		revmap_data->pstate_id = id & 0xFF;
 		revmap_data->cpufreq_table_idx = i;
@@ -357,7 +361,7 @@ static int init_powernv_pstates(void)
 	return 0;
 out:
 	of_node_put(power_mgt);
-	return -ENODEV;
+	return rc;
 }
 
 /* Returns the CPU frequency corresponding to the pstate_id. */
-- 
2.17.0

