Return-Path: <SRS0=wfsy=OA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89380C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 09:47:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B4FF2146F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 09:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B4FF2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 430HmG04mkzF3fZ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 20:47:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=zte.com.cn
 (client-ip=202.103.147.172; helo=mxct.zte.com.cn;
 envelope-from=wen.yang99@zte.com.cn; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=zte.com.cn
X-Greylist: delayed 941 seconds by postgrey-1.36 at bilbo;
 Wed, 21 Nov 2018 18:56:33 AEDT
Received: from mxct.zte.com.cn (out1.zte.com.cn [202.103.147.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 430FJd3WCszF3dw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2018 18:56:32 +1100 (AEDT)
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
 by Forcepoint Email with ESMTPS id 89D153EA44BEDCCA6676;
 Wed, 21 Nov 2018 15:40:39 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
 by mse01.zte.com.cn with ESMTP id wAL7eQIG084734;
 Wed, 21 Nov 2018 15:40:26 +0800 (GMT-8)
 (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
 by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
 with ESMTP id 2018112115404502-12071388 ;
 Wed, 21 Nov 2018 15:40:45 +0800 
From: Wen Yang <wen.yang99@zte.com.cn>
To: qiang.zhao@nxp.com
Subject: [PATCH 2/4] soc/fsl/qe: fix potential NULL pointer dereference in
 ucc_of_parse_tdm
Date: Wed, 21 Nov 2018 15:41:51 +0800
Message-Id: <1542786111-18648-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release
 8.5.3FP6|November 21, 2013) at 2018-11-21 15:40:45,
 Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-11-21 15:40:18, Serialize complete at 2018-11-21 15:40:18
X-MAIL: mse01.zte.com.cn wAL7eQIG084734
X-Mailman-Approved-At: Wed, 21 Nov 2018 20:45:27 +1100
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
Cc: wang.yi59@zte.com.cn, zhong.weidong@zte.com.cn,
 linux-kernel@vger.kernel.org, leoyang.li@nxp.com,
 Julia Lawall <julia.lawall@lip6.fr>, linuxppc-dev@lists.ozlabs.org,
 wen.yang99@zte.com.cn, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch fixes a possible null pointer dereference in
ucc_of_parse_tdm, detected by the semantic patch
deref_null.cocci, with the following warning:

./drivers/soc/fsl/qe/qe_tdm.c:177:21-24: ERROR: pdev is NULL but dereferenced.

The following code has potential null pointer references:
        pdev = of_find_device_by_node(np2);
        if (!pdev) {
                ret = -EINVAL;
                pr_err("%pOFn: failed to lookup pdev\n", np2);
                of_node_put(np2);
                goto err_miss_siram_property;
        }
...
err_miss_siram_property:
        devm_iounmap(&pdev->dev, utdm->si_regs);

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Reviewed-by: Tan Hu <tan.hu@zte.com.cn>
CC: Julia Lawall <julia.lawall@lip6.fr>
---
 drivers/soc/fsl/qe/qe_tdm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/qe_tdm.c b/drivers/soc/fsl/qe/qe_tdm.c
index f78c346..166378b 100644
--- a/drivers/soc/fsl/qe/qe_tdm.c
+++ b/drivers/soc/fsl/qe/qe_tdm.c
@@ -174,7 +174,8 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
 	return ret;
 
 err_miss_siram_property:
-	devm_iounmap(&pdev->dev, utdm->si_regs);
+	if (pdev)
+		devm_iounmap(&pdev->dev, utdm->si_regs);
 	return ret;
 }
 EXPORT_SYMBOL(ucc_of_parse_tdm);
-- 
2.9.5

