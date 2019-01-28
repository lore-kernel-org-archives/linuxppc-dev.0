Return-Path: <SRS0=7Eaw=QE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A543C282C8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 09:16:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0599E20844
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 09:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0599E20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=infinera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43p3sq0dlGzDqJS
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 20:16:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=infinera.com
 (client-ip=31.15.61.139; helo=smtp.transmode.se;
 envelope-from=mathias.thore@infinera.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=infinera.com
X-Greylist: delayed 415 seconds by postgrey-1.36 at bilbo;
 Mon, 28 Jan 2019 20:14:58 AEDT
Received: from smtp.transmode.se (smtp.transmode.se [31.15.61.139])
 by lists.ozlabs.org (Postfix) with ESMTP id 43p3qk1pn0zDqBW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2019 20:14:55 +1100 (AEDT)
Received: from se-math-lx.infinera.com (se-math-lx.infinera.com
 [10.210.72.102])
 by smtp.transmode.se (Postfix) with ESMTP id DFE091186FC6;
 Mon, 28 Jan 2019 10:07:56 +0100 (CET)
Received: from se-math-lx.infinera.com (se-math-lx.infinera.com [127.0.0.1])
 by se-math-lx.infinera.com (8.14.9/8.14.9) with ESMTP id x0S97ueA015898;
 Mon, 28 Jan 2019 10:07:56 +0100
Received: (from math@localhost)
 by se-math-lx.infinera.com (8.14.9/8.14.9/Submit) id x0S97upd015897;
 Mon, 28 Jan 2019 10:07:56 +0100
From: Mathias Thore <mathias.thore@infinera.com>
To: leoyang.li@nxp.com, netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 david.gounaris@infinera.com, joakim.tjernlund@infinera.com
Subject: [PATCH] ucc_geth: Reset BQL queue when stopping device
Date: Mon, 28 Jan 2019 10:07:47 +0100
Message-Id: <20190128090747.15851-1-mathias.thore@infinera.com>
X-Mailer: git-send-email 2.19.2
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
Cc: Mathias Thore <mathias.thore@infinera.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

After a timeout event caused by for example a broadcast storm, when
the MAC and PHY are reset, the BQL TX queue needs to be reset as
well. Otherwise, the device will exhibit severe performance issues
even after the storm has ended.

Co-authored-by: David Gounaris <david.gounaris@infinera.com>
Signed-off-by: Mathias Thore <mathias.thore@infinera.com>
---
 drivers/net/ethernet/freescale/ucc_geth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index c3d539e209ed..eb3e65e8868f 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -1879,6 +1879,8 @@ static void ucc_geth_free_tx(struct ucc_geth_private *ugeth)
 	u16 i, j;
 	u8 __iomem *bd;
 
+	netdev_reset_queue(ugeth->ndev);
+
 	ug_info = ugeth->ug_info;
 	uf_info = &ug_info->uf_info;
 
-- 
2.19.2

