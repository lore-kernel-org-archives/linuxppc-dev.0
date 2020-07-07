Return-Path: <SRS0=AwiL=AS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0DBC433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2020 12:02:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF9D8206BE
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2020 12:02:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF9D8206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B1LfS5scfzDqsM
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2020 22:02:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=zte.com.cn (client-ip=63.217.80.70; helo=mxhk.zte.com.cn;
 envelope-from=wang.yi59@zte.com.cn; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=zte.com.cn
X-Greylist: delayed 944 seconds by postgrey-1.36 at bilbo;
 Tue, 07 Jul 2020 22:00:55 AEST
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.217.80.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B1LcR3QPjzDqmF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jul 2020 22:00:54 +1000 (AEST)
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
 by Forcepoint Email with ESMTPS id 15C503D8B48ABFE1F3AD;
 Tue,  7 Jul 2020 19:44:59 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notes_smtp.zte.com.cn [10.30.1.239])
 by mse-fl1.zte.com.cn with ESMTP id 067Bimif058681;
 Tue, 7 Jul 2020 19:44:48 +0800 (GMT-8)
 (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
 by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
 with ESMTP id 2020070719450240-4209657 ;
 Tue, 7 Jul 2020 19:45:02 +0800 
From: Yi Wang <wang.yi59@zte.com.cn>
To: timur@kernel.org
Subject: [PATCH] ASoC: fsl: mpc8610_hpcd: Add missing of_node_put()
Date: Tue, 7 Jul 2020 19:47:47 +0800
Message-Id: <1594122467-11615-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release
 8.5.3FP6|November 21, 2013) at 2020-07-07 19:45:02,
 Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2020-07-07 19:44:51, Serialize complete at 2020-07-07 19:44:51
X-MAIL: mse-fl1.zte.com.cn 067Bimif058681
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
Cc: wang.yi59@zte.com.cn, alsa-devel@alsa-project.org, wang.liang82@zte.com.cn,
 Xiubo.Lee@gmail.com, linuxppc-dev@lists.ozlabs.org, tiwai@suse.com,
 lgirdwood@gmail.com, perex@perex.cz, nicoleotsuka@gmail.com,
 broonie@kernel.org, Liao Pingfang <liao.pingfang@zte.com.cn>,
 xue.zhihong@zte.com.cn, festevam@gmail.com, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Liao Pingfang <liao.pingfang@zte.com.cn>

After finishing using device node got from of_find_compatible_node(),
of_node_put() needs to be called.

Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
---
 sound/soc/fsl/mpc8610_hpcd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index f7bd900..b3090fe 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -426,9 +426,11 @@ static int __init mpc8610_hpcd_init(void)
 	guts_np = of_find_compatible_node(NULL, NULL, "fsl,mpc8610-guts");
 	if (of_address_to_resource(guts_np, 0, &res)) {
 		pr_err("mpc8610-hpcd: missing/invalid global utilities node\n");
+		of_node_put(guts_np);
 		return -EINVAL;
 	}
 	guts_phys = res.start;
+	of_node_put(guts_np);
 
 	return platform_driver_register(&mpc8610_hpcd_driver);
 }
-- 
2.9.5

