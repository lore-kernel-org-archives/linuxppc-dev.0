Return-Path: <SRS0=1eNT=OV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A39DC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 14:20:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47F4020849
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 14:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F4020849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43FJqn2Yz1zDqW6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 01:20:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=92.121.34.13; helo=inva020.nxp.com;
 envelope-from=diana.craciun@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43FJZk5W1bzDqRt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2018 01:09:02 +1100 (AEDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B215C1A025B;
 Wed, 12 Dec 2018 15:03:31 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com
 [134.27.226.22])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A69321A0187;
 Wed, 12 Dec 2018 15:03:31 +0100 (CET)
Received: from fsr-ub1664-009.ea.freescale.net
 (fsr-ub1664-009.ea.freescale.net [10.171.71.77])
 by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 6F7CD205E5;
 Wed, 12 Dec 2018 15:03:31 +0100 (CET)
From: Diana Craciun <diana.craciun@nxp.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 10/11] powerpc/fsl: Update Spectre v2 reporting
Date: Wed, 12 Dec 2018 16:03:09 +0200
Message-Id: <1544623390-18710-11-git-send-email-diana.craciun@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544623390-18710-1-git-send-email-diana.craciun@nxp.com>
References: <1544623390-18710-1-git-send-email-diana.craciun@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
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
Cc: Diana Craciun <diana.craciun@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Report branch predictor state flush as a mitigation for
Spectre variant 2.

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
---
 arch/powerpc/kernel/security.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 4393a38..861fab3 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -212,8 +212,11 @@ ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr, c
 
 		if (count_cache_flush_type == COUNT_CACHE_FLUSH_HW)
 			seq_buf_printf(&s, "(hardware accelerated)");
-	} else
+	} else if (btb_flush_enabled) {
+		seq_buf_printf(&s, "Mitigation: Branch predictor state flush");
+	} else {
 		seq_buf_printf(&s, "Vulnerable");
+	}
 
 	seq_buf_printf(&s, "\n");
 
-- 
2.5.5

