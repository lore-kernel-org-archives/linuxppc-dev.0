Return-Path: <SRS0=2k7A=4J=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8552BC35669
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Feb 2020 23:13:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD9CB2073A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Feb 2020 23:13:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD9CB2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48PS1d4ZJDzDqvY
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Feb 2020 10:13:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=canonical.com
 (client-ip=91.189.89.112; helo=youngberry.canonical.com;
 envelope-from=colin.king@canonical.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=canonical.com
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48PRzq6n7PzDqJ3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Feb 2020 10:11:50 +1100 (AEDT)
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <colin.king@canonical.com>)
 id 1j5HSR-0004zi-UK; Fri, 21 Feb 2020 23:11:44 +0000
From: Colin King <colin.king@canonical.com>
To: Roy Pledge <Roy.Pledge@nxp.com>, Li Yang <leoyang.li@nxp.com>,
 Youri Querry <youri.querry_1@nxp.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH][next] soc: fsl: dpio: fix dereference of pointer p before
 null check
Date: Fri, 21 Feb 2020 23:11:43 +0000
Message-Id: <20200221231143.30131-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Colin Ian King <colin.king@canonical.com>

Pointer p is currently being dereferenced before it is null
checked on a memory allocation failure check. Fix this by
checking if p is null before dereferencing it.

Addresses-Coverity: ("Dereference before null check")
Fixes: 3b2abda7d28c ("soc: fsl: dpio: Replace QMAN array mode with ring mode enqueue")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/soc/fsl/dpio/qbman-portal.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/dpio/qbman-portal.c b/drivers/soc/fsl/dpio/qbman-portal.c
index 740ee0d19582..d1f49caa5b13 100644
--- a/drivers/soc/fsl/dpio/qbman-portal.c
+++ b/drivers/soc/fsl/dpio/qbman-portal.c
@@ -249,10 +249,11 @@ struct qbman_swp *qbman_swp_init(const struct qbman_swp_desc *d)
 	u32 mask_size;
 	u32 eqcr_pi;
 
-	spin_lock_init(&p->access_spinlock);
-
 	if (!p)
 		return NULL;
+
+	spin_lock_init(&p->access_spinlock);
+
 	p->desc = d;
 	p->mc.valid_bit = QB_VALID_BIT;
 	p->sdq = 0;
-- 
2.25.0

